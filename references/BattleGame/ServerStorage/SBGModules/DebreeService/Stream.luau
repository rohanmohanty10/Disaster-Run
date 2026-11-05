--!strict
-- ServerStorage > SBGModules > DebreeService > Stream   (ModuleScript, server only)
--
-- Everything Debree sends to clients, in JJS's wire format:
--   Create  (RemoteEvent)            groups[transparency][materialKey]["r,g,b"] = { staticBuf, movedBuf, flyingBuf }
--   Physics (UnreliableRemoteEvent)  21-byte records of moving pieces, at most Config.RecordsPerFire per fire
--   Settle  (RemoteEvent)            the same 21-byte records for pieces that just came to rest. Reliable,
--                                    so a dropped packet can never leave a piece frozen mid-slide.
--                                    (Our addition; JJS sends these over Physics too.)
--   Prop    (RemoteEvent)            { id, ... } to remove
--   Sound   (UnreliableRemoteEvent)  i16 ID list, or one Instance
--
-- Only players whose client has fired Ready get anything. A player who isn't ready yet
-- receives the whole current state in one snapshot once they are, so nothing is missed
-- or drawn twice.
--
-- All three Create buffers are always present (empty when unused): Roblox drops or
-- renumbers the entries of an array with nil holes when it crosses the network.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Shared = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Debree")
local Config = require(Shared:WaitForChild("Config"))
local Records = require(Shared:WaitForChild("Records"))
local Registry = require(script.Parent:WaitForChild("Registry"))

type Piece = Registry.Piece
type Group = Registry.Group

export type PhysicsEntry = { Id: number, Transform: CFrame, Settled: boolean }
export type CreatePayload = { [string]: { [string]: { [string]: { buffer } } } }

local Stream = {}

local CreateRemote: RemoteEvent
local PropRemote: RemoteEvent
local PhysicsRemote: UnreliableRemoteEvent
local SettleRemote: RemoteEvent?
local SoundRemote: UnreliableRemoteEvent
local AbsorbRemote: RemoteEvent? = nil

local Ready: { [Player]: boolean } = {}
local EMPTY = buffer.create(0)

local function FireReady(Remote: RemoteEvent | UnreliableRemoteEvent, ...: any)
	for Player in Ready do
		if Player.Parent then
			(Remote :: any):FireClient(Player, ...)
		end
	end
end

local function Pack(List: { Piece }): buffer
	if #List == 0 then
		return EMPTY
	end
	local Buffer = buffer.create(#List * Records.PIECE_SIZE)
	for Index, Piece in List do
		Records.WritePiece(Buffer, Index, Piece.Body.CFrame, Piece.Body.Size, Piece.Id)
	end
	return Buffer
end

-- Hooks up the remotes. OnReady(Player) runs once per player, the first time their client
-- says it's ready; it should send them the snapshot.
function Stream.Start(OnReady: (Player) -> ())
	local Folder = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Debree")
	CreateRemote = Folder:WaitForChild("Create") :: RemoteEvent
	PropRemote = Folder:WaitForChild("Prop") :: RemoteEvent
	PhysicsRemote = Folder:WaitForChild("Physics") :: UnreliableRemoteEvent
	SettleRemote = Folder:FindFirstChild("Settle") :: RemoteEvent?
	if not SettleRemote then
		warn("Debree: Remotes.Debree.Settle (RemoteEvent) is missing; settled positions will use the unreliable Physics remote")
	end
	SoundRemote = Folder:WaitForChild("Sound") :: UnreliableRemoteEvent
	local Absorb = Folder:FindFirstChild("Absorb") :: RemoteEvent?
	if not Absorb then
		local Made = Instance.new("RemoteEvent")
		Made.Name = "Absorb"
		Made.Parent = Folder
		Absorb = Made
	end
	AbsorbRemote = Absorb
	
	local ReadyRemote = Folder:WaitForChild("Ready") :: RemoteEvent

	ReadyRemote.OnServerEvent:Connect(function(Player: Player)
		if Ready[Player] then
			return -- only the first Ready counts, so a client can't spam snapshots
		end
		Ready[Player] = true
		OnReady(Player)
	end)
	Players.PlayerRemoving:Connect(function(Player: Player)
		Ready[Player] = nil
	end)
end

function Stream.IsReady(Player: Player): boolean
	return Ready[Player] == true
end

-- True when settled positions go over the reliable Settle remote.
function Stream.HasReliableSettle(): boolean
	return SettleRemote ~= nil
end

-- Packs pieces into JJS's grouped Create table. Static pieces go in staticBuf,
-- debris in movedBuf; flyingBuf is always empty (JJS's client fades flying pieces
-- after 3 s, and Debree pieces stay until the reset).
function Stream.BuildGroups(List: { Piece }): CreatePayload
	type Bucket = { Group: Group, Static: { Piece }, Moved: { Piece } }
	local Buckets: { [string]: Bucket } = {}
	for _, Piece in List do
		local G = Piece.Group
		local Key = G.TransparencyKey .. "\0" .. G.MaterialKey .. "\0" .. G.ColorKey
		local Found = Buckets[Key]
		if not Found then
			Found = { Group = G, Static = {}, Moved = {} }
			Buckets[Key] = Found
		end
		table.insert(if Piece.Kind == "Static" then Found.Static else Found.Moved, Piece)
	end

	local Groups: CreatePayload = {}
	for _, Found in Buckets do
		local G = Found.Group
		local ByMaterial = Groups[G.TransparencyKey]
		if not ByMaterial then
			ByMaterial = {}
			Groups[G.TransparencyKey] = ByMaterial
		end
		local ByColor = ByMaterial[G.MaterialKey]
		if not ByColor then
			ByColor = {}
			ByMaterial[G.MaterialKey] = ByColor
		end
		ByColor[G.ColorKey] = { Pack(Found.Static), Pack(Found.Moved), EMPTY }
	end
	return Groups
end

-- New pieces, to every ready player.
function Stream.SendCreate(List: { Piece }, Silent: boolean?)
	if #List == 0 then
		return
	end
	FireReady(CreateRemote, Stream.BuildGroups(List), if Silent then true else nil)
end

-- The late-join snapshot: every piece, to one player, in chunks.
function Stream.SendCreateTo(Player: Player, List: { Piece }, Silent: boolean?)
	local Chunk = Config.SnapshotChunk
	for First = 1, #List, Chunk do
		local Part = table.move(List, First, math.min(First + Chunk - 1, #List), 1, {})
		CreateRemote:FireClient(Player, Stream.BuildGroups(Part), if Silent then true else nil)
	end
end

-- Pieces to remove, to every ready player.
function Stream.SendProp(Ids: { number })
	local Chunk = Config.PropChunk
	for First = 1, #Ids, Chunk do
		FireReady(PropRemote, table.move(Ids, First, math.min(First + Chunk - 1, #Ids), 1, {}))
	end
end

local function PackPhysics(Entries: { PhysicsEntry }, First: number, Last: number): buffer
	local Buffer = buffer.create((Last - First + 1) * Records.PHYSICS_SIZE)
	for Index = First, Last do
		local Entry = Entries[Index]
		Records.WritePhysics(Buffer, Index - First + 1, Entry.Transform, Entry.Id, Entry.Settled)
	end
	return Buffer
end

-- Piece positions, to every ready player. Moving pieces go over Physics, at most
-- Config.RecordsPerFire per fire; settled pieces go over Settle in one reliable fire.
function Stream.SendPhysics(Entries: { PhysicsEntry })
	local Unreliable: { PhysicsEntry } = {}
	local Settled: { PhysicsEntry } = {}
	for _, Entry in Entries do
		table.insert(if Entry.Settled and SettleRemote then Settled else Unreliable, Entry)
	end
	local Chunk = Config.RecordsPerFire
	for First = 1, #Unreliable, Chunk do
		FireReady(PhysicsRemote, PackPhysics(Unreliable, First, math.min(First + Chunk - 1, #Unreliable)))
	end
	if #Settled > 0 and SettleRemote then
		FireReady(SettleRemote, PackPhysics(Settled, 1, #Settled))
	end
end

-- Debris sounds at these pieces.
function Stream.SendSound(Ids: { number })
	if #Ids > 0 then
		FireReady(SoundRemote, Records.WriteIds(Ids))
	end
end

-- One debris sound at a map part (used for parts launched whole).
function Stream.SendSoundAt(Target: BasePart)
	FireReady(SoundRemote, Target)
end

export type AbsorbBox = { CFrame: CFrame, Size: Vector3, Group: Group }
export type AbsorbBatch = {
	Removed: { number }, -- pieces removed with no animation
	Created: { Piece }, -- boxes left standing around the hole
	Taken: { number }, -- pieces clients are already drawing, animated by ID
	Boxes: { AbsorbBox }, -- freshly cut cells, animated from the pool
	Parts: { BasePart }, -- special prop parts (trees), animated as copies
	Target: Attachment?,
	Style: string?, -- how pieces move on clients (DebreeController's ABSORB_STYLES)
	TargetId: string?, -- a target clients drive themselves, by name (DebreeController.SetTarget)
	Center: Vector3,
}

-- Absorb boxes grouped by look like Create's groups, one buffer of piece records per look.
-- Their IDs are 0: the server never registered them, clients only animate them.
local function BuildBoxGroups(Boxes: { AbsorbBox }): CreatePayload
	local Lists: { [string]: { Group: Group, Boxes: { AbsorbBox } } } = {}
	for _, Box in Boxes do
		local G = Box.Group
		local Key = G.TransparencyKey .. "\0" .. G.MaterialKey .. "\0" .. G.ColorKey
		local Found = Lists[Key]
		if not Found then
			Found = { Group = G, Boxes = {} }
			Lists[Key] = Found
		end
		table.insert(Found.Boxes, Box)
	end
	local Groups: CreatePayload = {}
	for _, Found in Lists do
		local G = Found.Group
		local Buffer = buffer.create(#Found.Boxes * Records.PIECE_SIZE)
		for Index, Box in Found.Boxes do
			Records.WritePiece(Buffer, Index, Box.CFrame, Box.Size, 0)
		end
		local ByMaterial = Groups[G.TransparencyKey] or {}
		Groups[G.TransparencyKey] = ByMaterial
		local ByColor = ByMaterial[G.MaterialKey] or {}
		ByMaterial[G.MaterialKey] = ByColor
		ByColor[G.ColorKey] = { Buffer }
	end
	return Groups
end

-- One absorb in ONE fire, so the hole's rubble going, the boxes left around the hole and the
-- pieces flying into the target all reach a client in the same frame.
function Stream.SendAbsorb(Batch: AbsorbBatch)
	if not AbsorbRemote then
		return
	end
	-- Parts by string key: a part that isn't streamed in on a client arrives as nil, and an
	-- array with nil holes gets truncated or renumbered on the way; a dictionary just drops it.
	local Parts: { [string]: BasePart } = {}
	for Index, Part in Batch.Parts do
		Parts[tostring(Index)] = Part
	end
	FireReady(AbsorbRemote :: RemoteEvent, {
		Removed = Batch.Removed,
		Create = if #Batch.Created > 0 then Stream.BuildGroups(Batch.Created) else nil,
		Taken = Records.WriteIds(Batch.Taken),
		Boxes = BuildBoxGroups(Batch.Boxes),
		Parts = Parts,
		Target = Batch.Target,
		Center = Batch.Center,
		Style = Batch.Style,
		TargetId = Batch.TargetId,
	})
end

return Stream


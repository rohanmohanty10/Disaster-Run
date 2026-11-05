--!strict
-- Physics ragdolls (SorceryGame reference approach): ball sockets and limb colliders are built
-- once per character and switched on/off, instead of rebuilding joints on every hit.
-- Works for R6 and R15: each socket sits exactly where its Motor6D joint is.
--
-- Players own their character's physics, so the server switches joints and tells the
-- player's client to enter the Physics humanoid state (CombatController does that).

local PhysicsService = game:GetService("PhysicsService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local MoveGrace = require(ReplicatedStorage.Shared.Util.MoveGrace)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local StatusEffectService = require(script.Parent.StatusEffectService)

local COLLIDER_GROUP = "RagdollCollider"
local BODY_GROUP = "RagdolledBody"

type Rig = {
	Character: Model,
	Humanoid: Humanoid,
	Root: BasePart,
	Motors: { Motor6D },
	Sockets: { BallSocketConstraint },
	Colliders: { BasePart },
	OriginalGroups: { [BasePart]: string },
	Ragdolled: boolean,
	Timer: thread?,
	EffectHandle: any,
}

local RagdollService = {}

local rigs: { [Model]: Rig } = {}

local function setupCollisionGroups()
	for _, group in { COLLIDER_GROUP, BODY_GROUP } do
		if not PhysicsService:IsCollisionGroupRegistered(group) then
			PhysicsService:RegisterCollisionGroup(group)
		end
	end
	-- A ragdoll's own pieces never push each other apart; they still hit the world and other players.
	PhysicsService:CollisionGroupSetCollidable(COLLIDER_GROUP, COLLIDER_GROUP, false)
	PhysicsService:CollisionGroupSetCollidable(COLLIDER_GROUP, BODY_GROUP, false)
	PhysicsService:CollisionGroupSetCollidable(BODY_GROUP, BODY_GROUP, false)
end

local function makeCollider(limb: BasePart, folder: Folder): BasePart
	local collider = Instance.new("Part")
	collider.Name = limb.Name .. "Collider"
	collider.Size = limb.Size / 1.25
	collider.CFrame = limb.CFrame
	collider.Transparency = 1
	collider.CanCollide = false
	collider.CanQuery = false
	collider.CanTouch = false
	collider.Massless = true
	collider.CollisionGroup = COLLIDER_GROUP
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = collider
	weld.Part1 = limb
	weld.Parent = collider
	collider.Parent = folder
	return collider
end

local function build(character: Model): Rig?
	local existing = rigs[character]
	if existing then
		return existing
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = Characters.GetRoot(character)
	if not humanoid or not root then
		return nil
	end
	humanoid.BreakJointsOnDeath = false
	humanoid.RequiresNeck = false

	local folder = Instance.new("Folder")
	folder.Name = "RagdollComponents"

	local rig: Rig = {
		Character = character,
		Humanoid = humanoid,
		Root = root,
		Motors = {},
		Sockets = {},
		Colliders = {},
		OriginalGroups = {},
		Ragdolled = false,
		Timer = nil,
		EffectHandle = nil,
	}

	local collided: { [BasePart]: boolean } = {}
	for _, motor in character:GetDescendants() do
		if not motor:IsA("Motor6D") then
			continue
		end
		local part0, part1 = motor.Part0, motor.Part1
		if not part0 or not part1 or part0 == root then
			continue -- keep the root joint so the HumanoidRootPart follows the body
		end
		local a0 = Instance.new("Attachment")
		a0.Name = "RagdollAttachment"
		a0.CFrame = motor.C0
		a0.Parent = part0
		local a1 = Instance.new("Attachment")
		a1.Name = "RagdollAttachment"
		a1.CFrame = motor.C1
		a1.Parent = part1

		local socket = Instance.new("BallSocketConstraint")
		socket.Name = motor.Name
		socket.Attachment0 = a0
		socket.Attachment1 = a1
		socket.LimitsEnabled = true
		socket.TwistLimitsEnabled = true
		socket.Radius = 0.15
		socket.MaxFrictionTorque = 1
		socket.Restitution = 0
		socket.UpperAngle = 90
		socket.TwistLowerAngle = -45
		socket.TwistUpperAngle = 45
		if string.find(motor.Name, "Neck") then
			socket.UpperAngle = 45
			socket.TwistLowerAngle = -70
			socket.TwistUpperAngle = 70
		end
		socket.Enabled = false
		socket.Parent = folder

		table.insert(rig.Motors, motor)
		table.insert(rig.Sockets, socket)
		for _, limb in { part0, part1 } do
			if not collided[limb] then
				collided[limb] = true
				table.insert(rig.Colliders, makeCollider(limb, folder))
			end
		end
	end

	folder.Parent = character
	rigs[character] = rig

	character.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			rigs[character] = nil
		end
	end)
	humanoid.Died:Connect(function()
		-- Bodies fall over on death and stay that way.
		RagdollService.Ragdoll(character, nil, true)
	end)
	return rig
end

local function setBodyGroup(rig: Rig, on: boolean)
	for _, part in rig.Character:GetDescendants() do
		if part:IsA("BasePart") and part.Parent ~= rig.Character:FindFirstChild("RagdollComponents") then
			if on then
				if rig.OriginalGroups[part] == nil then
					rig.OriginalGroups[part] = part.CollisionGroup
				end
				part.CollisionGroup = BODY_GROUP
			else
				local original = rig.OriginalGroups[part]
				if original then
					part.CollisionGroup = original
				end
			end
		end
	end
	if not on then
		table.clear(rig.OriginalGroups)
	end
end

local function standUpright(rig: Rig)
	local root = rig.Root
	local look = root.CFrame.LookVector * Vector3.new(1, 0, 1)
	if look.Magnitude < 0.01 then
		look = Vector3.new(0, 0, -1)
	end
	local ray = workspace:Raycast(root.Position, Vector3.new(0, -6, 0))
	local height = if ray then ray.Position.Y + 3 else root.Position.Y
	rig.Character:PivotTo(CFrame.lookAt(Vector3.new(root.Position.X, height, root.Position.Z), Vector3.new(root.Position.X, height, root.Position.Z) + look.Unit))
end

local function setPhysics(rig: Rig, on: boolean)
	for _, motor in rig.Motors do
		motor.Enabled = not on
	end
	for _, socket in rig.Sockets do
		socket.Enabled = on
	end
	for _, collider in rig.Colliders do
		collider.CanCollide = on
	end
	setBodyGroup(rig, on)

	local player = Players:GetPlayerFromCharacter(rig.Character)
	if player then
		Remotes.Event("Ragdoll"):FireClient(player, on)
	else
		if rig.Root:CanSetNetworkOwnership() then
			rig.Root:SetNetworkOwner(nil)
		end
		rig.Humanoid.PlatformStand = on
		if on then
			rig.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		elseif rig.Humanoid.Health > 0 then
			standUpright(rig)
			rig.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end
end

--[[
	Ragdolls a character for `duration` seconds (capped by CombatConfig.MaxRagdollTime).
	Ragdolling an already-ragdolled character extends it to whichever ends later.
	duration = nil keeps it ragdolled until Unragdoll(). `ignoreDeath` lets dead bodies ragdoll.
]]
function RagdollService.Ragdoll(character: Model, duration: number?, ignoreDeath: boolean?)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or (humanoid.Health <= 0 and not ignoreDeath) then
		return
	end
	local rig = build(character)
	if not rig then
		return
	end
	-- Ragdoll flings and the get-up aren't the player's own movement.
	MoveGrace.Grant(character, math.min(duration or CombatConfig.MaxRagdollTime, CombatConfig.MaxRagdollTime) + 1.5)
	if rig.Timer and coroutine.status(rig.Timer) == "suspended" then
		task.cancel(rig.Timer)
	end
	rig.Timer = nil
	if not rig.Ragdolled then
		rig.Ragdolled = true
		if humanoid.Health > 0 then
			rig.EffectHandle = StatusEffectService.Apply(character, "Ragdolled", nil, { Force = true })
		end
		setPhysics(rig, true)
	end
	if duration then
		rig.Timer = task.delay(math.min(duration, CombatConfig.MaxRagdollTime), function()
			rig.Timer = nil
			RagdollService.Unragdoll(character)
		end)
	end
end

function RagdollService.Unragdoll(character: Model)
	local rig = rigs[character]
	if not rig or not rig.Ragdolled then
		return
	end
	if rig.Humanoid.Health <= 0 then
		return -- dead bodies stay down
	end
	if rig.Timer and coroutine.status(rig.Timer) == "suspended" then
		task.cancel(rig.Timer)
	end
	rig.Timer = nil
	rig.Ragdolled = false
	setPhysics(rig, false)
	if rig.EffectHandle then
		rig.EffectHandle:Remove()
		rig.EffectHandle = nil
	end
	-- A moment to stand up before the next stun can land.
	StatusEffectService.Apply(character, "StunImmunity", CombatConfig.GetUpStunImmunity, { Force = true })
end

function RagdollService.IsRagdolled(character: Model): boolean
	local rig = rigs[character]
	return rig ~= nil and rig.Ragdolled
end

-- Builds the joints ahead of time so the first ragdoll has no hitch.
function RagdollService.Prepare(character: Model)
	build(character)
end

function RagdollService.Init()
	setupCollisionGroups()
end

function RagdollService.Start()
	local function onCharacter(character: Model)
		character:WaitForChild("HumanoidRootPart", 10)
		local humanoid = character:WaitForChild("Humanoid", 10)
		if humanoid then
			RagdollService.Prepare(character)
		end
	end
	local function onPlayer(player: Player)
		player.CharacterAppearanceLoaded:Connect(onCharacter)
		if player.Character then
			task.spawn(onCharacter, player.Character)
		end
	end
	for _, player in Players:GetPlayers() do
		onPlayer(player)
	end
	Players.PlayerAdded:Connect(onPlayer)
end

return RagdollService

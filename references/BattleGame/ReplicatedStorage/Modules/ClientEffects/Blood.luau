local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

--local EffectUtility = require( ReplicatedStorage.Modules.Player.Replication.EffectUtility )
local VFXHandler = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler) -- only used by ExplodeHead now
local UtilityModule = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)



--local Blood = require( ReplicatedStorage.Modules.Player.Replication.Global.Blood )
local Blood = require( ReplicatedStorage.Modules.Blood )

--local CameraShake = require( ReplicatedStorage.Modules.Player.Replication.Global.CameraShake )

local VFX = {}

function VFX.Explode(RootPart : BasePart)
	--if not LocalPlayer:GetAttribute("Blood") then return end

	--EffectUtility.EmitEffects(script.Explode, RootPart)
	--VFXHandler.EmitEffects(script.Explode)
	local fadeInfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)

	for _, Item in ipairs(RootPart.Parent:GetDescendants()) do
		if Item:IsA("BasePart") then
			local random = math.random(1, 4)

			--Blood.BloodRaysWithoutPreset(RootPart, {
			--	Face = random == 1 and Enum.NormalId.Top or random == 2 and Enum.NormalId.Left or random == 3 and Enum.NormalId.Right or random == 4 and Enum.NormalId.Bottom, 
			--	SpreadAngle = Vector2.new(90, 90), 
			--	Amount = Vector2.new(4, 6), 
			--	PoolSize = 1.5,
			--	PoolSizeRandom = Vector2.new(-0.6, 0.6),
			--})

			--EffectUtility.EmitEffects(ReplicatedStorage.Effects.Blood.Splash, Item)
			--VFXHandler.EmitEffects(ReplicatedStorage.Assets.Effects.Blood.Splash, Item)
			--VFXHandler.EmitEffects()

			--Item.Transparency = 1
			TweenService:Create(Item, fadeInfo, { Transparency = 1 }):Play()

		elseif Item:IsA("Decal") then
			--Item.Transparency = 1
			TweenService:Create(Item, fadeInfo, { Transparency = 1 }):Play()
		end
	end

	task.wait(.1)

	for Index = 1, 10 do
		local head = RootPart.Parent:FindFirstChild("Head")
		local Torso = RootPart.Parent:FindFirstChild("Torso")
		if (head ~= nil and head.Parent ~= nil) then
			Blood.BloodRaysWithoutPreset(Torso:FindFirstChild("BodyFrontAttachment"), {
				Face = Enum.NormalId.Top,
				SpreadAngle = Vector2.new(360, 360), 
				Amount = Vector2.new(3, 4), 
			})

			--task.wait(0.)
		else
			break
		end
	end

	--CameraShake(7.5, 100, 0.03, 0.65)
end

function VFX.ExplodeHead(RootPart : BasePart)
	local character = RootPart.Parent
	local head = character:FindFirstChild("Head")
	if not head then return end

	--VFXHandler.EmitEffects(script.Explode, head)
	VFXHandler.EmitEffects(ReplicatedStorage.Assets.Effects.Blood.HeadSplash, head)
	head.Transparency = 1

	for _, item in ipairs(head:GetChildren()) do
		if item:IsA("Decal") then
			item.Transparency = 1
		end
	end

	for Index = 1, 45 do
		if (head ~= nil and head.Parent ~= nil) then
			Blood.BloodRaysWithoutPreset(character.Torso.NeckAttachment, {
				Face = Enum.NormalId.Top,
				SpreadAngle = Vector2.new(180, 180), 
				Amount = Vector2.new(3, 4), 
			})

			task.wait(0.15)
		else
			break
		end
	end

end


----------------------------------------------------------------------------------
-- ExplodeGore: Justice Served style body explosion
-- Uses the JJS assets in ReplicatedStorage.Assets.Effects.Blood (Chunk, BloodSpread, Splash)
-- and the sounds you pass in (ReplicatedStorage.Assets.Sounds.Gore)
----------------------------------------------------------------------------------

local BloodEffects = ReplicatedStorage.Assets.Effects.Blood
local GoreRandom = Random.new()

local BLOODSPREAD_COUNT = 20 -- JJS emits 20 BloodSpread particles (used if the emitter has no EmitCount attribute)
local CHUNK_BLOOD_TEXTURE = "rbxassetid://7029770407"
local CHUNK_TRAIL_COLOR = Color3.fromRGB(85, 0, 0)
local CHUNK_NO_BLOOD_COLOR = Color3.fromRGB(255, 85, 255) -- JJS turns chunks pink when gore is off

-- Launch speed. These are JJS's Justice Served numbers: chunks go sideways at up to
-- CHUNK_OUT_SPEED on each axis and up between CHUNK_UP_SPEED.X and .Y.
-- Lower them to keep chunks closer to the body. Every type below can only go SLOWER
-- than this (its Speed is 1 or less), never faster.
local CHUNK_OUT_SPEED = 90
local CHUNK_UP_SPEED = Vector2.new(20, 50)
local CHUNK_MAX_DISTANCE = 60 -- safety stop for anything that slides/rolls further than JJS chunks can fly
local CHUNK_PHYSICS = PhysicalProperties.new(1.5, 1.5, 0.1, 100, 100) -- grippy, barely bouncy, so nothing skids away

local BONE_COUNT = 3 -- bones thrown out every explosion (on top of the normal chunks)

-- Chunk types. Each normal chunk rolls one of these by Weight. Each type has its own
-- colours so you can tell them apart in the burst.
--   Class    : kind of part (wedges look torn / jagged)
--   Min/Max  : random size per axis        Uniform : same size on every axis (balls)
--   Colors   : picks one, then darkens it a bit at random
--   Shine    : reflectance range (wet look)
--   Speed    : sideways speed multiplier (1 = JJS)      Lift : upward speed multiplier
--   MaxDistance : overrides CHUNK_MAX_DISTANCE for this type
--   Bleeds   : drips blood + leaves smears where it lands
local CHUNK_TYPES = {
	{ Name = "Meat", Weight = 30, Class = "Part", Shape = Enum.PartType.Block,
		Min = Vector3.new(0.5, 0.4, 0.5), Max = Vector3.new(1.0, 0.8, 1.0),
		Colors = { Color3.fromRGB(121, 16, 16), Color3.fromRGB(140, 12, 12) }, Shine = Vector2.new(0.03, 0.1),
		Speed = 1, Lift = 1, Bleeds = true },

	{ Name = "Slab", Weight = 10, Class = "Part", Shape = Enum.PartType.Block,
		Min = Vector3.new(1.1, 0.6, 0.9), Max = Vector3.new(1.7, 1.0, 1.4),
		Colors = { Color3.fromRGB(85, 0, 0), Color3.fromRGB(100, 8, 8) }, Shine = Vector2.new(0.02, 0.06),
		Speed = 0.75, Lift = 0.85, Bleeds = true },

	{ Name = "Glob", Weight = 15, Class = "Part", Shape = Enum.PartType.Ball,
		Min = Vector3.one * 0.5, Max = Vector3.one * 0.9, Uniform = true,
		Colors = { Color3.fromRGB(160, 10, 10), Color3.fromRGB(175, 25, 25) }, Shine = Vector2.new(0.2, 0.3),
		Speed = 0.9, Lift = 1, Bleeds = true },

	{ Name = "Torn", Weight = 18, Class = "WedgePart",
		Min = Vector3.new(0.4, 0.4, 0.6), Max = Vector3.new(0.8, 1.0, 1.4),
		Colors = { Color3.fromRGB(170, 55, 55), Color3.fromRGB(185, 70, 65) }, Shine = Vector2.new(0.05, 0.12),
		Speed = 1, Lift = 1, Bleeds = true },

	{ Name = "Scrap", Weight = 12, Class = "CornerWedgePart",
		Min = Vector3.new(0.45, 0.4, 0.45), Max = Vector3.new(0.85, 0.7, 0.85),
		Colors = { Color3.fromRGB(200, 120, 105), Color3.fromRGB(190, 100, 90) }, Shine = Vector2.new(0.03, 0.08),
		Speed = 1, Lift = 1, Bleeds = true },

	{ Name = "Fleck", Weight = 15, Class = "Part", Shape = Enum.PartType.Block,
		Min = Vector3.one * 0.18, Max = Vector3.one * 0.32,
		Colors = { Color3.fromRGB(70, 0, 0), Color3.fromRGB(110, 5, 5) }, Shine = Vector2.new(0, 0.05),
		Speed = 1, Lift = 1, Bleeds = false },
}

-- Bones are thrown separately (BONE_COUNT every time) so you always see some,
-- and they stay close: less than half the sideways speed and a short leash.
local BONE_TYPE = { Name = "Bone", Class = "Part", Shape = Enum.PartType.Cylinder,
	Min = Vector3.new(1.0, 0.3, 0.3), Max = Vector3.new(1.6, 0.4, 0.4),
	Colors = { Color3.fromRGB(232, 224, 205), Color3.fromRGB(215, 205, 182) }, Shine = Vector2.new(0.05, 0.1),
	Speed = 0.35, Lift = 0.7, MaxDistance = 12, Bleeds = false, Bone = true }

local CHUNK_TOTAL_WEIGHT = 0
for _, Type in CHUNK_TYPES do
	CHUNK_TOTAL_WEIGHT += Type.Weight
end

local function RollChunkType()
	local Roll = GoreRandom:NextNumber(0, CHUNK_TOTAL_WEIGHT)
	for _, Type in CHUNK_TYPES do
		Roll -= Type.Weight
		if Roll <= 0 then
			return Type
		end
	end
	return CHUNK_TYPES[1]
end

local function RollSize(Type): Vector3
	if Type.Uniform then
		return Vector3.one * GoreRandom:NextNumber(Type.Min.X, Type.Max.X)
	end
	return Vector3.new(
		GoreRandom:NextNumber(Type.Min.X, Type.Max.X),
		GoreRandom:NextNumber(Type.Min.Y, Type.Max.Y),
		GoreRandom:NextNumber(Type.Min.Z, Type.Max.Z)
	)
end

local function ScaleSequence(Sequence: NumberSequence, Scale: number): NumberSequence
	local Points = {}
	for _, Point in Sequence.Keypoints do
		table.insert(Points, NumberSequenceKeypoint.new(Point.Time, Point.Value * Scale, Point.Envelope * Scale))
	end
	return NumberSequence.new(Points)
end

-- Copies the particles of an effect (a Folder of ParticleEmitters, or one ParticleEmitter)
-- onto an attachment at Position and fires them with UtilityModule.Emit.
-- The attachment sits in workspace.Terrain so the effect isn't cut off when the body is removed.
local function EmitAt(Effect: Instance, Position: Vector3, DefaultCount: number?)
	local Holder = Instance.new("Attachment")
	Holder.Parent = workspace.Terrain
	Holder.WorldPosition = Position

	local Items = Effect:IsA("ParticleEmitter") and { Effect } or Effect:GetChildren()
	local Longest = 0

	for _, Item in Items do
		if Item:IsA("ParticleEmitter") then
			local Clone = Item:Clone()
			Clone.Enabled = false

			if DefaultCount and Clone:GetAttribute("EmitCount") == nil then
				Clone:SetAttribute("EmitCount", DefaultCount)
			end

			Clone.Parent = Holder

			local Delay = tonumber(Clone:GetAttribute("EmitDelay")) or 0
			local Duration = tonumber(Clone:GetAttribute("EmitDuration")) or 0
			Longest = math.max(Longest, Delay + Duration + Clone.Lifetime.Max)
		end
	end

	UtilityModule.Emit(Holder)
	task.delay(Longest + 0.5, Holder.Destroy, Holder)
end

-- Gives a part the drip emitter + trail. Uses the ones inside the JJS Chunk
-- (Assets.Effects.Blood.Chunk) when it exists, otherwise builds matching ones.
local function AddChunkEffects(Chunk: BasePart): (ParticleEmitter?, Trail?)
	local Template = BloodEffects:FindFirstChild("Chunk")

	if Template then
		-- clone the whole template so the Trail keeps its links to its attachments,
		-- then move the effects onto our part
		local Source = Template:Clone()
		for _, Child in Source:GetChildren() do
			Child.Parent = Chunk
		end
		Source:Destroy()

		return Chunk:FindFirstChildWhichIsA("ParticleEmitter"), Chunk:FindFirstChildWhichIsA("Trail")
	end

	local Front = Instance.new("Attachment")
	Front.Position = Vector3.new(0, 0, 0.25)
	Front.Parent = Chunk

	local Back = Instance.new("Attachment")
	Back.Position = Vector3.new(0, 0, -0.25)
	Back.Parent = Chunk

	local Trail = Instance.new("Trail")
	Trail.Attachment0 = Back
	Trail.Attachment1 = Front
	Trail.Lifetime = 0.1
	Trail.Color = ColorSequence.new(CHUNK_TRAIL_COLOR)
	Trail.Transparency = NumberSequence.new(0, 1)
	Trail.Parent = Chunk

	local Drip = Instance.new("ParticleEmitter")
	Drip.Texture = CHUNK_BLOOD_TEXTURE
	Drip.Color = ColorSequence.new(Color3.fromRGB(117, 0, 0))
	Drip.Acceleration = Vector3.new(0, -40, 0)
	Drip.EmissionDirection = Enum.NormalId.Top
	Drip.Rate = 50
	Drip.Speed = NumberRange.new(5, 20)
	Drip.Lifetime = NumberRange.new(0.6, 0.9)
	Drip.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4),
		NumberSequenceKeypoint.new(0.3, 0.2),
		NumberSequenceKeypoint.new(1, 0),
	})
	Drip.Parent = Chunk

	return Drip, Trail
end

-- Builds one chunk: a random type (or ForcedType, e.g. BONE_TYPE), with its shape,
-- size, colour and blood amount
local function MakeGoreChunk(ShowBlood: boolean, ForcedType)
	local Type = ForcedType or RollChunkType()
	local Size = RollSize(Type)
	local Bulk = (Size.X + Size.Y + Size.Z) / 3 -- ~0.2 for flecks, ~1.3 for slabs

	local Chunk = Instance.new(Type.Class)
	Chunk.Name = "GoreChunk"
	if Type.Shape and Chunk:IsA("Part") then
		Chunk.Shape = Type.Shape
	end
	Chunk.Size = Size
	Chunk.Material = Enum.Material.SmoothPlastic
	Chunk.TopSurface = Enum.SurfaceType.Smooth
	Chunk.BottomSurface = Enum.SurfaceType.Smooth

	if not ShowBlood then
		Chunk.Color = CHUNK_NO_BLOOD_COLOR
	else
		local Base = Type.Colors[GoreRandom:NextInteger(1, #Type.Colors)]
		Chunk.Color = Base:Lerp(Color3.new(0, 0, 0), GoreRandom:NextNumber(0, 0.15))
		Chunk.Reflectance = GoreRandom:NextNumber(Type.Shine.X, Type.Shine.Y) -- wet look
	end

	local Drip, Trail = AddChunkEffects(Chunk)

	-- trail width follows the chunk size; bones get a thin trail
	if Trail then
		Trail.WidthScale = NumberSequence.new(math.clamp(Bulk, 0.25, 1.4))
		if not ShowBlood then
			Trail.Color = ColorSequence.new(CHUNK_NO_BLOOD_COLOR)
		end
	end

	-- bigger chunks bleed more, flecks and bones don't drip at all
	local Bleeds = ShowBlood and Type.Bleeds
	if Drip then
		if Bleeds then
			Drip.Rate = 50 * math.clamp(Bulk, 0.4, 1.5)
			Drip.Size = ScaleSequence(Drip.Size, math.clamp(Bulk, 0.5, 1.4))
			Drip.Enabled = true
		else
			Drip.Enabled = false
		end
	end

	return Chunk, Drip, Trail, Bulk, Bleeds, Type
end

-- Drops a small blood pool under a chunk (the smear it leaves where it lands)
local function SmearUnder(Chunk: BasePart, Bulk: number)
	if Chunk.Parent == nil then
		return
	end

	local Position = Chunk.Position
	local Aim = Instance.new("Attachment")
	Aim.Parent = workspace.Terrain
	Aim.WorldCFrame = CFrame.lookAt(Position, Position - Vector3.yAxis, Vector3.zAxis)

	Blood.BloodRaysWithoutPreset(Aim, {
		Face = Enum.NormalId.Front, -- straight down
		Spread = Vector2.new(10, 10),
		Amount = Vector2.new(1, 1),
		Power = 8,
		PoolSize = 0.4 + Bulk * 0.5,
		PoolSizeRandom = Vector2.new(-0.15, 0.15),
		PoolDuration = 5,
	})

	Aim:Destroy() -- the ray already copied its start position
end

-- Throws one chunk (random type, or ForcedType). Velocity is the JJS launch; each
-- type can only slow it down (Speed / Lift are 1 or less). Each one bleeds, smears
-- the ground, then shrinks away.
local function ThrowGoreChunk(Origin: Vector3, Velocity: Vector3, ShowBlood: boolean, ForcedType)
	local Chunk, Drip, Trail, Bulk, Bleeds, Type = MakeGoreChunk(ShowBlood, ForcedType)
	local MaxDistance = Type.MaxDistance or CHUNK_MAX_DISTANCE

	-- bigger pieces of the same type go a little slower (never faster than JJS)
	local SizeScale = math.clamp(1 - (Bulk - 0.5) * 0.3, 0.8, 1)
	local Sideways = Type.Speed * SizeScale
	local Launch = Vector3.new(Velocity.X * Sideways, Velocity.Y * Type.Lift, Velocity.Z * Sideways)

	local SpinScale = math.clamp(1.3 - Bulk * 0.5, 0.5, 1.2)

	-- start somewhere inside the torso area instead of all from one exact point
	local Start = Origin + Vector3.new(
		GoreRandom:NextNumber(-0.8, 0.8),
		GoreRandom:NextNumber(-0.8, 1.2),
		GoreRandom:NextNumber(-0.5, 0.5)
	)

	Chunk.Anchored = false
	Chunk.CanCollide = false
	Chunk.CanTouch = false
	Chunk.CanQuery = false
	Chunk.CFrame = CFrame.new(Start) * CFrame.Angles(
		GoreRandom:NextNumber(0, math.pi * 2),
		GoreRandom:NextNumber(0, math.pi * 2),
		GoreRandom:NextNumber(0, math.pi * 2)
	)
	Chunk.CustomPhysicalProperties = CHUNK_PHYSICS
	pcall(function()
		Chunk.CollisionGroup = "NonPColDebri" -- bounces on the map, not on players
	end)
	Chunk.Parent = workspace.World.Visuals

	Chunk.AssemblyLinearVelocity = Launch
	Chunk.AssemblyAngularVelocity = Vector3.new(
		GoreRandom:NextNumber(-30, 30),
		GoreRandom:NextNumber(-30, 30),
		GoreRandom:NextNumber(-30, 30)
	) * SpinScale

	-- collide a moment later so it clears the body first, then bounces around
	task.delay(0.1, function()
		if Chunk.Parent then
			Chunk.CanCollide = true
		end
	end)

	-- after landing, stop it rolling, and never let it slide/roll further than
	-- MaxDistance from where the body was (12 for bones, 60 for everything else)
	task.spawn(function()
		local Elapsed = 0

		while Chunk.Parent and Elapsed < 3 do
			local Offset = Chunk.Position - Origin
			local Flat = Vector3.new(Offset.X, 0, Offset.Z)
			local Current = Chunk.AssemblyLinearVelocity
			local FlatVelocity = Vector3.new(Current.X, 0, Current.Z)

			if Flat.Magnitude > MaxDistance and FlatVelocity:Dot(Flat) > 0 then
				Chunk.AssemblyLinearVelocity = Vector3.new(0, math.min(Current.Y, 0), 0)
				Chunk.AssemblyAngularVelocity = Vector3.zero
			elseif Elapsed >= 0.5 then
				Chunk.AssemblyAngularVelocity *= 0.6
			end

			Elapsed += task.wait(0.1)
		end
	end)

	-- blood smears where the bleeding chunks land / bounce
	if Bleeds then
		task.delay(GoreRandom:NextNumber(0.35, 0.7), SmearUnder, Chunk, Bulk)
		if Bulk > 0.7 then
			task.delay(GoreRandom:NextNumber(1, 1.5), SmearUnder, Chunk, Bulk)
		end
	end

	-- each chunk stops bleeding and shrinks at a slightly different time
	local BleedTime = GoreRandom:NextNumber(1.6, 2.4)
	local ShrinkTime = GoreRandom:NextNumber(0.6, 1.1)

	task.delay(BleedTime, function()
		if Chunk.Parent == nil then
			return
		end
		if Drip then
			Drip.Enabled = false
		end
		if Trail then
			Trail.Enabled = false
		end
		TweenService:Create(Chunk, TweenInfo.new(ShrinkTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = Vector3.zero,
		}):Play()
	end)

	task.delay(BleedTime + ShrinkTime + 0.1, Chunk.Destroy, Chunk)
end

-- Plays the given sounds at a world position (the body is invisible right after, so
-- the sounds live on their own attachment instead of on the character)
local function PlayGoreSounds(Position: Vector3, Sounds: {Sound})
	local Holder = Instance.new("Attachment")
	Holder.Parent = workspace.Terrain
	Holder.WorldPosition = Position

	local Longest = 0
	for _, Sound in Sounds do
		local Clone = Sound:Clone()
		Clone.PlayOnRemove = false -- some copied sounds (e.g. the JJS ones) replay when destroyed
		Clone.Parent = Holder
		Clone:Play()
		Longest = math.max(Longest, Clone.TimeLength / math.max(Clone.PlaybackSpeed, 0.01))
	end

	task.delay(math.max(Longest, 3) + 0.5, Holder.Destroy, Holder)
end

-- Justice Served style finisher explosion.
--   VFX.ExplodeGore(victim.HumanoidRootPart, { Sounds = { SomeSound, OtherSound } })
--
-- Accepts the character or any part of it. Options (all optional):
--   Sounds      : {Sound}  - sounds to play at the explosion
--   Chunks      : number   - how many flesh chunks (default 24)
--   Bones       : number   - how many bones (default BONE_COUNT = 3)
--   ChunkPower  : number   - multiplier on chunk speed (default 1)
--   Direction   : Vector3  - throw the blood + chunks mostly this way. nil = every direction
--   BloodBursts : number   - how many blood ray batches (default 10, ~50 drops total)
function VFX.ExplodeGore(Target: Instance, Options: {[string]: any}?)
	local Settings = Options or {}

	local Character = Target:IsA("Model") and Target or Target:FindFirstAncestorOfClass("Model")
	if Character == nil then
		return
	end

	local RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
	if RootPart == nil then
		return
	end

	local Origin = RootPart.Position
	local ShowBlood = Blood.CanShowBlood()

	local Direction: Vector3? = nil
	if Settings.Direction and Settings.Direction.Magnitude > 0.01 then
		Direction = Settings.Direction.Unit
	end

	-- 1. Explosion sounds
	if Settings.Sounds then
		PlayGoreSounds(Origin, Settings.Sounds)
	end

	-- 2. JJS BloodSpread puff (the red mist) at the head
	local Head = Character:FindFirstChild("Head")
	local BloodSpread = BloodEffects:FindFirstChild("BloodSpread")
	if ShowBlood and BloodSpread then
		EmitAt(BloodSpread, (Head or RootPart).Position, BLOODSPREAD_COUNT)
	end

	-- 3. Your Splash effect on every body part
	local Splash = BloodEffects:FindFirstChild("Splash")
	if ShowBlood and Splash then
		for _, PartName in { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" } do
			local Part = Character:FindFirstChild(PartName)
			if Part then
				EmitAt(Splash, Part.Position)
			end
		end
	end

	-- 4. Hide the whole body (parts, face, clothes on the parts, accessories)
	for _, Item in Character:GetDescendants() do
		if Item:IsA("BasePart") or Item:IsA("Decal") then
			Item.Transparency = 1
		end
	end

	-- 5. Blood rays: ~50 drops thrown everywhere (or mostly along Direction), leaving pools
	local BurstItem: BasePart | Attachment = RootPart

	if Direction then
		-- aim an attachment along Direction so Face = Front shoots that way
		local BurstAttachment = Instance.new("Attachment")
		BurstAttachment.Parent = workspace.Terrain
		BurstAttachment.WorldCFrame = CFrame.lookAt(Origin, Origin + Direction)
		BurstItem = BurstAttachment
		task.delay(1, BurstAttachment.Destroy, BurstAttachment)
	end

	for _ = 1, Settings.BloodBursts or 10 do
		Blood.BloodRaysWithoutPreset(BurstItem, {
			Face = Direction and Enum.NormalId.Front or Enum.NormalId.Top,
			Spread = Direction and Vector2.new(40, 40) or Vector2.new(180, 180),
			Amount = Vector2.new(4, 6),
			Power = GoreRandom:NextNumber(35, 85),
			PoolSize = 1.5,
			PoolSizeRandom = Vector2.new(-0.6, 0.6),
			PoolDuration = 6,
		})
	end

	-- 6. Chunks (skipped if the explosion is far away from this player)
	if LocalPlayer:DistanceFromCharacter(Origin) <= 150 then
		local ChunkPower = Settings.ChunkPower or 1

		-- same launch as JJS Justice Served: random -90..90 sideways on each axis, 20..50 up
		local function RollLaunch(): Vector3
			local Up = GoreRandom:NextNumber(CHUNK_UP_SPEED.X, CHUNK_UP_SPEED.Y)

			if Direction then
				return Direction * GoreRandom:NextNumber(CHUNK_OUT_SPEED * 0.55, CHUNK_OUT_SPEED)
					+ Vector3.new(GoreRandom:NextNumber(-8, 8), Up * 0.6, GoreRandom:NextNumber(-8, 8))
			end

			return Vector3.new(
				GoreRandom:NextNumber(-CHUNK_OUT_SPEED, CHUNK_OUT_SPEED),
				Up,
				GoreRandom:NextNumber(-CHUNK_OUT_SPEED, CHUNK_OUT_SPEED)
			)
		end

		for _ = 1, Settings.Chunks or 24 do
			ThrowGoreChunk(Origin, RollLaunch() * ChunkPower, ShowBlood)
		end

		-- bones: always a few, thrown softly so they land near the body
		for _ = 1, Settings.Bones or BONE_COUNT do
			ThrowGoreChunk(Origin, RollLaunch() * ChunkPower, ShowBlood, BONE_TYPE)
		end
	end
end



return VFX

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local RockHandler = {}

local Rnd = Random.new()
local Assets = script.Assets
local Presets = require(script.Presets)

-- ─────────────────────────────────────────
-- Inlined VisualParams (replaces Utility.VisualParams)
-- ─────────────────────────────────────────
-- Rocks and craters sit on anything in the map you can stand on, plus Debree's rubble (Voxel).
-- This used to be only Destroyable.Map.Floor, but most walkable ground isn't in that folder
-- (Indestructible Map, docks, islands, building floors), so rocks silently didn't appear there.
-- RespectCanCollide: rays pass through decoration instead of stopping on it.
local VisualParams = RaycastParams.new()
VisualParams.FilterType = Enum.RaycastFilterType.Include
VisualParams.RespectCanCollide = true
VisualParams.IgnoreWater = true

local MapRoot = workspace.World:WaitForChild("Map")
local Voxel = workspace.World:WaitForChild("Voxel")
VisualParams.FilterDescendantsInstances = { MapRoot, Voxel }
-- ─────────────────────────────────────────
-- Inlined Seed (replaces Utility.Seed)
-- ─────────────────────────────────────────
local Seed = Random.new()

-- ─────────────────────────────────────────
-- Inlined EventService (replaces EventService.new())
-- ─────────────────────────────────────────
local function newEvent()
	local event = {}
	event._connections = {}

	function event:Connect(fn)
		local conn = { Callback = fn, Connected = true }
		self._connections[conn] = true
		function conn:Disconnect()
			conn.Connected = false
			event._connections[conn] = nil
		end
		return conn
	end

	function event:Once(fn)
		local conn
		conn = self:Connect(function(...)
			conn:Disconnect()
			fn(...)
		end)
		return conn
	end

	function event:Fire(...)
		for conn in self._connections do
			if conn.Connected then
				task.spawn(conn.Callback, ...)
			end
		end
	end

	function event:Destroy()
		for conn in self._connections do
			conn:Disconnect()
		end
		table.clear(self._connections)
	end

	return event
end

-- ─────────────────────────────────────────
-- Ignore list
-- ─────────────────────────────────────────
local IgnorePartNames = {
	Barrier = true,
}

-- ─────────────────────────────────────────
-- DefaultCraterInfo
-- ─────────────────────────────────────────
local DefaultCraterInfo = {
	Amount = 6,

	Timing = {
		In = {
			Min = 0.1,
			Max = 0.2
		},
		Idle = {
			Min = 4.7,
			Max = 5.1
		},
		Out = {
			Min = 1.6,
			Max = 2.2
		},
	},

	Distance = 3,

	Exposure = {
		Min = 0.6,
		Max = 0.8
	},

	Angle = {
		Min = -30,
		Max = 30
	},

	LookAt = {
		Min = -3,
		Max = 3
	},

	Burn = {
		Enabled = false,
	},

	BaseX = 3,
	BaseY = 1.5,
	BaseZ = 2.1,

	SizeMultiplier = 1,

	CastShadow = true,
	CraterSmoke = true,
	CanCollide = true,

	Rotation = {
		Min = {X = math.rad(-12), Y = math.rad(-12), Z = math.rad(-12)},
		Max = {X = math.rad(12), Y = math.rad(12), Z = math.rad(12)}
	},
}
DefaultCraterInfo.__index = DefaultCraterInfo

-- ─────────────────────────────────────────
-- Helpers
-- ─────────────────────────────────────────
local function RandomSettingToAngles(Setting)
	return CFrame.Angles(
		Rnd:NextNumber(Setting.Min.X, Setting.Max.X),
		Rnd:NextNumber(Setting.Min.Y, Setting.Max.Y),
		Rnd:NextNumber(Setting.Min.Z, Setting.Max.Z)
	)
end

local function RandomSetting(Setting)
	return if typeof(Setting) == "table" then Rnd:NextNumber(Setting.Min, Setting.Max) else Setting
end

local function NormalisedDirection(Direction)
	return if Direction.Magnitude < 1e-7 then Vector3.zero else Direction.Unit
end

local function GetDistanceMax(Distance)
	return if typeof(Distance) == "table" then Distance.Max else Distance
end

local function GetNumberSetting(Setting)
	return if typeof(Setting) == "table" then RandomSetting(Setting) else Setting
end

local function CanSpawnCraterOn(Result)
	local IsADestructible = false
	if Result then
		IsADestructible = (Result.Instance:HasTag("DestructibleDescendant") or Result.Instance:HasTag("Destructible"))
	end
	-- Normal.Y: only ground-like surfaces (now that walls are in the filter, a slanted ray or a
	-- wall's edge must not stick rocks onto it)
	return (Result ~= nil and Result.Instance.CanCollide and Result.Normal.Y > 0.5 and not IsADestructible and not IgnorePartNames[Result.Instance.Name])
end

local function FetchGround(Pos, NegY)
	local GroundRay = workspace:Raycast(Pos, Vector3.yAxis * -(NegY or 8), VisualParams)
	if not GroundRay then return end
	return {
		Position = GroundRay.Position,
		Normal = GroundRay.Normal,
		Color = GroundRay.Instance.Color,
		Material = GroundRay.Instance.Material,
		Raw = GroundRay,
	}
end

-- ─────────────────────────────────────────
-- RockHandler methods
-- ─────────────────────────────────────────
function RockHandler.GetAdorneeCFrame(Adornee)
	if typeof(Adornee) == "CFrame" then
		return Adornee
	elseif typeof(Adornee) == "Instance" then
		return Adornee.CFrame
	elseif typeof(Adornee) == "Vector3" then
		return CFrame.new(Adornee)
	end
	error("Could not get CFrame from Adornee")
end

function RockHandler.SlightlyBrightenColor(Color)
	return Color
end

function RockHandler.GenerateRandomOrientation(ReturnAngles)
	local Orientation = Rnd:NextUnitVector() * 360
	if ReturnAngles then
		return CFrame.Angles(Orientation.X, Orientation.Y, Orientation.Z)
	end
	return Orientation
end

function RockHandler.MatchWithRay(Rock, Result)
	local ResultInstance = Result.Instance
	if not ResultInstance:GetAttribute("RockIgnoreTransparency") then
		Rock.Transparency = ResultInstance.Transparency
	end
	Rock.Reflectance = ResultInstance.Reflectance
	Rock.Color = RockHandler.SlightlyBrightenColor(ResultInstance.Color)
	Rock.Material = ResultInstance.Material
	Rock.MaterialVariant = ResultInstance.MaterialVariant
end

function RockHandler.Rocks(PresetName, Adornee)
	local Preset = Presets[PresetName]
	if not Preset then return end

	local Coordinate = RockHandler.GetAdorneeCFrame(Adornee)

	for Index = -1, 1, 2 do
		local Origin
		if Preset.Messy then
			Origin = Coordinate * CFrame.new(
				Rnd:NextNumber(-Preset.Spacing, Preset.Spacing), 0,
				Rnd:NextNumber(-Preset.Spacing, Preset.Spacing)
			)
		else
			Origin = Coordinate * CFrame.new(Preset.Spacing * Index, 0, 0)
		end

		local Raycast = workspace:Raycast(Origin.Position + Vector3.yAxis * 2, -Vector3.yAxis * (Preset.RaycastDistance + 2), VisualParams)

		if Raycast then
			local Rock = Assets.Debree:Clone()
			Rock.CanCollide = false
			RockHandler.MatchWithRay(Rock, Raycast)

			if Preset.Size then
				Rock.Size = Vector3.one * Preset.Size
			end

			local NewPosition = Raycast.Position
			local InGround = NewPosition - Vector3.yAxis * Rock.Size.Y

			Rock.Position = InGround
			Rock.Orientation = RockHandler.GenerateRandomOrientation()
			Rock.Parent = workspace.World.Visuals

			local FadeInInfo = TweenInfo.new(Preset.FadeInTime or Rnd:NextNumber(0.25, 0.4))
			TweenService:Create(Rock, FadeInInfo, { Position = NewPosition }):Play()

			task.delay(3 + Rnd:NextNumber(-0.5, 0.5), function()
				local FadeOutInfo = TweenInfo.new(Rnd:NextNumber(1, 2))
				local FadeOutTween = TweenService:Create(Rock, FadeOutInfo, { Position = InGround })
				FadeOutTween:Play()
				FadeOutTween.Completed:Wait()
				Rock:Destroy()
			end)
		end
	end
end

function RockHandler.RocksWithoutPreset(Data, Adornee)
	local Coordinate = RockHandler.GetAdorneeCFrame(Adornee)

	for Index = -1, 1, 2 do
		local Origin
		if Data.Messy then
			Origin = Coordinate * CFrame.new(
				Rnd:NextNumber(-Data.Spacing, Data.Spacing), 0,
				Rnd:NextNumber(-Data.Spacing, Data.Spacing)
			)
		else
			Origin = Coordinate * CFrame.new(Data.Spacing * Index, 0, 0)
		end

		local Raycast = workspace:Raycast(Origin.Position + Vector3.yAxis * 2, -Vector3.yAxis * (Data.RaycastDistance + 2), VisualParams)

		if Raycast then
			local Rock = Assets.Debree:Clone()
			Rock.CanCollide = false
			RockHandler.MatchWithRay(Rock, Raycast)

			if Data.Size then
				Rock.Size = Vector3.one * Data.Size
			end

			local NewPosition = Raycast.Position
			local InGround = NewPosition - Vector3.yAxis * Rock.Size.Y

			Rock.Position = InGround
			Rock.Orientation = RockHandler.GenerateRandomOrientation()
			Rock.Parent = workspace.World.Visuals

			local FadeInInfo = TweenInfo.new(Data.FadeInTime or Rnd:NextNumber(0.25, 0.4))
			TweenService:Create(Rock, FadeInInfo, { Position = NewPosition }):Play()

			task.delay(3 + Rnd:NextNumber(-0.5, 0.5), function()
				local FadeOutInfo = TweenInfo.new(Rnd:NextNumber(1, 2))
				local FadeOutTween = TweenService:Create(Rock, FadeOutInfo, { Position = InGround })
				FadeOutTween:Play()
				FadeOutTween.Completed:Wait()
				Rock:Destroy()
			end)
		end
	end
end

function RockHandler.Rockst(Position, Direction, Params)
	local Raycast = workspace:Raycast(Position - (Direction / 2), Direction, VisualParams)

	if Raycast ~= nil then
		local RockCount = Params.Count or 5
		local XZVelocity = Params.XZVelocity or NumberRange.new(0.75, 1)
		local YVelocity = Params.YVelocity or NumberRange.new(0.75, 1.25)

		for Index = 1, RockCount do
			local Rock = Assets.FlyingDebree:Clone()
			RockHandler.MatchWithRay(Rock, Raycast)

			Rock.Size = Vector3.one * Rnd:NextNumber(table.unpack(Params.Size))
			Rock.CFrame = CFrame.lookAt(Raycast.Position, Raycast.Position - Raycast.Normal)
				+ Vector3.yAxis * 1.5
				+ Vector3.new(Rnd:NextNumber(-1, 1), 0, Rnd:NextNumber(-1, 1)) * (Params.SpawnVariance or 5)

			Params.Velocity = Params.Velocity * Rnd:NextNumber(0.75, 1)

			local Mass = math.max(1, Rock:GetMass())
			local Mass = math.max(Mass, 2)
			local VelocityDirection = (Rnd:NextUnitVector() + Vector3.yAxis).Unit

			Rock.AssemblyLinearVelocity = Mass * Vector3.new(
				VelocityDirection.X * Rnd:NextNumber(XZVelocity.Min, XZVelocity.Max) * Params.Velocity,
				VelocityDirection.Y * Rnd:NextNumber(YVelocity.Min, YVelocity.Max) * Params.Velocity,
				VelocityDirection.Z * Rnd:NextNumber(XZVelocity.Min, XZVelocity.Max) * Params.Velocity
			)

			Rock.AssemblyAngularVelocity = Mass * Vector3.new(
				Rnd:NextNumber(-5, 5),
				Rnd:NextNumber(-5, 5),
				Rnd:NextNumber(-5, 5)
			)

			Rock.Parent = workspace.World.Visuals

			task.delay((Params.Lifetime or 3) + Rnd:NextNumber(-0.5, 0.5), function()
				local FadeOutInfo = TweenInfo.new(Rnd:NextNumber(1, 2))
				local FadeOutTween = TweenService:Create(Rock, FadeOutInfo, { Size = Vector3.zero })
				FadeOutTween:Play()
				FadeOutTween.Completed:Wait()
				Rock:Destroy()
			end)
		end
	end
end

function RockHandler.Crater(Position, Direction, Info)
	Info = setmetatable(Info or {}, DefaultCraterInfo)
	local InitialCast = workspace:Raycast(Position - (Direction / 2), Direction, VisualParams)

	if not CanSpawnCraterOn(InitialCast) then return end

	local UnitDirection = NormalisedDirection(Direction)
	local Velocity = UnitDirection * (GetDistanceMax(Info.Distance) + Direction.Magnitude - InitialCast.Distance)

	local RockParent = workspace.World.Visuals
	local OnAllRockGone = newEvent()

	if Info.Burn and Info.Burn.Enabled then
		local CraterHolder = Instance.new("Model")
		CraterHolder.Name = "CraterHolder"
		CraterHolder.Parent = workspace.World.Visuals

		local Highlight = Instance.new("Highlight")
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded
		Highlight.FillColor = Info.Burn.Color
		Highlight.FillTransparency = Info.Burn.Transparency
		Highlight.OutlineTransparency = 1
		Highlight.Parent = CraterHolder

		TweenService:Create(Highlight, TweenInfo.new(RandomSetting(Info.Burn.Time)), { FillTransparency = 1 }):Play()

		OnAllRockGone:Connect(function()
			OnAllRockGone:Destroy()
			CraterHolder:Destroy()
		end)

		RockParent = CraterHolder
	end

	for CurrentAmount = 1, Info.Amount do
		local Distance = InitialCast.Normal * GetNumberSetting(Info.Distance)
		local StartPosition = InitialCast.Position + Distance

		local EndCoordinate =
			CFrame.lookAt(StartPosition, StartPosition - Distance) *
			CFrame.Angles(math.rad(90), math.rad(CurrentAmount * (360 / Info.Amount) + RandomSetting(Info.Angle)), 0) *
			CFrame.new(0, (-Distance.Magnitude - Direction.Magnitude), (Distance.Magnitude + Direction.Magnitude))

		local Raycast = workspace:Raycast(StartPosition, (EndCoordinate.Position - StartPosition), VisualParams)

		if CanSpawnCraterOn(Raycast) then
			local BaseSize = Vector3.new(Info.BaseX, Info.BaseY, Info.BaseZ) * Info.SizeMultiplier
			local Rotation = RandomSettingToAngles(Info.Rotation)

			local At = Raycast.Position - Raycast.Normal * GetNumberSetting(Info.Exposure)
			local LookAt = InitialCast.Position - Raycast.Normal * RandomSetting(Info.LookAt)

			local OutGroundCFrame = CFrame.lookAt(At, LookAt, Raycast.Normal)
			local InGroundCFrame = OutGroundCFrame - Raycast.Normal * BaseSize

			local DoOutGroundTween = (Info.Timing.In ~= 0)

			local Rock = Assets.Debree:Clone()
			RockHandler.MatchWithRay(Rock, Raycast)

			Rock.CFrame = DoOutGroundTween and InGroundCFrame or OutGroundCFrame
			Rock.Size = BaseSize
			Rock.CanCollide = Info.CanCollide
			Rock.CastShadow = Info.CastShadow

			if Info.CraterSmoke then
				local SmokeSize = (BaseSize.X + BaseSize.Y + BaseSize.Z)
				local Smoke = Assets.Smoke:Clone()
				Smoke.Size = NumberSequence.new(SmokeSize)
				Smoke.Speed = NumberRange.new(SmokeSize * 10)
				Smoke.Color = ColorSequence.new(Rock.Color)
				Smoke.Parent = Rock
				Smoke:Emit(math.clamp(math.round(SmokeSize) - 1, 1, 10))
			end

			task.delay(RandomSetting(Info.Timing.Idle), function()
				local FadeOutTween = TweenService:Create(Rock, TweenInfo.new(RandomSetting(Info.Timing.Out)),
					{ CFrame = InGroundCFrame, Size = Vector3.zero }
				)
				FadeOutTween:Play()
				FadeOutTween.Completed:Once(function()
					Rock:Destroy()
					if CurrentAmount == Info.Amount then
						OnAllRockGone:Fire()
					end
				end)
			end)

			Rock.Parent = RockParent

			if DoOutGroundTween then
				TweenService:Create(Rock, TweenInfo.new(RandomSetting(Info.Timing.In)),
					{ CFrame = OutGroundCFrame }
				):Play()
			end
		end
	end
end

function RockHandler.SemiCircleCrater(Position, Direction, FacingCFrame, Info)
	Info = setmetatable(Info or {}, DefaultCraterInfo)

	local InitialCast = workspace:Raycast(Position - (Direction / 2), Direction, VisualParams)
	if not CanSpawnCraterOn(InitialCast) then return end

	local ArcDegrees = Info.ArcDegrees or 180
	local Radius     = GetNumberSetting(Info.Distance)
	local Amount     = Info.Amount
	local Center     = InitialCast.Position

	-- character's flat forward + right on the ground plane
	local look  = FacingCFrame.LookVector
	local fwd   = Vector3.new(look.X, 0, look.Z)
	fwd = fwd.Magnitude > 1e-4 and fwd.Unit or Vector3.new(0, 0, -1)
	local right = Vector3.new(fwd.Z, 0, -fwd.X)   -- perpendicular on the ground

	for CurrentAmount = 1, Amount do
		local frac = (Amount > 1) and ((CurrentAmount - 1) / (Amount - 1)) or 0.5
		-- sweep from -half arc to +half arc, centered on FORWARD
		local a = math.rad((frac - 0.5) * ArcDegrees + RandomSetting(Info.Angle))

		-- radial direction: forward rotated by `a` around the vertical axis,
		-- built from fwd/right so it's guaranteed relative to the character
		local radial = fwd * math.cos(a) + right * math.sin(a)

		local spot = Center + radial * Radius
		local Raycast = workspace:Raycast(spot + Vector3.yAxis * 4, Vector3.yAxis * -8, VisualParams)

		if CanSpawnCraterOn(Raycast) then
			local BaseSize = Vector3.new(Info.BaseX, Info.BaseY, Info.BaseZ) * Info.SizeMultiplier

			local At = Raycast.Position - Raycast.Normal * GetNumberSetting(Info.Exposure)

			-- aim the rock's face at the arc center, so it always leans inward
			local toCenter = (Center - At)
			local flatToCenter = Vector3.new(toCenter.X, 0, toCenter.Z).Unit
			-- flip: negate it so it points AWAY from center (leans outward)
			local flatAway = -flatToCenter
			local LookAt = At + flatAway + Vector3.yAxis * (Info.InwardLean or 0.5)

			local OutGroundCFrame = CFrame.lookAt(At, LookAt, Raycast.Normal)
			local InGroundCFrame = OutGroundCFrame - Raycast.Normal * BaseSize


			local Rock = Assets.Debree:Clone()
			RockHandler.MatchWithRay(Rock, Raycast)
			Rock.CFrame = InGroundCFrame
			Rock.Size = BaseSize
			Rock.CanCollide = Info.CanCollide
			Rock.CastShadow = Info.CastShadow

			if Info.CraterSmoke then
				local SmokeSize = (BaseSize.X + BaseSize.Y + BaseSize.Z)
				local Smoke = Assets.Smoke:Clone()
				Smoke.Size = NumberSequence.new(SmokeSize)
				Smoke.Speed = NumberRange.new(SmokeSize * 10)
				Smoke.Color = ColorSequence.new(Rock.Color)
				Smoke.Parent = Rock
				Smoke:Emit(math.clamp(math.round(SmokeSize) - 1, 1, 10))
			end

			Rock.Parent = workspace.World.Visuals

			TweenService:Create(Rock, TweenInfo.new(RandomSetting(Info.Timing.In)),
				{ CFrame = OutGroundCFrame }):Play()

			task.delay(RandomSetting(Info.Timing.Idle), function()
				local FadeOut = TweenService:Create(Rock, TweenInfo.new(RandomSetting(Info.Timing.Out)),
					{ CFrame = InGroundCFrame, Size = Vector3.zero })
				FadeOut:Play()
				FadeOut.Completed:Once(function() Rock:Destroy() end)
			end)
		end
	end
end
local RockLineParams = {
	Amount = 15,
	Spacing = 1.5,
	Angle = math.rad(110),
	Size = 1,
	SizeIndex = 0.2,
	RandomJitter = 1.25,
	ExposeLevel = -0.5,
}
RockLineParams.__index = RockLineParams

local function CreateRockLine(Params, Coordinate, Index, AmountIndex)
	local Origin = Coordinate * CFrame.Angles(0, Params.Angle * Index / 2, 0) * CFrame.new(Rnd:NextNumber(-Params.RandomJitter, Params.RandomJitter), 0, -Params.Spacing * AmountIndex)
	local Raycast = workspace:Raycast(Origin.Position + (Vector3.yAxis * 2), Vector3.yAxis * -25, VisualParams)

	if Raycast then
		local Rock = Assets.RockLine:Clone()
		RockHandler.MatchWithRay(Rock, Raycast)
		Rock.Position = Raycast.Position - (Vector3.yAxis * -Params.ExposeLevel)
		Rock.Orientation = RockHandler.GenerateRandomOrientation()

		local FinalSize = Vector3.one * (Params.Size + (AmountIndex * Params.SizeIndex))

		if Params.NoTween then
			Rock.Size = FinalSize
		else
			TweenService:Create(Rock, TweenInfo.new(0.3), { Size = FinalSize }):Play()
		end

		if not Params.NoSmoke then
			local Smoke = Assets.Smoke:Clone()
			Smoke.Color = ColorSequence.new(Rock.Color)
			Smoke.Parent = Rock
			Smoke:Emit((FinalSize.X * FinalSize.Y * FinalSize.Z) / 4)
		end

		Rock.Parent = workspace.World.Visuals
		
		local hold = Params.HoldTime or 2

		task.delay(hold, function()
			local FadeOutTween = TweenService:Create(Rock, TweenInfo.new(3), { Size = Vector3.zero })
			FadeOutTween:Play()
			FadeOutTween.Completed:Wait()
			Rock:Destroy()
		end)
	end
end

function RockHandler.RockLines(Coordinate, Params)
	setmetatable(Params, RockLineParams)

	for AmountIndex = 1, Params.Amount do
		for Index = -1, 1, 2 do
			CreateRockLine(Params, Coordinate, Index, AmountIndex)
		end
		if Params.TimeTilNextRock then
			task.wait(Params.TimeTilNextRock)
		end
	end
end

local RegularRockLineParams = {
	Amount = 15,
	Spacing = 3,
	Angle = math.rad(110),
	Size = 1,
	SizeIndex = 0.2,
	RandomJitter = 1.25,
	ExposeLevel = -0.5,
	SideSpacing = 8,
	TweenDelay = 2,
}
RegularRockLineParams.__index = RegularRockLineParams

function RockHandler.RegularRockLines(Coordinate, Params)
	setmetatable(Params, RegularRockLineParams)

	for AmountIndex = 1, Params.Amount do
		for Index = -1, 1, 2 do
			local Origin = Coordinate * CFrame.Angles(0, Params.Angle * Index / 2, 0) * CFrame.new((Params.SideSpacing * Index) + Rnd:NextNumber(-Params.RandomJitter, Params.RandomJitter), 0, -Params.Spacing * AmountIndex)
			local Raycast = workspace:Raycast(Origin.Position + (Vector3.yAxis * 2), Vector3.yAxis * -25, VisualParams)

			if Raycast then
				local Rock = Assets.RockLine:Clone()
				RockHandler.MatchWithRay(Rock, Raycast)
				Rock.Position = Raycast.Position - (Vector3.yAxis * -Params.ExposeLevel)
				Rock.Orientation = RockHandler.GenerateRandomOrientation()

				local FinalSize = Vector3.one * (Params.Size + (AmountIndex * Params.SizeIndex))

				if Params.NoTween then
					Rock.Size = FinalSize
				else
					TweenService:Create(Rock, TweenInfo.new(0.3), { Size = FinalSize }):Play()
				end

				if not Params.NoSmoke then
					local Smoke = Assets.Smoke:Clone()
					Smoke.Color = ColorSequence.new(Rock.Color)
					Smoke.Parent = Rock
					Smoke:Emit((FinalSize.X * FinalSize.Y * FinalSize.Z) / 4)
				end

				Rock.Parent = workspace.World.Visuals

				task.delay(Params.TweenDelay, function()
					if Params.SinkRocks then
						local FadeOutTween = TweenService:Create(Rock, TweenInfo.new(3), {
							CFrame = Rock.CFrame - Vector3.new(0, 3, 0)
						})
						FadeOutTween:Play()
						FadeOutTween.Completed:Wait()
						Rock:Destroy()
					else
						local FadeOutTween = TweenService:Create(Rock, TweenInfo.new(3), { Size = Vector3.zero })
						FadeOutTween:Play()
						FadeOutTween.Completed:Wait()
						Rock:Destroy()
					end
				end)
			end
		end

		if Params.TimeTilNextRock then
			task.wait(Params.TimeTilNextRock)
		end
	end
end

function RockHandler.OldJSDRocks(Origin, Params)
	Params = Params or {}

	local OriginPos = (typeof(Origin) == "CFrame" and Origin.Position) or Origin
	local Ground = FetchGround(OriginPos + Vector3.yAxis * 2, 10)
	if not Ground then return end

	local OriginCFr = (typeof(Origin) == "CFrame" and (Origin - Origin.Position) + Ground.Position)
		or CFrame.new(Ground.Position, Ground.Position + Ground.Normal) * CFrame.Angles(math.rad(-90), 0, 0)

	local RockCount = Params.Rocks or 4
	local Distance = Params.Distance or 3
	local SizeMagnitude = Params.SizeMagnitude or 1
	local BaseDuration = Params.BaseDuration or 2
	local ExposeLevel = Params.ExposeLevel or 0
	local OpenSpace = Params.OpenSpaces or 0
	local Layers = Params.Layers or 1

	local IsMagnitude = (typeof(SizeMagnitude) == "number")
	local SizeMultipliers = {}
	if IsMagnitude then
		SizeMultipliers.X = SizeMagnitude
		SizeMultipliers.Y = SizeMagnitude
		SizeMultipliers.Z = SizeMagnitude
	else
		SizeMultipliers.X = SizeMagnitude.X
		SizeMultipliers.Y = SizeMagnitude.Y
		SizeMultipliers.Z = SizeMagnitude.Z
	end

	local MinVariation = Params.VariationMin or 0.95
	local MaxVariation = Params.VariationMax or 1.05
	local MinSizeVariation = Params.SizeVariationMin or 0.95
	local MaxSizeVariation = Params.SizeVariationMax or 1.05
	local MinAngleVariation = Params.MinAngleVariation or -30
	local MaxAngleVariation = Params.MaxAngleVariation or 30

	local BaseX = Params.BaseX or 3
	local BaseY = Params.BaseY or 1.5
	local BaseZ = Params.BaseZ or 2.1
	local BaseSize = Vector3.new(BaseX, BaseY, BaseZ) * Vector3.new(SizeMultipliers.X, SizeMultipliers.Y, SizeMultipliers.Z)

	local function FetchVariatedSize()
		return BaseSize * Seed:NextNumber(MinSizeVariation, MaxSizeVariation)
	end

	local function GetDistanceVariation()
		return Distance * Seed:NextNumber(MinVariation, MaxVariation)
	end

	local RockSpace = RockCount + OpenSpace

	local function CreatePiece(i)
		local Angle = (i * (math.pi * 2 / RockSpace)) + math.rad(Seed:NextNumber(-30, 30))
		local X, Z = math.sin(Angle), math.cos(Angle)

		X *= GetDistanceVariation()
		Z *= GetDistanceVariation()

		local OffsetPos = OriginCFr.Position + Vector3.new(X, 0, Z)
		local GroundRay = workspace:Raycast(OffsetPos + Vector3.yAxis * 2, Vector3.yAxis * -7, VisualParams)

		if not GroundRay then return end
		if GroundRay.Normal:Dot(Vector3.yAxis) < 1 then return end

		for i = 1, Layers do
			task.spawn(function()
				local ScaleFactor = (i == 1 and 1) or 1 + (i * 0.05)

				local NewPiece = script.Assets.Debree:Clone()
				NewPiece.Anchored = true
				NewPiece.CanCollide = (Params.CanCollide == nil and true) or Params.CanCollide
				NewPiece.Color = GroundRay.Instance.Color
				NewPiece.Material = GroundRay.Instance.Material
				NewPiece.Size = FetchVariatedSize() * ScaleFactor

				local VarAngle = math.rad(Seed:NextNumber(40, 45) * ScaleFactor)
				if Params.Inverted then
					VarAngle = -VarAngle
				end

				local BaseCFr = CFrame.new(OffsetPos, OriginCFr.Position)
					* CFrame.new(0, 0, (i == 1 and 0) or ScaleFactor * Seed:NextNumber(1.2, 1.7))
					* CFrame.Angles(VarAngle, 0, 0)
				local EndCFr = BaseCFr * CFrame.new(0, NewPiece.Size.Y * 0.05 + ExposeLevel, 0)

				NewPiece.CFrame = EndCFr
				NewPiece.Position -= Vector3.yAxis * 4
				NewPiece.Parent = workspace.World.Visuals

				TweenService:Create(NewPiece, TweenInfo.new(Seed:NextNumber(0.1, 0.15), Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { CFrame = EndCFr }):Play()
				task.wait(BaseDuration * Seed:NextNumber(0.9, 1.1))
				TweenService:Create(NewPiece, TweenInfo.new(Seed:NextNumber(1.1, 1.5), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Position = NewPiece.Position - Vector3.yAxis * NewPiece.Size.Y }):Play()
				task.delay(2, NewPiece.Destroy, NewPiece)
			end)
		end
	end

	for i = 1, RockCount do
		task.spawn(CreatePiece, i)
	end
end

function RockHandler.ExpandingCrater(Position, Direction, Info, Growth)
	Info   = setmetatable(Info or {}, DefaultCraterInfo)
	Growth = Growth or {}
	local GrowTime    = Growth.GrowTime       or 0.7
	local StartRadius = Growth.StartRadius    or 4     -- the ring's starting radius
	local GrowStyle   = Growth.EasingStyle    or Enum.EasingStyle.Quad
	local GrowDir     = Growth.EasingDirection or Enum.EasingDirection.Out
	local GrowSize    = Growth.GrowSize == true        -- also scale rocks up as they spread (off by default)
	local Jitter      = Growth.Jitter         or 0.1   -- per-rock arrival variance, keeps it organic
	
	--local newParams = RaycastParams.new()
	--newParams.FilterType = Enum.RaycastFilterType.Include
	--local Map = workspace.World.Map.Destroyable.Map
	--newParams.FilterDescendantsInstances = {Map}
	
	
	local InitialCast = workspace:Raycast(Position - (Direction / 2), Direction, VisualParams)
	if not CanSpawnCraterOn(InitialCast) then return end
	local Center = InitialCast.Position

	for CurrentAmount = 1, Info.Amount do
		-- Final resting spot — identical maths to RockHandler.Crater, so the finished crater is unchanged.
		local Distance = InitialCast.Normal * GetNumberSetting(Info.Distance)
		local StartPosition = InitialCast.Position + Distance
		local EndCoordinate =
			CFrame.lookAt(StartPosition, StartPosition - Distance) *
			CFrame.Angles(math.rad(90), math.rad(CurrentAmount * (360 / Info.Amount) + RandomSetting(Info.Angle)), 0) *
			CFrame.new(0, (-Distance.Magnitude - Direction.Magnitude), (Distance.Magnitude + Direction.Magnitude))
		local Raycast = workspace:Raycast(StartPosition, (EndCoordinate.Position - StartPosition), VisualParams)

		if CanSpawnCraterOn(Raycast) then
			local BaseSize = Vector3.new(Info.BaseX, Info.BaseY, Info.BaseZ) * Info.SizeMultiplier
			local exposure = GetNumberSetting(Info.Exposure)
			local At     = Raycast.Position - Raycast.Normal * exposure
			local LookAt = InitialCast.Position - Raycast.Normal * RandomSetting(Info.LookAt)
			local OutGroundCFrame = CFrame.lookAt(At, LookAt, Raycast.Normal)
			local InGroundCFrame  = OutGroundCFrame - Raycast.Normal * BaseSize

			-- Matching START near the centre: same facing & burial, slid in to StartRadius along the flat radial.
			local flat = Vector3.new(At.X - Center.X, 0, At.Z - Center.Z)
			local Rfinal = math.max(flat.Magnitude, 1e-3)
			local radial = Rfinal > 1e-3 and flat.Unit or Vector3.new(0, 0, 1)
			local startPos = Vector3.new(Center.X, At.Y, Center.Z) + radial * StartRadius
			local StartCFrame = CFrame.new(startPos) * OutGroundCFrame.Rotation

			local gt = GrowTime * Rnd:NextNumber(1 - Jitter, 1 + Jitter)

			local Rock = Assets.Debree:Clone()
			RockHandler.MatchWithRay(Rock, Raycast)
			Rock.CanCollide = false
			Rock.CastShadow = Info.CastShadow
			Rock.CFrame = StartCFrame
			Rock.Size = GrowSize and BaseSize * math.clamp(StartRadius / Rfinal, 0.3, 1) or BaseSize
			Rock.Parent = workspace.World.Visuals

			-- Expand: slide outward (and optionally grow) to the final crater spot.
			local goals = { CFrame = OutGroundCFrame }
			if GrowSize then goals.Size = BaseSize end
			TweenService:Create(Rock, TweenInfo.new(gt, GrowStyle, GrowDir), goals):Play()

			-- Hold at full size, then sink + shrink away exactly like the original.
			task.delay(gt + RandomSetting(Info.Timing.Idle), function()
				local FadeOutTween = TweenService:Create(Rock, TweenInfo.new(RandomSetting(Info.Timing.Out)),
					{ CFrame = InGroundCFrame, Size = Vector3.zero }
				)
				FadeOutTween:Play()
				FadeOutTween.Completed:Once(function()
					Rock:Destroy()
				end)
			end)
		end
	end
end



local dataTable = {}
local startTime = tick()
local function cleanupThrownObjects()
	if tick() - startTime > 300 then
		startTime = tick()
		local destroyedCount = 0

		for _, object in pairs(workspace.World.Debris:GetChildren()) do
			if
				object:IsA("Part")
				and object:GetAttribute("Spawn")
				and not table.find(dataTable, object)
				and not object:GetAttribute("DeletionImmunity")
				and tick() - object:GetAttribute("Spawn") > 60
			then
				object:Destroy()
				destroyedCount = destroyedCount + 1
			end
		end

		return
	else
		local firstEntry = rawget(dataTable, 1)

		if #dataTable > 100 then
			for _ = 101, #dataTable do
				local excessEntry = rawget(dataTable, 101)
				table.remove(dataTable, 101)

				if excessEntry then
					excessEntry:Destroy()
				end
			end
		end

		if firstEntry and not firstEntry.Parent then
			table.remove(dataTable, 1)
		end

		if firstEntry and firstEntry.Parent then
			table.remove(dataTable, 1)

			if firstEntry.Name == "starterdeb" then
				firstEntry.Name = "aa"
			end

			firstEntry.CollisionGroup = "NonPColDebri"
			firstEntry:SetAttribute("Spawn", tick())

			return firstEntry
		else
			return
		end
	end
end

local function calculateCFrameBetweenVectors(vectorA, vectorB, axis)
	local dotProduct = vectorA:Dot(vectorB)
	local crossProduct = vectorA:Cross(vectorB)

	if dotProduct < -0.99999 then
		return CFrame.fromAxisAngle(axis, math.pi)
	else
		return CFrame.new(0, 0, 0, crossProduct.x, crossProduct.y, crossProduct.z, 1 + dotProduct)
	end
end

local function performRaycast(rayData)
	local orig = rayData.orig
	local dir = rayData.dir
	local raycastParams = RaycastParams.new()

	-- VoxBreaker disables CanQuery on destroyed floor and parents the recut pieces to
	-- World.Voxel, so the default filter must see that folder or rays fall through
	-- fresh craters and sample whatever sits beneath the real ground
	local filter = rayData.Whitelist
	if not filter then
		filter = { workspace.World.Map.Destroyable:WaitForChild("Map") }
		--local VoxelFolder = workspace.World:FindFirstChild("Voxel")
		--if VoxelFolder then
		--	table.insert(filter, VoxelFolder)
		--end
	end
	raycastParams.FilterDescendantsInstances = filter
	raycastParams.FilterType = Enum.RaycastFilterType.Include

	if rayData.Blockcast then
		local result = workspace:Blockcast(orig, rayData.Blockcast, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	else
		-- World.Voxel also holds launched (unanchored) debris chunks; step past those so
		-- we sample the static ground underneath, not a chunk flying by
		local from, remaining = orig, dir
		for _ = 1, 4 do
			local result = workspace:Raycast(from, remaining, raycastParams)
			if not result then
				return
			end
			if result.Instance.Anchored then
				return result.Instance, result.Position, result.Material, result.Normal
			end
			local step = dir.Unit * 0.1
			remaining = remaining - (result.Position - from) - step
			from = result.Position + step
		end
		return
	end
end
--[[
	spawnFlyingDebris(config)

	The two flying-debris loops from debrisSpawner, extracted, with the raycast
	folded in and every hardcoded roll exposed. Does NOT spawn the crater ring.

	Paste this into the SAME script that defines debrisSpawner, because it needs
	these upvalues to already exist in scope:
		cleanupThrownObjects   -- part pool
		dataTable              -- part pool backing table
		LocalConfigFolder      -- for "Fast Mode"
		calculateCFrameBetweenVectors
		performRaycast
		TS                     -- TweenService

	--------------------------------------------------------------------------
	TOP LEVEL
		position       Vector3   impact point. Raycasts down from here to find
		                         the floor; hit point + normal are used automatically.
		Seed           number?   omit for tick()-seeded.
		parent         Instance? default workspace.World.Debris.
		less           bool?     kills chunks, divides smalls by 2.5. (add.less)
		nodebris       bool?     kills both.
		ignoreFastMode bool?     skip the Fast Mode /2.

		chunk          table?    settings for the big tumbling rocks
		small          table?    settings for the SmallDebris shards

		-- override path, for callers that already raycast (e.g. debrisSpawner):
		ground         BasePart? skips the internal raycast.
		cframe         CFrame    spawn origin. required if ground is passed.
		normal         Vector3?  surface normal. default (0,1,0).

	--------------------------------------------------------------------------
	PER-GROUP (identical schema for `chunk` and `small`)

		amount       number?   ABSOLUTE count. wins over amountRange.
		amountRange  {a, b}    randomized count. chunk default {3,5}, small {4,7}.

		size         number?   fixed cube size. wins over sizeRange.
		sizeRange    {a, b}    randomized cube size. chunk default {1,3}, small {0.6,0.8}.
		sizeMult     number?   multiplier applied after either of the above. default 1.
		shape        Vector3?  per-axis multiplier on the final size, for flat
		                       shards instead of cubes. default (1,1,1).

		spread       {a, b}    horizontal velocity roll, used for BOTH X and Z.
		                       default {-25, 25}.
		upward       {a, b}    vertical velocity roll. default {5, 25}.
		speedMult    number?   multiplier on the final velocity vector. default 2.
		                       (2 is the original's hardcoded value, not a bonus.)

		lifetime     number?   seconds before fadeout begins. default 3.
		jitter       number?   random 0..jitter added to lifetime. default 1.

		spin         bool?     attach a BodyAngularVelocity. chunk default false,
		                       small default true.
		spinVelocity Vector3?  AngularVelocity. default Roblox's (0,2,0).
		spinTorque   number?   MaxTorque on all axes. default Roblox's 4000.

	--------------------------------------------------------------------------
	Counts are floored. Sizes are cubes unless `shape` is set. If the raycast
	misses, the function returns silently — same failure mode as Ground Crater.

	Passing NOTHING for chunk/small reproduces the original debrisSpawner
	behaviour exactly.
]]

local FLYING_DEBRIS_RAY_UP = 2 -- studs above `position` the ray starts
local FLYING_DEBRIS_RAY_LEN = 14 -- studs the ray travels down

local CHUNK_DEFAULTS = {
	amountRange = { 3, 5 },
	sizeRange = { 1, 3 },
	spread = { -25, 25 },
	upward = { 5, 25 },
	speedMult = 2,
	lifetime = 3,
	jitter = 1,
	spin = false,
}

local SMALL_DEFAULTS = {
	amountRange = { 4, 7 },
	sizeRange = { 0.6, 0.8 },
	spread = { -25, 25 },
	upward = { 5, 25 },
	speedMult = 2,
	lifetime = 3,
	jitter = 1,
	spin = true,
}

local function resolveGroup(user, def)
	user = user or {}

	local sizeMin, sizeMax
	if user.size then
		sizeMin, sizeMax = user.size, user.size
	else
		local r = user.sizeRange or def.sizeRange
		sizeMin, sizeMax = r[1], r[2]
	end

	local mult = user.sizeMult or 1

	return {
		amount = user.amount,
		amountRange = user.amountRange or def.amountRange,
		sizeMin = sizeMin * mult,
		sizeMax = sizeMax * mult,
		shape = user.shape or Vector3.new(1, 1, 1),
		spread = user.spread or def.spread,
		upward = user.upward or def.upward,
		speedMult = user.speedMult or def.speedMult,
		lifetime = user.lifetime or def.lifetime,
		jitter = user.jitter or def.jitter,
		spin = user.spin ~= nil and user.spin or def.spin,
		spinVelocity = user.spinVelocity,
		spinTorque = user.spinTorque,
	}
end

local function spawnFlyingDebris(config)
	local ground, origin, normal

	if config.ground then
		ground = config.ground
		origin = config.cframe
		normal = config.normal or Vector3.new(0, 1, 0)
		if not origin then
			return
		end
	else
		if not config.position then
			return
		end

		local hit, pos, _, nrm = performRaycast({
			orig = config.position + Vector3.new(0, FLYING_DEBRIS_RAY_UP, 0),
			dir = Vector3.new(0, -FLYING_DEBRIS_RAY_LEN, 0),
			Whitelist = {
				workspace.World.Map.Destroyable.Map.Floor,
				workspace.World.Map["Indestructible Map"].IndestructableFloor,
				workspace.World.Voxel, --fixes white rocks only
			},
		})

		if not hit then
			return
		end

		ground = hit
		origin = CFrame.new(pos)
		normal = nrm or Vector3.new(0, 1, 0)
	end

	local rng = Random.new(config.Seed or tick())
	local parent = config.parent or workspace.World.Debris

	local chunk = resolveGroup(config.chunk, CHUNK_DEFAULTS)
	local small = resolveGroup(config.small, SMALL_DEFAULTS)

	--local fast = LocalConfigFolder:FindFirstChild("Fast Mode")
	--	and LocalConfigFolder["Fast Mode"].Value == true

	local chunkCount = chunk.amount or rng:NextNumber(chunk.amountRange[1], chunk.amountRange[2])
	local smallCount = small.amount or rng:NextNumber(small.amountRange[1], small.amountRange[2])

	if config.less then
		chunkCount = 0
		smallCount = smallCount / 2.5
	end

	--if fast and not config.ignoreFastMode then
	--	chunkCount = chunkCount / 2
	--	smallCount = smallCount / 2
	--end

	if config.nodebris then
		chunkCount = 0
		smallCount = 0
	end

	chunkCount = math.floor(chunkCount)
	smallCount = math.floor(smallCount)

	-- pooled parts arrive with whatever state the previous user left them in.
	-- ring rocks get CanTouch/CanQuery false and Name "SmallDebris"; the original
	-- loops never reset those, so recycled parts came back raycast-invisible.
	local function acquire()
		local p = cleanupThrownObjects() or Instance.new("Part")
		p.Name = "Debris"
		p.CollisionGroup = "NonPColDebri"
		p.Anchored = true
		p.CanCollide = false
		p.CanTouch = true
		p.CanQuery = true
		p.Material = ground.Material
		p.MaterialVariant = ground.MaterialVariant
		p.Color = ground.Color
		p.Transparency = ground.Transparency
		p.TopSurface = Enum.SurfaceType.Smooth -- Instance.new("Part") defaults to Studs/Inlet
		p.BottomSurface = Enum.SurfaceType.Smooth
		p:SetAttribute("CanGoThroughCamera", true)
		p:SetAttribute("OGCframe", nil)
		return p
	end

	-- caller must set CFrame, Size and Parent before calling this
	local function launch(p, g)
		p.AssemblyLinearVelocity = Vector3.new()
		p.AssemblyAngularVelocity = Vector3.new()
		p.CanCollide = true
		p.Anchored = false

		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
		bv.Velocity = Vector3.new(
			rng:NextNumber(g.spread[1], g.spread[2]),
			rng:NextNumber(g.upward[1], g.upward[2]),
			rng:NextNumber(g.spread[1], g.spread[2])
		) * g.speedMult
		bv.Parent = p
		game:GetService("Debris"):AddItem(bv, 0.15)

		local bav = nil
		if g.spin then
			bav = Instance.new("BodyAngularVelocity")
			if g.spinVelocity then
				bav.AngularVelocity = g.spinVelocity
			end
			if g.spinTorque then
				bav.MaxTorque = Vector3.new(g.spinTorque, g.spinTorque, g.spinTorque)
			end
			bav.Parent = p
			game:GetService("Debris"):AddItem(bav, 0.5)
		end

		task.delay(g.lifetime + rng:NextNumber(0, g.jitter), function()
			TweenService:Create(p, TweenInfo.new(g.tweenTime or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1,
				Size = p.Size / 1.5,
			}):Play()

			task.delay(0.3, function()
				if bav then
					bav:Destroy()
				end
				p.Anchored = true
				p.CanCollide = false
				p.CFrame = CFrame.new(100000000, 100000000, 100000000)
				table.insert(dataTable, p)
			end)
		end)
	end

	-- big chunks: fully random orientation
	for _ = 1, chunkCount do
		local s = rng:NextNumber(chunk.sizeMin, chunk.sizeMax)
		local p = acquire()

		p.CFrame = origin * CFrame.Angles(
			math.rad(rng:NextNumber(-360, 360)),
			math.rad(rng:NextNumber(-360, 360)),
			math.rad(rng:NextNumber(-360, 360))
		)
		p.Size = Vector3.new(s, s, s) * chunk.shape
		p.Parent = parent

		launch(p, chunk)
	end

	-- SmallDebris: aligned to the surface normal
	for _ = 1, smallCount do
		local s = rng:NextNumber(small.sizeMin, small.sizeMax)
		local p = acquire()

		p.Name = "SmallDebris"
		p.CFrame = origin
		p.CFrame = p.CFrame
			* (calculateCFrameBetweenVectors(p.CFrame.UpVector, normal, Vector3.new(0, 1, 0))
				* CFrame.Angles(1.5707963267948966, 0, 0))
		p.Size = Vector3.new(s, s, s) * small.shape
		p.Parent = parent

		launch(p, small)
	end
end

shared.flyingdebris = spawnFlyingDebris


return RockHandler
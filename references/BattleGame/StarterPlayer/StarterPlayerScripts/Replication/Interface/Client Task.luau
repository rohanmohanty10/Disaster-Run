type particlesModule = {
	GetHLF: (Part: Part?) -> number,
	Emit: (Part: Part?) -> (),
	Enabled: (Part: Part?, State: boolean) -> (),
	EnableTrail: (Part: Part?, State: boolean) -> (),
	scaleLifetime: (Part: Part?, newScale: number) -> (),
	tweenScale: (Model: Model, Parameters: { startScale: number?, goalScale: number, Info: TweenInfo }) -> (),
	resizeParticle: (Particles: { any }, GoalSize: number) -> (),
}

local ClientTasks = tick()

--Services

local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local TS = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local RNS = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local StarterGui = game:GetService("StarterGui")
local SoundService = game:GetService("SoundService")
local TextChatService = game:GetService("TextChatService")
local ServerStorage = game:GetService("ServerStorage")

--Modules
local CamShakePresets = require(RS.Modules.CamShakePresets)
local SoundsModule = require(RS.Modules.SoundHandler)

local Utility = require(RS.Modules:WaitForChild("Utility"))
local ParticlesModule: particlesModule = Utility("Particles")
local Trove = require(RS.Modules.Trove)

--Player

local LocalPlayer = game.Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
LocalPlayer:GetPropertyChangedSignal("Character"):Connect(function()
	LocalCharacter = LocalPlayer.Character
end)
local LocalConfigFolder = LocalPlayer:FindFirstChild("Configuration") or LocalPlayer:WaitForChild("Configuration", 10)

--Remotes
local VFXFunctions = require(RS.Modules.ClientEffects.VfxHandler)

--local BoatTween = require(RS.Modules.ClientEffects.BoatTween)
local BoatTween = require(RS.Modules.ClientEffects.EffectHelper.BoatTween)

local Comunicator = RS.Remotes.Comunicator

local ComSet = Comunicator.Set
local ComGet = Comunicator.Get

--Variables

local RandomSeed = Random.new()

local Assets = RS.Assets
local Effects = Assets.Effects
local LegacyReplication = RS.Resources.LegacyReplication
local Resources = RS.Resources

local DestroyedParts = {}
shared.DestroyedParts = DestroyedParts

--Params

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = {
	workspace.World.Map.Destroyable:WaitForChild("Map"),
	--workspace.Map:WaitForChild("Miscellaneous"),
	--workspace.Map.Borders,
	--workspace.Map:WaitForChild("Destroyable"):WaitForChild("Buildings"),
	--workspace.World.Map:WaitForChild("Destroyable"):WaitForChild("Buildings")
}

local MapOverlapParams = OverlapParams.new()
MapOverlapParams.RespectCanCollide = true
MapOverlapParams.FilterType = MapRayParams.FilterType
MapOverlapParams.FilterDescendantsInstances = { workspace.World.Map.Destroyable:WaitForChild("Map") }

local FlyAnimations = {
	Idle = { Vector3.new(0, 0, 0), "Idle", 94758213419458 },
	Go = { Vector3.new(0, 0, -1), "Go", 81114852737149 },
	Back = { Vector3.new(0, 0, 1), "Back", 126932518182313 },
	Right = { Vector3.new(1, 0, 0), "Right", 71157769026115 },
	Left = { Vector3.new(-1, 0, 0), "Left", 135853202712106 },
	AD_Right = { Vector3.new(1, 0, -1), "AD_Right", 121663167610266 },
	AD_Left = { Vector3.new(-1, 0, -1), "AD_Left", 130933791889226 },
	AA_Right = { Vector3.new(1, 0, 1), "AA_Right", 121026914054347 },
	AA_Left = { Vector3.new(-1, 0, 1), "AA_Left", 93854851650591 },
}

shared.clearVelocities = function(Part: Part, Ignore: BodyVelocity?)
	for _, Velocity in Part:GetDescendants() do
		if
			Velocity ~= Ignore
			and (
				Velocity:IsA("BodyVelocity")
					or Velocity:IsA("LinearVelocity")
					or Velocity:IsA("BodyPosition")
					or Velocity:IsA("BodyGyro")
					or Velocity:IsA("BodyAngularVelocity")
					or Velocity:IsA("BodyMover")
					or Velocity:IsA("BodyForce")
					or Velocity:IsA("BodyThrust")
					or Velocity:IsA("AngularVelocity")
					or Velocity:IsA("VelocityMotor")
			)
		then
			Velocity:Destroy()
		end
	end
	--warn("Cleared velocities")
end

shared.zeroVelocities = function(Part: Part)
	if not Part then return end

	Part.AssemblyLinearVelocity = Vector3.zero
	Part.AssemblyAngularVelocity = Vector3.zero
	warn("Zeroed velocities")
end

--local DefaultFilter = {
--	workspace.World.Live,
--	workspace.World.Debris,
--	workspace.World.Visuals,
--	workspace.World.Hitboxes,
--	workspace.World.Leaderboards,
--}

--Functions
local function raycast(
	Origin: Vector3,
	Direction: Vector3,
	rayParams: RaycastParams,
	isWhitelist: boolean,
	returnIsolated: boolean
)
	local localRayParams
	if typeof(rayParams) == "table" then
		localRayParams = RaycastParams.new()
		localRayParams.FilterDescendantsInstances = rayParams
		if isWhitelist then
			localRayParams.FilterType = Enum.RaycastFilterType.Include
		else
			localRayParams.FilterType = Enum.RaycastFilterType.Exclude
		end
	else
		localRayParams = MapRayParams
	end

	local ray = workspace:Raycast(Origin, Direction, localRayParams)
	if not returnIsolated then
		return ray
	else
		return ray.Instance, ray.Position, ray.Material, ray.Normal
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
local function QuickWeld(Part0, Part1)
	Part1.Anchored = false

	local Weld = Instance.new("WeldConstraint")
	Weld.Part0 = Part0
	Weld.Part1 = Part1
	Weld.Parent = Part1

	return Weld
end

local function PlayMesh(MeshContainer)
	task.spawn(function()
		local Model = MeshContainer.Model
		local TweenInformation = MeshContainer.Info or TweenInfo.new(1, Enum.EasingStyle.Sine)
		local StartPart = Model:FindFirstChild("Start")
		local EndPart = Model:FindFirstChild("End")
		local NoDelete = MeshContainer.Stay
		local GoalCFrame = MeshContainer.Anchor
		local GoalTransparency = MeshContainer.EndT or 1
		local ExtraLifetime = MeshContainer.Del
		local Skip = MeshContainer.Skip

		Model.PrimaryPart = StartPart

		if not Skip then
			for _, eyes in pairs(Model:GetChildren()) do
				if eyes:IsA("BasePart") then
					eyes.CanCollide = false
					eyes.Anchored = true
				end
			end
		end

		if GoalCFrame then
			Model:PivotTo(GoalCFrame)
		end

		if MeshContainer.T then
			StartPart.Transparency = MeshContainer.T
		end

		EndPart.Transparency = 1
		Model.Parent = workspace.World.Debris

		local StartDecal = StartPart:FindFirstChildOfClass("Decal")
		local StartMesh = StartPart:FindFirstChildOfClass("SpecialMesh")
		local EndMesh = EndPart:FindFirstChildOfClass("SpecialMesh")
		local EndDecal = EndPart:FindFirstChildOfClass("Decal")

		if EndDecal and not Skip then
			EndDecal.Transparency = 1
		end

		local Tween = nil

		if ExtraLifetime then
			TS:Create(StartPart, TweenInformation, {
				Size = EndPart.Size,
				CFrame = EndPart.CFrame,
			}):Play()

			task.delay(ExtraLifetime, function()
				Tween = TS:Create(StartPart, TweenInformation, {
					Transparency = GoalTransparency,
				})

				Tween:Play()

				if StartDecal then
					for _, Decal in pairs(StartPart:GetChildren()) do
						if Decal:IsA("Decal") then
							TS:Create(Decal, TweenInformation, {
								Transparency = GoalTransparency,
							}):Play()
						end
					end
				end

				if StartMesh then
					Tween = TS:Create(StartMesh, TweenInformation, {
						Scale = EndMesh.Scale,
					}):Play()
				end
			end)
		else
			if StartMesh then
				TS:Create(StartMesh, TweenInformation, {
					Scale = EndMesh.Scale,
				}):Play()
			end

			if StartDecal then
				for _, randomVFX in pairs(StartPart:GetChildren()) do
					if randomVFX:IsA("Decal") then
						TS:Create(randomVFX, TweenInformation, {
							Transparency = GoalTransparency,
						}):Play()
					end
				end

				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size,
					CFrame = EndPart.CFrame,
				})

				Tween:Play()
			else
				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size,
					Transparency = GoalTransparency,
					CFrame = EndPart.CFrame,
				})

				Tween:Play()
			end
		end

		if not NoDelete then
			if ExtraLifetime then
				task.wait(ExtraLifetime + 0.1)
			end

			Tween.Completed:Connect(function()
				Model:Destroy()
			end)
		end
	end)
end

local function miniDebris(Parameters)
	task.spawn(function()
		-- Force defaults to MaximumRocks to preserve the original coupling, but
		-- can now be set independently so raising the count does not also
		-- multiply the launch speed.
		local Force = Parameters.Force or Parameters.MaximumRocks
		local AngleMin = Parameters.AngleMin or 25
		local AngleMax = Parameters.AngleMax or 30
		local Spread = Parameters.Spread or 25
		local Spin = Parameters.Spin or 25
		local LifeMin = Parameters.LifeMin or 4
		local LifeMax = Parameters.LifeMax or 6
		local SizeMult = Parameters.SizeMult or 1
		local FadeTime = Parameters.FadeTime or 1
		-- 0 = normal gravity, 0.5 = half. Higher makes the chips rise slowly and
		-- hang, rather than snapping up and dropping.
		local Float = math.clamp(Parameters.Float or 0, 0, 0.9)

		local flyRocksNumber = math.random(Parameters.MinimumRocks, Parameters.MaximumRocks * 1.15)

		if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
			flyRocksNumber /= 2
		end

		for i = 1, flyRocksNumber do
			local lifeTime = RandomSeed:NextNumber(LifeMin, LifeMax)

			local flyingDebris = Resources.Rocks.rockCircle.DefaultPart:Clone()
			flyingDebris.CFrame = Parameters.CFrame * CFrame.new(0, 0.25, 0)
			flyingDebris.Anchored = false
			flyingDebris.CollisionGroup = "NonPColDebri"
			flyingDebris.CanCollide = true
			flyingDebris.Material = Parameters.Material
			-- always assign, even when "" — the template can ship with a variant
			-- baked in, and skipping the write leaves it there
			flyingDebris.MaterialVariant = Parameters.MaterialVariant or ""
			flyingDebris.Color = Parameters.Color
			flyingDebris.Size = Vector3.new(0.5, 0.5, 0.5) * math.random(1, 2) * SizeMult
			flyingDebris.Parent = workspace.Terrain
			flyingDebris.AssemblyAngularVelocity = Vector3.new(RandomSeed:NextNumber(-Spin, Spin), RandomSeed:NextNumber(-Spin, Spin), RandomSeed:NextNumber(-Spin, Spin))
			flyingDebris.AssemblyLinearVelocity = (CFrame.Angles(0, 2 * math.pi * i/flyRocksNumber + math.rad(RandomSeed:NextNumber(-Spread, Spread)), 0) * CFrame.Angles(math.rad(RandomSeed:NextNumber(AngleMin, AngleMax)), 0, 0)).UpVector * (RandomSeed:NextNumber(Parameters.MinimumVelocity, Parameters.MaximumVelocity) * Force)

			if Float > 0 then
				local Lift = Instance.new("BodyForce")
				Lift.Force = Vector3.new(0, flyingDebris.AssemblyMass * workspace.Gravity * Float, 0)
				Lift.Parent = flyingDebris
				Debris:AddItem(Lift, lifeTime)
			end

			Debris:AddItem(flyingDebris, lifeTime + FadeTime)

			task.delay(lifeTime, function()
				TS:Create(flyingDebris, TweenInfo.new(FadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), { Size = Vector3.zero, Transparency = 1 }):Play()
			end)
		end
	end)
end


local function QuickFX(Parameters)
	local FX = Parameters.FX
	local AnchorPoint = Parameters.Anchor
	local Maid = Parameters.Maid

	FX = FX:Clone()

	if FX:IsA("Model") then
		FX:PivotTo(AnchorPoint)
	elseif FX:IsA("BasePart") then
		FX.CFrame = AnchorPoint
	end

	if FX:IsA("Attachment") then
		FX.Parent = AnchorPoint
	else
		FX.Parent = workspace.World.Debris
	end

	if Maid then
		Maid:Add(FX)
	else
		Debris:AddItem(FX, 30)
	end

	return FX
end

local function getRandomValue(min, max, isInteger, randomGenerator)
	local generator = randomGenerator or RandomSeed

	if not max and min then
		max = min
		min = 1
	end

	if not max and not min then
		min = 0
		max = 1
	end

	if not isInteger then
		return generator:NextNumber(min, max)
	else
		return generator:NextInteger(min, max)
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

local function getTouchingPartsExceptIgnored(object)
	if not object then
		return
	elseif object.ClassName == "Model" then
		return
	else
		local touchConnection = object.Touched:Connect(function() end)

		local touchingParts = object:GetTouchingParts()
		touchConnection:Disconnect()

		local validParts = {}
		for _, part in pairs(touchingParts) do
			if part.Name ~= "InvisibleBorder" and part.Name ~= "InfBall" then
				table.insert(validParts, part)
			end
		end

		return validParts
	end
end

local function playSoundWithAttachment(attachmentData)
	local sound = Instance.new("Sound")
	game:GetService("CollectionService"):AddTag(sound, "NewSound")

	local attachment = nil
	local soundEndedConnection = nil

	soundEndedConnection = sound.Ended:Connect(function()
		if sound then
			sound:Destroy()
		end
		if attachment then
			attachment:Destroy()
		end
		soundEndedConnection:Disconnect()
	end)

	if not attachmentData.RollOffMaxDistance then
		attachmentData.RollOffMaxDistance = 300
	end

	if attachmentData.CFrame then
		attachment = Instance.new("Attachment")
		attachment.Parent = workspace.Terrain
		attachment.WorldCFrame = attachmentData.CFrame
		attachmentData.Parent = attachment
	end

	attachmentData.CFrame = nil

	for key, value in pairs(attachmentData) do
		sound[key] = value
	end

	return sound, attachment
end

local function debrisSpawner(config)
	if not config.add then
		config.add = {}
	end

	local v278 = config.sizemult or 1
	local l_add_0 = config.add
	local v280 = Random.new(config.Seed or tick())
	local l_v89_0 = getRandomValue

	local function v284(v282, v283)
		return l_v89_0(v282, v283, nil, v280)
	end

	if config.amount then
		config.amount = math.floor(config.amount)
	end

	local v285 = l_add_0.less and 2.5 or 1
	local v286 = nil

	if config.ground.Name == "Tile" and not config.ground:GetAttribute("FakeStadium") and not config.notiles then
		v286 = shared.repfire("Break Model", {
			Tile = config.ground,
		})
	end

	local v287 = 3
	local v288 = 5
	local v289 = v280 or RandomSeed

	if not v288 and v287 then
		v288 = v287
		v287 = 1
	end

	if not v288 and not v287 then
		v287 = 0
		v288 = 1
	end

	local v290 = v289:NextNumber(v287, v288)

	if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
		v290 = v290 / 2
	end

	if config.nodebris then
		v290 = 0
	end

	for _ = 1, v290 do
		if not l_add_0.less then
			local v292 = 1
			local v293 = 3
			local v294 = v280 or RandomSeed

			if not v293 and v292 then
				v293 = v292
				v292 = 1
			end

			if not v293 and not v292 then
				v292 = 0
				v293 = 1
			end

			local v295 = v294:NextNumber(v292, v293)
			v292 = cleanupThrownObjects() or Instance.new("Part")
			v292.CollisionGroup = "NonPColDebri"
			v294 = config.cframe

			local l_Angles_0 = CFrame.Angles
			local v297 = -360
			local v298 = 360
			local v299 = v280 or RandomSeed

			if not v298 and v297 then
				v298 = v297
				v297 = 1
			end

			if not v298 and not v297 then
				v297 = 0
				v298 = 1
			end

			local v300 = math.rad((v299:NextNumber(v297, v298)))
			v298 = -360
			v299 = 360
			local v301 = v280 or RandomSeed

			if not v299 and v298 then
				v299 = v298
				v298 = 1
			end

			if not v299 and not v298 then
				v298 = 0
				v299 = 1
			end

			local v302 = math.rad((v301:NextNumber(v298, v299)))
			v299 = -360
			v301 = 360
			local v303 = v280 or RandomSeed

			if not v301 and v299 then
				v301 = v299
				v299 = 1
			end

			if not v301 and not v299 then
				v299 = 0
				v301 = 1
			end

			v292.CFrame = v294 * l_Angles_0(v300, v302, (math.rad((v303:NextNumber(v299, v301)))))
			v292.Size = Vector3.new(v295, v295, v295)
			v292.CanCollide = true
			v292.Anchored = false
			v292.Material = config.ground.Material
			v292.MaterialVariant = config.ground.MaterialVariant
			v292.Color = config.ground.Color
			v292.Transparency = config.ground.Transparency
			v292:SetAttribute("CanGoThroughCamera", true)
			v292.Transparency = config.ground.Transparency
			v292.Parent = workspace.World.Debris
			v293 = Instance.new("BodyVelocity")
			v293.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000, 0)
			v302 = -25
			v297 = 25
			v298 = v280 or RandomSeed

			if not v297 and v302 then
				v297 = v302
				v302 = 1
			end

			if not v297 and not v302 then
				v302 = 0
				v297 = 1
			end

			v300 = v298:NextNumber(v302, v297)
			v297 = 5
			v298 = 25
			v299 = v280 or RandomSeed

			if not v298 and v297 then
				v298 = v297
				v297 = 1
			end

			if not v298 and not v297 then
				v297 = 0
				v298 = 1
			end

			v293.Velocity = Vector3.new(v300, v299:NextNumber(v297, v298), v284(-25, 25)) * 2
			v293.Parent = v292
			game:GetService("Debris"):AddItem(v293, 0.15)
			v294 = delay
			v300 = 3
			v297 = 0
			v298 = 1
			v299 = v280 or RandomSeed

			if not v298 and v297 then
				v298 = v297
				v297 = 1
			end

			if not v298 and not v297 then
				v297 = 0
				v298 = 1
			end

			v294(v300 + v299:NextNumber(v297, v298), function()
				TS:Create(v292, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1,
					Size = v292.Size / 1.5,
				}):Play()

				delay(0.3, function()
					v292.Anchored = true
					v292.CanCollide = false
					v292.CFrame = CFrame.new(100000000, 100000000, 100000000)
					table.insert(dataTable, v292)
				end)
			end)
		else
			break
		end
	end

	v289 = 4

	local v304 = 7
	local v305 = v280 or RandomSeed

	if not v304 and v289 then
		v304 = v289
		v289 = 1
	end

	if not v304 and not v289 then
		v289 = 0
		v304 = 1
	end

	v287 = v305:NextNumber(v289, v304) / v285

	if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
		v287 = v287 / 2
	end

	if config.nodebris then
		v287 = 0
	end

	for _ = 1, v287 do
		local v307 = 0.6
		local v308 = 0.8
		local v309 = v280 or RandomSeed

		if not v308 and v307 then
			v308 = v307
			v307 = 1
		end

		if not v308 and not v307 then
			v307 = 0
			v308 = 1
		end

		v305 = v309:NextNumber(v307, v308)
		v307 = cleanupThrownObjects() or Instance.new("Part")
		v307.CFrame = config.cframe
		v308 = calculateCFrameBetweenVectors(v307.CFrame.UpVector, config.normal, (Vector3.new(0, 1, 0, 0)))
		v307.CFrame = v307.CFrame * (v308 * CFrame.Angles(1.5707963267948966, 0, 0))
		v307.CollisionGroup = "NonPColDebri"
		v307.Size = Vector3.new(v305, v305, v305)
		v307.CanCollide = true
		v307.Name = "SmallDebris"
		v307.Anchored = false
		v307.Material = config.ground.Material
		v307.MaterialVariant = config.ground.MaterialVariant
		v307.Color = config.ground.Color
		v307.Transparency = config.ground.Transparency
		v307:SetAttribute("CanGoThroughCamera", true)
		v307.Transparency = config.ground.Transparency
		v307.Parent = workspace.World.Debris
		v309 = Instance.new("BodyVelocity")
		v309.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)

		local v310 = -25
		local v311 = 25
		local v312 = v280 or RandomSeed

		if not v311 and v310 then
			v311 = v310
			v310 = 1
		end

		if not v311 and not v310 then
			v310 = 0
			v311 = 1
		end

		local v313 = v312:NextNumber(v310, v311)
		v311 = 5
		v312 = 25
		local v314 = v280 or RandomSeed

		if not v312 and v311 then
			v312 = v311
			v311 = 1
		end

		if not v312 and not v311 then
			v311 = 0
			v312 = 1
		end

		v309.Velocity = Vector3.new(v313, v314:NextNumber(v311, v312), v284(-25, 25)) * 2
		v309.Parent = v307
		game:GetService("Debris"):AddItem(v309, 0.15)
		local l_BodyAngularVelocity_0 = Instance.new("BodyAngularVelocity")
		l_BodyAngularVelocity_0.Parent = v307
		game:GetService("Debris"):AddItem(l_BodyAngularVelocity_0, 0.5)

		local l_delay_0 = delay
		v310 = 3
		v312 = 0
		v314 = 1
		local v317 = v280 or RandomSeed

		if not v314 and v312 then
			v314 = v312
			v312 = 1
		end

		if not v314 and not v312 then
			v312 = 0
			v314 = 1
		end

		l_delay_0(v310 + v317:NextNumber(v312, v314), function()
			TS:Create(v307, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1,
				Size = v307.Size / 1.5,
			}):Play()

			delay(0.3, function()
				l_BodyAngularVelocity_0:Destroy()
				v307.Anchored = true
				v307.CanCollide = false
				v307.CFrame = CFrame.new(100000000, 100000000, 100000000)
				table.insert(dataTable, v307)
			end)
		end)
	end

	v288 = {}
	v289 = 5
	v304 = 7

	if config.new then
		v289 = config.new[1]
		v304 = config.new[2]
	end

	v305 = CFrame.new(config.cframe.p)
	local v318 = (v289 + v304) / 2
	local v319 = config.amount or 16

	if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
		v319 = v319 / 2
	end

	v305 = v305 * calculateCFrameBetweenVectors(v305.UpVector, config.normal, (Vector3.new(0, 1, 0, 0)))
	local l_Angles_1 = CFrame.Angles
	local v321 = 0
	local v322 = -360
	local v323 = 360
	local v324 = v280 or RandomSeed

	if not v323 and v322 then
		v323 = v322
		v322 = 1
	end

	if not v323 and not v322 then
		v322 = 0
		v323 = 1
	end

	v305 = v305 * l_Angles_1(v321, math.rad((v324:NextNumber(v322, v323))), 0)
	v321 = CFrame.Angles
	local v325 = 0
	v323 = -16
	v324 = 16
	local v326 = v280 or RandomSeed

	if not v324 and v323 then
		v324 = v323
		v323 = 1
	end

	if not v324 and not v323 then
		v323 = 0
		v324 = 1
	end

	l_Angles_1 = v305 * v321(v325, math.rad((v326:NextNumber(v323, v324))), 0)
	v321 = true

	if v289 ~= 5 and v304 ~= 7 then
		config.Double = 2
	end

	for v327 = 1, v319 do
		for v328 = 1, config.Double or 1 do
			local l_v305_0 = v305

			if v328 > 1 then
				l_v305_0 = l_Angles_1
				v318 = v318 + 1
			end

			local v330 = math.sin((360 / v319 + 360 / v319 * v327) / 57.29577951308232)
			local v331 = math.cos((360 / v319 + 360 / v319 * v327) / 57.29577951308232)
			local v332 = l_v305_0 * CFrame.new(v318 * v330, 0, v318 * v331)
			local v333 = 0.2

			if config.Double then
				v333 = 0.35
			end

			local l_lookVector_0 = v332.lookVector
			local v335 = -v333
			local l_v333_0 = v333
			local l_v335_0 = v335
			local l_l_v333_0_0 = l_v333_0
			local v339 = v280 or RandomSeed

			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0
				l_v335_0 = 1
			end

			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0
				l_l_v333_0_0 = 1
			end

			v332 = v332 + l_lookVector_0 * v339:NextNumber(l_v335_0, l_l_v333_0_0)
			local v340 = cleanupThrownObjects() or Instance.new("Part")
			-- ring rocks can land on different ground than the crater centre (grass/stone
			-- boundaries), so sample the ground under THIS rock's spot, like RockHandler
			-- does per rock; fall back to the centre hit when the local ray misses
			local rockGround = performRaycast({
				orig = v332.Position + Vector3.new(0, 4, 0),
				dir = Vector3.new(0, -16, 0),
			}) or config.ground
			v340.Anchored = true
			v340.CanCollide = false
			v340.CanTouch = true
			v340.Material = rockGround.Material
			v340.MaterialVariant = rockGround.MaterialVariant
			v340.Color = rockGround.Color
			v340.CFrame = v332 * CFrame.fromEulerAnglesXYZ(0, (360 / v319 + 360 / v319 * v327) / 57.29577951308232, 0)

			l_lookVector_0 = v340.CFrame
			local l_Angles_2 = CFrame.Angles
			l_l_v333_0_0 = 6
			v339 = 42

			local v342 = v280 or RandomSeed

			if not v339 and l_l_v333_0_0 then
				v339 = l_l_v333_0_0
				l_l_v333_0_0 = 1
			end

			if not v339 and not l_l_v333_0_0 then
				l_l_v333_0_0 = 0
				v339 = 1
			end

			v340.CFrame = l_lookVector_0 * l_Angles_2(math.rad(-v342:NextNumber(l_l_v333_0_0, v339)), 0, 0)
			l_v335_0 = 2
			l_l_v333_0_0 = 5
			v339 = v280 or RandomSeed

			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0
				l_v335_0 = 1
			end

			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0
				l_l_v333_0_0 = 1
			end

			v335 = v339:NextNumber(l_v335_0, l_l_v333_0_0) * (v328 > 1 and 1.8 or config.Double and 1.35 or 1)
			l_v335_0 = 1.9
			l_l_v333_0_0 = 2.4
			v339 = v280 or RandomSeed

			if not l_l_v333_0_0 and l_v335_0 then
				l_l_v333_0_0 = l_v335_0
				l_v335_0 = 1
			end

			if not l_l_v333_0_0 and not l_v335_0 then
				l_v335_0 = 0
				l_l_v333_0_0 = 1
			end

			v340.Size = Vector3.new(v335, v339:NextNumber(l_v335_0, l_l_v333_0_0), v284(2, 6)) * v278
			v340.CFrame = v340.CFrame * CFrame.new(0, -(v340.Size.Y / 3 + v340.Size.Z / 3) / 3, 0)
			v340.Transparency = 1
			v340.Parent = workspace.World.Debris
			l_lookVector_0 = v340.CFrame
			l_Angles_2 = nil
			v335 = getTouchingPartsExceptIgnored(v340)
			l_v333_0 = {}
			l_v335_0 = nil
			l_l_v333_0_0 = nil

			for _, v344 in pairs(v335) do
				if
					not v344:IsDescendantOf(workspace.World.Live)
					and v344.Name ~= "invis"
					and v344.Parent ~= workspace.World.Debris
					-- unanchored parts are loose destruction chunks and World.Visuals holds
					-- client-only rocks (RockHandler etc.); neither is real ground, so they
					-- must not re-theme the crater ring or mark it as breakable
					and v344.Anchored
					and not v344:IsDescendantOf(workspace.World.Visuals)
				then
					if v344.Material ~= config.ground.Material then
						l_Angles_2 = v344
					end

					table.insert(l_v333_0, v344)
				end

				if v344 == config.ground then
					l_v335_0 = config.ground
				end

				if v344.Name == "Tile" then
					l_l_v333_0_0 = true
				end
			end

			v339 = v340.CFrame
			local v345 = CFrame.new(0, -3, -1.5)
			local l_Angles_3 = CFrame.Angles
			local v347 = -11
			local v348 = 11
			local v349 = v280 or RandomSeed

			if not v348 and v347 then
				v348 = v347
				v347 = 1
			end

			if not v348 and not v347 then
				v347 = 0
				v348 = 1
			end

			local v350 = math.rad((v349:NextNumber(v347, v348)))
			v348 = -11
			v349 = 11
			local v351 = v280 or RandomSeed

			if not v349 and v348 then
				v349 = v348
				v348 = 1
			end

			if not v349 and not v348 then
				v348 = 0
				v349 = 1
			end

			local v352 = math.rad((v351:NextNumber(v348, v349)))
			v349 = -11
			v351 = 11
			local v353 = v280 or RandomSeed

			if not v351 and v349 then
				v351 = v349
				v349 = 1
			end

			if not v351 and not v349 then
				v349 = 0
				v351 = 1
			end

			v340.CFrame = v339 * (v345 * l_Angles_3(v350, v352, (math.rad((v353:NextNumber(v349, v351))))))
			v340.Transparency = 0
			table.insert(v288, v340)
			v339 = true

			if #l_v333_0 ~= 0 then
				v339 = config.ground:GetAttribute("Breakable") or not config.ground.Anchored
			end

			v342 = config.angle

			if v342 then
				l_Angles_3 = config.anglecfr
				v350 = l_lookVector_0.Position
				v342 = math.deg(
					(
						math.acos(
							(
								l_Angles_3.LookVector:Dot(
									(Vector3.new(v350.X, l_Angles_3.p.Y, v350.Z) - l_Angles_3.p).unit
								)
							)
						)
					)
				) <= config.angle
			end

			if v339 or v342 then
				v340.Transparency = 1
			else
				-- rocks keep the appearance sampled from the ground ray (same as
				-- RockHandler); adopting a touching part's material re-themed the whole
				-- ring grey whenever the buried rocks poked into the foundation layer
				-- beneath the floor, so that behavior was removed
				v340.Transparency = rockGround.Transparency
			end

			if v340.Transparency >= 1 then
				v340.CanCollide = false
				v340.CanTouch = false
				v340.CanQuery = false
			else
				v340.CanCollide = true
			end

			if v340.Velocity.magnitude > 0 then
				v340.AssemblyLinearVelocity = Vector3.new()
				v340.AssemblyAngularVelocity = Vector3.new()
			end

			if v321 then
				v321 = false

				v345 = {
					--"rbxassetid://102266679899704",
					--"rbxassetid://108089015142253"
				}

				l_Angles_3 = {
					"rbxassetid://4307208601",
					"rbxassetid://4307207425",
					"rbxassetid://4307207693",
					"rbxassetid://4307205188",
					"rbxassetid://3778609188",
					"rbxassetid://3778608737",
					"rbxassetid://3744401196",
					"rbxassetid://4307204962",
				}

				v350 = {
					"rbxassetid://4307204696",
					"rbxassetid://4307204452",
				}

				if l_add_0.sounds and not config.nosound then
					v352 = 1

					if v286 then
						v352 = 2
					end

					v347 = playSoundWithAttachment
					v348 = {}
					v353 = #v350
					local v354 = nil
					local l_v82_1 = RandomSeed

					if not v354 and v353 then
						v354 = v353
						v353 = 1
					end

					if not v354 and not v353 then
						v353 = 0
						v354 = 1
					end

					v348.SoundId = v350[l_v82_1:NextInteger(v353, v354)]
					v348.Volume = 3.85 / v352
					v348.Parent = v340
					v347(v348):Play()
					v347 = playSoundWithAttachment
					v348 = {}
					v353 = #l_Angles_3
					v354 = nil
					l_v82_1 = RandomSeed

					if not v354 and v353 then
						v354 = v353
						v353 = 1
					end

					if not v354 and not v353 then
						v353 = 0
						v354 = 1
					end

					v348.SoundId = l_Angles_3[l_v82_1:NextInteger(v353, v354)]
					v348.Volume = 4.3 / v352
					v348.Parent = v340
					v347(v348):Play()
					v347 = playSoundWithAttachment
					v348 = {}
					v353 = #v345
					v354 = nil
					l_v82_1 = RandomSeed

					if not v354 and v353 then
						v354 = v353
						v353 = 1
					end

					if not v354 and not v353 then
						v353 = 0
						v354 = 1
					end

					v348.SoundId = v345[l_v82_1:NextInteger(v353, v354)]
					v348.Volume = 4.12 / v352
					v348.Parent = v340
					v347(v348):Play()
				end
			end

			v340:SetAttribute("OGCframe", l_lookVector_0)
			v345 = TS
			v350 = v340
			v352 = TweenInfo.new
			v348 = 0.2
			v349 = 0.3
			v351 = v280 or RandomSeed

			if not v349 and v348 then
				v349 = v348
				v348 = 1
			end

			if not v349 and not v348 then
				v348 = 0
				v349 = 1
			end

			v345:Create(v350, v352(v351:NextNumber(v348, v349), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = l_lookVector_0,
			}):Play()
			v345 = delay
			l_Angles_3 = l_add_0.keep

			if not l_Angles_3 then
				v350 = 5
				v352 = 7
				v347 = v280 or RandomSeed

				if not v352 and v350 then
					v352 = v350
					v350 = 1
				end

				if not v352 and not v350 then
					v350 = 0
					v352 = 1
				end

				l_Angles_3 = v347:NextNumber(v350, v352)
			end

			v345(l_Angles_3, function()
				if l_add_0.keep then
					TS:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						CFrame = l_lookVector_0,
						Size = v340.Size,
					}):Play()
					wait(2)
				end

				TS:Create(v340, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = v340.CFrame * CFrame.new(0, -7, 0),
					Size = v340.Size / 1.5,
				}):Play()

				wait(2)
				v340:SetAttribute("OGCframe", nil)
				v340.Anchored = true
				v340.CFrame = CFrame.new(100000000, 100000000, 100000000)

				table.insert(dataTable, v340)
			end)
		end
	end
	return v288
end

local ReplicationEffects = {
	smoothweld = function(Params)
		local Bind = Params.Bind
		local Character: Model = Params.Character
		local EnemyCharacter: Model = Params.EnemyCharacter
		local TweenTime: number = Params.TweenTime
		local EasingStyle = Params.EasingStyle or Enum.EasingStyle.Sine
		local EasingDirection = Params.EasingDirection or Enum.EasingDirection.Out
		local Offset: CFrame = Params.Offset

		local StartCFrame = EnemyCharacter:GetPivot()
		local StartTime = os.clock()

		local TweenTask = task.spawn(function()
			while
				Character ~= nil
				and Character.Parent ~= nil
				and EnemyCharacter ~= nil
				and EnemyCharacter.Parent ~= nil
				and Bind ~= nil
				and Bind.Parent ~= nil
			do
				EnemyCharacter:PivotTo(
					StartCFrame:Lerp(
						Character:GetPivot() * Offset,
						TS:GetValue((os.clock() - StartTime) / TweenTime, EasingStyle, EasingDirection)
					)
				)

				task.wait()
			end
		end)

		task.delay(TweenTime, function()
			pcall(function()
				task.cancel(TweenTask)
			end)
		end)
	end,

	velocityForward = function(params)
		local character = LocalPlayer.Character
		local humanoidRootPart = character.HumanoidRootPart

		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Name = "VelForwardBv"
		bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000, 0)
		bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * (params.Distance or 55)

		if params.StunCheck then
			bodyVelocity:SetAttribute("StunCheck", true)
		end

		if params.Up then
			bodyVelocity.Velocity += Vector3.new(0, params.Up, 0)
		end

		if params.HeadFirst then
			bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000, 0)
		end

		if params.Jetdive then
			task.spawn(function()
				local startTime = tick()
				repeat
					task.wait()
				until performRaycast({
					orig = humanoidRootPart.Position,
					dir = Vector3.new(0, -7, 0, 0),
				}) or tick() - startTime > 5

				local animModule = require(
					character.Client:FindFirstChild("AnimationPlayer")
						or character.Client:WaitForChild("AnimationPlayer")
				)

				local function playJetdiveAnim(animationId)
					return animModule.playAnimation(game.FindFirstChild(character, "Humanoid"), animationId)
				end

				bodyVelocity:Destroy()
				playJetdiveAnim(77765973186169):Play()
			end)
		end

		bodyVelocity.Parent = params.Alternate or humanoidRootPart
		game:GetService("Debris"):AddItem(bodyVelocity, params.Time or 0.15)

		return bodyVelocity
	end,
	clearVelocities = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
		end

		shared.clearVelocities(HumRP)
	end,
	
	zeroVelocities = function(Params)
		local Character: Model = Params.Char
		if Character then
			shared.zeroVelocities(Character.HumanoidRootPart)
		end
	end,

	Hitbox = function(Params)
		--print("HITBOX VIS →", Params.Method, typeof(Params.Size), Params.Size)
		for _, v in workspace.World.Debris:GetChildren() do
			if v.Name == LocalPlayer.UserId .. " Hitbox" then
				v:Destroy()
			end
		end

		local Visualizer
		if Params.Method == "Box" then
			Visualizer = Assets.HitboxTemplate:Clone()
			Visualizer.CFrame = Params.CFrame * (Params.Offset or CFrame.new(0, 0, 0))
			Visualizer.Size = Params.Size
		elseif Params.Method == "Sphere" or Params.Method == "Radius" then
			Visualizer = Assets.HitboxTemplateSphere:Clone()
			Visualizer.CFrame = Params.CFrame * (Params.Offset or CFrame.new(0, 0, 0))
			Visualizer.Size = Params.Size
		end

		Visualizer.Parent = workspace.World.Debris
		Debris:AddItem(Visualizer, 0.1)
	end,

	RemoveAllBodyMovers = function(Character: Model)
		for _, BodyMover: BodyVelocity in Character:GetDescendants() do
			if BodyMover:IsA("BodyVelocity") or BodyMover:IsA("LinearVelocity") or BodyMover:IsA("BodyPosition") then
				BodyMover:Destroy()
				print("RemovedBM")
			end
		end
	end,

	StayVelocity = function(Params)
		local Character = LocalPlayer.Character
		local HumRP = Character.HumanoidRootPart
		print("Stay")

		for _, v in pairs(HumRP:GetChildren()) do
			if v.Name == "VelForwardBv" then
				v:Destroy()
			end
		end

		local VelForwardBv = Instance.new("BodyVelocity")
		VelForwardBv.Name = "VelForwardBv"
		VelForwardBv.MaxForce = Vector3.new(40000, 40000, 40000, 0)
		VelForwardBv.Velocity = HumRP.CFrame.lookVector

		local RayParams = RaycastParams.new()
		RayParams.FilterType = Enum.RaycastFilterType.Exclude
		RayParams.FilterDescendantsInstances = {
			Character,
		}

		local MaxDistance = Params.MaxDistance or 50
		local function EvaluateTarget()
			local LiveCharacters = {}
			for _, GoalCharacter: Model in pairs(game.Workspace.World.Live:GetChildren()) do
				local GoalHumanoid = GoalCharacter:FindFirstChild("Humanoid")
				local GoalHumRP = GoalCharacter:FindFirstChild("HumanoidRootPart")

				if
					GoalCharacter ~= Character
					and GoalHumanoid
					and GoalHumRP
					and GoalHumanoid.Health > 0
					and (HumRP.Position - GoalHumRP.Position).Magnitude <= MaxDistance
				then
					table.insert(LiveCharacters, GoalCharacter)
				end
			end

			local FoundCharacter: Model
			local NextPos

			for _, GoalCharacter: Model in pairs(LiveCharacters) do
				local GoalHumRP = GoalCharacter:FindFirstChild("HumanoidRootPart")
				local LookVector = HumRP.CFrame.lookVector:Dot((GoalHumRP.Position - HumRP.Position).Unit)
				local IsBlocking = GoalCharacter:HasTag("Blocking")
				local HeadPos = (Character.Head.Position - GoalCharacter.Head.Position).Unit:Dot(
					GoalCharacter.Head.CFrame.lookVector
				)

				if not IsBlocking and not GoalCharacter:FindFirstChildOfClass("ForceField") and LookVector >= 0.75 then
					if not FoundCharacter then
						FoundCharacter = GoalCharacter
						NextPos = LookVector
					elseif NextPos < LookVector then
						FoundCharacter = GoalCharacter
						NextPos = LookVector
					end
				end
			end

			return FoundCharacter
		end

		VelForwardBv.Parent = Params.Alternate or HumRP

		local GoalPos
		local Target = EvaluateTarget()

		if Target then
			GoalPos = Target.PrimaryPart.Position
		else
			local RayCast = game.Workspace:Raycast(
				HumRP.Position,
				game.Workspace.CurrentCamera.CFrame.lookVector * MaxDistance * 2,
				RayParams
			)

			if RayCast then
				local RayPos = RayCast.Position
				local RootPos = HumRP.Position
				local GoalMagnitude = (RootPos - RayPos).magnitude

				if MaxDistance < GoalMagnitude then
					RayPos = RayPos:Lerp(RootPos, 1 - MaxDistance / GoalMagnitude)
				end

				GoalPos = RayPos
			else
				GoalPos = HumRP.CFrame * CFrame.new(0, 0, -MaxDistance).Position
			end
		end

		local NewRayCast = game.Workspace:Raycast(GoalPos, Vector3.new(0, -1000, 0, 0), RayParams)
		if NewRayCast then
			GoalPos = NewRayCast.Position
		end

		GoalPos = GoalPos + Vector3.new(0, HumRP.Size.Y * 1.5, 0)

		ComSet:FireServer("MonsterPosConfrim", { Pos = GoalPos })

		HumRP.CFrame = CFrame.new(HumRP.Position, GoalPos)

		task.delay(Params.Time or 0.3, function()
			local NumberValue = Instance.new("NumberValue")
			NumberValue.Value = 0
			game.Debris:AddItem(NumberValue, 1)

			game:GetService("TweenService")
				:Create(NumberValue, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
					Value = 1,
				})
				:Play()

			local startTick = tick()
			while tick() - startTick < 0.2 do
				local rx, ry, rz = HumRP.CFrame:ToOrientation()

				Character:PivotTo(HumRP.CFrame:lerp(CFrame.new(GoalPos) * CFrame.Angles(rx, ry, rz), NumberValue.Value))
				game:GetService("RunService").RenderStepped:Wait()
			end
		end)

		game:service("Debris"):AddItem(VelForwardBv, Params.Time or 0.25)

		return VelForwardBv
	end,
	
	M1HitHighlight = function(Params)
		local EnemyCharacter: Model = Params.EChar
		if not EnemyCharacter or not EnemyCharacter:FindFirstChild("HumanoidRootPart") then
			return
		end

		local Duration = Params.Duration or 0.35
		local FillColor = Params.Color or Color3.fromRGB(255, 255, 255)

		local Highlight = Instance.new("Highlight")
		Highlight.Adornee = EnemyCharacter
		Highlight.DepthMode = Enum.HighlightDepthMode.Occluded -- .AlwaysOnTop to show through walls
		Highlight.FillColor = FillColor
		Highlight.OutlineColor = FillColor
		Highlight.FillTransparency = Params.StartFill or 0.4 -- 0 = solid white, 1 = outline only
		Highlight.OutlineTransparency = 0
		Highlight.Parent = EnemyCharacter

		TS:Create(Highlight, TweenInfo.new(Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			FillTransparency = 1,
			OutlineTransparency = 1,
		}):Play()

		Debris:AddItem(Highlight, Duration)
	end,

	Ring = function(Params)
		local Resources = game.ReplicatedStorage.Resources
		local Ring = Resources.Misc.Ring:Clone()
		Ring.Parent = workspace.Thrown
		Ring.CFrame = Params.CF

		for Prop, Value in Params.FirstProps do
			if Ring[Prop] then
				Ring[Prop] = Value
			end
		end

		TS:Create(
			Ring,
			TweenInfo.new(
				Params.TN_Info.Time,
				Enum.EasingStyle[Params.TN_Info.Style],
				Enum.EasingDirection[Params.TN_Info.Direction]
			),
			Params.FinalProps
		):Play()
		Debris:AddItem(Ring, Params.LF or Params.TN_Info.Time)
	end,

	armTrailEffect = function(Params)
		local Resources = game.ReplicatedStorage.Resources

		local waterPalm = Resources.Effects.ArmTrailEffect:Clone()

		local lifeTime = Params.lifeTime

		if lifeTime then
			local limbName = Params and Params.limbName

			for i, v in next, Params.char:GetChildren() do
				if v:IsA("BasePart") then
					if v.Name == limbName then
						waterPalm.Parent = workspace.World.Visuals
						waterPalm.CFrame = v.CFrame

						local weld = Instance.new("Weld", waterPalm)

						weld.Part0 = waterPalm
						weld.Part1 = v
					end
				end
			end

			for i, v in next, waterPalm:GetDescendants() do
				if v:IsA("ParticleEmitter") then
					v.Enabled = true
				end

				if v:IsA("Trail") then
					v.Enabled = true
				end
			end

			task.delay(lifeTime, function()
				for i, v in next, waterPalm:GetDescendants() do
					if v:IsA("ParticleEmitter") then
						v.Enabled = false
					end

					if v:IsA("Trail") then
						BoatTween:Create(v, {
							Time = 0.55,
							EasingStyle = "EntranceExpressive",
							EasingDirection = "In",

							Reverses = false,
							DelayTime = 0,
							RepeatCount = 0,

							StepType = "Renderstepped",

							Goal = {
								Transparency = NumberSequence.new(1, 1),
							},
						}):Play()
					end
				end

				Debris:AddItem(waterPalm, 0.65)
			end)
		end
	end,

	RockTrail = function(args)
		local part = args.Part
		local settings = args.Settings
		local offset = args.Offset or Vector3.new(0, 0, 0)
		local direction = settings[1] or "Look"
		local duration = settings[2] or 1
		local size = settings[3] or 2
		local interval = settings[5] or 0.1
		local endTime = os.clock() + duration

		local function spawnRock(hit)
			local rock = Instance.new("Part")
			rock.Anchored = true
			rock.CanCollide = false
			rock.CanQuery = false
			rock.CanTouch = false
			rock.Material = hit.Material
			rock.MaterialVariant = hit.Instance.MaterialVariant
			rock.Color = hit.Instance.Color
			rock.Size = Vector3.zero
			rock.CFrame = CFrame.lookAt(hit.Position, hit.Position + hit.Normal)
				* CFrame.Angles(
					RandomSeed:NextNumber(-math.pi, math.pi),
					RandomSeed:NextNumber(-math.pi, math.pi),
					RandomSeed:NextNumber(-math.pi, math.pi)
				)
			rock.Parent = workspace.World.Debris

			local rockSize = RandomSeed:NextNumber(1.5, 1.5) * size

			local growTween = TS:Create(rock, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = Vector3.one * rockSize,
				CFrame = rock.CFrame * CFrame.new(0, rockSize / 2, 0),
			})
			growTween:Play()

			growTween.Completed:Once(function()
				task.wait(0.3)
				local shrinkTween =
					TS:Create(rock, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
						Size = Vector3.zero,
						Position = rock.Position + Vector3.new(0, -1, 0),
					})
				shrinkTween.Completed:Once(function()
					rock:Destroy()
				end)
				shrinkTween:Play()
			end)
		end

		local function spawnTrailSide()
			while true do
				local origin = part.CFrame * CFrame.new(offset) * CFrame.new(0, 2, 0)
				local hit = workspace:Raycast(origin.Position, Vector3.new(0, -25, 0), MapRayParams)

				if hit then
					task.spawn(spawnRock, hit)
				end

				task.wait(interval)
				if endTime <= os.clock() then
					return
				end
			end
		end

		task.spawn(spawnTrailSide)
	end,
	
	RockTrail2 = function(Params)
		local parent = Params.parent
		local size = Params.size
		local side = Params.side
		local Lifetime = Params.t
		local spawnrate = Params.spawnrate
		local duration = Params.duration

		local HumRP = parent.Parent:FindFirstChild("HumanoidRootPart")
		local GroundColor, SmokeStep = nil
		local LastSmoke = tick()
		local LastDebris = 0
		local DebrisRate = Params.debrisRate or 0
		local FastMode = LocalPlayer:GetAttribute("Fast_Mode")
		local SmokeRate = FastMode and 0.05 or 0.025
		local SmokeQuantity = FastMode and 1 or 2

		if HumRP then
			SmokeStep = RNS.RenderStepped:Connect(function()
				if GroundColor and tick() - LastSmoke >= SmokeRate then
					LastSmoke = tick()

					local SmokeEmitter = HumRP.BottomPart.Smoke.Smoke:Clone()
					SmokeEmitter.Parent = HumRP.BottomPart.Smoke
					SmokeEmitter.Name = ""
					SmokeEmitter.Color = ColorSequence.new(GroundColor)
					SmokeEmitter:Emit(SmokeQuantity)
					Debris:AddItem(SmokeEmitter, 2)
				end
			end)
		end

		for i = 1, duration/spawnrate do
			local HumRP = parent.Parent:FindFirstChild('HumanoidRootPart')

			local function rocknew(finalSide)
				local GroundRay = raycast(parent.Position, Vector3.new(0, -Params.height, 0), MapRayParams)
				if GroundRay then
					GroundColor = GroundRay.Instance.Color

					local GoalSize = Vector3.new(1, 1, 1) * RandomSeed:NextNumber(size / 1.5, size * 1.5)
					local SizeMagnitude = GoalSize.Magnitude

					local Rock = Resources.Rocks.RockTrail.Part:Clone()
					Rock.CFrame = CFrame.lookAlong(GroundRay.Position, parent.CFrame.LookVector) * CFrame.new(RandomSeed:NextNumber(finalSide / 1.5, finalSide * 1.5), 0, RandomSeed:NextNumber(-SizeMagnitude / 2, SizeMagnitude / 2))
					Rock.Orientation = Vector3.new(math.random(-180, 180), math.random(-180, 180), math.random(-180, 180))
					Rock.Color = GroundRay.Instance.Color
					Rock.Material = GroundRay.Material
					-- this map themes its floor with MaterialVariants, so Color
					-- alone comes back white — the variant is what carries the look
					Rock.MaterialVariant = GroundRay.Instance.MaterialVariant
					Rock.Reflectance = GroundRay.Instance.Reflectance
					Rock.Parent = workspace.Thrown
					Debris:AddItem(Rock, Lifetime + 0.5)

					TS:Create(Rock, TweenInfo.new(0.25), { Size = GoalSize }):Play()

					-- debrisRate throttles scatters to a fixed cadence, independent
					-- of how fast rocks are spawning. Without it, a tight spawnrate
					-- buries the screen in chips.
					if not Params.noDebris
						and SizeMagnitude >= (Params.debrisThreshold or 2)
						and tick() - LastDebris >= DebrisRate
					then
						LastDebris = tick()

						miniDebris({
							CFrame = CFrame.new(Rock.Position),
							Color = Rock.Color,
							Material = Rock.Material,
							MaterialVariant = Rock.MaterialVariant,
							MinimumRocks = Params.debrisMin or 1,
							MaximumRocks = Params.debrisMax or 3,
							MinimumVelocity = Params.debrisMinVel or 14,
							MaximumVelocity = Params.debrisMaxVel or 28,
							Force = Params.debrisForce,
							AngleMin = Params.debrisAngleMin,
							AngleMax = Params.debrisAngleMax,
							Spread = Params.debrisSpread,
							Spin = Params.debrisSpin,
							LifeMin = Params.debrisLifeMin,
							LifeMax = Params.debrisLifeMax,
							SizeMult = Params.debrisSize,
							FadeTime = Params.debrisFade,
							Float = Params.debrisFloat,
						})
					end

					task.delay(Lifetime, function()
						TS:Create(Rock, TweenInfo.new(0.5), { Size = Vector3.zero }):Play()
					end)

				else
					GroundColor = nil

				end
			end

			task.spawn(function()
				if side == 0 then
					rocknew(side)
				else
					rocknew(side)
					rocknew(-side)
				end
			end)

			task.wait(spawnrate)
		end

		if SmokeStep then
			SmokeStep:Disconnect()
		end
	end,

	DashMiss = function(Params)
		local PrimaryPart: BasePart = Params.PrimaryPart
		local YAngle = Params.YAngle or 0

		local GroundRay = raycast(PrimaryPart.Position, Vector3.new(0, -4, 0), MapRayParams)
		if not GroundRay then
			return
		end

		local SmokeBack = Resources.Effects.SmokeBack:Clone()
		SmokeBack.CFrame = PrimaryPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, YAngle, 0)
		SmokeBack.Parent = workspace.Thrown
		SmokeBack.SmokeBack.Smoke.Color = ColorSequence.new(GroundRay.Instance.Color)
		ParticlesModule.Emit(SmokeBack)
		Debris:AddItem(SmokeBack, 3)
	end,
	DashHit = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character.HumanoidRootPart

		local EnemyCharacter: Model = Params.EChar
		local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

		local MovesetName = LocalPlayer:GetAttribute("Moveset")

		local DashHit = Resources.Misc.DashHit:Clone()
		DashHit.CFrame = CFrame.lookAlong(Params.RootPart.Position, -Params.LookVector)
		DashHit.Parent = workspace.Thrown
		ParticlesModule.Emit(DashHit)
		Debris:AddItem(DashHit, 1)

		for i = 1, RandomSeed:NextInteger(2, 6) do
			local Shard = Instance.new("Part")
			Shard.Anchored = true
			Shard.CanCollide = false
			Shard.Material = Enum.Material.Neon
			Shard.Color = Color3.new(1, 1, 1)
			Shard.CanTouch = false
			Shard.Size = Vector3.new(0.15000000596046448, 0.15000000596046448, 3)
			Shard.CanQuery = false
			Shard.Transparency = 0.6

			local Mesh = Instance.new("SpecialMesh")
			Mesh.MeshType = "Sphere"
			Mesh.Parent = Shard

			Shard.CFrame = CFrame.lookAlong(
				(Params.RootPart.CFrame * CFrame.new(RandomSeed:NextNumber(-1, 1), RandomSeed:NextNumber(-1, 1), 0)).Position,
				-Params.LookVector
			)
			Shard.Parent = workspace.Thrown

			local ZSize = RandomSeed:NextNumber(10, 20)
			local TweenTime = RandomSeed:NextNumber(0.1, 0.15)
			local Lifetime = RandomSeed:NextNumber(0.2, 0.4)

			TS:Create(Shard, TweenInfo.new(TweenTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = Vector3.new(0.15, 0.15, ZSize - 2),
				CFrame = Shard.CFrame * CFrame.new(0, 0, ZSize / 2),
			}):Play()

			task.delay(TweenTime, function()
				TS:Create(Shard, TweenInfo.new(Lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = Vector3.new(0, 0, 0),
					CFrame = Shard.CFrame * CFrame.new(0, 0, ZSize / 2),
				}):Play()
			end)

			Debris:AddItem(Shard, Lifetime + TweenTime)
		end
	end,
	smokeEffect = function(Params)
		if Params.char then
			local Character = Params and Params.char

			local start = time()
			local fastModeEnabled = LocalPlayer:GetAttribute("Fast_Mode")

			task.spawn(function()
				while time() - start < Params.time do
					local params = RaycastParams.new()
					params.FilterType = Enum.RaycastFilterType.Include
					params.FilterDescendantsInstances = { workspace.World.Map }

					local BodySmokez = Resources.Effects.DashSmoke:Clone()
					BodySmokez.Parent = workspace.Thrown
					BodySmokez.Smoke.Enabled = true

					task.delay(0.07, function()
						if BodySmokez.Parent then
							BodySmokez.Smoke.Enabled = false
						end
					end)

					Debris:AddItem(BodySmokez, 5)

					local raycast = workspace:Raycast(Character.PrimaryPart.Position, Vector3.new(0, -5, 0), params)

					if raycast then
						BodySmokez.CFrame = Character.PrimaryPart.CFrame
						BodySmokez.Position = raycast.Position + Vector3.new(0, 0.1, 0)
						BodySmokez.Smoke.Color = ColorSequence.new(raycast.Instance.Color)
					end

					task.wait(0.1)
				end
			end)
		end
	end,

	destroyAmbient = function(Params)
		local CF: CFrame = Params.CFrame
		if typeof(CF) == "Instance" then
			CF = CF.CFrame * (Params.Offset or CFrame.new(0, 0, 0))
		end

		local Size: Vector3 = Params.Size
		local Burn = false
		local Velocity: Vector3 = Params.Velocity
		local LookAt: Vector3 = Params.LookAt
		local Multiplier = Params.Multiplier

		local function Destroy(Part: Part, WaitTime: number)
			table.insert(DestroyedParts, Part)

			local RealVelocity = Velocity
			if LookAt then
				local LookVector = -CFrame.lookAt(Part.Position, LookAt).LookVector
				RealVelocity = Vector3.new(LookVector.X * Velocity.X, Velocity.Y, LookVector.Z * Velocity.Z)
			end

			local Clone = Part:Clone()
			if
				Part:IsDescendantOf(workspace.World.Map.Destroyable.Buildings)
				and Clone.CanCollide == true
				and math.random(1, 2) == 1
			then
				Clone.CanCollide = true
			else
				Clone.CanCollide = false
			end
			CollectionService:RemoveTag(Clone, "WindShake")
			Clone.CanTouch = false
			Clone.CanQuery = false
			Clone.CollisionGroup = "NonPColDebri"
			Clone.Parent = workspace.World.Debris
			Clone.Anchored = false
			Clone.AssemblyAngularVelocity = Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
			Debris:AddItem(Clone, 5)

			local BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			BodyVelocity.Velocity = RealVelocity
			BodyVelocity.Parent = Clone
			Debris:AddItem(BodyVelocity, 0.1)

			task.delay(2.5, function()
				TS:Create(Clone, TweenInfo.new(2.5), { Size = Vector3.zero }):Play()
			end)

			Part.Transparency = 1
			Part.CanCollide = false
			Part.CanQuery = false

			task.delay(WaitTime or math.random(10, 18), function()
				TS:Create(Part, TweenInfo.new(1), { Transparency = 0 }):Play()
				if Part.Name ~= "Leaves" then
					Part.CanCollide = true
				end
				Part.CanQuery = true

				task.delay(1, function()
					local Index = table.find(DestroyedParts, Part)
					if Index then
						table.remove(DestroyedParts, Index)
					end
				end)
			end)
		end

		local PartsInBounds = Params.Parts or workspace:GetPartBoundsInBox(CF, Size, MapOverlapParams)
		if #PartsInBounds > 0 then
			for _, Part: Part in PartsInBounds do
				if Part and Part.Parent then
					if
						Part:IsDescendantOf(workspace.World.Map.Destroyable)
						and (not Params.CategoryOnly or Part:FindFirstAncestor(Params.CategoryOnly))
						and not table.find(DestroyedParts, Part)
					then
						if Part.Parent.Name == "Tree" then
							local WaitTime = math.random(10, 18)

							for _, TreePart in Part.Parent:GetChildren() do
								local Index = table.find(PartsInBounds, TreePart)
								if Index then
									table.remove(PartsInBounds, Index)
								end

								Destroy(TreePart, WaitTime)
							end
						else
							Destroy(Part)
						end
					end
				end
			end
		end
	end,

	SwordTrail = function(Params)
		local Part: BasePart = Params.Part
		local Trail = Part.Trail
		local Slash = Trail.Slash
		Slash.Enabled = true
		task.delay(Params.Lifetime, function()
			Slash.Enabled = false
		end)
	end,
	SwordEffect = function(Params)
		print("SwordEffect")
		local Part: BasePart = Params.MainPart
		local Attachment = Part.Attachment
		VFXFunctions.EmitDescendants(Attachment)
	end,
	
	Camshake = function(Params)
		if LocalConfigFolder:FindFirstChild("Camera Shake") and LocalConfigFolder["Camera Shake"].Value == false then
			return
		end

		if Params.Last then
			task.spawn(function()
				for _ = 1, Params.Last / 0.03 do
					local addshake = shared.addshake
					if addshake then
						addshake(Params.Intensity)
					end

					Params.Intensity = Params.Intensity * 0.9
					task.wait(0.03)
				end
			end)
			return
		else
			shared.addshake(Params.Intensity)
		end
	end,

	ShakeCamera = function(params)
		if LocalConfigFolder:FindFirstChild("Camera Shake") and LocalConfigFolder["Camera Shake"].Value == false then
			--print("returned")
			return
		end

		task.spawn(function()
			if params["Intensity"] ~= nil then
				if params.Last then
					--print("Intensity")
					local Intensity = params.Intensity

					for i = 1, params.Last / 0.03 do
						shared.addshake(Intensity)

						Intensity *= 0.9

						task.wait(0.03)
					end
				else
					shared.addshake(params.Intensity)
				end
			elseif params.Instance then
				shared.sustainshake(params.Instance, params.shakeTime, params.fadeOutTime)
			else
				if params.Preset then
					local Preset = CamShakePresets[params.Preset]
					assert(Preset, "The specified preset does not exist.")

					shared.addshake(Preset.Magnitude, Preset.Roughness, Preset.FadeInTime, Preset.FadeOutTime)
				else
					shared.addshake(params.Magnitude, params.Roughness, params.FadeInTime, params.FadeOutTime)
				end
			end
		end)
		--print("Shake")
	end,

	ApplySpin = function(Params)
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			print("angular")
			hrp.AssemblyAngularVelocity = Params.SpinVec
		end
	end,
	systemMessage = function(Params)
		if Params.Info.Color then
			local Color = Params.Info.Color

			Params.Info.Text = ('<font color="rgb(%s, %s, %s)">%s</font>'):format(
				math.floor(Color.R * 255),
				math.floor(Color.G * 255),
				math.floor(Color.B * 255),
				Params.Info.Text
			)
		end

		if Params.Info then
			local Info, TextValue =
				Params.Info.Text:gsub("\226\128\162 ", '<font color="rgb(255, 255, 255)">\226\128\162 </font>')
			Params.Info.Text = Info

			if TextValue > 0 then
			end
		end

		game.TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(Params.Info.Text)
	end,
	preloadanims = function(AnimationsList)
		local PreloadRig = workspace:WaitForChild("Preloader")
		local Animator = PreloadRig:WaitForChild("Humanoid"):WaitForChild("Animator")

		--for _, AnimationId in {
		--	139212625147266,
		--	110122816377050,
		--	77046991681714
		--	}
		--do
		--	local Animation = Instance.new("Animation")
		--	Animation.AnimationId = "rbxassetid://" .. AnimationId

		--	Animator:LoadAnimation(Animation)
		--	Animation:Destroy()
		--end

		for _, AnimationId in AnimationsList do
			local Animation = Instance.new("Animation")
			Animation.AnimationId = AnimationId

			Animator:LoadAnimation(Animation)
			Animation:Destroy()
		end

		for _, Animation: Animation in RS:GetDescendants() do
			if Animation:IsA("Animation") then
				Animator:LoadAnimation(Animation)
			end
		end

		Debris:AddItem(PreloadRig, 5)
	end,
	flyend = function(Params)
		LocalCharacter:SetAttribute("Flying", false)

		LocalCharacter:RemoveTag("Stunned")
		LocalCharacter:RemoveTag("Ragdolled")

		for _, bv in CollectionService:GetTagged("flybv" .. LocalPlayer.Name) do
			bv:Destroy()
		end

		local AnimationPlayer = require(LocalCharacter.Client.AnimationPlayer)
		for _, DirectionInfo in FlyAnimations do
			AnimationPlayer.playAnimation(LocalCharacter.Humanoid.Animator, DirectionInfo[3], true):Stop()
		end
	end,

	burncharacter = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
		if HumRP then
			SoundsModule:AddSound(Params.Sound, HumRP)
		end

		for _, Part in Character:GetChildren() do
			if Part.Name == "HumanoidRootPart" then
				continue
			end

			if Part:IsA("BasePart") then
				Part.Color = Color3.fromRGB(0, 0, 0)
				Assets.Effects.Misc.BurnSmoke:Clone().Parent = Part
			elseif Part:IsA("Accessory") then
				local Handle: Part? = Part:FindFirstChild("Handle")
				if Handle then
					Handle.Color = Color3.fromRGB(0, 0, 0)
				end
			elseif Part:IsA("Pants") or Part:IsA("Shirt") or Part:IsA("ShirtGraphic") then
				Part.Color3 = Color3.fromRGB(0, 0, 0)
			end
		end
	end,

	collisionWall = function(Params)
		local root = Params.root
		local rootCFrame = root.CFrame

		-- Don't process if too far from camera
		if (workspace.CurrentCamera.CFrame.p - rootCFrame.p).magnitude > 200 then
			return
		end

		local hitPart = nil
		local hitPosition = nil
		local hitMaterial = nil
		local hitNormal = nil

		local raycastDistance = 4
		local startTime = tick()

		repeat
			rootCFrame = root.CFrame

			if not Params.AccurateCheck then
				-- Check all 4 directions around the character
				local directions = {
					rootCFrame.lookVector * -raycastDistance,
					rootCFrame.lookVector * raycastDistance,
					rootCFrame.rightVector * raycastDistance,
					rootCFrame.rightVector * -raycastDistance,
				}

				for _, dir in ipairs(directions) do
					local part, position, material, normal = performRaycast({
						orig = rootCFrame.p,
						dir = dir,
						Whitelist = Params.OnlyCheck,
					})
					hitPart = part
					hitPosition = position
					hitMaterial = material
					hitNormal = normal
					if hitPart then
						break
					end
				end
			else
				-- Accurate velocity-based raycast
				local predictedPosition = root.Position + root.Velocity
				local part, position, material, normal = performRaycast({
					orig = root.Position,
					dir = (predictedPosition - root.Position).Unit
						* (math.clamp(root.Velocity.magnitude, 0, 1e999) / 5.2),
					Whitelist = Params.OnlyCheck,
				})
				hitPart = part
				hitPosition = position
				hitMaterial = material
				hitNormal = normal
			end

			-- Override with downward raycast if justdown flag is set
			if Params.justdown then
				local part, position, material, normal = performRaycast({
					Whitelist = Params.OnlyCheck,
					orig = rootCFrame.p,
					dir = Vector3.new(0, -38, 0),
				})
				hitPart = part
				hitPosition = position
				hitMaterial = material
				hitNormal = normal
			end

			if not hitPart then
				if Params.AccurateCheck then
					task.wait()
				else
					wait()
				end
			end
		until hitPart
			or tick() - startTime > (Params.Time or 2)
			or (root and root.Parent and root.Parent:FindFirstChild("RagdollCancel"))

		-- Abort if root is gone or ragdoll was cancelled
		if not root or not root.Parent or root.Parent:FindFirstChild("RagdollCancel") then
			return
		end

		if Params.stronger and typeof(Params.stronger) ~= "table" then
			Params.stronger = {}
		end

		if not hitPart then
			return
		end

		-- Camera shake for nearby players
		if Params.camshakecrep then
			for _, player in ipairs(Params.camshakecrep.people) do
				if player == game.Players.LocalPlayer.Character then
					shared.repfire("Camshake", {
						Intensity = Params.camshakecrep.Intensity,
						Last = Params.camshakecrep.Last,
					})
					break
				end
			end
		end

		local sizeMultiplier = 1

		
		

		if Params.NoCrater == "regularSmokeSmash" then
			local localCharacter = game.Players.LocalPlayer.Character
			if Params.hit == localCharacter or Params.caller == localCharacter then
				shared.repfire("Camshake", { Intensity = 7, Last = 0.35 })
			end

			shared.repfire("Ground Crater", {
				Seed = math.random(1, 2000000000),
				start = hitPosition + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -24, 0),
				amount = 6,
				size = 0.3,
				nosmoke = true,
				nosound = false,
			})

			shared.repfire("Ground Crater", {
				Seed = math.random(1, 2000000000),
				start = hitPosition + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -14, 0),
				amount = 6,
				sizemult = 1.65,
				size = 1.5,
				nosound = true,
			})

			shared
				.sfx({
					CFrame = CFrame.new(hitPosition + Vector3.new(0, 0.35, 0)),
					SoundId = "rbxassetid://110196339711288",
					Volume = 10,
				})
				:Play()

			--local explosionVfx = RS.Assets.Effects.Zoro.RegularAbilities.FirstAbility.Explosion:Clone()
			--explosionVfx.Parent = workspace.World.Debris
			--explosionVfx:SetPrimaryPartCFrame(CFrame.new(hitPosition) * CFrame.new(0, 1, 0))
			--utility.Debris(explosionVfx, 4)
			--utility.Emit(explosionVfx)
			--utility.vfxTween(explosionVfx.Ring,  TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			--utility.vfxTween(explosionVfx.Wind1, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			--utility.vfxTween(explosionVfx.Wind2, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
		end
		if Params.NoCrater == "SanjiExplosion" then
			local localCharacter = game.Players.LocalPlayer.Character
			if Params.hit == localCharacter or Params.caller == localCharacter then
				shared.repfire("Camshake", { Intensity = 7, Last = 0.35 })
			end

			shared.repfire("Ground Crater", {
				Seed = math.random(1, 2000000000),
				start = hitPosition + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -24, 0),
				amount = 6,
				size = 0.3,
				nosmoke = true,
				nosound = false,
			})

			shared.repfire("Ground Crater", {
				Seed = math.random(1, 2000000000),
				start = hitPosition + Vector3.new(0, 0.1, 0),
				["end"] = Vector3.new(0, -14, 0),
				amount = 6,
				sizemult = 1.65,
				size = 1.5,
				nosound = true,
			})

			shared
				.sfx({
					CFrame = CFrame.new(hitPosition + Vector3.new(0, 0.35, 0)),
					SoundId = "rbxassetid://110196339711288",
					Volume = 10,
				})
				:Play()

			local utility = require(RS.Modules.ClientEffects.EffectUtilities)
			local explosionVfx = RS.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Finisher.Explosion:Clone()
			explosionVfx.Parent = workspace.World.Debris
			explosionVfx:SetPrimaryPartCFrame(CFrame.new(hitPosition) * CFrame.new(0, 1, 0))
			utility.Debris(explosionVfx, 4)
			utility.Emit(explosionVfx)
			utility.vfxTween(explosionVfx.Ring, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			utility.vfxTween(explosionVfx.Wind1, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out))
			utility.vfxTween(explosionVfx.Wind2, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))
		end

		-- Early exits for specific NoCrater variants
		if Params.NoCrater == "bulletbarragecrater" or Params.NoCrater == "skysnatcher" then
			return
		end

		-- Smoke/crater effect for all other cases
		local zOffsetMin = -0.001
		local zOffsetMax = 0.001
		local zOffsetRandom = RandomSeed:NextNumber(zOffsetMin, zOffsetMax)

		-- Mark bench parts specially
		if hitPart.Parent.Name == "Bench" then
			hitPart:SetAttribute("LowTransparency", true)
			hitPart:SetAttribute("NoCrater", true)
		end

		-- Create attachment at the hit surface
		local smokeAttachment = Instance.new("Attachment")
		smokeAttachment.Parent = hitPart.Anchored and hitPart or workspace.Terrain
		smokeAttachment.WorldCFrame = CFrame.new(hitPosition)
			* calculateCFrameBetweenVectors(CFrame.new(hitPosition).UpVector, hitNormal, Vector3.new(0, 1, 0))

		local emitCount = RandomSeed:NextInteger(15, 17) / (LocalPlayer:GetAttribute("S_FastMode") and 2 or 1)
		local surfaceColor = workspace.Terrain == hitPart and Color3.fromRGB(227, 206, 157) or hitPart.Color

		-- Helper to configure and emit a smoke particle
		local function createSmoke(emitter, sizeScale, color, count)
			emitter.Parent = smokeAttachment
			emitter.Color = ColorSequence.new(color)

			if hitPart:GetAttribute("LowTransparency") then
				emitter.Transparency = LegacyReplication.Trans.Transparency
			end

			if not Params.NoCrater then
				if Params.stronger then
					shared.resizeparticle(emitter, sizeScale)
					emitter.ZOffset = emitter.ZOffset + zOffsetRandom
					emitter.Speed = NumberRange.new(
						emitter.Speed.Min * (4.5 - (Params.stronger.minus or 0)),
						emitter.Speed.Max * (4.5 - (Params.stronger.minus or 0))
					)
					emitter.Lifetime = NumberRange.new(emitter.Lifetime.Min * 2, emitter.Lifetime.Max * 2)
					emitter.RotSpeed = NumberRange.new(emitter.RotSpeed.Min * 0.35, emitter.RotSpeed.Max * 0.35)
				else
					shared.resizeparticle(emitter, 1.25)
				end

				if hitPart ~= workspace.Terrain then
					emitter:Emit(count)
				end
			end
		end

		-- Emit base smoke
		createSmoke(LegacyReplication.Smoke:Clone(), 4.2, surfaceColor, emitCount)

		-- Emit upward smoke if no crater suppression
		if not Params.NoCrater and not Params.NoUpSmoke then
			local upSmokeEmitter = Assets.Effects.Effects1.UpSmoke:Clone()
			local upEmitCount = RandomSeed:NextInteger(15, 17) / emitCount
			createSmoke(upSmokeEmitter, 8, surfaceColor, upEmitCount)
		end

		game:GetService("Debris"):AddItem(smokeAttachment, 8)

		-- Check for sand/snow surface
		local isSoftSurface = hitPart.Material == Enum.Material.Sand or hitPart.Material == Enum.Material.Snow

		-- Spawn debris/crater if not suppressed
		if not hitPart:GetAttribute("NoCrater") and not Params.NoCrater then
			if Params.stronger then
				Params.nosound = true
				local globalSoundList = nil
				if Params.GlobalSound and typeof(Params.GlobalSound) == "table" then
					globalSoundList = Params.GlobalSound
				end

				local impactSound = {
					SoundId = Params.stronger.sound or "rbxassetid://102044786532146",
					RollOffMaxDistance = 600,
					CFrame = CFrame.new(hitPosition),
					Volume = Params.stronger.volume or 10,
				}
				local impactSound2 = {
					SoundId = "rbxassetid://88100500796013",
					RollOffMaxDistance = 600,
					CFrame = CFrame.new(hitPosition),
					Volume = Params.stronger.volume2 or Params.stronger.volume or 10,
				}

				-- Play sounds locally if the local player is in the sound list
				if globalSoundList and table.find(globalSoundList, game.Players.LocalPlayer.Character) then
					for _, soundData in pairs({ impactSound2, impactSound }) do
						soundData.CFrame = nil
						soundData.Parent = game.Players.LocalPlayer.PlayerGui
						soundData.Volume = soundData.Volume / 2
					end
				end

				shared.sfx(impactSound):Play()
				shared.sfx(impactSound2):Play()

				if Params.camshake and table.find(Params.camshake, LocalPlayer.Name) then
					spawn(function()
						shared.repfire("Camshake", {
							Last = 1.2 * (Params.camshake[3] or 1),
							Intensity = 12 * (Params.camshake[3] or 1),
						})
					end)
				end
			end

			local debrisSizeMult = 1
			local debrisIterations = Params.stronger and 3 - (Params.stronger.minus or 0) or 1

			for i = 1, debrisIterations do
				debrisSpawner({
					ground = hitPart,
					cframe = CFrame.new(hitPosition),
					amount = (Params.amount or isSoftSurface and 7 or 10) / 1.25,
					normal = hitNormal,
					sand = isSoftSurface,
					add = { sounds = true },
					Seed = (Params.Seed or 0) + i,
					new = { 5 * sizeMultiplier, 5.5 * sizeMultiplier },
					sizemult = debrisSizeMult,
					nosound = Params.nosound,
				})

				if Params.stronger then
					sizeMultiplier = sizeMultiplier * 3
					debrisSizeMult = debrisSizeMult + 1.6
				end
			end
		end
	end,

	["Ground Crater"] = function(v898)
		if typeof(v898.start) == "Instance" then
			if v898.start:IsA("Attachment") then
				v898.start = v898.start.WorldPosition
			else
				v898.start = v898.start.Position
			end
		end
		local v16348 = Random.new(v898.Seed)
		local l_v89_4 = getRandomValue
		local function _(v16350, v16351)
			return l_v89_4(v16350, v16351, nil, v16348)
		end
		local v16353, v16354, _, v16356 = performRaycast({
			orig = v898.start,
			dir = v898["end"],
			Whitelist = {  workspace.World.Map.Destroyable.Map.Floor, workspace.World.Map["Indestructible Map"].IndestructableFloor},
		})
		if v898.Sound then
			v898.Sound.CFrame = CFrame.new(v16354)
			shared.sfx(v898.Sound):Play()
		end
		if v16353 then
			local v16357 = calculateCFrameBetweenVectors(CFrame.new(v16354).UpVector, v16356, (Vector3.new(0, 1, 0, 0)))
			local l_Attachment_15 = Instance.new("Attachment")
			l_Attachment_15.Parent = v16353
			if not v16353.Anchored then
				l_Attachment_15.Parent = workspace.Terrain
			end
			l_Attachment_15.WorldCFrame = CFrame.new(v16354) * v16357
			if not v898.nosmoke then
				local v16359 = 8
				if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
					v16359 = v16359 / 2
				end
				local v16360 = -0.001
				local v16361 = 0.001
				local v16362 = v16348 or RandomSeed
				if not v16361 and v16360 then
					v16361 = v16360
					v16360 = 1
				end
				if not v16361 and not v16360 then
					v16360 = 0
					v16361 = 1
				end
				local v16363 = v16362:NextNumber(v16360, v16361)
				v16360 = game.ReplicatedStorage.Assets.Effects.Effects1.Smoke:Clone()
				v16360.Parent = l_Attachment_15
				v16360.ZOffset = v16360.ZOffset + v16363
				v16360.Color = ColorSequence.new(v16353.Color)
				if v898.stronger then
					shared.resizeparticle(v16360, v898.stronger.size1 or 4.2)
					v16360.Speed = NumberRange.new(
						v16360.Speed.Min * (4.5 - (v898.stronger.minus or 0)),
						v16360.Speed.Max * (4.5 - (v898.stronger.minus or 0))
					)
					v16360.Lifetime = NumberRange.new(v16360.Lifetime.Min * 2, v16360.Lifetime.Max * 2)
					v16360.RotSpeed = NumberRange.new(v16360.RotSpeed.Min * 0.35, v16360.RotSpeed.Max * 0.35)
				else
					shared.resizeparticle(v16360, 1.25)
					if v898.CloserCircle then
						v16360.Speed = NumberRange.new(25, 50)
						shared.resizeparticle(v16360, 0.7)
						v16359 = v16359 / 1.5
					end
					if v898.Closerr then
						shared.resizeparticle(v16360, 0.55)
						v16360.Speed = NumberRange.new(7, 25)
					end
				end
				if not v898.NoCircleSmoke then
					v16360:Emit(v16359)
				end
				v16361 = 8
				if LocalConfigFolder:FindFirstChild("Fast Mode") and LocalConfigFolder["Fast Mode"].Value == true then
					v16361 = v16361 / 2
				end
				v16362 = game.ReplicatedStorage.Assets.Effects.Effects1.UpSmoke:Clone()
				v16362.Parent = l_Attachment_15
				v16362.ZOffset = v16362.ZOffset + v16363
				v16362.Color = ColorSequence.new(v16353.Color)
				if v898.stronger then
					shared.resizeparticle(v16362, v898.stronger.size2 or 4.2)
					v16362.Speed = v898.speed1
						or NumberRange.new(
							v16362.Speed.Min * (4.5 - (v898.stronger.minus or 0)),
							v16362.Speed.Max * (4.5 - (v898.stronger.minus or 0))
						)
					v16362.Lifetime = NumberRange.new(v16362.Lifetime.Min * 2, v16362.Lifetime.Max * 2)
					v16362.RotSpeed = NumberRange.new(v16362.RotSpeed.Min * 0.35, v16362.RotSpeed.Max * 0.35)
				else
					shared.resizeparticle(v16362, 1.25)
					if v898.Closerr then
						shared.resizeparticle(v16362, 0.3)
						v16361 = v16361 / 1.5
						v16362.Speed = NumberRange.new(20, 35)
					end
				end
				shared.resizeparticle(v16362, 1.25)
				if not v898.NoUpSmoke then
					v16362:Emit(v16361)
				end
			end
			game:GetService("Debris"):AddItem(l_Attachment_15, 9)
			local v16364 = false
			if not (v16353.Material ~= Enum.Material.Sand) or v16353.Material == Enum.Material.Snow then
				v16364 = true
			end
			if not v898.NoCrater2 then
				debrisSpawner({
					ground = v16353,
					cframe = CFrame.new(v16354),
					amount = (v898.amount or v16364 and 7 or 10) / 1.25,
					normal = v16356,
					sand = v16364 and true or nil,
					add = {
						sounds = true,
					},
					sizemult = v898.sizemult,
					new = {
						5 * (v898.size or 1),
						5.5 * (v898.size or 1),
					},
					nosound = v898.nosound,
					angle = v898.angle,
					anglecfr = v898.anglecfr,
					nodebris = v898.nodebris,
					notiles = v898.notiles,
					Seed = v898.Seed,
				})
			end
			return
		end
	end,

	["Rock Explosion"] = function(v898)
		local pos = v898.position
		if typeof(pos) == "Instance" then
			if pos:IsA("Attachment") then
				pos = pos.WorldPosition
			else
				pos = pos.Position
			end
		end

		local rng = Random.new(v898.Seed or tick())

		local count = v898.count or 20
		local minSpeed = v898.minSpeed or 30
		local maxSpeed = v898.maxSpeed or 80
		local minSize = v898.minSize or 0.3
		local maxSize = v898.maxSize or 1.2
		local lifetime = v898.lifetime or 3
		local spread = v898.spread or 1
		local upBias = v898.upwardBias or 0.3
		local color = v898.color or Color3.fromRGB(163, 162, 165)
		local material = v898.material or Enum.Material.SmoothPlastic

		for i = 1, count do
			local size = rng:NextNumber(minSize, maxSize)

			local theta = rng:NextNumber(0, 2 * math.pi)
			local phi = rng:NextNumber(spread > 0.5 and -math.pi or 0, math.pi) * spread
			local dir = Vector3.new(
				math.sin(phi) * math.cos(theta),
				math.abs(math.cos(phi)) + upBias,
				math.sin(phi) * math.sin(theta)
			).Unit

			local speed = rng:NextNumber(minSpeed, maxSpeed)

			local rotCF = CFrame.Angles(
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2)
			)

			local rock = cleanupThrownObjects() or Instance.new("Part")
			rock.Transparency = 0
			rock.Size = Vector3.new(size, size * rng:NextNumber(0.6, 1.4), size * rng:NextNumber(0.6, 1.4))
			rock.CFrame = CFrame.new(pos) * rotCF
			rock.Color = color
			rock.Material = material
			rock.CollisionGroup = "NonPColDebri"
			rock.CanCollide = true
			rock.Anchored = false
			rock.CanTouch = true
			rock.CanQuery = true
			rock.AssemblyLinearVelocity = Vector3.new()
			rock.AssemblyAngularVelocity = Vector3.new()
			rock:SetAttribute("CanGoThroughCamera", true)
			rock.Parent = workspace.World.Debris

			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(2e9, 2e9, 2e9)
			bv.Velocity = dir * speed
			bv.Parent = rock
			game:GetService("Debris"):AddItem(bv, 0.12)

			local bav = Instance.new("BodyAngularVelocity")
			bav.AngularVelocity = Vector3.new(rng:NextNumber(-15, 15), rng:NextNumber(-15, 15), rng:NextNumber(-15, 15))
			bav.MaxTorque = Vector3.new(2e9, 2e9, 2e9)
			bav.Parent = rock
			game:GetService("Debris"):AddItem(bav, 0.5)

			delay(lifetime + rng:NextNumber(0, 1), function()
				TS:Create(rock, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1,
					Size = rock.Size / 1.5,
				}):Play()

				delay(0.4, function()
					rock.Anchored = true
					rock.CanCollide = false
					rock.CFrame = CFrame.new(1e8, 1e8, 1e8)
					table.insert(dataTable, rock)
				end)
			end)
		end
	end,
	
	["Liberation Rock Explosion"] = function(v898)
		local pos = v898.position
		local rocks = v898.rocks
		if typeof(pos) == "Instance" then
			if pos:IsA("Attachment") then
				pos = pos.WorldPosition
			else
				pos = pos.Position
			end
		end

		local rng = Random.new(v898.Seed or tick())

		local count = v898.count or 20
		local minSpeed = v898.minSpeed or 30
		local maxSpeed = v898.maxSpeed or 80
		local minSize = v898.minSize or 0.3
		local maxSize = v898.maxSize or 1.2
		local lifetime = v898.lifetime or 3
		local spread = v898.spread or 1
		local upBias = v898.upwardBias or 0.3
		local color = v898.color or Color3.fromRGB(163, 162, 165)
		local material = v898.material or Enum.Material.SmoothPlastic

		for i = 1, count do
			local size = rng:NextNumber(minSize, maxSize)

			local theta = rng:NextNumber(0, 2 * math.pi)
			local phi = rng:NextNumber(spread > 0.5 and -math.pi or 0, math.pi) * spread
			local dir = Vector3.new(
				math.sin(phi) * math.cos(theta),
				math.abs(math.cos(phi)) + upBias,
				math.sin(phi) * math.sin(theta)
			).Unit

			local speed = rng:NextNumber(minSpeed, maxSpeed)

			local rotCF = CFrame.Angles(
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2),
				rng:NextNumber(0, math.pi * 2)
			)

			local rock = cleanupThrownObjects() or Instance.new("Part")
			rock.Transparency = 0
			rock.Size = Vector3.new(size, size * rng:NextNumber(0.6, 1.4), size * rng:NextNumber(0.6, 1.4))
			rock.CFrame = CFrame.new(pos) * rotCF
			
			local pick = rocks and rocks[i]
			rock.Color = pick and pick.Color or color
			rock.Material = pick and pick.Material or material
			rock.MaterialVariant = pick and pick.MaterialVariant or "" -- clears any stale 
			
			rock.CollisionGroup = "NonPColDebri"
			rock.CanCollide = true
			rock.Anchored = false
			rock.CanTouch = true
			rock.CanQuery = true
			rock.AssemblyLinearVelocity = Vector3.new()
			rock.AssemblyAngularVelocity = Vector3.new()
			rock:SetAttribute("CanGoThroughCamera", true)
			rock.Parent = workspace.World.Debris

			local bv = Instance.new("BodyVelocity")
			bv.MaxForce = Vector3.new(2e9, 2e9, 2e9)
			bv.Velocity = dir * speed
			bv.Parent = rock
			game:GetService("Debris"):AddItem(bv, 0.12)

			local bav = Instance.new("BodyAngularVelocity")
			bav.AngularVelocity = Vector3.new(rng:NextNumber(-15, 15), rng:NextNumber(-15, 15), rng:NextNumber(-15, 15))
			bav.MaxTorque = Vector3.new(2e9, 2e9, 2e9)
			bav.Parent = rock
			game:GetService("Debris"):AddItem(bav, 0.5)

			delay(lifetime + rng:NextNumber(0, 1), function()
				TS:Create(rock, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Transparency = 1,
					Size = rock.Size / 1.5,
				}):Play()

				delay(0.4, function()
					rock.Anchored = true
					rock.CanCollide = false
					rock.CFrame = CFrame.new(1e8, 1e8, 1e8)
					table.insert(dataTable, rock)
				end)
			end)
		end
	end,
	

	
	HammerHeelAir = function(Params)
		local Character: Model = Params.Char
		local HumRP: BasePart
		if Character then
			HumRP = Character.HumanoidRootPart
		end

		local Stage = Params.Stage

		local AssetsFolder = Assets.Effects.Neon.ModeAbilities.ThirdAbility.SpinMoveVfx
		local RootFX = AssetsFolder.RootFX
		local ThrownFolder = workspace.World.Debris
		local UtilityModule = require(RS.Modules.ClientEffects.EffectUtilities)

		if Stage == "Throw" then
			local ThrowStuff = AssetsFolder.ThrowStuff:Clone()
			local Start = ThrowStuff.Distortion.Start

			for _, v28774 in pairs({
				Start,
				}) do
				local IsNotDistortion = tostring(v28774.Parent) ~= "Distortion"

				local RedHighlight = Instance.new("Highlight")
				RedHighlight.FillColor = Color3.fromRGB(255, 0, 0)
				RedHighlight.FillTransparency = 1
				RedHighlight.OutlineTransparency = 1
				RedHighlight.OutlineColor = Color3.fromRGB(0, 0, 0)
				RedHighlight.DepthMode = IsNotDistortion and Enum.HighlightDepthMode.Occluded
					or Enum.HighlightDepthMode.AlwaysOnTop
			end

			ThrowStuff:SetPrimaryPartCFrame(
				CFrame.new(
					HumRP.Position
						+ HumRP.CFrame.LookVector * -7.27847672
						+ Vector3.new(0.683349609375, -6.011728286743164, 0, 0),
					HumRP.Position
						+ HumRP.CFrame.LookVector * -7.27847672
						+ Vector3.new(0.683349609375, -6.011728286743164, 0, 0)
						+ HumRP.CFrame.LookVector
				)
					* CFrame.new(0, 4, -15)
					* CFrame.Angles(-1.3962634015954636, 0, 0)
			)
			ThrowStuff.Parent = workspace.World.Debris

			UtilityModule.Debris(ThrowStuff, 2)
			UtilityModule.Emit(ThrowStuff)
			UtilityModule.vfxTween(
				ThrowStuff.Rings1,
				TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(
				ThrowStuff.Rings2,
				TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(
				ThrowStuff.Distortion,
				TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(
				ThrowStuff.Shockwave,
				TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(ThrowStuff.Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			UtilityModule.vfxTween(
				ThrowStuff.Wind1,
				TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(
				ThrowStuff.Wind2,
				TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
			)
			UtilityModule.vfxTween(
				ThrowStuff.WindDecal2,
				TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			)
		elseif Stage == "HitOne" then
			local EnemyHumRP = Params.Target.PrimaryPart
			local HitFX = RootFX.Hit:Clone()

			HitFX.Parent = EnemyHumRP
			UtilityModule.Debris(HitFX, 3)
			UtilityModule.Emit(HitFX)
		elseif Stage == "HitSec" then
			local Torso = Params.Target.Torso

			local Trails = RootFX.Trails:Clone()
			Trails.Parent = Torso

			task.delay(1.5, function()
				UtilityModule.ToggleVFX(Trails, false)
			end)
			UtilityModule.Debris(Trails, 2)

			local HitFX = AssetsFolder.HitFX:Clone()
			HitFX.Parent = ThrownFolder

			for _, v in pairs(HitFX:GetDescendants()) do
				if v:IsA("Part") then
					v.CFrame = HumRP.CFrame * v:GetAttribute("Offset")
				end
			end

			UtilityModule.Debris(HitFX, 2)
			UtilityModule.Emit(HitFX)
			UtilityModule.vfxTween(
				HitFX.WindDecal,
				TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			)

			local Spin = RootFX.Spin:Clone()
			Spin.Parent = HumRP
			UtilityModule.Debris(Spin, 2.35)
			UtilityModule.Emit(Spin)

			task.delay(0.267, function()
				local Grab = RootFX.Grab:Clone()
				Grab.Parent = HumRP

				UtilityModule.Debris(Grab, 2)
				UtilityModule.Emit(Grab)
			end)

			task.delay(0.45, function()
				for v28793 = 0, 4 do
					task.delay(0.2 * v28793, function()
						local WindSpin = AssetsFolder.WindSpin:Clone()
						WindSpin.Parent = workspace.World.Debris

						local rx, ry, rz = WindSpin:GetPivot():ToOrientation()
						WindSpin:PivotTo(HumRP.CFrame * CFrame.Angles(rx, ry, rz))
						WindSpin:PivotTo(
							WindSpin:GetPivot()
								* CFrame.Angles(0, math.random(-3.141592653589793, 3.141592653589793), 0)
						)

						UtilityModule.Debris(WindSpin, 0.25)
						UtilityModule.vfxTween(
							WindSpin,
							TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						)

						local WindSpin2 = AssetsFolder.WindSpin2:Clone()
						WindSpin2.Parent = workspace.World.Debris
						WindSpin2:PivotTo(HumRP.CFrame * CFrame.Angles(rx, ry, rz))
						WindSpin2:PivotTo(
							WindSpin2:GetPivot()
								* CFrame.Angles(0, math.random(-3.141592653589793, 3.141592653589793), 0)
						)

						UtilityModule.Debris(WindSpin2, 0.25)
						UtilityModule.vfxTween(
							WindSpin2,
							TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
						)
					end)
				end
			end)

			task.delay(1.033, function()
				local StartFX = RootFX.Start:Clone()
				StartFX.Parent = HumRP

				UtilityModule.Debris(StartFX, 2)
				UtilityModule.Emit(StartFX)

				local SpinBeam = AssetsFolder.SpinBeam:Clone()
				SpinBeam.Parent = workspace.World.Debris
				UtilityModule.Debris(SpinBeam, 0.5)

				local v28819 = 20
				local v28820 = 0.5

				task.spawn(function()
					local HeartbeatConnection: RBXScriptConnection
					HeartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function(v28823)
						if not SpinBeam or SpinBeam and not SpinBeam.Parent then
							return HeartbeatConnection:Disconnect()
						else
							SpinBeam.CFrame = SpinBeam.CFrame * CFrame.Angles(0, math.rad(v28819 * v28823 * 100), 0)

							return
						end
					end)

					task.delay(v28820, function()
						HeartbeatConnection:Disconnect()
					end)
				end)

				local DelayTimer = 0.1
				local DelayTimerTwo = 0.3
				local DelayTimerThree = 0.1

				task.spawn(function()
					for _, v in pairs(SpinBeam:GetDescendants()) do
						if v:IsA("Beam") and v:GetAttribute("Play") == true then
							local Width0 = v.Width0
							local Width1 = v.Width1

							v.Width0 = 0
							v.Width1 = 0
							v.Enabled = true

							DelayTimer = DelayTimer * math.random(75, 125) / 100
							DelayTimerTwo = DelayTimerTwo * math.random(75, 125) / 100

							UtilityModule.Tween(
								v,
								TweenInfo.new(DelayTimer, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
								{
									Width0 = Width0,
									Width1 = Width1,
								}
							)

							task.delay(DelayTimer + DelayTimerThree, function()
								UtilityModule.Tween(v, TweenInfo.new(DelayTimerTwo, Enum.EasingStyle.Linear), {
									Width0 = 0,
									Width1 = 0,
								})

								task.delay(DelayTimerTwo, function()
									v.Enabled = false
								end)
							end)
						end
					end
				end)

				local CreateHighlight = UtilityModule.Highlight(Character, {
					FillColor = Color3.fromRGB(255, 25, 25),
					OutlineTransparency = 1,
				})

				UtilityModule.Debris(CreateHighlight, 0.5)
				UtilityModule.Tween(
					CreateHighlight,
					TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{
						FillTransparency = 1,
						FillColor = Color3.fromRGB(0, 0, 0),
					}
				)
			end)
		elseif Stage == "Trails" then
			local TrailsVfx = RootFX.Trails:Clone()
			TrailsVfx.Parent = Character["Right Arm"]

			task.delay(1.275, function()
				UtilityModule.ToggleVFX(TrailsVfx, false)
			end)

			UtilityModule.Debris(TrailsVfx, 1.4249999999999998)

			local LeftTrails = RootFX.Trails:Clone()
			LeftTrails.Parent = Character["Left Arm"]

			task.delay(1.275, function()
				UtilityModule.ToggleVFX(LeftTrails, false)
			end)

			UtilityModule.Debris(LeftTrails, 1.4249999999999998)

			local RightTrails = RootFX.Trails:Clone()
			RightTrails.Parent = Character["Right Leg"]

			task.delay(1.275, function()
				UtilityModule.ToggleVFX(RightTrails, false)
			end)

			UtilityModule.Debris(RightTrails, 1.4249999999999998)

			local TrailsFX = RootFX.Trails:Clone()
			TrailsFX.Parent = Character["Left Leg"]

			task.delay(1.275, function()
				UtilityModule.ToggleVFX(TrailsFX, false)
			end)

			UtilityModule.Debris(TrailsFX, 1.4249999999999998)
		end
	end,

	
	
	trashcanFloorHit = function(Params)
		local SoundAssets = RS.Assets.Sounds

		local ThrowableObject = Params[1]
		local ThrowableOwner = Params[2]
		local Root = (ThrowableObject:IsA("Model") and ThrowableObject.PrimaryPart) or ThrowableObject
		if not Root then return end

		if LocalPlayer == ThrowableOwner and LocalCharacter.PrimaryPart then
			local BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.MaxForce = Vector3.new(math.huge, 0, math.huge)
			BodyVelocity.Velocity = LocalCharacter.PrimaryPart.CFrame.LookVector * 125 + Vector3.new(0, 225, 0)
			BodyVelocity.Parent = Root
			Debris:AddItem(BodyVelocity, 0.1)
		end

		local raycastStep
		raycastStep = RNS.RenderStepped:Connect(function()
			if not Root or not Root.Parent then
				raycastStep:Disconnect()
				raycastStep = nil
			elseif raycast(Root.Position, Vector3.new(0, -Root.Size.Y/2 - 1, 0), MapRayParams) then
				raycastStep:Disconnect()
				raycastStep = nil
				SoundsModule:AddSound(SoundAssets.TrashFloor, Root)
			end
		end)
	end,

	GatlingGun = function(Params)
		local localRate = Params.Rate
		local duration = Params.Duration
		local originCharacter = Params.Character

		local humanoid = originCharacter:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = originCharacter:FindFirstChild("HumanoidRootPart")
		local torso = originCharacter:FindFirstChild("Torso")

		if humanoid and humanoid.Health > 0 then
			--originCharacter["Left Arm"].Transparency = 1
			--originCharacter["Right Arm"].Transparency = 1
			local BarrageFX = Assets.Effects.Luffy.Move1.GatlingEffects:Clone()
			BarrageFX.Parent = workspace.World.Debris
			BarrageFX.CFrame = humanoidRootPart.CFrame

			local BarrageFXFloor = Assets.Effects.Luffy.Move1.GatlingEffectsGround:Clone()
			BarrageFXFloor.Parent = workspace.World.Debris
			BarrageFXFloor.CFrame = humanoidRootPart.CFrame * CFrame.new(0, 0, -5)

			ParticlesModule.Enabled(BarrageFX, true)
			ParticlesModule.Enabled(BarrageFXFloor, true)

			task.spawn(function()
				local startTime = os.clock()
				while os.clock() - startTime <= duration do
					if not humanoid or humanoid.Health <= 0 then
						break
					end

					task.spawn(function()
						for i = 1, 2 do
							local armClone =
								Assets.Effects.Luffy.Move1.Gatling:FindFirstChild("LuffyArm" .. i + 2):Clone()
							local primaryPart = armClone.PrimaryPart

							task.delay(0.13, function()
								if armClone then
									armClone:Destroy()
								end
							end)

							armClone.Parent = workspace.World.Visuals
							local num = math.random(-3, 0)

							primaryPart.CFrame = humanoidRootPart.CFrame
								* CFrame.new(0, 0, num)
								* CFrame.Angles(math.rad(math.random(-15, 15)), 0, math.rad(math.random(-300, 300)))

							--local tween = TS:Create(armClone:FindFirstChildOfClass("MeshPart"), TweenInfo.new(0.18, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
							--Transparency = .5
							--}):Play()
							local options = { 0, 2 }
							local randNum = options[math.random(1, 2)]
							local animation = armClone.AnimationController:LoadAnimation(
								Assets.Animations.Luffy.FirstMove.GatlingNewMiddle:FindFirstChild(
									"GatlingArms" .. tostring(i + randNum)
								)
							)
							animation:Play(0)
						end
					end)
					task.spawn(function()
						for i = 1, 2 do
							local armClone =
								Assets.Effects.Luffy.Move1.Gatling:FindFirstChild("LuffyArm1LongerV2"):Clone()
							local primaryPart = armClone.PrimaryPart

							task.delay(0.2, function()
								if armClone then
									armClone:Destroy()
								end
							end)
							armClone.Parent = workspace.World.Visuals
							local randomLoc = math.random(-3.5, 1.5)
							primaryPart.CFrame = humanoidRootPart.CFrame
								* CFrame.Angles(0, 0, math.rad(math.random(-55, 55)))
								* CFrame.new(1, 0, randomLoc) --  -30,55
							--primaryPart.CFrame = humanoidRootPart.CFrame  * CFrame.Angles(math.rad(math.random(-15,15)), 0, 0)  --  -30,55

							--local tween = TS:Create(armClone:FindFirstChildOfClass("MeshPart"), TweenInfo.new(0.26, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
							--Transparency = 1
							--}):Play()

							--local offset = (i - 1) * 3
							local randomNum = math.random(1, 6)

							local animation = armClone.AnimationController:LoadAnimation(
								Assets.Animations.Luffy.FirstMove.GatlingNewRight:FindFirstChild(
									"GatlingArmsLongerNew" .. tostring(randomNum)
								)
							)
							animation:Play()
							animation:AdjustSpeed(1.5)
						end
					end)

					task.spawn(function()
						for i = 1, 2 do
							local armClone =
								Assets.Effects.Luffy.Move1.Gatling:FindFirstChild("LuffyArm1LongerV2"):Clone()
							local primaryPart = armClone.PrimaryPart

							task.delay(0.2, function()
								if armClone then
									armClone:Destroy()
								end
							end)
							armClone.Parent = workspace.World.Visuals
							local randomLoc = math.random(-3.5, 1.5)
							primaryPart.CFrame = humanoidRootPart.CFrame
								* CFrame.Angles(0, 0, math.rad(180))
								* CFrame.Angles(0, 0, math.rad(math.random(-55, 55)))
								* CFrame.new(1, 0, randomLoc) --  -30,55
							--primaryPart.CFrame = humanoidRootPart.CFrame  * CFrame.Angles(math.rad(math.random(-15,15)), 0, 0)  --  -30,55

							--local tween = TS:Create(armClone:FindFirstChildOfClass("MeshPart"), TweenInfo.new(0.26, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
							--Transparency = 1
							--}):Play()

							--local offset = (i - 1) * 3
							local randomNum = math.random(1, 6)

							local animation = armClone.AnimationController:LoadAnimation(
								Assets.Animations.Luffy.FirstMove.GatlingNewRight:FindFirstChild(
									"GatlingArmsLongerNew" .. tostring(randomNum)
								)
							)
							animation:Play(0)
							animation:AdjustSpeed(1.5)
						end
					end)

					task.wait(localRate)
				end

				--originCharacter["Left Arm"].Transparency = 0
				--originCharacter["Right Arm"].Transparency = 0
				ParticlesModule.Enabled(BarrageFX, false)
				Debris:AddItem(BarrageFX, 2.5)

				ParticlesModule.Enabled(BarrageFXFloor, false)
				Debris:AddItem(BarrageFXFloor, 2.5)
			end)
		end
	end,	
}

CollectionService:GetInstanceAddedSignal("SmallDebris"):connect(function(debrisInstance)
	local debrisTimerAttr = debrisInstance:GetAttribute("timern")
	local hitHRP = debrisInstance.Parent:FindFirstChild("HumanoidRootPart")
	local localPlayerHRP = LocalPlayer.Character

	local function spawnDebrisAt(hitInstance, materialEnum, positionVector)
		if
			(hitInstance.Parent.Name == "Rock1" or hitInstance.Parent.Name == "Rock2")
			and hitInstance.Parent.Parent.Name == "AdjustedHB"
		then
			return
		else
			local debrisPart = cleanupThrownObjects() or Instance.new("Part")
			local partColor = hitInstance.Color
			local partVariant = hitInstance.MaterialVariant
			local partReflectance = hitInstance.Reflectance

			if hitInstance:IsA("Terrain") then
				partColor = workspace.Terrain:GetMaterialColor(materialEnum)
				partVariant = ""
				partReflectance = 0
			end

			debrisPart.Name = "Debris"
			debrisPart.Anchored = true
			debrisPart.CanCollide = false
			debrisPart.CastShadow = false
			debrisPart.Transparency = 1
			debrisPart.CollisionGroup = "NotTouchableVisualDestruction"

			local sizeMin = 0.75
			local sizeMax = 1
			local rngRefA = RandomSeed

			if not sizeMax and sizeMin then
				sizeMax = sizeMin
				sizeMin = 1
			end

			if not sizeMax and not sizeMin then
				sizeMin = 0
				sizeMax = 1
			end

			local sizeX = rngRefA:NextNumber(sizeMin, sizeMax)
			sizeMax = 0.75
			rngRefA = 1

			local rngRefB = RandomSeed
			if not rngRefA and sizeMax then
				rngRefA = sizeMax
				sizeMax = 1
			end

			if not rngRefA and not sizeMax then
				sizeMax = 0
				rngRefA = 1
			end

			debrisPart.Size = Vector3.new(sizeX, rngRefB:NextNumber(sizeMax, rngRefA), getRandomValue(0.75, 1)) * 0.75
			debrisPart.Position = positionVector
			debrisPart.Material = materialEnum
			-- always assign, even when "" — pooled parts recycled from debrisSpawner
			-- carry a stale MaterialVariant/Reflectance from previous ground
			debrisPart.MaterialVariant = partVariant
			debrisPart.Reflectance = partReflectance
			debrisPart.Color = partColor

			local originalCFrame = debrisPart.CFrame
			local cframeAngles = CFrame.Angles

			sizeMax = -360
			rngRefA = 360
			rngRefB = RandomSeed

			if not rngRefA and sizeMax then
				rngRefA = sizeMax
				sizeMax = 1
			end

			if not rngRefA and not sizeMax then
				sizeMax = 0
				rngRefA = 1
			end

			sizeX = math.rad((rngRefB:NextNumber(sizeMax, rngRefA)))
			rngRefA = -360
			rngRefB = 360

			local rngRefC = RandomSeed

			if not rngRefB and rngRefA then
				rngRefB = rngRefA
				rngRefA = 1
			end

			if not rngRefB and not rngRefA then
				rngRefA = 0
				rngRefB = 1
			end

			sizeMin = math.rad((rngRefC:NextNumber(rngRefA, rngRefB)))
			rngRefB = -360
			rngRefC = 360

			local rngRefD = RandomSeed

			if not rngRefC and rngRefB then
				rngRefC = rngRefB
				rngRefB = 1
			end

			if not rngRefC and not rngRefB then
				rngRefB = 0
				rngRefC = 1
			end

			debrisPart.CFrame = originalCFrame
				* cframeAngles(sizeX, sizeMin, (math.rad((rngRefD:NextNumber(rngRefB, rngRefC)))))
			originalCFrame = debrisPart.CFrame
			debrisPart.CFrame = debrisPart.CFrame - Vector3.new(0, 1.25, 0, 0)
			debrisPart.Transparency = 0
			debrisPart.Parent = workspace.Thrown

			TS:Create(debrisPart, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				CFrame = originalCFrame,
			}):Play()

			local delayedCall = task.delay
			sizeMin = 9
			sizeMax = 12
			rngRefA = RandomSeed

			if not sizeMax and sizeMin then
				sizeMax = sizeMin
				sizeMin = 1
			end

			if not sizeMax and not sizeMin then
				sizeMin = 0
				sizeMax = 1
			end

			delayedCall(rngRefA:NextNumber(sizeMin, sizeMax), function()
				local fadeMin = 1
				local fadeMax = 2
				local rngRefE = RandomSeed

				if not fadeMax and fadeMin then
					fadeMax = fadeMin
					fadeMin = 1
				end

				if not fadeMax and not fadeMin then
					fadeMin = 0
					fadeMax = 1
				end

				local tweenDuration = rngRefE:NextNumber(fadeMin, fadeMax)
				local targetPartRef = debrisPart
				local tweenInfoObj = TweenInfo.new(tweenDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				local tweenProps = {}
				local targetCFrameBase = debrisPart.CFrame - Vector3.new(0, 1.2999999523162842, 0, 0)
				local cframeAnglesInner = CFrame.Angles
				local angleMinA = -360
				local angleMaxA = 360
				local rngRefF = RandomSeed

				if not angleMaxA and angleMinA then
					angleMaxA = angleMinA
					angleMinA = 1
				end

				if not angleMaxA and not angleMinA then
					angleMinA = 0
					angleMaxA = 1
				end

				local randAngle1 = math.rad((rngRefF:NextNumber(angleMinA, angleMaxA)))
				angleMaxA = -360
				rngRefF = 360

				local rngRefG = RandomSeed

				if not rngRefF and angleMaxA then
					rngRefF = angleMaxA
					angleMaxA = 1
				end

				if not rngRefF and not angleMaxA then
					angleMaxA = 0
					rngRefF = 1
				end

				local randAngle2 = math.rad((rngRefG:NextNumber(angleMaxA, rngRefF)))
				rngRefF = -360
				rngRefG = 360
				local rngRefH = RandomSeed

				if not rngRefG and rngRefF then
					rngRefG = rngRefF
					rngRefF = 1
				end

				if not rngRefG and not rngRefF then
					rngRefF = 0
					rngRefG = 1
				end

				tweenProps.CFrame = targetCFrameBase
					* cframeAnglesInner(randAngle1, randAngle2, (math.rad((rngRefH:NextNumber(rngRefF, rngRefG)))))
				TS:Create(targetPartRef, tweenInfoObj, tweenProps):Play()

				delay(tweenDuration, function()
					debrisPart.Anchored = true
					debrisPart.CFrame = CFrame.new(100000000, 100000000, 100000000)
					debrisPart.CastShadow = true

					table.insert(dataTable, debrisPart)
				end)
			end)

			return
		end
	end

	localPlayerHRP = if localPlayerHRP then LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or nil else nil
	if hitHRP and localPlayerHRP and (hitHRP.Position - localPlayerHRP.Position).magnitude <= 100 then
		local targetPosition = hitHRP.Position
		local _, onScreen = workspace:FindFirstChildOfClass("Camera"):WorldToScreenPoint(targetPosition)

		if onScreen then
			local startTick = tick()
			while
				debrisInstance.Parent
				and tick() - startTick <= 10
				and not LocalPlayer.Character:FindFirstChild("usingufw")
				and (not debrisTimerAttr or debrisTimerAttr > tick() - startTick)
			do
				local shotCount = math.random(1, 2)

				if LocalPlayer:GetAttribute("Fast_Mode") then
					shotCount = 1
				end

				for _ = 1, shotCount do
					local raycastFunc = shared.ray
					local rayParams = {}
					local hrpCFrame = hitHRP.CFrame
					local cframeNew = CFrame.new
					local minOffset = 1.75
					local maxOffset = 3.5
					local rngRefI = RandomSeed

					if not maxOffset and minOffset then
						maxOffset = minOffset
						minOffset = 1
					end

					if not maxOffset and not minOffset then
						minOffset = 0
						maxOffset = 1
					end

					rayParams.orig = (hrpCFrame * cframeNew(
						rngRefI:NextNumber(minOffset, maxOffset),
						0,
						getRandomValue(-1.5, 1.5)
						)).p
					rayParams.dir = Vector3.new(0, -6, 0, 0)
					rayParams.Whitelist = {game.Workspace.World.Map}

					local hitResult
					raycastFunc, rayParams, hitResult = raycastFunc(rayParams)

					if raycastFunc and raycastFunc == workspace.Terrain then
						startTick = 0
						break
					else
						if raycastFunc then
							spawnDebrisAt(raycastFunc, hitResult, rayParams)
						end

						local raycastFunc2 = shared.ray
						local rayParams2 = {}
						hrpCFrame = hitHRP.CFrame
						cframeNew = CFrame.new
						local negMax = -3.5
						local negMin = -1.75
						local rngRefJ = RandomSeed

						if not negMin and negMax then
							negMin = negMax
							negMax = 1
						end

						if not negMin and not negMax then
							negMax = 0
							negMin = 1
						end

						rayParams2.orig = (hrpCFrame * cframeNew(
							rngRefJ:NextNumber(negMax, negMin),
							0,
							getRandomValue(-1.5, 1.5)
							)).p
						rayParams2.dir = Vector3.new(0, -6, 0, 0)
						rayParams2.Whitelist = {game.Workspace.World.Map}
						raycastFunc2, rayParams2, hrpCFrame = raycastFunc2(rayParams2)

						if raycastFunc2 then
							spawnDebrisAt(raycastFunc2, hrpCFrame, rayParams2)
						end
					end
				end

				task.wait(LocalPlayer:GetAttribute("Fast_Mode") and 0.35 or 0.1)
			end
		end
	end
end)

return ReplicationEffects

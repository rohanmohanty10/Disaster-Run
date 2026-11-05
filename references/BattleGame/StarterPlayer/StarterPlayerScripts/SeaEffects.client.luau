--!native
--!optimize 2

--[[
	SeaRenderer (LocalScript)
	Place in: StarterPlayer > StarterPlayerScripts

	Fully renamed/cleaned version of the decompiled client sea script.
	Changes from the original:
	- All variables renamed to readable names
	- WIND dependency removed (was dead code)
	- math.map replaced with a local map() function (no Luau version worries)
	- Dead/no-op decompiler leftovers removed
	- Inverse dome removed; replaced with underwater screen effects + sound

	Requires:
	- ReplicatedStorage.Modules.Waves        (ModuleScript)
	- ReplicatedStorage.Modules.AreaSystem   (ModuleScript with getWaterDepth)
	- ReplicatedStorage.Assets.SeaMesh       (SkinnedSeaV1, IdleSeaV1, FarSea, HolderSea)
	- ReplicatedStorage.Assets.Animations.Drown (Blur, ColorCorrection, Underwater, Submerge/, Surface/)
]]

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
assert(Camera)

local Waves = require(ReplicatedStorage:WaitForChild("Modules", math.huge):WaitForChild("Waves", math.huge))
local AreaSystem = require(ReplicatedStorage.Modules.AreaSystem)

-- ============================================================
-- Constants / tuning
-- ============================================================

local TILE_SIZE = 100            -- studs per sea tile
--local SKINNED_RADIUS = 3         -- tiles with bones: |x| <= 3 and |z| <= 3 (7x7)
local SKINNED_RADIUS = 2         -- tiles with bones: |x| <= 3 and |z| <= 3 (7x7)

local GRID_RADIUS = 6            -- full grid: -6..6 (13x13)
--local WAVE_RANGE = 295           -- bone wave influence fades to 0 at this distance
local WAVE_RANGE = 200
local COLOR_CHECK_INTERVAL = 0.5 -- seconds between sea color re-checks

-- Day/night sea colors (Hallowtide event swaps these to red)

--local dayColor = Color3.fromRGB(60, 84, 90)
local dayColor = Color3.fromRGB(56, 100, 144)

local nightColor = Color3.fromRGB(51, 61, 65)


local __seaTimeSum, __seaFrames, __seaLastPrint = 0, 0, nil


-- ============================================================
-- Helpers
-- ============================================================

local function map(x, inMin, inMax, outMin, outMax)
	return outMin + (x - inMin) / (inMax - inMin) * (outMax - outMin)
end

-- Sea color based on time of day, slightly brightened in shallow water
local function getSeaColor()
	local clockTime = Lighting.ClockTime
	local color = dayColor

	if clockTime <= 5 then
		color = nightColor
	elseif clockTime > 5 and clockTime <= 7 then
		color = nightColor:Lerp(dayColor, (clockTime - 5) / 2) -- dawn
	elseif clockTime > 7 and clockTime <= 17 then
		color = dayColor
	elseif clockTime > 17 and clockTime <= 19 then
		color = dayColor:Lerp(nightColor, (clockTime - 17) / 2) -- dusk
	elseif clockTime > 19 then
		color = nightColor
	end

	local depth = AreaSystem.getWaterDepth(Camera.CFrame.Position)
	local depthFactor = map(math.clamp(depth, 0.5, 1), 0.5, 1, 0, 1)

	local h, s, v = color:ToHSV()
	local newV = v + map(depthFactor, 0, 1, 0.05, 0)
	local newS = s + map(depthFactor, 0, 1, 0.05, 0)
	return Color3.fromHSV(h, newS, newV)
end

-- ============================================================
-- Asset setup
-- ============================================================

local currentSeaColor = getSeaColor()

local seaModel = Instance.new("Model")
seaModel.Name = "SkinnedSea"

local Assets = ReplicatedStorage:WaitForChild("Assets")
local SeaMeshFolder = Assets:WaitForChild("SeaMesh", math.huge)
local SkinnedSeaTemplate = SeaMeshFolder:WaitForChild("SkinnedSeaV1", math.huge)
local IdleSeaTemplate = SeaMeshFolder:WaitForChild("IdleSeaV1", math.huge)
local FarSeaTemplate = SeaMeshFolder:WaitForChild("FarSea", math.huge)
local HolderSeaTemplate = SeaMeshFolder:WaitForChild("HolderSea", math.huge)

-- ============================================================
-- Underwater screen effects + sound (replaces the inverse dome)
-- ============================================================

local SWIM = Assets.Animations:WaitForChild("Drown", math.huge)

local blurPreset = SWIM:WaitForChild("Blur")             -- a BlurEffect
local colorPreset = SWIM:WaitForChild("ColorCorrection") -- a ColorCorrectionEffect

local waterBlur = Instance.new("BlurEffect")
waterBlur.Name = "WaterBlur"
waterBlur.Size = 0
waterBlur.Parent = Lighting

local waterColor = Instance.new("ColorCorrectionEffect")
waterColor.Name = "WaterColorContrast"
waterColor.Brightness = 0
waterColor.Contrast = 0
waterColor.Saturation = 0
waterColor.TintColor = Color3.new(1, 1, 1)
waterColor.Parent = Lighting

local underwaterSound = SWIM:WaitForChild("Underwater")

local submergeFolder = SWIM:WaitForChild("Submerge")
local surfaceFolder = SWIM:WaitForChild("Surface")

local function playRandom(container)
	local sounds = {}
	for _, d in container:GetDescendants() do
		if d:IsA("Sound") then
			table.insert(sounds, d)
		end
	end
	if #sounds > 0 then
		sounds[math.random(1, #sounds)]:Play()
	end
end

local cameraSubmerged = false
local function setSubmerged(state)
	if state == cameraSubmerged then return end
	cameraSubmerged = state
	if state then
		TweenService:Create(waterColor, TweenInfo.new(0.25), {
			Brightness = colorPreset.Brightness,
			Contrast = colorPreset.Contrast,
			Saturation = colorPreset.Saturation,
			TintColor = colorPreset.TintColor,
		}):Play()
		TweenService:Create(waterBlur, TweenInfo.new(0.25), { Size = blurPreset.Size }):Play()

		SoundService.AmbientReverb = Enum.ReverbType.UnderWater
		if not underwaterSound.IsPlaying then
			--underwaterSound:Play()
		end
		--playRandom(submergeFolder)
	else
		TweenService:Create(waterColor, TweenInfo.new(0.25), {
			Brightness = 0, Contrast = 0, Saturation = 0, TintColor = Color3.new(1, 1, 1),
		}):Play()
		TweenService:Create(waterBlur, TweenInfo.new(0.25), { Size = 0 }):Play()

		SoundService.AmbientReverb = Enum.ReverbType.NoReverb
		underwaterSound:Stop()
		--playRandom(surfaceFolder)
	end
end

-- Flat fallback sea used when LowGraphics is on
local holderSea = HolderSeaTemplate:Clone()
holderSea.CFrame = CFrame.identity

local skinnedTileMeshSize = SkinnedSeaTemplate.Size.X

-- Tile storage
local idleTiles = {}
local skinnedTiles = {}
local farSeaMeshes = {}

-- Build the 13x13 tile grid centered on the camera cell
for tileX = -GRID_RADIUS, GRID_RADIUS do
	for tileZ = -GRID_RADIUS, GRID_RADIUS do
		local tileIndex = (tileZ + GRID_RADIUS) * (GRID_RADIUS * 2 + 1) + (tileX + GRID_RADIUS) + 1

		if math.abs(tileX) <= SKINNED_RADIUS and math.abs(tileZ) <= SKINNED_RADIUS then
			local tile = SkinnedSeaTemplate:Clone()
			tile.Name = "SeaSkin"
			tile.Parent = seaModel
			tile.Archivable = false
			tile.Color = currentSeaColor
			tile.CastShadow = false
			tile.Anchored = true
			tile.CanCollide = false
			tile.CanTouch = false
			tile.CFrame = CFrame.identity

			local edgeBones = {}
			local innerBones = {}
			for _, child in tile:GetChildren() do
				if child:IsA("Bone") then
					local normalized = child.Position / skinnedTileMeshSize
					local offset = normalized * TILE_SIZE
					child.Position = offset

					if math.abs(normalized.X) > 0.49 or math.abs(normalized.Z) > 0.49 then
						edgeBones[child] = offset
					else
						innerBones[child] = offset
					end
				end
			end

			tile.Size = Vector3.new()
			skinnedTiles[tileIndex] = {
				mesh = tile,
				bones = innerBones,
				bones_edge = edgeBones,
			}
		else
			local tile = IdleSeaTemplate:Clone()
			tile.Name = "SeaIdle"
			tile.Parent = seaModel
			tile.Archivable = false
			tile.Color = currentSeaColor
			tile.CastShadow = false
			tile.Anchored = true
			tile.CanCollide = false
			tile.CanTouch = false
			tile.CFrame = CFrame.identity
			tile.Size = Vector3.new(TILE_SIZE, 0, TILE_SIZE)
			idleTiles[tileIndex] = tile
		end
	end
	RunService.PreRender:Wait()
end

-- Four huge far-sea planes in the cardinal directions (the horizon)
for i = 1, 4 do
	local sign = (i % 2 == 0) and 1 or -1
	local xDir = sign * (i <= 2 and 0 or 1)
	local zDir = sign * (i > 2 and 0 or 1)

	if not farSeaMeshes[xDir] then
		farSeaMeshes[xDir] = {}
	end

	local farSea = FarSeaTemplate:Clone()
	farSea.Name = "SeaFar"
	farSea.Parent = seaModel
	farSea.Archivable = false
	farSea.Color = currentSeaColor
	farSea.CastShadow = false
	farSea.Anchored = true
	farSea.CanCollide = false
	farSea.CanTouch = false
	farSea.Size = Vector3.new(1, 1, 1)
	farSea.CFrame = CFrame.identity

	local specialMesh = farSea:FindFirstChild("Mesh")
	if specialMesh then
		specialMesh.Scale = Vector3.new(600, 0, 600)
		farSeaMeshes[xDir][zDir] = specialMesh
	end
end

-- ============================================================
-- Render loop state
-- ============================================================

local frameCounter = 0
local lastColorCheckTime = 0
local lastGridOrigin = nil
local firstFrame = true

local seaIntensity = workspace:GetAttribute("SeaIntensity") or 1
workspace:GetAttributeChangedSignal("SeaIntensity"):Connect(function()
	seaIntensity = workspace:GetAttribute("SeaIntensity") or 1
end)

-- ============================================================
-- Graphics settings: LowGraphics attribute + NoSea tag
-- ============================================================

local lowGraphics = LocalPlayer:GetAttribute("LowGraphics")
local hasNoSeaTag = LocalPlayer:HasTag("NoSea")
local seaEnabled = (lowGraphics ~= true) and not hasNoSeaTag

local function refreshSeaVisibility()
	lowGraphics = LocalPlayer:GetAttribute("LowGraphics")
	hasNoSeaTag = LocalPlayer:HasTag("NoSea")

	if lowGraphics == true then
		seaModel.Parent = nil
		if not hasNoSeaTag then
			holderSea.Color = getSeaColor()
			holderSea.Parent = workspace.Terrain
		end
	else
		if not hasNoSeaTag then
			seaModel.Parent = workspace
		end
		holderSea.Parent = nil
	end

	seaEnabled = (lowGraphics ~= true) and not hasNoSeaTag
end

CollectionService:GetInstanceAddedSignal("NoSea"):Connect(function(instance)
	if instance == LocalPlayer then
		seaModel.Parent = nil
		holderSea.Parent = nil
		lowGraphics = LocalPlayer:GetAttribute("LowGraphics")
		hasNoSeaTag = LocalPlayer:HasTag("NoSea")
		seaEnabled = (lowGraphics ~= true) and not hasNoSeaTag
	end
end)

CollectionService:GetInstanceRemovedSignal("NoSea"):Connect(function(instance)
	task.wait()
	if instance == LocalPlayer then
		refreshSeaVisibility()
	end
end)

LocalPlayer:GetAttributeChangedSignal("LowGraphics"):Connect(refreshSeaVisibility)

if not hasNoSeaTag then
	if seaEnabled then
		seaModel.Parent = workspace
	else
		holderSea.Color = getSeaColor()
		holderSea.Parent = workspace.Terrain
	end
end

-- ============================================================
-- Main render loop
-- ============================================================
--local getWaveAt = Waves.getWaveAt
RunService:BindToRenderStep("SeaWater", Enum.RenderPriority.Camera.Value + 10, function(deltaTime)
	
	-- Inside Whitebeard's tsunami (set by the WhiteBeardTsunami client effect).
	local inTsunami = LocalPlayer:GetAttribute("InTsunami") == true
	if not seaEnabled then
		-- No sea for LowGraphics/NoSea, but the tsunami's underwater effect still applies.
		setSubmerged(inTsunami)
		return
	end
	local __t0 = os.clock()
	local serverTime = workspace:GetServerTimeNow()
	frameCounter = (frameCounter + 1) % 8

	local camCFrame = Camera.CFrame
	local lookVector = camCFrame.LookVector
	local camPos = camCFrame.Position
	local absLookY = math.abs(lookVector.Y)

	local outOfRange = camPos.Y < -2 or camPos.Y > 345

	-- Underwater screen effects, driven by camera height vs. the wave surface
	local surfaceY = Waves.getWaveHeightAt(Vector3.new(camPos.X, 0, camPos.Z), serverTime)
	setSubmerged(camPos.Y < surfaceY or inTsunami)

	if firstFrame then
		outOfRange = false
	end

	--local updateInnerBones = frameCounter % 2 == 0
	--local updateEdgeBones = not updateInnerBones
	local updateInnerBones = frameCounter % 4 == 0
	local updateEdgeBones = frameCounter % 4 == 2

	local depthFactor = math.clamp(AreaSystem.getWaterDepth(camPos), 0.5, 1)

	local gridOrigin = Vector3.new(
		math.floor(camPos.X / TILE_SIZE) * TILE_SIZE + TILE_SIZE / 2,
		0,
		math.floor(camPos.Z / TILE_SIZE) * TILE_SIZE + TILE_SIZE / 2
	)
	local gridMoved = gridOrigin ~= lastGridOrigin

	local colorChanged = serverTime - lastColorCheckTime > COLOR_CHECK_INTERVAL
	if colorChanged then
		lastColorCheckTime = serverTime
		local previousColor = currentSeaColor
		currentSeaColor = getSeaColor()
		if previousColor == currentSeaColor then
			colorChanged = false
		end
	end

	-- ---- Far-sea horizon planes ----
	if gridMoved or colorChanged then
		for xDir, group in farSeaMeshes do
			for zDir, mesh in group do
				if colorChanged and mesh.Parent then
					mesh.Parent.Color = currentSeaColor
				end
				if gridMoved then
					local absX = math.abs(xDir)
					local absZ = math.abs(zDir)
					local baseLength = 1300
					if absX > 0 then
						baseLength += 10000
					end
					local scaleX = absX * baseLength + absZ * 5000
					local scaleZ = absZ * baseLength + absX * 5000
					mesh.Scale = Vector3.new(scaleX, 0, scaleZ)

					local offsetX = zDir * (GRID_RADIUS * TILE_SIZE + TILE_SIZE / 2 + 5000 / 2)
					local offsetZ = xDir * (GRID_RADIUS * TILE_SIZE + TILE_SIZE / 2 + 5000 / 2)
					mesh.Offset = gridOrigin + Vector3.new(offsetX, 0, offsetZ)
				end
			end
		end
	end

	-- ---- Tile grid ----
	for tileX = -GRID_RADIUS, GRID_RADIUS do
		for tileZ = -GRID_RADIUS, GRID_RADIUS do
			local tileIndex = (tileZ + GRID_RADIUS) * (GRID_RADIUS * 2 + 1) + (tileX + GRID_RADIUS) + 1

			if math.abs(tileX) <= SKINNED_RADIUS and math.abs(tileZ) <= SKINNED_RADIUS then
				local tile = skinnedTiles[tileIndex]
				if tile and tile.mesh then
					if colorChanged then
						tile.mesh.Color = currentSeaColor
					end

					local tileOrigin = gridOrigin + Vector3.new(tileX * TILE_SIZE, 0, tileZ * TILE_SIZE)
					local toTile = tileOrigin - camPos

					local shouldUpdate = gridMoved
					if not shouldUpdate then
						-- Only animate tiles roughly within the camera's view cone.
						-- Tiles behind you (under the map, off-screen) are skipped.
						local toTileFlat = toTile
						if toTileFlat.Magnitude > 0.001 then
							local angleToTile = math.deg(math.acos(math.clamp(lookVector:Dot(toTileFlat.Unit), -1, 1)))
							local fovLimit = (1 - absLookY) * 20 + 100
							shouldUpdate = angleToTile <= fovLimit
						else
							shouldUpdate = true -- tile is basically on top of the camera
						end
					end

					if shouldUpdate then
						local beyondWaveRange = outOfRange or (toTile.Magnitude - TILE_SIZE / 2 > WAVE_RANGE)

						if updateInnerBones or gridMoved then
							for bone, boneOffset in tile.bones do
								local worldPos = tileOrigin + boneOffset
								local flatCFrame = CFrame.new(worldPos)
								if beyondWaveRange then
									if gridMoved then
										bone.CFrame = flatCFrame
									end
								else
									local influence = (1 - (worldPos - camPos).Magnitude / WAVE_RANGE)
										* depthFactor * seaIntensity
									if influence > 0 then
										local wave = Waves.getWaveAt(worldPos, serverTime)
										
										bone.CFrame = flatCFrame:Lerp(
											CFrame.new(wave.Position + worldPos) * wave.Rotation,
											influence
										)
									elseif gridMoved then
										bone.CFrame = flatCFrame
									end
								end
							end
						end

						if updateEdgeBones or gridMoved then
							for bone, boneOffset in tile.bones_edge do
								local worldPos = tileOrigin + boneOffset
								local flatCFrame = CFrame.new(worldPos)
								if beyondWaveRange then
									if gridMoved then
										bone.CFrame = flatCFrame
									end
								else
									local influence = (1 - (worldPos - camPos).Magnitude / WAVE_RANGE)
										* depthFactor * seaIntensity
									if influence > 0 then
										local wave = Waves.getWaveAt(worldPos, serverTime)
										bone.CFrame = flatCFrame:Lerp(
											CFrame.new(wave.Position + worldPos) * wave.Rotation,
											influence
										)
									elseif gridMoved then
										bone.CFrame = flatCFrame
									end
								end
							end
						end
					end
				end
			else
				local tile = idleTiles[tileIndex]
				if tile then
					if colorChanged then
						tile.Color = currentSeaColor
					end
					if gridMoved then
						tile.CFrame = CFrame.new(
							gridOrigin + Vector3.new(tileX * TILE_SIZE, 0, tileZ * TILE_SIZE)
						)
					end
				end
			end
		end
	end

	lastGridOrigin = gridOrigin
	firstFrame = false
	-- perf print
	--__seaTimeSum = (__seaTimeSum or 0) + (os.clock() - __t0)
	--__seaFrames = (__seaFrames or 0) + 1
	--if not __seaLastPrint then __seaLastPrint = os.clock() end
	--if os.clock() - __seaLastPrint >= 1 then
	--	local avgMs = (__seaTimeSum / __seaFrames) * 1000
	--	print(string.format("[Sea] %.3f ms/frame avg  (%d frames)", avgMs, __seaFrames))
	--	__seaTimeSum = 0
	--	__seaFrames = 0
	--	__seaLastPrint = os.clock()
	--end
end)
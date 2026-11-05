--!strict
-- The simple canyon course (GAME_PLAN.md Section 4, kept deliberately plain).
--   * Static: Workspace.Course — floor, canyon walls, start bunker + "StartBarrier", Sanctuary gate.
--     It lives in the place (src/map/Course.rbxmx, synced by Rojo) so it's visible in Edit mode;
--     edit it in Studio and save it back to that file, or regenerate with tools/build_world.py.
--     If it's missing, the same course is built here as a fallback.
--   * Per round: Course.Cover — ruins, pillars, low walls, boulders in 100-stud chunks, reshuffled
--     with a new seed. Ruins / pillars / walls are DestructibleCover with Health; boulders are
--     permanent shelter. Set the attribute FixedCover = true on Course to keep hand-placed cover.

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MapConfig = require(ReplicatedStorage.Shared.Config.MapConfig)
local FogConfig = require(ReplicatedStorage.Shared.Config.FogConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Players = game:GetService("Players")

local CombatService = require(script.Parent.CombatService)
local FogService = require(script.Parent.FogService)

local MapService = {}

local course: Model? = nil
local coverFolder: Folder? = nil
local barrier: BasePart? = nil
local generated = false

local function block(parent: Instance, name: string, size: Vector3, cframe: CFrame, color: Color3, material: Enum.Material, props: { [string]: any }?): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Anchored = true
	part.Size = size
	part.CFrame = cframe
	part.Color = color
	part.Material = material
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	for key, value in props or {} do
		(part :: any)[key] = value
	end
	part.Parent = parent
	return part
end

-- ------------------------------------------------------------------ static course
local function buildCourse(): Model
	local cfg = MapConfig
	local origin = cfg.Origin
	local length, width = cfg.Length, cfg.Width
	local model = Instance.new("Model")
	model.Name = "Course"

	local center = origin + Vector3.new(0, -2, -length / 2)
	block(model, "Floor", Vector3.new(width, 4, length + 120), CFrame.new(center + Vector3.new(0, 0, 30)), cfg.Colors.Floor, Enum.Material.Grass)
	for _, side in { -1, 1 } do
		block(model, "Wall", Vector3.new(12, cfg.WallHeight, length + 120), CFrame.new(center + Vector3.new(side * (width / 2 + 6), cfg.WallHeight / 2, 30)), cfg.Colors.Wall, Enum.Material.Rock)
	end

	-- Start bunker: back wall, roof, and the barrier that drops when the run starts.
	local startZ = origin.Z + 40
	block(model, "BunkerBack", Vector3.new(width, 30, 6), CFrame.new(origin.X, origin.Y + 15, startZ + 40), cfg.Colors.Bunker, Enum.Material.Concrete)
	block(model, "BunkerRoof", Vector3.new(width, 2, 46), CFrame.new(origin.X, origin.Y + 30, startZ + 18), cfg.Colors.Bunker, Enum.Material.Concrete)
	barrier = block(model, "StartBarrier", Vector3.new(width, 30, 2), CFrame.new(origin.X, origin.Y + 15, origin.Z), Color3.fromRGB(56, 189, 248), Enum.Material.ForceField, { Transparency = 0.5 })
	block(model, "StartSpawn", Vector3.new(30, 1, 20), CFrame.new(origin.X, origin.Y + 0.5, startZ + 15), cfg.Colors.Floor, Enum.Material.Slate, { Transparency = 1, CanCollide = false, CanQuery = false })

	-- Sanctuary gate at the far end.
	local endZ = origin.Z - length
	for _, side in { -1, 1 } do
		block(model, "GatePillar", Vector3.new(8, 40, 8), CFrame.new(origin.X + side * 30, origin.Y + 20, endZ), cfg.Colors.Gate, Enum.Material.Marble)
	end
	block(model, "GateArch", Vector3.new(68, 6, 8), CFrame.new(origin.X, origin.Y + 43, endZ), cfg.Colors.Gate, Enum.Material.Marble)
	block(model, "Sanctuary", Vector3.new(width, 30, 30), CFrame.new(origin.X, origin.Y + 15, endZ - 20), Color3.fromRGB(80, 255, 140), Enum.Material.ForceField, { Transparency = 0.6, CanCollide = false, CanQuery = false })

	model.Parent = workspace
	return model
end

-- ------------------------------------------------------------------ cover
local COVER_TYPES = { "Ruin", "Pillar", "Boulder", "Wall", "Tree", "Tree" }
local groupCounter = 0

local function destructible(part: BasePart, health: number)
	part:SetAttribute("Health", health)
	part:SetAttribute("MaxHealth", health)
	part:SetAttribute("BaseColor", part.Color)
	CollectionService:AddTag(part, "DestructibleCover")
end

local function placeCover(folder: Folder, kind: string, position: Vector3, rng: Random)
	local cfg = MapConfig
	local yaw = CFrame.Angles(0, math.rad(rng:NextInteger(0, 3) * 90 + rng:NextNumber(-10, 10)), 0)
	if kind == "Tree" then
		-- Trees block shots and line of sight but can't be destroyed.
		local height = rng:NextNumber(9, 13)
		local trunk = block(folder, "TreeTrunk", Vector3.new(height, 2.2, 2.2), CFrame.new(position + Vector3.new(0, height / 2, 0)) * CFrame.Angles(0, 0, math.rad(90)), cfg.Colors.Wood, Enum.Material.Wood)
		trunk.Shape = Enum.PartType.Cylinder
		local crown = rng:NextNumber(10, 14)
		local leaves = block(folder, "TreeLeaves", Vector3.one * crown, CFrame.new(position + Vector3.new(0, height + crown * 0.25, 0)), cfg.Colors.Leaves, Enum.Material.LeafyGrass)
		leaves.Shape = Enum.PartType.Ball
	elseif kind == "Boulder" then
		local size = rng:NextNumber(8, 14)
		local rock = block(folder, "Boulder", Vector3.new(size, size * 0.8, size), CFrame.new(position + Vector3.new(0, size * 0.35, 0)) * yaw, cfg.Colors.Boulder, Enum.Material.Rock)
		rock.Shape = Enum.PartType.Ball
	elseif kind == "Pillar" then
		local height = rng:NextNumber(12, 20)
		local pillar = block(folder, "Pillar", Vector3.new(5, height, 5), CFrame.new(position + Vector3.new(0, height / 2, 0)) * yaw, cfg.Colors.Ruin, Enum.Material.Cobblestone)
		destructible(pillar, cfg.CoverHealth.Pillar)
	elseif kind == "Wall" then
		local wall = block(folder, "LowWall", Vector3.new(rng:NextNumber(14, 22), 6, 3), CFrame.new(position + Vector3.new(0, 3, 0)) * yaw, cfg.Colors.Ruin, Enum.Material.Cobblestone)
		destructible(wall, cfg.CoverHealth.Wall)
	elseif kind == "Bunker" then
		-- Concrete bunker: three thick walls and a roof, open toward the start so Runners can duck in.
		groupCounter += 1
		local base = CFrame.new(position)
		local parts = {
			block(folder, "BunkerWall", Vector3.new(16, 8, 2.5), base * CFrame.new(0, 4, -7), cfg.Colors.Bunker, Enum.Material.Concrete),
			block(folder, "BunkerWall", Vector3.new(2.5, 8, 14), base * CFrame.new(-7, 4, 0), cfg.Colors.Bunker, Enum.Material.Concrete),
			block(folder, "BunkerWall", Vector3.new(2.5, 8, 14), base * CFrame.new(7, 4, 0), cfg.Colors.Bunker, Enum.Material.Concrete),
		}
		local roof = block(folder, "BunkerRoof", Vector3.new(17, 2, 16), base * CFrame.new(0, 9, 0), cfg.Colors.Bunker, Enum.Material.Concrete)
		roof:SetAttribute("Roof", true)
		table.insert(parts, roof)
		for _, part in parts do
			part:SetAttribute("Group", groupCounter)
			destructible(part, cfg.CoverHealth.Bunker)
		end
	else
		-- A small ruin: two walls and a roof slab to hide under. The roof falls when both walls go.
		groupCounter += 1
		local base = CFrame.new(position) * yaw
		for _, side in { -1, 1 } do
			local wall = block(folder, "RuinWall", Vector3.new(2, 10, 14), base * CFrame.new(side * 6, 5, 0), cfg.Colors.Ruin, Enum.Material.Cobblestone)
			wall:SetAttribute("Group", groupCounter)
			destructible(wall, cfg.CoverHealth.Ruin)
		end
		local roof = block(folder, "RuinRoof", Vector3.new(14, 1.5, 14), base * CFrame.new(0, 10.75, 0), cfg.Colors.Ruin, Enum.Material.Concrete)
		roof:SetAttribute("Group", groupCounter)
		roof:SetAttribute("Roof", true)
		destructible(roof, cfg.CoverHealth.Ruin)
	end
end

local function pickChunk(rng: Random, index: number): string
	local total = 0
	for _, entry in MapConfig.Chunks do
		if not (index == 1 and MapConfig.FirstChunkSafe and entry.Name == "ChasmBridge") then
			total += entry.Weight
		end
	end
	local roll = rng:NextNumber() * total
	for _, entry in MapConfig.Chunks do
		if not (index == 1 and MapConfig.FirstChunkSafe and entry.Name == "ChasmBridge") then
			roll -= entry.Weight
			if roll <= 0 then
				return entry.Name
			end
		end
	end
	return "Ruins"
end

-- A hazard strip across the playable width with a bridge over each open lane.
-- Is the character standing on a bridge (or its ramps)? Raycasts straight down from the root.
local bridgeParams = RaycastParams.new()
bridgeParams.FilterType = Enum.RaycastFilterType.Exclude
local function onBridge(character: Model, root: BasePart): boolean
	bridgeParams.FilterDescendantsInstances = { character }
	local result = workspace:Raycast(root.Position, Vector3.new(0, -8, 0), bridgeParams)
	local name = result and result.Instance.Name
	return name == "Bridge" or name == "BridgeRamp"
end

local function placeChasm(folder: Folder, chunkZ: number, open: { [number]: boolean }, rng: Random)
	local cfg = MapConfig
	local hazard = cfg.Hazard
	local kindName = if rng:NextNumber() < 0.5 then "Lava" else "Quicksand"
	local kind = hazard.Kinds[kindName]
	local floorY = cfg.Origin.Y
	local pit = block(folder, kindName, Vector3.new(cfg.PlayableWidth, 0.4, hazard.Depth), CFrame.new(cfg.Origin.X, floorY + 0.2, chunkZ), kind.Color, kind.Material, { CanCollide = false, CanQuery = false })
	-- The damage zone spans the whole canyon, slopes included, so the strip can't be walked
	-- around along the valley sides. Only the bridges are safe (see hazardTick).
	local zone = block(folder, `{kindName}Zone`, Vector3.new(cfg.Width, cfg.SlopeHeight + 6, hazard.Depth), CFrame.new(cfg.Origin.X, floorY + (cfg.SlopeHeight + 6) / 2, chunkZ), kind.Color, kind.Material, { CanCollide = false, CanQuery = false, Transparency = 1 })
	zone:SetAttribute("HazardKind", kindName)
	CollectionService:AddTag(zone, "Hazard")
	-- Visual: the strip continues up both valley slopes. Each slope rises toward its cliff, so a
	-- sheet through the middle of the slope, tilted by the slope angle, lies on its surface.
	local slopeLength = math.sqrt(cfg.SlopeDepth ^ 2 + cfg.SlopeHeight ^ 2)
	local slopeAngle = math.atan2(cfg.SlopeHeight, cfg.SlopeDepth)
	for _, side in { -1, 1 } do
		local center = CFrame.new(cfg.Origin.X + side * (cfg.Width / 2 - cfg.SlopeDepth / 2), floorY + cfg.SlopeHeight / 2 + 0.2, chunkZ)
		block(folder, kindName, Vector3.new(slopeLength, 0.4, hazard.Depth), center * CFrame.Angles(0, 0, slopeAngle * side), kind.Color, kind.Material, { CanCollide = false, CanQuery = false })
	end
	local _ = pit
	if kindName == "Lava" then
		local glow = Instance.new("PointLight")
		glow.Color = kind.Color
		glow.Range = 30
		glow.Brightness = 2
		glow.Parent = pit
	end
	local laneWidth = cfg.PlayableWidth / cfg.Lanes
	for lane in open do
		local x = cfg.Origin.X - cfg.PlayableWidth / 2 + (lane - 0.5) * laneWidth
		local h = hazard.BridgeHeight
		block(folder, "Bridge", Vector3.new(hazard.BridgeWidth, h, hazard.Depth), CFrame.new(x, floorY + h / 2, chunkZ), cfg.Colors.Wood, Enum.Material.WoodPlanks)
		-- Ramps at both ends so Runners can walk on and off.
		for _, side in { 1, -1 } do
			local ramp = Instance.new("WedgePart")
			ramp.Name = "BridgeRamp"
			ramp.Anchored = true
			ramp.Size = Vector3.new(hazard.BridgeWidth, h, 5)
			ramp.Color = cfg.Colors.Wood
			ramp.Material = Enum.Material.WoodPlanks
			-- A wedge is tallest at its back (+Z) face; turn that face toward the bridge.
			local z = chunkZ + side * (hazard.Depth / 2 + 2.5)
			ramp.CFrame = CFrame.new(x, floorY + h / 2, z) * CFrame.Angles(0, if side == 1 then math.pi else 0, 0)
			ramp.Parent = folder
		end
	end
	local _ = rng
end

-- Fog Patches for this chunk (FogConfig; off unless fog is enabled).
local function placeFog(folder: Folder, chunkZ: number, rng: Random)
	if not FogConfig.Enabled then
		return
	end
	local cfg = FogConfig.Patches
	for _ = 1, rng:NextInteger(cfg.PerChunk.Min, cfg.PerChunk.Max) do
		local radius = rng:NextNumber(cfg.Radius.Min, cfg.Radius.Max)
		local x = MapConfig.Origin.X + rng:NextNumber(-MapConfig.PlayableWidth / 2, MapConfig.PlayableWidth / 2)
		local z = chunkZ + rng:NextNumber(-MapConfig.ChunkLength * 0.4, MapConfig.ChunkLength * 0.4)
		FogService.MakeZone("Patch", CFrame.new(x, MapConfig.Origin.Y + cfg.Height / 2, z), Vector3.new(radius * 2, cfg.Height, radius * 2), radius, folder)
	end
end

-- Rebuilds all cover with a new seed. Every chunk keeps at least two clear lanes.
function MapService.Generate(seed: number?)
	if not generated then
		return
	end
	if coverFolder then
		coverFolder:Destroy()
	end
	local old = course and course:FindFirstChild("Cover")
	if old then
		old:Destroy()
	end
	local folder = Instance.new("Folder")
	folder.Name = "Cover"
	coverFolder = folder
	local cfg = MapConfig
	local rng = Random.new(seed or os.clock() * 1000)
	local laneWidth = cfg.PlayableWidth / cfg.Lanes
	local chunks = math.floor((cfg.Length - 80) / cfg.ChunkLength)
	for chunk = 1, chunks do
		local chunkZ = cfg.Origin.Z - 40 - (chunk - 0.5) * cfg.ChunkLength
		-- Pick lanes to keep open (at least two).
		local open: { [number]: boolean } = {}
		local openCount = 0
		while openCount < 2 do
			local lane = rng:NextInteger(1, cfg.Lanes)
			if not open[lane] then
				open[lane] = true
				openCount += 1
			end
		end
		local theme = pickChunk(rng, chunk)
		if theme == "ChasmBridge" then
			placeChasm(folder, chunkZ, open, rng)
		else
			for lane = 1, cfg.Lanes do
				if not open[lane] and rng:NextNumber() < cfg.CoverDensity then
					local x = cfg.Origin.X - cfg.PlayableWidth / 2 + (lane - 0.5) * laneWidth + rng:NextNumber(-3, 3)
					local z = chunkZ + rng:NextNumber(-cfg.ChunkLength * 0.3, cfg.ChunkLength * 0.3)
					local position = Vector3.new(x, cfg.Origin.Y, z)
					if theme == "Bunker" then
						placeCover(folder, if rng:NextNumber() < 0.7 then "Bunker" else "Boulder", position, rng)
					elseif theme == "PillarField" then
						for i = 1, rng:NextInteger(2, 3) do
							local offset = Vector3.new(rng:NextNumber(-laneWidth * 0.3, laneWidth * 0.3), 0, (i - 2) * 12 + rng:NextNumber(-3, 3))
							placeCover(folder, "Pillar", position + offset, rng)
						end
					else
						placeCover(folder, COVER_TYPES[rng:NextInteger(1, #COVER_TYPES)], position, rng)
					end
				end
			end
		end
		placeFog(folder, chunkZ, rng)
	end
	folder.Parent = course
end

-- ------------------------------------------------------------------ hazards
-- Runners standing in lava / quicksand (not on a bridge) are hurt and slowed.
local function hazardTick()
	local hazards = CollectionService:GetTagged("Hazard")
	if #hazards == 0 then
		return
	end
	local tick = MapConfig.Hazard.Tick
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local root = character and Characters.GetRoot(character)
		if character and root and Characters.IsAlive(character) and player:GetAttribute("Role") ~= "God" then
			for _, hazard in hazards do
				if hazard:IsA("BasePart") then
					local localPoint = hazard.CFrame:PointToObjectSpace(root.Position)
					local half = hazard.Size / 2
					local inside = math.abs(localPoint.X) <= half.X and math.abs(localPoint.Y) <= half.Y and math.abs(localPoint.Z) <= half.Z
					-- Jumping over it is fine: only Runners standing on something (not a bridge) burn.
					local grounded = character:FindFirstChildOfClass("Humanoid") ~= nil
						and (character:FindFirstChildOfClass("Humanoid") :: Humanoid).FloorMaterial ~= Enum.Material.Air
					if inside and grounded and not onBridge(character, root) then
						local kind = MapConfig.Hazard.Kinds[hazard:GetAttribute("HazardKind") :: string]
						if kind then
							CombatService.Afflict(nil, character, {
								Damage = kind.DamagePerSecond * tick,
								Slow = { Factor = kind.Slow, Duration = tick + 0.3 },
							})
						end
						break
					end
				end
			end
		end
	end
end

-- Opens (true) or closes (false) the start barrier.
function MapService.SetBarrier(open: boolean)
	local part = barrier
	if part then
		part.CanCollide = not open
		part.Transparency = if open then 1 else 0.5
	end
end

function MapService.Init()
	local existing = workspace:FindFirstChild("Course")
	if existing and existing:IsA("Model") then
		course = existing
		local found = existing:FindFirstChild("StartBarrier")
		barrier = if found and found:IsA("BasePart") then found else nil
	else
		course = buildCourse()
	end
	generated = not (course :: Model):GetAttribute("FixedCover")
	MapService.Generate()
	MapService.SetBarrier(false)
end

function MapService.Start()
	task.spawn(function()
		while true do
			task.wait(MapConfig.Hazard.Tick)
			local ok, err = pcall(hazardTick :: any)
			if not ok then
				warn(`[MapService] Hazard tick failed: {err}`)
			end
		end
	end)
end

return MapService

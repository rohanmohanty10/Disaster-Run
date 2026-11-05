--!strict
-- The simple canyon course (GAME_PLAN.md Section 4, kept deliberately plain).
--   * Static: Workspace.Course — floor, canyon walls, start bunker + "StartBarrier", Sanctuary gate.
--     It lives in the place (src/map/Course.rbxmx, synced by Rojo) so it's visible in Edit mode;
--     edit it in Studio and save it back to that file, or regenerate with tools/build_course.py.
--     If it's missing, the same course is built here as a fallback.
--   * Per round: Course.Cover — ruins, pillars, low walls, boulders in 100-stud chunks, reshuffled
--     with a new seed. Ruins / pillars / walls are DestructibleCover with Health; boulders are
--     permanent shelter. Set the attribute FixedCover = true on Course to keep hand-placed cover.

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MapConfig = require(ReplicatedStorage.Shared.Config.MapConfig)

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
	block(model, "Floor", Vector3.new(width, 4, length + 120), CFrame.new(center + Vector3.new(0, 0, 30)), cfg.Colors.Floor, Enum.Material.Slate)
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
local COVER_TYPES = { "Ruin", "Pillar", "Boulder", "Wall" }

local function placeCover(folder: Folder, kind: string, position: Vector3, rng: Random)
	local cfg = MapConfig
	local yaw = CFrame.Angles(0, math.rad(rng:NextInteger(0, 3) * 90 + rng:NextNumber(-10, 10)), 0)
	if kind == "Boulder" then
		local size = rng:NextNumber(8, 14)
		local rock = block(folder, "Boulder", Vector3.new(size, size * 0.8, size), CFrame.new(position + Vector3.new(0, size * 0.35, 0)) * yaw, cfg.Colors.Boulder, Enum.Material.Rock)
		rock.Shape = Enum.PartType.Ball
	elseif kind == "Pillar" then
		local height = rng:NextNumber(12, 20)
		local pillar = block(folder, "Pillar", Vector3.new(5, height, 5), CFrame.new(position + Vector3.new(0, height / 2, 0)) * yaw, cfg.Colors.Ruin, Enum.Material.Brick)
		pillar:SetAttribute("Health", cfg.CoverHealth.Pillar)
		CollectionService:AddTag(pillar, "DestructibleCover")
	elseif kind == "Wall" then
		local wall = block(folder, "LowWall", Vector3.new(rng:NextNumber(14, 22), 6, 3), CFrame.new(position + Vector3.new(0, 3, 0)) * yaw, cfg.Colors.Ruin, Enum.Material.Brick)
		wall:SetAttribute("Health", cfg.CoverHealth.Wall)
		CollectionService:AddTag(wall, "DestructibleCover")
	else
		-- A small ruin: two walls and a roof slab to hide under.
		local base = CFrame.new(position) * yaw
		for _, side in { -1, 1 } do
			local wall = block(folder, "RuinWall", Vector3.new(2, 10, 14), base * CFrame.new(side * 6, 5, 0), cfg.Colors.Ruin, Enum.Material.Brick)
			wall:SetAttribute("Health", cfg.CoverHealth.Ruin)
			CollectionService:AddTag(wall, "DestructibleCover")
		end
		local roof = block(folder, "RuinRoof", Vector3.new(14, 1.5, 14), base * CFrame.new(0, 10.75, 0), cfg.Colors.Ruin, Enum.Material.Concrete)
		roof:SetAttribute("Health", cfg.CoverHealth.Ruin)
		CollectionService:AddTag(roof, "DestructibleCover")
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
	local laneWidth = cfg.Width / cfg.Lanes
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
		for lane = 1, cfg.Lanes do
			if not open[lane] and rng:NextNumber() < cfg.CoverDensity then
				local x = cfg.Origin.X - cfg.Width / 2 + (lane - 0.5) * laneWidth + rng:NextNumber(-4, 4)
				local z = chunkZ + rng:NextNumber(-cfg.ChunkLength * 0.3, cfg.ChunkLength * 0.3)
				placeCover(folder, COVER_TYPES[rng:NextInteger(1, #COVER_TYPES)], Vector3.new(x, cfg.Origin.Y, z), rng)
			end
		end
	end
	folder.Parent = course
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

function MapService.Start() end

return MapService

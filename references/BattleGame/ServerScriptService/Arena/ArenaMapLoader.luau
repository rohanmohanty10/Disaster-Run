-- Arena only: replaces the big Demon Fruits map with ServerStorage.ArenaMap when the server starts.
--
-- The folders inside workspace.World.Map (Destroyable, Indestructible Map, Not Destroyable,
-- Throwables) are kept and only their CONTENTS are swapped, because DebreeService and other
-- scripts hold references to those folders. DebreeService.Start calls Load() first thing, so
-- the swap always happens before destruction is set up. Safe to call more than once.
--
-- ArenaMap layout this expects (made by you, never edited by code):
--   Destroyable / Indestructible Map / Not Destroyable / Throwables -> copied into World.Map
--   Bounds   -> copied into World.Map["Indestructible Map"].Bounds
--   Spawns, KillPlane, CameraSelect -> copied into workspace.World.Arena

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local PlaceRole = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole"))

local MAP_FOLDERS = { "Destroyable", "Indestructible Map", "Not Destroyable", "Throwables" }
local MARKERS = { "Spawns", "KillPlane", "CameraSelect" }

-- Anything in workspace (outside World) with a part inside this box is moved out of the way.
local ARENA_HALF = Vector3.new(140, 0, 140)
local ARENA_MIN_Y, ARENA_MAX_Y = -170, 120

local Loader = {}
local done = false

local function insideArena(position: Vector3): boolean
	return math.abs(position.X) < ARENA_HALF.X
		and math.abs(position.Z) < ARENA_HALF.Z
		and position.Y > ARENA_MIN_Y
		and position.Y < ARENA_MAX_Y
end

local function touchesArena(thing: Instance): boolean
	if thing:IsA("BasePart") and insideArena(thing.Position) then
		return true
	end
	for _, descendant in thing:GetDescendants() do
		if descendant:IsA("BasePart") and insideArena(descendant.Position) then
			return true
		end
	end
	return false
end

function Loader.Load()
	if done then
		return
	end
	done = true
	if not PlaceRole.IsArena() then
		return
	end

	local template = ServerStorage:FindFirstChild("ArenaMap")
	if not template then
		warn("[Arena] ServerStorage.ArenaMap is missing; keeping the normal map")
		return
	end

	local World = workspace:WaitForChild("World")
	local Map = World:WaitForChild("Map")

	-- 1. Swap the contents of the map folders in place
	local keep = {}
	for _, name in MAP_FOLDERS do
		local live = Map:FindFirstChild(name)
		if not live then
			live = Instance.new("Folder")
			live.Name = name
			live.Parent = Map
		end
		keep[live] = true
		live:ClearAllChildren()
		local source = template:FindFirstChild(name)
		if source then
			for _, child in source:GetChildren() do
				child:Clone().Parent = live
			end
		end
	end

	-- 2. Everything else loose in World.Map (the 2048-stud Baseplate) goes
	for _, child in Map:GetChildren() do
		if not keep[child] then
			child:Destroy()
		end
	end

	-- 3. Walls are unbreakable
	local bounds = template:FindFirstChild("Bounds")
	if bounds then
		bounds:Clone().Parent = Map["Indestructible Map"]
	end

	-- 4. Spawns, kill plane and select camera live outside Map so destruction ignores them
	local arena = World:FindFirstChild("Arena") or Instance.new("Folder")
	arena.Name = "Arena"
	arena:ClearAllChildren()
	for _, name in MARKERS do
		local marker = template:FindFirstChild(name)
		if marker then
			marker:Clone().Parent = arena
		end
	end
	local camera = arena:FindFirstChild("CameraSelect")
	if camera and camera:IsA("BasePart") then
		camera.Transparency = 1
		camera.CanCollide = false
		camera.CanQuery = false
		camera.CanTouch = false
	end
	arena.Parent = World

	-- 5. The main game's spawn points are far away; the arena places characters itself
	for _, descendant in workspace:GetDescendants() do
		if descendant:IsA("SpawnLocation") then
			descendant.Enabled = false
		end
	end

	-- 6. Loose dev models / boards that sit inside the arena (under the floor at the origin)
	local hidden = ServerStorage:FindFirstChild("ArenaHidden") or Instance.new("Folder")
	hidden.Name = "ArenaHidden"
	hidden.Parent = ServerStorage
	for _, child in workspace:GetChildren() do
		if child == World or child:IsA("Terrain") or child:IsA("Camera") then
			continue
		end
		if (child:IsA("Model") or child:IsA("BasePart")) and touchesArena(child) then
			child.Parent = hidden
		end
	end
	local boards = World:FindFirstChild("Leaderboards")
	if boards then
		for _, board in boards:GetChildren() do
			if touchesArena(board) then
				board.Parent = hidden
			end
		end
	end

	print("[Arena] Arena map loaded")
end

return Loader

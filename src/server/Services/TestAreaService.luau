--!strict
-- Dev test area: admins try any Runner or God kit without starting a match.
--   * workspace.TestArea is built here: a floor with a border, a ramp and ledge for movement
--     skills, destructible cover for God strikes, and the test dummies (CombatConfig.TestDummies).
--   * Enter(player, "Runner" | "God", spot?) puts an admin in it with that role; Leave() sends them
--     back to the lobby. Runners stand on the floor; Gods get the overhead view like in a match.
--     spot "Course" puts a God above the real course instead (TestAreaSpot attribute).
--   * Options: no cooldowns (per player), moving dummies (for practising God aim), reset cover.
--   * Matches skip players with InTestArea (RoundService), and entering is blocked mid-match.
-- Used from the admin panel (TOOLS tab) and "/test area ..." (DevTestService).

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local TestAreaConfig = require(ReplicatedStorage.Shared.Config.TestAreaConfig)
local MoveGrace = require(ReplicatedStorage.Shared.Util.MoveGrace)
local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local TestAreaService = {}

local area: Model? = nil
local spawnDummies: (() -> ())? = nil

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

local function at(offset: Vector3): CFrame
	return CFrame.new(TestAreaConfig.Center + offset)
end

-- ------------------------------------------------------------------ building
local function buildCover(model: Model)
	local old = model:FindFirstChild("Cover")
	if old then
		old:Destroy()
	end
	local cover = Instance.new("Folder")
	cover.Name = "Cover"
	cover.Parent = model
	local colors = TestAreaConfig.Colors
	-- Destructible walls and a pillar: God strikes chip these down (same tag as the course cover).
	for _, info in {
		{ Vector3.new(-40, 4, 10), Vector3.new(16, 8, 2) },
		{ Vector3.new(0, 4, 20), Vector3.new(16, 8, 2) },
		{ Vector3.new(40, 4, 10), Vector3.new(16, 8, 2) },
		{ Vector3.new(-20, 6, 40), Vector3.new(4, 12, 4) },
	} do
		local wall = block(cover, "Ruin", info[2], at(info[1]), colors.Cover, Enum.Material.Cobblestone)
		wall:SetAttribute("Health", TestAreaConfig.CoverHealth)
		CollectionService:AddTag(wall, "DestructibleCover")
	end
	-- Permanent shelter.
	for _, offset in { Vector3.new(25, 4, 45), Vector3.new(-55, 4, 45) } do
		block(cover, "Boulder", Vector3.new(9, 8, 9), at(offset), colors.Boulder, Enum.Material.Slate, { Shape = Enum.PartType.Ball })
	end
end

local function sign(parent: Instance, offset: Vector3, title: string, sub: string)
	local post = block(parent, "Sign", Vector3.new(1, 1, 1), at(offset), Color3.new(1, 1, 1), Enum.Material.SmoothPlastic, { Transparency = 1, CanCollide = false, CanQuery = false })
	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.fromOffset(320, 70)
	billboard.AlwaysOnTop = false
	billboard.MaxDistance = 160
	billboard.Parent = post
	for i, text in { title, sub } do
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(1, 0, if i == 1 then 0.6 else 0.4, 0)
		label.Position = UDim2.fromScale(0, if i == 1 then 0 else 0.6)
		label.Font = if i == 1 then Enum.Font.GothamBlack else Enum.Font.GothamMedium
		label.TextScaled = true
		label.TextColor3 = if i == 1 then TestAreaConfig.Colors.Lines else Color3.fromRGB(226, 232, 240)
		label.TextStrokeTransparency = 0.4
		label.Text = text
		label.Parent = billboard
	end
end

local function build(): Model
	local existing = workspace:FindFirstChild("TestArea")
	if existing and existing:IsA("Model") then
		return existing
	end
	local cfg = TestAreaConfig
	local colors = cfg.Colors
	local size = cfg.Size
	local model = Instance.new("Model")
	model.Name = "TestArea"

	block(model, "Floor", Vector3.new(size, 4, size), at(Vector3.new(0, -2, 0)), colors.Floor, Enum.Material.Concrete)
	-- Grid lines every 20 studs so distances (dash lengths, blink range) are easy to read.
	local lines = Instance.new("Folder")
	lines.Name = "GridLines"
	lines.Parent = model
	for i = -size / 2 + 20, size / 2 - 20, 20 do
		for _, horizontal in { true, false } do
			local lineSize = if horizontal then Vector3.new(size, 0.1, 0.3) else Vector3.new(0.3, 0.1, size)
			local offset = if horizontal then Vector3.new(0, 0.05, i) else Vector3.new(i, 0.05, 0)
			block(lines, "Line", lineSize, at(offset), colors.Lines, Enum.Material.Neon, { Transparency = 0.7, CanCollide = false, CanQuery = false, CastShadow = false })
		end
	end
	-- Border.
	for _, side in { -1, 1 } do
		block(model, "Wall", Vector3.new(size + 4, cfg.WallHeight, 2), at(Vector3.new(0, cfg.WallHeight / 2, side * (size / 2 + 1))), colors.Wall, Enum.Material.Concrete)
		block(model, "Wall", Vector3.new(2, cfg.WallHeight, size + 4), at(Vector3.new(side * (size / 2 + 1), cfg.WallHeight / 2, 0)), colors.Wall, Enum.Material.Concrete)
	end
	-- Movement course along the east side: a ramp up to a ledge, then a gap to a second ledge.
	block(model, "Ramp", Vector3.new(14, 1, 30), at(Vector3.new(75, 5, 40)) * CFrame.Angles(math.rad(-20), 0, 0), colors.Ramp, Enum.Material.DiamondPlate)
	block(model, "Ledge", Vector3.new(14, 10, 20), at(Vector3.new(75, 5, 15)), colors.Ramp, Enum.Material.DiamondPlate)
	block(model, "Ledge", Vector3.new(14, 10, 20), at(Vector3.new(75, 5, -25)), colors.Ramp, Enum.Material.DiamondPlate)
	-- A low wall to vault and a tall one to blink through / wall-run along.
	block(model, "LowWall", Vector3.new(30, 3, 2), at(Vector3.new(-60, 1.5, -10)), colors.Wall, Enum.Material.Concrete)
	block(model, "TallWall", Vector3.new(2, 16, 40), at(Vector3.new(-80, 8, -40)), colors.Wall, Enum.Material.Concrete)

	-- Markers (invisible).
	local marker = { Transparency = 1, CanCollide = false, CanQuery = false, CanTouch = false, CastShadow = false }
	block(model, "RunnerSpawn", Vector3.new(10, 1, 10), at(cfg.RunnerSpawn), colors.Floor, Enum.Material.SmoothPlastic, marker)
	block(model, "Center", Vector3.new(1, 1, 1), at(Vector3.new(0, 0.5, 0)), colors.Floor, Enum.Material.SmoothPlastic, marker)

	sign(model, cfg.RunnerSpawn + Vector3.new(0, 7, -6), "TEST AREA", "Admin panel (F2) → TOOLS to switch role or leave")
	buildCover(model)
	model.Parent = workspace
	return model
end

-- ------------------------------------------------------------------ placing players
local function place(player: Player)
	local character = player.Character
	local root = character and Characters.GetRoot(character)
	if not character or not root then
		return
	end
	local cfg = TestAreaConfig
	if player:GetAttribute("Role") == "God" then
		-- Like a match: the God's body waits in the sky and takes no part.
		local below = cfg.Center
		if player:GetAttribute("TestAreaSpot") == "Course" then
			local course = workspace:FindFirstChild("Course") or workspace:FindFirstChild("CourseMarkers")
			local start = course and course:FindFirstChild("StartSpawn")
			if start and start:IsA("BasePart") then
				below = start.Position
			end
		end
		character:PivotTo(CFrame.new(below + Vector3.new(0, cfg.GodHeight, 0)))
		root.Anchored = true
		for _, d in character:GetDescendants() do
			if d:IsA("BasePart") then
				d.CanCollide = false
				d.CanQuery = false
			end
		end
	else
		root.Anchored = false
		local spawn = cfg.Center + cfg.RunnerSpawn
		MoveGrace.Teleport(character, CFrame.lookAt(spawn, spawn + Vector3.new(0, 0, -1)))
	end
end

local function freshCharacter(player: Player)
	task.spawn(function()
		player:LoadCharacter()
	end)
end

-- ------------------------------------------------------------------ API
function TestAreaService.SetDummySpawner(fn: () -> ())
	spawnDummies = fn
end

function TestAreaService.IsInside(player: Player): boolean
	return player:GetAttribute("InTestArea") == true
end

-- Puts a player in the test area as a Runner or a God. Returns (ok, message).
function TestAreaService.Enter(player: Player, role: string, spot: string?): (boolean, string)
	if role ~= "Runner" and role ~= "God" then
		return false, "Role must be Runner or God."
	end
	if spot == "Course" and role ~= "God" then
		return false, "Only the God can test over the course (Runners would be stuck behind the start barrier)."
	end
	if player:GetAttribute("InRound") then
		return false, "You're in a match. End it first (TOOLS → End round / match)."
	end
	area = area or build()
	if not workspace:FindFirstChild("TestDummies") and spawnDummies then
		spawnDummies()
	end
	local wasRunnerHere = TestAreaService.IsInside(player) and player:GetAttribute("Role") == "Runner"
	player:SetAttribute("InTestArea", true)
	player:SetAttribute("TestAreaSpot", if spot == "Course" then "Course" else nil)
	player:SetAttribute("Role", role) -- AbilityService refreshes cooldowns and God energy on this
	if wasRunnerHere and role == "Runner" and player.Character then
		-- Already a Runner here: just go back to the spawn.
		place(player)
	else
		-- A fresh body clears God anchoring / no-collide; CharacterAdded places it.
		freshCharacter(player)
	end
	if spot == "Course" then
		return true, "God over the course (no match). Equip kits in the admin panel."
	end
	return true, `Test area: you're a {role}. Equip kits in the admin panel.`
end

function TestAreaService.Leave(player: Player): (boolean, string)
	if not TestAreaService.IsInside(player) then
		return false, "You're not in the test area."
	end
	player:SetAttribute("InTestArea", nil)
	player:SetAttribute("TestAreaSpot", nil)
	player:SetAttribute("TestNoCooldowns", nil)
	player:SetAttribute("Role", nil)
	freshCharacter(player)
	return true, "Back to the lobby."
end

function TestAreaService.ToggleNoCooldowns(player: Player): (boolean, string)
	if not TestAreaService.IsInside(player) then
		return false, "Enter the test area first."
	end
	local on = not player:GetAttribute("TestNoCooldowns")
	player:SetAttribute("TestNoCooldowns", on or nil)
	for i = 1, 5 do
		player:SetAttribute(`Cooldown{i}`, nil)
	end
	return true, `No cooldowns / free casts: {if on then "ON" else "OFF"}`
end

function TestAreaService.ToggleMovingDummies(): (boolean, string)
	local on = not workspace:GetAttribute("TestDummiesMove")
	workspace:SetAttribute("TestDummiesMove", on or nil)
	return true, `Moving dummies: {if on then "ON" else "OFF"}`
end

function TestAreaService.Reset(): (boolean, string)
	area = area or build()
	buildCover(area :: Model)
	if spawnDummies then
		spawnDummies()
	end
	return true, "Test area reset: cover rebuilt, dummies respawned."
end

-- No-cooldown mode is only honoured inside the test area (AbilityService checks this).
function TestAreaService.FreeCasts(player: Player): boolean
	return TestAreaService.IsInside(player) and player:GetAttribute("TestNoCooldowns") == true
end

-- ------------------------------------------------------------------ lifecycle
local function patrol()
	-- Moving dummies walk left and right of where they stand, so God aim gets practice.
	local leg = 1
	while true do
		task.wait(TestAreaConfig.PatrolInterval)
		local folder = workspace:FindFirstChild("TestDummies")
		if folder then
			local moving = workspace:GetAttribute("TestDummiesMove") == true
			leg = -leg
			for _, dummy in folder:GetChildren() do
				local humanoid = dummy:FindFirstChildOfClass("Humanoid")
				local root = Characters.GetRoot(dummy :: Model)
				if humanoid and root and humanoid.Health > 0 then
					local home = dummy:GetAttribute("Home")
					if typeof(home) ~= "Vector3" then
						home = root.Position
						dummy:SetAttribute("Home", home)
					end
					local goal = if moving then (home :: Vector3) + Vector3.new(leg * TestAreaConfig.PatrolDistance, 0, 0) else home :: Vector3
					humanoid.WalkSpeed = 16
					humanoid:MoveTo(goal)
				end
			end
		end
	end
end

function TestAreaService.Init() end

function TestAreaService.Start()
	-- Build it up front in Studio so it can be seen in Play mode; live servers build on first use.
	if RunService:IsStudio() then
		area = build()
	end
	local function watch(player: Player)
		player.CharacterAdded:Connect(function(character)
			if not TestAreaService.IsInside(player) then
				return
			end
			character:WaitForChild("HumanoidRootPart", 10)
			task.wait() -- let spawn placement finish first
			if TestAreaService.IsInside(player) then
				place(player)
			end
		end)
	end
	for _, player in Players:GetPlayers() do
		watch(player)
	end
	Players.PlayerAdded:Connect(watch)
	task.spawn(patrol)
	-- The dummy row stays where CombatConfig puts it; mention it once for anyone moving the area.
	if (CombatConfig.TestDummies.Origin - TestAreaConfig.Center).Magnitude > TestAreaConfig.Size then
		warn("[TestArea] CombatConfig.TestDummies.Origin is outside the test area.")
	end
end

return TestAreaService

--!strict
-- The dev test area (TestAreaService): a practice yard where admins try Runner and God kits
-- without starting a match. Only admins can enter (AdminService.IsAdmin). Matches ignore anyone
-- inside it, so testing never pulls a dev into a round and a round never pulls them out.

local TestAreaConfig = {}

-- Away from the lobby (around 0, 0, 0) and the course (X 515-685).
TestAreaConfig.Center = Vector3.new(-400, 0, 0)
TestAreaConfig.Size = 200 -- square floor, studs
TestAreaConfig.WallHeight = 6

-- Where things go, relative to Center.
TestAreaConfig.RunnerSpawn = Vector3.new(0, 3, 70) -- Runners start here, facing the dummies (-Z)
TestAreaConfig.GodHeight = 250 -- God bodies wait this high above Center (like in a match)

-- Moving dummies walk this far left and right of where they stand.
TestAreaConfig.PatrolDistance = 25
TestAreaConfig.PatrolInterval = 2.5 -- seconds per leg

-- In no-cooldown mode a skill can be used again after this many seconds (stops accidental spam).
TestAreaConfig.NoCooldownDelay = 0.3

TestAreaConfig.CoverHealth = 120

TestAreaConfig.Colors = {
	Floor = Color3.fromRGB(70, 78, 92),
	Lines = Color3.fromRGB(56, 189, 248),
	Wall = Color3.fromRGB(45, 52, 66),
	Cover = Color3.fromRGB(150, 146, 136),
	Boulder = Color3.fromRGB(98, 104, 84),
	Ramp = Color3.fromRGB(120, 128, 140),
}

return TestAreaConfig

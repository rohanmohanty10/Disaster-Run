local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local spawnFolder = script.Parent
local spawnStudio = spawnFolder:WaitForChild("SpawnLocationStudio")
local spawnLive = spawnFolder:WaitForChild("SpawnLocationLive")

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		local hrp = character:WaitForChild("HumanoidRootPart")

		-- Use task.wait() to ensure the character has physically 
		-- loaded before we try to teleport them
		task.wait(0.1) 

		if RunService:IsStudio() then
			-- Teleport to Studio Spawn
			hrp.CFrame = spawnStudio.CFrame * CFrame.new(0, 3, 0)
			print("Dev Mode: Spawned at Studio Location")
		else
			-- Teleport to Live Game Spawn
			hrp.CFrame = spawnLive.CFrame * CFrame.new(0, 3, 0)
			print("Live Mode: Spawned at Live Location")
		end
	end)
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Handle players who might have joined before the script ran
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end
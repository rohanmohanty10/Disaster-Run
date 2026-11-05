--[[
	RaycastProbe (LocalScript) - TEMPORARY DIAGNOSTIC
	Place in: StarterPlayer > StarterPlayerScripts

	Press P while standing/floating on the invisible surface. It raycasts
	straight down from your HumanoidRootPart and prints what's under you:
	the instance name, its full path, class, position, distance, and whether
	it's CanCollide. Delete this script once you've identified the culprit.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode ~= Enum.KeyCode.P then return end

	local character = player.Character
	if not character then warn("[Probe] No character") return end
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then warn("[Probe] No HumanoidRootPart") return end

	local origin = hrp.Position
	local direction = Vector3.new(0, -500, 0) -- 500 studs straight down

	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { character } -- ignore ourselves
	params.IgnoreWater = false -- also catch Terrain water if any

	local result = workspace:Raycast(origin, direction, params)

	print("=========== DROWN PROBE ===========")
	print("Your Y position:", string.format("%.2f", origin.Y))

	if result then
		local hit = result.Instance
		-- Build full path
		local path = hit.Name
		local node = hit.Parent
		while node and node ~= game do
			path = node.Name .. "." .. path
			node = node.Parent
		end

		print("HIT SOMETHING:")
		print("  Name:      ", hit.Name)
		print("  Full path: ", path)
		print("  ClassName: ", hit.ClassName)
		print("  Hit Y:     ", string.format("%.2f", result.Position.Y))
		print("  Distance:  ", string.format("%.2f", result.Distance), "studs below you")
		print("  CanCollide:", hit.CanCollide)
		print("  Transparency:", hit.Transparency)
		print("  Anchored:  ", hit.Anchored)
		print("  Material:  ", result.Material.Name)
	else
		print("HIT NOTHING within 500 studs below you.")
		print("(If you're floating but nothing's below, the hold is a force/anchor, not a floor.)")
	end
	print("===================================")
end)
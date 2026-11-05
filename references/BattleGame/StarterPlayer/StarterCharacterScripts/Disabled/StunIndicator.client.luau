local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local OFFSET = Vector3.new(0, 4.5, 0)

local function hookCharacter(character: Model)
	local hrp = character:WaitForChild("HumanoidRootPart", 5)
	if not hrp then return end

	local block = character:WaitForChild("StunIndicator", 5)
	if not block or not block:IsA("BasePart") then return end

	local conn
	conn = RunService.RenderStepped:Connect(function()
		if not character.Parent or not hrp.Parent or not block.Parent then
			conn:Disconnect()
			return
		end
		block.CFrame = CFrame.new(hrp.Position + OFFSET)
	end)
end

local function onPlayer(plr: Player)
	plr.CharacterAdded:Connect(hookCharacter)
	if plr.Character then
		hookCharacter(plr.Character)
	end
end

for _, plr in ipairs(Players:GetPlayers()) do
	onPlayer(plr)
end
Players.PlayerAdded:Connect(onPlayer)

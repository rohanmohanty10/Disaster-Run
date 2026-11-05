local rp = game:GetService("ReplicatedStorage")
local remotes = rp:WaitForChild("Remotes")
local player = game:GetService("Players").LocalPlayer
local button = script.Parent

button.Activated:Connect(function()
	remotes.Ulted:FireServer(player:GetAttribute("Character"))
end)
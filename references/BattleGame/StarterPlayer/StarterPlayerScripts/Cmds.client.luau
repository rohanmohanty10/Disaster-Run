local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SetCommand = RS.Remotes.Commands.Set

local player = Players.LocalPlayer

player.Chatted:Connect(function(message)
	if message:sub(1, 7) == "!speed " then
		local speed = tonumber(message:sub(8))
		if speed then
			print("Fired Custom")
			SetCommand:FireServer("CustomSpeed", { Speed = speed })
		end
	end
end)
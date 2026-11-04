 

 

local Players = game:GetService("Players");
local PlayerPreferences = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("PlayerPreferences");
local u2 = Players.LocalPlayer.Idled:Connect(function(p1) -- Line: 5
    -- upvalues: PlayerPreferences (copy)
    PlayerPreferences:FireServer("Idled", p1);
end);
script.Destroying:Connect(function() -- Line: 8
    -- upvalues: u2 (copy)
    u2:Disconnect();
end);
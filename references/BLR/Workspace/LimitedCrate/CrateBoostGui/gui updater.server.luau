  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerModifiers = ReplicatedStorage.ServerModifiers;
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local ChancesBoosted = script.Parent.Parent:WaitForChild("PremiumCrateOrigin"):WaitForChild("ChancesBoosted");
local Chances = script.Parent.Parent:WaitForChild("PremiumCrateOrigin"):WaitForChild("Chances");

while true do
    local Attribute = ServerModifiers:GetAttribute("CrateBoostTimer");

    if Attribute and workspace:GetServerTimeNow() < Attribute then
        ChancesBoosted.Enabled = true;
        Chances.Enabled = false;
        script.Parent.Enabled = true;
        script.Parent.Timer.Text = FormatNumber.AdaptiveClockString(Attribute - workspace:GetServerTimeNow(), true, 2);
    else
        ChancesBoosted.Enabled = false;
        Chances.Enabled = true;
        script.Parent.Enabled = false;
    end;

    task.wait(1);
end;
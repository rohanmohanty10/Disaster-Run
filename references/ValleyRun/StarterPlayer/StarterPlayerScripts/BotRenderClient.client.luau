 

 

if not require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    return;
end;

local Bots = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("Bots");
local u1 = require(Bots:WaitForChild("ClientBotRenderer")).new();
u1:start();
script.Destroying:Connect(function() -- Line: 9
    -- upvalues: u1 (copy)
    u1:stop();
end);
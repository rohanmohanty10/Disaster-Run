  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("Players");
local _ = game.Players.LocalPlayer;
ReplicatedStorage:WaitForChild("Football");
local u1 = nil;
local Knit = require(ReplicatedStorage.Packages.Knit);
local v2 = Knit.CreateController({
    Name = "NetworkController"
});

function v2.KnitStart(p3) -- Line: 15
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("BallService");
    tick();
end;

return v2;
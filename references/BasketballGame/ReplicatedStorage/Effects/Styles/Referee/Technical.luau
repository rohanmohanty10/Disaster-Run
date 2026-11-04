 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: Players (copy), SfxManager (copy), Effects (copy)
    local Character = p2.Character;
    SfxManager:playSound({
        Sound = "BBZ Referee Technical",
        Parent = Character:FindFirstChild("HumanoidRootPart")
    });
    Effects:SubtitleV2({
        { Players:FindFirstChild(Character.Name), "You can\'t do that!", 1 }
    });
end;
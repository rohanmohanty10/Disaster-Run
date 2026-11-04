 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 20, Name: GearAbility
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u5 = p6.Network;

    if not p6.RubberGear then
        p6.RubberGear = "Defensive";
    end;

    local v7 = script:FindFirstChild(p6.RubberGear);
    require(v7)(p6);
end;
 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(p5) -- Line: 19
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), Effects (copy), CameraShaker (copy), Essentials (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p5.CameraController;
    u2 = p5.AbilityService;
    u3 = p5.Animations;
    u4 = p5.Network;

    if p5:HoopDist() > 150 then
        Effects:Popup("Too far away from hoop", 3);
        p5:ResetCD(4);

        return;
    end;

    u1.CamShake:Shake(CameraShaker.Presets.Dunk);
    u2.Ability:Fire("Phantom Twin", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local math_random_ret = math.random(1, 2);
    u3:PlayChar("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u4.CharValues)}`, Enum.AnimationPriority.Action2);
    u3:PlayBall("Passes", `Pass{math_random_ret}{Essentials:ReturnRorL(u4.CharValues)}`, Enum.AnimationPriority.Action2);
end;
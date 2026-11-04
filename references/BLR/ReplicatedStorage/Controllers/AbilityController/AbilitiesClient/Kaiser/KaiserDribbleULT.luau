  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local u1 = require(script["On-Ball"]);
local u2 = require(script["Off-Ball"]);

return function(p3, p4, p5) -- Line: 19, Name: KaiserDribble
    -- upvalues: Popup (copy), u1 (copy), u2 (copy)
    if p3.AbilityThree > tick() then
        return;
    end;

    if p3.ABC then
        p3.ABC:Clean();
    end;

    if p5.Humanoid:GetState() == Enum.HumanoidStateType.Freefall or p5.Humanoid:GetState() == Enum.HumanoidStateType.Jumping then
        Popup.Popup(nil, "Must be on the ground to use dribble");

        return;
    end;

    if not p5.Values.HasBall.Value then
        return u2(p3, p4, p5);
    end;

    if not p5:GetAttribute("KaiserDribbleTake") then
        return u1(p3, p4, p5);
    end;

    Popup.Popup(nil, "You can\'t use this skill right now!");
end;
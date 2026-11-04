 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 19, Name: DunkOverHeaven
    -- upvalues: LocalPlayer (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref)
    local math_abs_ret = math.abs(LocalPlayer.Character.HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X);

    if math_abs_ret < 115 or math_abs_ret > 160 then
        p5:ResetCD(4);
        Effects:Popup("Only usable from center of the field!");

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.CameraController;
    u4:SetShiftlock(false);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9.5, function() -- Line: 37
        -- upvalues: u2 (ref), u4 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u4:SetShiftlock(true);
    end);
    u3:StopAll();
    u1.Ability:Fire("DunkOverHeaven", {
        TimeSent = workspace:GetServerTimeNow()
    });
    p5:StillHasBall();
end;
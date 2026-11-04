 
 

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
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 22, Name: TruePower
    -- upvalues: LocalPlayer (copy), u2 (ref), u4 (ref), u1 (ref), u3 (ref), u5 (ref), Effects (copy)
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u5 = p6.Network;
    local v7 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position;

    if v7:Dot(v7) > 22500 then
        Effects:Popup("Too far away from hoop!", 1);
        p6:ResetCD(3);

        return;
    end;

    local EnemyWithBallWithinDistance, v8 = u4:GetEnemyWithBallWithinDistance(50);

    if EnemyWithBallWithinDistance == nil then
        Effects:Popup("An enemy player with the ball must be close to you!", 1);
        p6:ResetCD(3);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(29.416666666666668, function() -- Line: 88
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("TruePower", {
        TimeSent = workspace:GetServerTimeNow(),
        Target = v8
    });
end;
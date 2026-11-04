 
 

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

return function(p5) -- Line: 21, Name: AwakenAbility1
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), LocalPlayer (copy)
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.BallController;

    if u4:GetPlayerPossessingBall() then
        p5:ResetCD(3);
        Effects:Popup("Ball must not be on a player!");

        return;
    end;

    local v6 = workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position - LocalPlayer.Character.HumanoidRootPart.Position;

    if v6:Dot(v6) >= 10000 then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    if not u4:LocalPlayerIsWithinDistanceOfBall(30) then
        p5:ResetCD(3);
        Effects:Popup("Too far away from hoop!", 1);

        return;
    end;

    if u4:GetServerBallPosition().Y < 15 then
        p5:ResetCD(3);
        Effects:Popup("Ball is too low!", 1);

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(12.25, function() -- Line: 64
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("NextGame", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
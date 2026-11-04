 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(p5) -- Line: 22, Name: NotMyReality
    -- upvalues: u2 (ref), u4 (ref), u1 (ref), u3 (ref), Effects (copy), RunService (copy), LocalPlayer (copy), Essentials (copy)
    u2 = p5.MovementController;
    u4 = p5.BallController;
    u1 = p5.AbilityService;
    u3 = p5.Animations;

    if u4:GetPlayerPossessingBall() then
        p5:ResetCD(4);
        Effects:Popup("Ball must have been shot from enemy!");

        return;
    end;

    if not RunService:IsStudio() then
        local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();

        if not LastPlayerToPossessBall or LastPlayerToPossessBall.Team == LocalPlayer.Team then
            p5:ResetCD(4);
            Effects:Popup("Ball must have been shot from enemy!");

            return;
        end;
    end;

    local ServerBallPosition = u4:GetServerBallPosition();

    if ServerBallPosition.Y < 15 then
        p5:ResetCD(4);
        Effects:Popup("Ball must be in the air!");

        return;
    end;

    if not u4:LocalPlayerIsWithinDistanceOfBall(100) then
        p5:ResetCD(4);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    local v6 = ServerBallPosition - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position;

    if v6:Dot(v6) > 14400 then
        p5:ResetCD(4);
        Effects:Popup("Ball must have been shot at the hoop!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9, function() -- Line: 76
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("NotMyReality", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
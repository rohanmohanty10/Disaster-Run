 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p5) -- Line: 17
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), LocalPlayer (copy), Effects (copy), RunService (copy), Essentials (copy)
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

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

    local v6 = HumanoidRootPart.Position - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position;

    if v6:Dot(v6) > 8100 then
        p5:ResetCD(4);
        Effects:Popup("Too far away from hoop!");

        return;
    end;

    local v7 = ServerBallPosition - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position;

    if v7:Dot(v7) > 14400 then
        p5:ResetCD(4);
        Effects:Popup("Ball must have been shot at the hoop!");

        return;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(2.5, function() -- Line: 65
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Unc Block", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
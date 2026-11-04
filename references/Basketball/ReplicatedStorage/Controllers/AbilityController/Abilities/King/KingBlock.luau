 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local PositionIsInTwoPointZone = require(ReplicatedStorage.Shared.Functions.PositionIsInTwoPointZone);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p6) -- Line: 19
    -- upvalues: u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), LocalPlayer (copy), RunService (copy), Effects (copy), Essentials (copy), PositionIsInTwoPointZone (copy)
    u1 = p6.Network;
    u2 = p6.AbilityService;
    u4 = p6.Animations;
    u3 = p6.MovementController;
    u5 = p6.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v7;

    if RunService:IsStudio() then
        v7 = workspace.DefenseRig;
    else
        v7 = u5:GetLastCharacterToPossessBall();
        local PlayerPossessingBall = u5:GetPlayerPossessingBall();

        if v7 then
            if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
                p6:ResetCD(3);
                Effects:Popup("Ball must be on enemy player!");

                return;
            end;

            if v7.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v7.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                p6:ResetCD(3);
                Effects:Popup("Enemy player must be on the ground!");

                return;
            end;

            local v8 = Essentials:ActualTeam(LocalPlayer.Team.Name);

            if not PositionIsInTwoPointZone((u1.Gamemode == "Match-2v2" or u1.Gamemode == "Match-1v1") and "Ranked" or v8, v7.HumanoidRootPart.Position) then
                p6:ResetCD(3);
                Effects:Popup("Enemy player must be in the 2 point area!");

                return;
            end;
        elseif not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
            p6:ResetCD(3);
            Effects:Popup("Ball must have been shot from enemy!");

            return;
        end;

        if (v7.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 50 then
            p6:ResetCD(3);
            Effects:Popup("Enemy player too far away!");

            return;
        end;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(7.266666666666667, function() -- Line: 78
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u4:StopAll();
    u2.Ability:Fire("King\'s Block", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v7
    });
end;
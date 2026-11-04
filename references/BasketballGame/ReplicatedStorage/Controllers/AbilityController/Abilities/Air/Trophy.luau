 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p5) -- Line: 17
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), LocalPlayer (copy), RunService (copy), Effects (copy), Essentials (copy)
    u1 = p5.AbilityService;
    u2 = p5.Animations;
    u3 = p5.MovementController;
    u4 = p5.BallController;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    local v6;

    if RunService:IsStudio() then
        v6 = workspace.DefenseRig;
    else
        v6 = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if not v6 then
            p5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            p5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            p5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if v6.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v6.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            p5:ResetCD(3);
            Effects:Popup("Enemy player must be on the ground!");

            return;
        end;

        local v7 = v6.HumanoidRootPart.Position.X - workspace.Hoops[Essentials:ActualTeam(LocalPlayer.Team.Name)].Hoop.Position.X;

        if math.abs(v7) > 145 then
            p5:ResetCD(3);
            Effects:Popup("Only usable on your side of the court!");

            return;
        end;

        if (v6.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 70 then
            p5:ResetCD(3);
            Effects:Popup("Enemy player too far away!");

            return;
        end;
    end;

    u3.States.Ability = true;
    u3.States.NoWalk = true;
    task.delay(15.833, function() -- Line: 73
        -- upvalues: u3 (ref)
        u3.States.Ability = false;
        u3.States.NoWalk = false;
    end);
    u2:StopAll();
    u1.Ability:Fire("Trophy", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;
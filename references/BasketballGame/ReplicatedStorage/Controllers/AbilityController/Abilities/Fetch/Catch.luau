 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 18, Name: Intercept
    -- upvalues: LocalPlayer (copy), u2 (ref), u5 (ref), u4 (ref), u1 (ref), u3 (ref), Effects (copy), RunService (copy)
    local Character = LocalPlayer.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u2 = u6.MovementController;
    u5 = u6.CameraController;
    u4 = u6.BallController;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    local LastPlayerToPossessBall = u4:GetLastPlayerToPossessBall();

    if LastPlayerToPossessBall == nil then
        u6:ResetCD(3);
        Effects:Popup("Ball must be passed or shot!");

        return;
    end;

    if LastPlayerToPossessBall.Team == LocalPlayer.Team and not RunService:IsStudio() then
        u6:ResetCD(3);
        Effects:Popup("Ball must have been just passed or shot by enemy player!");

        return;
    end;

    if u4:GetPlayerPossessingBall() then
        u6:ResetCD(3);
        Effects:Popup("Ball must have been just passed or shot!");

        return;
    end;

    local v7 = u4:GetServerBallPosition() - HumanoidRootPart.Position;

    if v7:Dot(v7) >= 2500 then
        u6:ResetCD(3);
        Effects:Popup("Ball is too far away!");

        return;
    end;

    u1.Ability:Fire("Catch", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Connect(u1.Ability, function(p8) -- Line: 67
        -- upvalues: Effects (ref), u6 (copy), u2 (ref), u3 (ref)
        if p8.Fail then
            Effects:Popup("Ball must just have been passed or shot!");
            u6.CDS[3] = tick() + 1;

            return;
        end;

        u6:ResetCopy();
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u3:StopAll();
        task.delay(5.5, function() -- Line: 86
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
    end);
end;
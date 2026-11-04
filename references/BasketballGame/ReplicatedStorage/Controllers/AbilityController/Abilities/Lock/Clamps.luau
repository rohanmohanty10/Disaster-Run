 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(p5) -- Line: 22, Name: Clamps
    -- upvalues: u4 (ref), Effects (copy), LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref)
    u4 = p5.BallController;
    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall == nil then
        p5:ResetCD(3);
        Effects:Popup("Player with ball must be close!");

        return;
    end;

    local Character = PlayerPossessingBall.Character;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        p5:ResetCD(3);
        Effects:Popup("Ball must be on enemy team!");

        return;
    end;

    if Character == nil then
        p5:ResetCD(3);
        Effects:Popup("Player with ball must be close!");

        return;
    end;

    if Character.HumanoidRootPart.Position.Y > 9.5 then
        p5:ResetCD(3);
        Effects:Popup("Player with ball must be on the ground!");

        return;
    end;

    if (Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 50 then
        p5:ResetCD(3);
        Effects:Popup("Player with ball must be close!");

        return;
    end;

    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    local v6 = math.abs(HumanoidRootPart.Position.X - workspace.Hoops[LocalPlayer.Team.Name].Hoop.Position.X) > 145;

    if v6 then
        task.delay(9, function() -- Line: 55
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
    else
        task.delay(10, function() -- Line: 57
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end);
    end;

    u3:StopAll();
    u1.Ability:Fire("Clamps", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = Character,
        OurSide = v6
    });
end;
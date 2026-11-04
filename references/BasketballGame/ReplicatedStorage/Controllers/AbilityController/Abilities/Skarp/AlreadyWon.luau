 
 

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

return function(p5) -- Line: 22, Name: AlreadyWon
    -- upvalues: u4 (ref), Effects (copy), LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref)
    u4 = p5.BallController;
    local PlayerPossessingBall = u4:GetPlayerPossessingBall();

    if PlayerPossessingBall == nil then
        p5:ResetCD(3);
        Effects:Popup("Player with ball must be close!");

        return;
    end;

    if PlayerPossessingBall.Team == LocalPlayer.Team then
        p5:ResetCD(3);
        Effects:Popup("Ball must be on enemy team!");

        return;
    end;

    local Character = PlayerPossessingBall.Character;

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

    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(9.5, function() -- Line: 62
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("AlreadyWon (Skarp)", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = Character
    });
end;
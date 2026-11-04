 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(p5) -- Line: 16
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), LocalPlayer (copy), RunService (copy), Effects (copy)
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.BallController;
    local _ = LocalPlayer.Character.HumanoidRootPart;
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

        if not (PlayerPossessingBall.Style:GetAttribute("AbilityIndex") and (PlayerPossessingBall.Style:GetAttribute("AbilityUsed") and PlayerPossessingBall.Style:GetAttribute("AbilityUsed") + 5 >= workspace:GetServerTimeNow())) then
            p5:ResetCD(3);
            Effects:Popup("Enemy player must have just used an ability!");

            return;
        end;

        if not (p5.CachedPillaged and (p5.CachedPillaged[PlayerPossessingBall.Name] and (p5.CachedPillaged[PlayerPossessingBall.Name][PlayerPossessingBall.Style.Value] and table.find(p5.CachedPillaged[PlayerPossessingBall.Name][PlayerPossessingBall.Style.Value], PlayerPossessingBall.Style:GetAttribute("AbilityIndex"))))) then
            p5:ResetCD(3);
            Effects:Popup("Enemy player must have used an ability that you have pillaged!");

            return;
        end;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(12.817, function() -- Line: 72
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("It\'s Mine", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;
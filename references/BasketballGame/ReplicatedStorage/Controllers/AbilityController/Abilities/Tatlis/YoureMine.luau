 
 

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

return function(u5) -- Line: 22, Name: YoureMine
    -- upvalues: LocalPlayer (copy), u2 (ref), u1 (ref), u4 (ref), u3 (ref), RunService (copy), Effects (copy)
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
    u2 = u5.MovementController;
    u1 = u5.AbilityService;
    u4 = u5.BallController;
    u3 = u5.Animations;

    if u5.Network.CharValues.HasBall then
        u2.States.Ability = true;
        u2.States.NoWalk = true;
        u5.AC:Add(task.delay(15, function() -- Line: 64
            -- upvalues: u2 (ref)
            u2.States.Ability = false;
            u2.States.NoWalk = false;
        end));
        u5.AC:Add(task.delay(3, function() -- Line: 71
            -- upvalues: u5 (copy), u3 (ref), u2 (ref)
            if workspace:FindFirstChild("CamRig") == nil then
                u5.AC:Clean();
                u5:ResetCD(3);
                u3:StopAll();
                u2.States.Ability = false;
                u2.States.NoWalk = false;
            end;
        end));
        u3:StopAll();
        u3:PlayChar("Tatlis", "YoureMine", Enum.AnimationPriority.Action4);
        u3:PlayBall("Tatlis", "YoureMineBall", Enum.AnimationPriority.Action4);
        u1.Ability:Fire("YoureMine", {
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    local v6;

    if RunService:IsStudio() then
        v6 = workspace.DefenseRig;
    else
        v6 = u4:GetCharacterPossessingBall();
        local PlayerPossessingBall = u4:GetPlayerPossessingBall();

        if v6 == nil then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if not PlayerPossessingBall then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if PlayerPossessingBall.Team == LocalPlayer.Team then
            u5:ResetCD(3);
            Effects:Popup("Ball must be on enemy player!");

            return;
        end;

        if v6.Humanoid:GetState() == Enum.HumanoidStateType.Jumping or v6.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            u5:ResetCD(3);
            Effects:Popup("Enemy player must be on the ground!");

            return;
        end;

        if (v6.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude > 70 then
            u5:ResetCD(3);
            Effects:Popup("Enemy player too far away!");

            return;
        end;
    end;

    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(13, function() -- Line: 52
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u3:PlayChar("Tatlis", "YoureMineOff", Enum.AnimationPriority.Action4);
    u3:PlayBall("Tatlis", "YoureMineOffBall", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("YoureMine", {
        TimeSent = workspace:GetServerTimeNow(),
        Other = v6
    });
end;
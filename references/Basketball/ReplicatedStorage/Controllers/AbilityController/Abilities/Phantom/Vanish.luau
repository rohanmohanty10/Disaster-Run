 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 17, Name: Vanish
    -- upvalues: LocalPlayer (copy), Effects (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), CameraShaker (copy), TweenService (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    local v7 = p6:CheckInfront(25);

    if v7 == nil then
        p6:ResetCD(4);
        Effects:Popup("Someone must be infront of you!");

        return;
    end;

    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.CameraController;
    u2.States.Ability = true;
    task.delay(1, function() -- Line: 31
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
    end);
    task.delay(0.3, function() -- Line: 33
        -- upvalues: u5 (ref), CameraShaker (ref)
        u5.CamShake:Shake(CameraShaker.Presets.Vanish);
    end);
    task.defer(function() -- Line: 38
        -- upvalues: TweenService (ref)
        local workspace_CurrentCamera = workspace.CurrentCamera;
        local v8 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            FieldOfView = 35
        });
        local v9 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
            FieldOfView = 90
        });
        v8:Play();
        task.wait(0.6);
        v9:Play();
    end);
    u3:StopAll();
    u3:PlayChar("Phantom", "Ability2", Enum.AnimationPriority.Action4);
    u3:PlayBall("Phantom", "Ability2Ball", Enum.AnimationPriority.Action4);
    u1.Ability:Fire("Vanish", {
        TimeSent = workspace:GetServerTimeNow(),
        OtherChar = v7
    });
end;
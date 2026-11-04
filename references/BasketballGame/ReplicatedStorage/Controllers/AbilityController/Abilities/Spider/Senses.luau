 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p7) -- Line: 21, Name: Senses
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), Effects (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local _ = Character.HumanoidRootPart;
    u1 = p7.Network;
    u2 = p7.AbilityService;
    u4 = p7.Animations;
    u3 = p7.MovementController;
    u5 = p7.BallController;
    u6 = p7.CameraController;
    Effects:Popup("SENSES ACTIVATED FOR 30 SECONDS");
    u2.Ability:Fire("Senses", {
        TimeSent = workspace:GetServerTimeNow()
    });
    local u8 = nil;
    u8 = u2.Ability:Connect(function(p9) -- Line: 38
        -- upvalues: u8 (ref), u4 (ref), u3 (ref)
        if p9.Stolen then
            u8:Disconnect();
            u4:StopAll();
            local v10 = u4:PlayChar("Spider", "ShotSense", Enum.AnimationPriority.Action3, true);
            local v11 = u4:PlayBall("Spider", "ShotSenseBall", Enum.AnimationPriority.Action3, true);
            v10:AdjustSpeed(1.65);
            v11:AdjustSpeed(1.65);
            u3.States.Ability = true;
            u3.States.NoWalk = true;
            task.delay(0.7676767676767677, function() -- Line: 51
                -- upvalues: u3 (ref)
                u3.States.NoWalk = false;
                u3.States.Ability = false;
            end);
        end;
    end);
    task.delay(31, function() -- Line: 58
        -- upvalues: u8 (ref)
        if u8 then
            u8:Disconnect();
        end;
    end);
end;
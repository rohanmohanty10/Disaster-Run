 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 18, Name: HandsUp
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), RunService (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u3 = u6.Animations;
    u2 = u6.MovementController;
    u4 = u6.BallController;
    u5 = u6.CameraController;
    u3:StopAll();
    local u7 = u3:PlayChar("Lock", "HandsUpStart", Enum.AnimationPriority.Action3, true);
    local u8 = u3:PlayChar("Lock", "HandsUpLoop", Enum.AnimationPriority.Action3, true);
    u2.States.Ability = true;
    u2.Boost = -3;
    u6.AC:Add(function() -- Line: 35
        -- upvalues: u2 (ref), u7 (copy), u8 (copy)
        u2.States.Ability = false;
        u2.Boost = 0;
        u7:Stop();
        u8:Stop();
    end);
    u6.AC:Add(task.delay(3, function() -- Line: 42
        -- upvalues: u6 (copy)
        u6.AC:Clean();
    end));
    u1.Ability:Fire("HandsUp", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u6.AC:Connect(RunService.Heartbeat, function() -- Line: 48
        -- upvalues: u6 (copy)
        if u6.Network.CharValues.HasBall then
            u6.AC:Clean();
        end;
    end);
    u6.AC:Connect(u1.Ability, function() -- Line: 54
        -- upvalues: u6 (copy), u3 (ref)
        u6.AC:Clean();

        if not u6.Network.CharValues.HasBall then
            u3:StopAll();
            u3:PlayChar("Blocks", "Blocked", Enum.AnimationPriority.Action3);
        end;
    end);
end;
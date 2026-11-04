 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
require(ReplicatedStorage.Shared.Utility.Raycast);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), VfxManager (copy), Essentials (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HasBall = p2.HasBall;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    SfxManager:playSound({
        Sound = "MeteorJamStart",
        Duration = 2,
        Parent = HumanoidRootPart
    });
    task.delay(HasBall and 0.25 or 0.01, function() -- Line: 24
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v4 = script.Jump:Clone();
        v4.Parent = workspace.Debris;
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -3, 0);
        VfxManager.Emit(v4);
        task.delay(4, v4.Destroy, v4);
    end);

    if HasBall then
        local BALL = Character:FindFirstChild("BALL", true);
        local u5;

        if BALL then
            u5 = script.BallTrail:Clone();
            u5.Parent = workspace.Debris;
            u5.CFrame = BALL.CFrame;
            Essentials:Weld(BALL, u5);
        else
            u5 = nil;
        end;

        task.delay(1.2, function() -- Line: 43
            -- upvalues: SfxManager (ref), HumanoidRootPart (copy)
            SfxManager:playSound({
                Sound = "MeteorJamThrow",
                Duration = 2,
                Parent = HumanoidRootPart
            });
        end);
        task.delay(1.34 - v3, function() -- Line: 47
            -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u5 (ref)
            local v6 = script.Throw:Clone();
            v6.Parent = workspace.Debris;
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, -6) * CFrame.Angles(-0.4363323129985824, 0, 0);
            VfxManager.Emit(v6);

            if u5 then
                u5:Destroy();
            end;

            task.delay(4, v6.Destroy, v6);
        end);
    end;
end;
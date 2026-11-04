 
 

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
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 19, Name: Jackpot
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), RunService (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.CameraController;
    u4:SetShiftlock(false);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(16.5, function() -- Line: 32
        -- upvalues: u2 (ref), u4 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u4:SetShiftlock(true);
    end);
    u3:StopAll();
    u1.Ability:Fire("Jackpot", {
        TimeSent = workspace:GetServerTimeNow()
    });
    p5.AC:Connect(u1.Ability, function(p6) -- Line: 43
        -- upvalues: Effects (ref), RunService (ref), u2 (ref)
        if p6 ~= 1 then
            Effects:Popup("SLOWER MOVEMENT SPEED FOR 10 SECONDS...", 2, Color3.new(1, 0.843137, 0.482353));
            local u7 = RunService.Heartbeat:Connect(function() -- Line: 76
                -- upvalues: u2 (ref)
                u2.Boost = -4;
            end);
            task.delay(10, function() -- Line: 79
                -- upvalues: u7 (ref), RunService (ref), u2 (ref)
                u7:Disconnect();
                RunService.Heartbeat:Wait();
                u2.Boost = 0;
            end);

            return;
        end;

        Effects:Popup("100% ANKLE BREAKERS GRANTED", 2, Color3.new(1, 0.843137, 0.482353));
        task.delay(0.5, function() -- Line: 46
            -- upvalues: Effects (ref)
            Effects:Popup("100% STEAL GUARANTEED", 2, Color3.new(1, 0.843137, 0.482353));
        end);
        task.delay(1, function() -- Line: 49
            -- upvalues: Effects (ref)
            Effects:Popup("MAY LUCK BE IN YOUR FAVOUR", 2, Color3.new(1, 0.843137, 0.482353));
        end);
        task.delay(15, function() -- Line: 53
            -- upvalues: Effects (ref)
            Effects:Popup("15 SECONDS LEFT.");
        end);
        task.delay(25, function() -- Line: 56
            -- upvalues: Effects (ref)
            for i = 1, 5 do
                Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                task.wait(1);
                local _ = i;
            end;

            Effects:Popup("BOOST ENDED, SEE YOU AGAIN SOON.");
        end);
        local u8 = RunService.Heartbeat:Connect(function() -- Line: 65
            -- upvalues: u2 (ref)
            u2.Boost = 5;
        end);
        task.delay(30, function() -- Line: 68
            -- upvalues: u8 (ref), RunService (ref), u2 (ref)
            u8:Disconnect();
            RunService.Heartbeat:Wait();
            u2.Boost = 0;
        end);
    end);
end;
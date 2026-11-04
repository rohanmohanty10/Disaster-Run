 
 

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

return function(u5) -- Line: 19, Name: Evolution
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), RunService (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.CameraController;
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
    u1.Ability:Fire("Evolution", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5.AC:Connect(u1.Ability, function() -- Line: 40
        -- upvalues: u5 (copy), Effects (ref), RunService (ref), u2 (ref)
        u5.InEvolution = true;
        Effects:Popup("INCREASED SPEED.", 2, Color3.new(1, 0.843137, 0.482353));
        task.delay(0.5, function() -- Line: 44
            -- upvalues: Effects (ref)
            Effects:Popup("INCREASED DRIBBLING POWER.", 2, Color3.new(1, 0.843137, 0.482353));
        end);
        task.delay(1, function() -- Line: 47
            -- upvalues: Effects (ref)
            Effects:Popup("YOU ARE PERFECT.", 2, Color3.new(0.321569, 1, 0.368627));
        end);
        task.delay(1.5, function() -- Line: 50
            -- upvalues: Effects (ref)
            Effects:Popup("BOOSTS END IN 40 SECONDS OR WHEN AWAKENING ENDS.", 2, Color3.new(1, 0.2, 0.2));
        end);
        task.delay(35, function() -- Line: 54
            -- upvalues: u5 (ref), Effects (ref)
            for i = 1, 5 do
                if not u5.Network.CharValues.InAwakening then
                    return;
                end;

                Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                task.wait(1);
                local _ = i;
            end;

            Effects:Popup("BOOST ENDED.");
        end);
        local u6 = nil;
        u6 = RunService.Heartbeat:Connect(function() -- Line: 64
            -- upvalues: u2 (ref), u5 (ref), u6 (ref), RunService (ref)
            u2.Boost = 4;

            if not u5.Network.CharValues.InAwakening then
                u6:Disconnect();
                RunService.Heartbeat:Wait();
                u5.InEvolution = nil;
                u2.Boost = 0;
            end;
        end);
        task.delay(40, function() -- Line: 74
            -- upvalues: u5 (ref), u6 (ref), RunService (ref), u2 (ref)
            u5.InEvolution = nil;
            u6:Disconnect();
            RunService.Heartbeat:Wait();
            u2.Boost = 0;
        end);
    end);
end;
 
 

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
local LocalPlayer = game.Players.LocalPlayer;
RunService:IsStudio();

return function(u4) -- Line: 22, Name: Chaos
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), RunService (copy), Effects (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = u4.AbilityService;
    u3 = u4.Animations;
    u2 = u4.MovementController;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(12.5, function() -- Line: 32
        -- upvalues: u2 (ref), u4 (copy), RunService (ref), Effects (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        u4.ChaosMode = true;
        u2.Boost = 10;
        local u5 = nil;
        u5 = RunService.Heartbeat:Connect(function() -- Line: 37
            -- upvalues: u2 (ref), u4 (ref), u5 (ref)
            u2.Boost = 10;

            if u4.Network.CharValues.InAwakening == false then
                u5:Disconnect();
                u5 = nil;
                u2.Boost = 0;
                u4.ChaosMode = nil;
            end;
        end);
        Effects:Popup("CHAOS MODE ENDING IN 40 SECONDS.", 2, Color3.new(0.603922, 0.603922, 0.603922));
        Effects:Popup("MONSTER RUN/DUNK AND DRIBBLE ACTIVATED.", 2, Color3.new(1, 0.278431, 0.278431));
        task.delay(35, function() -- Line: 50
            -- upvalues: u5 (ref), Effects (ref), u4 (ref), u2 (ref)
            if u5 then
                u5:Disconnect();
                u5 = nil;

                for i = 1, 4 do
                    task.wait(1);
                    Effects:Popup((`CHAOS MODE ENDING IN {5 - i}`));
                    local _ = i;
                end;

                u4.ChaosMode = nil;
                u2.Boost = 0;
            end;
        end);
    end);
    u3:StopAll();
    u1.Ability:Fire("Chaos", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
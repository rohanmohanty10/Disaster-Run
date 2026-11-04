 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Trove);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Tables.Zones);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u7) -- Line: 22
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), LocalPlayer (copy), Effects (copy), RunService (copy)
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local _ = Character.HumanoidRootPart;
    u1.Ability:Fire("The King Of Curses", {
        TimeSent = workspace:GetServerTimeNow()
    });
    task.wait(15.983);
    u7.AC:Connect(u1.Ability, function() -- Line: 38
        -- upvalues: Effects (ref), RunService (ref), u2 (ref), u7 (copy)
        Effects:Popup("YOU\'RE THE KING OF CURSES.", 2, Color3.new(0.607843, 0.164706, 0.164706));
        task.delay(0.5, function() -- Line: 40
            -- upvalues: Effects (ref)
            Effects:Popup("AUTO DRIBBLE ACTIVATED.", 2, Color3.new(1, 1, 1));
            Effects:Popup("MAKE THEM BOW THEIR HEADS.", 2, Color3.new(0, 0, 0));
        end);
        task.delay(1, function() -- Line: 44
            -- upvalues: Effects (ref)
            Effects:Popup("SPEED INCREASED.", 2, Color3.new(1, 1, 1));
            Effects:Popup("THEY CAN TRY TO CATCH YOU.", 2, Color3.new(0, 0, 0));
        end);
        task.delay(1.5, function() -- Line: 48
            -- upvalues: Effects (ref)
            Effects:Popup("MODE ENDS IN 20 SECONDS OR WHEN AWAKENING ENDS.", 2, Color3.new(1, 0.2, 0.2));
        end);
        task.delay(15, function() -- Line: 52
            -- upvalues: Effects (ref)
            for i = 1, 5 do
                Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                task.wait(1);
                local _ = i;
            end;

            Effects:Popup("MODE ENDED.");
        end);
        local u8 = nil;
        u8 = RunService.Heartbeat:Connect(function() -- Line: 61
            -- upvalues: u2 (ref), u7 (ref), u8 (ref), RunService (ref)
            u2.Boost = 10;

            if not u7.Network.CharValues.InAwakening then
                u8:Disconnect();
                RunService.Heartbeat:Wait();
                u2.Boost = 0;
            end;
        end);
        task.delay(20, function() -- Line: 70
            -- upvalues: u8 (ref), RunService (ref), u2 (ref)
            u8:Disconnect();
            RunService.Heartbeat:Wait();
            u2.Boost = 0;
        end);
    end);
end;
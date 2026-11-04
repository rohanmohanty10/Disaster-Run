 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
game:GetService("TweenService");
game:GetService("RunService");
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
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), u6 (ref), LocalPlayer (copy), Effects (copy)
    u1 = u7.AbilityService;
    u2 = u7.MovementController;
    u3 = u7.BallController;
    u4 = u7.CameraController;
    u5 = u7.Animations;
    u6 = u7.Network;
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local _ = Character.HumanoidRootPart;
    Effects:Popup("INCREASED SPEED, INCREASED DRIBBLING POWER AND DISABLED ABILITIES FOR 15 SECONDS!", 6);
    u7.InDisable = true;
    local v8 = u2;
    v8.Boost = v8.Boost + 10;
    task.delay(15, function() -- Line: 37
        -- upvalues: u7 (copy), u2 (ref)
        u7.InDisable = nil;
        local v9 = u2;
        v9.Boost = v9.Boost - 10;

        if u2.Boost < 0 then
            u2.Boost = 0;
        end;
    end);
    u1.Ability:Fire("Disable", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
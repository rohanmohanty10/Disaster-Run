 
 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u6) -- Line: 19
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = u6.AbilityService;
    u2 = u6.MovementController;
    u3 = u6.BallController;
    u4 = u6.Animations;
    u5 = u6.Network;
    Effects:Popup("INCREASED SPEED, INCREASED DRIBBLING POWER FOR 15 SECONDS!", 6);
    u6.InNewWorld = true;
    local v7 = u2;
    v7.Boost = v7.Boost + 10;
    task.delay(15, function() -- Line: 33
        -- upvalues: u6 (copy), u2 (ref)
        u6.InNewWorld = nil;
        local v8 = u2;
        v8.Boost = v8.Boost - 10;

        if u2.Boost < 0 then
            u2.Boost = 0;
        end;
    end);
    u1.Ability:Fire("New World", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
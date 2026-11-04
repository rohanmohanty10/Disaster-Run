 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(u5) -- Line: 22, Name: TheMoon
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.Network;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(25, function() -- Line: 33
        -- upvalues: u5 (copy), u2 (ref)
        u5.InMoon = true;
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        local v6 = u2;
        v6.Boost = v6.Boost + 10;
        task.delay(40, function() -- Line: 38
            -- upvalues: u5 (ref), u2 (ref)
            u5.InMoon = false;
            local v7 = u2;
            v7.Boost = v7.Boost - 10;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
    end);
    u3:StopAll();
    u1.Ability:Fire("TheMoon", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
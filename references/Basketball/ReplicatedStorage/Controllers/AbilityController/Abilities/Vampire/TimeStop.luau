 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 22, Name: TimeStop
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy)
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.Network;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(5.166666666666667, function() -- Line: 33
        -- upvalues: Effects (ref), u2 (ref)
        Effects:Popup("Time has frozen for 5 seconds!", 4);
        Effects:Popup("Dribble near an enemy player to freeze them when time resumes!", 4);
        u2.States.Ability = false;
        u2.States.NoWalk = false;
        local v6 = u2;
        v6.Boost = v6.Boost + 7.5;
        task.delay(5, function() -- Line: 39
            -- upvalues: u2 (ref)
            local v7 = u2;
            v7.Boost = v7.Boost - 7.5;

            if u2.Boost < 0 then
                u2.Boost = 0;
            end;
        end);
    end);
    u3:StopAll();
    u1.Ability:Fire("VampireTimestop", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
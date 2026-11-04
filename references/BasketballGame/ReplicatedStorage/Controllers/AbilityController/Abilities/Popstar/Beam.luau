 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u5) -- Line: 19
    -- upvalues: u1 (ref), u3 (ref), u2 (ref), u4 (ref), LocalPlayer (copy)
    u1 = u5.AbilityService;
    u3 = u5.Animations;
    u2 = u5.MovementController;
    u4 = u5.BallController;
    local _ = LocalPlayer.Character.HumanoidRootPart;
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(14.349666666666666, function() -- Line: 31
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    u3:StopAll();
    u1.Ability:Fire("Beam", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u5.AC:Connect(u1.Ability, function() -- Line: 39
        -- upvalues: u5 (copy), u2 (ref)
        u5.AC:Clean();
        local v6 = u2;
        v6.Boost = v6.Boost + 16;
        task.wait(20);
        u2.Boost = math.max(u2.Boost - 16, 0);
    end);
end;
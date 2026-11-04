 
 

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
local u5 = nil;
local LocalPlayer = game.Players.LocalPlayer;

return function(p6) -- Line: 18, Name: DribbleKing
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p6.AbilityService;
    u3 = p6.Animations;
    u2 = p6.MovementController;
    u4 = p6.BallController;
    u5 = p6.CameraController;

    if u2.States.PumpFake then
        p6:ResetCD(2);
        Effects:Popup("Can\'t use after a fake!");

        return;
    end;

    u2.States.Ability = true;
    u2.Boost = -3;
    task.delay(2.4, function() -- Line: 33
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.Boost = 0;
    end);
    local ServerTimeNow = workspace:GetServerTimeNow();
    local u7 = nil;
    p6.AC:Connect(u1.Ability, function(p8) -- Line: 38
        -- upvalues: u7 (ref), ServerTimeNow (copy), u3 (ref), u2 (ref), ReplicatedStorage (ref)
        if u7 ~= nil then
            if u7 ~= "Fail" then
                return;
            end;

            u2.States.NoWalk = true;
            task.delay(1, function() -- Line: 56
                -- upvalues: u2 (ref)
                u2.States.NoWalk = false;
            end);
            local Value = ReplicatedStorage.Basketball.Value;
            local Random_new_ret = Random.new();
            local v9 = Random_new_ret:NextNumber(-1, 1);
            local v10 = Random_new_ret:NextNumber(-2, 1);
            Value.AssemblyLinearVelocity = Vector3.new(v9, v10, Random_new_ret:NextNumber(-1, 1)) * Random_new_ret:NextNumber(40, 70);

            return;
        end;

        if typeof(p8) ~= "table" or p8.RNG ~= "" and p8.RNG ~= "Fail" then
            return;
        end;

        u7 = p8.RNG;
        local v11 = workspace:GetServerTimeNow() - ServerTimeNow;
        local math_max_ret = math.max(v11, 0);
        u3:StopAll();
        local v12 = u3:PlayChar("Chuck", `DribbleKing{u7}`, Enum.AnimationPriority.Action3, true);
        local v13 = u3:PlayBall("Chuck", `DribbleKing{u7}Ball`, Enum.AnimationPriority.Action3, true);
        v12.TimePosition = math_max_ret;
        v13.TimePosition = math_max_ret;
    end);
    u1.Ability:Fire("DribbleKing", {
        TimeSent = ServerTimeNow
    });
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local LocalPlayer = Players.LocalPlayer;

return function(u6) -- Line: 14
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), ReplicatedStorage (copy), Effects (copy), LocalPlayer (copy)
    u1 = u6.MovementController;
    u2 = u6.BallController;
    u3 = u6.AbilityService;
    u4 = u6.Animations;
    u5 = u6.Network;

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.CaneEffectCD.Value > workspace:GetServerTimeNow() then
            local v7 = ReplicatedStorage.Cooldowns.CaneEffectCD.Value - workspace:GetServerTimeNow();
            local math_abs_ret = math.abs(v7);
            Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
            u6:ResetCD(1);

            return;
        end;

        local PlayerPossessingBall = u2:GetPlayerPossessingBall();

        if not PlayerPossessingBall or PlayerPossessingBall.Team == LocalPlayer.Team then
            u6:ResetCD(1);
            Effects:Popup("Enemy player must have the ball!");

            return;
        end;

        if not u2:LocalPlayerIsWithinDistanceOfBall(30) then
            u6:ResetCD(1);
            Effects:Popup("Must be close to the ball!");

            return;
        end;
    end;

    local _ = LocalPlayer.Character.HumanoidRootPart;
    task.delay(0.4666666666666667, function() -- Line: 45
        -- upvalues: u1 (ref)
        u1.States.NoWalk = true;
        u1.States.Ability = true;
    end);
    task.delay(1, function() -- Line: 50
        -- upvalues: u1 (ref)
        u1.States.NoWalk = false;
        u1.States.Ability = false;
    end);
    u4:StopAll();

    if u5.CharValues.HasBall then
        local v8 = u4:PlayChar("BasketballUnc", "CaneEffect", Enum.AnimationPriority.Action3);

        if v8 then
            v8:AdjustSpeed(1.3);
        end;

        local v9 = u4:PlayBall("BasketballUnc", "CaneEffectBall", Enum.AnimationPriority.Action3);

        if v9 then
            v9:AdjustSpeed(1.3);
        end;
    else
        local v10 = u4:PlayChar("BasketballUnc", "CaneEffectNo", Enum.AnimationPriority.Action3);

        if v10 then
            v10:AdjustSpeed(1.3);
        end;
    end;

    u6.AC:Connect(u3.Ability, function() -- Line: 73
        -- upvalues: u6 (copy), Effects (ref)
        u6.AC:Clean();
        Effects:Popup("Failed to knock the ball loose!");
    end);
    u3.Ability:Fire("Cane Effect", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
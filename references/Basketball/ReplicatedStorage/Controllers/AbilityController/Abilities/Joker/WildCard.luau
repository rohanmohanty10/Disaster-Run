 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local u3 = nil;

return function(u4) -- Line: 14
    -- upvalues: u1 (ref), u2 (ref), u3 (ref), ReplicatedStorage (copy), Effects (copy), LocalPlayer (copy)
    u1 = u4.AbilityService;
    u2 = u4.Animations;
    u3 = u4.Network;

    if u3.CharValues.HasBall then
        u1.Ability:Fire("Wild Card", {
            Task = "Smoke Trick",
            TimeSent = workspace:GetServerTimeNow()
        });
        u2:PlayChar("Joker", "SmokeTrick", Enum.AnimationPriority.Action3);

        return;
    end;

    if ReplicatedStorage.GameValues.Scoring.Value then
        u4:ResetCD(1);
        Effects:Popup("Can\'t use after a goal!");

        return;
    end;

    if ReplicatedStorage.Cooldowns.WildCardCD.Value > workspace:GetServerTimeNow() then
        u4:ResetCD(1);
        local v5 = ReplicatedStorage.Cooldowns.WildCardCD.Value - workspace:GetServerTimeNow();
        Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v5)} seconds`, 2);

        return;
    end;

    if not LocalPlayer:GetAttribute("LastTimeHoldingBallTick") or workspace:GetServerTimeNow() - 5 > LocalPlayer:GetAttribute("LastTimeHoldingBallTick") then
        u4:ResetCD(1);
        Effects:Popup("Can only be used within 5 seconds after losing the ball!");

        return;
    end;

    Effects:Popup("50% chance that the ball teleports to you.");
    u4.AC:Connect(u1.Ability, function(p6) -- Line: 42
        -- upvalues: u4 (copy), Effects (ref)
        if p6 then
            if p6.Fail then
                u4:ResetCD(1);

                return;
            end;

            if p6.Steal then
                Effects:Popup("Wild Card Succeded!");
                Effects:Popup("Ball teleports back to you in 1 second.");
            else
                Effects:Popup("Wild Card Failed!");
            end;
        end;

        u4.AC:Clean();
    end);
    u1.Ability:Fire("Wild Card", {
        Task = "Wild Card",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4.AC:Add(task.delay(3, function() -- Line: 62
        -- upvalues: u4 (copy)
        u4.AC:Clean();
    end));
end;
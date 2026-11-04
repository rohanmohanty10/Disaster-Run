 
 

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
local LocalPlayer = game.Players.LocalPlayer;

return function(p5) -- Line: 18
    -- upvalues: LocalPlayer (copy), u1 (ref), u3 (ref), u2 (ref), u4 (ref), Effects (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p5.AbilityService;
    u3 = p5.Animations;
    u2 = p5.MovementController;
    u4 = p5.Network;

    if u4.CharValues.HasBall then
        Effects:Popup("Flings enemy when you ankle break them and auto dribble for 3 seconds!");
        u2.Boost = 4;
        task.delay(3, function() -- Line: 32
            -- upvalues: u2 (ref)
            u2.Boost = 0;
        end);
        u1.Ability:Fire("Soul Strings", {
            TimeSent = workspace:GetServerTimeNow()
        });

        return;
    end;

    if ReplicatedStorage.Cooldowns.SoulStringsCD.Value > workspace:GetServerTimeNow() then
        p5:ResetCD(2);
        local v6 = ReplicatedStorage.Cooldowns.SoulStringsCD.Value - workspace:GetServerTimeNow();
        Effects:Popup(`Ability is on global cooldown! Ready in {math.round(v6)} seconds`, 2);

        return;
    end;

    Effects:Popup("All opponents are slowed and drained 10% from their zone bars!");
    u2.States.NoWalk = true;
    u2.States.Ability = true;
    task.delay(4.633333333333334, function() -- Line: 48
        -- upvalues: u2 (ref)
        u2.States.NoWalk = false;
        u2.States.Ability = false;
    end);
    u3:StopAll();
    u3:PlayChar("Popstar", "SoulStrings", Enum.AnimationPriority.Action3);
    u1.Ability:Fire("Soul Strings", {
        TimeSent = workspace:GetServerTimeNow()
    });
end;
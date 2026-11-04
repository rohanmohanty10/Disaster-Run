 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Shared.Utility.Essentials);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local LocalPlayer = game.Players.LocalPlayer;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Barriers };

return function(u8) -- Line: 25, Name: TimeSkipDribble
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Effects (copy), u1 (ref), u2 (ref), u4 (ref), u3 (ref), u5 (ref), u6 (ref), u7 (ref), Knit (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.Humanoid;
    local _ = Character.HumanoidRootPart;

    if ReplicatedStorage.Cooldowns.FreezeCD.Value > workspace:GetServerTimeNow() then
        local v9 = ReplicatedStorage.Cooldowns.FreezeCD.Value - workspace:GetServerTimeNow();
        local math_round_ret = math.round(v9);
        Effects:Popup((`Skill on global cooldown for {tostring(math_round_ret)}!`));
        u8:ResetCD(2);

        return;
    end;

    u1 = u8.Network;
    u2 = u8.AbilityService;
    u4 = u8.Animations;
    u3 = u8.MovementController;
    u5 = u8.BallController;
    u6 = u8.CameraController;
    u7 = Knit.GetService("CustomServerService");
    Effects:Popup("Next enemy to touch you gets frozen! Lasts for 2 Seconds.", 3);
    u2.Ability:Fire("VampireFreeze", {
        TimeSent = workspace:GetServerTimeNow()
    });
    u8.AC:Connect(u2.Ability, function(p10) -- Line: 43
        -- upvalues: u8 (copy), u3 (ref), u4 (ref)
        u8.AC:Clean();

        if p10.Success then
            u3.States.Ability = true;
            u3.States.NoWalk = true;
            local v11 = workspace:GetServerTimeNow() - p10.TimeSent;
            local v12, v13;

            if u3.States.AimAssist then
                v12 = u4:PlayChar("Vampire", "Freeze", Enum.AnimationPriority.Action, true);
                v13 = u4:PlayBall("Vampire", "FreezeBall", Enum.AnimationPriority.Action, true);
            else
                u4:StopAll();
                v12 = u4:PlayChar("Vampire", "Freeze", Enum.AnimationPriority.Action3, true);
                v13 = u4:PlayBall("Vampire", "FreezeBall", Enum.AnimationPriority.Action3, true);
            end;

            v12.TimePosition = v11;
            v13.TimePosition = v11;
            task.delay(1.5666666666666667 - v11, function() -- Line: 64
                -- upvalues: u3 (ref)
                u3.States.Ability = false;
                u3.States.NoWalk = false;
            end);
        end;
    end);
end;
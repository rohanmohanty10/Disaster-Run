 
 

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
local _ = workspace.CurrentCamera;

return function(p6) -- Line: 20
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), u3 (ref), u4 (ref), u5 (ref), Effects (copy), ReplicatedStorage (copy)
    local Character = LocalPlayer.Character;
    local _ = Character.HumanoidRootPart;
    local _ = Character.Humanoid;
    u1 = p6.AbilityService;
    u2 = p6.MovementController;
    u3 = p6.BallController;
    u4 = p6.Animations;
    u5 = p6.Network;

    if not u5.CharValues.HasBall then
        if ReplicatedStorage.Cooldowns.SkyBlockCD.Value <= workspace:GetServerTimeNow() then
            u1.Ability:Fire("Sky Block", {
                State = "Block",
                TimeSent = workspace:GetServerTimeNow()
            });
            Effects:Popup("Sky Block activated, ready to block a nearby shot.", 3, Color3.new(1, 0.607843, 0.772549), UDim2.new(0.65, 0, 0.25, 0));

            return;
        end;

        local v7 = ReplicatedStorage.Cooldowns.SkyBlockCD.Value - workspace:GetServerTimeNow();
        local math_abs_ret = math.abs(v7);
        Effects:Popup(`Ability on global cooldown! Ready in {math.ceil(math_abs_ret)} seconds`, 2);
        p6:ResetCD(2);

        return;
    end;

    u1.Ability:Fire("Sky Block", {
        State = "Invert",
        TimeSent = workspace:GetServerTimeNow()
    });
    u4:StopAll();
    u4:PlayChar("Valentine", "InvertedWorld", Enum.AnimationPriority.Action3);
    u4:PlayBall("Valentine", "InvertedWorldBall", Enum.AnimationPriority.Action3);
    u2.States.Ability = true;
    u2.States.NoWalk = true;
    task.delay(0.9666666666666667, function() -- Line: 40
        -- upvalues: u2 (ref)
        u2.States.Ability = false;
        u2.States.NoWalk = false;
    end);
    Effects:Popup("INVERTED THE VISION OF ENEMIES.");
end;
  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.GetService("EffectService");

return {
    Inherit = "Bike",
    ItemId = "MOUNT_19",
    Animator = "KarooAnimator",
    RaycastDown = 7,
    MovementProperties = {
        MAX_SPEED = 70,
        MOTIONAL_ACCELERATION = 0.25,
        ROTATIONAL_ACCELERATION = 0.075
    },

    OnSetup = function(u1) -- Line: 25, Name: OnSetup
        local Humanoid = u1.Character.Humanoid;
        Humanoid.HipHeight = 2.4;
        u1.Trove:Add(function() -- Line: 31
            -- upvalues: Humanoid (copy)
            if Humanoid:IsDescendantOf(game) then
                Humanoid.HipHeight = 0;
            end;
        end);
        u1.Model.PrimaryPart.Equip:Play();
        task.spawn(function() -- Line: 37
            -- upvalues: u1 (copy)
            local v2 = Random.new();

            while u1.Model and u1.Model:IsDescendantOf(game) do
                u1.Model.PrimaryPart["Scream" .. math.random(1, 2)]:Play();
                task.wait(v2:NextNumber(7, 10));
            end;
        end);
    end,

    OnMove = function(p3, p4) -- Line: 48, Name: OnMove
        p3.Model.PrimaryPart.MoveStart[p4 and "Play" or "Stop"](p3.Model.PrimaryPart.MoveStart);
    end
};
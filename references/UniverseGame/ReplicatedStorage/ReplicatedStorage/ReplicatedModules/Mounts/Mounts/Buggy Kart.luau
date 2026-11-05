  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    Inherit = "Bike",
    ItemId = "MOUNT_7",
    Animator = "BuggyAnimator",
    MovementProperties = {
        MAX_SPEED = 70
    },

    OnSetup = function(p2) -- Line: 18, Name: OnSetup
        -- upvalues: u1 (copy)
        local Humanoid = p2.Character.Humanoid;
        Humanoid.HipHeight = -2.5;
        p2.Trove:Add(function() -- Line: 24
            -- upvalues: Humanoid (copy)
            if Humanoid:IsDescendantOf(game) then
                Humanoid.HipHeight = 0;
            end;
        end);
        task.delay(1, u1.FireAllClients, "Buggy Kart Active", p2.Character);
        p2.Model.PrimaryPart.Equip:Play();
        p2.Model.PrimaryPart.IdleLoop:Play();
    end
};
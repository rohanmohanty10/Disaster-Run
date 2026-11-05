  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    Animator = "AnimatorTemplate",
    Inherit = "Hoverboard",
    ItemId = "MOUNT_2",
    MovementProperties = {
        MAX_SPEED = 85
    },

    OnSetup = function(p2) -- Line: 14, Name: OnSetup
        -- upvalues: u1 (copy)
        p2.Model.PrimaryPart.Equip:Play();
        p2.Model.PrimaryPart.Loop:Play();
        u1.FireAllClients("Celestial Starboard Active", p2.Character);
    end
};
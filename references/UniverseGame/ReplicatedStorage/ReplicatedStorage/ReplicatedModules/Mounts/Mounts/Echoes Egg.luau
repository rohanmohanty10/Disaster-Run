  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    Inherit = "Bike",
    ItemId = "MOUNT_6",
    Animator = "EggAnimator",

    OnSetup = function(p2) -- Line: 14, Name: OnSetup
        -- upvalues: u1 (copy)
        p2.Model.PrimaryPart.Equip:Play();
        task.delay(1, u1.FireAllClients, "Echoes Egg Active", p2.Character);
    end
};
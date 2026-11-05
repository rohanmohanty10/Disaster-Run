  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    Inherit = "Echoes Egg",
    ItemId = "MOUNT_22",

    OnSetup = function(p2) -- Line: 12, Name: OnSetup
        -- upvalues: u1 (copy)
        p2.Model.PrimaryPart.Equip:Play();
        task.delay(1, u1.FireAllClients, "Echoes Egg Active", p2.Character, "The Log");
    end,

    OnMove = function(p3, p4) -- Line: 18, Name: OnMove
        if p4 then
            p3.Model.PrimaryPart.MovementStart:Play();
        end;

        p3.Model.PrimaryPart.MovementSFX.Playing = p4;
    end
};
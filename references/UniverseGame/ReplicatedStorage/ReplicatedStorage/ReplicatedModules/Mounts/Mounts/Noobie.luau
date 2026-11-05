  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    ItemId = "MOUNT_4",
    Inherit = "Hoverboard",
    Model = game.ReplicatedStorage["Client Assets"].Misc.NoobieBike,
    MovementProperties = {
        MAX_SPEED = 220,
        MOTIONAL_ACCELERATION = 3,
        HOVER_INFLUENCE = 3,
        HOVER_HEIGHT = 9
    },

    OnSetup = function(p2) -- Line: 23, Name: OnSetup
        -- upvalues: u1 (copy)
        p2.Model.PrimaryPart.Equip:Play();
        p2.Model.PrimaryPart.Groove:Play();
        u1.FireAllClients("Avatar Mount Render", p2.Character);
    end
};
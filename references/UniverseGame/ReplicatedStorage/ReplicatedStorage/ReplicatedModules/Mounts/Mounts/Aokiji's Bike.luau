  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Knit.OnStart():await();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
local u1 = Knit.GetService("EffectService");

return {
    Inherit = "Bike",
    ItemId = "MOUNT_14",
    Model = game.ReplicatedStorage["Client Assets"].Mounts.Bike,

    OnSetup = function(p2) -- Line: 17, Name: OnSetup
        -- upvalues: u1 (copy)
        local Model = p2.Model;

        if Model then
            Model.Body.Color = Color3.fromRGB(20, 72, 11);
            task.delay(1, u1.FireAllClients, "Aokiji\'s Bike Active", p2.Character);
        end;
    end
};
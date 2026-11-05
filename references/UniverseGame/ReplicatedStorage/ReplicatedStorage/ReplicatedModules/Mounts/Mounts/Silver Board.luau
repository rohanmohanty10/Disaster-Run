  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return {
    Inherit = "Subway Board",
    ItemId = "MOUNT_27",

    OnSetup = function(p1) -- Line: 10, Name: OnSetup
        p1.Model.PrimaryPart.Equip:Play();
        p1.Model.PrimaryPart.IdleLoop:Play();
    end,

    OnMove = function(p2, p3) -- Line: 15, Name: OnMove
        if p3 then
            p2.Model.PrimaryPart.Movement:Play();
        end;

        for _, descendant in p2.Model:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "WhenMoving" then
                descendant.Enabled = p3;
            end;
        end;
    end
};
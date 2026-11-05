  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.ReplicatedModules.KnitPackage.Knit);
local UIOutput = ReplicatedStorage.Remotes.UIOutput;
local u1 = nil;
local u2 = nil;
local u3 = nil;

if RunService:IsServer() then
    Knit.OnStart():andThen(function() -- Line: 10
        -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref)
        u1 = Knit.GetService("InventoryService");
        u2 = Knit.GetService("SubPowerService");
        u3 = Knit.GetService("TraitService");
    end);
end;

return {
    Vergil = {
        Price = 100000,

        Reward = function(p4, p5) -- Line: 21, Name: Reward
            -- upvalues: u1 (ref)
            u1.AddAbilityToInventory(p5, 51);
        end
    },
    ["Trait Hand"] = {
        Price = 75000,

        Reward = function(p6, p7) -- Line: 27, Name: Reward
            -- upvalues: u3 (ref)
            u3.GivePlayerTraitHand(p7);
        end
    },
    ["Mirage Blades"] = {
        Price = 50000,
        Powers = { "ShootMirageBlade", "BlisteringBlades", "SpiralBlades", "StormBlades", "HeavyRainBlades" },

        Reward = function(p8, p9) -- Line: 34, Name: Reward
            -- upvalues: u2 (ref), UIOutput (copy)
            for _, v in p8.Powers do
                u2.UnlockSubPower(p9, v);
                UIOutput:FireClient(p9, "Notify", "SUBPOWER", `Unlocked {v}`, 5);
            end;
        end
    },
    Beowulf = {
        Price = 25000,

        Reward = function(p10, p11) -- Line: 43, Name: Reward
            -- upvalues: u1 (ref)
            u1.AddAbilityToInventory(p11, 50);
        end
    }
};
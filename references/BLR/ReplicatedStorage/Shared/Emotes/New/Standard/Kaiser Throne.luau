  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://82323011418501",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.Throne:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame);
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v5:Add(v6);

        return v5;
    end
});
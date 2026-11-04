  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://139486849716346",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local v6 = script["cupid bow"]:Clone();
        v6.Parent = p2.HumanoidRootPart;
        local arrow = v6.bow.arrow;
        arrow.Part0 = v6.bow;
        arrow.Part1 = v6.arrow;
        local bow = v6.bow.bow;
        bow.Part0 = p2["Right Arm"];
        bow.Part1 = v6.bow;
        v5:Add(v6);

        return v5;
    end
});
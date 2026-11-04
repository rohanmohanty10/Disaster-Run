  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/mountEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    meta = {
        rarity = "Limited"
    },
    anims = {
        walk = "rbxassetid://76720712945626",
        idle = "rbxassetid://76720712945626"
    },

    init = function(p2: any, p3: userdata, p4: any) -- Line: 12, Name: init
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.MetavisionEye.eyeball:Clone();
        v6.eyeball.Part0 = p2.HumanoidRootPart;
        v6.eyeball.Part1 = v6;
        v6.Parent = p2.HumanoidRootPart;
        v5:Add(v6);

        return v5;
    end
});
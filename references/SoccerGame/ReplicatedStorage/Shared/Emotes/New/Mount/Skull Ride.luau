  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/mountEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    meta = {
        rarity = "Limited"
    },
    anims = {
        walk = "rbxassetid://131129403465225",
        idle = "rbxassetid://131129403465225"
    },

    init = function(p2: any, p3: userdata, p4: any) -- Line: 12, Name: init
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.SkullRide["Skull ride emote"]:Clone();
        v6["Skull ride emote"].Part0 = p2.HumanoidRootPart;
        v6["Skull ride emote"].Part1 = v6;
        v6.Parent = p2.HumanoidRootPart;
        v5:Add(v6);

        return v5;
    end
});
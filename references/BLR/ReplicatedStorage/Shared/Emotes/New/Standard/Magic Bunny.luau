  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://110496282173080",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.MagicBunnyEmote:Clone();
        v6.Parent = p2.HumanoidRootPart;

        for _, child in v6:GetChildren() do
            local v7 = child:FindFirstChildOfClass("Motor6D");

            if v7 then
                v7.Part0 = p2.HumanoidRootPart;
                v7.Part1 = child;
            end;
        end;

        v5:Add(v6);

        return v5;
    end
});
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://95547479364548",
    maxWalkDistance = 2,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2) -- Line: 10, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v3 = Trove.new();
        local v4 = ReplicatedStorage.Assets.Misc["100Million"]:Clone();
        v4.Parent = p2;
        v4.HumanoidRootPartWeld.Part0 = p2.HumanoidRootPart;
        v3:Add(v4);
        local v5 = ReplicatedStorage.Assets.Misc["100MillionBall"]:Clone();
        v5.Parent = p2;
        local Weld = Instance.new("Weld");
        Weld.Parent = v5.PrimaryPart;
        Weld.C0 = CFrame.new(-1, 0.5, -0.3);
        Weld.Part0 = v5.PrimaryPart;
        Weld.Part1 = p2["Left Arm"];
        v3:Add(v5);

        return v3;
    end
});
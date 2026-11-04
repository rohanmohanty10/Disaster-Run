  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://73643037599808",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;

        for _, v in { "gear1", "gear2", "gear3" } do
            local v6 = script:FindFirstChild(v):Clone();
            v6.CanCollide = false;
            v6.Massless = true;
            v6.Anchored = false;
            v6.Parent = workspace.Debris;
            local v7 = v6:FindFirstChildWhichIsA("Motor6D");
            v7.Part0 = HumanoidRootPart;
            v7.Part1 = v6;
            v7.Parent = HumanoidRootPart;
            v5:Add(v7);
            v5:Add(v6);
        end;

        return v5;
    end
});
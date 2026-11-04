  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://139638606515427",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v3 = Trove.new();
        local v4 = script.TrophyEmote:Clone();
        v4.Parent = HumanoidRootPart;

        for _, child in v4:GetChildren() do
            if child:IsA("BasePart") then
                child.Anchored = false;
                child.CanCollide = false;
                child.CanQuery = false;
                child.CanTouch = false;
                child.Massless = true;
                local v5 = child:FindFirstChildOfClass("Motor6D");

                if v5 then
                    v5.Part0 = HumanoidRootPart;
                    v5.Part1 = child;
                end;
            end;
        end;

        v3:Add(v4);

        return v3;
    end
});
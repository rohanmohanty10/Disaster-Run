  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://90927355383143",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 9, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = p2:FindFirstChild("Left Arm");

        if not v6 then
            return v5;
        end;

        local v7 = ReplicatedStorage.Assets.Misc.HardTraining.Weights:Clone();
        v7.Anchored = false;
        v7.CanCollide = false;
        v7.CanQuery = false;
        v7.CanTouch = false;
        v7.Massless = true;
        local v8 = v7:FindFirstChildOfClass("Motor6D");

        if v8 then
            v8.Part1 = v6;
        end;

        v7.Parent = p2;
        v5:Add(v7);

        return v5;
    end
});
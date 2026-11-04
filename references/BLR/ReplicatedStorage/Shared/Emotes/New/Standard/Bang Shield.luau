  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://76450107993287",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local v6 = script.Shield:Clone();
        v6.CanCollide = false;
        v6.Massless = true;
        v6.Anchored = false;
        v6.Parent = workspace.Debris;
        local v7 = v6:FindFirstChildWhichIsA("Motor6D");
        local ConnectTo = v7:FindFirstChild("ConnectTo");

        if ConnectTo then
            v7.Part0 = p2:FindFirstChild(ConnectTo.Value);
        end;

        v7.Part1 = v6;
        v5:Add(v7);
        v5:Add(v6);

        return v5;
    end
});
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://81589319671186",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local v6 = script.RoseBasket:Clone();
        v6.Parent = p2.HumanoidRootPart;
        local v7 = v6:FindFirstChildOfClass("Motor6D");

        if v7 then
            v7.Part0 = p2["Right Arm"];
            v7.Part1 = v6;
        end;

        v5:Add(v6);

        return v5;
    end
});
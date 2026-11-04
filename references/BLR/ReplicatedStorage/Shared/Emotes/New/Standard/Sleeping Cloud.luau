  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://88005815031572",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy)
        local v5 = Trove.new();
        local v6 = script.cloud:Clone();
        v6.cloud.Part1 = v6;
        v6.cloud.Part0 = p2.HumanoidRootPart;
        v6.Anchored = false;
        v6.Massless = true;
        v6.CanCollide = false;
        v6.Parent = workspace.Debris;
        v5:Add(v6);

        return v5;
    end
});
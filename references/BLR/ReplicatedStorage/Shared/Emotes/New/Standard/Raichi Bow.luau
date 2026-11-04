  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://98734367765378",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.RaichiBow.HumanoidRootPart:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame);
        v6.Parent = p2.HumanoidRootPart;
        Essentials:Weld(p2.HumanoidRootPart, v6, v6);
        v5:Add(v6);

        return v5;
    end
});
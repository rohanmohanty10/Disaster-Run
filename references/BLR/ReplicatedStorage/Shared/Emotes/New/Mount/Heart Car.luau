  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/mountEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    meta = {
        rarity = "Limited"
    },
    anims = {
        walk = "rbxassetid://99643619404484",
        idle = "rbxassetid://126924516805234"
    },

    init = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: init
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.LoveCar.Car:Clone();
        v6.Main.Main.Part0 = p2.HumanoidRootPart;
        v6.Main.Main.Part1 = v6.Main;
        v6.Parent = workspace.Debris;
        v5:Add(v6);

        return v5;
    end
});
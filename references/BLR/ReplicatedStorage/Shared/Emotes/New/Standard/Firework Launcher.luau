  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://93756147842130",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.FireworkLauncher.Launcher:Clone();
        v6.Parent = p2.HumanoidRootPart;

        for _, child in v6:GetChildren() do
            if string.find(child.Name, "Rocket") then
                child.Rocket.Part0 = p2.HumanoidRootPart;
                child.Rocket.Part1 = child;
            end;
        end;

        v6.Handle.Launcher.Part0 = v6.Handle;
        v6.Handle.Launcher.Part1 = v6.Launcher;
        v6.Handle.Handle.Part0 = p2["Right Arm"];
        v6.Handle.Handle.Part1 = v6.Handle;
        v5:Add(v6);

        return v5;
    end
});
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://81047726679353",
    meta = {
        rarity = "Limited"
    },

    effect = function(u2: table, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        u2:SetAttribute("HighlightOutline", Color3.fromRGB(255, 255, 62));
        local v6 = script.Griddy:Clone();
        v6:PivotTo(u2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = u2.HumanoidRootPart;

        for _, child in v6:GetChildren() do
            Essentials:Weld(u2.HumanoidRootPart, child, child);
        end;

        v5:Add(function() -- Line: 25
            -- upvalues: u2 (copy)
            u2:SetAttribute("HighlightOutline", Color3.fromRGB(0, 0, 0));
        end);
        v5:Add(v6);

        return v5;
    end
});
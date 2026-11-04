  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://86963107685281",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(u2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.HumanoidRootPart:Clone();
        v6:PivotTo(u2.HumanoidRootPart.CFrame);
        v6.Parent = workspace.Debris;
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Massless = true;
        Essentials:Weld(u2.HumanoidRootPart, v6, v6);
        v5:Add(v6);
        u2:SetAttribute("HighlightOutline", Color3.fromRGB(255, 16, 20));
        v5:Add(function() -- Line: 30
            -- upvalues: u2 (copy)
            u2:SetAttribute("HighlightOutline", Color3.fromRGB(0, 0, 0));
        end);

        return v5;
    end
});
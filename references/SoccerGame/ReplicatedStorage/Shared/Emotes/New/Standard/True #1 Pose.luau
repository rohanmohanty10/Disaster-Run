  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://129415764238197",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2) -- Line: 10, Name: effect
        -- upvalues: Trove (copy)
        local v3 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local CFrame = script.VFX.AuraVFX.CFrame;
        local v4 = script.VFX:Clone();
        v4.Name = "TrueNumberOneVFX";
        v3:Add(v4);

        for _, descendant in v4:GetDescendants() do
            if descendant:IsA("BasePart") then
                local v5 = CFrame:ToObjectSpace(descendant.CFrame);
                descendant.CFrame = HumanoidRootPart.CFrame * v5;
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Name = "EmoteWeld";
                Weld.C0 = v5;
                Weld.Part0 = HumanoidRootPart;
                Weld.Part1 = descendant;
                Weld.Parent = descendant;
            end;
        end;

        v4.Parent = p2;

        return v3;
    end
});
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local u2 = script.VFXReference.CFrame:ToObjectSpace(script.VFX.AuraVFX.CFrame);

return v1({
    animationId = "rbxassetid://93925940061375",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p3) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), u2 (copy), Essentials (copy)
        local HumanoidRootPart = p3.HumanoidRootPart;
        local v4 = Trove.new();
        local v5 = script.VFX:Clone();
        v5.Parent = HumanoidRootPart;

        for _, child in v5:GetChildren() do
            if child:IsA("BasePart") then
                local v6 = child:FindFirstChildOfClass("Motor6D");
                child.Anchored = false;
                child.CanCollide = false;
                child.CanQuery = false;
                child.CanTouch = false;
                child.Massless = true;

                if v6 then
                    child.CFrame = HumanoidRootPart.CFrame * v6.C0;
                    v6.Part0 = HumanoidRootPart;
                    v6.Part1 = child;
                    v6.Parent = HumanoidRootPart;
                    v4:Add(v6);
                else
                    child.CFrame = HumanoidRootPart.CFrame * u2;
                    Essentials:Weld(HumanoidRootPart, child, child);
                end;
            end;
        end;

        v4:Add(v5);

        return v4;
    end
});
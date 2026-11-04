  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://135189333092227",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v6 = ReplicatedStorage.Assets.Misc.NinjaPose:Clone();
        v6.Parent = HumanoidRootPart;

        for _, child in v6:GetChildren() do
            if child:IsA("BasePart") then
                child.Anchored = false;
                child.CanCollide = false;
                child.CanQuery = false;
                child.CanTouch = false;
                child.Massless = true;
                local Weld = Instance.new("Weld");
                Weld.Part0 = HumanoidRootPart;
                Weld.Part1 = child;
                Weld.C0 = child.CFrame;
                Weld.C1 = CFrame.new();
                Weld.Parent = child;
            end;
        end;

        v5:Add(v6);

        return v5;
    end
});
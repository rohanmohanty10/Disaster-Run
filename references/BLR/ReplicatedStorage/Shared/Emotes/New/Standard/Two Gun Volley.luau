  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

return v1({
    animationId = "rbxassetid://140595334588346",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 9, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2.HumanoidRootPart;
        local v6 = ReplicatedStorage.Assets.Misc.TwoGunVolley.Guns:Clone();
        v6.Parent = HumanoidRootPart;

        for _, child in v6:GetChildren() do
            if child:IsA("BasePart") then
                child.Anchored = false;
                child.CanCollide = false;
                child.Massless = true;
                local v7 = child:FindFirstChildWhichIsA("Motor6D");

                if v7 then
                    v7.Part0 = HumanoidRootPart;
                    v7.Part1 = child;
                end;
            end;
        end;

        local v8 = ReplicatedStorage.Assets.Misc.TwoGunVolley.VFXPart:Clone();
        v8.Anchored = false;
        v8.CanCollide = false;
        v8.Massless = true;
        v8.Parent = HumanoidRootPart;
        local Weld = Instance.new("Weld");
        Weld.Part0 = HumanoidRootPart;
        Weld.Part1 = v8;
        Weld.C0 = CFrame.new();
        Weld.C1 = CFrame.new();
        Weld.Parent = v8;
        v5:Add(v6);
        v5:Add(v8);

        return v5;
    end
});
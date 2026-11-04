  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://133661849028272",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 10, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local Kunigami = ReplicatedStorage.Assets.Misc.Kunigami;

        for _, child in Kunigami:GetChildren() do
            if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                local v6 = child:Clone();
                v6.Anchored = false;
                v6.CanCollide = false;
                v6.Massless = true;
                v6:PivotTo(p2.HumanoidRootPart.CFrame * Kunigami.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
                v6.Parent = p2.HumanoidRootPart;
                Essentials:Weld(p2.HumanoidRootPart, v6, v6);
                v5:Add(v6);
            end;
        end;

        return v5;
    end
});
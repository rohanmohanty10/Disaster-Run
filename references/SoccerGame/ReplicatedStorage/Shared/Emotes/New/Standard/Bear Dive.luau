  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://89419892593666",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 12, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local v5 = Trove.new();
        local BearDive = ReplicatedStorage.Assets.Misc.BearDive;
        local v6 = BearDive:Clone();
        v6:PivotTo(p2.HumanoidRootPart.CFrame * BearDive.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.Massless = true;

                if descendant ~= v6.HumanoidRootPart then
                    Essentials:Weld(v6.HumanoidRootPart, descendant, descendant);
                end;
            end;
        end;

        Essentials:Weld(p2.HumanoidRootPart, v6.HumanoidRootPart, v6.HumanoidRootPart);
        v6.Parent = workspace.Debris;
        VfxManager.Enable(v6, true);
        v5:Add(v6);

        return v5;
    end
});
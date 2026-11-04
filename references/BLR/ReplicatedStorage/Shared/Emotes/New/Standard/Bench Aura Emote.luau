  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.EmitModule);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://109052583650543",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy), VfxManager (copy)
        local v5 = Trove.new();
        local BenchAura = ReplicatedStorage.Assets.Misc.BenchAura;
        local v6 = BenchAura.bench:Clone();
        v6.bench.Part0 = p2.HumanoidRootPart;
        v6.bench.Part1 = v6;
        v6.Parent = p2;
        v5:Add(v6);
        local v7 = BenchAura.BenchAura:Clone();
        v7:PivotTo(p2.HumanoidRootPart.CFrame * BenchAura.HumanoidRootPart.CFrame:ToObjectSpace(v7:GetPivot()));
        v7.Parent = p2.HumanoidRootPart;

        for _, child in v7:GetChildren() do
            if child:IsA("BasePart") then
                child.CanCollide = false;
                child.Massless = true;
                child.Anchored = false;
                child.Transparency = 1;
                Essentials:Weld(p2.HumanoidRootPart, child, child);
            end;
        end;

        VfxManager.Enable(v7, true);
        v5:Add(v7);

        return v5;
    end
});
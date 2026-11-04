  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/mountEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    meta = {
        rarity = "Limited"
    },
    anims = {
        walk = "rbxassetid://105765263223189",
        idle = "rbxassetid://116041981732151"
    },

    init = function(p2, p3, p4) -- Line: 16, Name: init
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc["Bunny Ride"]["BLR Bunny Rig"]:Clone();
        local HumanoidRootPart = ReplicatedStorage.Assets.Misc["Bunny Ride"].HumanoidRootPart;

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Massless = true;
            end;
        end;

        v6:PivotTo(p2.HumanoidRootPart.CFrame * HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;
        v6.RootPart.Anchored = false;
        v6.RootPart.CanCollide = false;
        v6.RootPart.Massless = true;
        v6.RootPart.Transparency = 1;
        Essentials:Weld(p2.HumanoidRootPart, v6.RootPart, v6.RootPart);
        v5:Add(v6);
        local Animator = v6.AnimationController.Animator;
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://90125744552877";
        local Animation2 = Instance.new("Animation");
        Animation2.AnimationId = "rbxassetid://92397598853184";
        local v7 = Animator:LoadAnimation(Animation);
        local v8 = Animator:LoadAnimation(Animation2);
        v7.Looped = true;
        v8.Looped = true;
        v7.Priority = Enum.AnimationPriority.Action4;
        v8.Priority = Enum.AnimationPriority.Action4;
        v7:Play();
        v5:Add(v7, "Stop");
        v5:Add(v8, "Stop");

        return v5, v7, v8;
    end,

    idle = function(p9, p10, p11, p12) -- Line: 64, Name: idle
        if p11 then
            p11:Stop();
        end;

        if p12 then
            p12:Play();
        end;
    end,

    walk = function(p13, p14, p15, p16) -- Line: 68, Name: walk
        if p16 then
            p16:Stop();
        end;

        if p15 then
            p15:Play();
        end;
    end
});
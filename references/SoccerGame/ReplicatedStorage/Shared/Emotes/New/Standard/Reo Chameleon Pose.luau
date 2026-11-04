  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://92758715669367",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 14, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Vfx:FindFirstChild("Reo Chameleon Pose");

        if not v6 then
            return v5;
        end;

        local v7 = v6:FindFirstChild("blr reo rig");
        local R6 = v6:FindFirstChild("R6");

        if not (v7 and R6) then
            return v5;
        end;

        local v8 = v7:Clone();

        for _, descendant in v8:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Massless = true;
                descendant.Anchored = false;
            end;
        end;

        v8:PivotTo(p2.HumanoidRootPart.CFrame * R6.HumanoidRootPart.CFrame:ToObjectSpace(v8:GetPivot()));
        v8.Parent = workspace.Debris;
        v5:Add(v8);
        Essentials:WeldOffset(p2.HumanoidRootPart, v8.RootPart, p2.HumanoidRootPart.CFrame:ToObjectSpace(v8.RootPart.CFrame));
        local v9 = v8.AnimationController:FindFirstChildWhichIsA("Animator");

        if not v9 then
            v9 = Instance.new("Animator");
            v9.Parent = v8.AnimationController;
        end;

        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://108676288894368";
        local v10 = v9:LoadAnimation(Animation);
        v10.Looped = true;
        v10.Priority = Enum.AnimationPriority.Action4;
        v10:Play();
        v5:Add(v10, "Stop");

        return v5;
    end
});
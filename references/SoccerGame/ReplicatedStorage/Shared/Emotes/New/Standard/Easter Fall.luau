  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://125237025383695",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 13, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = script.Egg:Clone();

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Massless = true;
                descendant.Anchored = false;
            end;
        end;

        v6:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;
        local eggreal = v6:FindFirstChild("eggreal");

        if eggreal then
            Essentials:Weld(p2.HumanoidRootPart, eggreal, eggreal);
        end;

        v5:Add(v6);
        local AnimationController = v6:FindFirstChild("AnimationController");

        if AnimationController then
            local v7 = AnimationController:FindFirstChildWhichIsA("Animator");

            if not v7 then
                v7 = Instance.new("Animator");
                v7.Parent = AnimationController;
            end;

            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://121091039070452";
            local v8 = v7:LoadAnimation(Animation);
            v8.Looped = false;
            v8.Priority = Enum.AnimationPriority.Action4;
            v8:Play();
            v5:Add(v8, "Stop");
        end;

        local EMIT = script:FindFirstChild("EMIT");

        if EMIT then
            local v9 = EMIT:Clone();
            v9.CanCollide = false;
            v9.Massless = true;
            v9.Anchored = false;
            v9.Transparency = 1;
            v9:PivotTo(p2.HumanoidRootPart.CFrame * script.HumanoidRootPart.CFrame:ToObjectSpace(v9.CFrame));
            v9.Parent = workspace.Debris;
            Essentials:Weld(p2.HumanoidRootPart, v9, v9);
            v5:Add(v9);
        end;

        return v5;
    end
});
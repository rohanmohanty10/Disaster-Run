  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://83906964976024",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2, p3, p4) -- Line: 14, Name: effect
        -- upvalues: Trove (copy), Essentials (copy)
        local v5 = Trove.new();
        local player = script:FindFirstChild("player");
        local ball = script:FindFirstChild("ball");

        if not (player and ball) then
            return v5;
        end;

        local v6 = ball:Clone();

        for _, descendant in v6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.Massless = true;
                descendant.Anchored = false;
            end;
        end;

        v6:PivotTo(p2.HumanoidRootPart.CFrame * player.HumanoidRootPart.CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = workspace.Debris;
        v5:Add(v6);
        local v7 = v6.PrimaryPart or v6:FindFirstChild("RootPart");

        if v7 then
            Essentials:WeldOffset(p2.HumanoidRootPart, v7, p2.HumanoidRootPart.CFrame:ToObjectSpace(v7.CFrame));
        end;

        local v8 = v6:FindFirstChildOfClass("AnimationController");

        if v8 then
            local v9 = v8:FindFirstChildWhichIsA("Animator");

            if not v9 then
                v9 = Instance.new("Animator");
                v9.Parent = v8;
            end;

            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://123764513923456";
            local v10 = v9:LoadAnimation(Animation);
            v10.Looped = true;
            v10.Priority = Enum.AnimationPriority.Action4;
            v10:Play();
            v5:Add(v10, "Stop");
        end;

        return v5;
    end
});
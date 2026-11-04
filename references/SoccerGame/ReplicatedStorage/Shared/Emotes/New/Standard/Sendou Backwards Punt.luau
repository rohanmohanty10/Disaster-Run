  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local CFrame_new_ret = CFrame.new(0, -2.32066441, 0);

return v1({
    animationId = "rbxassetid://79807378131156",
    looped = false,
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 14, Name: effect
        -- upvalues: Trove (copy), CFrame_new_ret (copy), Essentials (copy)
        local v5 = Trove.new();
        local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return v5;
        end;

        local u6 = script.Ball:Clone();
        u6.Name = "SendouBackwardsPuntBall";
        local RootPart = u6.RootPart;
        u6:PivotTo(HumanoidRootPart.CFrame * CFrame_new_ret);

        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Anchored = false;
                descendant.CanCollide = false;
                descendant.CanTouch = false;
                descendant.CanQuery = false;
                descendant.Massless = true;
            end;
        end;

        Essentials:Weld(HumanoidRootPart, RootPart, RootPart);
        u6.Parent = workspace.Debris;
        v5:Add(u6);
        local Animation = Instance.new("Animation");
        Animation.AnimationId = "rbxassetid://96446252303037";
        v5:Add(Animation);
        local v7 = u6.AnimationController.Animator:LoadAnimation(Animation);
        v7.Looped = false;
        v7:Play();
        v5:Add(v7.Ended:Once(function() -- Line: 44
            -- upvalues: u6 (copy)
            if u6.Parent then
                u6:Destroy();
            end;
        end));

        return v5;
    end
});
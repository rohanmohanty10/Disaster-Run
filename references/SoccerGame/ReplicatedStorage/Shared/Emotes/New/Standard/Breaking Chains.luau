  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

local function setupPart(p2) -- Line: 11
    p2.CanCollide = false;
    p2.CanQuery = false;
    p2.CanTouch = false;
    p2.Massless = true;
    p2.Anchored = false;
end;

return v1({
    animationId = "rbxassetid://74428252366351",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p3, u4, p5) -- Line: 24, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), RunService (copy)
        local v6 = Trove.new();
        local HumanoidRootPart = p3:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return v6;
        end;

        u4.Priority = Enum.AnimationPriority.Action3;
        local v7 = ReplicatedStorage.Assets.Misc.BreakingChains:Clone();
        v7:PivotTo(HumanoidRootPart.CFrame);

        for _, descendant in v7:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CanCollide = false;
                descendant.CanQuery = false;
                descendant.CanTouch = false;
                descendant.Massless = true;
                descendant.Anchored = false;
            end;
        end;

        local HumanoidRootPart2 = v7:FindFirstChild("HumanoidRootPart");
        local v8 = {};

        if HumanoidRootPart2 then
            for _, child in HumanoidRootPart2:GetChildren() do
                if child:IsA("Motor6D") then
                    table.insert(v8, child);
                end;
            end;
        end;

        local VFX = v7:FindFirstChild("VFX");
        local u9 = {};

        if VFX and VFX:IsA("BasePart") then
            for _, descendant in VFX:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    table.insert(u9, descendant);
                    descendant.Enabled = false;
                end;
            end;
        end;

        for _, child in v7:GetChildren() do
            if child ~= HumanoidRootPart2 then
                child.Parent = p3;
                v6:Add(child);
            end;
        end;

        VFX.Parent = HumanoidRootPart;

        for _, v in v8 do
            v.Part0 = HumanoidRootPart;
            v.Parent = HumanoidRootPart;
            v6:Add(v);
        end;

        if VFX and VFX:IsA("BasePart") then
            VFX.CFrame = HumanoidRootPart.CFrame;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = VFX;
            WeldConstraint.Parent = VFX;
        end;

        if HumanoidRootPart2 then
            HumanoidRootPart2:Destroy();
        end;

        v7:Destroy();
        local v10 = p3:FindFirstChildOfClass("Humanoid");

        if v10 then
            v10 = v10:FindFirstChildOfClass("Animator");
        end;

        if v10 then
            local Animation = Instance.new("Animation");
            Animation.AnimationId = "rbxassetid://138317168509240";
            local u11 = v10:LoadAnimation(Animation);
            u11.Looped = true;
            u11.Priority = Enum.AnimationPriority.Action4;
            v6:Add(u11, "Stop");
            local u12 = false;

            local function trigger() -- Line: 106
                -- upvalues: u12 (ref), u4 (copy), u11 (copy), u9 (copy)
                if u12 then
                    return;
                end;

                u12 = true;
                u4:AdjustSpeed(0);
                u11:Play(0.35);

                for _, v in u9 do
                    v.Enabled = true;
                end;
            end;

            v6:Add(RunService.Heartbeat:Connect(function() -- Line: 116
                -- upvalues: u12 (ref), u4 (copy), u11 (copy), u9 (copy)
                if u12 then
                    return;
                end;

                local Length = u4.Length;

                if Length > 0 and u4.TimePosition >= Length - 0.3 then
                    if u12 then
                        return;
                    end;

                    u12 = true;
                    u4:AdjustSpeed(0);
                    u11:Play(0.35);

                    for _, v in u9 do
                        v.Enabled = true;
                    end;
                end;
            end));
            v6:Add(u4.DidLoop:Once(trigger));
        end;

        return v6;
    end
});
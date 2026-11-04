  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);

local function setupPart(p2) -- Line: 9
    p2.Anchored = false;
    p2.CanCollide = false;
    p2.CanQuery = false;
    p2.CanTouch = false;
    p2.Massless = true;
end;

local function playOn(p3, p4, p5) -- Line: 17
    local v6 = p3:FindFirstChildWhichIsA("AnimationController");

    if not v6 then
        return;
    end;

    local v7 = v6:FindFirstChildWhichIsA("Animator");

    if not v7 then
        v7 = Instance.new("Animator");
        v7.Parent = v6;
    end;

    local Animation = Instance.new("Animation");
    Animation.AnimationId = p4;
    local v8 = v7:LoadAnimation(Animation);
    v8.Looped = true;
    v8.Priority = Enum.AnimationPriority.Action4;
    v8:Play();
    p5:Add(v8, "Stop");
end;

return v1({
    animationId = "rbxassetid://79793013040658",
    looped = true,
    meta = {
        rarity = "Limited"
    },

    effect = function(p9, p10, p11) -- Line: 38, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), playOn (copy)
        local u12 = Trove.new();
        local HumanoidRootPart = p9:FindFirstChild("HumanoidRootPart");

        if not HumanoidRootPart then
            return u12;
        end;

        local v13 = ReplicatedStorage.Assets.Misc.RedPanther:Clone();
        v13:PivotTo(HumanoidRootPart.CFrame);
        local HumanoidRootPart2 = v13:FindFirstChild("HumanoidRootPart");
        local Lion = v13:FindFirstChild("Lion");
        local Ball = v13:FindFirstChild("Ball");
        local GroundAuraSit = v13:FindFirstChild("GroundAuraSit");
        local u14 = workspace:FindFirstChild("Debris") or workspace;

        local function attach(p15) -- Line: 57
            -- upvalues: u14 (copy), HumanoidRootPart (copy), u12 (copy)
            if not p15 then
                return;
            end;

            p15.Parent = u14;

            for _, descendant in p15:GetDescendants() do
                if descendant:IsA("BasePart") then
                    descendant.Anchored = false;
                    descendant.CanCollide = false;
                    descendant.CanQuery = false;
                    descendant.CanTouch = false;
                    descendant.Massless = true;
                end;
            end;

            local PrimaryPart = p15.PrimaryPart;

            if PrimaryPart then
                local WeldConstraint = Instance.new("WeldConstraint");
                WeldConstraint.Part0 = HumanoidRootPart;
                WeldConstraint.Part1 = PrimaryPart;
                WeldConstraint.Parent = PrimaryPart;
            end;

            u12:Add(p15);
        end;

        attach(Lion);
        attach(Ball);

        if GroundAuraSit and GroundAuraSit:IsA("BasePart") then
            GroundAuraSit.Parent = u14;
            GroundAuraSit.Anchored = false;
            GroundAuraSit.CanCollide = false;
            GroundAuraSit.CanQuery = false;
            GroundAuraSit.CanTouch = false;
            GroundAuraSit.Massless = true;
            local WeldConstraint = Instance.new("WeldConstraint");
            WeldConstraint.Part0 = HumanoidRootPart;
            WeldConstraint.Part1 = GroundAuraSit;
            WeldConstraint.Parent = GroundAuraSit;
            u12:Add(GroundAuraSit);
        end;

        if HumanoidRootPart2 then
            HumanoidRootPart2:Destroy();
        end;

        v13:Destroy();

        if Lion then
            playOn(Lion, "rbxassetid://109244782337470", u12);
        end;

        if Ball then
            playOn(Ball, "rbxassetid://72969992842458", u12);
        end;

        return u12;
    end
});
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = Random.new();

local function u4(p2, p3) -- Line: 23
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function UseNumber(p5) -- Line: 27
    -- upvalues: u4 (copy)
    if typeof(p5) == "number" then
        return p5;
    end;

    return typeof(p5) ~= "NumberRange" and 0 or u4(p5.Min, p5.Max);
end;

return function(u6, p7) -- Line: 37
    -- upvalues: Trove (copy), EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local Special = workspace:FindFirstChild("Map"):FindFirstChild("Fractured Island"):FindFirstChild("Special");
    local Cinematic = Special:FindFirstChild("Cinematic");
    local ShrineCrystal = Special:FindFirstChild("ShrineEffects"):FindFirstChild("ShrineCrystal");
    local v8 = {};

    for _, child in Cinematic:FindFirstChild("Waypoints2"):GetChildren() do
        if child:IsA("BasePart") then
            local v9 = tonumber(child.Name);

            if v9 then
                v8[v9] = child;
            end;
        end;
    end;

    if #v8 == 0 then
        return;
    end;

    local u10 = Trove.new();
    task.delay(10, function() -- Line: 57
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
    task.spawn(function() -- Line: 61
        -- upvalues: EffectsHandler (ref), ShrineCrystal (copy), AssetHandler (ref), u10 (copy), ParticleHandler (ref), u6 (copy), TweenService (ref)
        local u11 = os.clock();
        EffectsHandler.CallEffect("Enable Particles", {
            Enabled = true,
            Parent = ShrineCrystal,
            ReferencePart = AssetHandler.GetAsset("Universal/Interaction/Space/ShrineCharge"),
            Id = u11
        });
        local v12 = AssetHandler.CloneAsset("Universal/Interaction/Space/Halo");
        u10:Add(v12);

        for _, descendant in v12:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.Transparency = 1;
            end;
        end;

        v12.Parent = workspace.Effects;
        local v13 = ParticleHandler.AttachTo(v12, {
            Part = u6:FindFirstChild("Head"),
            C0 = CFrame.new(0, -4, -0.09)
        });

        if v13 then
            local v14 = TweenService:Create(v13, TweenInfo.new(4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                C0 = CFrame.new(0, -1.6, -0.09)
            });
            v14:Play();
            u10:Add(v14);
        end;

        for _, descendant in v12:GetDescendants() do
            if descendant:IsA("BasePart") then
                local v15 = TweenService:Create(descendant, TweenInfo.new(4.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Transparency = 0
                });
                v15:Play();
                u10:Add(v15);
            end;
        end;

        task.spawn(EffectsHandler.CallEffect, "Create Global Audio", {
            Sound = "rbxassetid://75880587941721",
            Volume = 1.5,
            PlaybackSpeed = 1
        });
        task.delay(2, function() -- Line: 100
            -- upvalues: EffectsHandler (ref), u6 (ref), ShrineCrystal (ref)
            task.spawn(EffectsHandler.CallEffect, "Path Bezier", u6, {
                EffectPath = "Abilities/δ: FOR THE DELTA/Particles/Common/EnergyTrail",
                RawPath = true,
                Scale = 3,
                Duration = 7,
                Rate = 0.075,
                Origin = ShrineCrystal,
                Goal = u6:FindFirstChild("HumanoidRootPart") or u6.PrimaryPart,
                CurveRadius = NumberRange.new(10, 85),
                SpreadAngle = NumberRange.new(-180, 180),
                EasingStyle = Enum.EasingStyle.Quad,
                EasingDirection = Enum.EasingDirection.InOut,
                Lifetime = NumberRange.new(0.4, 0.8)
            });
        end);
        task.delay(9, function() -- Line: 119
            -- upvalues: EffectsHandler (ref), u11 (copy)
            EffectsHandler.CallEffect("Enable Particles", {
                Enabled = false,
                Id = u11
            });
        end);
        task.wait(9);
        task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
            LifeTime = 0.3,
            Transparency = 0.2,
            TweenIn = { 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
            TweenOut = { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
            Size = UDim2.fromScale(1, 1),
            Color = Color3.fromRGB(73, 255, 79)
        });
        EffectsHandler.CallEffect("Camera Shake", { 8, 15, 0, 0.7, Vector3.new(0.4, 0.4, 0.4), Vector3.new(4, 1, 1), true });
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Universal/Interaction/Space/ShrineBurst",
            RawPath = true,
            Scale = 2,
            Origin = ShrineCrystal.CFrame
        });
    end);
    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
        LifeTime = 8,
        Transparency = 0.2,
        TweenIn = { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
        Size = UDim2.fromScale(1, 1),
        Color = Color3.fromRGB(0, 0, 0)
    });
    EffectsHandler.CallEffect("Camera Cinematic", u6, {
        Duration = 10,
        EasingStyle = "Sine",
        EasingDirection = "InOut",
        EndOnCharacter = true,
        DisableUI = true,
        Waypoints = v8
    });
end;
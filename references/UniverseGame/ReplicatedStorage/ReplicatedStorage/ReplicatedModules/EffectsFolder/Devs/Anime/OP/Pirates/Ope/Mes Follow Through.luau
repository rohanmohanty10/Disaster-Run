  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3) -- Line: 10
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    if not (p1 and p1:IsDescendantOf(game)) then
        return;
    end;

    local v4 = {
        AbilityName = "Ope",
        SkinName = p3
    };
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v5 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    local u6 = AssetHandler.GetAsset("Particles/Mes/Trail", v4):Clone();
    ParticleHandler.Unusualify(u6, {
        HSVData = v5
    });
    u6.Parent = HumanoidRootPart;
    ParticleHandler.AttachTo(u6, {
        Part = HumanoidRootPart
    });
    task.delay(0.3, function() -- Line: 30
        -- upvalues: u6 (copy)
        if u6:IsDescendantOf(game) then
            task.delay(1, u6.Destroy, u6);

            for _, descendant in u6:GetDescendants() do
                if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    local CFrame2 = HumanoidRootPart.CFrame;
    local v7 = AssetHandler.GetAsset("Particles/Mes/InitialLine", v4):Clone();
    ParticleHandler.Unusualify(v7, {
        HSVData = v5
    });
    v7.CFrame = CFrame2 * CFrame.Angles(0, 1.5707963267948966, 0);
    v7.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = v7;
    task.delay(0.5, v7.Destroy, v7);
    TweenService:Create(v7, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = Vector3.new(34, 0, 0),
        CFrame = v7.CFrame * CFrame.new(17, 0, 0)
    }):Play();
    local v8 = CFrame.new(p2, p2 + (p2 - CFrame2.Position).Unit);
    EffectsHandler.CallEffect("Generate Quasiduck Lightning", p1, {
        Speed = 7.33,
        Sparks = true,
        Size = 0.6,
        Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(255, 57, 60)), v5),
        CFrames = { CFrame2, v8 }
    });
    EffectsHandler.CallEffect("Generate Quasiduck Lightning", p1, {
        Speed = 6.66,
        Size = 0.6,
        Sparks = true,
        Color = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
        CFrames = { CFrame2, v8 }
    });

    for i = 1, 2 do
        local v9 = i % 2 == 0 and -1 or 1;
        local Magnitude = (CFrame2.Position - v8.Position).Magnitude;
        local v10 = CFrame2 * CFrame.new(math.random(25, 50) / 10 * v9, math.random(25, 50) / 10 * v9, 0);
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", p1, {
            Speed = 6.66,
            Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(255, 57, 60)), v5),
            CFrames = { v10, v10 * CFrame.new(0, 0, -Magnitude) },
            Size = math.random(45, 55) / 100
        });
    end;

    for _ = 1, 3 do
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", p1, {
            PartCount = 8,
            Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(255, 57, 60)), v5),
            Speed = 1 / (math.random(5, 20) / 75),
            CFrames = { CFrame2 * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-25, -10)), v8 * CFrame.new(math.random(-10, 10) / 10, math.random(-10, 10) / 10, math.random(-10, 10) / 10) },
            Size = math.random(25, 45) / 100
        });
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", p1, {
            PartCount = 8,
            Color = ColorSequence.new(Color3.fromRGB(0, 0, 0)),
            Speed = 1 / (math.random(5, 20) / 75),
            CFrames = { CFrame2 * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-25, -10)), v8 * CFrame.new(math.random(-10, 10) / 10, math.random(-10, 10) / 10, math.random(-10, 10) / 10) },
            Size = math.random(25, 45) / 100
        });
    end;
end;
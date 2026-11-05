  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1) -- Line: 12
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local Character = p1.Character;
    local SkinName = p1.SkinName;
    local Start = p1.Start;
    local Distance = p1.Distance;
    local Size = p1.Size;

    if not (Character and Character:IsDescendantOf(game)) then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v2 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/InjectionShot/Pierce",
        AbilityName = "Ope",
        MaxRenderDistance = 350,
        Character = Character,
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -0.5, -3.4),
        SkinName = SkinName
    });
    EffectsHandler.CallEffect("Cutlass Pierce", {
        Character = Character,
        Start = Start,
        Distance = Distance,
        Size = Size
    });
    local Model = Instance.new("Model");
    Model.Name = "Injection Shot Container";
    Model.Parent = workspace.Effects;
    task.delay(2, Model.Destroy, Model);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Model;
    local v3 = AssetHandler.GetAsset("Particles/Mes/InitialLine", {
        AbilityName = "Ope",
        SkinName = SkinName
    }):Clone();
    v3.CFrame = Start * CFrame.Angles(0, 1.5707963267948966, 0);
    v3.Color = ParticleHandler.TryHSVShift(Color3.fromRGB(9, 137, 207));
    ParticleHandler.Unusualify(v3, {
        HSVData = v2
    });
    v3.Parent = Model;
    task.delay(0.5, v3.Destroy, v3);
    TweenService:Create(v3, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = Vector3.new(Distance, 0, 0),
        CFrame = v3.CFrame * CFrame.new(Distance / 2, 0, 0)
    }):Play();
    local v4 = Start * CFrame.new(0, 0, -Distance);

    for i = 1, 2 do
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", Character, {
            Speed = 5.75,
            Length = 1.25,
            Size = 0.6,
            Sparks = true,
            Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(119, 136, 245)), v2),
            CFrames = { Start * CFrame.new(4.5 * (i % 2 == 0 and 1 or -1), 0, 0), v4 },
            Parent = Model
        });
    end;
end;
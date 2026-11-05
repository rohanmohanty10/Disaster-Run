  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local _ = v2.Player;
    local u3 = v2.Speed or 1;
    local Animation = v2.Animation;
    local Character = v2.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local v4 = AssetHandler.GetAbilityData(Character);
    local u5 = AssetHandler.CloneAsset("Models/Dragon", v4);
    u5.Parent = workspace.Effects;
    ParticleHandler.AttachTo(u5.RootPart, {
        Part = HumanoidRootPart,
        Offset = CFrame.Angles(0, -3.141592653589793, 0)
    });
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = u5;
    u5.AnimationController.Animator:LoadAnimation(Animation2):Play(0, nil, u3);
    EffectsHandler.CallEffect("HighlightObject", u5, {
        OutlineTransparency = 1,
        FillTransparency = 0,
        Lifetime = 0.75,
        Style = "Exponential",
        Tween = true,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.fromRGB(255, 255, 255)
    });

    for _, child in u5:GetChildren() do
        local v6 = child:FindFirstChildOfClass("SurfaceAppearance");

        if v6 then
            local EmissiveStrength = v6.EmissiveStrength;
            v6.EmissiveStrength = 40;
            TweenService:Create(v6, TweenInfo.new(0.44 / u3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                EmissiveStrength = EmissiveStrength
            }):Play();
        end;
    end;

    local u7 = nil;
    local u8 = false;

    local function Destroy() -- Line: 81
        -- upvalues: u8 (ref), u7 (ref), u5 (copy), ParticleHandler (ref), TweenService (ref), u3 (copy)
        if u8 then
            return;
        end;

        u8 = true;

        if u7 then
            u7:Disconnect();
            u7 = nil;
        end;

        task.delay(1.5, u5.Destroy, u5);
        ParticleHandler.EnableAllParticles(u5, false);

        for _, descendant in u5:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.3 / u3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end;

    local Mouth = u5.PrimaryPart:WaitForChild("Bone"):WaitForChild("Mouth");
    task.delay(1.9166666666666667 / u3, function() -- Line: 106
        -- upvalues: u8 (ref), ParticleHandler (ref), Mouth (copy), EffectsHandler (ref), Character (copy), u3 (copy)
        if u8 then
            return;
        end;

        ParticleHandler.EnableVFX(Mouth, true, { "ParticleEmitter", "PointLight" });
        print(Mouth);
        task.spawn(EffectsHandler.CallEffect, "Radial Bezier", Character, {
            Path = "Particles/Misc/Trails",
            Rate = 0.03,
            Radius = 17,
            Goal = Mouth,
            Duration = 0.27 / u3,
            Lifetime = NumberRange.new(0.16363636363636364, 0.3103448275862069)
        });
    end);
    task.delay(2.4166666666666665 / u3, function() -- Line: 121
        -- upvalues: u8 (ref), ParticleHandler (ref), Mouth (copy)
        if u8 then
            return;
        end;

        ParticleHandler.EnableVFX(Mouth, false, { "ParticleEmitter", "PointLight" });
    end);
    task.delay(2.6666666666666665 / u3, Destroy);
    task.delay(2.2666666666666666 / u3, function() -- Line: 129
        -- upvalues: u5 (copy)
        if u5 then
            u5:IsDescendantOf(game);
        end;
    end);
    u7 = Character:GetAttributeChangedSignal("ConstantFlux"):Connect(function() -- Line: 135
        -- upvalues: Character (copy), Destroy (copy)
        if not Character:GetAttribute("ConstantFlux") then
            Destroy();
        end;
    end);
end;
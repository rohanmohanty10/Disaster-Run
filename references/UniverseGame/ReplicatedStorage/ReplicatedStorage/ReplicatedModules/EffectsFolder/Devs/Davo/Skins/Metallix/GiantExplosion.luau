  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 9
    -- upvalues: AssetHandler (copy), LocalPlayer (copy), EffectsHandler (copy), TweenService (copy), ParticleHandler (copy)
    local v2 = p1.Size or 120;
    local v3 = p1.LightingDistance or v2 + 50;
    local v4 = p1.Origin or p1.CFrame;
    local v5 = typeof(v4) == "Vector3" and v4 and v4 or v4.Position;

    if typeof(v4) == "Vector3" then
        v4 = CFrame.new(v4) or v4;
    end;

    local u6 = AssetHandler.GetAsset("Raigo/Meshes", {
        AbilityName = "KillEffects"
    });
    local v7 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

    if v7 and (v5 - v7.Position).Magnitude <= v3 then
        task.delay(0.05, function() -- Line: 20
            -- upvalues: EffectsHandler (ref), TweenService (ref)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Brightness = 0.1;
            ColorCorrectionEffect.Saturation = -1;
            ColorCorrectionEffect.Contrast = -5;
            ColorCorrectionEffect.Parent = game.Lighting;
            EffectsHandler.Wait(0.05);
            ColorCorrectionEffect.Contrast = 1;
            EffectsHandler.Wait(0.05);
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Saturation = 0,
                Contrast = 0,
                Brightness = 0
            }):Play();
            task.delay(0.35, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
        end);
    end;

    local u8 = AssetHandler.CloneAsset("Raigo/Explode", {
        AbilityName = "KillEffects"
    });
    u8.CFrame = v4;
    u8.Parent = workspace.Effects;
    ParticleHandler.Unusualify(u8, {
        IncludeParts = true,
        HSVData = {
            HueShift = 38,
            Saturation = 0.8,
            Value = 1,
            Chroma = false
        },
        HSVDataParams = {}
    });
    local v9 = {};

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("Beam") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.35,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
            table.insert(v9, descendant);
        end;
    end;

    AssetHandler.ScaleAsset(u8, {
        Scale = v2,
        TweenInfo = { 0.35 }
    });
    task.delay(0.4, AssetHandler.ScaleAsset, u8, {
        Scale = 1.25,
        TweenInfo = { 1.6 }
    });
    task.delay(1, function() -- Line: 89
        -- upvalues: TweenService (ref), u8 (copy), EffectsHandler (ref)
        TweenService:Create(u8, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
            Transparency = 1
        }):Play();

        for _, descendant in pairs(u8:GetDescendants()) do
            if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
                EffectsHandler.CallEffect("Boat Tween", descendant, {
                    Time = 0.35,
                    EasingStyle = "EntranceExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Transparency = NumberSequence.new(1)
                    }
                });
            end;
        end;

        task.delay(0.8, u8.Destroy, u8);
    end);
    task.spawn(function() -- Line: 113
        -- upvalues: EffectsHandler (ref), u8 (copy), TweenService (ref), u6 (copy)
        for _ = 1, 4 do
            EffectsHandler.Wait(0.15);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            Part.Size = Vector3.new(20, 20, 20);
            Part.Position = u8.Position;
            Part.Color = u8.Color;
            Part.Material = Enum.Material.ForceField;
            Part.Shape = Enum.PartType.Ball;
            Part.Parent = workspace.Effects;
            TweenService:Create(Part, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = Vector3.new(88.88889, 88.88889, 88.88889),
                Transparency = 1
            }):Play();
            task.delay(0.5, Part.Destroy, Part);
            local v10 = u6.Shockwave:Clone();
            v10.Size = Vector3.new(4, 20, 20);
            v10.Position = u8.Position;
            v10.Parent = workspace.Effects;
            TweenService:Create(v10, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = Vector3.new(3.888889, 72.22222, 72.22222),
                Orientation = v10.Orientation + Vector3.new(0, 240, 0)
            }):Play();
            EffectsHandler.Wait(0.2);
            TweenService:Create(v10, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = Vector3.new(0, 72.22222, 72.22222),
                Transparency = 1
            }):Play();
            task.delay(0.5, v10.Destroy, v10);
        end;
    end);
end;
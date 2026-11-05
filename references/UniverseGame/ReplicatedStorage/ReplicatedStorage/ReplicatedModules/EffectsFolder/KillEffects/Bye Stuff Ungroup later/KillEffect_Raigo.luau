  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);

return function(p4) -- Line: 14
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), LightningBolt (copy), TweenService (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local u6 = AssetHandler.GetAsset("Raigo/Meshes", {
        AbilityName = "KillEffects"
    });
    local u7 = AssetHandler.CloneAsset("Raigo/Summoning", {
        AbilityName = "KillEffects"
    });
    u7.Parent = workspace.Effects;
    u7:PivotTo(CFrame2 * CFrame.new(0, 60, 0));
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    AssetHandler.ScaleAsset(u7.Raigo, {
        Scale = 5,
        TweenInfo = { 2 }
    });
    task.spawn(function() -- Line: 44
        -- upvalues: u7 (copy), LightningBolt (ref), EffectsHandler (ref)
        local v8 = { Color3.fromRGB(110, 153, 202) };

        for _ = 1, 50 do
            local Attachment = Instance.new("Attachment");
            Attachment.WorldCFrame = u7.Raigo.CFrame * CFrame.new(math.random(-30, 30), math.random(-20, 20), math.random(-30, 30));
            Attachment.Parent = workspace.Terrain;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Parent = u7.Raigo;
            local v9 = LightningBolt.new(Attachment2, Attachment, 22);
            v9.PulseSpeed = 4.25;
            v9.PulseLength = 0.7;
            v9.Thickness = 0.85;
            v9.MinThicknessMultiplier = 0.65;
            v9.MaxThicknessMultiplier = 1;
            v9.AnimationSpeed = 6.25;
            v9.MaxRadius = 10;
            v9.MinTransparency = 0;
            v9.MaxTransparency = 1;
            v9.ContractFrom = 1;
            v9.Color = v8[math.random(1, #v8)];
            EffectsHandler.Wait(0.04);
        end;
    end);
    task.delay(2, function() -- Line: 74
        -- upvalues: u7 (copy), u6 (copy), TweenService (ref), EffectsHandler (ref), CFrame2 (copy), AssetHandler (ref), LightningBolt (ref)
        local Raigo = u7.Raigo;
        task.spawn(function() -- Line: 77
            -- upvalues: u6 (ref), Raigo (copy), TweenService (ref), EffectsHandler (ref)
            for _ = 1, 5 do
                local v10 = u6.ThinRing:Clone();
                v10.Size = Vector3.new(20, 4, 20);
                v10.Position = Raigo.Position;
                v10.Parent = workspace.Effects;
                TweenService:Create(v10, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Size = Vector3.new(50, 1.5384616, 50)
                }):Play();
                EffectsHandler.Wait(0.2);
                TweenService:Create(v10, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(50, 0, 50),
                    Transparency = 1
                }):Play();
                task.delay(0.5, v10.Destroy, v10);
            end;
        end);

        for _, descendant in u7:GetDescendants() do
            if not descendant:IsDescendantOf(Raigo) and descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        local v11 = TweenService:Create(Raigo, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            CFrame = CFrame2
        });
        v11:Play();
        v11.Completed:Connect(function() -- Line: 100
            -- upvalues: u7 (ref), AssetHandler (ref), EffectsHandler (ref), TweenService (ref), CFrame2 (ref), u6 (ref), LightningBolt (ref)
            task.delay(5, u7.Destroy, u7);
            AssetHandler.ScaleAsset(u7.Raigo, {
                Scale = 0,
                TweenInfo = { 0.3 }
            });
            task.delay(0.05, function() -- Line: 108
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
            local u12 = AssetHandler.CloneAsset("Raigo/Explode", {
                AbilityName = "KillEffects"
            });
            u12.CFrame = CFrame2;
            u12.Parent = workspace.Effects;
            local v13 = {};

            for _, descendant in pairs(u12:GetDescendants()) do
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
                    table.insert(v13, descendant);
                end;
            end;

            AssetHandler.ScaleAsset(u12, {
                Scale = 120,
                TweenInfo = { 0.35 }
            });
            task.delay(0.4, AssetHandler.ScaleAsset, u12, {
                Scale = 1.25,
                TweenInfo = { 1.6 }
            });
            task.delay(1, function() -- Line: 166
                -- upvalues: TweenService (ref), u12 (copy), EffectsHandler (ref)
                TweenService:Create(u12, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    Transparency = 1
                }):Play();

                for _, descendant in pairs(u12:GetDescendants()) do
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

                task.delay(0.8, u12.Destroy, u12);
            end);
            task.spawn(function() -- Line: 190
                -- upvalues: EffectsHandler (ref), u12 (copy), TweenService (ref), u6 (ref)
                for _ = 1, 4 do
                    EffectsHandler.Wait(0.15);
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CastShadow = false;
                    Part.Size = Vector3.new(20, 20, 20);
                    Part.Position = u12.Position;
                    Part.Color = Color3.fromRGB(76, 94, 255);
                    Part.Material = Enum.Material.ForceField;
                    Part.Shape = Enum.PartType.Ball;
                    Part.Parent = workspace.Effects;
                    TweenService:Create(Part, TweenInfo.new(0.75, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = Vector3.new(88.88889, 88.88889, 88.88889),
                        Transparency = 1
                    }):Play();
                    task.delay(0.5, Part.Destroy, Part);
                    local v14 = u6.Shockwave:Clone();
                    v14.Size = Vector3.new(4, 20, 20);
                    v14.Position = u12.Position;
                    v14.Parent = workspace.Effects;
                    TweenService:Create(v14, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = Vector3.new(3.888889, 72.22222, 72.22222),
                        Orientation = v14.Orientation + Vector3.new(0, 240, 0)
                    }):Play();
                    EffectsHandler.Wait(0.2);
                    TweenService:Create(v14, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Size = Vector3.new(0, 72.22222, 72.22222),
                        Transparency = 1
                    }):Play();
                    task.delay(0.5, v14.Destroy, v14);
                end;
            end);
            task.spawn(function() -- Line: 232
                -- upvalues: u12 (copy), LightningBolt (ref), EffectsHandler (ref)
                for _ = 1, 30 do
                    local Attachment = Instance.new("Attachment");
                    Attachment.WorldCFrame = u12.CFrame * CFrame.new(math.random(-45, 45), math.random(10, 40), math.random(-45, 45));
                    Attachment.Parent = workspace.Terrain;
                    local Attachment2 = Instance.new("Attachment");
                    Attachment2.Parent = u12;
                    local v15 = LightningBolt.new(Attachment2, Attachment, 22);
                    v15.PulseSpeed = 4.25;
                    v15.PulseLength = 0.7;
                    v15.Thickness = 0.85;
                    v15.MinThicknessMultiplier = 0.65;
                    v15.MaxThicknessMultiplier = 1;
                    v15.AnimationSpeed = 6.25;
                    v15.MaxRadius = 10;
                    v15.MinTransparency = 0;
                    v15.MaxTransparency = 1;
                    v15.ContractFrom = 1;
                    v15.Color = Color3.fromRGB(110, 153, 202);
                    EffectsHandler.Wait(0.04);
                end;
            end);
        end);
    end);
end;
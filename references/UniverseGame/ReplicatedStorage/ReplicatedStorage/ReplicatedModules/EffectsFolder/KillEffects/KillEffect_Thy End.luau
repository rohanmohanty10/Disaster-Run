  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local v2 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    local u3 = AssetHandler.CloneAsset("Thy End/Summon", {
        AbilityName = "KillEffects"
    });
    u3.CFrame = CFrame2;
    u3.Parent = workspace.Effects;
    ParticleHandler.DestroyEmit(u3, 10);
    local u4 = AssetHandler.GetAsset("Thy End/Trails", {
        AbilityName = "KillEffects"
    }):GetChildren();

    for i = 1, 10 do
        local u5 = v2:NextNumber(0.27, 0.46);
        local u6 = CFrame2 * CFrame.new(v2:NextNumber(-20, 20), v2:NextNumber(-20, 20), v2:NextNumber(-20, 20));
        local u7 = CFrame2 * CFrame.new(v2:NextNumber(-14, 14), v2:NextNumber(-14, 14), v2:NextNumber(-14, 14));
        local u8 = CFrame2 * CFrame.new(v2:NextNumber(-8, 8), v2:NextNumber(-8, 8), v2:NextNumber(-8, 8));
        task.spawn(function() -- Line: 41
            -- upvalues: u4 (copy), i (copy), u5 (copy), u6 (copy), u7 (copy), u8 (copy), CFrame2 (copy), EffectsHandler (ref), ParticleHandler (ref), TargetCharacter (copy), AssetHandler (ref), TweenService (ref), u3 (copy)
            local v9 = u4[i % 2 == 0 and 1 or 2]:Clone();
            v9.Parent = workspace.Effects;
            local v10 = math.ceil(u5 * 60);

            for i2 = 1, v10 do
                if not v9:IsDescendantOf(game) then
                    break;
                end;

                local v11 = i2 / v10;
                v9.Position = (1 - v11) ^ 3 * u6.Position + 3 * (1 - v11) ^ 2 * v11 * u7.Position + 3 * (1 - v11) * v11 ^ 2 * u8.Position + v11 ^ 3 * CFrame2.Position;
                EffectsHandler.Wait();
            end;

            if not v9:IsDescendantOf(game) then
                return;
            end;

            ParticleHandler.EnableAllParticles(v9, false);
            ParticleHandler.DestroyEmit(v9, 5);

            if i ~= 10 then
                ParticleHandler.Emit(u3, ParticleHandler.GenerateEmitInfo(u3));

                return;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Thy End/Trigger",
                AbilityName = "KillEffects",
                Origin = CFrame2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966)
            });
            task.spawn(function() -- Line: 71
                -- upvalues: TargetCharacter (ref), AssetHandler (ref), CFrame2 (ref), TweenService (ref), EffectsHandler (ref)
                local Highlight = Instance.new("Highlight");
                Highlight.OutlineTransparency = 1;
                Highlight.FillTransparency = 0.5;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.Parent = TargetCharacter;

                for i2 = 1, 5 do
                    if i2 == 5 then
                        local v12 = AssetHandler.CloneAsset("Thy End/Distortion", {
                            AbilityName = "KillEffects"
                        });
                        v12.Transparency = 4;
                        v12.Size = Vector3.new(25, 25, 25);
                        v12.Position = CFrame2.Position;
                        v12.Parent = workspace.Effects;
                        task.delay(0.3, v12.Destroy, v12);
                        TweenService:Create(v12, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Transparency = 1,
                            Size = Vector3.new(0, 0, 0)
                        }):Play();
                    else
                        local Part = Instance.new("Part");
                        Part.Transparency = 1;
                        Part.Shape = "Ball";
                        Part.Material = Enum.Material.Neon;
                        Part.Color = i2 % 2 == 0 and Color3.new(0.482353, 0.631373, 0.858824) or Color3.new(0.835294, 0.45098, 0.239216);
                        Highlight.FillColor = Part.Color;
                        Part.Size = Vector3.new(18, 18, 18);
                        Part.Anchored = true;
                        Part.CanCollide = false;
                        Part.CastShadow = false;
                        Part.Position = CFrame2.Position;
                        Part.Parent = workspace.Effects;
                        task.delay(1.1, Part.Destroy, Part);
                        TweenService:Create(Part, TweenInfo.new(0.08, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                            Size = Vector3.new(0, 0, 0),
                            Transparency = 0.7
                        }):Play();
                        EffectsHandler.Wait(0.08);
                    end;
                end;
            end);
            task.delay(0.4, function() -- Line: 123
                -- upvalues: u3 (ref), EffectsHandler (ref), TargetCharacter (ref), CFrame2 (ref)
                task.delay(2.5, u3.Destroy, u3);
                EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Thy End/Explosion",
                    AbilityName = "KillEffects",
                    Origin = CFrame2 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966)
                });
            end);
        end);
        EffectsHandler.Wait(0.1);
    end;
end;
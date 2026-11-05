  

 

local Players = game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
require(PathShortcuts.ReplicatedModules.Classes.Particle);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local FXHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.FXHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local Settings = LocalPlayer:WaitForChild("Settings");
local u1 = 0;
local Callbacks = require(script.Callbacks);

return function(p2) -- Line: 25
    -- upvalues: ParticleHandler (copy), LocalPlayer (copy), CurrentCamera (copy), u1 (ref), Players (copy), AssetHandler (copy), TableUtil (copy), PathShortcuts (copy), Settings (copy), FXHandler (copy), Callbacks (copy), SoundGroups (copy), EffectsHandler (copy)
    local v3 = p2 or {};
    local v4 = nil;
    local v5 = v3.Origin or (v3.CFrame or nil);

    if v3.TranslateToPosition and typeof(v5) == "Instance" then
        if v5:IsA("Model") then
            v4 = CFrame.new(v5:GetPivot().Position);
        elseif v5:IsA("Part") then
            v4 = CFrame.new(v5.Position);
        end;
    else
        v4 = ParticleHandler.TranslateToCFrame(v5);
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if not Character:FindFirstChild("HumanoidRootPart") then
        return;
    end;

    if v4 and (v3.MaxRenderDistance or 250) < (CurrentCamera.CFrame.Position - v4.Position).Magnitude then
        return;
    end;

    if u1 > 20 and not v3.BypassRenderCap then
        return;
    end;

    local v6 = {};
    local Size = v3.Size;
    local Particle = v3.Particle;
    local Path = v3.Path;
    local RawPath = v3.RawPath;
    local SkinName = v3.SkinName;
    local AbilityName = v3.AbilityName;
    local Player = v3.Player;
    local v7 = v3.Character or (v3.Player and v3.Player:IsA("Player") and v3.Player.Character or v3.Player);
    local Properties = v3.Properties;
    local Scale = v3.Scale;
    local ScaleLifetime = v3.ScaleLifetime;
    local ScaleTo = v3.ScaleTo;
    local PlaySounds = v3.PlaySounds;
    local v8 = v3.AttributeColors or {};
    local LockToPart = v3.LockToPart;
    local PointLightTime = v3.PointLightTime;
    local v9 = v3.IgnoreData or false;
    local v10;

    if v7 then
        v10 = v7:GetAttribute("ChromaUnusual");
    else
        v10 = v7;
    end;

    local v11 = Player or v7;
    local v12;

    if v11 == nil or not v11:IsA("Model") then
        v12 = v11;
    else
        v12 = Players:GetPlayerFromCharacter(v11);

        if v12 == nil then
            v12 = v11;
        end;
    end;

    local v13 = 0;
    local v14 = nil;
    local v15 = nil;

    if not v9 and (v12 and (v12.Data and v12.Data.Skin)) then
        if v12.Data.Skin:GetAttribute("UnusualHueId") then
            v13 = v13 + v12.Data.Skin:GetAttribute("UnusualHueId") * 5;
        end;

        if v12.Data.Skin:GetAttribute("UnusualSaturation") then
            v14 = v12.Data.Skin:GetAttribute("UnusualSaturation");
        end;

        if v12.Data.Skin:GetAttribute("UnusualValue") then
            v15 = v12.Data.Skin:GetAttribute("UnusualValue");
        end;
    end;

    if not v9 and (not SkinName and (v12 and (v12.Data and v12.Data.Skin))) then
        SkinName = v12.Data.Skin:GetAttribute("SkinName");
    end;

    if not v9 and (not AbilityName and (v12 and (v12.Data and v12.Data.Ability))) then
        AbilityName = v12.Data.Ability:GetAttribute("AbilityName");
    end;

    if Path then
        local v16 = {
            AbilityName = AbilityName,
            SkinName = SkinName,
            RootFolder = v3.PathFolder
        };

        if RawPath then
            v16 = nil;
        end;

        Particle = AssetHandler.GetAsset(Path, v16);

        if v7 and (v7:GetAttribute("MimicryAbilityName") and not Particle) then
            Particle = AssetHandler.GetAsset(Path, {
                AbilityName = v7:GetAttribute("MimicryAbilityName"),
                RootFolder = v3.PathFolder
            });
            v13 = v13 + (v7:GetAttribute("MimicryHueShift") or 312);
        end;
    end;

    local ParticleName = v3.ParticleName;

    if not ParticleName then
        if Particle then
            ParticleName = Particle.Name;
        end;
    end;

    local v17 = ParticleHandler.GetParticleInfo(ParticleName) or {};

    if not Particle and v17 then
        Particle = v17.Object;
    end;

    if Particle then
        local v18 = ParticleHandler.TranslateToCFrame(v3.Offset);

        if v18 ~= nil and typeof(v18) == "CFrame" then
            v4 = v4 * v18;
        end;

        if v3.Clone ~= false then
            Particle = Particle:Clone();
        end;

        if typeof(Particle) == "Instance" and (Particle:IsA("Model") and ScaleTo) then
            Particle:ScaleTo(ScaleTo);
        end;

        if Size then
            Particle.Size = Size;
        end;

        local v19 = ParticleHandler.TranslateToCFrame(v3.LookAt);
        local AttachTo = v3.AttachTo;

        if AttachTo then
            ParticleHandler.AttachTo(Particle, AttachTo);
        elseif v19 then
            ParticleHandler.MoveTo(Particle, CFrame.lookAt(v4.Position, v19.Position));
        else
            ParticleHandler.MoveTo(Particle, v4);
        end;

        if v3.ParticleColor and typeof(v3.ParticleColor) == "ColorSequence" then
            ParticleHandler.ColorParticle(Particle, v3.ParticleColor);
        end;

        ParticleHandler.UpdateGroundColors(Particle, v4);

        if v3.HueShift then
            ParticleHandler.HueShiftParticles(Particle, v3.HueShift);
        end;

        if v3.HSVShift then
            ParticleHandler.HSVShiftParticles(Particle, v3.HSVShift);
        end;

        if LockToPart ~= nil then
            ParticleHandler.LockToPart(Particle, LockToPart);
        end;

        if type(v3.Delay) == "number" then
            task.wait(v3.Delay);
        end;

        local v20 = v17.Particles or (v17.ParticleInfo or ParticleHandler.GenerateEmitInfo(Particle));
        local v21 = ParticleHandler.GetSkinInfo(SkinName);
        local v22;

        if v3.IgnoreSkinShift or not v21 then
            v22 = v20;
        else
            local v23 = TableUtil.Copy(v21.Metadata or {}, true);
            local v24 = TableUtil.Copy(v21[ParticleName] or {}, true);
            local v25 = v24.HueShift or v23.HueShift;

            if v25 and v3.HueShift ~= false then
                ParticleHandler.HueShiftParticles(Particle, v25);
            end;

            local v26 = v24.HSVShift or v23.HSVShift;

            if v26 and v3.HueShift ~= false then
                local v27 = type(v26) == "function" and (v26(v3) or {}) or v26;
                ParticleHandler.HSVShiftParticles(Particle, v27);
            end;

            if v24.Particles then
                v22 = v24.Particles;

                if v24.Reconcile then
                    v22 = TableUtil.Reconcile(v22, v20);
                end;
            else
                v22 = v20;
            end;

            if ParticleHandler.IsUnusualValue(v13) == true and v23.SaturationThreshold then
                ParticleHandler.HSVShiftParticles(Particle, {
                    SaturationThreshold = v23.SaturationThreshold
                });
            end;
        end;

        if ParticleHandler.IsUnusualValue(v13) and not (v3.IgnoreUnusuals or v10) then
            local v28 = {
                HueShift = v13,
                Saturation = v3.Saturation or v14,
                Value = v15
            };

            if v21 ~= nil and (v21.UnusualMetadata ~= nil and (v21.UnusualMetadata.HSVShift ~= nil and not (v14 or v15))) then
                v28 = TableUtil.Reconcile(v28, v21.UnusualMetadata.HSVShift);
            end;

            ParticleHandler.HSVShiftParticles(Particle, v28);
        end;

        if v10 then
            PathShortcuts.Remotes.ClientBind:Fire(v7, "Chroma", Particle);
        end;

        if v22 then
            for i, v in pairs(v22) do
                if v.Properties then
                    local v29 = Particle:FindFirstChild(i, true);

                    if v29 and v29:IsA("ParticleEmitter") or v29:IsA("Trail") then
                        ParticleHandler.ChangeProperties(v29, v.Properties);
                    end;
                end;
            end;
        end;

        for _, v in v22 do
            if Settings and (Settings:FindFirstChild("ParticleEmissionScalar") and (v.EmitAmount and v.EmitAmount >= 1)) then
                local Value = Settings.ParticleEmissionScalar.Value;

                if Value < 1 then
                    local v30 = math.ceil(v.EmitAmount * Value);
                    v.EmitAmount = math.clamp(v30, 1, v.EmitAmount);
                elseif Value == 1 then
                    v.EmitAmount = FXHandler.ScaleQuality(v.EmitAmount);
                end;
            end;

            if v3.OverrideDuration and (v.EmitDuration and v.EmitDuration > 0) then
                v.EmitDuration = v3.OverrideDuration;
            end;
        end;

        if Properties then
            ParticleHandler.ChangeProperties(Particle, Properties);
        end;

        if v3.ParticleProperties then
            for _, descendant in ipairs(Particle:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    if v3.ParticleProperties.RotationOffset then
                        local RotationOffset = v3.ParticleProperties.RotationOffset;
                        local Rotation = descendant.Rotation;
                        descendant.Rotation = NumberRange.new(Rotation.Min + RotationOffset, Rotation.Max + RotationOffset);
                    end;

                    if not v3.ParticleProperties.SkipApply then
                        ParticleHandler.ChangeProperties(descendant, v3.ParticleProperties);
                    end;
                end;
            end;
        end;

        if ScaleLifetime then
            ParticleHandler.ScaleLifetime(Particle, ScaleLifetime);
        end;

        if v8 then
            ParticleHandler.UpdateAttributeColors(Particle, v8);
        end;

        for _, v in ipairs({ Particle, unpack(Particle:GetDescendants()) }) do
            if v:IsA("BasePart") then
                v.CanCollide = false;
                v.CollisionGroup = "Ghosted";
            end;
        end;

        if v3.ParticleCallback and Callbacks[v3.ParticleCallback] then
            task.spawn(Callbacks[v3.ParticleCallback], TableUtil.Reconcile({
                Particle = Particle,
                ParticleHandler = ParticleHandler
            }, v3));
        end;

        if v3.Parent ~= false then
            Particle.Parent = workspace.Effects;
        end;

        if Scale then
            AssetHandler.ScaleAsset(Particle, typeof(Scale) == "table" and Scale and Scale or {
                Scale = Scale
            });
        end;

        if Particle:IsA("BasePart") and v3.Transparency ~= false then
            Particle.Transparency = 1;
        end;

        if PlaySounds then
            for _, descendant in pairs(Particle:GetDescendants()) do
                if descendant:IsA("Sound") then
                    SoundGroups:AssignSoundTag(descendant);
                    descendant:Play();
                end;
            end;
        end;

        local u31 = ParticleHandler.GetMaxLifetime(Particle);

        if not v3.BypassRenderCap then
            u1 = u1 + 1;
            task.delay(u31, function() -- Line: 351
                -- upvalues: u1 (ref)
                u1 = u1 - 1;
            end);
        end;

        if v3.EnableDuration then
            ParticleHandler.EnableVFX(Particle, true, { "ParticleEmitter", "Beam", "Trail" });
            task.delay(v3.EnableDuration, function() -- Line: 358
                -- upvalues: ParticleHandler (ref), Particle (ref), u31 (copy)
                ParticleHandler.EnableVFX(Particle, false, { "ParticleEmitter", "Beam", "Trail" });
                task.delay(u31, Particle.Destroy, Particle);
            end);
            v3.Destroy = false;
        elseif v3.Enabled == nil then
            ParticleHandler.Emit(Particle, v22);

            if v3.EmitBeams == true then
                v3.EmitBeams = {};
            end;

            if v3.EmitBeams and typeof(v3.EmitBeams) == "table" then
                v3.EmitBeams.Effect = Particle;
                EffectsHandler.CallEffect("Emit Beams", v3.EmitBeams);
            end;
        else
            v6.MaxLifetime = ParticleHandler.EnableParticle(Particle, v3.Enabled);
        end;

        if v3.VFXForgeEmit then
            EffectsHandler.CallEffect("VFXForge Mesh Emit", Particle, u31);
        end;

        local v32;

        if v3.Destroy == false then
            v32 = nil;
        else
            v32 = ParticleHandler.DestroyEmit(Particle, v3.Lifetime);
        end;

        v6.Particle = Particle;
        local v33 = Particle:FindFirstChildOfClass("PointLight");

        if v33 then
            game.TweenService:Create(v33, TweenInfo.new(PointLightTime or (v32 or 0.5), Enum.EasingStyle.Sine), {
                Brightness = 0
            }):Play();
        end;

        return v6;
    end;
end;
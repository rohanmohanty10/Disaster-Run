 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
game:GetService("StarterGui");
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.Brightness;
local _ = Lighting.ClockTime;
local _ = Lighting.Ambient;
local _ = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
require(ReplicatedStorage.util.Util);
local mainreplication = require(script.Parent.Parent.mainreplication);
require(script.Parent.Parent.TekrinnDialogue);
require(ReplicatedStorage.util.UwUEffects);
require(ReplicatedStorage.util.vfxUtil);

function v1.legacyisagiult(p2, p3) -- Line: 48
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy)
    local v4 = p2.HumanoidRootPart or p2.PrimaryPart;
    local _ = p2.Torso;
    mainreplication.sceneEnabled(true);
    local v5 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v5.Parent = Lighting;
    v5.FarIntensity = 0;
    TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.isagi["DIRECTA SHOOTOTA"], SoundService);
    mainreplication.cutscene(v4, CFrame.new(Vector3.new(0, 0, 0)), 5.5, ReplicatedStorage.Resources.Legacy.isagi.uFOV, true);
    local v6 = ReplicatedStorage.Resources.Legacy.isagi.JJ:Clone();
    v6.JJRootPart.JJRootPart.Part0 = v4;
    v6.Parent = v4;
    task.wait(0.15);
    local v7 = ReplicatedStorage.Resources.Legacy.isagi.step:Clone();
    v7.CFrame = v4.CFrame * CFrame.new(0.5, -2.6, 0.3);
    v7.Parent = workspace.Effects;

    for _, descendant in ipairs(v7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, v7.Destroy, v7);
    task.wait(0.3);
    local v8 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v8.Parent = Lighting;
    v8.Brightness = 0.3;
    TweenService:Create(v8, TweenInfo.new(1.5), {
        Brightness = 0
    }):Play();
    task.delay(1.5, v8.Destroy, v8);
    local v9 = ReplicatedStorage.Resources.Legacy.isagi.popup:Clone();
    v9.CFrame = v4.CFrame * CFrame.new(0.5, -3, 0.3);
    v9.Parent = workspace.Effects;

    for _, descendant in ipairs(v9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(descendant:GetAttribute("EmitCount"));
        end;
    end;

    task.delay(2, v9.Destroy, v9);
    task.wait(0.4);
    local v10 = ReplicatedStorage.Resources.Legacy.isagi.PE:Clone();
    v10:PivotTo(v4.CFrame * CFrame.new(0.5, -3, 0.3));
    v10.Parent = workspace.Effects;

    for _, descendant in ipairs(v10.PE:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(2, v10.Destroy, v10);
    local v11 = ReplicatedStorage.Resources.Legacy.isagi.PE2:Clone();
    v11.CFrame = v4.CFrame * CFrame.new(0.5, -3, 0.3);
    v11.Parent = workspace.Effects;
    task.delay(1, function() -- Line: 117
        -- upvalues: ReplicatedStorage (ref)
        local v12 = ReplicatedStorage.Resources.Legacy.isagi.bg:Clone();
        v12:PivotTo(workspace.CurrentCamera.CFrame * CFrame.new(0, 15, -15));
        v12.Parent = workspace.Effects;
        task.delay(1, v12.Destroy, v12);
    end);
    task.wait(2);

    for _, descendant in ipairs(v11:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(2, v11.Destroy, v11);
    TweenService:Create(Lighting.Atmosphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Density = 0.929,
        Haze = 4.55,
        Color = Color3.fromRGB(0, 0, 0)
    }):Play();
    local v13 = ReplicatedStorage.Resources.Legacy.isagi.line:Clone();
    v13.CFrame = CFrame.new(v4.Position) * CFrame.new(0, -0.7, 0);
    v13.Parent = workspace.Effects;
    task.delay(0.3, v13.Destroy, v13);

    for _, descendant in ipairs(v6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            ReplicatedStorage.Resources.Legacy.isagi.PointLight:Clone().Parent = descendant;
            descendant.Material = Enum.Material.Neon;
            TweenService:Create(descendant, TweenInfo.new(0.15), {
                Color = Color3.fromRGB(0, 145, 255)
            }):Play();
        end;
    end;

    task.wait(1.8);
    TweenService:Create(Lighting.Atmosphere, TweenInfo.new(0.3), {
        Density = Density,
        Color = Color
    }):Play();
    mainreplication.Emit(v4, ReplicatedStorage.Resources.Legacy.isagi.im1, 3, CFrame.new(0.95, -0.15, -3));
    local v14 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v14.Parent = Lighting;
    v14.Brightness = 0.3;
    TweenService:Create(v14, TweenInfo.new(1.5), {
        Brightness = 0
    }):Play();
    task.delay(1.5, v14.Destroy, v14);
    task.wait(0.9);
    v5:Destroy();
    v6:Destroy();
    mainreplication.sceneEnabled(false);
    mainreplication.bigshockwave(v4);
end;

function v1.legacyisagiawaken(p15) -- Line: 201
    -- upvalues: mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), RunService (copy), Lighting (copy), TweenService (copy)
    local v16 = p15.HumanoidRootPart or p15.PrimaryPart;
    local _ = p15.Torso;
    mainreplication.sceneEnabled(true);
    soundUtil:play(ReplicatedStorage.Resources.Legacy.isagi.isagiawaken, SoundService);
    mainreplication.cutscene(v16, CFrame.new(Vector3.new(0, 0, 0)), 4.5, ReplicatedStorage.Resources.Legacy.isagi.FOV);
    local u17 = ReplicatedStorage.Resources.Legacy.isagi.A:Clone();
    u17.CFrame = v16.CFrame;
    u17.Parent = p15;
    local v20 = RunService.PreRender:Connect(function(p18) -- Line: 215
        -- upvalues: u17 (copy)
        local v19 = u17;
        v19.CFrame = v19.CFrame * CFrame.Angles(0, 0.005, 0);
    end);
    local v21 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v21.Parent = Lighting;
    TweenService:Create(v21, TweenInfo.new(1.5), {
        Brightness = 0
    }):Play();
    task.delay(1.5, v21.Destroy, v21);
    local v22 = ReplicatedStorage.Resources.Legacy.isagi.RoomReal:Clone();
    v22.CFrame = v16.CFrame;
    v22.Parent = p15;
    task.wait(1.91);
    v22:Destroy();
    local v23 = ReplicatedStorage.Resources.Legacy.isagi.RoomReal2:Clone();
    v23.CFrame = v16.CFrame;
    v23.Parent = p15;
    local v24 = ReplicatedStorage.Resources.Legacy.isagi.legwater:Clone();
    v24.Parent = p15;
    v24.CFrame = CFrame.new(p15["Left Leg"].Position);
    local v25 = ReplicatedStorage.Resources.Legacy.isagi.legwater:Clone();
    v25.Parent = p15;
    v25.CFrame = CFrame.new(p15["Right Leg"].Position);
    task.wait(2.5);
    v23:Destroy();
    v20:Disconnect();
    u17:Destroy();
    v24:Destroy();
    v25:Destroy();
    local v26 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v26.Parent = Lighting;
    v26.Brightness = -1;
    task.wait(0.5);
    TweenService:Create(v26, TweenInfo.new(0.5), {
        Brightness = 0
    }):Play();
    task.delay(0.5, v26.Destroy, v26);
    mainreplication.fov(false, 40);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.sceneEnabled(false);
end;

function v1.legacytwogun(u27) -- Line: 298
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), PlayerGui (copy), mainreplication (copy), soundUtil (copy), SoundService (copy)
    local v28 = u27.HumanoidRootPart or u27.PrimaryPart;
    local _ = u27.Torso;
    local _ = Lighting.Atmosphere;
    local v29 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v29.Parent = Lighting;
    v29.Brightness = -1;
    TweenService:Create(v29, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v29.Destroy, v29);
    local u30 = ReplicatedStorage.Resources.Legacy.isagi.allGunEffect:Clone();
    u30:PivotTo(v28.CFrame);
    u30.Parent = u27;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    task.delay(0.3666666666666667, function() -- Line: 317
        -- upvalues: u30 (copy)
        for _, descendant in ipairs(u30.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.9, function() -- Line: 324
        -- upvalues: u30 (copy), TweenService (ref)
        u30.footya.Decal.Transparency = 0;
        TweenService:Create(u30.footya, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u30.footya.CFrame * CFrame.Angles(0, 0, 2.0943951023931953)
        }):Play();
        TweenService:Create(u30.footya.Decal, TweenInfo.new(1.55, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
    end);
    task.delay(2.2, function() -- Line: 330
        -- upvalues: ReplicatedStorage (ref), u27 (copy)
        local v31 = ReplicatedStorage.Resources.shidou.line:Clone();
        v31.Parent = u27["Right Leg"];
        task.delay(0.5, v31.Destroy, v31);
    end);
    task.delay(2.766666666666667, function() -- Line: 337
        -- upvalues: u30 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in ipairs(u30.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u30.End.Decal.Transparency = 0.95;
        u30.End.Mesh.Scale = Vector3.new(0.1, 0.15, 0.15);
        TweenService:Create(u30.End.Mesh, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Scale = Vector3.new(0.8, 0.2, 0.2)
        }):Play();
        TweenService:Create(u30.End, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = u30.End.CFrame * CFrame.Angles(1.0471975511965976, 0, 0)
        }):Play();
        TweenService:Create(u30.End.Decal, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        ColorCorrectionEffect.Contrast = -15;
        task.wait(0.03);
        ColorCorrectionEffect.Contrast = 15;
        task.wait(0.03);
        ColorCorrectionEffect.Contrast = 5;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.65), {
            Contrast = 0
        }):Play();
    end);
    local v32 = ReplicatedStorage.Resources.darkscreen:Clone();
    v32.Parent = PlayerGui;
    mainreplication.sceneEnabled(true);
    local v33 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v33.Parent = Lighting;
    v33.FarIntensity = 0;
    TweenService:Create(v33, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.isagi.isagitwogunvolley_1, SoundService);
    mainreplication.cutscene(v28, CFrame.new(Vector3.new(0, 0, 0)), 3.816666666666667, ReplicatedStorage.Resources.Legacy.isagi["2FOV"]);
    local v34 = ReplicatedStorage.Resources.Legacy.isagi.Gun1:Clone();
    v34.Parent = u27;
    v34.Gun1.Part0 = v28;
    local v35 = ReplicatedStorage.Resources.Legacy.isagi.Gun2:Clone();
    v35.Parent = u27;
    v35.Gun2.Part0 = v28;
    task.wait(3.816666666666667);
    v33:Destroy();
    v32:Destroy();
    v34:Destroy();
    v35:Destroy();
    local v36 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v36.Parent = Lighting;
    v36.Brightness = 1;
    task.wait(0.2);
    TweenService:Create(v36, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(0.4, v36.Destroy, v36);
    mainreplication.sceneEnabled(false);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

return v1;
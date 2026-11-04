 

 

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
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
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

function v1.legacysaeAwk(u2) -- Line: 48
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), PlayerGui (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local v3 = u2.HumanoidRootPart or u2.PrimaryPart;
    local _ = u2.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local v4 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v4.Parent = Lighting;
    v4.Brightness = -1;
    TweenService:Create(v4, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v4.Destroy, v4);
    local u5 = ReplicatedStorage.Resources.darkscreen:Clone();
    u5.Parent = PlayerGui;
    mainreplication.sceneEnabled(true);
    local u6 = ReplicatedStorage.Resources.Legacy.sae.effectawk:Clone();
    u6:PivotTo(v3.CFrame);
    u6.Parent = u2;

    for _, descendant in ipairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u7 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u7.Parent = Lighting;
    u7.FarIntensity = 0;
    TweenService:Create(u7, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.Legacy.sae["Itoshi lock in"], SoundService);
    mainreplication.cutscene(v3, CFrame.new(Vector3.new(0, 0, 0)), 10.55, ReplicatedStorage.Resources.Legacy.sae.FOV);
    local u8 = nil;
    task.delay(0.1166666666666667, function() -- Line: 89
        -- upvalues: u8 (ref), ReplicatedStorage (ref), u2 (copy)
        u8 = ReplicatedStorage.Resources.Legacy.sae.he:Clone();
        u8.Weld.Part0 = u2.Head;
        u8.Parent = u2;
        u8.e1.ParticleEmitter:Emit(1);
        u8.e2.ParticleEmitter:Emit(1);
        u8.eye.eye.Enabled = true;
        u8.eye.eye2.Enabled = true;
    end);
    task.delay(0.55, function() -- Line: 100
        -- upvalues: u8 (ref)
        if u8 then
            u8:Destroy();
        end;
    end);
    task.delay(1.633333333333333, function() -- Line: 106
        -- upvalues: u6 (copy)
        for _, descendant in ipairs(u6.slam:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u9 = nil;
    local u10 = nil;
    task.delay(3, function() -- Line: 117
        -- upvalues: TweenService (ref), Atmosphere (copy), ColorCorrectionEffect (copy), Lighting (ref), u9 (ref), ReplicatedStorage (ref), u2 (copy), u10 (ref)
        TweenService:Create(Atmosphere, TweenInfo.new(0.5), {
            Density = 0.4,
            Color = Color3.fromRGB(254, 38, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            TintColor = Color3.fromRGB(255, 103, 174)
        }):Play();
        TweenService:Create(Lighting, TweenInfo.new(0.5), {
            Brightness = 0,
            ColorShift_Top = Color3.fromRGB(255, 103, 174)
        }):Play();
        u9 = ReplicatedStorage.Resources.Legacy.sae.legaura:Clone();
        u9.Weld.Part0 = u2["Right Leg"];
        u9.Parent = u2;
        u10 = ReplicatedStorage.Resources.Legacy.sae.legaura:Clone();
        u10.Weld.Part0 = u2["Left Leg"];
        u10.Parent = u2;
        ColorCorrectionEffect.Contrast = 5;
        task.wait(0.03);
        ColorCorrectionEffect.Contrast = -5;
        task.wait(0.035);
        ColorCorrectionEffect.Contrast = -4;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Contrast = 1
        }):Play();
    end);
    task.delay(4.283333333333333, function() -- Line: 143
        -- upvalues: u9 (ref), u10 (ref), u6 (copy)
        u9:Destroy();
        u10:Destroy();
        u6.aura1.ez.sh3:Emit(4);

        for _, descendant in ipairs(u6.aura1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u6.au2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u11 = nil;
    local u12 = nil;
    task.delay(8.5, function() -- Line: 163
        -- upvalues: u12 (ref), ReplicatedStorage (ref), u11 (ref), RunService (ref)
        u12 = ReplicatedStorage.Resources.Legacy.sae.PartCF2:Clone();
        u12.Parent = workspace.Effects;
        u11 = RunService.PreRender:connect(function(p13) -- Line: 167
            -- upvalues: u12 (ref)
            u12.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -2);
        end);
    end);
    task.delay(8.683333333333334, function() -- Line: 185
        -- upvalues: u12 (ref), u11 (ref)
        u12:Destroy();
        u11:Disconnect();
    end);
    task.delay(10.55, function() -- Line: 190
        -- upvalues: u7 (copy), u6 (copy), ColorCorrectionEffect (copy), u5 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), ReplicatedStorage (ref), TweenService (ref), mainreplication (ref)
        u7:Destroy();
        u6:Destroy();
        ColorCorrectionEffect:Destroy();
        u5:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        local v14 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v14.Parent = Lighting;
        v14.Brightness = -1;
        task.wait(0.2);
        TweenService:Create(v14, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
        task.delay(1, v14.Destroy, v14);
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function v1.legacysaenutmeg(u15) -- Line: 218
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy), Brightness (copy)
    local v16 = u15.HumanoidRootPart or u15.PrimaryPart;
    local _ = u15.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    local u17 = ReplicatedStorage.Resources.Legacy.sae.saeEffect:Clone();
    u17:PivotTo(v16.CFrame);
    u17.Parent = u15;
    local u18 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u18.Parent = Lighting;
    u18.FarIntensity = 0;
    TweenService:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.Legacy.sae[`you'll never surpass me_{Random.new():NextInteger(1, 2)}`], SoundService);
    mainreplication.cutscene(v16, CFrame.new(Vector3.new(0, 0, 0)), 10.43333333333333, ReplicatedStorage.Resources.Legacy.sae.FOV2);
    task.delay(0.8166666666666667, function() -- Line: 242
        -- upvalues: u17 (copy)
        for _, descendant in ipairs(u17.hit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.216666666666667, function() -- Line: 250
        -- upvalues: ColorCorrectionEffect (copy)
        ColorCorrectionEffect.Contrast = 0.35;
        ColorCorrectionEffect.Saturation = -0.3;
    end);
    task.delay(3.716666666666667, function() -- Line: 255
        -- upvalues: u17 (copy)
        for _, descendant in ipairs(u17.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u19 = nil;
    task.delay(4.2, function() -- Line: 264
        -- upvalues: u19 (ref), ReplicatedStorage (ref), u15 (copy), u17 (copy)
        u19 = ReplicatedStorage.Resources.Legacy.sae.Head2:Clone();
        u19.Weld.Part0 = u15.Head;
        u19.Parent = u15;

        for _, descendant in ipairs(u17.aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.183333333333334, function() -- Line: 276
        -- upvalues: u19 (ref)
        u19:Destroy();
    end);
    task.delay(9.366666666666667, function() -- Line: 280
        -- upvalues: u17 (copy)
        for _, descendant in ipairs(u17.hit2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(10.43333333333333, function() -- Line: 288
        -- upvalues: u18 (copy), u17 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), ReplicatedStorage (ref), TweenService (ref), mainreplication (ref)
        u18:Destroy();
        u17:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        local v20 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v20.Parent = Lighting;
        v20.Brightness = 1;
        task.wait(0.2);
        TweenService:Create(v20, TweenInfo.new(1), {
            Brightness = 0
        }):Play();
        task.delay(1, v20.Destroy, v20);
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function v1.legacysaeskill2(p21, p22) -- Line: 315
    -- upvalues: Players (copy), soundUtil (copy), ReplicatedStorage (copy), workspace_CurrentCamera (copy), RunService (copy), Lighting (copy), TweenService (copy), mainreplication (copy)
    local u23 = p21.HumanoidRootPart or p21.PrimaryPart;
    Players.LocalPlayer.character:SetAttribute("disableRotate", true);
    soundUtil:play(ReplicatedStorage.Resources.Legacy.sae.countered, u23);
    local u24 = ReplicatedStorage.Resources.Legacy.sae.bgScene:Clone();
    u24.Parent = workspace.Effects;
    u24.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);

    for _, descendant in ipairs(u24:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;

    local v26 = RunService.PreRender:connect(function(p25) -- Line: 337
        -- upvalues: u24 (copy), workspace_CurrentCamera (ref)
        u24.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -2);
    end);
    task.delay(5, v26.Disconnect, v26);
    task.delay(5, u24.Destroy, u24);
    local v27 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v27.Parent = Lighting;
    v27.TintColor = Color3.fromRGB(149, 156, 255);
    v27.Brightness = 0.1;
    v27.Contrast = 15;
    TweenService:Create(v27, TweenInfo.new(0.55), {
        Contrast = 0.5
    }):Play();
    mainreplication.fov(false, 30);
    mainreplication.cameraShake(20, 1.5, 3);
    mainreplication.fov(true, 70, 0.8333333333333333, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.characterImage({
        Speed = 2.5,
        Brightness = 1,
        Whitelist = { p21 },
        Color = Color3.fromRGB(255, 255, 255)
    });
    task.wait(0.8333333333333333);
    mainreplication.cameraShake(20, 1, 3);
    TweenService:Create(v27, TweenInfo.new(1), {
        Contrast = 0,
        Brightness = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(1, v27.Destroy, v27);
    mainreplication.characterImage({
        Duration = 0.8,
        Speed = 0.5,
        CFrames = true,
        Brightness = 1,
        Count = 5,
        countSpeed = 0.1,
        Whitelist = { p21 },
        Color = Color3.fromRGB(220, 172, 255)
    });
    mainreplication.destroyPosition(p21);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 2500;
    BodyPosition.MaxForce = Vector3.new(30000, 0, 30000);
    BodyPosition.D = 500;
    BodyPosition.Parent = u23;
    TweenService:Create(BodyPosition, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        P = 12500,
        D = 300
    }):Play();
    local u28 = -10;
    local v30 = RunService.PreRender:Connect(function(p29) -- Line: 374
        -- upvalues: u28 (ref), BodyPosition (copy), u23 (copy)
        u28 = math.clamp(u28 + 0.7 * p29 * 60, -10, 0);
        BodyPosition.Position = u23.CFrame.LookVector * 7 + u23.CFrame.RightVector * u28 + u23.Position;
    end);
    task.delay(0.8, v30.Disconnect, v30);
    task.delay(0.8, BodyPosition.Destroy, BodyPosition);
    task.wait(0.4);
    TweenService:Create(BodyPosition, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        P = 2500,
        D = 500
    }):Play();
    Players.LocalPlayer.character:SetAttribute("disableRotate", false);
end;

function v1.legacysaePass(p31) -- Line: 461
    -- upvalues: Players (copy), mainreplication (copy), TweenService (copy), RunService (copy)
    local u32 = p31.HumanoidRootPart or p31.PrimaryPart;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p31) then
        return;
    end;

    mainreplication.fov(false, 55);
    mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.destroyPosition(p31);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 0, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = u32;
    TweenService:Create(BodyPosition, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        P = 2500,
        D = 500
    }):Play();
    local v34 = RunService.PreRender:Connect(function(p33) -- Line: 483
        -- upvalues: u32 (copy), BodyPosition (copy)
        BodyPosition.Position = u32.CFrame.LookVector * 0.5 + u32.Position;
    end);
    task.delay(0.7, v34.Disconnect, v34);
    task.delay(0.7, BodyPosition.Destroy, BodyPosition);
end;

return v1;
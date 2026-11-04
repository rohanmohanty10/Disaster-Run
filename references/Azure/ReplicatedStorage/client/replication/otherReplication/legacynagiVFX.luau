 

 

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

function v1.legacynagiawaken(p2) -- Line: 48
    -- upvalues: mainreplication (copy), Lighting (copy), ReplicatedStorage (copy), PlayerGui (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy)
    local v3 = p2.HumanoidRootPart or p2.PrimaryPart;
    local _ = p2.Torso;
    mainreplication.sceneEnabled(true);
    Lighting.Atmosphere.Density = 0.7;
    Lighting.Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Lighting.Atmosphere.Haze = 4.55;
    local v4 = ReplicatedStorage.Resources.darkscreen:Clone();
    v4.Parent = PlayerGui;
    local v5 = ReplicatedStorage.Resources.Legacy.nagi.sKULL:Clone();
    v5.Parent = p2;
    v5.sKULL.Part0 = v3;
    local v6 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v6.Parent = Lighting;
    v6.FarIntensity = 0;
    TweenService:Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local v7 = ReplicatedStorage.Resources.Legacy.nagi.ColorCorrection2:Clone();
    v7.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.Legacy.nagi["nagi awaken"], SoundService);
    mainreplication.cutscene(v3, CFrame.new(Vector3.new(0, 0, 0)), 7.083333492279053, ReplicatedStorage.Resources.Legacy.nagi["2FOV"]);
    local v8 = ReplicatedStorage.Resources.Legacy.nagi.awafloor:Clone();
    v8.CFrame = v3.CFrame * CFrame.new(0, -3, 0);
    v8.Parent = p2;
    local v9 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v9.Parent = Lighting;
    TweenService:Create(v9, TweenInfo.new(1.5), {
        Brightness = 0
    }):Play();
    task.delay(1.5, v9.Destroy, v9);
    task.wait(7.083333492279053);
    v4:Destroy();
    v7:Destroy();
    v5:Destroy();
    v8:Destroy();
    Lighting.Atmosphere.Density = Density;
    Lighting.Atmosphere.Color = Color;
    Lighting.Atmosphere.Haze = 3;
    v6:Destroy();
    local v10 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v10.Parent = Lighting;
    v10.Brightness = -1;
    task.wait(0.5);
    TweenService:Create(v10, TweenInfo.new(0.5), {
        Brightness = 0
    }):Play();
    task.delay(0.5, v10.Destroy, v10);
    mainreplication.fov(false, 40);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    mainreplication.sceneEnabled(false);
end;

function v1.legacynagicontrolwindup(p11, p12) -- Line: 150
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Players (copy), TweenService (copy), RunService (copy)
    local u13 = p11.HumanoidRootPart or p11.PrimaryPart;
    local _ = p11.Torso;
    local u14, u15;

    if p12 == "new" then
        u14 = 17.5;
        u15 = 5.75;
    else
        u14 = 5;
        u15 = 7;
    end;

    mainreplication.raycastEffect(u13, ReplicatedStorage.Resources.Legacy.nagi.jumpsmoke, 3);
    local u16 = ReplicatedStorage.Resources.armdrip:Clone();
    u16.Parent = p11;
    u16.Weld.Part0 = p11["Left Arm"];
    local u17 = ReplicatedStorage.Resources.armdrip:Clone();
    u17.Parent = p11;
    u17.Weld.Part0 = p11["Right Arm"];
    task.delay(0.3, function() -- Line: 173
        -- upvalues: u16 (copy), u17 (copy)
        for _, descendant in ipairs(u16:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u17:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u16.Destroy, u16);
        task.delay(2, u17.Destroy, u17);
    end);

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p11) then
        return;
    end;

    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(false, 90);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = u13;
    TweenService:Create(BodyPosition, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
        P = 2500,
        D = 500
    }):Play();
    local v19 = RunService.PreRender:connect(function(p18) -- Line: 202
        -- upvalues: u13 (copy), BodyPosition (copy), u14 (ref), u15 (ref)
        local CFrame2 = u13.CFrame;
        BodyPosition.Position = CFrame2.LookVector * u14 + CFrame2.UpVector * u15 + u13.Position;
    end);
    task.delay(0.3, v19.Disconnect, v19);
    task.delay(0.3, BodyPosition.Destroy, BodyPosition);
end;

function v1.legacynagicontrol(u20) -- Line: 215
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), soundUtil (copy), SoundService (copy)
    local u21 = u20.HumanoidRootPart or u20.PrimaryPart;
    local _ = u20.Torso;
    mainreplication.sceneEnabled(true);
    local v22 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v22.Parent = Lighting;
    v22.FarIntensity = 0;
    TweenService:Create(v22, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.nagi["catch ball"], SoundService);
    mainreplication.cutscene(u21, CFrame.new(Vector3.new(0, 0, 0)), 1.0499999523162842, ReplicatedStorage.Resources.Legacy.nagi.FOV, true);
    task.delay(0.15, function() -- Line: 236
        -- upvalues: ReplicatedStorage (ref), u21 (copy), u20 (copy), Lighting (ref), TweenService (ref), mainreplication (ref)
        local u23 = ReplicatedStorage.Resources.Legacy.nagi.charge:Clone();
        u23.Weld.Part0 = u21;
        u23.Parent = u20;
        task.delay(0.35, function() -- Line: 241
            -- upvalues: ReplicatedStorage (ref), Lighting (ref), TweenService (ref), mainreplication (ref), u21 (ref), u23 (copy)
            local v24 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v24.Parent = Lighting;
            v24.Brightness = 0.1;
            TweenService:Create(v24, TweenInfo.new(1.5), {
                Brightness = 0
            }):Play();
            task.delay(1.5, v24.Destroy, v24);
            mainreplication.Emit(u21, ReplicatedStorage.Resources.Legacy.nagi.normalkick, 3, CFrame.new(0, 0.85, -2.2));
            u23:Destroy();
        end);
    end);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = u21;
    BodyPosition.Position = u21.Position;
    task.wait(1.0499999523162842);
    BodyPosition:Destroy();
    v22:Destroy();
    mainreplication.sceneEnabled(false);
end;

function v1.legacyfakevolley(p25) -- Line: 275
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Players (copy)
    local v26 = p25.HumanoidRootPart or p25.PrimaryPart;
    local _ = p25.Torso;
    local u27 = ReplicatedStorage.Resources.armdrip:Clone();
    u27.Parent = p25;
    u27.Weld.Part0 = p25["Right Leg"];
    task.delay(0.5, function() -- Line: 286
        -- upvalues: u27 (copy)
        for _, descendant in ipairs(u27:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, u27.Destroy, u27);
    end);
    task.wait(0.5);
    mainreplication.raycastEffect(v26, ReplicatedStorage.Resources.Legacy.nagi.jumpsmoke, 3);

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(p25) then
        return;
    end;

    mainreplication.Emit(v26, ReplicatedStorage.Resources.headball, 3, CFrame.new(0, 0, -2));
    mainreplication.cameraShake(15, 0.7, 4);
    mainreplication.fov(false, 90);
    mainreplication.fov(true, 70, 1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.legacyamnagi(p28) -- Line: 307
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), mainreplication (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Color (copy), Density (copy)
    local v29 = p28.HumanoidRootPart or p28.PrimaryPart;
    local _ = p28.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local v30 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v30.Parent = Lighting;
    v30.Brightness = -1;
    TweenService:Create(v30, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v30.Destroy, v30);
    mainreplication.sceneEnabled(true);
    local u31 = ReplicatedStorage.Resources.Legacy.nagi.anagiEffects:Clone();
    u31:PivotTo(v29.CFrame);
    u31.Parent = p28;
    local v32 = ReplicatedStorage.Resources.darkscreen:Clone();
    v32.Parent = PlayerGui;
    soundUtil:play(ReplicatedStorage.Resources.Legacy.nagi.nagiyahoo, SoundService);
    mainreplication.cutscene(v29, CFrame.new(Vector3.new(0, 0, 0)), 14.816666603088379, ReplicatedStorage.Resources.Legacy.nagi["3FOV"]);
    task.delay(3.083333333333333, function() -- Line: 336
        -- upvalues: u31 (copy)
        for _, descendant in ipairs(u31.jump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u33 = nil;
    local u34 = nil;
    local u35 = nil;
    task.delay(3.8, function() -- Line: 347
        -- upvalues: u33 (ref), ReplicatedStorage (ref), Lighting (ref), u34 (ref), u35 (ref), Atmosphere (copy)
        u33 = ReplicatedStorage.Resources.DepthOfField:Clone();
        u33.Parent = Lighting;
        u33.FarIntensity = 1;
        u34 = Instance.new("ColorCorrectionEffect");
        u34.TintColor = Color3.fromRGB(223, 226, 255);
        u34.Saturation = -0.3;
        u34.Parent = Lighting;
        u35 = ReplicatedStorage.Resources.Bloom:Clone();
        u35.Parent = Lighting;
        u35.Threshold = 0.5;
        Atmosphere.Color = Color3.fromRGB(187, 179, 255);
        Atmosphere.Density = 0.34;
    end);
    task.delay(4.5, function() -- Line: 369
        -- upvalues: u31 (copy)
        for _, descendant in ipairs(u31.line:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.783333333333333, function() -- Line: 376
        -- upvalues: u31 (copy), u34 (ref), u35 (ref)
        u31.line:Destroy();

        for _, descendant in ipairs(u31.wind:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u34.TintColor = Color3.fromRGB(207, 230, 255);
        u34.Contrast = 0.5;
        u34.Saturation = -0.5;
        u35.Threshold = 1.25;
    end);
    task.delay(8.166666666666668, function() -- Line: 391
        -- upvalues: u31 (copy)
        u31.wind:Destroy();

        for _, descendant in ipairs(u31.aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.1, function() -- Line: 400
        -- upvalues: u31 (copy), Atmosphere (copy), Color (ref), Density (ref), u34 (ref), u35 (ref), TweenService (ref)
        for _, descendant in ipairs(u31.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u31.line2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        Atmosphere.Color = Color;
        Atmosphere.Density = Density;
        u34.TintColor = Color3.fromRGB(255, 255, 255);
        u34.Contrast = -5;
        u34.Saturation = 0;
        u35.Threshold = 0.85;
        task.wait(0.03);
        u34.Contrast = 5;
        task.wait(0.04);
        u34.Contrast = -1;
        TweenService:Create(u34, TweenInfo.new(0.25), {
            Contrast = 0
        }):Play();
    end);
    task.wait(14.816666603088379);
    u34:Destroy();
    v32:Destroy();
    u35:Destroy();
    u33:Destroy();
    mainreplication.sceneEnabled(false);
    u31:Destroy();
    local v36 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v36.Parent = Lighting;
    v36.Brightness = 1;
    task.wait(0.2);
    TweenService:Create(v36, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(0.4, v36.Destroy, v36);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.legacynagicontrolawk(p37) -- Line: 463
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), TweenService (copy), PlayerGui (copy), mainreplication (copy), soundUtil (copy), SoundService (copy)
    local v38 = p37.HumanoidRootPart or p37.PrimaryPart;
    local _ = p37.Torso;
    local _ = Lighting.Atmosphere;
    local v39 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v39.Parent = Lighting;
    v39.Brightness = -1;
    TweenService:Create(v39, TweenInfo.new(0.15), {
        Brightness = 0
    }):Play();
    task.delay(0.15, v39.Destroy, v39);
    local u40 = ReplicatedStorage.Resources.Legacy.nagi.goalEffects:Clone();
    u40:PivotTo(v38.CFrame);
    u40.Parent = p37;
    local v41 = ReplicatedStorage.Resources.darkscreen:Clone();
    v41.Parent = PlayerGui;
    mainreplication.sceneEnabled(true);
    task.delay(5.3, function() -- Line: 484
        -- upvalues: u40 (copy)
        for _, descendant in ipairs(u40.hit3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local v42 = ReplicatedStorage.Resources.DepthOfField:Clone();
    v42.Parent = Lighting;
    v42.FarIntensity = 0;
    TweenService:Create(v42, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.nagi.blocked_1, SoundService);
    mainreplication.cutscene(v38, CFrame.new(Vector3.new(0, 0, 0)), 6.033333333333333, ReplicatedStorage.Resources.Legacy.nagi["4FOV"]);
    task.wait(6.033333333333333);
    u40:Destroy();
    v42:Destroy();
    v41:Destroy();
    local v43 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v43.Parent = Lighting;
    v43.Brightness = 1;
    task.wait(0.2);
    TweenService:Create(v43, TweenInfo.new(0.4), {
        Brightness = 0
    }):Play();
    task.delay(0.4, v43.Destroy, v43);
    mainreplication.sceneEnabled(false);
    mainreplication.fov(false, 15);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

return v1;
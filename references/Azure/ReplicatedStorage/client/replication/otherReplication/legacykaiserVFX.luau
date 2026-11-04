 

 

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
local ClockTime = Lighting.ClockTime;
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

function v1.legacykaiserrunDash(p2) -- Line: 48
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Players (copy)
    local v3 = p2.HumanoidRootPart or p2.PrimaryPart;
    p2:FindFirstChildOfClass("Humanoid");
    mainreplication.characterImage({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.03,
        Count = 16,
        Whitelist = { p2 },
        Color = Color3.fromRGB(1000, 1000, 1000),
        Color2 = Color3.fromRGB(79, 126, 255)
    });
    mainreplication.rockFlakes(v3, 1.1);
    local v4 = ReplicatedStorage.Resources.kaiser.A:Clone();
    v4.Weld.Part0 = v3;
    v4.Parent = p2;
    local v5 = ReplicatedStorage.Resources.kaiser.roott:Clone();
    v5.Weld.Part0 = p2["Right Arm"];
    v5.Parent = p2;
    local v6 = ReplicatedStorage.Resources.kaiser.roott:Clone();
    v6.Weld.Part0 = p2["Left Arm"];
    v6.Parent = p2;
    mainreplication.bodyVelocity(v3, 250, 1.1, nil, nil, nil, TweenInfo.new(2.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p2) then
        mainreplication.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
        mainreplication.fov(false, 55);
        mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    mainreplication.cameraShake(15, 1.3, 6);
    mainreplication.Emit(v3, ReplicatedStorage.Resources.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    task.wait(0.45);

    for _, descendant in ipairs(v4:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v4.Destroy, v4);

    for _, descendant in ipairs(v5:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v5.Destroy, v5);

    for _, descendant in ipairs(v6:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v6.Destroy, v6);
end;

function v1.legacykaiserdribble(p7) -- Line: 105
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy), Players (copy), RunService (copy)
    local u8 = p7.HumanoidRootPart or p7.PrimaryPart;
    mainreplication.highlight(p7, Color3.fromRGB(79, 102, 255), 0.2666666666666667);
    task.wait(0.2666666666666667);
    mainreplication.characterImage({
        ImageTransparency = 0.7,
        Speed = 0.3,
        CFrames = true,
        Brightness = 1,
        countSpeed = 0.03,
        Count = 16,
        Whitelist = { p7 },
        Color = Color3.fromRGB(1000, 1000, 1000),
        Color2 = Color3.fromRGB(79, 126, 255)
    });
    mainreplication.rockFlakes(u8, 0.5);
    local v9 = ReplicatedStorage.Resources.Legacy.kaiser.A:Clone();
    v9.Weld.Part0 = u8;
    v9.Parent = p7;
    local v10 = ReplicatedStorage.Resources.Legacy.kaiser.roott:Clone();
    v10.Weld.Part0 = p7["Right Arm"];
    v10.Parent = p7;
    local v11 = ReplicatedStorage.Resources.Legacy.kaiser.roott:Clone();
    v11.Weld.Part0 = p7["Left Arm"];
    v11.Parent = p7;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p7) then
        mainreplication.bright(0.15, 1.5, Color3.fromRGB(111, 106, 255));
        mainreplication.fov(false, 55);
        mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    mainreplication.cameraShake(15, 1.3, 3);
    mainreplication.Emit(u8, ReplicatedStorage.Resources.Legacy.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    local u12, u13 = mainreplication.bodyVelocity(u8, 100, 0.5, nil, nil, true);
    local u14 = nil;
    u14 = RunService.RenderStepped:Connect(function(p15) -- Line: 147
        -- upvalues: u12 (copy), u14 (ref), u8 (copy), u13 (copy)
        if u12 and u12:IsDescendantOf(game) then
            u12.Velocity = u8.CFrame.LookVector * u13.Value + -u8.CFrame.RightVector * u13.Value / 2;

            return;
        end;

        u14:Disconnect();
    end);
    task.wait(0.3);
    mainreplication.rockFlakes(u8, 0.5);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p7) then
        mainreplication.fov(false, 85);
        mainreplication.fov(true, 70, 1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    mainreplication.Emit(u8, ReplicatedStorage.Resources.Legacy.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    mainreplication.cameraShake(15, 0.55, 6);
    local u16, u17 = mainreplication.bodyVelocity(u8, 150, 0.5, nil, nil, true);
    local u18 = nil;
    u18 = RunService.RenderStepped:Connect(function(p19) -- Line: 175
        -- upvalues: u16 (copy), u18 (ref), u8 (copy), u17 (copy)
        if u16 and u16:IsDescendantOf(game) then
            u16.Velocity = u8.CFrame.LookVector * u17.Value + u8.CFrame.RightVector * u17.Value / 2;

            return;
        end;

        u18:Disconnect();
    end);
    task.wait(0.3);

    for _, descendant in ipairs(v9:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v9.Destroy, v9);

    for _, descendant in ipairs(v10:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v10.Destroy, v10);

    for _, descendant in ipairs(v11:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    task.delay(3, v11.Destroy, v11);
end;

function v1.legacykaiserAwk(u20) -- Line: 213
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Density (copy), Color (copy), Brightness (copy)
    local v21 = u20.HumanoidRootPart or u20.PrimaryPart;
    local _ = u20.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.bright(-1, 1);
    mainreplication.sceneEnabled(true);
    local u22 = ReplicatedStorage.Resources.Legacy.kaiser.ultEff:Clone();
    u22:PivotTo(v21.CFrame);
    u22.Parent = u20;
    local u23 = ReplicatedStorage.Resources.Legacy.kaiser.rose:Clone();
    u23.rose.Part0 = u20["Right Arm"];
    u23.Parent = u22;
    local u24 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u24.Parent = Lighting;
    u24.FarIntensity = 0;
    TweenService:Create(u24, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 255, 255);
    ColorCorrectionEffect.Parent = Lighting;
    soundUtil:play(ReplicatedStorage.Resources.Legacy.kaiser.alkaiserawake_1, SoundService);
    mainreplication.cutsceneBlender(v21, ReplicatedStorage.Resources.Legacy.kaiser.flowAnim2, ReplicatedStorage.Resources.Legacy.kaiser.FOV2);

    for _, descendant in pairs(u22.Rose:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.TimeScale = 1;
        end;
    end;

    for _, descendant in pairs(u22.Aura:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.4666666666666667, function() -- Line: 256
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.AMM1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.183333333333333, function() -- Line: 264
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.AMM2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.083333333333333, function() -- Line: 272
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.AMM3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.983333333333333, function() -- Line: 280
        -- upvalues: mainreplication (ref), u20 (copy), ReplicatedStorage (ref)
        mainreplication.Emit(u20.Head, ReplicatedStorage.Resources.Legacy.kaiser.XD, 3);
    end);
    task.delay(4.383333333333333, function() -- Line: 284
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.JA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.033333333333333, function() -- Line: 292
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.Aura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.783333333333333, function() -- Line: 300
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.JA:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.85, function() -- Line: 308
        -- upvalues: u22 (copy)
        for _, descendant in ipairs(u22.JA2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.85, function() -- Line: 316
        -- upvalues: u22 (copy), u23 (copy)
        for _, descendant in ipairs(u22.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u23.Transparency = 1;
    end);
    task.delay(6.183333333333333, function() -- Line: 325
        -- upvalues: u22 (copy), TweenService (ref)
        for _, descendant in pairs(u22.Rose:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.9;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;
    end);
    task.delay(5.766666666666667, function() -- Line: 336
        -- upvalues: mainreplication (ref), ReplicatedStorage (ref)
        mainreplication.impactFrame(ReplicatedStorage.Resources.Legacy.kaiser.ImpactFrame4);
    end);
    task.delay(7.6, function() -- Line: 340
        -- upvalues: mainreplication (ref), u24 (copy), u22 (copy), ColorCorrectionEffect (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref)
        mainreplication.blackscene(0.5833333333333333);
        u24:Destroy();
        u22:Destroy();
        ColorCorrectionEffect:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 15);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function v1.legacykaisercounter(u25) -- Line: 361
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), TweenService (copy), soundUtil (copy), SoundService (copy), PlayerGui (copy), ClockTime (copy), RunService (copy), Density (copy), Color (copy), Brightness (copy)
    local Ball = u25:FindFirstChild("Ball");
    local v26 = u25.HumanoidRootPart or u25.PrimaryPart;
    local _ = u25.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.bright(1, 1.5);
    mainreplication.sceneEnabled(true);
    mainreplication.cutsceneLeftright(v26, ReplicatedStorage.Resources.Legacy.kaiser.skill1counter3, ReplicatedStorage.Resources.Legacy.kaiser.FOV);
    local u27 = ReplicatedStorage.Resources.Legacy.kaiser.ColorCorrection:Clone();
    u27.Parent = Lighting;
    local u28 = ReplicatedStorage.Resources.Legacy.kaiser.couallEff:Clone();
    u28:PivotTo(v26.CFrame);
    u28.Parent = u25;
    local u29 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u29.Parent = Lighting;
    u29.FarIntensity = 0;
    TweenService:Create(u29, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.kaiser.kaiser, SoundService);
    local u30 = {};

    for _, child in ipairs(u25:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v31 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.Legacy.kaiser.auraya:GetChildren()) do
                local v32 = child2:Clone();
                v32.Enabled = true;
                v32.Parent = v31;
                table.insert(u30, v32);
            end;
        end;
    end;

    local function spawnmisspoint() -- Line: 405
        -- upvalues: ReplicatedStorage (ref), u28 (copy)
        local v33 = ReplicatedStorage.Resources.Legacy.kaiser.Point:Clone();
        v33.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(Random.new():NextInteger(-5, 5), Random.new():NextInteger(0, 5), Random.new():NextInteger(-11, -7));
        v33.Parent = u28;

        for _, descendant in pairs(v33.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 413
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v33.misspoint:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 421
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v33.MISS:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 429
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        task.delay(3, v33.Destroy, v33);
    end;

    task.delay(5.166666666666667, spawnmisspoint);
    task.delay(5.55, spawnmisspoint);
    task.delay(5.8, spawnmisspoint);
    task.delay(5.966666666666667, spawnmisspoint);
    task.delay(6.083333333333333, spawnmisspoint);
    task.delay(6.183333333333333, spawnmisspoint);
    task.delay(6.266666666666667, spawnmisspoint);
    task.delay(6.35, spawnmisspoint);
    task.delay(6.433333333333333, spawnmisspoint);
    task.delay(6.516666666666667, spawnmisspoint);
    task.delay(6.6, spawnmisspoint);
    task.delay(6.65, spawnmisspoint);
    task.delay(6.783333333333333, spawnmisspoint);
    task.delay(7, function() -- Line: 452
        -- upvalues: ReplicatedStorage (ref), u28 (copy)
        local v34 = ReplicatedStorage.Resources.Legacy.kaiser.Point:Clone();
        v34.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -7);
        v34.Parent = u28;

        for _, descendant in pairs(v34.emit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 460
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v34.goalpoint:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 468
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(v34.GOAL:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 476
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        task.delay(3, v34.Destroy, v34);
    end);
    local u35 = nil;
    task.delay(4.766666666666667, function() -- Line: 487
        -- upvalues: Ball (copy), u35 (ref), ReplicatedStorage (ref), u28 (copy)
        if not Ball then
            return;
        end;

        u35 = ReplicatedStorage.Resources.Legacy.kaiser.Ball:Clone();
        u35.Weld.Part0 = Ball;
        u35.Parent = u28;

        for _, descendant in pairs(u35.ballseeingaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.983333333333333, function() -- Line: 503
        -- upvalues: u35 (ref)
        if not u35 then
            return;
        end;

        for _, descendant in pairs(u35.ballseeingaura:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u35.ballaimed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 516
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(7.733333333333333, function() -- Line: 523
        -- upvalues: u35 (ref)
        if not u35 then
            return;
        end;

        for _, descendant in pairs(u35.ballaimed:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 529
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in pairs(u35.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 538
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(9.233333333333333, function() -- Line: 545
        -- upvalues: u35 (ref)
        if not u35 then
            return;
        end;

        for _, descendant in ipairs(u35.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;

        for _, descendant in ipairs(u35.ballglare:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.98333333333333, function() -- Line: 561
        -- upvalues: u35 (ref)
        if not u35 then
            return;
        end;

        for _, descendant in ipairs(u35.ballauranormal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(0.85, function() -- Line: 573
        -- upvalues: mainreplication (ref), ReplicatedStorage (ref)
        mainreplication.impactFrame(ReplicatedStorage.Resources.Legacy.kaiser.ImpactFrame1);
    end);
    task.delay(10.16666666666667, function() -- Line: 577
        -- upvalues: mainreplication (ref), ReplicatedStorage (ref)
        mainreplication.impactFrame(ReplicatedStorage.Resources.Legacy.kaiser.ImpactFrame2);
    end);
    task.delay(11.6, function() -- Line: 581
        -- upvalues: mainreplication (ref), ReplicatedStorage (ref)
        mainreplication.impactFrame(ReplicatedStorage.Resources.Legacy.kaiser.ImpactFrame3);
    end);
    task.delay(0.85, function() -- Line: 587
        -- upvalues: u30 (copy), u28 (copy)
        for _, v in u30 do
            v.Enabled = false;
        end;

        for _, descendant in ipairs(u28.kaiserimpactslam1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.733333333333333, function() -- Line: 600
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaiserimpactslam2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    local u36 = nil;
    task.delay(3.75, function() -- Line: 610
        -- upvalues: u30 (copy), u36 (ref), ReplicatedStorage (ref), u25 (copy), u28 (copy)
        for _, v in u30 do
            v.Enabled = true;
        end;

        u36 = ReplicatedStorage.Resources.Legacy.kaiser.eyeflash:Clone();
        u36.Weld.Part0 = u25.Head;
        u36.Parent = u28;

        for _, descendant in pairs(u36.eyeflash:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 622
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    local u37 = nil;
    task.delay(4.716666666666667, function() -- Line: 633
        -- upvalues: Lighting (ref), u37 (ref), ReplicatedStorage (ref), PlayerGui (ref), TweenService (ref), ClockTime (ref)
        Lighting.ClockTime = 24;
        u37 = ReplicatedStorage.Resources.Legacy.kaiser.glowscreen:Clone();
        u37.Parent = PlayerGui;
        task.wait(2.283333333333333);
        TweenService:Create(Lighting, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            ClockTime = ClockTime
        }):Play();
    end);
    task.delay(4.416666666666667, function() -- Line: 644
        -- upvalues: u36 (ref)
        if not u36 then
            return;
        end;

        for _, descendant in pairs(u36.impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 650
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(4.616666666666667, function() -- Line: 657
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaiserimpactsurroundingstuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.633333333333333, function() -- Line: 665
        -- upvalues: u36 (ref)
        if not u36 then
            return;
        end;

        for _, descendant in pairs(u36.explosion:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 671
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(4.733333333333333, function() -- Line: 678
        -- upvalues: ReplicatedStorage (ref), u25 (copy), RunService (ref)
        local u38 = ReplicatedStorage.Resources.Legacy.kaiser.CamEffect:Clone();
        u38.CFrame = workspace.CurrentCamera.CFrame;
        u38.Parent = u25;

        for _, descendant in ipairs(u38:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v39 = RunService.PreRender:connect(function() -- Line: 689
            -- upvalues: u38 (copy)
            u38.CFrame = workspace.CurrentCamera.CFrame;
        end);
        task.delay(3, v39.Disconnect, v39);
        task.delay(3, u38.Destroy, u38);
    end);
    task.delay(4.75, function() -- Line: 697
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaisergrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.5, function() -- Line: 705
        -- upvalues: ReplicatedStorage (ref), u25 (copy), RunService (ref)
        local u40 = ReplicatedStorage.Resources.Legacy.kaiser.CamEffect:Clone();
        u40.CFrame = workspace.CurrentCamera.CFrame;
        u40.Parent = u25;
        local v41 = RunService.PreRender:connect(function() -- Line: 710
            -- upvalues: u40 (copy)
            u40.CFrame = workspace.CurrentCamera.CFrame;
        end);

        for _, descendant in ipairs(u40:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.2333333333333333, u40.Destroy, u40);
        task.delay(0.2333333333333333, v41.Disconnect, v41);
    end);
    task.delay(8, function() -- Line: 723
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.116666666666667, function() -- Line: 731
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaiserimpactsurroundingstuff1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.133333333333333, function() -- Line: 739
        -- upvalues: ReplicatedStorage (ref), u25 (copy)
        local v42 = ReplicatedStorage.Resources.Legacy.kaiser.trail:Clone();
        v42.Weld.Part0 = u25["Right Arm"];
        v42.Parent = u25;
        local v43 = ReplicatedStorage.Resources.Legacy.kaiser.trail:Clone();
        v43.Weld.Part0 = u25["Left Arm"];
        v43.Parent = u25;
        local v44 = ReplicatedStorage.Resources.Legacy.kaiser.trail:Clone();
        v44.Weld.Part0 = u25["Right Leg"];
        v44.Parent = u25;
        local v45 = ReplicatedStorage.Resources.Legacy.kaiser.trail:Clone();
        v45.Weld.Part0 = u25["Left Leg"];
        v45.Parent = u25;
        task.delay(0.8, v42.Destroy, v42);
        task.delay(0.8, v43.Destroy, v43);
        task.delay(0.8, v44.Destroy, v44);
        task.delay(0.8, v45.Destroy, v45);
    end);
    task.delay(9.233333333333333, function() -- Line: 762
        -- upvalues: u30 (copy), u28 (copy)
        for _, v in u30 do
            v.TimeScale = 0.1;
        end;

        for _, descendant in ipairs(u28.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.05;
            end;
        end;
    end);
    task.delay(9.283333333333333, function() -- Line: 774
        -- upvalues: u28 (copy)
        for _, descendant in pairs(u28.kaiserimpactsurroundingstuff.Part.Stars:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u28.kaiserimpactsurroundingstuff.Part.Ground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end);
    task.delay(9.266666666666667, function() -- Line: 790
        -- upvalues: u28 (copy)
        for _, descendant in ipairs(u28.kaisergrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(10.98333333333333, function() -- Line: 798
        -- upvalues: u30 (copy), u28 (copy)
        for _, v in u30 do
            v.TimeScale = 1;
        end;

        for _, descendant in pairs(u28.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(11.58333333333333, function() -- Line: 811
        -- upvalues: u28 (copy)
        for _, descendant in pairs(u28.kaiserimpactlegflashpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 815
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(12.26666666666667, function() -- Line: 822
        -- upvalues: u37 (ref), u30 (copy), u28 (copy)
        if u37 then
            u37:Destroy();
        end;

        for _, v in u30 do
            v:Destroy();
        end;

        table.clear(u30);

        for _, descendant in pairs(u28.kaiserimpactlegflashpart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 835
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in pairs(u28.kaiserimpactsurroundingstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 844
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(12.31666666666667, function() -- Line: 851
        -- upvalues: u35 (ref), u28 (copy)
        if u35 then
            u35:Destroy();
        end;

        for _, descendant in pairs(u28.kaiserimpactkick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.16666666666667, function() -- Line: 864
        -- upvalues: u29 (copy), u28 (copy), u27 (copy), Atmosphere (copy), Density (ref), Color (ref), Lighting (ref), Brightness (ref), mainreplication (ref), u37 (ref), u30 (copy)
        u29:Destroy();
        u28:Destroy();
        u27:Destroy();
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0);
        Lighting.Brightness = Brightness;
        mainreplication.ultFlash();
        mainreplication.sceneEnabled(false);
        mainreplication.fov(false, 100);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);

        if u37 then
            u37:Destroy();
        end;

        for _, v in u30 do
            v:Destroy();
        end;

        table.clear(u30);
    end);
end;

function v1.legacykaiserImpact(u46) -- Line: 895
    -- upvalues: ReplicatedStorage (copy), TweenService (copy), mainreplication (copy)
    local u47 = u46.HumanoidRootPart or u46.PrimaryPart;
    local Ball = u46:FindFirstChild("Ball");
    local u48 = ReplicatedStorage.Resources.Legacy.kaiser.kieff:Clone();
    u48:PivotTo(u47.CFrame);
    u48.Parent = u46;
    task.delay(1.983333333333333, u48.Destroy, u48);

    for _, descendant in ipairs(u48:GetDescendants()) do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        end;
    end;

    task.spawn(function() -- Line: 917
        -- upvalues: u48 (copy), u47 (copy)
        while true do
            u48:PivotTo(u47.CFrame);
            task.wait();
        end;
    end);
    task.delay(0.2333333333333333, function() -- Line: 926
        -- upvalues: u48 (copy), TweenService (ref)
        for i = 1, 4 do
            local v49 = u48.Wind1:Clone();
            v49.Size = Vector3.new(4.996, 11.287, 11.663);
            v49.Transparency = 0.85;
            v49.Parent = workspace.Effects;
            TweenService:Create(v49, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = Vector3.new(12.96, 24.999, 24.999),
                CFrame = v49.CFrame * CFrame.new(16, 0, 0) * CFrame.Angles(5, 0, 0)
            }):Play();
            task.delay(0.3, v49.Destroy, v49);
            task.wait(0.15);
            local _ = i;
        end;
    end);
    task.delay(0.1666666666666667, function() -- Line: 940
        -- upvalues: mainreplication (ref), u48 (copy)
        mainreplication.cameraShake(15, 0.65, 4);

        for _, descendant in ipairs(u48.Jump:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.2333333333333333, function() -- Line: 950
        -- upvalues: u48 (copy)
        for _, descendant in ipairs(u48.A:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.2666666666666667, function() -- Line: 958
        -- upvalues: ReplicatedStorage (ref), u46 (copy)
        local v50 = ReplicatedStorage.Resources.Legacy.kaiser.ADA:Clone();
        v50.Weld.Part0 = u46["Right Leg"];
        v50.Parent = u46;

        for _, descendant in ipairs(v50:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v50.Destroy, v50);
    end);
    task.delay(0.35, function() -- Line: 971
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u46 (copy)
        if not Ball then
            return;
        end;

        local v51 = ReplicatedStorage.Resources.Legacy.kaiser.Charge:Clone();
        v51.Weld.Part0 = Ball;
        v51.Parent = u46;

        for _, descendant in ipairs(v51:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v51.Destroy, v51);
    end);
    task.delay(0.3833333333333333, function() -- Line: 986
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u46 (copy)
        if not Ball then
            return;
        end;

        local v52 = ReplicatedStorage.Resources.Legacy.kaiser.Charge2:Clone();
        v52.Weld.Part0 = Ball;
        v52.Parent = u46;
        task.delay(0.2333333333333334, v52.Destroy, v52);

        for _, descendant in ipairs(v52:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    mainreplication.fov(true, 120, 0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    task.delay(0.6166666666666667, function() -- Line: 1003
        -- upvalues: mainreplication (ref), u48 (copy), TweenService (ref)
        mainreplication.fov(false, 70);
        mainreplication.cameraShake(15, 1.35, 8);

        for _, descendant in ipairs(u48.Impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v53 = u48.BRO:Clone();
        v53.Size = Vector3.new(24.622, 10.168, 10.474);
        v53.Mesh.Scale = Vector3.new(1.077, 0.338, 0.336);

        for _, descendant in ipairs(v53:GetDescendants()) do
            if descendant:IsA("Decal") then
                descendant.Transparency = 0;
            end;
        end;

        v53.Parent = workspace.Effects;
        TweenService:Create(v53, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(52.739, 0.001, 0.001),
            CFrame = v53.CFrame * CFrame.new(-8, 0, 0)
        }):Play();
        TweenService:Create(v53.Mesh, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(2.307, 0, 0)
        }):Play();
        task.delay(0.0333333333333333, v53.Destroy, v53);
    end);
    task.delay(0.4666666666666667, function() -- Line: 1030
        -- upvalues: u48 (copy), TweenService (ref)
        local v54 = u48.MeshPart:Clone();
        v54.Size = Vector3.new(8, 1.382, 8);
        v54.Transparency = 0;
        v54.Parent = workspace.Effects;
        TweenService:Create(v54, TweenInfo.new(0.1166666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(19.999, 1.382, 19.999),
            CFrame = v54.CFrame * CFrame.new(0, -11, 0)
        }):Play();
        task.delay(0.1166666666666666, v54.Destroy, v54);
        task.wait(0.015);
        local v55 = u48.MeshPart2:Clone();
        v55.Size = Vector3.new(5, 1.382, 5);
        v55.Transparency = 0;
        v55.Parent = workspace.Effects;
        TweenService:Create(v55, TweenInfo.new(0.1016666666666666, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(14, 1.382, 14),
            CFrame = v55.CFrame * CFrame.new(0, -9, 0)
        }):Play();
        task.delay(0.1016666666666666, v55.Destroy, v55);
    end);
    task.delay(0.6, function() -- Line: 1054
        -- upvalues: u48 (copy), TweenService (ref)
        local v56 = u48.First:Clone();
        v56.Size = Vector3.new(24.622, 19.953, 19.969);
        v56.Mesh.Scale = Vector3.new(1.077, 0.663, 0.641);
        v56.Decal.Transparency = 0.4;
        v56.Parent = workspace.Effects;
        TweenService:Create(v56, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(48.149, 12.068, 9.594),
            CFrame = v56.CFrame * CFrame.new(-11, 0, 0)
        }):Play();
        TweenService:Create(v56.Mesh, TweenInfo.new(0.0333333333333333, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(1.503, 0.571, 0.518)
        }):Play();
        task.delay(0.0333333333333333, v56.Destroy, v56);
    end);
    task.delay(0.6333333333333333, function() -- Line: 1067
        -- upvalues: u48 (copy), TweenService (ref)
        local v57 = u48.Haze:Clone();
        v57.Size = Vector3.new(13.115, 17.07, 13.602);
        v57.Mesh.Scale = Vector3.new(-0.052, -0.085, -0.054);
        v57.Decal.Transparency = 0.8;
        v57.Parent = workspace.Effects;
        TweenService:Create(v57, TweenInfo.new(0.6666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = Vector3.new(22.987, 28.914, 21.857),
            CFrame = v57.CFrame * CFrame.new(0, -11, 0) * CFrame.Angles(0, -5, 0)
        }):Play();
        TweenService:Create(v57.Mesh, TweenInfo.new(0.6666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = Vector3.new(-0.092, -0.145, -0.087)
        }):Play();
        TweenService:Create(v57.Decal, TweenInfo.new(0.6666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        task.delay(0.6666666666666667, v57.Destroy, v57);
        local v58 = u48.End:Clone();
        v58.Size = Vector3.new(27.739, 7.389, 26.128);
        v58.Transparency = 0;
        v58.Parent = workspace.Effects;
        TweenService:Create(v58, TweenInfo.new(0.6666666666666667, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(18.992, 6.23, 20.161),
            Color = Color3.fromRGB(13, 105, 172),
            CFrame = v58.CFrame * CFrame.new(0, 15, 0) * CFrame.Angles(0, 5, 0)
        }):Play();
        task.delay(0.6666666666666667, v58.Destroy, v58);
    end);
end;

function v1.legacykaiserImpactmagnus(u59) -- Line: 1091
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy)
    local u60 = u59.HumanoidRootPart or u59.PrimaryPart;
    local Ball = u59:FindFirstChild("Ball");
    mainreplication.fov(true, 120, 0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
    mainreplication.cameraShake(15, 1.35, 3);
    task.delay(0.1333333333333333, function() -- Line: 1098
        -- upvalues: Ball (copy), ReplicatedStorage (ref), u59 (copy), mainreplication (ref), u60 (copy)
        if not Ball then
            return;
        end;

        local v61 = ReplicatedStorage.Resources.Legacy.kaiser.XDD:Clone();
        v61.ball.Part0 = Ball;
        v61.Parent = u59;

        for _, descendant in ipairs(v61:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v61.Destroy, v61);
        mainreplication.Emit(u60, ReplicatedStorage.Resources.Legacy.kaiser.Jump, 3, CFrame.new(0, -3, 0));
    end);
    task.delay(0.4333333333333333, function() -- Line: 1115
        -- upvalues: mainreplication (ref), u60 (copy), ReplicatedStorage (ref)
        mainreplication.fov(false, 70);
        mainreplication.cameraShake(15, 1.35, 8);
        mainreplication.Emit(u60, ReplicatedStorage.Resources.Legacy.kaiser.IMPACTA, 3, CFrame.new(0, -2, -3));
    end);
end;

function v1.legacykaiserImpactLightningStrike(p62, p63) -- Line: 1124
    -- upvalues: Lighting (copy), mainreplication (copy), ReplicatedStorage (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy), soundUtil (copy), SoundService (copy), Brightness (copy), Density (copy), Color (copy)
    local v64 = p62.HumanoidRootPart or p62.PrimaryPart;
    local _ = p62.Torso;
    local Atmosphere = Lighting.Atmosphere;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(-1);
    local u65 = ReplicatedStorage.Resources.Legacy.kaiser.lseff:Clone();
    u65:PivotTo(v64.CFrame);
    u65.Parent = p62;
    local u66 = ReplicatedStorage.Resources.Legacy.kaiser.eyeki:Clone();
    u66.Weld.Part0 = p62.Head;
    u66.Parent = u65;
    local u67 = {};

    for _, child in ipairs(p62:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v68 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.Legacy.kaiser.auraya:GetChildren()) do
                local v69 = child2:Clone();
                v69.Enabled = true;
                v69.Parent = v68;
                table.insert(u67, v69);
            end;
        end;
    end;

    task.delay(0.8, function() -- Line: 1168
        -- upvalues: ReplicatedStorage (ref), u65 (copy), RunService (ref), workspace_CurrentCamera (ref), TweenService (ref)
        local u70 = ReplicatedStorage.Resources.Legacy.kaiser.CAMERAPART:Clone();
        u70.Parent = u65;
        local u71 = nil;
        u71 = RunService.PreRender:connect(function() -- Line: 1173
            -- upvalues: u70 (copy), u71 (ref), workspace_CurrentCamera (ref)
            if not u70:IsDescendantOf(game) then
                u71:Disconnect();
            end;

            u70.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(0, 0, 0.3490658503988659);
        end);

        for _, descendant in ipairs(u65.KICKPARTICLES1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u65.End.Size = Vector3.new(10, 20, 20);
        u65.End.Transparency = 0;
        TweenService:Create(u65.End, TweenInfo.new(0.217), {
            Transparency = 1,
            Size = Vector3.new(13, 0, 0),
            CFrame = u65.End.CFrame * CFrame.Angles(10, 0, 0)
        }):Play();
        u65.EndBlue.Size = Vector3.new(3, 6, 6);
        u65.EndBlue.Transparency = 0.95;
        TweenService:Create(u65.EndBlue, TweenInfo.new(0.867), {
            Transparency = 1,
            Size = Vector3.new(14, 14, 14),
            CFrame = u65.EndBlue.CFrame * CFrame.Angles(10, 0, 0)
        }):Play();
    end);
    task.delay(0.367, function() -- Line: 1198
        -- upvalues: u66 (copy)
        for _, descendant in ipairs(u66:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.817, function() -- Line: 1206
        -- upvalues: u67 (copy)
        for _, v in u67 do
            v.Enabled = false;
            task.delay(3, v.Destroy, v);
        end;

        table.clear(u67);
    end);
    local u72 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u72.Parent = Lighting;
    u72.FarIntensity = 0;
    TweenService:Create(u72, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    soundUtil:play(ReplicatedStorage.Resources.Legacy.kaiser["lightning strike"], SoundService);
    mainreplication.cutsceneBlender(v64, ReplicatedStorage.Resources.Legacy.kaiser.skill52, ReplicatedStorage.Resources.Legacy.kaiser.FOV3);
    task.delay(1.667, function() -- Line: 1222
        -- upvalues: u72 (copy), mainreplication (ref), u65 (copy), Lighting (ref), Brightness (ref), Atmosphere (copy), Density (ref), Color (ref)
        u72:Destroy();
        mainreplication.ultFlash(1);
        mainreplication.sceneEnabled(false);
        u65:Destroy();
        Lighting.Brightness = Brightness;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        mainreplication.fov(false, 70);
    end);
end;

return v1;
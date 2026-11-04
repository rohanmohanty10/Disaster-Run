 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local v1 = {};
local u2 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Decay = Lighting.Atmosphere.Decay;
local _ = Lighting.Atmosphere.Haze;
local _ = Lighting.GeographicLatitude;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local _ = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local MeshEmitter = require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
require(ReplicatedStorage.util.KatUtil);
local UwUEffects = require(ReplicatedStorage.util.UwUEffects);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(ReplicatedStorage.client.replication.TekrinnDialogue);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local MoonCFrameTimeline = require(ReplicatedStorage.util.MoonCFrameTimeline);
local BackgroundHighlight = require(ReplicatedStorage.client.replication.BackgroundHighlight);
local TrajectoryPreview = require(ReplicatedStorage.util.TrajectoryPreview);
local trove = require(ReplicatedStorage.forum.trove);
local wiki = require(ReplicatedStorage.wiki);
local u3 = {};
local Color2 = workspace:WaitForChild("map"):WaitForChild("map"):WaitForChild("sanam"):WaitForChild("main").Color;

local function createData(u4: userdata, p5: any) -- Line: 66
    -- upvalues: u2 (copy)
    if not u2[u4] then
        u2[u4] = {};
        u4.AncestryChanged:Once(function() -- Line: 69
            -- upvalues: u2 (ref), u4 (copy)
            for _, v in u2[u4] do
                for _, v2 in v do
                    if typeof(v2) == "table" and v2.Destroy then
                        v2:Destroy();
                    end;
                end;
            end;

            table.clear(u2[u4]);
            u2[u4] = nil;
        end);
    end;

    if not u2[u4][p5] then
        u2[u4][p5] = {};
    end;

    return u2[u4][p5];
end;

local function emitall(p6) -- Line: 89
    if not p6 then
        return;
    end;

    for _, descendant in pairs(p6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
        end;
    end;
end;

local function enableall(p7, p8, p9) -- Line: 98
    for _, v in p7 do
        if not v then
            return;
        end;

        if v:IsA("ParticleEmitter") or v:IsA("Beam") then
            v.Enabled = true;
        end;

        local u10 = v;

        for _, descendant in pairs(v:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        if p9 then
            for _, descendant in pairs(u10:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 112
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        else
            task.delay(p8, function() -- Line: 118
                -- upvalues: u10 (copy)
                if not u10 then
                    return;
                end;

                if u10:IsA("ParticleEmitter") or u10:IsA("Beam") then
                    u10.Enabled = false;
                end;

                for _, descendant in pairs(u10:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;
    end;
end;

function v1.gyroShotTrail(p11) -- Line: 133
    -- upvalues: ReplicatedStorage (copy), Debris (copy), RunService (copy), MeshEmitter (copy)
    if not workspace.Terrain:FindFirstChild("Ball") then
        return;
    end;

    local CFBall = ReplicatedStorage:WaitForChild("CFBall");
    local Part = Instance.new("Part");
    Part.Parent = workspace.Effects;
    Part.Anchored = true;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Transparency = 1;
    Part.CanCollide = false;
    Debris:AddItem(Part, 5);
    local l_time = time;
    local u12 = l_time() + 0.514;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u18 = RunService.PreRender:connect(function(p16) -- Line: 162
        -- upvalues: CFBall (copy), u15 (ref), u14 (ref), Part (copy), l_time (ref), u12 (ref), u13 (ref), MeshEmitter (ref), ReplicatedStorage (ref)
        if not CFBall:IsDescendantOf(game) then
            return;
        end;

        if not CFBall:FindFirstChild("velocity") then
            return;
        end;

        local Value = CFBall.velocity.Value;
        u15 = CFBall.Value.Position;
        u14 = CFrame.lookAt(u15, u15 + Value);
        Part.CFrame = u14 * CFrame.Angles(1.5707963267948966, 0, 0);

        if l_time and u12 then
            local v17 = l_time();

            if u12 > v17 then
                return;
            end;

            u12 = v17 + 0.514;
        end;

        l_time = time;
        u12 = l_time() + 0.514;

        if Value.Magnitude >= 200 then
            u13 = MeshEmitter.StartMeshEmitter(Part, ReplicatedStorage.Resources.yukimiya["GyroTrail MeshEmitter"], nil, 0.517);
            u13.Parent = workspace.Effects;
        end;
    end);
    local u19 = nil;
    u19 = CFBall.AncestryChanged:Once(function() -- Line: 195
        -- upvalues: u18 (ref), u19 (ref)
        if u18 then
            u18:Disconnect();
        end;

        if u19 then
            u19:Disconnect();
        end;
    end);
    task.delay(2, u19.Disconnect, u19);
    task.delay(2, u18.Disconnect, u18);
end;

function v1.gyroShot(u20: any, p21: number) -- Line: 204
    -- upvalues: MeshEmitter (copy), ReplicatedStorage (copy), Debris (copy), Players (copy), mainreplication (copy), Lighting (copy), TweenService (copy)
    local u22 = p21 or 1;
    local u23 = MeshEmitter.StartMeshEmitter(u20.HumanoidRootPart or u20.PrimaryPart, ReplicatedStorage.Resources.yukimiya["gyro shot remake2 MeshEmitter"], nil, 5);
    u23.Parent = workspace.Effects;
    local beamwind = u23.beamwind;
    beamwind.Parent = u20.HumanoidRootPart;
    beamwind.Weld.Part0 = u20.HumanoidRootPart;
    Debris:AddItem(beamwind, 2);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u20) then
        mainreplication.fov(true, 120, 0.54 / u22, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        mainreplication.springcamerashake(15, 30);
    end;

    task.delay(0.15 / u22, function() -- Line: 225
        -- upvalues: beamwind (copy), u22 (copy)
        for _, descendant in ipairs(beamwind:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25 / u22), {
                    Width0 = 0,
                    Width1 = 5
                }):Play();
            end;
        end;
    end);
    task.delay(0.2833333333333333 / u22, function() -- Line: 232
        -- upvalues: u23 (copy)
        for _, descendant in pairs(u23.PRE:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.5333333333333333 / u22, function() -- Line: 240
        -- upvalues: u23 (copy)
        for _, descendant in pairs(u23.impact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.55 / u22, function() -- Line: 249
        -- upvalues: Players (ref), u20 (copy), mainreplication (ref), u22 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), beamwind (copy)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u20) then
            mainreplication.fov(false, 50);
            mainreplication.fov(true, 70, 2 / u22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(60, 55);
            local v24 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v24.Parent = Lighting;
            v24.TintColor = Color3.fromRGB(255, 115, 0);
            v24.Brightness = 0.4;
            v24.Contrast = 1;
            v24.Saturation = -0.4;
            TweenService:Create(v24, TweenInfo.new(1.5 / u22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v24, TweenInfo.new(2 / u22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2 / u22, v24.Destroy, v24);
        end;

        for _, descendant in ipairs(beamwind:GetDescendants()) do
            if descendant:IsA("Beam") then
                game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.25 / u22), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end);
end;

function v1.yukimiya3Start(u25, u26) -- Line: 276
    -- upvalues: UwUEffects (copy), ReplicatedStorage (copy), Debris (copy), mainreplication (copy), RunService (copy), Players (copy), Lighting (copy), TweenService (copy)
    local HumanoidRootPart = u25:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    UwUEffects.createEffect({
        Character = u25
    }, `YukiDribbleStart{u26 and "L" or "R"}`, nil);
    local u27 = ReplicatedStorage.Resources.yukimiya["Left Arm Trail"]:Clone();
    u27.Weld.Part0 = u25["Right Arm"];
    u27.Parent = u25;
    local u28 = ReplicatedStorage.Resources.yukimiya["Right Arm Trail"]:Clone();
    u28.Weld.Part0 = u25["Left Arm"];
    u28.Parent = u25;
    local u29 = ReplicatedStorage.Resources.yukimiya["Left Leg Trail"]:Clone();
    u29.Weld.Part0 = u25["Left Leg"];
    u29.Parent = u25;
    local u30 = ReplicatedStorage.Resources.yukimiya["Right Leg Trail"]:Clone();
    u30.Weld.Part0 = u25["Right Leg"];
    u30.Parent = u25;
    local u31 = ReplicatedStorage.Resources.yukimiya["Torso Trail"]:Clone();
    u31.Weld.Part0 = u25.Torso;
    u31.Parent = u25;
    Debris:AddItem(u27, 2.5);
    Debris:AddItem(u28, 2.5);
    Debris:AddItem(u29, 2.5);
    Debris:AddItem(u30, 2.5);
    Debris:AddItem(u31, 2.55);
    print(u31.Name, u31.Parent.Name);
    local u32, u33, u34 = mainreplication.bodyVelocity(HumanoidRootPart, 60, 1.2, nil, nil, true);

    if u32 then
        u34 = RunService.PreRender:Connect(function(p35) -- Line: 315
            -- upvalues: u32 (copy), u34 (ref), u26 (copy), HumanoidRootPart (copy), u33 (copy)
            if not u32.Parent then
                u34:Disconnect();
            end;

            u32.Velocity = (u26 and HumanoidRootPart.CFrame.LookVector - HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.LookVector + HumanoidRootPart.CFrame.RightVector).Unit * u33.Value;
        end);
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u25) then
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 40, 0.81, Enum.EasingStyle.Quart, Enum.EasingDirection.In);
        mainreplication.springcamerashake(15, 30);
        local v36 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v36.Parent = Lighting;
        v36.TintColor = Color3.fromRGB(2, 255, 141);
        v36.Brightness = 0.4;
        v36.Contrast = 1;
        v36.Saturation = -0.4;
        TweenService:Create(v36, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v36, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v36.Destroy, v36);
    end;

    task.delay(0.817, function() -- Line: 341
        -- upvalues: Players (ref), u25 (copy), mainreplication (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), u32 (copy), HumanoidRootPart (copy), RunService (ref), u26 (copy)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u25) then
            mainreplication.fov(false, 120);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(10, 60);
            local v37 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v37.Parent = Lighting;
            v37.TintColor = Color3.fromRGB(101, 116, 255);
            v37.Brightness = 0.4;
            v37.Contrast = 1;
            v37.Saturation = -0.4;
            TweenService:Create(v37, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v37, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v37.Destroy, v37);
        end;

        if u32 then
            u32:Destroy();
        end;

        local u38, _, u39 = mainreplication.bodyVelocity(HumanoidRootPart, 65.55, 0.955, nil, nil, true);

        if u38 then
            local u40 = 0.215;
            local os_clock_ret = os.clock();
            u39 = RunService.PreRender:Connect(function(p41) -- Line: 373
                -- upvalues: u38 (copy), u39 (ref), os_clock_ret (copy), u40 (ref), u26 (ref), HumanoidRootPart (ref)
                if not u38.Parent then
                    u39:Disconnect();
                end;

                if os.clock() - os_clock_ret > 0.1 then
                    u40 = u40 + p41;
                end;

                local v42 = math.clamp(u40 / 0.75, 0, 0.85) ^ 2 * 3.141592653589793 * 0.75;
                local v43 = u26 and HumanoidRootPart.CFrame.RightVector or -HumanoidRootPart.CFrame.RightVector;
                local LookVector = HumanoidRootPart.CFrame.LookVector;
                local math_cos_ret = math.cos(v42);
                local math_sin_ret = math.sin(v42);
                u38.Velocity = (v43 * math_cos_ret + LookVector * math_sin_ret).Unit * 65.55;
            end);
        end;
    end);
    task.delay(1.3, function() -- Line: 397
        -- upvalues: u27 (copy), u28 (copy), u29 (copy), u30 (copy), u31 (copy)
        for _, descendant in pairs(u27:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u28:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u29:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u30:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u31:GetDescendants()) do
            if descendant.ClassName == "ParticleEmitter" or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

function v1.yukimiya3Confirm(p44) -- Line: 426
    -- upvalues: createData (copy), UwUEffects (copy), mainreplication (copy), RunService (copy)
    local HumanoidRootPart = p44:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v45 = createData(p44, "yukimiya3Start");

    if v45.Thread and coroutine.status(v45.Thread) == "suspended" then
        task.cancel(v45.Thread);
        v45.Thread = nil;
    end;

    if v45.BodyVelocity then
        v45.BodyVelocity:Destroy();
        v45.BodyVelocity = nil;
    end;

    if v45.VFX then
        v45.VFX:Destroy();
        v45.VFX = nil;
    end;

    v45.VFX = UwUEffects.createEffect({
        Character = p44
    }, "YukiDribbleConfirm");
    local u46, u47, u48 = mainreplication.bodyVelocity(HumanoidRootPart, 150, 1, nil, nil, true);

    if u46 then
        local u49 = 0.25;
        local os_clock_ret = os.clock();
        u48 = RunService.PreRender:Connect(function(p50) -- Line: 456
            -- upvalues: u46 (copy), u48 (ref), os_clock_ret (copy), u49 (ref), HumanoidRootPart (copy), u47 (copy)
            if not u46.Parent then
                u48:Disconnect();
            end;

            if os.clock() - os_clock_ret > 0.1 then
                u49 = u49 + p50;
            end;

            local v51 = math.clamp(u49 / 1, 0, 0.75) * 3.141592653589793;
            local RightVector = HumanoidRootPart.CFrame.RightVector;
            local v52 = HumanoidRootPart.CFrame.LookVector * 2;
            local math_cos_ret = math.cos(v51);
            local math_sin_ret = math.sin(v51);
            u46.Velocity = (RightVector * math_cos_ret + v52 * math_sin_ret).Unit * u47.Value;
        end);
    end;
end;

function v1.yukimiyaFlow(u53, u54, p55) -- Line: 481
    -- upvalues: trove (copy), soundUtil (copy), ReplicatedStorage (copy), Util (copy), vfxUtil (copy), actionUtil (copy), Players (copy), UwUEffects (copy), mainreplication (copy), PlayerGui (copy), Lighting (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local v56;

    if u54 then
        v56 = u54:FindFirstChild("HumanoidRootPart");
    else
        v56 = u54;
    end;

    local HumanoidRootPart = u53:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v56) then
        return;
    end;

    local u57 = trove.new();
    u57:AttachToInstance(u53);
    local v58;

    if u53:GetAttribute("FunnyVoicelines") then
        v58 = soundUtil:play(ReplicatedStorage.Resources.yukimiya.awakenRNP, ReplicatedStorage, {
            Character = u53
        });
    else
        v58 = soundUtil:play(ReplicatedStorage.Resources.yukimiya.awakenSound, ReplicatedStorage, {
            Character = u53
        });
    end;

    Util.flowCancel(u57, p55, { v58 });
    u57:Add(vfxUtil.getScreenDimmer());

    if actionUtil.checkStyle(Players:GetPlayerFromCharacter(u54)) ~= "neru" then
        u54 = false;
    end;

    if not u54 then
        for _, child in workspace.characters:GetChildren() do
            if actionUtil.checkStyle(Players:GetPlayerFromCharacter(child)) == "neru" then
                u54 = child;
                break;
            end;
        end;
    end;

    u57:Add(UwUEffects.createEffect({
        Character = u53
    }, "YukiFlow"));
    print("hi", u53);
    local v59 = u57:Clone(ReplicatedStorage.Resources.yukimiya.yukiultcc);
    v59.Parent = game.lighting;
    local v60 = u57:Clone(ReplicatedStorage.Resources.yukimiya.yukiultcctest);
    v60.Parent = game.lighting;
    local v61 = u57:Clone(ReplicatedStorage.Resources.yukimiya.yukiultpropercc);
    v61.Parent = game.lighting;
    local v62, v63 = mainreplication.cutsceneBlender(HumanoidRootPart, ReplicatedStorage.Resources.yukimiya.AwakeningCamera, ReplicatedStorage.Resources.yukimiya.AwakeningFOV);
    u57:Add(v63);

    if v62 and v62:FindFirstChild("CamPart") then
        for _, child in ReplicatedStorage.Resources.yukimiya.AwakeningCam:GetChildren() do
            child:Clone().Parent = v62.CamPart;
        end;
    end;

    local AwakeningImpact = ReplicatedStorage.Resources.yukimiya.AwakeningImpact;
    u57:Add(Util.Preload(AwakeningImpact));
    Util.AttributeTween(v59);
    Util.AttributeTween(v60);
    Util.AttributeTween(v61);
    Util.DarkLighting();
    mainreplication.sceneEnabled(true);
    u57:Clone(ReplicatedStorage.Resources.uibox).Parent = PlayerGui;
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.2;
    ColorCorrectionEffect.Brightness = 0;
    u57:Add(ColorCorrectionEffect);
    local v64 = u57:Clone(ReplicatedStorage.Resources.DepthOfField);
    v64.Parent = Lighting;
    v64.FarIntensity = 1;
    local u65 = u57:Clone(ReplicatedStorage.Resources.yukimiya.AwakeningMap);
    u65:PivotTo(CFrame.new(0, 1000, 0));
    u65.Parent = workspace.Effects;

    if u53:GetAttribute("RinNoPlay") then
        u65.catbruh.Transparency = 1;
        u65.catbruh.Cats.Enabled = true;
    end;

    u57:Add(task.delay(3.1, function() -- Line: 572
        -- upvalues: u65 (copy), HumanoidRootPart (copy)
        u65:PivotTo(HumanoidRootPart.CFrame);
    end));
    u57:Add(task.delay(4.317 - #AwakeningImpact:GetChildren() / 24, function() -- Line: 576
        -- upvalues: u57 (copy), Util (ref), AwakeningImpact (copy)
        u57:Add(Util.Gif(AwakeningImpact, 24));
    end));

    if v58.Name == "Dub" then
        u57:Add(task.spawn(function() -- Line: 581
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u54 (ref)
            u57:Add(TekrinnDialogue.Speak(u54 or "???", {
                {
                    Text = " He\'s using people as obstacles to weave through...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u57:Add(task.delay(4.183, function() -- Line: 606
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u54 (ref)
            u57:Add(TekrinnDialogue.Speak(u54 or "???", {
                {
                    Text = "This is street soccer-style dribbling!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
        u57:Add(task.delay(6.65, function() -- Line: 631
            -- upvalues: u57 (copy), u65 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Remove(u65);
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = "Keep clear. ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                },
                {
                    Text = "I don\'t have much time left.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
    elseif v58.Name == "awakenRNP" then
        u57:Add(task.spawn(function() -- Line: 679
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = " Go! Go! Go!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 0.75));
        end));
        u57:Add(task.delay(1.1, function() -- Line: 705
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = "Can you feel the speed?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 1.75));
        end));
        u57:Add(task.delay(2.85, function() -- Line: 731
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = "Yeaaaaaaah baby!",
                    Bold = false,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 1.75));
        end));
        u57:Add(task.delay(4.7, function() -- Line: 757
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = "Do you feel that adrenaline surging through your veins? ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                },
                {
                    Text = "No? Just me?",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
    else
        u57:Add(task.spawn(function() -- Line: 804
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u54 (ref)
            u57:Add(TekrinnDialogue.Speak(u54 or "???", {
                {
                    Text = "Using people as obstacles to weave through...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u57:Add(task.delay(4.183, function() -- Line: 829
            -- upvalues: u57 (copy), TekrinnDialogue (ref), u54 (ref)
            u57:Add(TekrinnDialogue.Speak(u54 or "???", {
                {
                    Text = "This is street soccer-style dribbling!",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
        u57:Add(task.delay(6.65, function() -- Line: 854
            -- upvalues: u57 (copy), u65 (copy), TekrinnDialogue (ref), u53 (copy)
            u57:Remove(u65);
            u57:Add(TekrinnDialogue.Speak(u53, {
                {
                    Text = "Out of my way. ",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                },
                {
                    Text = "I\'m running out of time.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
    end;

    u57:Add(function() -- Line: 904
        -- upvalues: HumanoidRootPart (copy), mainreplication (ref), Util (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref)
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        HumanoidRootPart.Anchored = true;
        task.delay(0.1, function() -- Line: 908
            -- upvalues: HumanoidRootPart (ref)
            HumanoidRootPart.Anchored = false;
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        end);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        Util.ReturnLighting();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
    end);
    u57:Add(task.delay(9.817, function() -- Line: 925
        -- upvalues: u57 (copy)
        u57:Destroy();
    end));
end;

function v1.yukimiyaFlowRare(u66, p67, p68) -- Line: 930
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), Util (copy), ReplicatedStorage (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local AwakeningRare = vfxUtil.getResources().yukimiya.AwakeningRare;
    local Root = vfxUtil.getRoot(u66);
    local Ball = u66:FindFirstChild("Ball");
    local v69 = soundUtil:play(AwakeningRare.Sound, "default", {
        Character = u66
    });
    mainreplication.sceneEnabled(true);
    local u70 = trove.new();
    u70:AttachToInstance(u66);
    u70:Add(function() -- Line: 940
        -- upvalues: Ball (copy), mainreplication (ref)
        if Ball then
            Ball.Transparency = 0;
            Ball.Name = "Ball";
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
    end);
    Util.flowCancel(u70, p68, { v69 });
    u70:Add(task.delay(5, function() -- Line: 952
        -- upvalues: u70 (copy)
        u70:Destroy();
    end));
    local v71 = u70:Clone(AwakeningRare.VFX);
    v71:PivotTo(u66:GetPivot());
    vfxUtil.setupAura(u66, v71.TemplateR6, true, true);
    local v72 = u70:Add(v71.TemplateR6["azl ballllllls_rig"]);
    v72.Ball.ball.Part0 = Root;
    v72.Parent = u66;
    v71.Parent = workspace.Effects;

    if Ball then
        Ball.Transparency = 1;
        Ball.Name = "Temp";
    end;

    local v73 = u70:Clone(ReplicatedStorage.Resources.yukimiya.AwakeningMap);
    v73:PivotTo(Root.CFrame * CFrame.new(-7.225, -1.848, 22.616) * CFrame.Angles(0, -0.060039326268604934, 0));
    v73.Parent = workspace.Effects;
    local MoonEffects = vfxUtil.getMoonEffects();
    u70:Add(MoonEffects);
    local _, v74 = mainreplication.cutsceneCamRigWithLetterBox(Root, AwakeningRare.CamAnimation, AwakeningRare.FOV, u66, nil, AwakeningRare.Cam, "CamPart");
    u70:Add(v74);
    local v75 = {
        Workspace = v71,
        ["Screen Cover"] = MoonEffects["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(u70, v75, AwakeningRare.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        Brightness = 3,
        ExposureCompensation = 0.2,
        ClockTime = 12,
        GeographicLatitude = 23,
        Ambient = Color3.new(1, 1, 1),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.fromRGB(38, 38, 38)
    });
    local v76 = u70:Construct(MoonPropertyAnimator);
    v76:LoadAndConvertSave(AwakeningRare.Moon, v75);
    v76:SetOriginalRoot(AwakeningRare.VFX:GetPivot());
    v76:SetRoot(Root);
    v76:PlayAll();
    vfxUtil.execute_compiled(AwakeningRare.Compiled, u70, v71, v72);
    u70:Add(task.delay(0.82, function() -- Line: 1004
        -- upvalues: u70 (copy), TekrinnDialogue (ref), u66 (copy)
        u70:Add(TekrinnDialogue.Speak(u66, {
            {
                Text = "Street Soccer S-",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 1));
    end));
    u70:Add(task.delay(2, function() -- Line: 1027
        -- upvalues: u70 (copy), TekrinnDialogue (ref), u66 (copy)
        u70:Add(TekrinnDialogue.Speak(u66, {
            {
                Text = "Ouch..",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 1));
    end));
end;

function v1.yukimiya5(u77, p78) -- Line: 1052
    -- upvalues: Lighting (copy), createData (copy), UwUEffects (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), soundUtil (copy), TekrinnDialogue (copy), PlayerGui (copy), animationUtil (copy), Color2 (copy), Color (copy), Decay (copy), Density (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    if p78 then
        p78 = p78:FindFirstChild("HumanoidRootPart");
    end;

    local HumanoidRootPart = u77:FindFirstChild("HumanoidRootPart");
    local Atmosphere = Lighting.Atmosphere;

    if not (HumanoidRootPart and p78) then
        return;
    end;

    createData(u77, "yukimiya5").VFX = UwUEffects.createEffect({
        Character = u77
    }, "YukiUltimate1");
    local u79, u80 = mainreplication.cutsceneBlender(HumanoidRootPart, ReplicatedStorage.Resources.yukimiya.Skill5SuccessC, ReplicatedStorage.Resources.yukimiya.UltFOV1);
    Util.CameraEffect(ReplicatedStorage.Resources.yukimiya.Ult1Cam, u79.CamPart);

    if u77:GetAttribute("FunnyVoicelines") then
        soundUtil:play(ReplicatedStorage.Resources.yukimiya.ult1SoundRNP, ReplicatedStorage);
        task.delay(0.4, function() -- Line: 1068
            -- upvalues: TekrinnDialogue (ref), u77 (copy)
            TekrinnDialogue.Speak(u77, {
                {
                    Text = "Come on, come on, come on!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1.5,
                        Lifetime = 4
                    }
                }
            }, 1);
        end);
        task.delay(1.7, function() -- Line: 1094
            -- upvalues: TekrinnDialogue (ref), u77 (copy)
            TekrinnDialogue.Speak(u77, {
                {
                    Text = "Must. Go. Faster!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2.5);
        end);
    end;

    soundUtil:play(ReplicatedStorage.Resources.yukimiya.ult1Sound, ReplicatedStorage);
    mainreplication.sceneEnabled(true);
    local main = workspace.map.map.sanam.main;
    local Material = main.Material;
    main.Color = Color3.fromRGB(255, 155, 32);
    main.Material = Enum.Material.SmoothPlastic;
    local u81 = ReplicatedStorage.Resources.vb:Clone();
    u81.Parent = PlayerGui;
    Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Atmosphere.Decay = Color3.fromRGB(0, 0, 0);
    Atmosphere.Density = 0.4;
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(255, 106, 0);
    Lighting.ExposureCompensation = 0;
    Lighting.Bloom.Threshold = 1.3;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.5;
    ColorCorrectionEffect.Saturation = 0;
    ColorCorrectionEffect.Brightness = 0;
    local u82 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u82.Parent = Lighting;
    u82.FarIntensity = 1;

    if u77:GetAttribute("RinNoPlay") then
        task.delay(1.6, function() -- Line: 1157
            -- upvalues: animationUtil (ref), u77 (copy), ReplicatedStorage (ref), u80 (ref), soundUtil (ref), u79 (ref), mainreplication (ref), HumanoidRootPart (copy)
            animationUtil:loadAnimation(u77, ReplicatedStorage.Resources.yukimiya.FailAnim):Play(0);
            u80();
            soundUtil:play(ReplicatedStorage.Resources.yukimiya.failSound, ReplicatedStorage);
            local v83, v84 = mainreplication.cutsceneBlender(HumanoidRootPart, ReplicatedStorage.Resources.yukimiya.FailCamera, ReplicatedStorage.Resources.yukimiya.FailFOV);
            u79 = v83;
            u80 = v84;
        end);
    end;

    task.delay(2.45, function() -- Line: 1168
        -- upvalues: main (copy), Color2 (ref), Material (copy), Atmosphere (copy), Color (ref), Decay (ref), Density (ref), Lighting (ref)
        main.Color = Color2;
        main.Material = Material;
        Atmosphere.Color = Color;
        Atmosphere.Decay = Decay;
        Atmosphere.Density = Density;
        Lighting.Ambient = Color3.fromRGB(189, 219, 255);
        Lighting.ExposureCompensation = 1;
        Lighting.Bloom.Threshold = 3.55;
    end);
    local u85 = ReplicatedStorage.Resources.yukimiya.blind:Clone();
    u85.Parent = game.lighting;
    Util.AttributeTween(u85);
    task.delay(3.517, function() -- Line: 1187
        -- upvalues: u80 (ref), mainreplication (ref), u85 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref), ColorCorrectionEffect (copy), u81 (copy), u82 (copy)
        u80();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        u85:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u81:Destroy();
        u82:Destroy();
    end);
end;

function v1.yukimiya5gyro(u86, p87) -- Line: 1211
    -- upvalues: vfxUtil (copy), createData (copy), UwUEffects (copy), mainreplication (copy), ReplicatedStorage (copy), Util (copy), soundUtil (copy), PlayerGui (copy), Lighting (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), ClockTime (copy)
    local HumanoidRootPart = u86:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u88, u89 = vfxUtil.earlyCancel(p87, u86);
    local v90 = createData(u86, "yukimiya5gyro");
    v90.VFX = UwUEffects.createEffect({
        Character = u86
    }, "YukiUltimate2");
    u88:Add(v90.VFX);
    local v91, v92 = mainreplication.cutsceneBlender(HumanoidRootPart, ReplicatedStorage.Resources.yukimiya.Skill5SuccessC2, ReplicatedStorage.Resources.yukimiya.UltFOV2);
    u88:Add(v92);
    local GyroImpact = ReplicatedStorage.Resources.yukimiya.GyroImpact;
    u88:Add(Util.Preload(GyroImpact));
    u88:Add(Util.CameraEffect(ReplicatedStorage.Resources.yukimiya.Ult2Cam, v91.CamPart));
    local u93 = soundUtil:play(ReplicatedStorage.Resources.yukimiya.ult2Sound, ReplicatedStorage, {
        Character = u86
    });
    mainreplication.bright(-1, 0.15);
    mainreplication.sceneEnabled(true);
    u88:Clone(ReplicatedStorage.Resources.uibox).Parent = PlayerGui;
    Lighting.Brightness = 1;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 3.55;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.4;
    ColorCorrectionEffect.Saturation = -0.4;
    ColorCorrectionEffect.Brightness = 0;
    u88:Add(ColorCorrectionEffect);
    local v94 = u88:Clone(ReplicatedStorage.Resources.DepthOfField);
    v94.Parent = Lighting;
    v94.FarIntensity = 1;
    local v95 = u88:Clone(ReplicatedStorage.Resources.yukimiya.gyroshotultcc);
    v95.Parent = Lighting;
    Util.AttributeTween(v95);
    local v96 = u88:Clone(ReplicatedStorage.Resources.yukimiya.flowVignette);
    v96.Parent = PlayerGui;
    Util.AttributeTween(v96);
    local v97 = u88:Clone(ReplicatedStorage.Resources.yukimiya.ballwind);
    v97.Weld.Part0 = u86:FindFirstChild("Ball");
    v97.Parent = u86;

    if u93.Name == "Dub" then
        u88:Add(task.delay(0.383, function() -- Line: 1279
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "I see it. The angle...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(2.6, function() -- Line: 1305
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "That\'s where I aim..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(4.8 - #GyroImpact:GetChildren() / 24, function() -- Line: 1331
            -- upvalues: Util (ref), GyroImpact (copy)
            Util.Gif(GyroImpact, 24);
        end));
        u88:Add(task.delay(7.4, function() -- Line: 1335
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "That ultimate shot, that\'ll take me where I want to be...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
        u88:Add(task.delay(13, function() -- Line: 1361
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "...INTO THE ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                },
                {
                    Text = "FLOW!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 7,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
        u88:Add(task.delay(17.8, function() -- Line: 1408
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "Barely made it in time.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.075,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(19.85, function() -- Line: 1434
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "So this is what it feels like...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(1, 1, 1),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(21.65, function() -- Line: 1460
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "\"the flow.\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(207, 207, 207)) }),
                    TextStrokeColor = Color3.fromRGB(207, 207, 207),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
    else
        u88:Add(task.delay(0.383, function() -- Line: 1486
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "I see it. My...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(2.6, function() -- Line: 1512
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "best angle for a shot.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(4.8 - #GyroImpact:GetChildren() / 24, function() -- Line: 1538
            -- upvalues: u88 (copy), Util (ref), GyroImpact (copy)
            u88:Add(Util.Gif(GyroImpact, 24));
        end));
        u88:Add(task.delay(7.3, function() -- Line: 1542
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "The ultimate shot that will lead me...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.025,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
        u88:Add(task.delay(13.5, function() -- Line: 1568
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "...TO THE ",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 4
                    }
                },
                {
                    Text = "FLOW!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.015,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 7,
                        Lifetime = 2
                    }
                }
            }, 2));
        end));
        u88:Add(task.delay(17.8, function() -- Line: 1615
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "Goal in time.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(19.85, function() -- Line: 1641
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "So this is sensation is the...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(1, 1, 1),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 3));
        end));
        u88:Add(task.delay(21.65, function() -- Line: 1667
            -- upvalues: u88 (copy), TekrinnDialogue (ref), u86 (copy)
            u88:Add(TekrinnDialogue.Speak(u86, {
                {
                    Text = "\"flow.\"",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.1,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(207, 207, 207)) }),
                    TextStrokeColor = Color3.fromRGB(207, 207, 207),
                    Shake = {
                        Enabled = false,
                        Intensity = 3,
                        Lifetime = 4
                    }
                }
            }, 2));
        end));
    end;

    u88:Add(function() -- Line: 1694
        -- upvalues: u89 (ref), u93 (copy), mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ClockTime (ref)
        if not u89 then
            u93:Destroy();
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Lighting.ClockTime = ClockTime;
    end);
    u88:Add(task.delay(21.533, function() -- Line: 1709
        -- upvalues: u89 (ref), u88 (copy)
        u89 = true;
        u88:Destroy();
    end));
end;

function v1.yukimiyaSkill2Start(u98, u99, p100, u101) -- Line: 1715
    -- upvalues: soundUtil (copy), ReplicatedStorage (copy), createData (copy), vfxUtil (copy), mainreplication (copy), RunService (copy), Debris (copy), Players (copy), Lighting (copy), TweenService (copy)
    local HumanoidRootPart = u98:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    soundUtil:play(ReplicatedStorage.Resources.yukimiya.fake, HumanoidRootPart, {
        Character = u98
    });
    local u102 = 40 * u101;
    local u103 = 90 * u101;
    local u104 = 0.6 / u101;
    local _ = HumanoidRootPart.CFrame;
    local u105 = createData(u98, "yukimiyaSkill2Start");

    if u105.container then
        u105.container:Destroy();
        u105.container = nil;
    end;

    local u106 = vfxUtil.character_trove(u98);
    u105.container = u106;
    u106:Add(function() -- Line: 1736
        -- upvalues: u105 (copy), u106 (copy)
        if u105.container == u106 then
            u105.container = nil;
        end;
    end);
    u106:Connect(p100.Changed, function(p107) -- Line: 1742
        -- upvalues: u106 (copy)
        if p107 then
            u106:Destroy();
        end;
    end);

    if p100.Value then
        u106:Destroy();

        return;
    end;

    u106:Add(task.spawn(function() -- Line: 1753
        -- upvalues: mainreplication (ref), HumanoidRootPart (copy), u101 (copy), u106 (copy), RunService (ref), u99 (copy), u102 (copy), u103 (copy), u104 (copy)
        local u108, u109, u110 = mainreplication.bodyVelocity(HumanoidRootPart, 70 * u101, 0.35 / u101, nil, nil, false);

        if u108 then
            u106:Add(u108);
            u110 = RunService.PreRender:Connect(function() -- Line: 1757
                -- upvalues: u108 (copy), u110 (ref), u99 (ref), HumanoidRootPart (ref), u109 (copy), u102 (ref)
                if u108.Parent then
                    u108.Velocity = ((u99 and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector) + HumanoidRootPart.CFrame.LookVector * 0.45).Unit * (u109 and u109.Value or u102);

                    return;
                end;

                u110:Disconnect();
            end);
        end;

        u106:Add(task.delay(0.35, function() -- Line: 1772
            -- upvalues: mainreplication (ref), HumanoidRootPart (ref), u101 (ref), u106 (ref), RunService (ref), u99 (ref), u102 (ref)
            local u111, u112, u113 = mainreplication.bodyVelocity(HumanoidRootPart, 50 * u101, 0.25 / u101, nil, nil, false);

            if u111 then
                u106:Add(u111);
                u113 = RunService.PreRender:Connect(function() -- Line: 1776
                    -- upvalues: u111 (copy), u113 (ref), u99 (ref), HumanoidRootPart (ref), u112 (copy), u102 (ref)
                    if u111.Parent then
                        u111.Velocity = (-(u99 and -HumanoidRootPart.CFrame.RightVector or HumanoidRootPart.CFrame.RightVector) + HumanoidRootPart.CFrame.LookVector * 0.45).Unit * (u112 and u112.Value or u102);

                        return;
                    end;

                    u113:Disconnect();
                end);
            end;
        end));
        u106:Add(task.delay(0.7166666666666667, function() -- Line: 1792
            -- upvalues: mainreplication (ref), HumanoidRootPart (ref), u103 (ref), u101 (ref), u106 (ref), u99 (ref), RunService (ref), u104 (ref)
            local u114, _, u115 = mainreplication.bodyVelocity(HumanoidRootPart, u103, 0.78333 / u101, nil, nil, true);

            if u114 then
                u106:Add(u114);
                local u116 = 0;
                local u117 = u99 and -0.6108652381980153 or 0.6108652381980153;
                u115 = RunService.PreRender:Connect(function(p118) -- Line: 1800
                    -- upvalues: u114 (copy), u115 (ref), u116 (ref), u104 (ref), u117 (copy), HumanoidRootPart (ref), u103 (ref)
                    if not u114.Parent then
                        u115:Disconnect();

                        return;
                    end;

                    u116 = u116 + p118;
                    local v119 = math.clamp(u116 / u104, 0, 1) ^ 2;
                    local v120 = u117 + (0 - u117) * v119;
                    local RightVector = HumanoidRootPart.CFrame.RightVector;
                    u114.Velocity = (HumanoidRootPart.CFrame.LookVector * math.cos(v120) + RightVector * math.sin(v120)).Unit * u103;
                end);
            end;
        end));
    end));
    u106:Add(function() -- Line: 1825
        -- upvalues: u105 (copy), u106 (copy)
        if u105.container == u106 then
            u105.container = nil;
        end;
    end);
    local v121;

    if u99 then
        v121 = ReplicatedStorage.Resources.yukimiya:FindFirstChild("DragScissorsLeftok");
    else
        v121 = ReplicatedStorage.Resources.yukimiya:FindFirstChild("DragScissorsok");
    end;

    local u122 = {};
    local u123 = {};
    local Ball = u98:FindFirstChild("Ball");

    if v121 then
        for _, child in ipairs(v121:GetChildren()) do
            local v124 = child.Name == "Ball" and Ball and Ball or u98:FindFirstChild(child.Name);

            if v124 then
                local v125 = child:Clone();

                for _, child2 in ipairs(v125:GetChildren()) do
                    child2.Parent = v124;
                    table.insert(u123, child2);
                    u106:Add(child2);

                    if child2:IsA("Trail") or (child2:IsA("Beam") or child2:IsA("ParticleEmitter")) then
                        child2.Enabled = true;
                        table.insert(u122, child2);
                    end;
                end;

                v125:Destroy();
            end;
        end;
    end;

    local v126 = {
        Ball = Ball,
        HumanoidRootPart = HumanoidRootPart
    };
    local Resources = vfxUtil.getResources();
    local v127 = u99 and Resources.yukimiya:FindFirstChild("DragScissorsLeftCompiled") or Resources.yukimiya:FindFirstChild("DragScissorsRightCompiled");

    if v127 then
        vfxUtil.execute_compiled(v127, u106, v126);
    end;

    u106:Add(task.delay(1.39 / u101, function() -- Line: 1868
        -- upvalues: u122 (copy), u123 (copy), Debris (ref)
        for _, v in ipairs(u122) do
            if v.Parent then
                v.Enabled = false;
            end;
        end;

        for _, v in ipairs(u123) do
            if v.Parent then
                Debris:AddItem(v, 2);
            end;
        end;
    end));
    u106:Add(task.delay(3.39 / u101, function() -- Line: 1881
        -- upvalues: u106 (copy)
        u106:Destroy();
    end));
    task.delay(0.35 / u101, function() -- Line: 1885
        -- upvalues: mainreplication (ref), u98 (copy), u99 (copy), u101 (copy)
        mainreplication.highlight(u98, u99 and Color3.fromRGB(255, 113, 47) or Color3.fromRGB(255, 133, 46), (u99 and 0.31666666666666665 or 0.38333333333333336) / u101);
    end);
    task.delay((u99 and 0.6833333333333333 or 0.75) / u101, function() -- Line: 1889
        -- upvalues: mainreplication (ref), u98 (copy), u99 (copy), u101 (copy)
        mainreplication.highlight(u98, u99 and Color3.fromRGB(255, 113, 47) or Color3.fromRGB(255, 133, 46), (u99 and 0.9666666666666667 or 0.9) / u101);
    end);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u98) then
        local function createCC(p128: number, p129: number, p130: number, p131: number, p132: any) -- Line: 1894
            -- upvalues: Lighting (ref), TweenService (ref)
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Parent = Lighting;
            ColorCorrectionEffect.Saturation = p128;
            ColorCorrectionEffect.Contrast = p129;
            ColorCorrectionEffect.Brightness = p130;
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(p131, p132 or Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Saturation = 0,
                Contrast = 0,
                Brightness = 0
            }):Play();
            task.delay(p131 + 0.1, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
        end;

        local v133 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v133.Parent = Lighting;
        v133.TintColor = Color3.fromRGB(255, 114, 58);
        v133.Brightness = 0.4;
        v133.Contrast = 1;
        v133.Saturation = -0.4;
        TweenService:Create(v133, TweenInfo.new(1.5 / u101, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v133, TweenInfo.new(2 / u101, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2 / u101, v133.Destroy, v133);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.35 / u101, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        mainreplication.springcamerashake(15, 40);
        task.delay(0.35 / u101, function() -- Line: 1922
            -- upvalues: createCC (copy), u99 (copy), u101 (copy)
            createCC(0.2, 0.2, 0, (u99 and 0.31666666666666665 or 0.38333333333333336) / u101, Enum.EasingStyle.Linear);
        end);
        task.delay((u99 and 0.6833333333333333 or 0.75) / u101, function() -- Line: 1926
            -- upvalues: createCC (copy), u99 (copy), u101 (copy)
            createCC(0.52, 0.13, 0.1, (u99 and 0.9666666666666667 or 0.9) / u101, Enum.EasingStyle.Quart);
        end);
        task.delay(0.35 / u101, function() -- Line: 1930
            -- upvalues: mainreplication (ref), u101 (copy)
            mainreplication.fov(false, 70);
            mainreplication.fov(true, 62.5, 0.21666666666666667 / u101, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut);
        end);
        task.delay(0.7166666666666667 / u101, function() -- Line: 1935
            -- upvalues: mainreplication (ref), u101 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            mainreplication.fov(false, 120);
            mainreplication.fov(true, 70, 2 / u101, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            local v134 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v134.Parent = Lighting;
            v134.TintColor = Color3.fromRGB(255, 105, 35);
            v134.Brightness = 0.4;
            v134.Contrast = 1;
            v134.Saturation = -0.4;
            TweenService:Create(v134, TweenInfo.new(1.5 / u101, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v134, TweenInfo.new(2 / u101, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v134.Destroy, v134);
        end);
        task.delay(0.35 / u101, function() -- Line: 1952
            -- upvalues: mainreplication (ref)
            mainreplication.springcamerashake(15, 30);
        end);
        task.delay(0.75 / u101, function() -- Line: 1956
            -- upvalues: mainreplication (ref)
            mainreplication.springcamerashake(20, 30);
        end);
    end;
end;

function v1.yukimiya_streetstyle(u135: any, p136: any, p137: table) -- Line: 1962
    -- upvalues: vfxUtil (copy), u3 (copy), mainreplication (copy), soundUtil (copy), trove (copy), PlayerGui (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local StreetSoccerStyle = vfxUtil.getResources().yukimiya.StreetSoccerStyle;
    local Root = vfxUtil.getRoot(u135);
    u135:FindFirstChild("Ball");

    if u3[u135] then
        u3[u135]:Destroy();
    end;

    mainreplication.sceneEnabled(true);
    local u138 = soundUtil:play(StreetSoccerStyle.SFX, "default", {
        Character = u135
    }).Name == "Dub";
    local u139 = trove.new();
    u3[u135] = u139;
    u139:AttachToInstance(u135);
    u139:Add(function() -- Line: 1978
        -- upvalues: u3 (ref), u135 (copy), u139 (copy)
        if u3[u135] == u139 then
            u3[u135] = nil;
        end;
    end);
    u139:Add(function() -- Line: 1983
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u139:Add(task.delay(8.033, function() -- Line: 1987
        -- upvalues: u139 (copy)
        u139:Destroy();
    end));
    local v140 = u139:Clone(StreetSoccerStyle.VFX);
    v140:PivotTo(Root.CFrame);
    v140.Parent = workspace.Effects;
    local v141, v142 = mainreplication.cutsceneCamRigWithLetterBox(Root, StreetSoccerStyle.CamAnimation, StreetSoccerStyle.FOV, nil, "default", StreetSoccerStyle.yukistreetdribblingCamz, "CamPart");
    u139:Add(v142);
    local v143 = u139:Add(vfxUtil.getMoonEffects());

    for _, child in StreetSoccerStyle.UI:GetChildren() do
        u139:Clone(child).Parent = PlayerGui;
    end;

    local v144 = {
        Vignette = v143.Vignette,
        Workspace = v140
    };
    vfxUtil.cutscene_lighting(u139, v144, StreetSoccerStyle.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 0.15000000596046448,
        ClockTime = 12,
        GeographicLatitude = 201,
        Ambient = Color3.new(1, 1, 1),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v145 = u139:Construct(MoonPropertyAnimator);
    v145:LoadAndConvertSave(StreetSoccerStyle.Moon, v144);
    v145:SetOriginalRoot(StreetSoccerStyle.VFX:GetPivot());
    v145:SetRoot(Root);
    v145:PlayAll();
    vfxUtil.execute_compiled(StreetSoccerStyle.Compiled, u139, v140, v141);
    u139:Add(task.delay(0.208, function() -- Line: 2036
        -- upvalues: u139 (copy), TekrinnDialogue (ref), u135 (copy), u138 (copy)
        u139:Add(TekrinnDialogue.Speak(u135, {
            {
                TypeSpeed = 0.02,
                Text = u138 and "It\'s time to enter the" or "Time to get into a",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = " flow ",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            },
            {
                Text = "state",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            },
            {
                Text = "...",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u139:Add(task.delay(3.413, function() -- Line: 2093
        -- upvalues: u139 (copy), TekrinnDialogue (ref), u135 (copy)
        u139:Add(TekrinnDialogue.Speak(u135, {
            {
                Text = "One step beyond my",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = " best ",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            },
            {
                Text = "performance",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            },
            {
                Text = ".",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u139:Add(task.delay(7.05, function() -- Line: 2152
        -- upvalues: u139 (copy), TekrinnDialogue (ref), u135 (copy)
        u139:Add(TekrinnDialogue.Speak(u135, {
            {
                Text = "GO!",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 4,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
end;

function v1.yukimiya_streetTag(p146: any, u147: userdata) -- Line: 2173
    -- upvalues: vfxUtil (copy), trove (copy), soundUtil (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy)
    local yukimiya = vfxUtil.getResources().yukimiya;
    local Pose = yukimiya.StreetTag.Pose;
    local Root = vfxUtil.getRoot(p146);
    local u148 = trove.new();
    u148:AttachToInstance(p146);
    u148:Connect(u147.AncestryChanged, function() -- Line: 2180
        -- upvalues: u147 (copy), u148 (copy)
        if not u147.Value then
            u148:Destroy();
        end;
    end);
    soundUtil:play(yukimiya["counter start"], Root);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p146) then
        mainreplication.eradicateVelocity(Root);
        mainreplication.fov(false, 50);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 30);
        local v149 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v149.Parent = Lighting;
        v149.TintColor = Color3.fromRGB(255, 255, 255);
        v149.Brightness = 0.4;
        v149.Contrast = 1;
        v149.Saturation = -0.4;
        TweenService:Create(v149, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v149, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v149.Destroy, v149);
    end;

    local v150 = u148:Clone(Pose.cpose);
    local v151 = u148:Add(v150.Highlight);
    v151.Parent = p146;
    vfxUtil.setupAura(p146, v150, true);
    v150.Parent = workspace.Effects;
    local v152 = 0;

    for _, v in ipairs({
        { 0, v150.HumanoidRootPart["1"] },
        { 0.2, v150.Ball }
    }) do
        u148:Add(task.delay(v[1], shared.vfx.emit, v[2]));
        local v153 = v[1] + vfxUtil.getEmittersLifetime(v[2]);
        v152 = math.max(v152, v153);
    end;

    u148:Add(task.delay(v152, function() -- Line: 2228
        -- upvalues: u148 (copy)
        u148:Destroy();
    end));
    local v154 = {
        CurrentCamera = workspace_CurrentCamera,
        Highlight = v151
    };
    local v155 = u148:Construct(MoonPropertyAnimator);
    v155:LoadAndConvertSave(Pose.Moon, v154);
    v155:PlayAll();
end;

local u156 = {};

function v1.yukimiya_streetTagged(u157) -- Line: 2241
    -- upvalues: vfxUtil (copy), u156 (copy), trove (copy), soundUtil (copy), mainreplication (copy), Lighting (copy), MoonCFrameTimeline (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy)
    local yukimiya = vfxUtil.getResources().yukimiya;
    local Counter = yukimiya.StreetTag.Counter;
    local Root = vfxUtil.getRoot(u157);

    if u156[u157] then
        u156[u157]:Destroy();
    end;

    local u158 = trove.new();
    u158:AttachToInstance(u157);
    soundUtil:play(yukimiya["countered (2)"], Root);
    local v159, u160 = vfxUtil.buildFromRig(u157, Counter.c);
    u156[u157] = v159;
    u158:Add(function() -- Line: 2257
        -- upvalues: u156 (ref), u157 (copy)
        u156[u157] = nil;
    end);
    u158:Add(v159);
    mainreplication.bodyVelocity(Root, -50, 0.5);
    local v161 = 0;

    for _, v in ipairs({
        {
            0,
            {
                u157.Ball.Attachment,
                u157.HumanoidRootPart["1"],
                u157.HumanoidRootPart["2"].Attachment,
                u157.HumanoidRootPart.Turn
            }
        },
        {
            43,
            {
                u157.Ball.Attachment,
                u157.HumanoidRootPart["3"],
                u157.HumanoidRootPart["4"],
                u157.HumanoidRootPart["1G"],
                u157.trailplaceholder,
                u157.trailplaceholder2
            }
        },
        {
            65,
            { u157.HumanoidRootPart["2G"] }
        }
    }) do
        local v162 = v[1] / 60;

        for _, v2 in v[2] do
            u158:Add(task.delay(v162, shared.vfx.emit, v2));
            local v163 = v162 + vfxUtil.getEmittersLifetime(v2);
            v161 = math.max(v161, v163);
        end;
    end;

    u158:Add(task.delay(v161, function() -- Line: 2294
        -- upvalues: u158 (copy)
        u158:Destroy();
    end));
    u158:Add(task.delay(2, function() -- Line: 2298
        -- upvalues: u160 (copy)
        for _, descendant in u160:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;
    end));
    local v164 = u158:Clone(Counter.ColorCorrection);
    local v165 = {
        c = u157,
        ColorCorrection = v164
    };

    if vfxUtil.isLocalPlayer(u157) then
        v164.Parent = Lighting;
        u158:Construct(MoonCFrameTimeline, Counter.CFrame, Counter.Moon):Cast(Root, Vector3.new(1.5, 1, 1.1590909));
        mainreplication.springcamerashake(20, 30);
        task.delay(0.7166666666666667, function() -- Line: 2314
            -- upvalues: mainreplication (ref)
            mainreplication.springcamerashake(40, 60);
        end);
        v165.CurrentCamera = workspace_CurrentCamera;
    end;

    local v166 = u158:Construct(MoonPropertyAnimator);
    v166:LoadAndConvertSave(Counter.Moon, v165);
    v166:PlayAll();
end;

function v1.yukimiya_streetParry(u167) -- Line: 2325
    -- upvalues: vfxUtil (copy), u156 (copy), trove (copy), RunService (copy), workspace_CurrentCamera (copy), soundUtil (copy), mainreplication (copy), BackgroundHighlight (copy), wiki (copy), Lighting (copy), MoonPropertyAnimator (copy), MoonCFrameTimeline (copy)
    local yukimiya = vfxUtil.getResources().yukimiya;
    local Parry = yukimiya.StreetTag.Parry;
    local Root = vfxUtil.getRoot(u167);

    if u156[u167] then
        u156[u167]:Destroy();
    end;

    local u168 = trove.new();
    u168:AttachToInstance(u167);
    local v169, u170 = vfxUtil.buildFromRig(u167, Parry.Parry);
    u156[u167] = v169;
    u168:Add(function() -- Line: 2339
        -- upvalues: u156 (ref), u167 (copy)
        u156[u167] = nil;
    end);
    u168:Add(v169);
    local u171 = u168:Clone(Parry.camm);
    u171.Parent = workspace.Effects;
    u168:Connect(RunService.RenderStepped, function() -- Line: 2347
        -- upvalues: u171 (copy), workspace_CurrentCamera (ref)
        u171:PivotTo(workspace_CurrentCamera.CFrame);
    end);
    local v172 = 0;

    for _, v in ipairs({
        {
            0,
            { u167.Ball }
        },
        {
            17,
            {
                u167.HumanoidRootPart["1G"],
                u167.HumanoidRootPart["1"],
                u167.HumanoidRootPart["2"],
                u171
            }
        },
        {
            36,
            { u167.HumanoidRootPart["2 Sign"] }
        },
        {
            57,
            { u167.HumanoidRootPart.Turn, u167.HumanoidRootPart["2G"] }
        },
        {
            81,
            { u167.HumanoidRootPart["3"], u167.HumanoidRootPart["4"] }
        }
    }) do
        local v173 = v[1] / 60;

        for _, v2 in v[2] do
            u168:Add(task.delay(v173, shared.vfx.emit, v2));
            local v174 = v173 + vfxUtil.getEmittersLifetime(v2);
            v172 = math.max(v172, v174);
        end;
    end;

    u168:Add(task.delay(v172, function() -- Line: 2384
        -- upvalues: u168 (copy)
        u168:Destroy();
    end));
    u168:Add(task.delay(2.033, function() -- Line: 2388
        -- upvalues: u170 (copy)
        for _, descendant in u170:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;
    end));
    soundUtil:play(yukimiya["gyro shoot Power"], "default");
    soundUtil:play(Parry.ParrySFX, "default");
    u168:Add(task.delay(0.283, function() -- Line: 2399
        -- upvalues: soundUtil (ref), yukimiya (copy)
        soundUtil:play(yukimiya.fake, "default");
    end));
    u168:Add(task.delay(1, function() -- Line: 2403
        -- upvalues: soundUtil (ref), yukimiya (copy), u168 (copy), mainreplication (ref)
        local u175 = soundUtil:play(yukimiya["cut in"], "default", {
            TimePosition = 0.188
        });
        u168:Add(task.delay(0.35, function() -- Line: 2405
            -- upvalues: mainreplication (ref), u175 (copy)
            mainreplication.springcamerashake(20, 30);
            u175.TimePosition = 0.621;
        end));
    end));
    u168:Add(task.delay(0.267, function() -- Line: 2413
        -- upvalues: BackgroundHighlight (ref), u167 (copy), wiki (ref)
        BackgroundHighlight({
            Speed = 1,
            CFrames = true,
            Brightness = 1,
            ImageTransparency = 0.5,
            CountSpeed = 0.08659999999999998,
            Count = 5,
            Whitelist = { u167 },
            BlacklistedParts = { "Ball" },
            Color = wiki.styles.yukimiya.color
        });
    end));
    local u176 = {
        c = u167,
        CurrentCamera = workspace_CurrentCamera,
        Lighting = Lighting
    };
    vfxUtil.contain_lighting(u168, u176, Parry.Lighting);
    local v177 = u168:Construct(MoonPropertyAnimator);
    v177:LoadAndConvertSave(Parry.Moon, u176);
    v177:PlayAll();
    u168:Add(task.delay(1.35, vfxUtil.restore_lighting_properties));
    u168:Add(task.delay(1.35, function() -- Line: 2442
        -- upvalues: mainreplication (ref), u176 (copy)
        mainreplication.ultFlash(1, 0.5);
        u176.Bloom:Destroy();
    end));

    if vfxUtil.isLocalPlayer(u167) then
        mainreplication.destroyVelocity(Root);
        u168:Construct(MoonCFrameTimeline, Parry.CFrame, Parry.Moon):Cast(Root, Vector3.new(1, 1, 0.95652175));
    else
        task.defer(function() -- Line: 2451
            -- upvalues: u176 (copy)
            u176.ColorCorrection.Enabled = false;
        end);
    end;

    mainreplication.springcamerashake(40, 60);
    mainreplication.ultFlash(1, 0.5);
end;

function v1.YukimiyaStealingTheBallOhMyGodHelpMe(u178, p179, p180) -- Line: 2460
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), Util (copy), mainreplication (copy), PlayerGui (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local FlowSteal = vfxUtil.getResources().yukimiya.FlowSteal;
    local v181 = u178.HumanoidRootPart or u178.PrimaryPart;
    local v182 = soundUtil:play(FlowSteal.SFX, soundUtil, {
        Character = u178
    });
    local _ = v182.Name == "Dub";
    local u183 = trove.new();
    u183:AttachToInstance(u178);
    Util.flowCancel(u183, p180, { v182 });
    local Compiled = require(FlowSteal.Compiled);
    local v184 = u183:Add(FlowSteal.Effects:Clone());
    v184.Parent = workspace.Effects;
    local v185 = u183:Construct(FlowSteal.YukimiyaAura);
    vfxUtil.setupAura(u178, v185, true);
    v185.Parent = workspace.Effects;
    local v186 = u183:Construct(FlowSteal.VictimAura);
    local Ball = v186.Ball;
    Ball.Parent = p179;
    Ball.Name = "TheVFXOne";

    if p179:FindFirstChild("Ball") then
        Ball.Parent = p179;
        local v187 = u183:Add(Instance.new("Weld"));
        v187.Part0 = p179:FindFirstChild("HumanoidRootPart");
        v187.Part1 = Ball;
        Ball.Transparency = 1;
    end;

    vfxUtil.setupAura(p179, v186, true);
    v186.Parent = workspace.Effects;
    v184:PivotTo(v181.CFrame);
    mainreplication.sceneEnabled(true);
    u183:Add(function() -- Line: 2501
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    local v188, v189 = mainreplication.cutsceneCamRigWithLetterBox(v181, FlowSteal.CamAnim, FlowSteal.FOV, u178, "default", FlowSteal.CamRig);
    u183:Add(v189);

    for _, child in FlowSteal.UI:GetChildren() do
        u183:Clone(child).Parent = PlayerGui;
    end;

    for _, v in Compiled do
        u183:Add(task.delay(v[1] / 60, v[2], v185, v188, v186, Ball));
    end;

    u183:Add(task.delay(0.506, function() -- Line: 2526
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u178 (copy)
        u183:Add(TekrinnDialogue.Speak(u178, {
            {
                Text = "Keep clear.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.3,
                    Lifetime = 4
                }
            }
        }, 3));
    end));
    u183:Add(task.delay(5.153, function() -- Line: 2552
        -- upvalues: u183 (copy), TekrinnDialogue (ref), u178 (copy)
        u183:Add(TekrinnDialogue.Speak(u178, {
            {
                Text = "I don\'t have much time left.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.025,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 106, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 4
                }
            }
        }, 3));
    end));
    u183:Add(task.delay(6.25, function() -- Line: 2578
        -- upvalues: mainreplication (ref), u183 (copy)
        mainreplication.ultFlash(0.5);
        u183:Destroy();
    end));
    local v190 = {
        Workspace = v184,
        Vignette = u183:Add(vfxUtil.getMoonEffects()).Vignette,
        Lighting = game:GetService("Lighting")
    };

    if FlowSteal:FindFirstChild("Lighting") then
        vfxUtil.cutscene_lighting(u183, v190, FlowSteal.Lighting, {
            Brightness = 2,
            EnvironmentDiffuseScale = 1,
            EnvironmentSpecularScale = 1,
            GlobalShadows = true,
            ShadowSoftness = 1,
            ExposureCompensation = 1,
            ClockTime = 12,
            GeographicLatitude = 201,
            Ambient = Color3.fromRGB(157, 181, 248),
            ColorShift_Top = Color3.fromRGB(2, 2, 2),
            ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
            OutdoorAmbient = Color3.fromRGB(47, 47, 47)
        });
    end;

    MoonPropertyAnimator.ConvertSave(FlowSteal.Moon, v190);
    local v191 = u183:Construct(MoonPropertyAnimator);
    v191:LoadAndConvertSave(FlowSteal.Moon, v190);
    v191:SetOriginalRoot(FlowSteal.Effects.Core.CFrame);
    v191:SetRoot(v181);
    v191:PlayAll();
end;

function v1.yukimiya_swordScrew(p192: vector) -- Line: 2613
    -- upvalues: vfxUtil (copy), workspace_CurrentCamera (copy), trove (copy), actionUtil (copy), LocalPlayer (copy), Lighting (copy), MoonPropertyAnimator (copy), mainreplication (copy)
    local SwordScrew = vfxUtil.getResources().yukimiya.SwordScrew;
    local Position = workspace_CurrentCamera.CFrame.Position;
    local u193 = trove.new();
    local v194 = u193:Clone(SwordScrew.VFX);
    local task_delay = task.delay;
    local EmittersLifetime = vfxUtil.getEmittersLifetime(v194);
    u193:Add(task_delay(math.max(EmittersLifetime, 0.5), function() -- Line: 2622
        -- upvalues: u193 (copy)
        u193:Destroy();
    end));
    v194:PivotTo(CFrame.new(p192, (Vector3.new(Position.X, p192.Y, Position.Z))) * CFrame.Angles(1.5707963267948966, 0, 0));
    v194.Parent = workspace.Effects;
    local v195 = u193:Clone(SwordScrew.ColorCorrection);

    if not actionUtil.checkGK(LocalPlayer.Character) then
        v195.Parent = Lighting;
    end;

    local v196 = u193:Construct(MoonPropertyAnimator);
    v196:LoadAndConvertSave(SwordScrew.Moon, {
        Workspace = v194,
        ColorCorrection = v195
    });
    v196:PlayAll();
    shared.vfx.emit(v194.Ball);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
end;

function v1.yukimiya_swordScrewBurst(p197: vector) -- Line: 2646
    -- upvalues: vfxUtil (copy), trove (copy)
    local SwordScrew = vfxUtil.getResources().yukimiya.SwordScrew;
    local u198 = trove.new();
    u198:Add(task.delay(vfxUtil.getEmittersLifetime(SwordScrew.Burst), function() -- Line: 2650
        -- upvalues: u198 (copy)
        u198:Destroy();
    end));
    local v199 = u198:Clone(SwordScrew.Burst);
    v199:PivotTo(CFrame.new(p197));
    v199.Parent = workspace.Effects;
    shared.vfx.emit(v199);
end;

local u200 = {
    Front = 45,
    Left = 35,
    Right = 30,
    Back = 30
};
local u201 = {
    [4] = 35,
    [3] = 25,
    [2] = 35,
    [1] = 25
};

function v1.yukimiya_breakthrough(u202: any, u203: string, p204: number) -- Line: 2675
    -- upvalues: vfxUtil (copy), u156 (copy), Lighting (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy), MoonCFrameTimeline (copy), u201 (copy), u200 (copy), mainreplication (copy), ReplicatedStorage (copy), TweenService (copy)
    local FullBreakthrough = vfxUtil.getResources().yukimiya.FullBreakthrough;
    local Root = vfxUtil.getRoot(u202);
    local u205 = vfxUtil.character_trove(u202);
    u205:Connect(u202:GetAttributeChangedSignal("last_breakthrough"), function() -- Line: 2680
        -- upvalues: u202 (copy), u203 (copy), u205 (copy)
        if u202:GetAttribute("last_breakthrough") ~= u203 then
            u205:Destroy();
        end;
    end);

    if u156[u202] then
        u156[u202]:Destroy();
    end;

    local v206, u207 = vfxUtil.buildFromRig(u202, FullBreakthrough.Rig);
    u156[u202] = v206;
    v206:Add(function() -- Line: 2692
        -- upvalues: u156 (ref), u202 (copy)
        u156[u202] = nil;
    end);
    u205:Add(v206);
    local u208 = u205:Clone(FullBreakthrough.VFX);
    u208:PivotTo(u202:GetPivot());
    u208.Parent = workspace.Effects;
    u205:Add(task.delay(0.45, function() -- Line: 2701
        -- upvalues: u207 (copy), u205 (copy), vfxUtil (ref), u208 (copy)
        for _, descendant in u207:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;

        u205:Add(task.delay(vfxUtil.getEmittersLifetime(u208), function() -- Line: 2707
            -- upvalues: u205 (ref)
            u205:Destroy();
        end));
    end));
    local v209 = u205:Clone(FullBreakthrough.ColorCorrection);
    v209.Parent = Lighting;
    local u210 = {
        ColorCorrection = v209,
        Highlight = u207.Highlight,
        CurrentCamera = workspace_CurrentCamera
    };
    local v211 = u205:Construct(MoonPropertyAnimator);
    v211:LoadAndConvertSave(FullBreakthrough.Moon, u210);
    v211:PlayAll();

    if vfxUtil.isLocalPlayer(u202) then
        u205:Construct(MoonCFrameTimeline, FullBreakthrough.Directions[u203].CFrame, FullBreakthrough.Moon):Cast(Root, Vector3.new(1, 1, 1) * ((u201[p204] or u201[4]) / u200[u203]));
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(30, 40);
        local v212 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v212.Parent = Lighting;
        v212.TintColor = Color3.fromRGB(255, 117, 37);
        v212.Brightness = 0.4;
        v212.Contrast = 1;
        v212.Saturation = -0.4;
        TweenService:Create(v212, TweenInfo.new(0.75, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v212, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v212.Destroy, v212);
    else
        task.defer(function() -- Line: 2746
            -- upvalues: u210 (copy)
            u210.ColorCorrection.Enabled = false;
        end);
    end;

    shared.vfx.emit(u208.HumanoidRootPart[`{u203}Grass`], u208[`{u203}DashGlowFX`]);

    if u207.Dash then
        shared.vfx.emit(u207.Dash);
    end;
end;

function v1.yukimiya_lightningRush(u213, u214, p215) -- Line: 2757
    -- upvalues: vfxUtil (copy), u156 (copy), workspace_CurrentCamera (copy), MoonPropertyAnimator (copy), MoonCFrameTimeline (copy)
    local LightningRush = vfxUtil.getResources().yukimiya.LightningRush;
    local Root = vfxUtil.getRoot(u213);
    local Ball = u213:FindFirstChild("Ball");
    local u216 = vfxUtil.character_trove(u213);
    u216:Connect(p215.Changed, function(p217) -- Line: 2763
        -- upvalues: Ball (ref), u216 (copy)
        if p217 then
            if Ball then
                Ball.Transparency = 0;
            end;

            u216:Destroy();
        end;
    end);

    if u156[u213] then
        u156[u213]:Destroy();
    end;

    local v218, u219 = vfxUtil.buildFromRig(u213, LightningRush.Rig);
    u156[u213] = v218;
    v218:Add(function() -- Line: 2778
        -- upvalues: u156 (ref), u213 (copy)
        u156[u213] = nil;
    end);
    u216:Add(v218);
    u216:Add(task.delay(2.683 / u214, function() -- Line: 2783
        -- upvalues: u219 (copy), u216 (copy), u214 (copy), Ball (ref)
        for _, descendant in u219:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;

        u216:Add(task.delay(3 / u214, function() -- Line: 2789
            -- upvalues: u216 (ref)
            u216:Destroy();
        end));

        if Ball then
            Ball.Transparency = 0;
        end;

        u219["azl ballllllls_rig"].Ball.Transparency = 1;
    end));

    if Ball then
        Ball.Transparency = 1;
    else
        u219["azl ballllllls_rig"].Ball.Transparency = 1;
        u216:Connect(u213.ChildAdded, function(p220) -- Line: 2800
            -- upvalues: Ball (ref), u219 (copy)
            if p220.Name == "Ball" then
                Ball = p220;
                p220.Transparency = 1;
                u219["azl ballllllls_rig"].Ball.Transparency = 0;
            end;
        end);
    end;

    local v221 = {
        Highlight = u219.Highlight,
        CurrentCamera = workspace_CurrentCamera
    };
    vfxUtil.contain_lighting(u216, v221, LightningRush.Lighting);
    local v222 = u216:Construct(MoonPropertyAnimator);
    v222:LoadAndConvertSave(LightningRush.Moon, v221);
    v222:PlayAll();

    if vfxUtil.isLocalPlayer(u213) then
        u216:Construct(MoonCFrameTimeline, LightningRush.CFrame, LightningRush.Moon):Cast(Root, Vector3.new(1, 1, 1.35), nil, function(p223) -- Line: 2823
            -- upvalues: u214 (copy)
            return p223 * u214;
        end);
    else
        for _, v in { "ColorCorrection", "Blur" } do
            v221[v].Enabled = false;
        end;
    end;

    vfxUtil.execute_compiled_ex(LightningRush.Compiled, u216, 60 * u214, u213);
end;

function v1.yukimiya_razor_break(u224: any, u225: string, u226: any) -- Line: 2835
    -- upvalues: vfxUtil (copy), u156 (copy), soundUtil (copy), MoonPropertyAnimator (copy), mainreplication (copy), MoonCFrameTimeline (copy), Players (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy)
    local RazorBreak = vfxUtil.getResources().yukimiya.RazorBreak;
    local Root = vfxUtil.getRoot(u224);
    local u227 = vfxUtil.character_trove(u224);
    u227:Connect(u224:GetAttributeChangedSignal("razor_breaks"), function() -- Line: 2840
        -- upvalues: u224 (copy), u225 (copy), u227 (copy)
        if u224:GetAttribute("razor_breaks") ~= u225 then
            u227:Destroy();
        end;
    end);

    if u156[u224] then
        u156[u224]:Destroy();
    end;

    local v228, u229 = vfxUtil.buildFromRig(u224, RazorBreak.Rig);
    u156[u224] = v228;
    v228:Add(function() -- Line: 2852
        -- upvalues: u156 (ref), u224 (copy)
        u156[u224] = nil;
    end);
    u227:Add(v228);
    local u230 = u227:Clone(RazorBreak.VFX);
    u230:PivotTo(u224:GetPivot());
    u230.Parent = workspace.Effects;
    soundUtil:play(u225 == "Front" and RazorBreak.Sounds.Dash2 or RazorBreak.Sounds.Dash1, Root);
    u227:Add(task.delay(0.55 / u226, function() -- Line: 2863
        -- upvalues: u229 (copy), u227 (copy), vfxUtil (ref), u230 (copy)
        for _, descendant in u229:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;

        u227:Add(task.delay(vfxUtil.getEmittersLifetime(u230), function() -- Line: 2869
            -- upvalues: u227 (ref)
            u227:Destroy();
        end));
    end));
    local v231 = {
        Highlight = u229.Highlight
    };
    local v232 = u227:Construct(MoonPropertyAnimator);
    v232:LoadAndConvertSave(RazorBreak.Moon, v231);
    v232:PlayAll();

    if vfxUtil.isLocalPlayer(u224) then
        mainreplication.destroyVelocity(Root, false);
        Root.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        local v233 = Vector3.new(1, 1, 1);

        if u225 == "Front" then
            v233 = Vector3.new(v233.X, v233.Y, 0.6);
        elseif u225 == "Back" then
            v233 = Vector3.new(v233.X, v233.Y, 1.05);
        end;

        u227:Construct(MoonCFrameTimeline, RazorBreak.Directions[u225].CFrame, RazorBreak.Moon):Cast(Root, v233, nil, function(p234, p235) -- Line: 2891
            -- upvalues: u225 (copy), u226 (copy)
            if u225 ~= "Front" and p235 > 0.25 then
                p234 = p234 * 1.3;
            end;

            return p234 * u226;
        end);
    end;

    if u225 ~= "Front" then
        u227:Add(task.delay(0.25 / u226, function() -- Line: 2900
            -- upvalues: u229 (copy), Players (ref), u224 (copy), mainreplication (ref), u226 (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref)
            for _, descendant in u229:GetDescendants() do
                if descendant:IsA("Attachment") and descendant.Name == "Dash" then
                    shared.vfx.emit(descendant);
                end;
            end;

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(u224) then
                mainreplication.fov(false, 80);
                mainreplication.fov(true, 70, 0.4166666666666667 / u226, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                mainreplication.springcamerashake(20, 30);
                local v236 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v236.Parent = Lighting;
                v236.TintColor = Color3.fromRGB(255, 116, 46);
                v236.Brightness = 0.4;
                v236.Contrast = 1;
                v236.Saturation = -0.4;
                TweenService:Create(v236, TweenInfo.new(0.75 / u226, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v236, TweenInfo.new(1 / u226, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2 / u226, v236.Destroy, v236);
            end;
        end));

        return;
    end;

    for _, descendant in u229:GetDescendants() do
        if descendant:IsA("Attachment") and descendant.Name == "Dash" then
            shared.vfx.emit(descendant);
        end;
    end;

    u227:Add(task.delay(0.43333333333333335 / u226, function() -- Line: 2932
        -- upvalues: u229 (copy)
        for _, descendant in u229:GetDescendants() do
            if descendant:IsA("Attachment") and descendant.Name == "Dash" then
                shared.vfx.emit(descendant);
            end;
        end;

        for _, descendant in u229:GetDescendants() do
            if descendant:IsA("Attachment") and descendant.Name == "Spin" then
                shared.vfx.emit(descendant);
            end;
        end;
    end));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u224) then
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.4166666666666667 / u226, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(20, 30);
        local v237 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v237.Parent = Lighting;
        v237.TintColor = Color3.fromRGB(255, 116, 46);
        v237.Brightness = 0.4;
        v237.Contrast = 1;
        v237.Saturation = -0.4;
        TweenService:Create(v237, TweenInfo.new(0.75 / u226, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v237, TweenInfo.new(1 / u226, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2 / u226, v237.Destroy, v237);
    end;
end;

function v1.yukimiya_nioEye(p238: any, p239: userdata) -- Line: 2965
    -- upvalues: vfxUtil (copy), soundUtil (copy), trove (copy), mainreplication (copy), actionUtil (copy), wiki (copy), LocalPlayer (copy), TrajectoryPreview (copy)
    local PredatorEye = vfxUtil.getResources().yukimiya.PredatorEye;
    local Head = p238:FindFirstChild("Head");
    local HumanoidRootPart = p238:FindFirstChild("HumanoidRootPart");
    local u240 = vfxUtil.isLocalPlayer(p238);
    soundUtil:play(PredatorEye.Sound, u240 and "default" or Head);
    local v241 = trove.new();
    v241:AttachToInstance(p238);
    v241:AttachToInstance(p239);
    v241:Add(function() -- Line: 2977
        -- upvalues: u240 (copy), mainreplication (ref)
        if u240 then
            mainreplication.ultFlash(0.5);
        end;
    end);
    local u242 = v241:Clone(PredatorEye.eye_flame);
    u242.Weld.Part0 = Head;
    u242.Parent = Head;
    v241:Connect(actionUtil.getworkspace().disabled.Changed, function(p243) -- Line: 2987
        -- upvalues: u242 (copy)
        for _, descendant in u242.Attachment:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = not p243;
            end;
        end;
    end);
    vfxUtil.emitAll(u242);

    if u240 then
        vfxUtil.flash(wiki.styles.yukimiya.color, 0.5);
    end;

    if LocalPlayer and LocalPlayer.Character == p238 then
        TrajectoryPreview.Preview(p238, {
            {
                nil,
                120.7125,
                "left",

                function(p244: vector) -- Line: 3002, Name: predatorEyeDirection
                    -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy)
                    local v245 = LocalPlayer and (LocalPlayer:FindFirstChild("setting") and LocalPlayer.setting:FindFirstChild("camAim")) and LocalPlayer.setting.camAim.Value;
                    local math_clamp_ret = math.clamp(p244.Y, v245 and 0.15 or 0.23, 1);
                    local LookVector = HumanoidRootPart.CFrame.LookVector;

                    return Vector3.new(LookVector.X, math_clamp_ret, LookVector.Z).Unit;
                end,

                nil,
                nil,
                0.005833333333333333
            },
            true,
            true,
            nil,
            nil,
            1.215,
            nil,
            nil,
            0.25,
            3
        }, v241, {
            lineColor = Color3.fromRGB(255, 85, 0)
        });
    end;
end;

function v1.yukimiya_pacifistShot(u246) -- Line: 3033
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), PlayerGui (copy), MoonPropertyAnimator (copy), TekrinnDialogue (copy)
    local PacifistShot = vfxUtil.getResources().yukimiya.PacifistShot;
    local Root = vfxUtil.getRoot(u246);
    local Ball = u246:FindFirstChild("Ball");
    local u247 = soundUtil:play(PacifistShot.Sound, "default", {
        Character = u246
    }).Name == "Dub";
    mainreplication.sceneEnabled(true);
    local u248 = trove.new();
    u248:AttachToInstance(u246);
    u248:Add(function() -- Line: 3043
        -- upvalues: Ball (copy), mainreplication (ref)
        if Ball then
            Ball.Transparency = 0;
            Ball.Name = "Ball";
        end;

        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1);
    end);
    u248:Add(task.delay(8.167, function() -- Line: 3052
        -- upvalues: u248 (copy)
        u248:Destroy();
    end));
    local v249 = u248:Clone(PacifistShot.VFX);
    v249:PivotTo(u246:GetPivot());
    vfxUtil.setupAura(u246, v249.TemplateR6, true, true);
    local v250 = u248:Add(v249.TemplateR6["azl ballllllls_rig"]);
    v250.Ball.ball.Part0 = Root;
    v250.Parent = u246;
    v249.Parent = workspace.Effects;

    if Ball then
        Ball.Transparency = 1;
        Ball.Name = "Temp";
    end;

    local MoonEffects = vfxUtil.getMoonEffects();
    u248:Add(MoonEffects);
    local _, v251 = mainreplication.cutsceneCamRigWithLetterBox(Root, PacifistShot.CamAnimation, PacifistShot.FOV, u246, "default", PacifistShot.Cam, "CamPart");
    u248:Add(v251);
    local v252 = {
        Workspace = v249,
        Vignette = MoonEffects.Vignette
    };

    for _, child in PacifistShot.UI:GetChildren() do
        u248:Clone(child).Parent = PlayerGui;
    end;

    vfxUtil.cutscene_lighting(u248, v252, PacifistShot.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 1,
        ClockTime = 12,
        GeographicLatitude = 201,
        Ambient = Color3.new(0.615686, 0.709804, 0.972549),
        ColorShift_Bottom = Color3.new(0.00784314, 0.00784314, 0.00784314),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v253 = u248:Construct(MoonPropertyAnimator);
    v253:LoadAndConvertSave(PacifistShot.Moon, v252);
    v253:SetOriginalRoot(PacifistShot.VFX:GetPivot());
    v253:SetRoot(Root);
    v253:PlayAll();
    vfxUtil.execute_compiled(PacifistShot.Compiled, u248, v249, v250);
    u248:Add(task.delay(0.368, function() -- Line: 3105
        -- upvalues: u248 (copy), TekrinnDialogue (ref), u246 (copy), u247 (copy)
        u248:Add(TekrinnDialogue.Speak(u246, {
            {
                TypeSpeed = 0.03,
                Text = u247 and "Didn\'t you know? I\'m a pacifist you see.." or "It\'ll all resolve peacefully if I score.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 3));
    end));

    if u247 then
        u248:Add(task.delay(4.665, function() -- Line: 3122
            -- upvalues: u248 (copy), TekrinnDialogue (ref), u246 (copy)
            u248:Add(TekrinnDialogue.Speak(u246, {
                {
                    Text = "We can resolve this peacefully if I just score.",
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
                }
            }, 3));
        end));

        return;
    end;

    u248:Add(task.delay(4.665, function() -- Line: 3139
        -- upvalues: u248 (copy), TekrinnDialogue (ref), u246 (copy)
        u248:Add(TekrinnDialogue.Speak(u246, {
            {
                Text = "I\'m a ",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "pacifist",
                Bold = true,
                TypeSpeed = 0.05,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) })
            },
            {
                Text = ".",
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
end;

function v1.yukimiya_overtime(u254, p255, p256, p257) -- Line: 3180
    -- upvalues: vfxUtil (copy), soundUtil (copy), mainreplication (copy), trove (copy), Util (copy), PlayerGui (copy), MoonPropertyAnimator (copy), LocalPlayer (copy), animationUtil (copy), TekrinnDialogue (copy)
    local Overtime = vfxUtil.getResources().yukimiya.Overtime;
    local Root = vfxUtil.getRoot(u254);
    local v258 = soundUtil:play(Overtime.Sound, "default", {
        Character = u254
    });
    local u259 = v258.Name == "Dub";
    mainreplication.sceneEnabled(true);
    local u260 = false;
    local u261 = trove.new();
    u261:AttachToInstance(u254);
    u261:Add(function() -- Line: 3192
        -- upvalues: mainreplication (ref), u260 (ref)
        mainreplication.sceneEnabled(false);
        u260 = true;
    end);
    Util.flowCancel(u261, p257.FlowCancel, { v258 });
    u261:Add(task.delay(19.35, function() -- Line: 3203
        -- upvalues: u261 (copy)
        u261:Destroy();
    end));
    task.delay(18.35, function() -- Line: 3207
        -- upvalues: u260 (ref), mainreplication (ref)
        if not u260 then
            mainreplication.newblackscene(1, 2, 1);
        end;
    end);
    u261:Add(Util.Preload(Overtime.Blindness));
    u261:Add(task.delay(5.666666666666667, function() -- Line: 3214
        -- upvalues: Util (ref), Overtime (copy)
        Util.Gif(Overtime.Blindness, 24);
    end));
    local v262 = u261:Clone(Overtime.VFX);
    v262:PivotTo(u254:GetPivot());
    vfxUtil.setupAura(u254, v262["azlball\'"], true, true);
    v262.Parent = workspace.Effects;
    local MoonEffects = vfxUtil.getMoonEffects();
    u261:Add(MoonEffects);
    local v263, v264 = mainreplication.cutsceneCamRigWithLetterBox(Root, Overtime.CamAnimation, Overtime.FOV, u254, "default", Overtime.Cam, "CamPart");
    u261:Add(v264);
    u261:Clone(Overtime.Bars).Parent = PlayerGui;
    local v265 = {
        Workspace = v262,
        Vignette = MoonEffects.Vignette,
        ["Screen Cover"] = MoonEffects["Screen Cover"]
    };
    vfxUtil.cutscene_lighting(u261, v265, Overtime.Lighting, {
        EnvironmentDiffuseScale = 1,
        EnvironmentSpecularScale = 1,
        ExposureCompensation = 1,
        ClockTime = 12,
        GeographicLatitude = 201,
        Ambient = Color3.new(0.615686, 0.709804, 0.972549),
        ColorShift_Bottom = Color3.new(0, 0, 0),
        ColorShift_Top = Color3.new(0, 0, 0),
        OutdoorAmbient = Color3.new(0.184314, 0.184314, 0.184314)
    });
    local v266 = u261:Construct(MoonPropertyAnimator);
    v266:LoadAndConvertSave(Overtime.Moon, v265);
    v266:SetOriginalRoot(Overtime.VFX:GetPivot());
    v266:SetRoot(Root);
    v266:PlayAll();
    vfxUtil.execute_compiled(Overtime.Compiled, u261, v262, v263);
    u261:Add(task.delay(11.383, function() -- Line: 3260
        -- upvalues: vfxUtil (ref), Root (copy), LocalPlayer (ref), u254 (copy), u261 (copy), animationUtil (ref), Overtime (copy)
        for i = 1, 4 do
            local u267 = vfxUtil.newRigForFriend(Root, LocalPlayer);
            u267:PivotTo(u254:GetPivot());
            u267.Parent = workspace.Effects;
            u261:Add(u267);
            task.spawn(function() -- Line: 3266
                -- upvalues: animationUtil (ref), u267 (copy), Overtime (ref), i (copy)
                local v268 = animationUtil:loadAnimation(u267, Overtime[`VictimAnimation{i}`]);
                v268:Play(0);
                v268.TimePosition = 11.383;
            end);
            u261:Add(task.delay(1.1170000000000009, function() -- Line: 3272
                -- upvalues: vfxUtil (ref), u267 (copy), Overtime (ref), u261 (ref)
                local v269, u270 = vfxUtil.buildFromRig(u267, Overtime.ShadowAura);
                u261:Add(v269);
                u261:Add(task.delay(1.7669999999999995, function() -- Line: 3275
                    -- upvalues: u270 (copy)
                    for _, descendant in u270:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;
                end));

                for _, descendant in u270:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") and descendant.Rate > 1 then
                        descendant.Rate = math.max(descendant.Rate / 4, 1);
                    end;
                end;
            end));
            local _ = i;
        end;
    end));
    u261:Add(task.delay(0.531, function() -- Line: 3291
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy), u259 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Italic = true,
                TypeSpeed = 0.04,
                Text = u259 and "Now, to determine a suitable " or "I need to set up a proper ",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            },
            {
                Text = "objective",
                Italic = true,
                TypeSpeed = 0.055,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 170, 0)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 2
                }
            },
            {
                Text = "..",
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 5));
    end));
    u261:Add(task.delay(3.218, function() -- Line: 3333
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Text = "?!..",
                Bold = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 1
                }
            }
        }, 1));
    end));
    u261:Add(task.delay(7.121, function() -- Line: 3353
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Text = "No, not yet..!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 3.5,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u261:Add(task.delay(8.827, function() -- Line: 3372
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Text = "Crank it up a gear!",
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u261:Add(task.delay(10.206, function() -- Line: 3391
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy), u259 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                TypeSpeed = 0.02,
                Text = u259 and "It\'s do or die, so find it!" or "It\'s now or never, so find it!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 106, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) }),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2
                }
            }
        }, 5));
    end));
    u261:Add(task.delay(13.061, function() -- Line: 3410
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy), u259 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Italic = true,
                TypeSpeed = 0.02,
                Text = u259 and "So this is what it feels like.." or "So this sensation is..",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 5));
    end));
    u261:Add(task.delay(16.799, function() -- Line: 3428
        -- upvalues: u261 (copy), TekrinnDialogue (ref), u254 (copy)
        u261:Add(TekrinnDialogue.Speak(u254, {
            {
                Text = "\"..the flow.\"",
                Bold = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) })
            }
        }, 2));
    end));
end;

function v1.fakeoutend(p271) -- Line: 3447
    -- upvalues: UwUEffects (copy), Players (copy), mainreplication (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), RunService (copy)
    local HumanoidRootPart = p271:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    UwUEffects.createEffect({
        Character = p271
    }, "YukiCutInCounter", nil);

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p271) then
        mainreplication.fov(false, 30);
        mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication.springcamerashake(30, 60);
        local v272 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v272.Parent = Lighting;
        v272.TintColor = Color3.fromRGB(0, 255, 140);
        v272.Brightness = 0.4;
        v272.Contrast = 1;
        v272.Saturation = -0.4;
        TweenService:Create(v272, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v272, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v272.Destroy, v272);
    end;

    mainreplication.destroyVelocity(HumanoidRootPart);
    local u273, _, u274 = mainreplication.bodyVelocity(HumanoidRootPart, 65.55, 0.955, nil, nil, true);

    if u273 then
        local u275 = 0.215;
        local os_clock_ret = os.clock();
        u274 = RunService.PreRender:Connect(function(p276) -- Line: 3482
            -- upvalues: u273 (copy), u274 (ref), os_clock_ret (copy), u275 (ref), HumanoidRootPart (copy)
            if not u273.Parent then
                u274:Disconnect();
            end;

            if os.clock() - os_clock_ret > 0.1 then
                u275 = u275 + p276;
            end;

            local v277 = math.clamp(u275 / 0.75, 0, 0.85) ^ 2 * 3.141592653589793 * 0.75;
            local v278 = -HumanoidRootPart.CFrame.RightVector;
            local LookVector = HumanoidRootPart.CFrame.LookVector;
            local math_cos_ret = math.cos(v277);
            local math_sin_ret = math.sin(v277);
            u273.Velocity = (v278 * math_cos_ret + LookVector * math_sin_ret).Unit * 65.55;
        end);
    end;
end;

return v1;
 
 

game:GetService("CollectionService");
game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("ServerStorage");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("TweenService");
game:GetService("UserInputService");
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local _ = Lighting.Atmosphere.Decay;
local _ = Lighting.Atmosphere.Haze;
local _ = Lighting.Atmosphere.Glare;
local _ = Lighting.Atmosphere.Offset;
local _ = Lighting.GeographicLatitude;
local Brightness = Lighting.Brightness;
local ClockTime = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local OutdoorAmbient = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;
local _ = Lighting.Bloom.Intensity;
local _ = Lighting.Bloom.Size;
require(ReplicatedStorage.MeshEmit2);
require(ReplicatedStorage.client.replication.MeshEmitter);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
require(ReplicatedStorage.Temp);
require(ReplicatedStorage.VfxHandler);
require(ReplicatedStorage.Welder);
require(ReplicatedStorage.util.animationUtil);
local mainreplication = require(script.Parent.Parent.mainreplication);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(script.Parent.aikuVFX.xamillmesh);
local camerasreplication = require(script.Parent.camerasreplication);
local Util = require(ReplicatedStorage.util.Util);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
require(ReplicatedStorage.util.KatUtil);
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local _ = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local BackgroundHighlight = require(script.Parent.Parent.BackgroundHighlight);

function v1.characterImage(p2) -- Line: 65
    -- upvalues: BackgroundHighlight (copy)
    BackgroundHighlight(p2);
end;

local u3 = {};

local function GetVFX(p4: userdata, p5: userdata, p6: number, p7: boolean) -- Line: 69
    -- upvalues: Debris (copy), u3 (copy)
    local v8 = p5:Clone();
    local v9 = p5.Parent:FindFirstChild(p5:GetAttribute("WeldName") and p5:GetAttribute("WeldName") or p5.Name .. "Weld");

    if v9 then
        local v10 = v9:Clone();

        if p5.Name ~= "Part" then
            v10.Name = p5.Name;
        end;

        v10.Parent = v8;
        v10.Part0 = p4;
        v10.Part1 = v8;
    end;

    if p6 then
        Debris:AddItem(v8, p6);
    end;

    if p7 then
        u3[v8.Name] = v8;
    end;

    v8.Parent = p4;

    return v8;
end;

function GrabSavedVFX(p11: string)
    -- upvalues: u3 (copy)
    return u3[p11];
end;

local function CreateVFXTimeline(p12: userdata, p13: table, p14: function, p15: number) -- Line: 95
    -- upvalues: GetVFX (copy)
    for i, v in p13 do
        if p14 and not p14() then
            local v16 = v;
            local v17 = i;

            for _, child in p12:GetChildren() do
                if child.Name == v17 then
                    v16:Destroy();
                end;
            end;

            return;
        end;

        local u18 = GetVFX(p12, i, p15 or 5);

        for _, v2 in v do
            task.delay(v2, function() -- Line: 109
                -- upvalues: u18 (copy)
                for _, descendant in u18:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end);
        end;
    end;
end;

local function emit(p19: userdata, p20: boolean?, p21: boolean?) -- Line: 120
    for _, descendant in p19:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            if p20 and not string.find(descendant.Name, "grass") then
                descendant.LockedToPart = true;
            end;

            if descendant:GetAttribute("EmitDelay") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 128
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
                end);
            else
                descendant:Emit(descendant:GetAttribute("EmitCount") or 10);
            end;
        end;
    end;
end;

local function enableall(u22, p23, p24) -- Line: 138
    if not u22 then
        return;
    end;

    for _, descendant in pairs(u22:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    if p23 then
        for _, descendant in pairs(u22:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 150
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        return;
    end;

    task.delay(p24, function() -- Line: 156
        -- upvalues: u22 (copy)
        if not u22 then
            return;
        end;

        for _, descendant in pairs(u22:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local function emit2(p25) -- Line: 169
    for _, descendant in pairs(p25:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local u26 = descendant:GetAttribute("EmitCount") or 10;
            local u27 = descendant:GetAttribute("EmitDuration") or 0;
            local v28 = descendant:GetAttribute("EmitDelay") or 0;
            task.delay(v28, function() -- Line: 176
                -- upvalues: u27 (copy), descendant (copy), u26 (copy)
                if u27 <= 0 then
                    descendant:Emit(u26);

                    return;
                end;

                descendant.Enabled = true;
                task.delay(u27, function() -- Line: 179
                    -- upvalues: descendant (ref)
                    descendant.Enabled = false;
                end);
            end);
        end;
    end;
end;

local function u30() -- Line: 190
    -- upvalues: Lighting (copy)
    local v29 = {};

    for _, child in Lighting:GetChildren() do
        table.insert(v29, child:Clone());
        child:Destroy();
    end;

    return v29;
end;

function v1.HelloKunigamiHelloIsagiSDhootBall(u31, u32, p33) -- Line: 201
    -- upvalues: ReplicatedStorage (copy), LocalPlayer (copy), vfxUtil (copy), camerasreplication (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), Lighting (copy), u30 (copy), CreateVFXTimeline (copy), TekrinnDialogue (copy), Ambient (copy), Brightness (copy), OutdoorAmbient (copy), ClockTime (copy), ExposureCompensation (copy)
    local v34 = u31.HumanoidRootPart or u31.PrimaryPart;
    local v35 = u32.HumanoidRootPart or u32.PrimaryPart;
    local Ball = u31:FindFirstChild("Ball");

    if require(ReplicatedStorage.util.actionUtil).checkGK(LocalPlayer.Character) then
        return;
    end;

    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u36 = camerasreplication.KuniCamera(v34, ReplicatedStorage.Resources.kunigami.AutoGoalFOV);
    mainreplication.sceneEnabled(true);
    local u37 = soundUtil:play(ReplicatedStorage.Resources.kunigami.chem.kunigamiauto, SoundService, {
        Character = u31
    });
    Util.Preload(ReplicatedStorage.Resources.kunigami.ImpactFrame1);
    task.delay(12.72, function() -- Line: 220
        -- upvalues: Util (ref), ReplicatedStorage (ref)
        print("?");
        Util.Gif(ReplicatedStorage.Resources.kunigami.ImpactFrame1, 30);
    end);
    local u38 = ReplicatedStorage.Resources.kunigami.MetaVis:Clone();
    u38.Parent = u32.Head;
    local u39 = ReplicatedStorage.Resources.kunigami.chem.KuniEye:Clone();
    u39.Parent = u31.Head;
    Lighting.Ambient = Color3.fromRGB(187, 205, 217);
    Lighting.Brightness = 2;
    Lighting.OutdoorAmbient = Color3.fromRGB(70, 70, 70);
    Lighting.ClockTime = -12;
    Lighting.ExposureCompensation = 1.5;
    local u40 = u30();
    local u41 = {};
    local u42 = {};
    local u43 = {};

    for _, child in ReplicatedStorage.Resources.kunigami.chem.lightning:GetChildren() do
        child:Clone().Parent = Lighting;
    end;

    local u44 = ReplicatedStorage.Resources.kunigami.chem.IsagiBall:Clone();
    local u45 = ReplicatedStorage.Resources.kunigami.chem.KuniBall:Clone();
    u45.Parent = Ball;
    u44.Parent = Ball;
    local u46 = ReplicatedStorage.Resources.kunigami.chem.Run:Clone();
    local u47 = ReplicatedStorage.Resources.kunigami.chem.Run2:Clone();
    u46.CFrame = v34.CFrame * CFrame.new(-18, 0, -40);
    u47.CFrame = v34.CFrame * CFrame.new(-18, 10, -60);
    u46.Parent = workspace.Effects;
    u47.Parent = workspace.Effects;
    local Weld = Instance.new("Weld");
    Weld.Part0 = Ball;
    Weld.Part1 = u45;
    Weld.Parent = Ball;
    local Weld2 = Instance.new("Weld");
    Weld2.Part0 = Ball;
    Weld2.Part1 = u44;
    Weld2.Parent = Ball;
    local u48 = ReplicatedStorage.Resources.kunigami.raining:Clone();
    u48.Parent = workspace.Effects;
    u48.stff.CFrame = u32.Torso.CFrame * CFrame.new(0, 5, 0);
    local u49 = ReplicatedStorage.Resources.kunigami.chem.BodyWind:Clone();
    u49.Parent = v35;
    CreateVFXTimeline(Ball, {
        [ReplicatedStorage.Resources.kunigami.chem.IsagiKick] = { 5.466666666666667 }
    });
    CreateVFXTimeline(v34, {
        [ReplicatedStorage.Resources.kunigami.chem.Kick] = { 8.45, 13.2 }
    });
    CreateVFXTimeline(v35, {
        [ReplicatedStorage.Resources.kunigami.chem.Aim] = { 6.3 }
    });
    task.delay(6.1, function() -- Line: 303
        -- upvalues: u36 (copy)
        u36.CameraGlow.CameraGlowB.Enabled = true;
        u36.CameraGlow.CameraGlowO.Enabled = true;
    end);
    task.delay(4.766666666666667, function() -- Line: 310
        -- upvalues: Lighting (ref)
        Lighting.IsagiKick.Enabled = true;
        task.wait(0.2);
        Lighting.IsagiKick.Enabled = false;
    end);
    task.delay(5.45, function() -- Line: 316
        -- upvalues: Lighting (ref)
        Lighting.IsagiKick.Enabled = true;
        task.wait(0.2);
        Lighting.IsagiKick.Enabled = false;
    end);

    for _, child in ipairs(u32:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v50 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.kunigami.chem.isagiAura:GetChildren()) do
                local v51 = child2:Clone();
                v51.Parent = v50;
                v51.Enabled = false;
                table.insert(u41, v51);
            end;
        end;
    end;

    for _, child in ipairs(p33:GetChildren()) do
        if child:IsA("Part") and child.Transparency < 1 then
            local v52 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.kunigami.chem.mainfodderaura:GetChildren()) do
                local v53 = child2:Clone();
                v53.Parent = v52;
                v53.Enabled = false;
                table.insert(u42, v53);
            end;
        end;
    end;

    for _, child in ipairs(u31:GetChildren()) do
        if child:IsA("Part") and (child.Transparency < 1 and child.Name ~= "Cam") then
            local v54 = child;

            for _, child2 in ipairs(ReplicatedStorage.Resources.kunigami.chem.kuniAura:GetChildren()) do
                local v55 = child2:Clone();
                v55.Parent = v54;
                v55.Enabled = false;
                table.insert(u43, v55);
            end;
        end;
    end;

    task.delay(u37.Name == "Dub" and 0.1 or 2.7, function() -- Line: 358
        -- upvalues: TekrinnDialogue (ref), u32 (copy), u37 (copy)
        TekrinnDialogue.Speak(u32, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = u37.Name == "Dub" and "No, you\'re still in control!" or "It\'s his territory!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    task.delay(2.5, function() -- Line: 384
        -- upvalues: u37 (copy), TekrinnDialogue (ref), u32 (copy), u31 (copy)
        if u37.Name == "Dub" then
            TekrinnDialogue.Speak(u32, {
                {
                    Text = "That\'s the domain... of",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                },
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.03,
                    Text = ` {u31.Name}!`,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 53, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 85, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 6
                    }
                }
            }, 2);
        end;
    end);
    task.delay(8.6, function() -- Line: 433
        -- upvalues: TekrinnDialogue (ref), u31 (copy), u37 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Text = u37.Name == "Dub" and "We\'ll crush all of you!" or "We\'re not done yet...!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 3,
                    Lifetime = 6
                }
            },
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = u37.Name == "Dub" and " ATTACKING IN WAVES!" or " We\'re going to crush all of you!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 85, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 6
                }
            }
        }, 3);
    end);
    task.delay(0.01, function() -- Line: 480
        -- upvalues: u49 (copy)
        for _, descendant in u49:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.6, function() -- Line: 488
        -- upvalues: u41 (copy)
        for _, v in u41 do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(2.65, function() -- Line: 496
        -- upvalues: u42 (copy)
        for _, v in u42 do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(3.5, function() -- Line: 504
        -- upvalues: u38 (copy)
        for _, child in u38:GetChildren() do
            if child:IsA("ParticleEmitter") or child:IsA("Beam") then
                child.Enabled = true;
            end;
        end;
    end);
    task.delay(4.8, function() -- Line: 512
        -- upvalues: u36 (copy), u44 (copy)
        for _, child in u36.CEffe:GetChildren() do
            if child:IsA("ParticleEmitter") or child:IsA("Beam") then
                child.Enabled = true;
            end;
        end;

        for _, child in u44:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;
    end);
    task.delay(5.35, function() -- Line: 526
        -- upvalues: u44 (copy)
        for _, child in u44:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;
    end);
    task.delay(6.1, function() -- Line: 534
        -- upvalues: u41 (copy), u38 (copy), u49 (copy)
        for _, v in u41 do
            if v:IsA("ParticleEmitter") or v:IsA("Beam") then
                v.Enabled = false;
            end;
        end;

        for _, child in u38:GetChildren() do
            if child:IsA("ParticleEmitter") or child:IsA("Beam") then
                child.Enabled = false;
            end;
        end;

        for _, descendant in u49:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(8.3, function() -- Line: 552
        -- upvalues: u36 (copy), u46 (copy), u43 (copy)
        for _, descendant in pairs(u36.CEffe:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u46:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u43 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;
    end);
    task.delay(9.2, function() -- Line: 571
        -- upvalues: u46 (copy), u47 (copy)
        for _, descendant in pairs(u46:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.916666666666666, function() -- Line: 584
        -- upvalues: u47 (copy), u39 (copy)
        for _, descendant in pairs(u47:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(12.7, function() -- Line: 597
        -- upvalues: u45 (copy)
        for _, descendant in pairs(u45:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(13.15, function() -- Line: 605
        -- upvalues: u45 (copy)
        for _, descendant in pairs(u45:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(14.35, function() -- Line: 613
        -- upvalues: u39 (copy)
        for _, descendant in pairs(u39:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16, function() -- Line: 623
        -- upvalues: ScreenDimmer (copy), u41 (copy), u43 (copy), u42 (copy), u48 (copy), u39 (copy), u45 (copy), u44 (copy), u49 (copy), u38 (copy), Lighting (ref), Ambient (ref), Brightness (ref), OutdoorAmbient (ref), ClockTime (ref), ExposureCompensation (ref), u40 (copy), mainreplication (ref), LocalPlayer (ref)
        ScreenDimmer:Destroy();

        for _, v in u41 do
            v:Destroy();
        end;

        for _, v in u43 do
            v:Destroy();
        end;

        for _, v in u42 do
            v:Destroy();
        end;

        u48:Destroy();
        u39:Destroy();
        u45:Destroy();
        u44:Destroy();
        u49:Destroy();
        u38:Destroy();
        Lighting.Ambient = Ambient;
        Lighting.Brightness = Brightness;
        Lighting.OutdoorAmbient = OutdoorAmbient;
        Lighting.ClockTime = ClockTime;
        Lighting.ExposureCompensation = ExposureCompensation;
        task.spawn(function() -- Line: 651
            -- upvalues: Lighting (ref), u40 (ref)
            for _, child in Lighting:GetChildren() do
                child:Destroy();
            end;

            for _, v in u40 do
                v.Parent = Lighting;
            end;
        end);
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 0.5);
        mainreplication.destroyVelocity(LocalPlayer.Character, true);
    end);
end;

function v1.DarkHorse(u56, p57) -- Line: 836
    -- upvalues: vfxUtil (copy), ReplicatedStorage (copy), LocalPlayer (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), MoonPropertyAnimator (copy)
    local v58 = u56.HumanoidRootPart or u56.PrimaryPart;

    if not p57.HumanoidRootPart then
        local _ = p57.PrimaryPart;
    end;

    local redone = vfxUtil.getResources().kunigami.redone;

    if require(ReplicatedStorage.util.actionUtil).checkGK(LocalPlayer.Character) then
        return;
    end;

    local v59 = vfxUtil.character_trove(u56);
    mainreplication.sceneEnabled(true);
    local v60, v61 = mainreplication.cutsceneCamRigWithLetterBox(v58, redone.DarkHorse_Camera, redone.FOV, u56, "default", redone["CamRigWithLetterBox "]);
    v59:Add(v61);
    local v62 = soundUtil:play(redone.isthisnotafoul, "default", {
        Volume = 0,
        Character = u56
    });

    if v62.Name == "Dub" then
        v62.Volume = redone.isthisnotafoul.Volume;
    elseif soundUtil:play(math.random(1, 2) == 1 and redone.isthisnotafoul or redone.isthisnotafoul2, SoundService).Name == "isthisnotafoul2" then
        task.delay(1.75, function() -- Line: 858
            -- upvalues: TekrinnDialogue (ref), u56 (copy)
            TekrinnDialogue.Speak(u56, {
                {
                    Text = "Even for you...",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 108, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2.5
                    }
                },
                {
                    Text = " that was too forced!",
                    Bold = true,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 108, 81)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 2.5
                    }
                }
            }, 1.6);
        end);
    end;

    local v63 = v59:Construct(redone.User);
    vfxUtil.setupAura(u56, v63, true);
    v63.Parent = workspace.Effects;
    local v64 = v59:Construct(redone.Victim);
    vfxUtil.setupAura(p57, v64, true);
    v64.Parent = workspace.Effects;
    local v65 = {
        Vignette = v59:Add(vfxUtil.getMoonEffects()).Vignette
    };
    vfxUtil.contain_lighting(v59, v65, redone.Lighting);
    local v66 = v59:Construct(MoonPropertyAnimator);
    v66:LoadAndConvertSave(redone.Moon, v65);
    v66:SetRoot(v58);
    v66:PlayAll();
    vfxUtil.execute_compiled(redone.Compiled, v59, v63, v64, v60);
    v59:Add(function() -- Line: 931
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(3, 0.3);
        mainreplication.sceneEnabled(false);
    end);
    v59:Add(task.delay(3.57, v59.Destroy, v59));
end;

return v1;
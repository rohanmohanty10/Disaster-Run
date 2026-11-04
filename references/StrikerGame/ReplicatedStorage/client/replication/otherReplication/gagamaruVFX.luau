 

 

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
local v1 = {};
local _ = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local Threshold = Lighting.Bloom.Threshold;
local ExposureCompensation = Lighting.ExposureCompensation;
local newmeshEmitter = require(script.Parent.Parent.newmeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local trove = require(ReplicatedStorage.forum.trove);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
require(ReplicatedStorage.util.KatUtil);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local Util = require(ReplicatedStorage.util.Util);

function v1.ultrareflex(p2, u3) -- Line: 45
    -- upvalues: mainreplication (copy), TweenService (copy), RunService (copy)
    local u4 = p2.HumanoidRootPart or p2.PrimaryPart;
    local u5, u6 = mainreplication.bodyVelocity(u4, 195, 0.5, nil, nil, true, TweenInfo.new(0.55, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
    u5.MaxForce = Vector3.new(300000, 300000, 300000);
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 60;
    NumberValue.Parent = u5;
    TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Value = 0
    }):Play();
    local u7 = nil;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 61
        -- upvalues: u5 (copy), u7 (ref), u3 (copy), u4 (copy), u6 (copy), NumberValue (copy)
        if u5 and u5:IsDescendantOf(game) then
            u5.Velocity = (u3 and -1 or 1) * u4.CFrame.RightVector * u6.Value + u4.CFrame.UpVector * NumberValue.Value;

            return;
        end;

        u7:Disconnect();
        workspace.Gravity = 500;
        task.delay(0.1, function() -- Line: 65
            workspace.Gravity = 196.2;
        end);
    end);
    task.delay(15, u7.Disconnect, u7);
end;

function v1.gagamaruShachihoko(u9, p10) -- Line: 77
    -- upvalues: Lighting (copy), trove (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), TekrinnDialogue (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local v11 = u9.HumanoidRootPart or u9.PrimaryPart;
    local Ball = u9:FindFirstChild("Ball");
    local _ = u9.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local u12 = trove.new();
    u12:AttachToInstance(u9);

    if p10 then
        u12:Add(p10.AncestryChanged:Once(function(p13) -- Line: 95
            -- upvalues: u12 (copy)
            u12:Destroy();
        end));
    end;

    local u14 = soundUtil:play(ReplicatedStorage.Resources.gagamaru.shajoko, SoundService, {
        Character = u9
    });
    u12:Add(task.delay(0.917, function() -- Line: 102
        -- upvalues: TekrinnDialogue (ref), u9 (copy)
        TekrinnDialogue.Speak(u9, {
            {
                Text = "I have to gamble.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end));
    u12:Add(task.delay(u14.Name == "Dub" and 2.6 or 2.2, function() -- Line: 128
        -- upvalues: TekrinnDialogue (ref), u9 (copy)
        TekrinnDialogue.Speak(u9, {
            {
                Text = "I\'ll go with my gut!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end));
    u12:Add(task.delay(u14.Name == "Dub" and 3.7 or 3.85, function() -- Line: 154
        -- upvalues: TekrinnDialogue (ref), u9 (copy), u14 (copy)
        TekrinnDialogue.Speak(u9, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = u14.Name == "Dub" and "COME ON!" or "Here it comes!",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u12:Add(task.delay(4.383, function() -- Line: 180
        -- upvalues: u14 (copy), TekrinnDialogue (ref), u9 (copy)
        if u14.Name == "Dub" then
            return;
        end;

        TekrinnDialogue.Speak(u9, {
            {
                Text = "Come on!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 1);
    end));
    u12:Add(task.delay(u14.Name == "Dub" and 6.4 or 6.617, function() -- Line: 210
        -- upvalues: TekrinnDialogue (ref), u9 (copy), u14 (copy)
        TekrinnDialogue.Speak(u9, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Text = u14.Name == "Dub" and "It\'s not over yet!" or "I still have a chance...",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    u12:Add(task.delay(8.933, function() -- Line: 236
        -- upvalues: TekrinnDialogue (ref), u9 (copy)
        TekrinnDialogue.Speak(u9, {
            {
                Text = "Shachihoko fish kick!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 3);
    end));
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(157, 181, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u15 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u15.Parent = Lighting;
    u15.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u16 = ReplicatedStorage.Resources.gagamaru.shaEffect:Clone();
    u16:PivotTo(v11.CFrame);
    u16.Parent = u9;
    mainreplication.cutscene(v11, nil, 10.767, ReplicatedStorage.Resources.gagamaru.shachihokoFOV, nil, p10);
    local u17 = ReplicatedStorage.Resources.gagamaru.shajokoCam:Clone();
    u17.Parent = u16;

    if Util.canshiftcolor(LocalPlayer, u9) then
        vfxUtil.LeanTowardsColor(u16, u9:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u9:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u18 = nil;
    u18 = RunService.PreRender:connect(function() -- Line: 293
        -- upvalues: u17 (copy), u18 (ref)
        if u17:IsDescendantOf(game) then
            u17.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u18:Disconnect();
    end);
    local u19 = ReplicatedStorage.Resources.gagamaru.shajokoball:Clone();
    u19.Weld.Part0 = Ball;
    u19.Parent = u16;
    local u20 = ReplicatedStorage.Resources.gagamaru.shajokoHead:Clone();
    u20.Weld.Part0 = u9.Head;
    u20.Parent = u16;
    local u21 = ReplicatedStorage.Resources.gagamaru.shajokuArm:Clone();
    u21.Weld.Part0 = u9["Left Arm"];
    u21.Parent = u16;

    for _, descendant in pairs(u20:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.spawn(function() -- Line: 317
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.gagamaruflames:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u16.parthand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    u12:Add(task.delay(3.25, function() -- Line: 332
        -- upvalues: u20 (copy)
        for _, descendant in pairs(u20:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u12:Add(task.delay(3.6, function() -- Line: 340
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.gagamaruflames:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u16.parthand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u12:Add(task.delay(3.65, function() -- Line: 355
        -- upvalues: u21 (copy), u17 (copy)
        for _, descendant in pairs(u21:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u17.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end));
    u12:Add(task.delay(5.167, function() -- Line: 369
        -- upvalues: u19 (copy)
        for i = 1, 3 do
            local _ = i;

            for _, descendant in ipairs(u19.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            task.wait(0.15);
        end;
    end));
    u12:Add(task.delay(5.233, function() -- Line: 380
        -- upvalues: u21 (copy), TweenService (ref), u17 (copy)
        for _, descendant in pairs(u21:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                TweenService:Create(descendant, TweenInfo.new(0.55), {
                    TimeScale = 0.05
                }):Play();
            end;
        end;

        for _, descendant in pairs(u17.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u12:Add(task.delay(5.3, function() -- Line: 396
        -- upvalues: u16 (copy)
        for _, descendant in pairs(u16.parthand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end));
    u12:Add(task.delay(6.233, function() -- Line: 404
        -- upvalues: u21 (copy)
        u21:Destroy();
    end));
    u12:Add(task.delay(6.35, function() -- Line: 407
        -- upvalues: u16 (copy)
        for _, descendant in ipairs(u16.groundslaphand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u12:Add(task.delay(6.35, function() -- Line: 414
        -- upvalues: u16 (copy)
        for _, descendant in ipairs(u16.groundslaphand:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u12:Add(task.delay(7.95, function() -- Line: 421
        -- upvalues: u17 (copy), u19 (copy)
        for _, descendant in pairs(u17.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in ipairs(u19.impactboom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end));
    u12:Add(task.delay(10.767, function() -- Line: 435
        -- upvalues: u12 (copy)
        u12:Destroy();
    end));
    u12:Add(function() -- Line: 439
        -- upvalues: u21 (copy), u14 (copy), u15 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), ColorCorrectionEffect (copy), u16 (copy), mainreplication (ref)
        pcall(u21.Destroy, u21);
        pcall(u14.Destroy, u14);
        u15:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u16:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
end;

function v1.gagamaruPerfectSave(u22) -- Line: 478
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), RunService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy)
    local v23 = u22.HumanoidRootPart or u22.PrimaryPart;
    local Ball = u22:FindFirstChild("Ball");
    local _ = u22.Torso;
    local _ = Lighting.Atmosphere;
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(189, 222, 248);
    Lighting.ExposureCompensation = 1;
    Lighting.Bloom.Threshold = 2.627;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.55;
    ColorCorrectionEffect.Saturation = -0.4;
    local u24 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u24.Parent = Lighting;
    u24.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(1, 1, true);
    local u25 = ReplicatedStorage.Resources.gagamaru.perfectSaveEff:Clone();
    u25:PivotTo(v23.CFrame);
    u25.Parent = u22;
    local u26 = soundUtil:play(ReplicatedStorage.Resources.gagamaru.gagasave_1, SoundService, {
        Character = u22
    });
    mainreplication.cutsceneBlender(v23, ReplicatedStorage.Resources.gagamaru.perfectSaveCam, ReplicatedStorage.Resources.gagamaru.perfectSaveFOV);
    local u27 = ReplicatedStorage.Resources.gagamaru.perfectCamEff:Clone();
    u27.Parent = u25;
    local u28 = nil;
    u28 = RunService.PreRender:connect(function() -- Line: 513
        -- upvalues: u27 (copy), u28 (ref)
        if u27:IsDescendantOf(game) then
            u27.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u28:Disconnect();
    end);
    local u29 = ReplicatedStorage.Resources.gagamaru.ballEffPerfect:Clone();
    u29.Weld.Part0 = Ball;
    u29.Parent = u25;

    if Util.canshiftcolor(LocalPlayer, u22) then
        vfxUtil.LeanTowardsColor(u25, u22:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u22:GetAttribute("CustomAlpha") or 0.985);
    end;

    u27.Beam.Enabled = true;
    task.delay(u26.Name == "Dub" and 1.8 or 0.333, function() -- Line: 528
        -- upvalues: TekrinnDialogue (ref), u22 (copy), u26 (copy)
        TekrinnDialogue.Speak(u22, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u26.Name == "Dub" and "Fire away synapses..." or "Uh-oh.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end);
    task.delay(u26.Name == "Dub" and 3.7 or 1.083, function() -- Line: 554
        -- upvalues: TekrinnDialogue (ref), u22 (copy), u26 (copy)
        TekrinnDialogue.Speak(u22, {
            {
                Italic = false,
                TypeSpeed = 0.01,
                Text = u26.Name == "Dub" and "Here\'s my super reaction!" or "Here it comes.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Bold = u26.Name == "Dub",
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(1.833, function() -- Line: 580
        -- upvalues: u26 (copy), TekrinnDialogue (ref), u22 (copy)
        if u26.Name == "Dub" then
            return;
        end;

        TekrinnDialogue.Speak(u22, {
            {
                Text = "Jump, synapses.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(3.733, function() -- Line: 610
        -- upvalues: u26 (copy), TekrinnDialogue (ref), u22 (copy)
        if u26.Name == "Dub" then
            return;
        end;

        TekrinnDialogue.Speak(u22, {
            {
                Text = "Here\'s my super reaction.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2.5
                }
            }
        }, 1);
    end);
    task.delay(7.617, function() -- Line: 640
        -- upvalues: u26 (copy), TekrinnDialogue (ref), u22 (copy)
        if u26.Name == "Dub" then
            return;
        end;

        TekrinnDialogue.Speak(u22, {
            {
                Text = "I\'m the one who\'ll stop it",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2.5
                }
            }
        }, 4);
    end);
    task.delay(u26.Name == "Dub" and 10.65 or 10.8, function() -- Line: 670
        -- upvalues: TekrinnDialogue (ref), u22 (copy)
        TekrinnDialogue.Speak(u22, {
            {
                Text = "Gagamaru Punch!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2.5,
                    Lifetime = 2.5
                }
            }
        }, 1);
    end);
    task.delay(1.1, function() -- Line: 697
        -- upvalues: u25 (copy), u27 (copy)
        for _, descendant in ipairs(u25.jump1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.7;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u25.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.7;
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        u27.Beamb.Enabled = true;
        u27.Beamb2.Enabled = true;
    end);
    task.delay(1.9666666666666666, function() -- Line: 715
        -- upvalues: Lighting (ref), u25 (copy), TweenService (ref)
        Lighting.Bloom.Threshold = 1;

        for _, descendant in ipairs(u25.jump1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u25.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;
    end);
    task.delay(4.933333333333334, function() -- Line: 733
        -- upvalues: Lighting (ref), u25 (copy), TweenService (ref), u27 (copy)
        Lighting.Bloom.Threshold = 2;

        for _, descendant in ipairs(u25.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 0.7;
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;

        u27.Beamb.Enabled = false;
        u27.Beamb2.Enabled = false;
    end);
    task.delay(5.733333333333333, function() -- Line: 749
        -- upvalues: u29 (copy), u25 (copy), TweenService (ref)
        for _, descendant in ipairs(u29.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u29.loop:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(0.5, function() -- Line: 760
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u25.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 0.7;
                TweenService:Create(descendant, TweenInfo.new(0.1), {
                    TimeScale = 0.15
                }):Play();
            end;
        end;
    end);
    task.delay(8.45, function() -- Line: 774
        -- upvalues: u25 (copy)
        for _, descendant in ipairs(u25.headstart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.95, function() -- Line: 781
        -- upvalues: u25 (copy), u27 (copy)
        for _, descendant in ipairs(u25.startthrow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u27.zoom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(10.583333333333334, function() -- Line: 795
        -- upvalues: u29 (copy)
        for _, descendant in ipairs(u29.throw:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                task.delay(1, function() -- Line: 800
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;

        for _, descendant in ipairs(u29.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(11.766666666666667, function() -- Line: 812
        -- upvalues: u27 (copy)
        for _, descendant in ipairs(u27.zoom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.983333333333333, function() -- Line: 819
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), u25 (copy), u29 (copy), u27 (copy)
        ColorCorrectionEffect.Brightness = 1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.45), {
            Brightness = 0
        }):Play();

        for _, descendant in ipairs(u25.bigthrow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                descendant.TimeScale = 1;
                TweenService:Create(descendant, TweenInfo.new(0.4), {
                    TimeScale = 0.4
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u25.bigthrowker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u29.follow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
                descendant.TimeScale = 1;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TimeScale = 0.5
                }):Play();
            end;
        end;

        for _, descendant in ipairs(u25.BeamsRedux:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                descendant.TextureLength = 55;
                descendant.TextureSpeed = 15;
                TweenService:Create(descendant, TweenInfo.new(1), {
                    TextureSpeed = 1
                }):Play();
            end;
        end;

        u27.Beambw.Enabled = true;
        u27.Beamb2w.Enabled = true;
    end);
    task.delay(13.683333333333334, function() -- Line: 854
        -- upvalues: u25 (copy), u29 (copy), u27 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ColorCorrectionEffect (copy)
        for _, descendant in ipairs(u25.bigthrow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u25.bigthrowker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in ipairs(u29.follow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in ipairs(u25.BeamsRedux:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u27.Beambw.Enabled = false;
        u27.Beamb2w.Enabled = false;
        u27.Beam.Enabled = false;
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        ColorCorrectionEffect:Destroy();
    end);
    task.delay(15.15, function() -- Line: 888
        -- upvalues: u25 (copy)
        for _, descendant in ipairs(u25.headFINISH:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(16.283, function() -- Line: 896
        -- upvalues: u24 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ColorCorrectionEffect (copy), u25 (copy), mainreplication (ref)
        u24:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;

        if ColorCorrectionEffect then
            ColorCorrectionEffect:Destroy();
        end;

        u25:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1, true);
    end);
end;

function v1.gagamaruAwk(u30, p31) -- Line: 928
    -- upvalues: vfxUtil (copy), Lighting (copy), ReplicatedStorage (copy), mainreplication (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), Util (copy), LocalPlayer (copy), RunService (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy)
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local v32 = u30.HumanoidRootPart or u30.PrimaryPart;
    local _ = u30.Torso;
    local _ = Lighting.Atmosphere;
    Lighting.Brightness = 2;
    Lighting.Ambient = Color3.fromRGB(144, 158, 168);
    Lighting.ExposureCompensation = 2;
    Lighting.Bloom.Threshold = 2;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Contrast = 0.7;
    ColorCorrectionEffect.Saturation = -0.4;
    local u33 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u33.Parent = Lighting;
    u33.FarIntensity = 1;
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(-1, 1, true);
    local u34 = ReplicatedStorage.Resources.glowscreen:Clone();
    u34.Parent = PlayerGui;
    u34.ImageLabel2.ImageTransparency = 0.5;
    u34.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u35 = ReplicatedStorage.Resources.gagamaru.gagamaruAwk:Clone();
    u35:PivotTo(v32.CFrame);
    u35.Parent = u30;
    local u36 = soundUtil:play(ReplicatedStorage.Resources.gagamaru["gagamaru awake_1"], SoundService, {
        Character = u30
    });
    mainreplication.cutsceneBlender(v32, ReplicatedStorage.Resources.gagamaru.gagamaruawkAnimCam, ReplicatedStorage.Resources.gagamaru.awkFOV);
    local u37 = ReplicatedStorage.Resources.gagamaru.ker:Clone();
    u37.Parent = u30.Head;
    local u38 = ReplicatedStorage.Resources.gagamaru.awkcamEffect:Clone();
    u38.Parent = u35;

    if Util.canshiftcolor(LocalPlayer, u30) then
        vfxUtil.LeanTowardsColor(u35, u30:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u30:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u39 = nil;
    u39 = RunService.PreRender:connect(function() -- Line: 977
        -- upvalues: u38 (copy), u39 (ref)
        if u38:IsDescendantOf(game) then
            u38.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u39:Disconnect();
    end);
    local u40;

    if p31 then
        u40 = `The Bear, {u30.Name}` or u30;
    else
        u40 = u30;
    end;

    task.delay(u36.Name == "Dub" and 1.8 or 2.393, function() -- Line: 984
        -- upvalues: TekrinnDialogue (ref), u40 (copy), u36 (copy)
        TekrinnDialogue.Speak(u40, {
            {
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Text = u36.Name == "Dub" and "Adjust." or "Darn.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
    task.delay(u36.Name == "Dub" and 4.4 or 4.417, function() -- Line: 1010
        -- upvalues: TekrinnDialogue (ref), u40 (copy), u36 (copy)
        TekrinnDialogue.Speak(u40, {
            {
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Text = u36.Name == "Dub" and "I have to try again." or "I\'ll try again.",
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.spawn(function() -- Line: 1036
        -- upvalues: u35 (copy)
        for _, descendant in ipairs(u35.lineall:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.783333333333333, function() -- Line: 1044
        -- upvalues: ReplicatedStorage (ref), u30 (copy)
        local v41 = ReplicatedStorage.Resources.gagamaru.line:Clone();
        v41.Parent = u30["Right Arm"];
        v41.Enabled = true;
        local v42 = ReplicatedStorage.Resources.gagamaru.line:Clone();
        v42.Parent = u30["Left Arm"];
        v42.Enabled = true;
        task.delay(0.266666666666667, v41.Destroy, v41);
        task.delay(0.266666666666667, v42.Destroy, v42);
    end);
    task.delay(2.8666666666666667, function() -- Line: 1057
        -- upvalues: u35 (copy), Lighting (ref)
        for _, descendant in ipairs(u35.punchefl:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        Lighting.Bloom.Threshold = 1;
    end);
    task.delay(4.833333333333333, function() -- Line: 1065
        -- upvalues: u35 (copy)
        for _, descendant in ipairs(u35.ker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u35.swing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u35.bigsmoke:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u35.lineall:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.3, function() -- Line: 1091
        -- upvalues: ScreenDimmer (copy), mainreplication (ref), u34 (copy), u33 (copy), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), ColorCorrectionEffect (copy), u35 (copy), u37 (copy)
        ScreenDimmer:Destroy();
        mainreplication.ultFlash(1, 1, true);
        u34:Destroy();
        u33:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Bloom.Threshold = Threshold;
        Lighting.ExposureCompensation = ExposureCompensation;
        Lighting.Ambient = Ambient;
        ColorCorrectionEffect:Destroy();
        u35:Destroy();
        u37:Destroy();
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.headdriveGamamaruHit(p43) -- Line: 1130
    -- upvalues: mainreplication (copy), newmeshEmitter (copy), ReplicatedStorage (copy)
    local v44 = p43.HumanoidRootPart or p43.PrimaryPart;
    mainreplication.cameraShake(20, 2, 15);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    newmeshEmitter.StartMeshEmitter(v44, ReplicatedStorage.Resources.gagamaru["GAMAGARU MeshEmitter"], CFrame.Angles(0, -1.5707963267948966, 0), 3);
end;

function v1.scorpionGamamaruHit(p45) -- Line: 1141
    -- upvalues: mainreplication (copy), ReplicatedStorage (copy)
    mainreplication.Emit(p45.HumanoidRootPart or p45.PrimaryPart, ReplicatedStorage.Resources.gagamaru.socEffect, 5, CFrame.new(0, 1, -4));
    mainreplication.cameraShake(20, 2, 15);
    mainreplication.fov(false, 60);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.scorpionGamamaru(u46) -- Line: 1151
    -- upvalues: Players (copy), mainreplication (copy), RunService (copy)
    local u47 = u46.HumanoidRootPart or u46.PrimaryPart;
    task.delay(0.2, function() -- Line: 1180
        -- upvalues: Players (ref), u46 (copy), mainreplication (ref), u47 (copy), RunService (ref)
        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u46) then
            return;
        end;

        local u48 = mainreplication.bodyVelocity(u47, 1, 0.15, nil, nil, true);
        u48.MaxForce = Vector3.new(300000, 300000, 300000);
        local u49 = nil;
        u49 = RunService.RenderStepped:Connect(function(p50) -- Line: 1188
            -- upvalues: u48 (copy), u49 (ref), u47 (ref)
            if u48 and u48:IsDescendantOf(game) then
                u48.Velocity = u47.CFrame.LookVector * 50 + u47.CFrame.UpVector * 35;

                return;
            end;

            u49:Disconnect();
        end);
        task.delay(15, u49.Disconnect, u49);
    end);
end;

function v1.divingHeader(u51) -- Line: 1204
    -- upvalues: mainreplication (copy), Players (copy), RunService (copy)
    local u52 = u51.HumanoidRootPart or u51.PrimaryPart;
    local u53 = mainreplication.bodyVelocity(u52, 25, 0.3, true, nil, nil, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In));

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(u51) then
        mainreplication.fov(true, 60, 0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end;

    task.delay(0.3, function() -- Line: 1236
        -- upvalues: u53 (copy), Players (ref), u51 (copy), mainreplication (ref), u52 (copy), RunService (ref)
        if u53 then
            u53:Destroy();
        end;

        if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u51) then
            return;
        end;

        mainreplication.cameraShake(20, 1, 6);
        mainreplication.fov(false, 80);
        mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
        local u54 = mainreplication.bodyVelocity(u52, 1, 0.15, nil, nil, true);
        u54.MaxForce = Vector3.new(300000, 300000, 300000);
        local u55 = nil;
        u55 = RunService.RenderStepped:Connect(function(p56) -- Line: 1252
            -- upvalues: u54 (copy), u55 (ref), u52 (ref)
            if u54 and u54:IsDescendantOf(game) then
                u54.Velocity = u52.CFrame.LookVector * 170 + u52.CFrame.UpVector * 15;

                return;
            end;

            u55:Disconnect();
        end);
        task.delay(15, u55.Disconnect, u55);
    end);
end;

function v1.gagamaru_wild_dash(p57: any, p58: boolean) -- Line: 1268
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    if not vfxUtil.isLocalPlayer(p57) then
        return;
    end;

    local Root = vfxUtil.getRoot(p57);
    mainreplication.bodyVelocity(Root, p58 and -145 or 145, 0.633, nil, "RightVector", false, TweenInfo.new(1.133, Enum.EasingStyle.Sine));
end;

function v1.gagamaru_wild_catch(p59: any, u60: boolean) -- Line: 1290
    -- upvalues: vfxUtil (copy), mainreplication (copy)
    if not vfxUtil.isLocalPlayer(p59) then
        return;
    end;

    local Root = vfxUtil.getRoot(p59);
    mainreplication.bodyVelocity(Root, u60 and -100 or 100, 0.35, nil, "RightVector", false, TweenInfo.new(1.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.In));
    task.delay(0.35, function() -- Line: 1311
        -- upvalues: mainreplication (ref), Root (copy), u60 (copy)
        mainreplication.bodyVelocity(Root, u60 and -50 or 50, 0.35, nil, "RightVector", false, TweenInfo.new(1.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out));
    end);
    mainreplication.fov(false, 35);
    mainreplication.fov(true, 70, 3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
end;

function v1.thisstrikergotpunchedbyreigen(u61: any, p62: number?) -- Line: 1327
    -- upvalues: vfxUtil (copy), mainreplication (copy), soundUtil (copy), MoonPropertyAnimator (copy)
    local Root = vfxUtil.getRoot(u61);
    local reigen = vfxUtil.getResources().gagamaru.reigen;
    local u63 = vfxUtil.character_trove(u61);
    mainreplication.sceneEnabled(true);
    u63:Add(function() -- Line: 1334
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    soundUtil:play(reigen.SFX, "default");
    local _, v64 = mainreplication.cutsceneCamRigWithLetterBox(Root, reigen.Animations.Cam, reigen.FOV_Reigen, u61, CFrame.identity, reigen.FrierenCameraRig, "Elysn\'s Camera Rig");
    u63:Add(v64);
    local u65 = u63:Clone(reigen.VFX);
    u65.Parent = u61;
    u65:PivotTo(Root:GetPivot());
    pcall(function() -- Line: 1354
        -- upvalues: u65 (copy), u61 (copy)
        u65.AvatarSkinColorSmear.Color = u61["Left Arm"].Color;
    end);
    local v66 = {
        Workspace = u65,
        ["Screen Cover"] = u63:Add(vfxUtil.getMoonEffects())["Screen Cover"]
    };
    local v67 = u63:Construct(MoonPropertyAnimator);
    v67:LoadAndConvertSave(reigen.Moon, v66);
    v67:SetOriginalRoot(reigen.VFX.PrimaryPart.CFrame);
    v67:SetRoot(Root);
    v67:PlayAll();
    u63:Add(task.delay(p62, function() -- Line: 1374
        -- upvalues: u63 (copy)
        u63:Destroy();
    end));
end;

return v1;
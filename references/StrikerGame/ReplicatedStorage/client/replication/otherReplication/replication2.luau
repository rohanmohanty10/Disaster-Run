 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
game:GetService("CollectionService");
local Lighting = game:GetService("Lighting");
local SoundService = game:GetService("SoundService");
game:GetService("TextService");
game:GetService("ContentProvider");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local v1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local Threshold = Lighting.Bloom.Threshold;
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local MeshEmitter = require(ReplicatedStorage.client.replication.MeshEmitter);
local mainreplication = require(script.Parent.Parent.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
local trove = require(ReplicatedStorage2.forum.trove);
local Util = require(ReplicatedStorage2.util.Util);
local vfxUtil = require(ReplicatedStorage2.util.vfxUtil);
local u2 = require("../LunarisService");

function v1.sakuyaSteal(u3, p4, u5) -- Line: 41
    -- upvalues: ReplicatedStorage (copy), trove (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), Util (copy), Lighting (copy), u2 (copy), TekrinnDialogue (copy)
    local Steal = ReplicatedStorage.Resources.izayoi.Steal;
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");
    local u6 = trove.new();

    local function syncedDelay(p7: number, p8: function, ...) -- Line: 46
        -- upvalues: u6 (copy)
        return u6:Add(task.delay(math.max(0, p7 / 60), p8, ...));
    end;

    mainreplication.sceneEnabled(true);
    soundUtil:play(Steal[`sfx{u5 and ("-" .. u5 or "") or ""}`], SoundService);
    local v9, v10 = mainreplication.cutsceneCamRigWithLetterBox(HumanoidRootPart, Steal.Animations.Camera, Steal.FOV, u3, CFrame.new(0, -3, 0), ReplicatedStorage.Resources.SakuyaStealCamera);

    if v9 and v10 then
        u6:Add(v10);
        Util.Preload({ Steal.ImpactFrames });
        syncedDelay(350, function() -- Line: 63
            -- upvalues: Util (ref), Steal (copy)
            Util.Gif(Steal.ImpactFrames, 24);
        end);
        local u11 = u6:Clone(Steal.Effects:FindFirstChild("1"));
        u11.Parent = v9.camera;
        syncedDelay(48, function() -- Line: 70
            -- upvalues: mainreplication (ref), u11 (copy)
            mainreplication.BetterEmit(u11);
        end);
        syncedDelay(53, function() -- Line: 74
            -- upvalues: u11 (copy)
            for _, descendant in u11:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 0;
                end;
            end;
        end);
        syncedDelay(347, function() -- Line: 84
            -- upvalues: u11 (copy)
            for _, descendant in u11:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant.TimeScale = 1;
                end;
            end;
        end);

        for _, child in u6:Clone(Steal.Effects.Camera):GetChildren() do
            child.Parent = v9.camera;
            mainreplication.BetterEnable(child, true);
        end;
    end;

    local v12 = u6:Clone(Steal.Effects.CC.Instance);
    v12.Parent = Lighting;
    u6:Construct(u2):Play(v12, Steal.Effects.CC.Properties);

    if not u5 then
        TekrinnDialogue.Speak(u3, {
            {
                Text = "Illusion world. The world!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(157, 208, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 1.5);
    end;

    for _, v in { "Head", "Right Arm", "Left Arm", "Left Leg", "Right Leg", "Torso" } do
        local v13 = u3:FindFirstChild(v);

        if v13 then
            for _, child in Steal.Effects.Aura:GetChildren() do
                u6:Clone(child).Parent = v13;
            end;
        end;
    end;

    syncedDelay(48, function() -- Line: 145
        -- upvalues: mainreplication (ref), Steal (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = Steal.Effects:FindFirstChild("2"),
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(158, function() -- Line: 152
        -- upvalues: u5 (copy), TekrinnDialogue (ref), u3 (copy), mainreplication (ref), Steal (copy), HumanoidRootPart (copy)
        if not u5 then
            TekrinnDialogue.Speak(u3, {
                {
                    Text = "If you want to surrender..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(157, 208, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 20
                    }
                }
            }, 1.5);
        end;

        mainreplication.EmitAttachmentIn({
            Effect = Steal.Effects:FindFirstChild("2"),
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(322, function() -- Line: 185
        -- upvalues: u5 (copy), TekrinnDialogue (ref), u3 (copy), mainreplication (ref), Steal (copy), HumanoidRootPart (copy)
        if not u5 then
            TekrinnDialogue.Speak(u3, {
                {
                    Text = "It\'s best to do it now.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.04,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(157, 208, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 20
                    }
                }
            }, 1.5);
        end;

        mainreplication.EmitAttachmentIn({
            Effect = Steal.Effects:FindFirstChild("3"),
            Parent = HumanoidRootPart
        });
    end);
    syncedDelay(370, function() -- Line: 218
        -- upvalues: mainreplication (ref), Steal (copy), HumanoidRootPart (copy)
        mainreplication.EmitAttachmentIn({
            Effect = Steal.Effects:FindFirstChild("4"),
            Parent = HumanoidRootPart
        });
    end);
    u6:Add(function() -- Line: 225
        -- upvalues: mainreplication (ref)
        mainreplication.sceneEnabled(false);
    end);
    syncedDelay(430, u6.Destroy, u6);
end;

function v1.DoTekrinn(p14, p15) -- Line: 232
    -- upvalues: TekrinnDialogue (copy)
    if not p14 then
        return;
    end;

    if not p15 then
        return;
    end;

    TekrinnDialogue.Speak(p14, p15[1], p15[2], table.unpack(p15[3] or {}));
end;

function v1.unstoppableShidou(u16, p17) -- Line: 238
    -- upvalues: Lighting (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), mainreplication (copy), TekrinnDialogue (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), RunService (copy), TweenService (copy), Density (copy), Color (copy), Brightness (copy)
    local v18 = u16.HumanoidRootPart or u16.PrimaryPart;
    local _ = u16.Torso;
    local Atmosphere = Lighting.Atmosphere;
    local Ball = u16:WaitForChild("Ball", 2);
    local Attribute = u16:GetAttribute("femlock");
    local u19 = Attribute or soundUtil:play(Attribute and ReplicatedStorage.Resources.shidou.Femvoicelines.autogoal or ReplicatedStorage.Resources.shidou["im unstoppable"], SoundService, {
        Character = u16
    }).Name == "Dub";
    Ball.Size = Vector3.new(1.5, 1.5, 1.5);
    mainreplication.sceneEnabled(true);
    task.delay(0.9, function() -- Line: 255
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "I\'m unstoppable!!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    task.delay(4.817, function() -- Line: 282
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "Couldn\'t agree more.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 4);
    end);
    task.delay(7, function() -- Line: 309
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "I\'ll stomp ya and put ya outta action",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = " FOR GOOD!!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    task.delay(0.883, function() -- Line: 358
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if not u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "There\'s nobody here who can stop me!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3.5);
    end);
    task.delay(4.817, function() -- Line: 385
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if not u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "You took the words right outta my mouth..",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    task.delay(7.033, function() -- Line: 412
        -- upvalues: u19 (copy), TekrinnDialogue (ref), u16 (copy)
        if not u19 then
            return;
        end;

        TekrinnDialogue.Speak(u16, {
            {
                Text = "WASTE",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            },
            {
                Text = " of a striker you are!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 21, 103)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 2,
                    Lifetime = 2
                }
            }
        }, 2);
    end);
    Lighting.Brightness = 2;
    local u20 = ReplicatedStorage.Resources.glowscreen:Clone();
    u20.Parent = PlayerGui;
    u20.ImageLabel2.ImageTransparency = 1;
    u20.ImageLabel2.ImageColor3 = Color3.fromRGB(255, 65, 167);
    local u21 = ReplicatedStorage.Resources.shidou.backheelFlowEff:Clone();
    u21:PivotTo(v18.CFrame);
    u21.Parent = u16;

    if Util.canshiftcolor(LocalPlayer, u16) then
        vfxUtil.LeanTowardsColor(u21, u16:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u16:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u22 = ReplicatedStorage.Resources.shidou.backheelCamEff:Clone();
    u22.Parent = u21;
    local u23 = nil;
    u23 = RunService.PreRender:connect(function() -- Line: 480
        -- upvalues: u22 (copy), u23 (ref)
        if u22:IsDescendantOf(game) then
            u22.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u23:Disconnect();
    end);

    for _, descendant in pairs(u21:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
            descendant.Enabled = false;
        end;
    end;

    local u24 = ReplicatedStorage.Resources.shidou.backheelFlowEffBall:Clone();
    u24.Weld.Part0 = Ball;
    u24.Parent = u21;
    local u25 = ReplicatedStorage.Resources.shidou.eyebackheel:Clone();
    u25.Weld.Part0 = u16.Head;
    u25.Parent = u21;
    local u26 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u26.Parent = Lighting;
    u26.FarIntensity = 0;
    TweenService:Create(u26, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    mainreplication.cutsceneBlender(v18, ReplicatedStorage.Resources.shidou.backheelFlowC, ReplicatedStorage.Resources.shidou.backheelFlowFOV);
    u22.cells.Enabled = true;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 36;
    BlurEffect.Parent = Lighting;
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Brightness = 1;
    ColorCorrectionEffect.Contrast = 0.1;
    ColorCorrectionEffect.Saturation = 0.05;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.133, Enum.EasingStyle.Linear), {
        Brightness = 0,
        Saturation = -0.7,
        TintColor = Color3.fromRGB(205, 255, 247)
    }):Play();
    TweenService:Create(BlurEffect, TweenInfo.new(1.283, Enum.EasingStyle.Linear), {
        Size = 5
    }):Play();
    TweenService:Create(Atmosphere, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        Color = Color3.fromRGB(255, 91, 91)
    }):Play();
    task.delay(2.633, function() -- Line: 522
        -- upvalues: BlurEffect (copy), TweenService (ref)
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.334, Enum.EasingStyle.Linear), {
            Size = 2.736
        }):Play();
    end);
    task.delay(4.383, function() -- Line: 527
        -- upvalues: BlurEffect (copy), TweenService (ref)
        BlurEffect.Size = 22;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
    task.delay(4.383, function() -- Line: 532
        -- upvalues: BlurEffect (copy), TweenService (ref)
        BlurEffect.Size = 22;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
    end);
    task.delay(4.983, function() -- Line: 537
        -- upvalues: TweenService (ref), BlurEffect (copy)
        local v27 = TweenService:Create(BlurEffect, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
            Size = 7
        });
        v27:Play();
        v27.Completed:Wait();
        local v28 = TweenService:Create(BlurEffect, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
            Size = 0
        });
        v28:Play();
        v28.Completed:Wait();
    end);
    task.delay(6.15, function() -- Line: 548
        -- upvalues: Atmosphere (copy), Density (ref), Color (ref)
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
    end);
    task.delay(2.617, function() -- Line: 553
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 218, 245);
        ColorCorrectionEffect.Brightness = 0.3;
        ColorCorrectionEffect.Contrast = 0.1;
        ColorCorrectionEffect.Saturation = -0.3;
        local v29 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.966, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = -0.7,
            TintColor = Color3.fromRGB(205, 255, 247)
        });
        v29:Play();
        v29.Completed:Wait();
        local v30 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.734, Enum.EasingStyle.Linear), {
            Brightness = -0.1,
            TintColor = Color3.fromRGB(255, 209, 248)
        });
        v30:Play();
        v30.Completed:Wait();
        ColorCorrectionEffect.TintColor = Color3.fromRGB(205, 255, 247);
        ColorCorrectionEffect.Brightness = 0.6;
        ColorCorrectionEffect.Contrast = 0.1;
        ColorCorrectionEffect.Saturation = -0.7;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Saturation = 0.05,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(0.817, function() -- Line: 575
        -- upvalues: u21 (copy)
        for _, descendant in pairs(u21.Part:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.567, function() -- Line: 584
        -- upvalues: u22 (copy), u21 (copy)
        for _, child in pairs(u22:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u21.Seasoning01:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.533, function() -- Line: 600
        -- upvalues: u22 (copy), u24 (copy)
        for _, child in pairs(u22:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u24.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        u22.cells.Enabled = true;
    end);
    task.delay(3.95, function() -- Line: 618
        -- upvalues: u24 (copy)
        for _, descendant in pairs(u24.Attachment:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.333, function() -- Line: 627
        -- upvalues: u24 (copy), u21 (copy), Atmosphere (copy), u20 (copy), TweenService (ref)
        for _, descendant in pairs(u24.BALLL:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u21.Seasoning01:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        Atmosphere.Density = 1;
        u20.ImageLabel2.ImageTransparency = 0;
        TweenService:Create(u20.ImageLabel2, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(5.133, function() -- Line: 648
        -- upvalues: u24 (copy)
        for _, descendant in pairs(u24.at:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(6.55, function() -- Line: 657
        -- upvalues: u25 (copy)
        for _, descendant in pairs(u25:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.133, function() -- Line: 666
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref), u21 (copy), u22 (copy)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 58, 137);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();

        for _, descendant in pairs(u21.endImpact:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        TweenService:Create(u21.endImpact.RootAttachment["Time Scale"], TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            TimeScale = 0
        }):Play();
        TweenService:Create(u21.endImpact.RootAttachment["ts 2"], TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            TimeScale = 0
        }):Play();

        for _, descendant in pairs(u22:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.817, function() -- Line: 689
        -- upvalues: Ball (copy), u26 (copy), ColorCorrectionEffect (copy), u20 (copy), mainreplication (ref), u21 (copy), BlurEffect (copy), Lighting (ref), Brightness (ref)
        Ball.Size = Vector3.new(1.95, 1.95, 1.95);
        u26:Destroy();
        ColorCorrectionEffect:Destroy();
        u20:Destroy();
        mainreplication.sceneEnabled(false);
        mainreplication.ultFlash(1, 1.5);
        u21:Destroy();
        BlurEffect:Destroy();
        Lighting.Brightness = Brightness;
    end);
end;

function v1.ronaldoIttooeasy(u31) -- Line: 712
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), mainreplication (copy), soundUtil (copy), SoundService (copy), MeshEmitter (copy), Debris (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), PlayerGui (copy), Players (copy), animationUtil (copy), RunService (copy), TekrinnDialogue (copy)
    local u32 = u31.HumanoidRootPart or u31.PrimaryPart;
    local _ = u31.Torso;
    local _ = Lighting.Atmosphere;
    local ronaldo = ReplicatedStorage.Resources.ronaldo;
    mainreplication.sceneEnabled(true);

    if workspace.Terrain:FindFirstChild("Ball") then
        workspace.Terrain:FindFirstChild("Ball").Transparency = 1;
    end;

    task.delay(18.5, function() -- Line: 724
        if workspace.Terrain:FindFirstChild("Ball") then
            workspace.Terrain:FindFirstChild("Ball").Transparency = 0;
        end;
    end);
    soundUtil:play(ReplicatedStorage.Resources.ronaldo["ronaldo sound effect"], SoundService);
    mainreplication.cutscene(u32, CFrame.new(Vector3.new(0, 0, 0)), 18, ronaldo.GOATFOV);
    MeshEmitter.StartMeshEmitter(u32, ronaldo["GOAT MeshEmitter"]);
    mainreplication.ultFlash(-1, 1.5);
    local v33 = ReplicatedStorage.Resources.ronaldo.EnemyModels:Clone();
    v33:PivotTo(u32.CFrame);
    v33.Parent = u31;
    Debris:AddItem(v33, 18);

    if Util.canshiftcolor(LocalPlayer, u31) then
        vfxUtil.LeanTowardsColor(v33, u31:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u31:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u34 = ronaldo.RonaldoBallVFX:Clone();
    u34.Weld.Part0 = u31:FindFirstChild("Ball");
    u34.Parent = u31.Ball;
    Debris:AddItem(u34, 18);
    local u35 = ronaldo.RootAttachVfx:Clone();
    u35.Weld.Part1 = u32;
    u35.Parent = u32;
    Debris:AddItem(u35, 18);
    local u36 = ronaldo.RightLegAttach:Clone();
    u36.Weld.Part1 = u31["Right Leg"];
    u36.Parent = u31["Right Leg"];
    Debris:AddItem(u36, 18);
    local u37 = ronaldo.LeftLegAttach:Clone();
    u37.Weld.Part1 = u31["Left Leg"];
    u37.Parent = u31["Left Leg"];
    Debris:AddItem(u37, 18);
    local u38 = ronaldo.afterimage1:Clone();
    u38.CFrame = u32.CFrame * CFrame.new(
        31.68997,
        3.94258165,
        -92.9888763,
        1,
        -1.79603271e-19,
        -5.06636013e-7,
        -4.36017951e-20,
        1,
        -4.4056314e-13,
        5.06636013e-7,
        4.4056314e-13,
        1
    );
    u38.Parent = u31;
    Debris:AddItem(u38, 18);
    local u39 = ronaldo.ambience1:Clone();
    u39.CFrame = u32.CFrame * CFrame.new(
        21.9768028,
        1.48125982,
        -4.81808472,
        1,
        -1.79603271e-19,
        -5.06636013e-7,
        -4.36017951e-20,
        1,
        -4.4056314e-13,
        5.06636013e-7,
        4.4056314e-13,
        1
    );
    u39.Parent = u31;
    Debris:AddItem(u39, 18);
    local u40 = ronaldo.ambience2:Clone();
    u40.CFrame = u32.CFrame * CFrame.new(
        23.7723618,
        1.48125982,
        -4.95471478,
        1,
        -1.79603193e-19,
        -5.06636013e-7,
        -4.36017176e-20,
        1,
        -4.4056314e-13,
        5.06636013e-7,
        4.4056314e-13,
        1
    );
    u40.Parent = u31;
    Debris:AddItem(u40, 18);
    local v41 = ronaldo.ambience3:Clone();
    v41.CFrame = u32.CFrame * CFrame.new(
        18.0858593,
        -2.31203032,
        -98.5127869,
        1,
        -1.79603271e-19,
        -5.06636013e-7,
        -4.36017951e-20,
        1,
        -4.4056314e-13,
        5.06636013e-7,
        4.4056314e-13,
        1
    );
    v41.Parent = u31;
    Debris:AddItem(v41, 18);
    local u42 = ronaldo.camshutter:Clone();
    u42.CFrame = u32.CFrame * CFrame.new(
        49.9976196,
        69.2090759,
        -173.033279,
        1,
        -1.79603271e-19,
        -5.06636013e-7,
        -4.36017951e-20,
        1,
        -4.4056314e-13,
        5.06636013e-7,
        4.4056314e-13,
        1
    );
    u42.Parent = u31;
    Debris:AddItem(u42, 18);
    local v43 = ReplicatedStorage.Resources.glowscreen:Clone();
    v43.Parent = PlayerGui;
    v43.ImageLabel2.ImageTransparency = 0;
    v43.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    Debris:AddItem(v43, 18);
    local u44 = ronaldo.ColorCorrection2:Clone();
    u44.Parent = Lighting;
    Debris:AddItem(u44, 18);
    local u45 = ronaldo.ColorCorrection3:Clone();
    u45.Parent = Lighting;
    Debris:AddItem(u45, 18);
    local v46 = ronaldo.ColorCorrection:Clone();
    v46.Parent = Lighting;
    Debris:AddItem(v46, 18);
    local u47 = ronaldo.ActualMeshes:Clone();
    u47:PivotTo(u32.CFrame);
    u47.Parent = workspace.Effects;
    local v48 = {};

    for _, v in Players:GetPlayers() do
        local PlayerFromCharacter = Players:GetPlayerFromCharacter(u31);

        if not (PlayerFromCharacter and (v == PlayerFromCharacter or v.Team == PlayerFromCharacter.Team) or (not v:GetAttribute("style") or v48[v:GetAttribute("style")])) then
            v48[v:GetAttribute("style")] = {};
        end;
    end;

    for _, child in ipairs(v33:GetChildren()) do
        if child:FindFirstChildOfClass("Humanoid") then
            animationUtil:loadAnimation(child, ReplicatedStorage.Resources.ronaldo.GOATANIMS[child.Name]):Play(0);
        end;
    end;

    local u49 = ronaldo.RonaldoCamPart:Clone();
    u49.Parent = u31;
    Debris:AddItem(u49, 18);
    local u50 = nil;
    u50 = RunService.PreRender:connect(function() -- Line: 845
        -- upvalues: u49 (copy), u50 (ref)
        if u49:IsDescendantOf(game) then
            u49.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u50:Disconnect();
    end);
    task.delay(1, function() -- Line: 851
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "Ah...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    task.delay(2.2, function() -- Line: 877
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "All warmed up.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);
    end);
    task.delay(4, function() -- Line: 904
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "BRING IT!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(191, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 0, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.7);
    end);
    task.delay(6, function() -- Line: 930
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "Gonna love this!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(7.7, function() -- Line: 956
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "Got  ya!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 0.8);
    end);
    task.delay(9.7, function() -- Line: 982
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "Now we\'re talkin!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(12, function() -- Line: 1008
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "Head\'s up!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1);
    end);
    task.delay(15, function() -- Line: 1034
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "You\'ve played well.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 0.7);
    end);
    task.delay(15.8, function() -- Line: 1060
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "HE SHOOTS...",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 0.4);
    end);
    task.delay(16.8, function() -- Line: 1086
        -- upvalues: TekrinnDialogue (ref), u31 (copy)
        TekrinnDialogue.Speak(u31, {
            {
                Text = "HE SCORES!",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.5);
    end);
    task.spawn(function() -- Line: 1114
        -- upvalues: u49 (copy), u34 (copy)
        local v51 = u49["1"];
        local EffectUtility = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility.EmitAttachment(v51);
        EffectUtility.ToggleAttachment(v51, true, 2);
        local v52 = u34["1"];
        local EffectUtility2 = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility2.EmitAttachment(v52);
        EffectUtility2.ToggleAttachment(v52, true, 1.7);
    end);
    task.delay(13.28, function() -- Line: 1128
        -- upvalues: ronaldo (copy), u32 (copy), u31 (copy), Debris (ref)
        local v53 = ronaldo.blackbox:Clone();
        v53.CFrame = u32.CFrame * CFrame.new(
            35.2706871,
            8.9853363,
            -96.2517242,
            1,
            -1.79603271e-19,
            -5.06636013e-7,
            -4.36017951e-20,
            1,
            -4.4056314e-13,
            5.06636013e-7,
            4.4056314e-13,
            1
        );
        v53.Parent = u31;
        Debris:AddItem(v53, 1.86);
    end);
    task.delay(17.29, function() -- Line: 1135
        -- upvalues: ronaldo (copy), u32 (copy), u31 (copy), Debris (ref)
        local v54 = ronaldo.speedline2:Clone();
        v54.CFrame = u32.CFrame * CFrame.new(
            30.5179386,
            5.87720919,
            -123.459198,
            0.543599367,
            0.267656893,
            0.795524657,
            -0.151007622,
            0.963514268,
            -0.220990747,
            -0.825649083,
            1.35605049e-7,
            0.56418401
        );
        v54.Parent = u31;
        Debris:AddItem(v54, 0.71);
        local v55 = ronaldo.CharHighlight:Clone();
        v55.Parent = u31;
        Debris:AddItem(v55, 0.71);
    end);
    task.delay(1.1, function() -- Line: 1146
        -- upvalues: u34 (copy), u49 (copy), u39 (copy)
        local v56 = u34["1.5"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v56);
        local BeamHolder1 = u49:WaitForChild("BeamHolder1");

        for _, descendant in pairs(BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;

        require(game:GetService("ReplicatedStorage").EffectUtility).ToggleAttachment(u39, true, 0.7);
    end);
    task.delay(1.6, function() -- Line: 1166
        -- upvalues: u42 (copy)
        local v57 = u42;
        local EffectUtility = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility.EmitAttachment(v57);
        EffectUtility.ToggleAttachment(v57, true, 18);
    end);
    task.delay(1.95, function() -- Line: 1174
        -- upvalues: u35 (copy), u49 (copy)
        local v58 = u35["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v58);
        local BeamHolder1 = u49:WaitForChild("BeamHolder1");

        for _, descendant in pairs(BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.5, function() -- Line: 1189
        -- upvalues: u44 (copy)
        u44.Enabled = true;
    end);
    task.delay(5.1, function() -- Line: 1193
        -- upvalues: u44 (copy)
        u44.Enabled = false;
    end);
    task.delay(6.13, function() -- Line: 1197
        -- upvalues: u44 (copy)
        u44.Enabled = true;
    end);
    task.delay(7.23, function() -- Line: 1201
        -- upvalues: u44 (copy)
        u44.Enabled = false;
    end);
    task.delay(13.31, function() -- Line: 1205
        -- upvalues: u44 (copy)
        u44.Enabled = true;
    end);
    task.delay(15.1, function() -- Line: 1209
        -- upvalues: u44 (copy)
        u44.Enabled = false;
    end);
    task.delay(16.53, function() -- Line: 1213
        -- upvalues: u45 (copy)
        u45.Enabled = true;
    end);
    task.delay(2.433333333333333, function() -- Line: 1217
        -- upvalues: u35 (copy), ReplicatedStorage (ref), u47 (copy)
        local v59 = u35["2"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v59);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in u47:WaitForChild("1"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end);
    task.delay(2.783333333333333, function() -- Line: 1234
        -- upvalues: u35 (copy)
        local v60 = u35["3"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v60);
    end);
    task.delay(3.6166666666666667, function() -- Line: 1241
        -- upvalues: u49 (copy), u40 (copy)
        local BeamHolder1 = u49:WaitForChild("BeamHolder1");

        for _, descendant in pairs(BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;

        require(game:GetService("ReplicatedStorage").EffectUtility).ToggleAttachment(u40, true, 1.2);
    end);
    task.delay(5.216666666666667, function() -- Line: 1256
        -- upvalues: u49 (copy), u38 (copy)
        local v61 = u49["1"];
        local EffectUtility = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility.EmitAttachment(v61);
        EffectUtility.ToggleAttachment(v61, true, 7);
        local v62 = u38;
        local EffectUtility2 = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility2.EmitAttachment(v62);
        EffectUtility2.ToggleAttachment(v62, true, 7);
        local BeamHolder1 = u49:WaitForChild("BeamHolder1");

        for _, descendant in pairs(BeamHolder1:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.683333333333334, function() -- Line: 1286
        -- upvalues: u35 (copy), ReplicatedStorage (ref), u47 (copy), u34 (copy)
        local v63 = u35["4"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v63);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in u47:WaitForChild("2"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        local v64 = u34["2"];
        local EffectUtility = require(game:GetService("ReplicatedStorage").EffectUtility);
        EffectUtility.EmitAttachment(v64);
        EffectUtility.ToggleAttachment(v64, true, 1.7);
    end);
    task.delay(8.966666666666667, function() -- Line: 1309
        -- upvalues: ReplicatedStorage (ref), u47 (copy)
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in u47:WaitForChild("3"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end);
    task.delay(9.166666666666666, function() -- Line: 1321
        -- upvalues: u35 (copy), ReplicatedStorage (ref), u47 (copy)
        local v65 = u35["5"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v65);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in u47:WaitForChild("4"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;
    end);
    task.delay(10.216666666666667, function() -- Line: 1338
        -- upvalues: u37 (copy)
        local v66 = u37["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v66);
    end);
    task.delay(10.333333333333334, function() -- Line: 1345
        -- upvalues: u36 (copy)
        local v67 = u36["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v67);
    end);
    task.delay(10.483333333333333, function() -- Line: 1352
        -- upvalues: u37 (copy)
        local v68 = u37["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v68);
    end);
    task.delay(10.633333333333333, function() -- Line: 1359
        -- upvalues: u36 (copy)
        local v69 = u36["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v69);
    end);
    task.delay(10.783333333333333, function() -- Line: 1366
        -- upvalues: u37 (copy)
        local v70 = u37["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v70);
    end);
    task.delay(10.9, function() -- Line: 1373
        -- upvalues: u36 (copy)
        local v71 = u36["1"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v71);
    end);
    task.delay(12.7, function() -- Line: 1380
        -- upvalues: u35 (copy), ReplicatedStorage (ref), u47 (copy), u38 (copy)
        local v72 = u35["7"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v72);
        local MeshEmit = require(ReplicatedStorage.MeshEmit);

        for _, descendant in u47:WaitForChild("5"):GetDescendants() do
            if descendant.Name == "Start" then
                MeshEmit(descendant, true);
            end;
        end;

        for _, descendant in pairs(u38:GetDescendants()) do
            if descendant.ClassName == "Beam" then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(16.283333333333335, function() -- Line: 1405
        -- upvalues: u35 (copy)
        local v73 = u35["8"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v73);
    end);
    task.delay(16.933333333333334, function() -- Line: 1412
        -- upvalues: u35 (copy)
        local v74 = u35["9"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v74);
    end);
    task.delay(17.483333333333334, function() -- Line: 1419
        -- upvalues: u35 (copy)
        local v75 = u35["10"];
        require(game:GetService("ReplicatedStorage").EffectUtility).EmitAttachment(v75);
    end);
    task.delay(18, function() -- Line: 1427
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(-1);
        mainreplication.sceneEnabled(false);
    end);
end;

function v1.SkillGapRonaldo(u76, p77) -- Line: 1436
    -- upvalues: Lighting (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), MeshEmitter (copy), Debris (copy), TekrinnDialogue (copy)
    local v78 = u76.HumanoidRootPart or u76.PrimaryPart;
    local _ = u76.Torso;
    local _ = Lighting.Atmosphere;
    local ronaldo = ReplicatedStorage.Resources.ronaldo;
    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
    mainreplication.fov(false, 100);
    mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication.cameraShake(10, 2, 6);
    task.wait(1);
    local Ball = u76:WaitForChild("Ball", 6.7);

    if not Ball then
        return;
    end;

    soundUtil:play(ReplicatedStorage.Resources.ronaldo.SkillGapSfx, SoundService);
    mainreplication.cutscene(v78, CFrame.new(Vector3.new(0, 0, 0)), 11.15, ronaldo.SkillGapFOV);
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(-1, 1.5);
    MeshEmitter.StartMeshEmitter(v78, ronaldo["ball steal MeshEmitter"]);
    task.delay(11.15, function() -- Line: 1460
        -- upvalues: mainreplication (ref)
        mainreplication.ultFlash(-1, 1.5);
        mainreplication.sceneEnabled(false);
    end);
    local u79 = ronaldo.SkillGapParticles:Clone();
    u79:PivotTo(v78.CFrame);
    Debris:AddItem(u79, 11.15);
    local v80 = {};

    for _, descendant in ipairs(u76:GetDescendants()) do
        if descendant:IsA("Part") and descendant.Transparency < 1 then
            local v81 = descendant;

            for _, descendant2 in ipairs(ronaldo.AuraContainerSkillGap:GetDescendants()) do
                local v82 = descendant2:Clone();
                v82.Parent = v81;
                Debris:AddItem(v82, 11.15);
                table.insert(v80, v82);
            end;
        end;
    end;

    local u83 = ronaldo.RooooootPart:Clone();
    u83.Weld.Part0 = v78;
    u83.Parent = v78;
    Debris:AddItem(u83, 11.15);
    local u84 = ronaldo.enemyrootpart:Clone();
    u84.Weld.Part0 = p77.HumanoidRootPart;
    u84.Parent = p77.HumanoidRootPart;
    Debris:AddItem(u84, 11.15);
    local u85 = ronaldo.SkillGapBall:Clone();
    u85.Weld.Part0 = Ball;
    u85.Parent = Ball;
    Debris:AddItem(u85, 11.15);
    local u86 = ronaldo.Flash:Clone();
    u86.Parent = Lighting;
    Debris:AddItem(u86, 11.15);
    local u87 = ronaldo.Gray:Clone();
    u87.Parent = Lighting;
    Debris:AddItem(u87, 11.15);
    local u88 = u79.Debris:Clone();
    u88.CFrame = v78.CFrame * CFrame.new(
        0.726680756,
        3.33609295,
        -7.44778442,
        -0,
        -4.54747351e-13,
        -1,
        -1,
        8.81072992e-13,
        0,
        -8.81072992e-13,
        1,
        4.54747351e-13
    );
    u88.Parent = u76;
    Debris:AddItem(u88, 11.15);
    local v89 = u79.Lines:Clone();
    v89.CFrame = v78.CFrame * CFrame.new(
        2.26633835,
        0.827649117,
        -6.35430908,
        0,
        4.54747351e-13,
        -1,
        1,
        -8.81072992e-13,
        0,
        8.81072992e-13,
        -1,
        4.54747351e-13
    );
    v89.Parent = u76;
    Debris:AddItem(v89, 11.15);
    local u90 = u79.Lines2:Clone();
    u90.CFrame = v78.CFrame * CFrame.new(
        -1.146492,
        -0.765979052,
        -19.9266663,
        4.54747351e-13,
        -0,
        -1,
        -8.81072992e-13,
        -1,
        0,
        -1,
        -8.81072992e-13,
        4.54747351e-13
    );
    u90.Parent = u76;
    Debris:AddItem(u90, 11.15);
    local u91 = u79.Slide:Clone();
    u91.CFrame = v78.CFrame * CFrame.new(
        -1.52078629,
        -2.93521214,
        -12.8317566,
        0.173648179,
        0,
        -0.98480773,
        8.67687487e-13,
        1,
        1.52996715e-13,
        0.98480773,
        8.81072992e-13,
        0.173648179
    );
    u91.Parent = u76;
    Debris:AddItem(u91, 11.15);
    local u92 = u79.Specs:Clone();
    u92.CFrame = v78.CFrame * CFrame.new(
        -0.73210907,
        0.226979017,
        -19.6228333,
        -4.54747351e-13,
        0,
        -1,
        8.81072992e-13,
        1,
        0,
        1,
        8.81072992e-13,
        4.54747351e-13
    );
    u92.Parent = u76;
    Debris:AddItem(u92, 11.15);
    local u93 = u79.Specs2:Clone();
    u93.CFrame = v78.CFrame * CFrame.new(
        -0.73210907,
        0.226979017,
        -19.6228333,
        -4.54747351e-13,
        0,
        -1,
        8.81072992e-13,
        1,
        0,
        1,
        8.81072992e-13,
        4.54747351e-13
    );
    u93.Parent = u76;
    Debris:AddItem(u93, 11.15);
    task.spawn(function() -- Line: 1541
        -- upvalues: u79 (copy), u76 (copy), u83 (copy), u85 (copy), u86 (copy), u87 (copy)
        for _, descendant in u79:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u76:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and string.find(descendant.Name, "Aura") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u83.StealTrail:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u85.Shine:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        u86.Enabled = false;
        u86.Brightness = 1;
        u86.Contrast = 0.6;
        u87.Enabled = false;
        u87.Brightness = -0.1;
        u87.Contrast = 0;
        u87.Saturation = -0.4;
    end);
    task.delay(0.31666666666666665, function() -- Line: 1581
        -- upvalues: u83 (copy)
        for _, descendant in u83.Step:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.7666666666666666, function() -- Line: 1590
        -- upvalues: u79 (copy), u88 (copy), u86 (copy), u87 (copy)
        local TweenService2 = game:GetService("TweenService");

        for _, descendant in u88:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u88.Clock:GetDescendants() do
            TweenService2:Create(descendant, TweenInfo.new(2.7), {
                TimeScale = 0.08
            }):Play();
        end;

        for _, descendant in u88:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        u86.Enabled = false;
        u86.Brightness = 1;
        u86.Contrast = 0.6;
        u86.Enabled = true;
        TweenService2:Create(u86, TweenInfo.new(0.3), {
            Brightness = 0,
            Contrast = 0
        }):Play();
        u87.Enabled = true;
    end);
    task.delay(7.016666666666667, function() -- Line: 1623
        -- upvalues: u83 (copy)
        for _, descendant in u83.Kick:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.75, function() -- Line: 1632
        -- upvalues: u79 (copy), u88 (copy), u86 (copy), u87 (copy)
        local TweenService2 = game:GetService("TweenService");

        for _, descendant in u88:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in u88.Clock:GetDescendants() do
            descendant.TimeScale = 0.8;
        end;

        for _, descendant in u88:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        u86.Enabled = false;
        u86.Brightness = 1;
        u86.Contrast = 0.6;
        u86.Enabled = true;
        TweenService2:Create(u86, TweenInfo.new(0.3), {
            Brightness = 0,
            Contrast = 0
        }):Play();
        u87.Enabled = false;
    end);
    task.delay(8.516666666666667, function() -- Line: 1663
        -- upvalues: u79 (copy), u91 (copy), u84 (copy)
        for _, descendant in u91:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u84.Confused:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.383333333333333, function() -- Line: 1680
        -- upvalues: u79 (copy), u93 (copy), u84 (copy)
        for _, descendant in u93:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in u84.Snap:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(9.383333333333333, function() -- Line: 1697
        -- upvalues: u83 (copy), u76 (copy), u85 (copy), u79 (copy), u90 (copy), u92 (copy)
        for _, descendant in u76:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and string.find(descendant.Name, "Aura") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u85.Shine:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u83.StealTrail:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u90:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in u92:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.816666666666666, function() -- Line: 1736
        -- upvalues: u79 (copy), u91 (copy)
        for _, descendant in u91:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.3, function() -- Line: 1748
        -- upvalues: TekrinnDialogue (ref), u76 (copy)
        TekrinnDialogue.Speak(u76, {
            {
                Text = "Try switching up your plan of attack.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 1.7);
    end);
    task.delay(3.1, function() -- Line: 1774
        -- upvalues: TekrinnDialogue (ref), u76 (copy)
        TekrinnDialogue.Speak(u76, {
            {
                Text = "You\'ve got the speed, but could use more skill.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.04,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 3);
    end);
end;

function v1.ronaldoperfectpass(u94) -- Line: 1802
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), Players (copy), Lighting (copy), TweenService (copy)
    local u95 = u94.HumanoidRootPart or u94.PrimaryPart;
    local Ball = u94:FindFirstChild("Ball");
    local u96 = ReplicatedStorage.Resources.ronaldo.AuraWithTrail:Clone();
    u96.Weld.Part0 = u94["Right Arm"];
    u96.Parent = u94;
    local u97 = ReplicatedStorage.Resources.ronaldo.AuraWithTrail:Clone();
    u97.Weld.Part0 = u94["Left Arm"];
    u97.Parent = u94;
    local u98 = ReplicatedStorage.Resources.ronaldo.SkillGapBall:Clone();
    u98.Weld.Part0 = Ball;
    u98.Parent = u94;
    local u99 = ReplicatedStorage.Resources.ronaldo.run:Clone();
    u99.Weld.Part0 = u95;
    u99.Parent = u94;
    task.delay(0.12, function() -- Line: 1824
        -- upvalues: mainreplication (ref), u95 (copy)
        mainreplication.bodyVelocity(u95, 75, 0.6, nil, nil, nil);
        task.wait(0.28);
        mainreplication.bodyVelocity(u95, 135, 1, nil, nil, nil);
    end);
    task.delay(0.55, function() -- Line: 1830
        -- upvalues: ReplicatedStorage (ref), u95 (copy), u94 (copy), Util (ref), LocalPlayer (ref), vfxUtil (ref)
        local v100 = ReplicatedStorage.Resources.ronaldo.headFlash:Clone();
        v100:PivotTo(u95.CFrame);
        v100.Parent = u94;

        if Util.canshiftcolor(LocalPlayer, u94) then
            vfxUtil.LeanTowardsColor(v100, u94:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u94:GetAttribute("CustomAlpha") or 0.985);
        end;

        for _, descendant in pairs(v100:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        task.delay(3, v100.Destroy, v100);
    end);
    task.delay(1.25, function() -- Line: 1848
        -- upvalues: u97 (copy), u96 (copy), u99 (copy), u98 (copy)
        u97:Destroy();
        u96:Destroy();
        u99:Destroy();
        u98:Destroy();
    end);
    task.delay(0.5, function() -- Line: 1855
        -- upvalues: Players (ref), u94 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref), mainreplication (ref)
        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u94) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.533, BlurEffect.Destroy, BlurEffect);
            local v101 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v101.Parent = Lighting;
            v101.TintColor = Color3.fromRGB(0, 255, 127);
            v101.Brightness = 0.4;
            v101.Contrast = 1;
            v101.Saturation = -0.4;
            TweenService:Create(v101, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v101, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v101.Destroy, v101);
            mainreplication.fov(false, 100);
            mainreplication.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.cameraShake(15, 1.5, 6);
        end;
    end);
end;

function v1.ronaldoAwk(u102) -- Line: 1898
    -- upvalues: Lighting (copy), mainreplication (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), PlayerGui (copy), TweenService (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), TekrinnDialogue (copy), Brightness (copy), Ambient (copy), Threshold (copy)
    local v103 = u102.HumanoidRootPart or u102.PrimaryPart;
    local _ = u102.Torso;
    local _ = Lighting.Atmosphere;
    local Ball = u102:FindFirstChild("Ball");
    mainreplication.sceneEnabled(true);
    mainreplication.ultFlash(-1);
    soundUtil:play(ReplicatedStorage.Resources.ronaldo["Ronaldo awk (1)"], SoundService);
    mainreplication.cutscene(v103, nil, 5.333, ReplicatedStorage.Resources.ronaldo.newawkFOV);
    Lighting.Brightness = 0;
    Lighting.Ambient = Color3.fromRGB(153, 153, 153);
    Lighting.Bloom.Threshold = 0.38;
    local u104 = ReplicatedStorage.Resources.uibox:Clone();
    u104.Parent = PlayerGui;
    local u105 = ReplicatedStorage.Resources.glowscreen:Clone();
    u105.Parent = PlayerGui;
    u105.ImageLabel2.ImageTransparency = 0;
    u105.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u106 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u106.Parent = Lighting;
    u106.FarIntensity = 0;
    TweenService:Create(u106, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        FarIntensity = 1
    }):Play();
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;
    local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect2.Parent = Lighting;
    local u107 = ReplicatedStorage.Resources.ronaldo.ronaldoAwk:Clone();
    u107:PivotTo(v103.CFrame);
    u107.Parent = u102;

    if Util.canshiftcolor(LocalPlayer, u102) then
        vfxUtil.LeanTowardsColor(u107, u102:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u102:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u108 = ReplicatedStorage.Resources.ronaldo.headFlash:Clone();
    u108.Weld.Part0 = u102.Head;
    u108.Parent = u107;
    local v109 = ReplicatedStorage.Resources.ronaldo.Ballef:Clone();
    v109.Weld.Part0 = Ball;
    v109.Parent = u107;
    TekrinnDialogue.Speak(u102, {
        {
            Text = "You\'re a natural on the field, but you lack",
            Bold = false,
            Italic = false,
            TypeSpeed = 0.03,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = false,
                Intensity = 1.5,
                Lifetime = 1.5
            }
        },
        {
            Text = " finesse.",
            Bold = true,
            Italic = true,
            TypeSpeed = 0.01,
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 0)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 1.5,
                Lifetime = 3
            }
        }
    }, 2);
    task.spawn(function() -- Line: 1997
        -- upvalues: u107 (copy), ColorCorrectionEffect2 (copy)
        local Background = u107.Background;
        local particles = u107.particles;

        for _, descendant in Background:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in Background.BG1:GetDescendants() do
            if descendant:IsA("Part") then
                descendant.Transparency = 1;
            end;
        end;

        for _, descendant in particles:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in particles.Debris:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        ColorCorrectionEffect2.Enabled = false;
        ColorCorrectionEffect2.Brightness = 2;
        ColorCorrectionEffect2.Contrast = 25;
        ColorCorrectionEffect2.Saturation = -1;
        ColorCorrectionEffect2.TintColor = Color3.fromRGB(255, 60, 60);
    end);
    task.delay(0.11666666666666667, function() -- Line: 2031
        -- upvalues: u107 (copy)
        for _, descendant in u107.particles.legya.Kick:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.9, function() -- Line: 2040
        -- upvalues: u107 (copy)
        for _, descendant in u107.particles.explode.Bounce:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.2666666666666666, function() -- Line: 2049
        -- upvalues: u107 (copy)
        for _, descendant in u107.particles.Slide:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    local u110 = {};
    task.delay(1.7833333333333334, function() -- Line: 2060
        -- upvalues: u108 (copy), u107 (copy), u102 (copy), ReplicatedStorage (ref), u110 (copy), TweenService (ref), ColorCorrectionEffect2 (copy)
        for _, descendant in u108.Flash:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in u107.particles.explode.CR7:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in u107.particles.explode.TopShoulder:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in ipairs(u102:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v111 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.ronaldo.auratable:GetDescendants()) do
                    local v112 = descendant2:Clone();
                    v112.Parent = v111;
                    table.insert(u110, v112);
                end;
            end;
        end;

        TweenService:Create(ColorCorrectionEffect2, TweenInfo.new(0.3), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0
        }):Play();
        TweenService:Create(ColorCorrectionEffect2, TweenInfo.new(0.8), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();

        for _, descendant in u107.particles.Specs:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.8333333333333335, function() -- Line: 2114
        -- upvalues: u107 (copy)
        local particles = u107.particles;

        for _, descendant in particles.Lines:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in particles.Debris:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.15, function() -- Line: 2129
        -- upvalues: u107 (copy)
        for _, descendant in u107.particles.Lines:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.5166666666666666, function() -- Line: 2138
        -- upvalues: u107 (copy), TweenService (ref), ColorCorrectionEffect (copy), TekrinnDialogue (ref), u102 (copy)
        local Background = u107.Background;
        local particles = u107.particles;

        for _, descendant in particles.Lines:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in particles.Lines2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
            Brightness = 0,
            Contrast = 0
        }):Play();
        TekrinnDialogue.Speak(u102, {
            {
                Text = "Don\'t let talent alone hold you back.",
                Bold = false,
                Italic = false,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 1.5,
                    Lifetime = 1.5
                }
            }
        }, 2);

        for _, descendant in Background.BG1:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in Background.BG1:GetDescendants() do
            if descendant:IsA("Part") then
                TweenService:Create(descendant, TweenInfo.new(0.05), {
                    Transparency = 0
                }):Play();
            end;
        end;
    end);
    task.delay(3.8833333333333333, function() -- Line: 2196
    end);
    task.delay(4.933, function() -- Line: 2205
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.217), {
            Brightness = -1
        }):Play();
    end);
    task.delay(5.333, function() -- Line: 2218
        -- upvalues: mainreplication (ref), u104 (copy), u105 (copy), Lighting (ref), Brightness (ref), Ambient (ref), Threshold (ref), u110 (copy), ColorCorrectionEffect (copy), ColorCorrectionEffect2 (copy), u106 (copy), u107 (copy)
        mainreplication.sceneEnabled(false);
        u104:Destroy();
        u105:Destroy();
        Lighting.Brightness = Brightness;
        Lighting.Ambient = Ambient;
        Lighting.Bloom.Threshold = Threshold;

        for _, v in u110 do
            v:Destroy();
        end;

        mainreplication.ultFlash(-1);
        ColorCorrectionEffect:Destroy();
        ColorCorrectionEffect2:Destroy();
        u106:Destroy();
        u107:Destroy();
        Lighting.Brightness = Brightness;
    end);
end;

function v1.sakuyaBallTimestop(u113, u114) -- Line: 2249
    -- upvalues: ReplicatedStorage (copy), trove (copy), soundUtil (copy), SoundService (copy), mainreplication (copy), Lighting (copy), animationUtil (copy), RunService (copy), workspace_CurrentCamera (copy), TweenService (copy), TekrinnDialogue (copy)
    local BallSteal = ReplicatedStorage.Resources.izayoi.BallSteal;
    local HumanoidRootPart = u113:FindFirstChild("HumanoidRootPart");
    local u115 = trove.new();
    soundUtil:play(ReplicatedStorage.Resources.dcsound, SoundService);
    local u116 = BallSteal.SakuyaArm:Clone();
    soundUtil:play(BallSteal[`sound{u114 and ("-" .. u114 or "") or ""}`], SoundService);

    for _, child in u113:GetChildren() do
        if child:IsA("CharacterMesh") or (child:IsA("BodyColors") or child:IsA("Shirt")) then
            child:Clone().Parent = u116;
        end;
    end;

    local u117 = {};
    local u118 = nil;
    local u119 = {};
    local u120 = nil;
    local u121 = nil;
    local u122 = nil;
    table.insert(u119, u120);
    table.insert(u119, u121);
    table.insert(u119, u122);
    u115:Add(function() -- Line: 2282
        -- upvalues: mainreplication (ref), u118 (ref), u119 (copy), u117 (copy), Lighting (ref), u116 (copy)
        mainreplication.sceneEnabled(false);

        if u118 then
            u118:Disconnect();
        end;

        for _, v in u119 do
            pcall(game.Destroy, v);
        end;

        for _, v in u117 do
            if v and v.Parent ~= nil then
                v.Parent = Lighting;
            end;
        end;

        pcall(game.Destroy, u116);
    end);
    task.delay(10.17, function() -- Line: 2300
        -- upvalues: u115 (copy)
        u115:Destroy();
    end);
    u116.Parent = workspace.Effects;
    u116["Left Arm"].Transparency = 1;
    local _, _, u123 = mainreplication.CutsceneStartCustom(HumanoidRootPart, BallSteal.Camera, BallSteal.FOV, nil, nil, CFrame.new(0, -3, 0));
    local u124 = animationUtil:Load(u116, BallSteal.Sakuya);
    u124:Play(0);
    u118 = RunService.PreRender:Connect(function() -- Line: 2312
        -- upvalues: u116 (copy), u124 (copy), workspace_CurrentCamera (ref), u118 (ref)
        if not u116 then
            u118:Disconnect();

            return;
        end;

        if u124 and u124.TimePosition ~= 0 then
            u116["Left Arm"].Transparency = 0;
        end;

        u116.HumanoidRootPart.CFrame = workspace_CurrentCamera.CFrame * CFrame.new(0, 0, -6.24) * CFrame.fromEulerAnglesYXZ(0, 3.141592653589793, 0);
    end);
    u115:Add(task.delay(0.28, function() -- Line: 2323
        -- upvalues: mainreplication (ref), u120 (ref), Lighting (ref), u121 (ref), u122 (ref), u119 (copy), TweenService (ref), u117 (copy), u118 (ref), u116 (copy), u123 (copy)
        mainreplication.sceneEnabled(true);
        u120 = Instance.new("ColorCorrectionEffect");
        u120.Parent = Lighting;
        u120.Saturation = -0.3;
        u121 = Instance.new("BlurEffect");
        u121.Parent = Lighting;
        u121.Size = 24;
        u121.Enabled = false;
        u122 = Instance.new("DepthOfFieldEffect");
        u122.Parent = Lighting;
        u122.Enabled = false;
        table.insert(u119, u120);
        table.insert(u119, u121);
        table.insert(u119, u122);
        TweenService:Create(u122, TweenInfo.new(1.22, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            FarIntensity = 1
        }):Play();

        for _, child in Lighting:GetChildren() do
            if (child:IsA("ColorCorrectionEffect") or (child:IsA("BlurEffect") or child:IsA("DepthOfFieldEffect"))) and not table.find(u119, child) then
                table.insert(u117, child);
                child.Parent = workspace;
            end;
        end;

        if u118 then
            u118:Disconnect();
        end;

        pcall(game.Destroy, u116);
        u123();
    end));
    u115:Add(task.delay(0.39, function() -- Line: 2364
        -- upvalues: u122 (ref), TweenService (ref)
        u122.FocusDistance = 0.05;
        u122.InFocusRadius = 30;
        u122.NearIntensity = 0.75;
        u122.Enabled = true;
        local v125 = TweenService:Create(u122, TweenInfo.new(1.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            FocusDistance = 0.05,
            InFocusRadius = 30,
            FarIntensity = 1,
            NearIntensity = 0.75
        });
        v125:Play();
        v125.Completed:Wait();
        local v126 = TweenService:Create(u122, TweenInfo.new(0.62, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            FocusDistance = 0.05,
            InFocusRadius = 1,
            FarIntensity = 1,
            NearIntensity = 0.75
        });
        v126:Play();
        v126.Completed:Wait();
        local v127 = TweenService:Create(u122, TweenInfo.new(1.07, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            InFocusRadius = 10
        });
        v127:Play();
        v127.Completed:Wait();
        local v128 = TweenService:Create(u122, TweenInfo.new(1.09, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            InFocusRadius = 1
        });
        v128:Play();
        v128.Completed:Wait();
        local v129 = TweenService:Create(u122, TweenInfo.new(0.81, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            InFocusRadius = 10
        });
        v129:Play();
        v129.Completed:Wait();
        task.delay(2.27, function() -- Line: 2385
            -- upvalues: TweenService (ref), u122 (ref)
            local v130 = TweenService:Create(u122, TweenInfo.new(0.83, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                InFocusRadius = 15
            });
            v130:Play();
            v130.Completed:Wait();
            local v131 = TweenService:Create(u122, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                InFocusRadius = 25
            });
            v131:Play();
            v131.Completed:Wait();
            local v132 = TweenService:Create(u122, TweenInfo.new(0.04, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                InFocusRadius = 43.132
            });
            v132:Play();
            v132.Completed:Wait();
            local v133 = TweenService:Create(u122, TweenInfo.new(1.71, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                InFocusRadius = 50
            });
            v133:Play();
            v133.Completed:Wait();
            TweenService:Create(u122, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                FocusDistance = 0,
                InFocusRadius = 0,
                FarIntensity = 0,
                NearIntensity = 0
            }):Play();
        end);
    end));
    u115:Add(task.delay(2.07, function() -- Line: 2403
        -- upvalues: TweenService (ref), u120 (ref)
        local u134 = TweenService:Create(u120, TweenInfo.new(0.08, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Saturation = -2
        });
        u134:Play();
        task.spawn(function() -- Line: 2406
            -- upvalues: u134 (copy), TweenService (ref), u120 (ref)
            u134.Completed:Once(function() -- Line: 2407
                -- upvalues: TweenService (ref), u120 (ref)
                local v135 = TweenService:Create(u120, TweenInfo.new(0.13, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Saturation = -1.492
                });
                v135:Play();
                v135.Completed:Wait();
                TweenService:Create(u120, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                    Saturation = -1
                }):Play();
                task.wait(1.25);
                task.delay(5.11, function() -- Line: 2413
                    -- upvalues: TweenService (ref), u120 (ref)
                    TweenService:Create(u120, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                        Saturation = -0.3
                    }):Play();
                    task.wait(0.15);
                    TweenService:Create(u120, TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                        Saturation = 0
                    }):Play();
                end);
            end);
        end);
        task.wait(0.03);
        u120.Brightness = -0.5;
        local v136 = TweenService:Create(u120, TweenInfo.new(0.09, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Brightness = -0.113
        });
        v136:Play();
        v136.Completed:Wait();
        TweenService:Create(u120, TweenInfo.new(1.32, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
            Brightness = 0
        }):Play();
    end));
    u115:Add(task.delay(0.31, function() -- Line: 2430
        -- upvalues: u114 (copy), TekrinnDialogue (ref), u113 (copy)
        if u114 then
            return;
        end;

        TekrinnDialogue.Speak(u113, {
            {
                Text = "Illusionary World, The World!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.02,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 1.5);
    end));
    u115:Add(task.delay(4.08, function() -- Line: 2457
        -- upvalues: u114 (copy), TekrinnDialogue (ref), u113 (copy)
        if u114 then
            return;
        end;

        TekrinnDialogue.Speak(u113, {
            {
                Text = "For the mistress I serve.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 1.5);
    end));
    u115:Add(task.delay(7.17, function() -- Line: 2485
        -- upvalues: u114 (copy), TekrinnDialogue (ref), u113 (copy)
        if u114 then
            return;
        end;

        TekrinnDialogue.Speak(u113, {
            {
                Text = "Let\'s start the dirty work.",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.03,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = false,
                    Intensity = 2,
                    Lifetime = 20
                }
            }
        }, 1.5);
    end));
end;

return v1;
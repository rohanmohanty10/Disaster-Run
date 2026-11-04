 
 

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
local u1 = {};
local workspace_CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer.PlayerGui;
LocalPlayer:GetMouse();
local _ = Lighting.Atmosphere.Color;
local _ = Lighting.Atmosphere.Density;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local Threshold = Lighting.Bloom.Threshold;
require(script.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local actionUtil = require(ReplicatedStorage.util.actionUtil);
local script_xamillmesh = require(script.xamillmesh);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.KatUtil);
local MoonPropertyAnimator = require(ReplicatedStorage.util.MoonPropertyAnimator);
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
u1.cutsceneohiocamera = mainreplication.cutsceneohiocamera;
u1.cutscene = mainreplication.cutscene;
u1.cutsceneLeftright = mainreplication.cutsceneLeftright;
u1.cutscene_JxBEj_0 = mainreplication.cutscene_JxBEj_0;
u1.cutsceneBlender = mainreplication.cutsceneBlender;
u1.sceneEnabled = mainreplication.sceneEnabled;
u1.ultFlash = mainreplication.ultFlash;
u1.bright = mainreplication.bright;
u1.cameraShake = mainreplication.cameraShake;
u1.fov = mainreplication.fov;
u1.bodyVelocity = mainreplication.bodyVelocity;
u1.destroyVelocity = mainreplication.destroyVelocity;
u1.Emit = mainreplication.Emit;
local MeshEmitter = require(ReplicatedStorage.client.replication.MeshEmitter);
local mainreplication2 = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.TekrinnDialogue);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);

function u1.offtheballAwk(u2, p3) -- Line: 61
    -- upvalues: Players (copy), Util (copy), LocalPlayer (copy), Lighting (copy), mainreplication2 (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), PlayerGui (copy), RunService (copy), vfxUtil (copy), MeshEmitter (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy), Ambient (copy), Threshold (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u2);
    local v4;

    if u2:GetAttribute("FunnyVoicelines") == true then
        v4 = true;
    else
        v4 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(LocalPlayer, "modifiedVoices");
    end;

    u2:FindFirstChild("Ball");
    local u5 = u2.HumanoidRootPart or u2.PrimaryPart;
    local _ = u2.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication2.ultFlash(-1.5);

    if workspace.Terrain:FindFirstChild("Ball") then
        workspace.Terrain:FindFirstChild("Ball").Transparency = 1;
    end;

    local v6 = not v4 and u2:GetAttribute("femlock");
    local v7;

    if v4 then
        v7 = ReplicatedStorage.Resources.aiku.offtheballrnp;
    elseif v6 then
        v7 = ReplicatedStorage.Resources.aiku.Femvoicelines.aikumissawk;
    else
        v7 = ReplicatedStorage.Resources.aiku["aiku awake fail sfx"];
    end;

    local u8 = v6 or soundUtil:play(v7, SoundService, {
        Character = u2
    }).Name == "Dub";
    mainreplication2.sceneEnabled(true);
    mainreplication2.cutsceneBlender(u5, ReplicatedStorage.Resources.aiku.offtheballAwkCam, ReplicatedStorage.Resources.aiku.offtheballFOV);
    local u9 = ReplicatedStorage.Resources.uibox:Clone();
    u9.Parent = PlayerGui;
    local u10 = ReplicatedStorage.Resources.glowscreen:Clone();
    u10.Parent = PlayerGui;
    u10.ImageLabel2.ImageTransparency = 0;
    u10.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
    local u11 = ReplicatedStorage.Resources.aiku.aikuOfftheballEff:Clone();
    u11:PivotTo(u5.CFrame);
    u11.Parent = workspace.Effects;
    local u12 = nil;
    u12 = RunService.PreRender:Connect(function() -- Line: 95
        -- upvalues: u5 (copy), u11 (copy), u12 (ref)
        if u5 and u11 then
            if u5 and u11 then
                u11:PivotTo(u5.CFrame);
            end;

            return;
        end;

        u12:Disconnect();
    end);

    if Util.canshiftcolor(LocalPlayer, u2) then
        vfxUtil.LeanTowardsColor(u11, u2:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u2:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in ipairs(u11.aikugridwalls:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;

    Lighting.Brightness = 0;
    Lighting.Ambient = Color3.fromRGB(153, 153, 153);
    Lighting.Bloom.Threshold = 0.38;
    local u13 = ReplicatedStorage.Resources.Ball:Clone();
    u13.ball.Part0 = u5;
    u13.Parent = u2;
    local v14 = ReplicatedStorage.Resources.aiku.eyeEff:Clone();
    v14.Weld.Part0 = u2.Head;
    v14.Parent = u11;
    local v15 = { MeshEmitter.StartMeshEmitter(u5, ReplicatedStorage.Resources.aiku["hoodirony MeshEmitter"], nil).aikuawk2cc };

    for _, v in ipairs(v15) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 136
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u16 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u16.Parent = Lighting;
    u16.FarIntensity = 1;
    local u17 = ReplicatedStorage.Resources.aiku.offtheballCamPart:Clone();
    u17.Parent = u2;
    local u18 = nil;
    u18 = RunService.PreRender:connect(function() -- Line: 147
        -- upvalues: u17 (copy), u18 (ref)
        if u17:IsDescendantOf(game) then
            u17.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u18:Disconnect();
    end);

    if v4 then
        TekrinnDialogue.Speak(u2, {
            {
                Text = "What\'s good, gang?!",
                Bold = true,
                Italic = true,
                TypeSpeed = 0.01,
                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                TextStrokeColor = Color3.new(0, 0, 0),
                Shake = {
                    Enabled = true,
                    Intensity = 3,
                    Lifetime = 2
                }
            }
        }, 2);
        task.delay(0.595, function() -- Line: 361
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "It\'s Oliver Aiku...",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(1.503, function() -- Line: 386
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = ".. back again!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(1.98, function() -- Line: 411
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "I have a feeling I\'m gonna make a sick vlog this time!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 5);
        end);
        task.delay(4.603, function() -- Line: 436
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "OH MY GOD WHAT\'S THAT OVER THERE?!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(6.64, function() -- Line: 461
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "I\'m going in!!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(7.669, function() -- Line: 486
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "Unluckily for you, I\'m goated with the sauce!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(9.82, function() -- Line: 511
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "As the last line of defense..",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(11.576, function() -- Line: 536
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "I\'ll be the one to put a stop to YOU!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(0.267, function() -- Line: 153
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "All the next moves.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 1.5
                    }
                }
            }, 2);
        end);
        task.delay(1.833, function() -- Line: 179
            -- upvalues: TekrinnDialogue (ref), u2 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Text = "My senses are in overdrive!",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 5);
        end);
        task.delay(4.517, function() -- Line: 205
            -- upvalues: TekrinnDialogue (ref), u2 (copy), u8 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u8 and "I see it within every fiber of my being." or "I understand it all with my whole body.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1.5
                    }
                }
            }, 4);
        end);
        task.delay(6.183, function() -- Line: 231
            -- upvalues: TekrinnDialogue (ref), u2 (copy), u8 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u8 and "A whole new world is opening before me!" or "When I reach the max of the abilities",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 4
                    }
                }
            }, 5);
        end);
        task.delay(7.933, function() -- Line: 257
            -- upvalues: u8 (copy), TekrinnDialogue (ref), u2 (copy)
            if u8 then
                return;
            end;

            TekrinnDialogue.Speak(u2, {
                {
                    Text = "There\'s a world I can see only once I\'m there.",
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(10.833, function() -- Line: 286
            -- upvalues: TekrinnDialogue (ref), u2 (copy), u8 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u8 and "This sensation..." or "This sensation is...",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 2);
        end);
        task.delay(12.633, function() -- Line: 312
            -- upvalues: TekrinnDialogue (ref), u2 (copy), u8 (copy)
            TekrinnDialogue.Speak(u2, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u8 and "I\'M UNSTOPPABLE!" or "UNSTOPPABLE!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    end;

    task.spawn(function() -- Line: 563
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(0.18333333333333332, function() -- Line: 576
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.grassemitpartaikuawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 580
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(0.45, function() -- Line: 586
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.grassemitpartaikuawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.35;
            end;
        end;
    end);
    local u19 = {};
    task.delay(0.65, function() -- Line: 597
        -- upvalues: u2 (copy), ReplicatedStorage (ref), u19 (copy)
        for _, descendant in ipairs(u2:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v20 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.aiku.offtheballAura:GetDescendants()) do
                    local v21 = descendant2:Clone();
                    v21.Parent = v20;
                    table.insert(u19, v21);
                end;
            end;
        end;
    end);
    task.delay(0.8, function() -- Line: 617
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.grassemitpartaikuawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(0.9166666666666666, function() -- Line: 625
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.grassemitpartaikuawk2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 629
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(2.5, function() -- Line: 635
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(2.6333333333333333, function() -- Line: 648
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikugridball:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 652
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(2.65, function() -- Line: 658
        -- upvalues: u11 (copy), u17 (copy)
        for _, descendant in pairs(u11.aikulinesbrightemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u17.startone:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(3.6666666666666665, function() -- Line: 672
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuroboticstuffemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 676
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(3.8666666666666667, function() -- Line: 682
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikulinesbrightemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.9, function() -- Line: 690
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuendlights:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(5.283, function() -- Line: 698
        -- upvalues: u11 (copy), TweenService (ref)
        for _, descendant in ipairs(u11.aikugridwalls:GetDescendants()) do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1.117, Enum.EasingStyle.Linear), {
                    Transparency = 0
                }):Play();
            end;
        end;
    end);
    task.delay(5.3, function() -- Line: 705
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuspeedlines1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u11.aikuspeedlines2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.316666666666666, function() -- Line: 719
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuawkpopemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 723
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(u11.aikuemitkaboomboom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 731
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;

        for _, descendant in pairs(u11.aikuemitkaboomboom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 739
                    -- upvalues: descendant (copy)
                    descendant.Enabled = true;
                end);
            end;
        end;
    end);
    task.delay(6.333333333333333, function() -- Line: 745
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikulinesbrightemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.35, function() -- Line: 759
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikubluesmokepart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.733333333333333, function() -- Line: 767
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikugridballstaying:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(8.983333333333333, function() -- Line: 775
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuemitkaboomboom:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 779
                    -- upvalues: descendant (copy)
                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(9.166666666666666, function() -- Line: 785
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikubluesmokepart:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(9.25, function() -- Line: 793
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuawkspecsstuffa:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(9.266666666666667, function() -- Line: 801
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikubeamsonendthing:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u11.aikuawkballtechthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 810
                    -- upvalues: descendant (copy)
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end);
            end;
        end;
    end);
    task.delay(9.283333333333333, function() -- Line: 816
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuspeedlines1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u11.aikuspeedlines2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.016666666666667, function() -- Line: 830
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuawkspecsstuffa:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(11.366666666666667, function() -- Line: 838
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikugridballstaying:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(12.483333333333333, function() -- Line: 846
        -- upvalues: u11 (copy)
        for _, descendant in pairs(u11.aikuendlights:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(14.566666666666666, function() -- Line: 854
        -- upvalues: u11 (copy), u19 (copy)
        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u11.aikuawkgreengrid:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, v in u19 do
            v.Enabled = false;
        end;

        for _, descendant in pairs(u11.aikubeamsonendthing:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(14.567, function() -- Line: 877
        -- upvalues: u12 (ref), mainreplication2 (ref), u16 (copy), u11 (copy), u13 (copy), Lighting (ref), Brightness (ref), Ambient (ref), Threshold (ref), u19 (copy), u9 (copy), u10 (copy)
        if u12 then
            u12:Disconnect();
        end;

        mainreplication2.ultFlash(1);
        u16:Destroy();
        u11:Destroy();
        u13:Destroy();

        if workspace.Terrain:FindFirstChild("Ball") then
            workspace.Terrain:FindFirstChild("Ball").Transparency = 0;
        end;

        Lighting.Brightness = Brightness;
        Lighting.Ambient = Ambient;
        Lighting.Bloom.Threshold = Threshold;

        for _, v in u19 do
            v:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        u9:Destroy();
        u10:Destroy();
        Lighting.Brightness = Brightness;
    end);
end;

function u1.aikurun(u22, p23) -- Line: 921
    -- upvalues: Players (copy), mainreplication2 (copy), vfxUtil (copy), soundUtil (copy), SoundService (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), RunService (copy), workspace_CurrentCamera (copy), PlayerGui (copy), Util (copy), LocalPlayer (copy)
    local u24 = u22.HumanoidRootPart or u22.PrimaryPart;

    if Players.LocalPlayer ~= Players:GetPlayerFromCharacter(u22) then
        return;
    end;

    mainreplication2.cameraShake(10, 1.5, 6);
    mainreplication2.fov(false, 120);
    mainreplication2.fov(true, 70, 1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    mainreplication2.highlight(u22, Color3.fromRGB(75, 120, 48), 1.5);
    mainreplication2.bodyVelocity(u24, 100, 1.667, true, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));

    if p23 ~= "penaltyBox" and p23 then
        local Resources = vfxUtil.getResources();
        soundUtil:play(Resources.nelisagi.metaBurstPointRun, "default");
        soundUtil:play(Resources.kurona.FetchRunSFX, "default");
        soundUtil:play(Resources["nel/isagi"].Sounds.PuzzleShatter, "default");
        p23.Parent = SoundService;
        local u25 = Resources.isagi.iwanttowinwithmygoal.runALLVFX:Clone();
        u25.Weld.Part0 = u24;
        u25.Parent = u22;
        task.delay(1.667, function() -- Line: 952
            -- upvalues: u25 (copy)
            u25:Destroy();
        end);

        return;
    end;

    soundUtil:play(ReplicatedStorage.Resources.aiku["aiku run"], SoundService);
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = 25;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    task.delay(0.15, BlurEffect.Destroy, BlurEffect);
    local v26 = ReplicatedStorage.Resources.ColorCorrection:Clone();
    v26.Parent = Lighting;
    v26.TintColor = Color3.fromRGB(16, 255, 24);
    v26.Brightness = 0.4;
    v26.Contrast = 1;
    v26.Saturation = -0.4;
    TweenService:Create(v26, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Contrast = 0,
        Brightness = 0,
        Saturation = 0,
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    task.delay(2, v26.Destroy, v26);
    local u27 = ReplicatedStorage.Resources.aiku.aikucamSTART:Clone();
    u27.Parent = workspace.Effects;
    local u28 = nil;
    u28 = RunService.PreRender:connect(function() -- Line: 995
        -- upvalues: u27 (copy), u28 (ref), workspace_CurrentCamera (ref)
        if not u27:IsDescendantOf(game) then
            u28:Disconnect();
        end;

        u27.CFrame = workspace_CurrentCamera.CFrame;
    end);

    for _, descendant in pairs(u27.aikuleft:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true;
        end;
    end;

    task.delay(0.15, u27.aikuleft.Destroy, u27.aikuleft);
    local u29 = ReplicatedStorage.Resources.glowscreen:Clone();
    u29.ImageLabel2.ImageColor3 = Color3.fromRGB(101, 109, 255);
    u29.Parent = PlayerGui;
    task.delay(0.15, function() -- Line: 1016
        -- upvalues: mainreplication2 (ref), u24 (copy), ReplicatedStorage (ref), Util (ref), LocalPlayer (ref), u22 (copy), vfxUtil (ref), TweenService (ref)
        mainreplication2.Emit(u24, ReplicatedStorage.Resources.Dashre, 3, CFrame.new(0, 0, -5));
        local u30 = ReplicatedStorage.Resources.rundasheff:Clone();
        u30.main.Weld.C0 = CFrame.new(0, 0, 0);
        u30.main.Weld.Part0 = u24;
        u30.Parent = workspace.Effects;

        if Util.canshiftcolor(LocalPlayer, u22) then
            vfxUtil.LeanTowardsColor(u30, u22:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u22:GetAttribute("CustomAlpha") or 0.985);
        end;

        u30.Air.Size = Vector3.new(4.998, 0.503, 4.998);
        u30.Air.Transparency = 0.8;
        local Air = u30.main.Air;
        Air.C0 = Air.C0 * CFrame.new(0, -15, 0);
        TweenService:Create(u30.main.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            C0 = u30.main.Air.C0 * CFrame.new(0, 15, 0)
        }):Play();
        TweenService:Create(u30.Air, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(17.136, 1.132, 16.878),
            Transparency = 1
        }):Play();
        u30.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
        u30.Wind1.Transparency = 0.9;
        TweenService:Create(u30.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Size = Vector3.new(19.108, 11.452, 11.292),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 1062
            -- upvalues: u30 (copy), TweenService (ref)
            u30.Wind1.Size = Vector3.new(2.998, 3.226, 2.534);
            u30.Wind1.Transparency = 0.9;
            TweenService:Create(u30.Wind1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                Size = Vector3.new(19.108, 11.452, 11.292),
                Transparency = 1
            }):Play();
        end);
        u30.End.Size = Vector3.new(5, 1, 5);
        u30.End.Transparency = 0.65;
        local End = u30.main.End;
        End.C0 = End.C0 * CFrame.new(0, 0, 0);
        TweenService:Create(u30.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            C0 = u30.main.End.C0 * CFrame.new(0, -15, 0)
        }):Play();
        TweenService:Create(u30.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
            Size = Vector3.new(12.999, 2.766, 12.999),
            Transparency = 1
        }):Play();
        task.delay(0.15, function() -- Line: 1078
            -- upvalues: u30 (copy), TweenService (ref)
            u30.End.Size = Vector3.new(5, 1, 5);
            u30.End.Transparency = 0.65;
            local End2 = u30.main.End;
            End2.C0 = End2.C0 * CFrame.new(0, 15, 0);
            TweenService:Create(u30.main.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                C0 = u30.main.End.C0 * CFrame.new(0, -15, 0)
            }):Play();
            TweenService:Create(u30.End, TweenInfo.new(0.13, Enum.EasingStyle.Linear), {
                Size = Vector3.new(12.999, 2.766, 12.999),
                Transparency = 1
            }):Play();
        end);
        u30.A.Size = Vector3.new(14.29, 4.752, 5.444);
        u30.A.Mesh.Scale = Vector3.new(0.308, 0.158, 0.175);
        u30.main.A.C0 = CFrame.new(-0.077, -0.717, 1) * CFrame.Angles(0.4363323129985824, -1.5707963267948966, 0);
        u30.A.Decal.Transparency = 0.9;
        TweenService:Create(u30.main.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            C0 = u30.main.A.C0 * CFrame.new(5, 0, 0) * CFrame.Angles(-0.4363323129985824, 0, 0)
        }):Play();
        TweenService:Create(u30.A, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Size = Vector3.new(33.166, 4.752, 5.443)
        }):Play();
        TweenService:Create(u30.A.Mesh, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(0.715, 0.303, 0.315)
        }):Play();
        TweenService:Create(u30.A.Decal, TweenInfo.new(0.234, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.delay(2, u30.Destroy, u30);
    end);
    task.delay(1.667, function() -- Line: 1102
        -- upvalues: TweenService (ref), u29 (copy), u27 (copy)
        TweenService:Create(u29.ImageLabel2, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();

        for _, descendant in pairs(u27:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(3, u27.Destroy, u27);
        task.delay(1, u29.Destroy, u29);
    end);
end;

function u1.serpentsway(p31, p32) -- Line: 1122
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), mainreplication2 (copy), RunService (copy), Players (copy), Lighting (copy), TweenService (copy)
    local u33 = p31.HumanoidRootPart or p31.PrimaryPart;

    if p32 then
        local u34 = ReplicatedStorage.Resources.aiku.serpentright:Clone();
        u34.aikubase1vfxstepRIGHT.weld.Part0 = u33;
        u34:PivotTo(u33.CFrame);
        u34.Parent = p31;

        if Util.canshiftcolor(LocalPlayer, p31) then
            vfxUtil.LeanTowardsColor(u34, p31:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p31:GetAttribute("CustomAlpha") or 0.985);
        end;

        task.delay(0, function() -- Line: 1213
            -- upvalues: u34 (copy)
            for _, descendant in pairs(u34.aikubase1vfxstepRIGHT.aikubase1vfxRIGHT:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(0.45, function() -- Line: 1221
            -- upvalues: u34 (copy)
            for _, descendant in pairs(u34.aikubase1vfxstepRIGHT.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(0.7833333333333333, function() -- Line: 1229
            -- upvalues: u34 (copy)
            for _, descendant in pairs(u34.aikubase1vfxstepRIGHT.aikubase1vfxrunRIGHT:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(u34.aikubase1vfxstepRIGHT.aikubase1vfxrunRIGHT:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(1.0833333333333333, function() -- Line: 1243
            -- upvalues: u34 (copy)
            for _, descendant in pairs(u34.aikubase1vfxstepRIGHT.aikubase1vfxrunRIGHT:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(3, u34.Destroy, u34);
        local u35, u36 = mainreplication2.bodyVelocity(u33, 75, 0.55, nil, nil, true, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        local u37 = nil;
        u37 = RunService.RenderStepped:Connect(function(p38) -- Line: 1256
            -- upvalues: u35 (copy), u37 (ref), u33 (copy), u36 (copy)
            if u35 and u35:IsDescendantOf(game) then
                u35.Velocity = u33.CFrame.LookVector * -u36.Value;

                return;
            end;

            u37:Disconnect();
        end);
        task.delay(15, u37.Disconnect, u37);
        task.delay(0.7833333333333333, function() -- Line: 1266
            -- upvalues: mainreplication2 (ref), u33 (copy), RunService (ref)
            local u39, u40 = mainreplication2.bodyVelocity(u33, 125, 0.42, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
            local u41 = nil;
            u41 = RunService.RenderStepped:Connect(function(p42) -- Line: 1271
                -- upvalues: u39 (copy), u41 (ref), u33 (ref), u40 (copy)
                if u39 and u39:IsDescendantOf(game) then
                    u39.Velocity = u33.CFrame.LookVector * u40.Value + u33.CFrame.RightVector * u40.Value * 1.25;

                    return;
                end;

                u41:Disconnect();
            end);
            task.delay(15, u41.Disconnect, u41);
        end);
    else
        local u43 = ReplicatedStorage.Resources.aiku.serpentleft:Clone();
        u43.aikubase1vfxstep.HumanoidRootPart.Part1 = u33;
        u43:PivotTo(u33.CFrame);
        u43.Parent = p31;

        if Util.canshiftcolor(LocalPlayer, p31) then
            vfxUtil.LeanTowardsColor(u43, p31:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p31:GetAttribute("CustomAlpha") or 0.985);
        end;

        task.spawn(function() -- Line: 1134
            -- upvalues: u43 (copy)
            for _, descendant in pairs(u43.aikubase1vfxstep.aikubase1vfx:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(0.45, function() -- Line: 1142
            -- upvalues: u43 (copy)
            for _, descendant in pairs(u43.aikubase1vfxstep.Attachment:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end);
        task.delay(0.7833333333333333, function() -- Line: 1150
            -- upvalues: u43 (copy)
            for _, descendant in pairs(u43.aikubase1vfxstep.aikubase1vfxrun:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;

            for _, descendant in pairs(u43.aikubase1vfxstep.aikubase1vfxrun:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = true;
                end;
            end;
        end);
        task.delay(1.0833333333333333, function() -- Line: 1164
            -- upvalues: u43 (copy)
            for _, descendant in pairs(u43.aikubase1vfxstep.aikubase1vfxrun:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
        task.delay(3, u43.Destroy, u43);
        local u44, u45 = mainreplication2.bodyVelocity(u33, 75, 0.55, nil, nil, true, TweenInfo.new(1.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        local u46 = nil;
        u46 = RunService.RenderStepped:Connect(function(p47) -- Line: 1176
            -- upvalues: u44 (copy), u46 (ref), u33 (copy), u45 (copy)
            if u44 and u44:IsDescendantOf(game) then
                u44.Velocity = u33.CFrame.LookVector * -u45.Value;

                return;
            end;

            u46:Disconnect();
        end);
        task.delay(15, u46.Disconnect, u46);
        task.delay(0.7833333333333333, function() -- Line: 1187
            -- upvalues: mainreplication2 (ref), u33 (copy), RunService (ref)
            local u48, u49 = mainreplication2.bodyVelocity(u33, 140, 0.56, nil, nil, true, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
            local u50 = nil;
            u50 = RunService.RenderStepped:Connect(function(p51) -- Line: 1193
                -- upvalues: u48 (copy), u50 (ref), u33 (ref), u49 (copy)
                if u48 and u48:IsDescendantOf(game) then
                    u48.Velocity = u33.CFrame.LookVector * u49.Value + u33.CFrame.RightVector * -u49.Value * 1.25;

                    return;
                end;

                u50:Disconnect();
            end);
            task.delay(15, u50.Disconnect, u50);
        end);
    end;

    if Players.LocalPlayer == Players:GetPlayerFromCharacter(p31) then
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.533, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        task.delay(0.533, BlurEffect.Destroy, BlurEffect);
        local v52 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        v52.Parent = Lighting;
        v52.TintColor = Color3.fromRGB(137, 255, 3);
        v52.Brightness = 0.4;
        v52.Contrast = 1;
        v52.Saturation = -0.4;
        TweenService:Create(v52, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(v52, TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.delay(2, v52.Destroy, v52);
        mainreplication2.fov(false, 100);
        mainreplication2.fov(true, 70, 0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication2.cameraShake(10, 1.5, 6);
    end;
end;

function u1.serpentdefense(u53) -- Line: 1334
    -- upvalues: Players (copy), Util (copy), LocalPlayer (copy), u1 (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), vfxUtil (copy), animationUtil (copy), MeshEmitter (copy), workspace_CurrentCamera (copy), TekrinnDialogue (copy), RunService (copy), mainreplication2 (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u53);
    local v54;

    if u53:GetAttribute("FunnyVoicelines") == true then
        v54 = true;
    else
        v54 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(LocalPlayer, "modifiedVoices");
    end;

    local v55 = u53.HumanoidRootPart or u53.PrimaryPart;
    local Ball = u53:FindFirstChild("Ball");
    u1.sceneEnabled(true);
    u1.cutsceneBlender(v55, ReplicatedStorage.Resources.aiku.defensecam, ReplicatedStorage.Resources.aiku.FOV);
    soundUtil:play(ReplicatedStorage.Resources.aiku[v54 and "defense_rnp" or "defense"], SoundService);
    local u56 = ReplicatedStorage.Resources.aiku["aiku snek Fixed"]:Clone();
    u56.RootPart.HumanoidRootPart.Part1 = v55;
    u56.Parent = u53;
    u56:PivotTo(v55.CFrame);
    local _baseplate_controller, u57 = vfxUtil.get_baseplate_controller();
    animationUtil:loadAnimation(u56, ReplicatedStorage.Resources.aiku.snakeanim):Play();
    local v58 = MeshEmitter.StartMeshEmitter(v55, ReplicatedStorage.Resources.aiku["Aiku2 MeshEmitter"], nil);

    for _, v in ipairs({
        v58.aikusnakecc,
        v58.DepthOfField,
        v58.DepthOfField2,
        v58.Blur
    }) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 1369
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u59 = ReplicatedStorage.Resources.aiku.aikusnakeeee:Clone();
    u59.Parent = u53;
    u59:PivotTo(v55.CFrame);
    u59.aikusnakevfx.Weld.Part0 = v55;
    local u60 = ReplicatedStorage.Resources.aiku.Aikuvfx:Clone();
    u60.Parent = u53;
    u60.Ball.Weld.Part0 = Ball;
    u60.Torso.Weld.Part0 = u53.Torso;
    task.delay(10, u60.Destroy, u60);
    task.delay(10, u59.Destroy, u59);
    local u61 = ReplicatedStorage.Resources.aiku.aikucam:Clone();
    u61.Parent = u59;

    if v54 then
        task.delay(0.193, function() -- Line: 1389
            -- upvalues: TekrinnDialogue (ref), u53 (copy)
            TekrinnDialogue.Speak(u53, {
                {
                    Text = "NOT SO FAST!!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(2.129, function() -- Line: 1412
            -- upvalues: TekrinnDialogue (ref), u53 (copy)
            TekrinnDialogue.Speak(u53, {
                {
                    Text = "THIS JUST GOT INTERCEPTED BY OLIVER AIKU!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(5.389, function() -- Line: 1435
            -- upvalues: TekrinnDialogue (ref), u53 (copy)
            TekrinnDialogue.Speak(u53, {
                {
                    Text = "I\'M SO BRI\'ISH!!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    end;

    if Util.canshiftcolor(LocalPlayer, u53) then
        vfxUtil.LeanTowardsColor(u59, u53:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u53:GetAttribute("CustomAlpha") or 0.985);
    end;

    local u62 = nil;
    u62 = RunService.PreRender:connect(function() -- Line: 1464
        -- upvalues: u61 (copy), u62 (ref), workspace_CurrentCamera (ref)
        if not u61:IsDescendantOf(game) then
            u62:Disconnect();
        end;

        u61.CFrame = workspace_CurrentCamera.CFrame;
    end);
    task.delay(10, u61.Destroy, u61);
    task.delay(0.13333333333333333, function() -- Line: 1474
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.8333333333333334, function() -- Line: 1482
        -- upvalues: u60 (copy)
        for _, descendant in pairs(u60:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.3, function() -- Line: 1490
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.1333333333333333, function() -- Line: 1498
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeballbite:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.216666666666667, function() -- Line: 1506
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeeyemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(2.2333333333333334, function() -- Line: 1514
        -- upvalues: u60 (copy)
        for _, descendant in pairs(u60:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(2.6666666666666665, function() -- Line: 1522
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "leftrightbeams1" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = true;
                    end;
                end;
            end;
        end;

        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "leftrightbeams2" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = true;
                    end;
                end;
            end;
        end;
    end);
    task.delay(3.2666666666666666, function() -- Line: 1542
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakegrassdirtgrow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.283333333333333, function() -- Line: 1550
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakesurroundingflashes:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.3, function() -- Line: 1558
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "leftrightbeams1" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = false;
                    end;
                end;
            end;
        end;

        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "leftrightbeams2" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = false;
                    end;
                end;
            end;
        end;
    end);
    task.delay(3.8, function() -- Line: 1578
        -- upvalues: u60 (copy)
        for _, descendant in pairs(u60:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.85, function() -- Line: 1586
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakegrassdirtgrow:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.9166666666666665, function() -- Line: 1594
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresidue:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.266666666666667, function() -- Line: 1602
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresiduebackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresiduebackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(4.6, function() -- Line: 1618
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresidue:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u59.aikusnakevfx.aikubeams:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u59.aikusnakevfx.aikubeams:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.616666666666666, function() -- Line: 1636
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "updownbeams1" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = true;
                    end;
                end;
            end;
        end;

        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "updownbeams2" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = true;
                    end;
                end;
            end;
        end;
    end);
    task.delay(4.733333333333333, function() -- Line: 1657
        -- upvalues: u59 (copy), u57 (copy), _baseplate_controller (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakesurroundingflashes:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        u57.Transparency = 1;
        _baseplate_controller.update();
    end);
    task.delay(5.15, function() -- Line: 1668
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "updownbeams1" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = false;
                    end;
                end;
            end;
        end;

        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Attachment") and descendant.Name == "updownbeams2" then
                for _, child in pairs(descendant:GetChildren()) do
                    if child:IsA("Beam") then
                        child.Enabled = false;
                    end;
                end;
            end;
        end;
    end);
    task.delay(5.166666666666667, function() -- Line: 1688
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresiduebackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.25;
            end;
        end;
    end);
    task.delay(5.183333333333334, function() -- Line: 1696
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(6.183333333333334, function() -- Line: 1704
        -- upvalues: u60 (copy)
        for _, descendant in pairs(u60:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.533333333333333, function() -- Line: 1712
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.55, function() -- Line: 1720
        -- upvalues: u59 (copy), u57 (copy), _baseplate_controller (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresiduebackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeresiduebackground:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        u57.Transparency = 0;
        _baseplate_controller.update();
    end);
    task.delay(6.566666666666666, function() -- Line: 1736
        -- upvalues: u61 (copy)
        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u61:GetDescendants()) do
            if descendant:IsA("PointLight") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(6.816666666666666, function() -- Line: 1748
        -- upvalues: u59 (copy)
        for _, descendant in pairs(u59.aikusnakevfx.aikusnakeheadervfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(7.367, function() -- Line: 1757
        -- upvalues: u1 (ref), u59 (copy), u56 (copy), u60 (copy), u61 (copy), mainreplication2 (ref)
        u1.sceneEnabled(false);
        u59:Destroy();
        u56:Destroy();
        u60:Destroy();
        u61:Destroy();
        mainreplication2.ultFlash(1);
        u1.fov(false, 15);
        u1.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    end);
end;

function u1.aikutrap(u63) -- Line: 1773
    -- upvalues: Players (copy), Util (copy), LocalPlayer (copy), u1 (copy), ReplicatedStorage (copy), soundUtil (copy), SoundService (copy), vfxUtil (copy), script_xamillmesh (copy), TekrinnDialogue (copy)
    local u64 = u63.HumanoidRootPart or u63.PrimaryPart;
    u63:FindFirstChild("Ball");
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u63);
    local v65;

    if u63:GetAttribute("FunnyVoicelines") == true then
        v65 = true;
    else
        v65 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(LocalPlayer, "modifiedVoices");
    end;

    u1.sceneEnabled(true);
    u1.cutsceneBlender(u64, ReplicatedStorage.Resources.aiku.aikutrapcam, ReplicatedStorage.Resources.aiku.FOV2);
    local v66 = soundUtil:play(ReplicatedStorage.Resources.aiku[v65 and "trappedrnp" or "trapped"], SoundService, {
        Character = u63
    });
    local u67 = ReplicatedStorage.Resources.aiku.AikuTrapVfx:Clone();
    u67:PivotTo(u64.CFrame);
    u67.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, u63) then
        vfxUtil.LeanTowardsColor(u67, u63:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u63:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(5, u67.Destroy, u67);
    task.delay(0.15, function() -- Line: 1795
        -- upvalues: u67 (copy), ReplicatedStorage (ref), u64 (copy), u63 (copy), script_xamillmesh (ref)
        for _, descendant in pairs(u67.Somethingelse.BallFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u67.Somethingelse:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v68 = ReplicatedStorage.Resources.aiku.AikuMeshes:Clone();
        v68:PivotTo(u64.CFrame);
        v68.Parent = u63;
        task.delay(3, v68.Destroy, v68);

        for _, descendant in v68:GetDescendants() do
            script_xamillmesh(descendant);
        end;
    end);
    local BodyPosition = Instance.new("BodyPosition");
    BodyPosition.P = 12500;
    BodyPosition.MaxForce = Vector3.new(30000, 30000, 30000);
    BodyPosition.D = 300;
    BodyPosition.Parent = u64;
    BodyPosition.Position = u64.Position;
    TekrinnDialogue.Speak(u63, {
        {
            Bold = false,
            Italic = false,
            TypeSpeed = 0.01,
            Text = v66.Name == "Dub" and "So close.." or (v65 and "I\'M HERE!" or "Nice shot."),
            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(69, 153, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(131, 255, 29)) }),
            TextStrokeColor = Color3.new(0, 0, 0),
            Shake = {
                Enabled = true,
                Intensity = 2,
                Lifetime = 1.5
            }
        }
    }, 1);
    task.delay(1.15, function() -- Line: 1850
        -- upvalues: u1 (ref), BodyPosition (copy)
        u1.sceneEnabled(false);
        BodyPosition:Destroy();
    end);
end;

function u1.reflexTackle(p69) -- Line: 1856
    -- upvalues: ReplicatedStorage (copy), Util (copy), LocalPlayer (copy), vfxUtil (copy), script_xamillmesh (copy), mainreplication2 (copy)
    local u70 = p69.HumanoidRootPart or p69.PrimaryPart;
    local u71 = ReplicatedStorage.Resources.aiku.Fx0:Clone();
    u71.Parent = workspace.Effects;

    if Util.canshiftcolor(LocalPlayer, p69) then
        vfxUtil.LeanTowardsColor(u71, p69:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p69:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.delay(0.15, function() -- Line: 1866
        -- upvalues: u71 (copy), u70 (copy), script_xamillmesh (ref), ReplicatedStorage (ref), mainreplication2 (ref)
        u71:PivotTo(u70.CFrame);

        for _, child in u71.Mesh.M1:GetChildren() do
            script_xamillmesh(child);
        end;

        local v72 = ReplicatedStorage.Resources.aiku.effReflek:Clone();
        v72.Weld.Part0 = u70;
        v72.Parent = workspace.Effects;
        task.delay(3, v72.Destroy, v72);

        for _, descendant in pairs(v72:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        mainreplication2.cameraShake(10, 0.6, 3);
        mainreplication2.bodyVelocity(u70, 70, 0.35, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
    end);
    task.delay(0.317, function() -- Line: 1890
        -- upvalues: u71 (copy), u70 (copy), script_xamillmesh (ref), mainreplication2 (ref)
        u71:PivotTo(u70.CFrame);

        for _, child in u71.Mesh.M2:GetChildren() do
            script_xamillmesh(child);
        end;

        for _, descendant in pairs(u71.WindFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        mainreplication2.cameraShake(10, 0.3, 6);
        mainreplication2.bodyVelocity(u70, 175, 0.35, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0));
        mainreplication2.fov(false, 100);
        mainreplication2.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
    end);
end;

function u1.reflexTackleHit(u73, u74) -- Line: 1913
    -- upvalues: ReplicatedStorage (copy), mainreplication2 (copy), script_xamillmesh (copy), Players (copy), Lighting (copy), TweenService (copy)
    local u75 = u73.HumanoidRootPart or u73.PrimaryPart;
    local u76 = ReplicatedStorage.Resources.aiku.Fx:Clone();
    u76.Parent = workspace.Effects;
    mainreplication2.highlight(u73, Color3.fromRGB(75, 120, 48), 0.5);
    mainreplication2.highlight(u74, Color3.fromRGB(75, 120, 48), 0.5);
    task.delay(0.017, function() -- Line: 1922
        -- upvalues: u76 (copy), u75 (copy), script_xamillmesh (ref), mainreplication2 (ref)
        u76:PivotTo(u75.CFrame);

        for _, child in u76.Mesh.M0:GetChildren() do
            script_xamillmesh(child);
        end;

        for _, descendant in pairs(u76.Trail1Part:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u76.Trail2Part:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = true;
            end;
        end;

        mainreplication2.cameraShake(10, 0.5, 4);
    end);
    task.delay(0.15, function() -- Line: 1946
        -- upvalues: u76 (copy), script_xamillmesh (ref), mainreplication2 (ref), u75 (copy), u73 (copy), Players (ref), u74 (copy), Lighting (ref), TweenService (ref), ReplicatedStorage (ref)
        for _, child in u76.Mesh.M1:GetChildren() do
            script_xamillmesh(child);
        end;

        for _, descendant in pairs(u76.ImpactFx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;

        mainreplication2.cameraShake(10, 0.3, 6);
        mainreplication2.bodyVelocity(u75, 120, 0.25, nil, nil, nil, TweenInfo.new(1, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0));
        mainreplication2.fov(false, 60);
        mainreplication2.fov(true, 70, 0.85, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
        mainreplication2.highlight(u73, Color3.fromRGB(75, 120, 48), 1.5);

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(u73) or Players.LocalPlayer == Players:GetPlayerFromCharacter(u74) then
            local BlurEffect = Instance.new("BlurEffect");
            BlurEffect.Size = 25;
            BlurEffect.Parent = Lighting;
            TweenService:Create(BlurEffect, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = 0
            }):Play();
            task.delay(0.15, BlurEffect.Destroy, BlurEffect);
            local v77 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v77.Parent = Lighting;
            v77.TintColor = Color3.fromRGB(137, 255, 3);
            v77.Brightness = 0.4;
            v77.Contrast = 1;
            v77.Saturation = -0.4;
            TweenService:Create(v77, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                Saturation = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(0.5, v77.Destroy, v77);
        end;
    end);
    task.delay(0.283, function() -- Line: 2010
        -- upvalues: u76 (copy), u75 (copy)
        u76:PivotTo(u75.CFrame);

        for _, descendant in pairs(u76.Trail1Part:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u76.Trail2Part:GetDescendants()) do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

function u1.aikuPenaltyBoxFlow(p78: userdata) -- Line: 2029
    -- upvalues: vfxUtil (copy), mainreplication2 (copy), Util (copy), LocalPlayer (copy), soundUtil (copy), SoundService (copy), MoonPropertyAnimator (copy)
    local PenaltySave = vfxUtil.getResources().aiku.PenaltySave;
    local Root = vfxUtil.getRoot(p78);
    local u79 = vfxUtil.character_trove(p78);
    mainreplication2.sceneEnabled(true);
    mainreplication2.ultFlash(1);
    local v80 = u79:Construct(PenaltySave.UserVFX);
    vfxUtil.setupAura(p78, v80, true);
    v80.Parent = workspace.Effects;
    local v81 = u79:Clone(PenaltySave.Domain);
    v81:PivotTo(Root.CFrame);
    v81.Parent = workspace;

    if Util.canshiftcolor(LocalPlayer, p78) then
        vfxUtil.LeanTowardsColor(v80, p78:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), p78:GetAttribute("CustomAlpha") or 0.985);
    end;

    soundUtil:play(PenaltySave.sound, SoundService);
    local _, v82 = mainreplication2.cutsceneCamRigWithLetterBox(Root, PenaltySave.Camera, PenaltySave.FOV, p78, "default", PenaltySave["CamRigWithLetterBox "]);
    u79:Add(v82);
    local v83 = {
        Vignette = u79:Add(vfxUtil.getMoonEffects()).Vignette,
        Workspace = v81
    };
    vfxUtil.contain_lighting(u79, v83, PenaltySave.Lighting);
    local v84 = u79:Construct(MoonPropertyAnimator);
    v84:LoadAndConvertSave(PenaltySave.Moon, v83);
    v84:SetRoot(Root);
    v84:SetOriginalRoot(CFrame.new(-19.088, 3, -0));
    v84:PlayAll();
    vfxUtil.execute_compiled(PenaltySave.Compiled, u79, v80);
    u79:Add(function() -- Line: 2074
        -- upvalues: mainreplication2 (ref)
        mainreplication2.sceneEnabled(false);
        mainreplication2.ultFlash(1);
    end);
    u79:Add(task.delay(3.3, function() -- Line: 2079
        -- upvalues: u79 (copy)
        u79:Destroy();
    end));
end;

function u1.aikuAwk(u85, p86) -- Line: 2084
    -- upvalues: Players (copy), Util (copy), LocalPlayer (copy), Lighting (copy), mainreplication2 (copy), ReplicatedStorage (copy), vfxUtil (copy), RunService (copy), soundUtil (copy), SoundService (copy), TekrinnDialogue (copy), TweenService (copy), Brightness (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u85);
    local v87;

    if u85:GetAttribute("FunnyVoicelines") == true then
        v87 = true;
    else
        v87 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(LocalPlayer, "modifiedVoices");
    end;

    u85:FindFirstChild("Ball");
    local v88 = u85.HumanoidRootPart or u85.PrimaryPart;
    local _ = u85.Torso;
    local _ = Lighting.Atmosphere;
    mainreplication2.sceneEnabled(true);
    mainreplication2.ultFlash(1);
    local u89 = ReplicatedStorage.Resources.aiku.allEffectAwk:Clone();
    u89:PivotTo(v88.CFrame);
    u89.Parent = u85;

    if Util.canshiftcolor(LocalPlayer, u85) then
        vfxUtil.LeanTowardsColor(u89, u85:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u85:GetAttribute("CustomAlpha") or 0.985);
    end;

    for _, descendant in pairs(u89:GetDescendants()) do
        if descendant:IsA("Beam") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = false;
        elseif descendant:IsA("BasePart") or descendant:IsA("Texture") then
            descendant.Transparency = 1;
        end;
    end;

    local u90 = ReplicatedStorage.Resources.aiku.camEffectAwk:Clone();
    u90.Parent = u89;
    local u91 = nil;
    u91 = RunService.PreRender:connect(function() -- Line: 2117
        -- upvalues: u90 (copy), u91 (ref)
        if u90:IsDescendantOf(game) then
            u90.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u91:Disconnect();
    end);
    local u92 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u92.Parent = Lighting;
    u92.FarIntensity = 1;
    local v93 = not v87 and u85:GetAttribute("femlock");
    local v94;

    if v87 then
        v94 = ReplicatedStorage.Resources.aiku["aiku awake_rnp"];
    elseif v93 then
        v94 = ReplicatedStorage.Resources.aiku.Femvoicelines.awkhitvar;
    else
        v94 = ReplicatedStorage.Resources.aiku["aiku awake_1"];
    end;

    local u95 = v93 or soundUtil:play(v94, SoundService, {
        Character = u85
    }).Name == "Dub";
    mainreplication2.cutsceneBlender(v88, ReplicatedStorage.Resources.aiku.aikuAwkCam, ReplicatedStorage.Resources.aiku.awkFOV);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Parent = Lighting;

    if v87 then
        task.delay(1.323, function() -- Line: 2220
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "What\'s up everybody?!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(2.266, function() -- Line: 2243
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "My name is Oliver Aiku!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(3.702, function() -- Line: 2266
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "As if I\'m gonna let YOU do that!",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 4);
        end);
        task.delay(6.7, function() -- Line: 2289
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "And also...",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
        task.delay(8.162, function() -- Line: 2312
            -- upvalues: TekrinnDialogue (ref), u85 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Text = "You\'re on MY leash.",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 2
                    }
                }
            }, 2);
        end);
    else
        task.delay(6.383, function() -- Line: 2142
            -- upvalues: TekrinnDialogue (ref), u85 (copy), u95 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.01,
                    Text = u95 and "As long as I\'m on patrol..." or "While I\'m on patrol...",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 4,
                        Lifetime = 1
                    }
                }
            }, 3);
        end);
        task.delay(8.317, function() -- Line: 2168
            -- upvalues: TekrinnDialogue (ref), u85 (copy), u95 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u95 and "you ain\'t stealing no goals from me" or "you won\'t be stealing any goals.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 3);
        end);
        task.delay(10.25, function() -- Line: 2194
            -- upvalues: TekrinnDialogue (ref), u85 (copy), u95 (copy)
            TekrinnDialogue.Speak(u85, {
                {
                    Bold = true,
                    Italic = true,
                    TypeSpeed = 0.01,
                    Text = u95 and "You li\'l burglar." or "Li\'l burglar.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 2,
                        Lifetime = 1
                    }
                }
            }, 1);
        end);
    end;

    task.delay(0.15, function() -- Line: 2337
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikugrassstep1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u89.aikurunwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(0.383, function() -- Line: 2352
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikugrassstep2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.7, function() -- Line: 2361
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikugrassstep3:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1, function() -- Line: 2370
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikugrassstep4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(1.083, function() -- Line: 2379
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.aikuright:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.233, function() -- Line: 2388
        -- upvalues: u89 (copy), TweenService (ref)
        for _, descendant in pairs(u89.aikurunwindvfx:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        TweenService:Create(u89.domain, TweenInfo.new(0.5), {
            Transparency = 0.4
        }):Play();
    end);
    task.delay(1.3, function() -- Line: 2399
        -- upvalues: u90 (copy), u89 (copy)
        for _, descendant in pairs(u90.aikuright:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u89.aikurunwindvfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(1.45, function() -- Line: 2414
        -- upvalues: u89 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u89.aikubigstepawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v96 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Brightness = 0.25,
            TintColor = Color3.fromRGB(71, 180, 255)
        });
        v96:Play();
        v96.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    local u97 = {};
    task.delay(1.5, function() -- Line: 2431
        -- upvalues: u89 (copy), u90 (copy), ReplicatedStorage (ref), u85 (copy), u97 (copy)
        for _, descendant in pairs(u89.aikushieldemit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u89.aikuroboticstuff:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u90.effectthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        local v98 = ReplicatedStorage.Resources.aiku.eyeEff:Clone();
        v98.Weld.Part0 = u85.Head;
        v98.Parent = u89;
        table.insert(u97, v98);

        for _, descendant in ipairs(u85:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v99 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.aiku.auraTable:GetDescendants()) do
                    local v100 = descendant2:Clone();
                    v100.Parent = v99;
                    table.insert(u97, v100);
                end;
            end;
        end;
    end);
    task.delay(2.233, function() -- Line: 2478
        -- upvalues: TweenService (ref), u89 (copy)
        TweenService:Create(u89.domain, TweenInfo.new(2), {
            Transparency = 1
        }):Play();
    end);
    task.delay(3.383, function() -- Line: 2482
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikuawkballkick:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u89.aikurunwindvfx2:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(3.583, function() -- Line: 2497
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.effectthing:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4, function() -- Line: 2506
        -- upvalues: ColorCorrectionEffect (copy), TweenService (ref)
        ColorCorrectionEffect.TintColor = Color3.fromRGB(174, 255, 173);
        ColorCorrectionEffect.Contrast = 1;
        ColorCorrectionEffect.Saturation = -1;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(4.067, function() -- Line: 2514
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikuawktacklehit:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(4.5, function() -- Line: 2523
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.aikuleft:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.633, function() -- Line: 2532
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikurunwindvfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(4.75, function() -- Line: 2541
        -- upvalues: u90 (copy)
        for _, descendant in pairs(u90.aikuleft:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.333, function() -- Line: 2550
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikurunwindvfx1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(5.433, function() -- Line: 2559
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikuawktacklereal:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(5.883, function() -- Line: 2568
        -- upvalues: u89 (copy)
        for _, descendant in pairs(u89.aikuawkfinalkickland:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(8.467, function() -- Line: 2585
        -- upvalues: u89 (copy), TweenService (ref), ColorCorrectionEffect (copy)
        for _, descendant in pairs(u89.aikubigstepawk:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        local v101 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(174, 255, 173)
        });
        v101:Play();
        v101.Completed:Wait();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(10.667, function() -- Line: 2600
        -- upvalues: mainreplication2 (ref), u92 (copy), ColorCorrectionEffect (copy), u89 (copy), u97 (copy), Lighting (ref), Brightness (ref)
        mainreplication2.blackscene(1);
        u92:Destroy();
        ColorCorrectionEffect:Destroy();
        u89:Destroy();

        for _, v in u97 do
            v:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        Lighting.Brightness = Brightness;
    end);
end;

function u1.formerstriker(u102, p103) -- Line: 2631
    -- upvalues: Players (copy), Util (copy), LocalPlayer (copy), Lighting (copy), soundUtil (copy), ReplicatedStorage (copy), SoundService (copy), mainreplication2 (copy), vfxUtil (copy), MeshEmitter (copy), workspace_CurrentCamera (copy), Debris (copy), RunService (copy), actionUtil (copy), TekrinnDialogue (copy), Brightness (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(u102);
    local v104;

    if u102:GetAttribute("FunnyVoicelines") == true then
        v104 = true;
    else
        v104 = Util.isSettingEnabled(PlayerFromCharacter, "britishaikuevil") and Util.isSettingEnabled(LocalPlayer, "modifiedVoices");
    end;

    local Ball = u102:FindFirstChild("Ball");
    local v105 = u102.HumanoidRootPart or u102.PrimaryPart;
    local _ = u102.Torso;
    local _ = Lighting.Atmosphere;
    local v106 = not v104 and u102:GetAttribute("femlock");
    local v107;

    if v104 then
        v107 = ReplicatedStorage.Resources.aiku.formerstriker_rnp;
    elseif v106 then
        v107 = ReplicatedStorage.Resources.aiku.Femvoicelines.wagamama;
    else
        v107 = ReplicatedStorage.Resources.aiku.formerstriker;
    end;

    local u108 = v106 or soundUtil:play(v107, SoundService, {
        Character = u102
    }).Name == "Dub";
    mainreplication2.sceneEnabled(true);
    mainreplication2.cutsceneBlender(v105, ReplicatedStorage.Resources.aiku.formercam, ReplicatedStorage.Resources.aiku.FOV3);
    local u109 = ReplicatedStorage.Resources.aiku.forma.rootpos:Clone();
    u109.Weld.Part0 = v105;
    u109.Parent = u102;
    local u110 = ReplicatedStorage.Resources.aiku.ballku:Clone();
    u110.Weld.Part0 = Ball;
    u110.Parent = u102;
    local ScreenDimmer = vfxUtil.getScreenDimmer();
    local u111 = Util.Preload({ ReplicatedStorage.Resources.aiku.ImpactFrame1, ReplicatedStorage.Resources.aiku.ImpactFrame2 });
    local u112 = MeshEmitter.StartMeshEmitter(v105, ReplicatedStorage.Resources.aiku.formercc, nil);

    for _, v in ipairs({ u112.formercolor }) do
        if not Util.isepilepsysafe() then
            v.Parent = workspace_CurrentCamera;
        end;

        task.delay(15, function() -- Line: 2666
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    local u113 = ReplicatedStorage.Resources.aiku.beampart:Clone();
    u113.Parent = u102;
    u113.HumanoidRootPart.Part1 = v105;
    Debris:AddItem(u113, 30);
    local u114 = ReplicatedStorage.Resources.DepthOfField:Clone();
    u114.Parent = Lighting;
    u114.FarIntensity = 1;
    local u115 = ReplicatedStorage.Resources.aiku.formcampart:Clone();
    u115.Parent = u102;
    local u116 = nil;
    u116 = RunService.PreRender:connect(function() -- Line: 2681
        -- upvalues: u115 (copy), u116 (ref)
        if u115:IsDescendantOf(game) then
            u115.CFrame = workspace.CurrentCamera.CFrame;

            return;
        end;

        u116:Disconnect();
    end);
    local u117 = {};
    task.spawn(function() -- Line: 2689
        -- upvalues: ReplicatedStorage (ref), u102 (copy), u117 (copy)
        local v118 = ReplicatedStorage.Resources.aiku.eyeEff:Clone();
        v118.Weld.Part0 = u102.Head;
        v118.Parent = u102;
        table.insert(u117, v118);

        for _, descendant in ipairs(u102:GetDescendants()) do
            if descendant:IsA("Part") and descendant.Transparency < 1 then
                local v119 = descendant;

                for _, descendant2 in ipairs(ReplicatedStorage.Resources.aiku.auratable2:GetDescendants()) do
                    local v120 = descendant2:Clone();
                    v120.Parent = v119;
                    table.insert(u117, v120);
                end;
            end;
        end;
    end);
    local v121 = {
        u115,
        u113,
        u109,
        u110,
        u117
    };

    if Util.canshiftcolor(LocalPlayer, u102) then
        vfxUtil.LeanTowardsColor(v121, u102:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), u102:GetAttribute("CustomAlpha") or 0.985);
    end;

    task.spawn(function() -- Line: 2716
        -- upvalues: u109 (copy), u115 (copy)
        for _, descendant in pairs(u109.aikuawkpopemitformer:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u109.aikustepstriker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u109.aikugridballformer:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.31666666666666665, function() -- Line: 2748
        -- upvalues: u115 (copy)
        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 0.65;
            end;
        end;

        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(0.36666666666666664, function() -- Line: 2762
        -- upvalues: u117 (copy), u110 (copy)
        for _, v in u117 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u110:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u110.MainFlareAiku:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    local v122 = {};

    for _, child in workspace.characters:GetChildren() do
        if actionUtil.checkStyle(Players:GetPlayerFromCharacter(child)) == "sae" then
            table.insert(v122, child);
        end;
    end;

    local u123, u124;

    if #v122 >= 1 then
        u123 = v122[math.random(#v122)];
        u124 = "rbxassetid://87031389627015";
    else
        u123 = "???";
        u124 = nil;
    end;

    if v104 then
        task.delay(0.764, function() -- Line: 2877
            -- upvalues: TekrinnDialogue (ref), u123 (ref), u124 (ref)
            TekrinnDialogue.Speak(u123, {
                {
                    Text = "Now\'s your time Oliver...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 87, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 3, u124, Color3.fromRGB(255, 60, 135));
        end);
        task.delay(3.35, function() -- Line: 2903
            -- upvalues: TekrinnDialogue (ref), u102 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Text = "Unluckily for you, I happen to be a former striker..",
                    Bold = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(5.917, function() -- Line: 2926
            -- upvalues: TekrinnDialogue (ref), u102 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Text = "WATCH OUT MATE-",
                    Bold = true,
                    TypeSpeed = 0.01,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(7.192, function() -- Line: 2949
            -- upvalues: TekrinnDialogue (ref), u102 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Text = "THIS IS MY DIRECT..",
                    Bold = true,
                    TypeSpeed = 0.02,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 2
                    }
                }
            }, 3);
        end);
        task.delay(9.484, function() -- Line: 2972
            -- upvalues: TekrinnDialogue (ref), u102 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Text = ".. SHOT!!!",
                    Bold = true,
                    TypeSpeed = 0.05,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 3
                    }
                }
            }, 3.215);
        end);
    else
        task.delay(0.993, function() -- Line: 2801
            -- upvalues: TekrinnDialogue (ref), u123 (ref), u124 (ref)
            TekrinnDialogue.Speak(u123, {
                {
                    Text = "Selfish captain...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.03,
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 87, 132)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = false,
                        Intensity = 1,
                        Lifetime = 1
                    }
                }
            }, 1.8, u124, Color3.fromRGB(255, 60, 135));
        end);
        task.delay(3.1, function() -- Line: 2826
            -- upvalues: TekrinnDialogue (ref), u102 (copy), u108 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.04,
                    Text = u108 and "Too bad for you guys, I just so happen to be a former striker." or "Unfortunately for you, I happen to be a former striker.",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 1.5,
                        Lifetime = 5.5
                    }
                }
            }, 2.9);
        end);
        task.delay(7.166666666666667, function() -- Line: 2851
            -- upvalues: TekrinnDialogue (ref), u102 (copy), u108 (copy)
            TekrinnDialogue.Speak(u102, {
                {
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    Text = u108 and "It\'s been fun, but this is the end for you, SOCCER GAME!" or "This is the end for you, SOCCER GAME!",
                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 0)) }),
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Shake = {
                        Enabled = true,
                        Intensity = 3,
                        Lifetime = 3
                    }
                }
            }, 3);
        end);
    end;

    task.delay(2.2666666666666666, function() -- Line: 2997
        -- upvalues: u115 (copy), u117 (copy), u109 (copy), u113 (copy)
        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, v in u117 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u109.aikustepstriker:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;

        for _, descendant in pairs(u113:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(3.8666666666666667, function() -- Line: 3031
        -- upvalues: u110 (copy)
        for _, descendant in pairs(u110:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;
    end);
    task.delay(7.166666666666667, function() -- Line: 3039
        -- upvalues: u115 (copy)
        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u115:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.TimeScale = 1;
            end;
        end;
    end);
    task.delay(11.083333333333334, function() -- Line: 3053
        -- upvalues: u110 (copy), u109 (copy), Util (ref), ReplicatedStorage (ref)
        for _, descendant in pairs(u110:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        for _, descendant in pairs(u109.aikukick1former:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;

        Util.Gif(ReplicatedStorage.Resources.aiku.ImpactFrame1, 24);
    end);
    task.delay(12.133333333333333, function() -- Line: 3068
        -- upvalues: u117 (copy), u110 (copy)
        for _, v in u117 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;

        for _, descendant in pairs(u110:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(12.267, function() -- Line: 3082
        -- upvalues: Util (ref), ReplicatedStorage (ref), u113 (copy)
        Util.Gif(ReplicatedStorage.Resources.aiku.ImpactFrame2, 24);

        for _, descendant in pairs(u113:GetDescendants()) do
            if descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(12.3, function() -- Line: 3091
        -- upvalues: u109 (copy)
        for _, descendant in pairs(u109.aikukick2former:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
            end;
        end;
    end);
    task.delay(13.666666666666666, function() -- Line: 3099
        -- upvalues: u117 (copy)
        for _, v in u117 do
            if v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;
        end;
    end);
    task.delay(13.667, function() -- Line: 3110
        -- upvalues: ScreenDimmer (copy), u111 (copy), mainreplication2 (ref), u112 (copy), u114 (copy), u109 (copy), u115 (copy), u110 (copy), u117 (copy), Lighting (ref), Brightness (ref)
        ScreenDimmer:Destroy();
        u111:Destroy();
        mainreplication2.ultFlash(1);
        u112:Destroy();
        u114:Destroy();
        u109:Destroy();
        u115:Destroy();
        u110:Destroy();

        for _, v in u117 do
            v:Destroy();
        end;

        mainreplication2.sceneEnabled(false);
        Lighting.Brightness = Brightness;
    end);
end;

for i, v in require(script.Mastery) do
    u1[i] = v;
end;

return u1;
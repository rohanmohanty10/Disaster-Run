 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local mainreplication = require(script.Parent.Parent.Parent.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.Parent.TekrinnDialogue);
local MeshEmitter = require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local _ = Lighting.Brightness;
local PlayerGui = Players.LocalPlayer.PlayerGui;
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.GeographicLatitude;
local Brightness = Lighting.Brightness;
local _ = Lighting.ClockTime;
local Ambient = Lighting.Ambient;
local _ = Lighting.OutdoorAmbient;
local ExposureCompensation = Lighting.ExposureCompensation;
local Threshold = Lighting.Bloom.Threshold;
local _ = Lighting.EnvironmentDiffuseScale;
local _ = Lighting.EnvironmentSpecularScale;
local _ = Lighting.ColorCorrection.Contrast;
local _ = Lighting.ColorCorrection.Saturation;
local _ = Lighting.Bloom.Threshold;

return function(u1: table) -- Line: 45
    -- upvalues: ReplicatedStorage (copy), mainreplication (copy), Players (copy), Lighting (copy), TweenService (copy), Debris (copy), PlayerGui (copy), soundUtil (copy), SoundService (copy), MeshEmitter (copy), RunService (copy), Util (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local Value = u1.Character.Value;
    local u2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local chigiri = ReplicatedStorage.Resources.chigiri;
    u1.Variant.Changed:Connect(function(p3) -- Line: 50
        -- upvalues: mainreplication (ref), Value (copy), u2 (copy), Players (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), chigiri (copy), Debris (ref), u1 (copy), PlayerGui (ref), soundUtil (ref), SoundService (ref), MeshEmitter (ref), RunService (ref), Util (ref), TekrinnDialogue (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Density (ref), Color (ref)
        if p3 == 1 then
            mainreplication.destroyVelocity(Value);
            mainreplication.bodyVelocity(u2, 115 * (Value:GetAttribute("chigiri_winger") and 1.5 or 1), 1.5, nil, nil, nil, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

            if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                mainreplication.fov(false, 100);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                mainreplication.springcamerashake(10, 80);
                local v4 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                v4.Parent = Lighting;
                v4.TintColor = Color3.fromRGB(255, 111, 142);
                v4.Brightness = 0.4;
                v4.Contrast = 1;
                v4.Saturation = -0.4;
                TweenService:Create(v4, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Saturation = 0
                }):Play();
                TweenService:Create(v4, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Contrast = 0,
                    Brightness = 0,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                task.delay(2, v4.Destroy, v4);
            end;

            if Value:FindFirstChild("ChigiriStartupBeam") then
                Value:FindFirstChild("ChigiriStartupBeam"):Destroy();
            end;

            local TweenService2 = game:GetService("TweenService");
            local u5 = chigiri.ChigiriHitBeam:Clone();
            u5.Weld.C0 = CFrame.new(0, 4, -1.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
            u5.Weld.Part1 = u2;
            u5.Parent = workspace.Effects;
            local u6 = nil;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Parent = u5;
            NumberValue.Value = 1;
            task.spawn(function() -- Line: 91
                -- upvalues: u6 (ref), TweenService2 (copy), NumberValue (copy), u5 (copy)
                u6 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) });
                TweenService2:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Value = 0
                }):Play();
                task.spawn(function() -- Line: 100
                    -- upvalues: u5 (ref), u6 (ref), TweenService2 (ref), NumberValue (ref)
                    for _, descendant in pairs(u5:GetDescendants()) do
                        task.spawn(function() -- Line: 102
                            -- upvalues: descendant (copy), u6 (ref), TweenService2 (ref), NumberValue (ref)
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                                descendant.Transparency = u6;
                                descendant.TextureSpeed = 10;
                                TweenService2:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    TextureSpeed = 0.01
                                }):Play();
                                NumberValue.Changed:Connect(function() -- Line: 110
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    task.spawn(function() -- Line: 111
                                        -- upvalues: descendant (ref), NumberValue (ref)
                                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                    end);
                                end);
                                task.delay(0.45, function() -- Line: 119
                                    -- upvalues: NumberValue (ref), descendant (ref)
                                    NumberValue.Changed:Connect(function() -- Line: 120
                                        -- upvalues: descendant (ref), NumberValue (ref)
                                        task.spawn(function() -- Line: 121
                                            -- upvalues: descendant (ref), NumberValue (ref)
                                            descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                        end);
                                    end);
                                    task.wait(1);
                                    descendant.Enabled = false;
                                    NumberValue:Destroy();
                                end);
                            end;
                        end);
                    end;
                end);
                task.delay(0.45, function() -- Line: 137
                    -- upvalues: TweenService2 (ref), NumberValue (ref)
                    TweenService2:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Value = 1
                    }):Play();
                end);
            end);

            if not (shared.allvfxcheck and shared.allvfxcheck()) then
                local u7 = chigiri.chigirinsdrunvfx:Clone();
                u7.Weld.Part1 = u2;
                u7.Weld.C0 = CFrame.new(0, 0, 3);
                u7.Parent = Value;
                Debris:AddItem(u7, 5);

                for _, descendant in pairs(u7:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                local u8 = chigiri.chigirinsdrunvfx2:Clone();
                u8.Weld.Part1 = u2;
                u8.Weld.C0 = CFrame.new(0, 0, 3);
                u8.Parent = Value;
                Debris:AddItem(u8, 5);

                for _, descendant in pairs(u8:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                local u9 = chigiri.chigirinsdfsvfx:Clone();
                u9.Weld.Part1 = u2;
                u9.Weld.C0 = CFrame.new(0, 0, -5);
                u9.Parent = Value;
                Debris:AddItem(u9, 5);

                for _, descendant in pairs(u9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u9:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;

                task.delay(0.9, function() -- Line: 185
                    -- upvalues: u7 (copy), u8 (copy), u9 (copy)
                    for _, descendant in pairs(u7:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    for _, descendant in pairs(u8:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    for _, descendant in pairs(u9:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = false;
                        end;
                    end;

                    for _, descendant in pairs(u9:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                        end;
                    end;
                end);
            end;

            return;
        end;

        if p3 ~= 2 then
            if p3 == 3 then
                mainreplication.bodyVelocity(u2, 50, 0.6, nil, nil, nil, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));
            end;

            return;
        end;

        local Value2 = u1.Victim.Value;

        if not Value2 then
            return;
        end;

        local _ = Value.Torso;
        local Atmosphere = Lighting.Atmosphere;
        Value:FindFirstChild("Ball");
        local chigiri2 = ReplicatedStorage.Resources.chigiri;
        local u10 = ReplicatedStorage.Resources.uibox:Clone();
        u10.Parent = PlayerGui;
        Lighting.Brightness = 1;
        Lighting.Ambient = Color3.fromRGB(157, 181, 248);
        Lighting.ExposureCompensation = 1;
        Lighting.Bloom.Threshold = 3.55;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Contrast = 0.25;
        ColorCorrectionEffect.Saturation = -0.1;
        ColorCorrectionEffect.Brightness = 0;
        local u11 = ReplicatedStorage.Resources.DepthOfField:Clone();
        u11.Parent = Lighting;
        u11.FarIntensity = 1;
        local u12 = ReplicatedStorage.Resources.ColorCorrection:Clone();
        u12.Parent = Lighting;
        u12.TintColor = Color3.fromRGB(255, 111, 142);
        u12.Brightness = 0.4;
        u12.Contrast = 1;
        u12.Saturation = -0.4;
        TweenService:Create(u12, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Saturation = 0
        }):Play();
        TweenService:Create(u12, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Contrast = 0,
            Brightness = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        local u13 = soundUtil:play(ReplicatedStorage.Resources.chigiri.steal, SoundService, {
            Character = Value
        });
        mainreplication.sceneEnabled(true);
        mainreplication.cutscene(u2, CFrame.new(Vector3.new(0, 0, 0)), 9.36, ReplicatedStorage.Resources.chigiri.STEALFOV);
        mainreplication.ultFlash(1);
        Debris:AddItem(MeshEmitter.StartMeshEmitter(u2, chigiri2["Outrun MeshEmitter"]), 9.36);
        local u14 = chigiri2.RootAttachment:Clone();
        u14.Weld.Part0 = u2;
        u14.Parent = u2;
        Debris:AddItem(u14, 9.36);
        local u15 = chigiri2.HeadAttachment:Clone();
        u15.Weld.Part0 = Value.Head;
        u15.Parent = u2;
        Debris:AddItem(u15, 9.36);
        local u16 = chigiri2.UltStealCamPart:Clone();
        u16.Parent = Value;
        Debris:AddItem(u16, 9.36);
        local u17 = RunService.PreRender:connect(function() -- Line: 272
            -- upvalues: u16 (copy)
            u16.CFrame = workspace.CurrentCamera.CFrame;
        end);
        u16.AncestryChanged:Once(function() -- Line: 276
            -- upvalues: u17 (ref)
            u17:Disconnect();
        end);
        local v18 = {
            { Value, "ChigiriREDPanther" },
            { workspace.Effects, (`{Value.Name}-ChigiriRun`) },
            { u2, "ChigiriUltRun" }
        };

        for _, v in ipairs(v18) do
            if v[1] then
                local v19 = v[1]:FindFirstChild(v[2]);

                if v19 then
                    v19:Destroy();
                end;
            end;
        end;

        local u20 = Util.Preload({ ReplicatedStorage.Resources.chigiri.AwakeningImpact4 });
        Util.Timeline({
            [0] = function() -- Line: 297
                -- upvalues: u14 (copy)
                for _, descendant in pairs(u14["1"]:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [0.95] = function() -- Line: 305
                -- upvalues: u16 (copy)
                for _, descendant in pairs(u16.BeamHolder1:GetDescendants()) do
                    if descendant.ClassName == "Beam" then
                        descendant.Enabled = true;
                    end;
                end;
            end,

            [1.083] = function() -- Line: 313
                -- upvalues: u13 (copy), TekrinnDialogue (ref), Value2 (copy)
                if u13.Name == "Dub" then
                    TekrinnDialogue.Speak(Value2, {
                        {
                            Text = "Team Z, Say goodbye. Cause this game is ours!",
                            Bold = true,
                            Italic = true,
                            TypeSpeed = 0.03,
                            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                            TextStrokeColor = Color3.new(0, 0, 0),
                            Shake = {
                                Enabled = false,
                                Intensity = 3,
                                Lifetime = 0.5
                            }
                        }
                    }, 3);

                    return;
                end;

                TekrinnDialogue.Speak(Value2, {
                    {
                        Text = "All right, it\'s clear. And that\'s game over-",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = false,
                            Intensity = 3,
                            Lifetime = 0.5
                        }
                    }
                }, 3);
            end,

            [3.8] = function() -- Line: 364
                -- upvalues: u16 (copy), u15 (copy)
                for _, descendant in pairs(u16.BeamHolder1:GetDescendants()) do
                    if descendant.ClassName == "Beam" then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u15["2"]:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;
            end,

            [3.916] = function() -- Line: 378
                -- upvalues: u15 (copy)
                for _, descendant in pairs(u15.breath:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [4.117] = function() -- Line: 386
                -- upvalues: u13 (copy), TekrinnDialogue (ref), Value (ref)
                if u13.Name == "Dub" then
                    TekrinnDialogue.Speak(Value, {
                        {
                            Text = "Move it.",
                            Bold = true,
                            Italic = true,
                            TypeSpeed = 0.01,
                            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 135)) }),
                            TextStrokeColor = Color3.new(0, 0, 0),
                            Shake = {
                                Enabled = true,
                                Intensity = 3,
                                Lifetime = 0.5
                            }
                        }
                    }, 3);

                    return;
                end;

                TekrinnDialogue.Speak(Value, {
                    {
                        Text = "Move.",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 135)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 3,
                            Lifetime = 0.5
                        }
                    }
                }, 3);
            end,

            [4.416] = function() -- Line: 437
                -- upvalues: u15 (copy)
                for _, descendant in pairs(u15["2"]:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end,

            [5] = function() -- Line: 445
                -- upvalues: u14 (copy), u15 (copy), u16 (copy), Util (ref), ReplicatedStorage (ref)
                for _, descendant in pairs(u14["3"]:GetDescendants()) do
                    if descendant.ClassName == "ParticleEmitter" then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;

                for _, descendant in pairs(u15.a2:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u15.a1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u16.af1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                Util.Gif(ReplicatedStorage.Resources.chigiri.AwakeningImpact4, 30);
            end,

            [5.95] = function() -- Line: 474
                -- upvalues: TekrinnDialogue (ref), Value (ref)
                TekrinnDialogue.Speak(Value, {
                    {
                        Text = "Outrun them!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 135)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 3,
                            Lifetime = 0.5
                        }
                    }
                }, 3);
            end,

            [7] = function() -- Line: 499
                -- upvalues: u15 (copy), u16 (copy)
                for _, descendant in pairs(u15.a1:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u15.a2:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u16.af1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end,

            [7.933] = function() -- Line: 519
                -- upvalues: u13 (copy), TekrinnDialogue (ref), Value (ref)
                if u13.Name == "Dub" then
                    TekrinnDialogue.Speak(Value, {
                        {
                            Text = "Feel the rush... and break through.",
                            Bold = true,
                            Italic = true,
                            TypeSpeed = 0.01,
                            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 135)) }),
                            TextStrokeColor = Color3.new(0, 0, 0),
                            Shake = {
                                Enabled = true,
                                Intensity = 5,
                                Lifetime = 0.5
                            }
                        }
                    }, 2);

                    return;
                end;

                TekrinnDialogue.Speak(Value, {
                    {
                        Text = "Let this rush carry you!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 84, 135)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 5,
                            Lifetime = 0.5
                        }
                    }
                }, 2);
            end,

            [9.36] = function() -- Line: 571
                -- upvalues: u20 (copy), mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u10 (copy), u11 (copy), ColorCorrectionEffect (copy), u12 (copy), u15 (copy)
                u20:Destroy();
                mainreplication.ultFlash(1);
                mainreplication.sceneEnabled(false);
                mainreplication.fov(false, 15);
                mainreplication.fov(true, 70, 2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                Lighting.Brightness = Brightness;
                Lighting.Bloom.Threshold = Threshold;
                Lighting.ExposureCompensation = ExposureCompensation;
                Lighting.Ambient = Ambient;
                Atmosphere.Density = Density;
                Atmosphere.Color = Color;
                u10:Destroy();
                u11:Destroy();
                ColorCorrectionEffect:Destroy();
                u12:Destroy();

                for _, descendant in pairs(u15.a1:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u15.a2:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u15.a2:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u15.a1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end
        });
    end);
    task.delay(0, function() -- Line: 626
        -- upvalues: mainreplication (ref), u2 (copy), Players (ref), Value (copy), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), chigiri (copy), Debris (ref)
        mainreplication.bodyVelocity(u2, 105, 1, nil, nil, nil, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out));

        if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
            mainreplication.fov(false, 80);
            mainreplication.fov(true, 70, 2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
            mainreplication.springcamerashake(10, 45);
            local v21 = ReplicatedStorage.Resources.ColorCorrection:Clone();
            v21.Parent = Lighting;
            v21.TintColor = Color3.fromRGB(255, 111, 142);
            v21.Brightness = 0.4;
            v21.Contrast = 1;
            v21.Saturation = -0.4;
            TweenService:Create(v21, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Saturation = 0
            }):Play();
            TweenService:Create(v21, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Contrast = 0,
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
            task.delay(2, v21.Destroy, v21);
        end;

        local TweenService2 = game:GetService("TweenService");
        local u22 = chigiri.ChigiriStartupBeam:Clone();
        u22.Weld.C0 = CFrame.new(0, 4, -1.5) * CFrame.Angles(-1.5707963267948966, 0, 0);
        u22.Weld.Part1 = u2;
        u22.Parent = Value;
        Debris:AddItem(u22, 10);
        local NumberValue = Instance.new("NumberValue");
        local u23 = nil;
        NumberValue.Parent = u22;
        NumberValue.Value = 1;
        task.spawn(function() -- Line: 661
            -- upvalues: u23 (ref), TweenService2 (copy), NumberValue (copy), u22 (copy)
            u23 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.5), NumberSequenceKeypoint.new(1, 1) });
            TweenService2:Create(NumberValue, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            task.spawn(function() -- Line: 670
                -- upvalues: u22 (ref), u23 (ref), TweenService2 (ref), NumberValue (ref)
                for _, descendant in pairs(u22:GetDescendants()) do
                    task.spawn(function() -- Line: 672
                        -- upvalues: descendant (copy), u23 (ref), TweenService2 (ref), NumberValue (ref)
                        if descendant:IsA("Beam") then
                            descendant.Enabled = true;
                            descendant.Transparency = u23;
                            descendant.TextureSpeed = 10;
                            TweenService2:Create(descendant, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                TextureSpeed = 0.01
                            }):Play();
                            NumberValue.Changed:Connect(function() -- Line: 680
                                -- upvalues: descendant (ref), NumberValue (ref)
                                task.spawn(function() -- Line: 681
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                end);
                            end);
                            task.delay(0.45, function() -- Line: 689
                                -- upvalues: NumberValue (ref), descendant (ref)
                                NumberValue.Changed:Connect(function() -- Line: 690
                                    -- upvalues: descendant (ref), NumberValue (ref)
                                    task.spawn(function() -- Line: 691
                                        -- upvalues: descendant (ref), NumberValue (ref)
                                        descendant.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, NumberValue.Value), NumberSequenceKeypoint.new(1, 1) });
                                    end);
                                end);
                                task.wait(1);
                                descendant.Enabled = false;
                                NumberValue:Destroy();
                            end);
                        end;
                    end);
                end;

                task.delay(0.45, function() -- Line: 706
                    -- upvalues: TweenService2 (ref), NumberValue (ref)
                    TweenService2:Create(NumberValue, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Value = 1
                    }):Play();
                end);
            end);
        end);
        local u24 = chigiri.ChigiriStartupGrass:Clone();
        u24.Weld.Part1 = u2;
        u24.Weld.C0 = CFrame.new(0, 3, 0);
        u24.Parent = Value;
        Debris:AddItem(u24, 5);

        for _, descendant in pairs(u24:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            end;
        end;

        task.delay(0.8, function() -- Line: 724
            -- upvalues: u24 (copy)
            for _, descendant in pairs(u24:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = false;
                end;
            end;
        end);
    end);
end;
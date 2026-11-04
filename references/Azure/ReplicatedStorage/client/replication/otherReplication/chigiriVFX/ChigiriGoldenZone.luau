 

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local SoundService = game:GetService("SoundService");
local Color = Lighting.Atmosphere.Color;
local Density = Lighting.Atmosphere.Density;
local _ = Lighting.GeographicLatitude;
local _ = Lighting.Brightness;
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
local mainreplication = require(ReplicatedStorage.client.replication.mainreplication);
local TekrinnDialogue = require(script.Parent.Parent.Parent.TekrinnDialogue);
require(script.Parent.Parent.Parent.MeshEmitter);
require(ReplicatedStorage.util.raycast);
local animationUtil = require(ReplicatedStorage.util.animationUtil);
local soundUtil = require(ReplicatedStorage.util.soundUtil);
require(ReplicatedStorage.util.actionUtil);
local Util = require(ReplicatedStorage.util.Util);
require(ReplicatedStorage.util.SignalValue);
local vfxUtil = require(ReplicatedStorage.util.vfxUtil);
local trove = require(ReplicatedStorage.forum.trove);
require(ReplicatedStorage.util.KatUtil);
local PlayerGui = Players.LocalPlayer.PlayerGui;
local Brightness = Lighting.Brightness;

return function(p1: table) -- Line: 48
    -- upvalues: ReplicatedStorage (copy), Players (copy), Util (copy), Debris (copy), soundUtil (copy), animationUtil (copy), vfxUtil (copy), mainreplication (copy), trove (copy), RunService (copy), Lighting (copy), TweenService (copy), SoundService (copy), PlayerGui (copy), TekrinnDialogue (copy), Brightness (copy), Threshold (copy), ExposureCompensation (copy), Ambient (copy), Density (copy), Color (copy)
    local Value = p1.Character.Value;
    local u2 = Value.HumanoidRootPart or Value.PrimaryPart;
    local chigiri = ReplicatedStorage.Resources.chigiri;
    p1.Variant.Changed:Connect(function(p3) -- Line: 54
        -- upvalues: Players (ref), Value (copy), chigiri (copy), Util (ref), u2 (copy), Debris (ref), soundUtil (ref), animationUtil (ref), ReplicatedStorage (ref), vfxUtil (ref), mainreplication (ref), trove (ref), RunService (ref), Lighting (ref), TweenService (ref), SoundService (ref), PlayerGui (ref), TekrinnDialogue (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Density (ref), Color (ref)
        if p3 == 1 then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value);
            local v4 = chigiri.ChigiriREDPanther:Clone();
            Util.Weld(u2, u2, v4.RootPart, CFrame.new(
                -5.96046448e-8,
                -3,
                -4.76838466e-7,
                -1,
                7.51293007e-26,
                -8.74230039e-8,
                -3.8515258e-20,
                1,
                4.40562896e-13,
                8.74230039e-8,
                4.40562896e-13,
                -1
            ));
            v4.Parent = Value;
            Debris:AddItem(v4, 6);
            soundUtil:play(chigiri.ChigiriUltRun, u2);
            animationUtil:loadAnimation(v4, chigiri.PANTHERRUN):Play(0);
            local u5 = ReplicatedStorage.Resources.chigiri.vfxrootpart:Clone();
            u5.Weld.Part1 = u2;
            u5.Name = `{Value.Name}-ChigiriRun`;
            u5.Parent = workspace.Effects;
            Debris:AddItem(u5, 4);

            if Util.canshiftcolor(PlayerFromCharacter, Value) then
                vfxUtil.LeanTowardsColor(u5, Value:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Value:GetAttribute("CustomAlpha") or 0.985);
            end;

            local u6 = {};
            Util.Timeline({
                [0] = function() -- Line: 80
                    -- upvalues: u5 (copy), Value (ref), chigiri (ref), u6 (copy)
                    local chigirirunningvfx = u5:FindFirstChild("chigirirunningvfx");

                    if chigirirunningvfx then
                        for _, descendant in pairs(chigirirunningvfx:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;

                    for _, descendant in ipairs(Value:GetDescendants()) do
                        if descendant:IsA("Part") and descendant.Transparency < 1 then
                            local v7 = descendant;

                            for _, descendant2 in ipairs(chigiri.auracontainerr:GetDescendants()) do
                                local v8 = descendant2:Clone();
                                v8.Parent = v7;
                                table.insert(u6, v8);
                            end;
                        end;
                    end;
                end,

                [0.25] = function() -- Line: 102
                    -- upvalues: mainreplication (ref), u2 (ref), Value (ref), trove (ref), RunService (ref), Players (ref), ReplicatedStorage (ref), Lighting (ref), TweenService (ref), u5 (copy)
                    local u9, u10 = mainreplication.bodyVelocity(u2, 150, 6.5, nil, nil, true, TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), 2.8);

                    if u9 then
                        local u11 = Value:GetAttribute("RinNoPlay") and 2 or 1.035;
                        local v12 = trove.new();
                        v12:AttachToInstance(u9);
                        v12:Connect(RunService.RenderStepped, function() -- Line: 111
                            -- upvalues: u9 (copy), mainreplication (ref), u2 (ref), u10 (copy), Value (ref), u11 (ref)
                            u9.Velocity = mainreplication.fixVelocity(u2, u2.CFrame.LookVector * u10.Value * (Value:GetAttribute("chigiri_winger") and u11 or 1));
                        end);
                    end;

                    if Players.LocalPlayer == Players:GetPlayerFromCharacter(Value) then
                        mainreplication.fov(false, 100);
                        mainreplication.fov(true, 70, 5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out);
                        mainreplication.springcamerashake(30, 120);
                        local v13 = ReplicatedStorage.Resources.ColorCorrection:Clone();
                        v13.Parent = Lighting;
                        v13.TintColor = Color3.fromRGB(255, 111, 142);
                        v13.Brightness = 0.4;
                        v13.Contrast = 1;
                        v13.Saturation = -0.4;
                        TweenService:Create(v13, TweenInfo.new(1.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Saturation = 0
                        }):Play();
                        TweenService:Create(v13, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                            Contrast = 0,
                            Brightness = 0,
                            TintColor = Color3.fromRGB(255, 255, 255)
                        }):Play();
                        task.delay(2, v13.Destroy, v13);
                    end;

                    local chigiripantheremit1 = u5:FindFirstChild("chigiripantheremit1");

                    if chigiripantheremit1 then
                        for _, descendant in pairs(chigiripantheremit1:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end;
                end,

                [1.616] = function() -- Line: 143
                    -- upvalues: u5 (copy)
                    local chigiripantheremit2 = u5:FindFirstChild("chigiripantheremit2");

                    if chigiripantheremit2 then
                        for _, descendant in pairs(chigiripantheremit2:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end;
                end,

                [3.066] = function() -- Line: 153
                    -- upvalues: u5 (copy)
                    local chigiripantheremit3 = u5:FindFirstChild("chigiripantheremit3");

                    if chigiripantheremit3 then
                        for _, descendant in pairs(chigiripantheremit3:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end;
                end,

                [3.25] = function() -- Line: 163
                    -- upvalues: u5 (copy), u6 (copy)
                    if u5:FindFirstChild("chigirirunningvfx") then
                        for _, descendant in pairs(u5.chigirirunningvfx:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end;

                    for _, v in ipairs(u6) do
                        if v:IsA("ParticleEmitter") then
                            v.Enabled = false;
                        end;
                    end;
                end
            });

            return;
        end;

        if p3 ~= 2 then
            if p3 == 3 then
                local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value);
                Value:FindFirstChild("Ball");
                local v14 = Value.HumanoidRootPart or Value.PrimaryPart;
                local _ = Value.Torso;
                local Atmosphere = Lighting.Atmosphere;
                local chigiri2 = ReplicatedStorage.Resources.chigiri;
                local ScreenDimmer = vfxUtil.getScreenDimmer();
                local v15 = ReplicatedStorage.Resources.Ball:Clone();
                v15.ball.Part0 = v14;
                v15.Size = Vector3.new(1.5, 1.5, 1.5);
                v15.Parent = Value;
                Debris:AddItem(v15, 4);
                local u16 = soundUtil:play(chigiri2.ChigiriUltStart, ReplicatedStorage, {
                    Character = Value
                });
                local u17 = Util.Preload(chigiri2.GoldenZoneStartImpact);
                local u18 = ReplicatedStorage.Resources.uibox:Clone();
                u18.Parent = PlayerGui;
                Lighting.Brightness = 1;
                Lighting.Ambient = Color3.fromRGB(157, 181, 248);
                Lighting.ExposureCompensation = 1;
                Lighting.Bloom.Threshold = 3.55;
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");

                if not Util.isepilepsysafe() then
                    ColorCorrectionEffect.Parent = Lighting;
                end;

                ColorCorrectionEffect.Contrast = 0.25;
                ColorCorrectionEffect.Saturation = -0.1;
                ColorCorrectionEffect.Brightness = 0;
                local u19 = ReplicatedStorage.Resources.DepthOfField:Clone();
                u19.Parent = Lighting;
                u19.FarIntensity = 1;
                mainreplication.sceneEnabled(true);
                mainreplication.ultFlash(1);
                mainreplication.cutscene(v14, CFrame.new(Vector3.new(0, 0, 0)), 6, chigiri2.GOLDENSTARTUPFOV);
                local u20 = chigiri2.ChigiriGoldenZoneVFX:Clone();
                u20:PivotTo(v14.CFrame);
                u20.Parent = workspace.Effects;
                Debris:AddItem(u20, 6);

                if Util.canshiftcolor(PlayerFromCharacter, Value) then
                    vfxUtil.LeanTowardsColor(u20, Value:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Value:GetAttribute("CustomAlpha") or 0.985);
                end;

                local v21 = ReplicatedStorage.Resources.glowscreen:Clone();
                v21.Parent = PlayerGui;
                v21.ImageLabel2.ImageTransparency = 0;
                v21.ImageLabel2.ImageColor3 = Color3.fromRGB(0, 0, 0);
                Debris:AddItem(v21, 6);
                local u22 = chigiri2.ChigiriGoldenZoneVFX.chigirigoldenzonecc:Clone();
                u22.Parent = Lighting;
                Debris:AddItem(u22, 6);
                local u23 = chigiri2.GoldenCamPart:Clone();
                u23.Parent = Value;
                Debris:AddItem(u23, 6);
                local u24 = chigiri2.RightLegParttt:Clone();
                u24.Weld.Part1 = Value["Right Leg"];
                u24.Parent = Value;
                Debris:AddItem(u24, 6);
                local u25 = nil;
                u25 = RunService.PreRender:connect(function() -- Line: 576
                    -- upvalues: u23 (copy), u25 (ref)
                    if u23:IsDescendantOf(game) then
                        u23.CFrame = workspace.CurrentCamera.CFrame;

                        return;
                    end;

                    u25:Disconnect();
                end);
                local u26 = {};
                Util.Timeline({
                    [0] = function() -- Line: 585
                        -- upvalues: u23 (copy), u22 (copy), TweenService (ref), u16 (copy), TekrinnDialogue (ref), Value (ref)
                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;

                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                            end;
                        end;

                        u22.Brightness = 1;
                        TweenService:Create(u22, TweenInfo.new(0.3), {
                            Brightness = 0
                        }):Play();

                        if u16.Name == "Dub" then
                            TekrinnDialogue.Speak(Value, {
                                {
                                    Text = "Not fast enough!",
                                    Bold = true,
                                    Italic = true,
                                    TypeSpeed = 0.01,
                                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
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
                                Text = "Accelerate!",
                                Bold = true,
                                Italic = true,
                                TypeSpeed = 0.01,
                                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                                TextStrokeColor = Color3.new(0, 0, 0),
                                Shake = {
                                    Enabled = true,
                                    Intensity = 3,
                                    Lifetime = 0.5
                                }
                            }
                        }, 3);
                    end,

                    [1.26] = function() -- Line: 652
                        -- upvalues: TweenService (ref), u22 (copy), chigiri2 (copy), Value (ref), Debris (ref), RunService (ref), u16 (copy), TekrinnDialogue (ref)
                        TweenService:Create(u22, TweenInfo.new(0.3), {
                            Brightness = -0.75
                        }):Play();
                        task.delay(0.3, function() -- Line: 655
                            -- upvalues: TweenService (ref), u22 (ref)
                            TweenService:Create(u22, TweenInfo.new(1.55), {
                                Brightness = -0.25
                            }):Play();
                        end);
                        task.delay(1.56, function() -- Line: 659
                            -- upvalues: TweenService (ref), u22 (ref), chigiri2 (ref), Value (ref), Debris (ref), RunService (ref)
                            TweenService:Create(u22, TweenInfo.new(0.15), {
                                Brightness = 0
                            }):Play();
                            local u27 = chigiri2.ChigiriCamPart:Clone();
                            u27.Parent = Value;
                            Debris:AddItem(u27, 3);
                            local u28 = nil;
                            u28 = RunService.PreRender:connect(function() -- Line: 667
                                -- upvalues: u27 (copy), u28 (ref)
                                if u27:IsDescendantOf(game) then
                                    u27.CFrame = workspace.CurrentCamera.CFrame;

                                    return;
                                end;

                                u28:Disconnect();
                            end);
                        end);

                        if u16.Name == "Dub" then
                            TekrinnDialogue.Speak(Value, {
                                {
                                    Text = "Accelerate!",
                                    Bold = true,
                                    Italic = true,
                                    TypeSpeed = 0.01,
                                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
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
                                Text = "Go even faster!",
                                Bold = true,
                                Italic = true,
                                TypeSpeed = 0.01,
                                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                                TextStrokeColor = Color3.new(0, 0, 0),
                                Shake = {
                                    Enabled = true,
                                    Intensity = 3,
                                    Lifetime = 0.5
                                }
                            }
                        }, 3);
                    end,

                    [1.566] = function() -- Line: 725
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirigoldenzoneglare:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end,

                    [1.7] = function() -- Line: 733
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirigoldenzonechains:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end,

                    [1.716] = function() -- Line: 740
                        -- upvalues: u24 (copy)
                        for _, descendant in pairs(u24:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                            end;
                        end;

                        for _, descendant in pairs(u24:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end,

                    [2.216] = function() -- Line: 753
                        -- upvalues: u23 (copy)
                        for _, descendant in pairs(u23.chigiristrongglare:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;

                        for _, descendant in pairs(u23.chigiristrongglare:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end,

                    [3] = function() -- Line: 766
                        -- upvalues: u16 (copy), TekrinnDialogue (ref), Value (ref)
                        if u16.Name == "Dub" then
                            TekrinnDialogue.Speak(Value, {
                                {
                                    Text = "One...",
                                    Bold = true,
                                    Italic = true,
                                    TypeSpeed = 0.01,
                                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
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
                                Text = "Once more...",
                                Bold = true,
                                Italic = true,
                                TypeSpeed = 0.01,
                                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                                TextStrokeColor = Color3.new(0, 0, 0),
                                Shake = {
                                    Enabled = true,
                                    Intensity = 3,
                                    Lifetime = 0.5
                                }
                            }
                        }, 3);
                    end,

                    [3.166] = function() -- Line: 818
                        -- upvalues: u23 (copy)
                        for _, descendant in pairs(u23.chigiristrongglare:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        for _, descendant in pairs(u23.chigiristrongglare:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end,

                    [3.183] = function() -- Line: 831
                        -- upvalues: u23 (copy)
                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = true;
                            end;
                        end;

                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = true;
                            end;
                        end;
                    end,

                    [3.2] = function() -- Line: 844
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirzonestartupemit2:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end,

                    [3.216] = function() -- Line: 852
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirigoldenzonechains:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end,

                    [3.35] = function() -- Line: 859
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirigoldenzoneglare:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end,

                    [3.583] = function() -- Line: 867
                        -- upvalues: Value (ref), chigiri2 (copy), u26 (copy)
                        for _, descendant in ipairs(Value:GetDescendants()) do
                            if descendant:IsA("Part") and descendant.Transparency < 1 then
                                local v29 = descendant;

                                for _, descendant2 in ipairs(chigiri2.auracontainerr:GetDescendants()) do
                                    local v30 = descendant2:Clone();
                                    v30.Parent = v29;
                                    table.insert(u26, v30);
                                end;
                            end;
                        end;
                    end,

                    [3.6] = function() -- Line: 881
                        -- upvalues: u20 (copy), u24 (copy), Util (ref), ReplicatedStorage (ref)
                        for _, descendant in pairs(u20.chigirzonestartupemit1:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;

                        for _, descendant in pairs(u24:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        Util.Gif(ReplicatedStorage.Resources.chigiri.GoldenZoneStartImpact, 40);
                    end,

                    [3.616] = function() -- Line: 896
                        -- upvalues: u24 (copy)
                        for _, descendant in pairs(u24:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = false;
                            end;
                        end;
                    end,

                    [3.633] = function() -- Line: 903
                        -- upvalues: u23 (copy)
                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end,

                    [4.116] = function() -- Line: 911
                        -- upvalues: u20 (copy)
                        for _, descendant in pairs(u20.chigirzonestartupemit1:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end,

                    [4.133] = function() -- Line: 919
                        -- upvalues: u23 (copy)
                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                            end;
                        end;
                    end,

                    [4.76] = function() -- Line: 927
                        -- upvalues: u16 (copy), TekrinnDialogue (ref), Value (ref)
                        if u16.Name == "Dub" then
                            TekrinnDialogue.Speak(Value, {
                                {
                                    Text = "Final Time!",
                                    Bold = true,
                                    Italic = true,
                                    TypeSpeed = 0.01,
                                    Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                                    TextStrokeColor = Color3.new(0, 0, 0),
                                    Shake = {
                                        Enabled = true,
                                        Intensity = 5,
                                        Lifetime = 0.5
                                    }
                                }
                            }, 1);

                            return;
                        end;

                        TekrinnDialogue.Speak(Value, {
                            {
                                Text = "I will dream!",
                                Bold = true,
                                Italic = true,
                                TypeSpeed = 0.01,
                                Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                                TextStrokeColor = Color3.new(0, 0, 0),
                                Shake = {
                                    Enabled = true,
                                    Intensity = 5,
                                    Lifetime = 0.5
                                }
                            }
                        }, 1);
                    end,

                    [6] = function() -- Line: 979
                        -- upvalues: ScreenDimmer (copy), mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u18 (copy), u19 (copy), u22 (copy), ColorCorrectionEffect (copy), u23 (copy), u26 (copy)
                        ScreenDimmer:Destroy();
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
                        u18:Destroy();
                        u19:Destroy();
                        u22:Destroy();
                        ColorCorrectionEffect:Destroy();

                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        for _, descendant in pairs(u23:GetDescendants()) do
                            if descendant:IsA("Beam") then
                                descendant.Enabled = false;
                            end;
                        end;

                        for _, v in ipairs(u26) do
                            if v:IsA("ParticleEmitter") then
                                v.Enabled = false;
                            end;
                        end;
                    end,

                    [7] = function() -- Line: 1017
                        -- upvalues: u17 (copy)
                        u17:Destroy();
                    end
                });
            end;

            return;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(Value);

        if Value:FindFirstChild("ChigiriREDPanther") then
            Value.ChigiriREDPanther:Destroy();
        end;

        local Atmosphere = Lighting.Atmosphere;
        local u31 = Util.Preload(ReplicatedStorage.Resources.chigiri.GoldenZoneImpact);
        local v32 = chigiri.ChigiriREDPanther:Clone();
        Util.Weld(u2, u2, v32.RootPart, CFrame.new(
            -5.96046448e-8,
            -3,
            -4.76838466e-7,
            -1,
            7.51293007e-26,
            -8.74230039e-8,
            -3.8515258e-20,
            1,
            4.40562896e-13,
            8.74230039e-8,
            4.40562896e-13,
            -1
        ));
        v32.Parent = Value;
        Debris:AddItem(v32, 4.4);
        animationUtil:loadAnimation(v32, chigiri.PANTHERSHOOT):Play(0);
        local ScreenDimmer = vfxUtil.getScreenDimmer();
        local u33 = soundUtil:play(chigiri.ChigiriUltHit, ReplicatedStorage, {
            Character = Value
        });
        mainreplication.sceneEnabled(true);
        mainreplication.ultFlash(1);
        mainreplication.cutscene(u2, CFrame.new(Vector3.new(0, 0, 0)), 4.4, chigiri.GOLDENSHOOTFOV);
        local UltimateTheme = SoundService:FindFirstChild("UltimateTheme");

        if UltimateTheme then
            UltimateTheme:Stop();
        end;

        local u34 = ReplicatedStorage.Resources.chigiri.ChigiriGoldenZoneVFX:Clone();
        u34:PivotTo(u2.CFrame);
        u34.Parent = workspace.Effects;
        Debris:AddItem(u34, 4.6);

        if Util.canshiftcolor(PlayerFromCharacter, Value) then
            vfxUtil.LeanTowardsColor(u34, Value:GetAttribute("CustomColor") or Color3.fromRGB(85, 0, 127), Value:GetAttribute("CustomAlpha") or 0.985);
        end;

        local u35 = ReplicatedStorage.Resources.uibox:Clone();
        u35.Parent = PlayerGui;
        Lighting.Brightness = 1;
        Lighting.Ambient = Color3.fromRGB(157, 181, 248);
        Lighting.ExposureCompensation = 1;
        Lighting.Bloom.Threshold = 3.55;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");

        if not Util.isepilepsysafe() then
            ColorCorrectionEffect.Parent = Lighting;
        end;

        ColorCorrectionEffect.Contrast = 0.25;
        ColorCorrectionEffect.Saturation = -0.1;
        ColorCorrectionEffect.Brightness = 0;
        local u36 = ReplicatedStorage.Resources.DepthOfField:Clone();
        u36.Parent = Lighting;
        u36.FarIntensity = 1;
        local u37 = ReplicatedStorage.Resources.chigiri.ChigiriGoldenZoneVFX.chigirigoldenzonecc:Clone();
        u37.Parent = Lighting;
        Debris:AddItem(u37, 4.6);
        u37.Brightness = 0;
        u37.Saturation = 0;
        u37.Contrast = 0;
        local u38 = ReplicatedStorage.Resources.chigiri.GoldenCamPart:Clone();
        u38.Parent = Value;
        Debris:AddItem(u38, 4.6);
        local u39 = nil;
        u39 = RunService.PreRender:connect(function() -- Line: 247
            -- upvalues: u38 (copy), u39 (ref)
            if u38:IsDescendantOf(game) then
                u38.CFrame = workspace.CurrentCamera.CFrame;

                return;
            end;

            u39:Disconnect();
        end);
        local u40 = ReplicatedStorage.Resources.chigiri.ChigiriCamPart:Clone();
        u40.Parent = Value;
        Debris:AddItem(u40, 4.6);
        RunService.PreRender:connect(function() -- Line: 257
            -- upvalues: u40 (copy), u39 (ref)
            if u40:IsDescendantOf(game) then
                u40.CFrame = workspace.CurrentCamera.CFrame;

                return;
            end;

            u39:Disconnect();
        end);
        local u41 = {};
        Util.Timeline({
            [0] = function() -- Line: 265
                -- upvalues: u38 (copy), u33 (copy), TekrinnDialogue (ref), Value (ref)
                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;
                end;

                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = true;
                    end;
                end;

                if u33.Name == "Dub" then
                    TekrinnDialogue.Speak(Value, {
                        {
                            Text = "All I want is another chance to become the best.",
                            Bold = true,
                            Italic = true,
                            TypeSpeed = 0.01,
                            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                            TextStrokeColor = Color3.new(0, 0, 0),
                            Shake = {
                                Enabled = true,
                                Intensity = 3,
                                Lifetime = 0.5
                            }
                        }
                    }, 2.5);

                    return;
                end;

                TekrinnDialogue.Speak(Value, {
                    {
                        Text = "To become the best in the world",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 3,
                            Lifetime = 0.5
                        }
                    }
                }, 3);
            end,

            [0.05] = function() -- Line: 328
                -- upvalues: u34 (copy), Value (ref), chigiri (ref), u41 (copy)
                for _, descendant in pairs(u34.chigirigoldenzoneshoot1:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;

                for _, descendant in ipairs(Value:GetDescendants()) do
                    if descendant:IsA("Part") and descendant.Transparency < 1 then
                        local v42 = descendant;

                        for _, descendant2 in ipairs(chigiri.auracontainerr:GetDescendants()) do
                            local v43 = descendant2:Clone();
                            v43.Parent = v42;
                            table.insert(u41, v43);
                        end;
                    end;
                end;
            end,

            [0.7] = function() -- Line: 348
                -- upvalues: u34 (copy)
                for _, descendant in pairs(u34.chigirigoldenzoneshoot2:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [0.78] = function() -- Line: 356
                -- upvalues: TweenService (ref), u37 (copy)
                TweenService:Create(u37, TweenInfo.new(0.15), {
                    Brightness = -0.35
                }):Play();
                task.delay(0.15, function() -- Line: 358
                    -- upvalues: TweenService (ref), u37 (ref)
                    TweenService:Create(u37, TweenInfo.new(0.15), {
                        Brightness = 0.5
                    }):Play();
                    TweenService:Create(u37, TweenInfo.new(0.15), {
                        TintColor = Color3.fromRGB(255, 123, 209)
                    }):Play();
                end);
                task.delay(0.3, function() -- Line: 362
                    -- upvalues: TweenService (ref), u37 (ref)
                    TweenService:Create(u37, TweenInfo.new(0.15), {
                        Brightness = 0
                    }):Play();
                    TweenService:Create(u37, TweenInfo.new(0.15), {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                end);
            end,

            [1.05] = function() -- Line: 367
                -- upvalues: u34 (copy)
                for _, descendant in pairs(u34.chigirigoldenzoneshoot3:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [1.783] = function() -- Line: 375
                -- upvalues: u38 (copy)
                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [2.817] = function() -- Line: 383
                -- upvalues: u33 (copy), TekrinnDialogue (ref), Value (ref)
                if u33.Name ~= "Dub" then
                    TekrinnDialogue.Speak(Value, {
                        {
                            Text = "I want..",
                            Bold = true,
                            Italic = true,
                            TypeSpeed = 0.01,
                            Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                            TextStrokeColor = Color3.new(0, 0, 0),
                            Shake = {
                                Enabled = true,
                                Intensity = 3,
                                Lifetime = 0.5
                            }
                        }
                    }, 3);
                end;
            end,

            [3.417] = function() -- Line: 410
                -- upvalues: TekrinnDialogue (ref), Value (ref)
                TekrinnDialogue.Speak(Value, {
                    {
                        Text = "Another chance to play soccer!",
                        Bold = true,
                        Italic = true,
                        TypeSpeed = 0.01,
                        Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 123)) }),
                        TextStrokeColor = Color3.new(0, 0, 0),
                        Shake = {
                            Enabled = true,
                            Intensity = 5,
                            Lifetime = 0.5
                        }
                    }
                }, 1);
            end,

            [3.95] = function() -- Line: 435
                -- upvalues: u34 (copy)
                for _, descendant in pairs(u34.chigiripantheremit4:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;
            end,

            [3.966] = function() -- Line: 443
                -- upvalues: u38 (copy), Util (ref), ReplicatedStorage (ref)
                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                    end;
                end;

                Util.Gif(ReplicatedStorage.Resources.chigiri.GoldenZoneImpact, 60);
            end,

            [4.283] = function() -- Line: 452
                -- upvalues: u41 (copy)
                for _, v in ipairs(u41) do
                    if v:IsA("ParticleEmitter") then
                        v.Enabled = false;
                    end;
                end;
            end,

            [4.6] = function() -- Line: 459
                -- upvalues: ScreenDimmer (copy), mainreplication (ref), Lighting (ref), Brightness (ref), Threshold (ref), ExposureCompensation (ref), Ambient (ref), Atmosphere (copy), Density (ref), Color (ref), u35 (copy), u36 (copy), u37 (copy), ColorCorrectionEffect (copy)
                ScreenDimmer:Destroy();
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
                u35:Destroy();
                u36:Destroy();
                u37:Destroy();
                ColorCorrectionEffect:Destroy();
            end,

            [4.666] = function() -- Line: 480
                -- upvalues: u38 (copy)
                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    end;
                end;

                for _, descendant in pairs(u38:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end,

            [5] = function() -- Line: 493
                -- upvalues: UltimateTheme (copy), u31 (copy)
                if UltimateTheme then
                    UltimateTheme:Resume();
                end;

                u31:Destroy();
            end
        });
    end);
end;
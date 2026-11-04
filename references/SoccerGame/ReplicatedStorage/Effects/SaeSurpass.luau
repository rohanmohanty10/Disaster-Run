  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Vfx = ReplicatedStorage:FindFirstChild("Assets"):FindFirstChild("Vfx");
local Debris = workspace:FindFirstChild("Debris");

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
            v.Enabled = p2 or false;
        end;
    end;
end;

function Emit_All_With_Duration(p3)
    local function emit(u4) -- Line: 28
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDuration");
            local Attribute2 = u4:GetAttribute("EmitDelay");
            local Attribute3 = u4:GetAttribute("EmitCount");

            if Attribute and Attribute ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 36
                        -- upvalues: u4 (copy), Attribute (copy)
                        u4.Enabled = true;
                        task.delay(Attribute, function() -- Line: 39
                            -- upvalues: u4 (ref)
                            u4.Enabled = false;
                        end);
                    end);

                    return;
                end;

                u4.Enabled = true;
                task.delay(Attribute, function() -- Line: 46
                    -- upvalues: u4 (copy)
                    u4.Enabled = false;
                end);

                return;
            end;

            if Attribute3 and Attribute3 ~= 0 then
                if Attribute2 and Attribute2 ~= 0 then
                    task.delay(Attribute2, function() -- Line: 53
                        -- upvalues: u4 (copy), Attribute3 (copy)
                        u4:Emit(Attribute3);
                    end);

                    return;
                end;

                u4:Emit(Attribute3);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 85
    task.delay(p6, function() -- Line: 87
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

local function tweenbeam(u7, u8, u9, u10, u11, p12) -- Line: 103
    -- upvalues: RunService (copy), TweenService (copy)
    local u13 = nil;
    local os_clock_ret = os.clock();
    local u14 = nil;
    u14 = RunService.Heartbeat:Connect(function(p15) -- Line: 107
        -- upvalues: u13 (ref), os_clock_ret (copy), u11 (copy), TweenService (ref), u9 (ref), u8 (copy), u10 (copy), u7 (copy), u14 (ref)
        u13 = (os.clock() - os_clock_ret) / u11;
        u13 = TweenService:GetValue(u13, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u9 = u8 + (u10 - u8) * u13;
        u7.Transparency = NumberSequence.new(u9, u9);

        if u11 <= os.clock() - os_clock_ret then
            u14:Disconnect();
        end;
    end);
    table.insert(p12, u14);
end;

local function tweenColor(u16, p17) -- Line: 121
    -- upvalues: RunService (copy), TweenService (copy)
    local u18 = nil;
    local os_clock_ret = os.clock();
    local Start = p17.Start;
    local Goal = p17.Goal;
    local Duration = p17.Duration;
    local Conns = p17.Conns;
    local u19 = 0;
    local u20 = 0;
    local u21 = 0;
    local u22 = Start[1];
    local u23 = Start[2];
    local u24 = Start[3];
    local u25 = Goal[1];
    local u26 = Goal[2];
    local u27 = Goal[3];
    local u28 = nil;
    u28 = RunService.Heartbeat:Connect(function(p29) -- Line: 133
        -- upvalues: u18 (ref), os_clock_ret (copy), Duration (copy), TweenService (ref), u19 (ref), u22 (copy), u25 (copy), u20 (ref), u23 (copy), u26 (copy), u21 (ref), u24 (copy), u27 (copy), u16 (copy), u28 (ref)
        u18 = (os.clock() - os_clock_ret) / Duration;
        u18 = TweenService:GetValue(u18, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
        u19 = u22 + (u25 - u22) * u18;
        u20 = u23 + (u26 - u23) * u18;
        u21 = u24 + (u27 - u24) * u18;

        if u16:IsA("ColorCorrectionEffect") then
            u16.TintColor = Color3.fromRGB(u19, u20, u21);
        elseif u16.Color then
            if typeof(u16.Color) == "ColorSequence" then
                u16.Color = ColorSequence.new(Color3.fromRGB(u19, u20, u21), Color3.fromRGB(u19, u20, u21));
            else
                u16.Color = Color3.fromRGB(u19, u20, u21);
            end;
        end;

        if Duration <= os.clock() - os_clock_ret then
            u28:Disconnect();
        end;
    end);
    table.insert(Conns, u28);
end;

local function Weld(p30, p31) -- Line: 161
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p30;
    WeldConstraint.Part1 = p31;
    WeldConstraint.Parent = p30;

    return WeldConstraint;
end;

return function(p32) -- Line: 168
    -- upvalues: SpectatorController (copy), SoundManager (copy), Debris (copy), Players (copy), TweenService (copy), ReplicatedStorage (copy), Vfx (copy), RunService (copy), tweenColor (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p32.Char;
    local Victim = p32.Victim;

    if not Char then
        return;
    end;

    local BALL = Char:FindFirstChild("PlrFootball"):FindFirstChild("BallAnims"):FindFirstChild("BALL");
    local u33 = script.Name .. " VFX FOLDER " .. Char.Name;

    if p32.Task ~= "Cutscene" then
        if p32.Task == "Cleanup" then
            local v34 = { Enum.AnimationPriority.Core, Enum.AnimationPriority.Movement, Enum.AnimationPriority.Idle };

            if Victim then
                Victim = Victim:FindFirstChildOfClass("Humanoid");
            end;

            if Victim then
                Victim = Victim:FindFirstChildOfClass("Animator");
            end;

            if Victim then
                for _, v in Victim:GetPlayingAnimationTracks() do
                    if not table.find(v34, v.Priority) then
                        print(v, v.Priority);
                        v:Stop();
                    end;
                end;
            end;

            local u35 = Debris:FindFirstChild(u33);

            if u35 then
                EnableVFX(u35, false);
                u35.Name = "_";
                u35:SetAttribute("Active", false);
                task.delay(2, function() -- Line: 87
                    -- upvalues: u35 (copy)
                    if typeof(u35) == "table" then
                        for _, v in u35 do
                            if v then
                                v:Destroy();
                            end;
                        end;

                        return;
                    end;

                    if u35 then
                        u35:Destroy();
                    end;
                end);
            end;
        end;

        return;
    end;

    if not Char then
        return;
    end;

    if not Victim then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u36 = SoundManager.SpawnSound("sae ult", 1, workspace, 130, false, true);
    u36:Play();
    local u37 = {};
    local u38 = {};
    local u39 = {};
    local u40 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = u33;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(16.35, function() -- Line: 87
        -- upvalues: Folder (copy)
        if typeof(Folder) == "table" then
            for _, v in Folder do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if Folder then
            Folder:Destroy();
        end;
    end);
    task.spawn(function() -- Line: 204
        -- upvalues: Players (ref)
        local v41 = script.FirstFrames:Clone();
        v41.Parent = Players.LocalPlayer.PlayerGui;
        local VideoFrame = v41:FindFirstChild("VideoFrame");
        VideoFrame.Visible = false;
        task.wait(6);
        VideoFrame.Visible = true;
        VideoFrame:Play();
        print(VideoFrame);
        task.wait(VideoFrame.TimeLength);
        v41:Destroy();
    end);
    task.spawn(function() -- Line: 220
        -- upvalues: Players (ref)
        local v42 = script.SecondFrames:Clone();
        v42.Parent = Players.LocalPlayer.PlayerGui;
        local VideoFrame = v42:FindFirstChild("VideoFrame");
        VideoFrame.Visible = false;
        task.wait(15.1);
        VideoFrame.Visible = true;
        VideoFrame:Play();
        print(VideoFrame.Playing);
        task.wait(VideoFrame.TimeLength);
        v42:Destroy();
    end);
    local Vignette = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette").Vignette;
    local u43 = nil;

    if Vignette then
        for _, v in { Vignette, Vignette.LL, Vignette.UR } do
            task.delay(0.8, function() -- Line: 243
                -- upvalues: Folder (copy), Debris (ref), u33 (copy), u43 (ref), TweenService (ref), v (copy)
                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                print("im playing");
                u43 = TweenService:Create(v, TweenInfo.new(0.43333333333333335, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                u43:Play();
                task.wait(0.43333333333333335);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(3.716666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = -1
                });
                u43:Play();
                task.wait(3.716666666666667);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(1.1, Enum.EasingStyle.Linear), {
                    ImageTransparency = -2,
                    ImageColor3 = Color3.fromRGB(107, 0, 0)
                });
                u43:Play();
                task.wait(1.1);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0
                });
                u43:Play();
                task.wait(0.23333333333333334);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(0.23333333333333334, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.6,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                u43:Play();
                task.wait(1.4333333333333333);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(0.11666666666666667, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.5,
                    ImageColor3 = Color3.fromRGB(255, 0, 59)
                });
                u43:Play();
                task.wait(5.183333333333333);

                if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                    return;
                end;

                u43 = TweenService:Create(v, TweenInfo.new(1.35, Enum.EasingStyle.Linear), {
                    ImageTransparency = 0.6,
                    ImageColor3 = Color3.fromRGB(0, 0, 0)
                });
                u43:Play();
            end);
        end;
    end;

    local u44 = ReplicatedStorage.Assets.UI.Popup:Clone();
    u44.Parent = Players.LocalPlayer.PlayerGui:FindFirstChild("Vignette");
    u44.Position = UDim2.new(0.5, 0, 0.8, 0);
    u44.Size = UDim2.new(1, 0, 0.1, 0);
    u44.BackgroundTransparency = 1;
    u44.AnchorPoint = Vector2.new(0.5, 0.5);
    u44.Font = Enum.Font.ArialBold;
    u44.MaxVisibleGraphemes = 0;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Parent = u44;
    UIStroke.Thickness = 4;
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
    task.delay(2.2333333333333334, function() -- Line: 306
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u44 (ref), UIStroke (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44.Text = "If you keep acting like my little brother...";
        u44.MaxVisibleGraphemes = 0;
        u44.TextTransparency = 0;
        u44.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        TweenService:Create(u44, TweenInfo.new(0.9666666666666667, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u44.Text
        }):Play();
        task.wait(2.95);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u44, TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.7833333333333333, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.wait(5.183333333333334);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44.Text = "...you will never surpass me.";
        u44.MaxVisibleGraphemes = 0;
        u44.TextTransparency = 0;
        u44.TextStrokeTransparency = 0;
        UIStroke.Transparency = 0;
        TweenService:Create(u44, TweenInfo.new(1.3666666666666667, Enum.EasingStyle.Linear), {
            MaxVisibleGraphemes = #u44.Text
        }):Play();
        task.wait(2.8833333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u44, TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
        TweenService:Create(UIStroke, TweenInfo.new(0.7666666666666667, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.wait(0.7666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u44:Destroy();
    end);
    local Highlight = Char:FindFirstChild("Highlight");

    if Highlight then
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    workspace_CurrentCamera.FieldOfView = 25;
    local u45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
        FieldOfView = 25
    });
    u45:Play();
    task.delay(6.216666666666667, function() -- Line: 360
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u45 (ref), TweenService (ref), workspace_CurrentCamera (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
            FieldOfView = 18
        });
        u45:Play();
        task.wait(0.15);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(1.0333333333333334, Enum.EasingStyle.Linear), {
            FieldOfView = 25
        });
        u45:Play();
        task.wait(1.0333333333333334);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u45 = TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
            FieldOfView = 27
        });
        u45:Play();
    end);
    task.delay(16.5, function() -- Line: 376
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), workspace_CurrentCamera (copy), FieldOfView (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end);
    local Blur = game.Lighting.Blur;
    local Size = Blur.Size;
    local u46 = nil;

    if Blur then
        task.delay(0.5333333333333333, function() -- Line: 386
            -- upvalues: u46 (ref), TweenService (ref), Blur (copy), Folder (copy), Debris (ref), u33 (copy)
            u46 = TweenService:Create(Blur, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                Size = 15
            });
            u46:Play();

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            task.wait(0.06666666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                Size = 0
            });
            u46:Play();
            task.wait(5.616666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                Size = 15
            });
            u46:Play();
            task.wait(0.06666666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                Size = 0
            });
            u46:Play();
            task.wait(1.9833333333333334);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                Size = 5
            });
            u46:Play();
            task.wait(0.06666666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                Size = 0
            });
            u46:Play();
            task.wait(6.366666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.06666666666666667, Enum.EasingStyle.Linear), {
                Size = 15
            });
            u46:Play();
            task.wait(0.06666666666666667);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u46 = TweenService:Create(Blur, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
                Size = 0
            });
            u46:Play();
        end);
    end;

    local Atmosphere = game.Lighting.Atmosphere;
    local Color = Atmosphere.Color;
    local Density = Atmosphere.Density;
    local Offset = Atmosphere.Offset;
    local Decay = Atmosphere.Decay;
    local Glare = Atmosphere.Glare;
    local Haze = Atmosphere.Haze;
    local u47 = nil;

    if Atmosphere then
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        task.delay(16.5, function() -- Line: 444
            -- upvalues: Folder (copy), Debris (ref), u33 (copy), Atmosphere (copy), Color (copy), Density (copy), Offset (copy), Decay (copy), Glare (copy), Haze (copy)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            Atmosphere.Color = Color;
            Atmosphere.Density = Density;
            Atmosphere.Offset = Offset;
            Atmosphere.Decay = Decay;
            Atmosphere.Glare = Glare;
            Atmosphere.Haze = Haze;
        end);
        Atmosphere.Color = Color3.fromRGB(133, 180, 255);
        Atmosphere.Density = 0.481;
        Atmosphere.Offset = 0.848;
        Atmosphere.Decay = Color3.fromRGB(49, 50, 99);
        Atmosphere.Glare = 5;
        Atmosphere.Haze = 6.08;
        task.delay(7.416666666666667, function() -- Line: 462
            -- upvalues: Folder (copy), Debris (ref), u33 (copy), u47 (ref), TweenService (ref), Atmosphere (copy)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u47 = TweenService:Create(Atmosphere, TweenInfo.new(0.016666666666666666, Enum.EasingStyle.Linear), {
                Color = Color3.fromRGB(199, 20, 107)
            });
            u47:Play();
            task.wait(0.016666666666666666);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            Atmosphere.Density = 0.3;
            Atmosphere.Offset = 0.5;
            Atmosphere.Haze = 2.04;
        end);
    end;

    local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
    local TintColor = ColorCorrection.TintColor;
    local Contrast = ColorCorrection.Contrast;
    local Brightness = ColorCorrection.Brightness;
    local Saturation = ColorCorrection.Saturation;
    local u48 = nil;
    task.delay(0.6166666666666667, function() -- Line: 483
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), ColorCorrection (copy), u48 (ref), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        if ColorCorrection then
            u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(155, 175, 255)
            });
            u48:Play();
            task.wait(0.03333333333333333);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.55, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u48:Play();
            task.wait(5.433333333333334);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(0, 0, 0)
            });
            u48:Play();
            task.wait(0.16666666666666666);

            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            u48 = TweenService:Create(ColorCorrection, TweenInfo.new(0.03333333333333333, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(255, 255, 255)
            });
            u48:Play();
        end;
    end);
    local u49 = Vfx.Surpass.DarkTones:Clone();
    u49.Parent = game.Lighting;
    u49.Enabled = false;
    task.delay(16.5, function() -- Line: 87
        -- upvalues: u49 (copy)
        if typeof(u49) == "table" then
            for _, v in u49 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u49 then
            u49:Destroy();
        end;
    end);
    task.delay(0.65, function() -- Line: 517
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u49 (copy), TweenService (ref), RunService (ref), u40 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u49.Enabled = true;
        task.wait(5.1);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u49, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(46, 0, 0)
        }):Play();
        task.delay(0.5333333333333333, function() -- Line: 527
            -- upvalues: Folder (ref), Debris (ref), u33 (ref), TweenService (ref), u49 (ref)
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            TweenService:Create(u49, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), {
                TintColor = Color3.fromRGB(58, 58, 58)
            }):Play();
        end);
        local u50 = nil;
        local os_clock_ret = os.clock();
        local u51 = 0;
        local u52 = nil;
        u52 = RunService.Heartbeat:Connect(function(p53) -- Line: 538
            -- upvalues: u50 (ref), os_clock_ret (copy), TweenService (ref), u51 (ref), u49 (ref), u52 (ref)
            u50 = (os.clock() - os_clock_ret) / 0.55;
            u50 = TweenService:GetValue(u50, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            u51 = 2 + 2 * u50;
            u49.Contrast = u51;

            if os.clock() - os_clock_ret >= 0.55 then
                u52:Disconnect();
            end;
        end);
        table.insert(u40, u52);
        task.wait(0.55);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u49, TweenInfo.new(0.5333333333333333, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(84, 84, 84)
        }):Play();
        local u54 = nil;
        local os_clock_ret2 = os.clock();
        local u55 = 0;
        local u56 = nil;
        u56 = RunService.Heartbeat:Connect(function(p57) -- Line: 563
            -- upvalues: u54 (ref), os_clock_ret2 (copy), TweenService (ref), u55 (ref), u49 (ref), u56 (ref)
            u54 = (os.clock() - os_clock_ret2) / 1.2166666666666666;
            u54 = TweenService:GetValue(u54, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
            u55 = 4 + -2 * u54;
            u49.Contrast = u55;

            if os.clock() - os_clock_ret2 >= 1.2166666666666666 then
                u56:Disconnect();
            end;
        end);
        table.insert(u40, u56);
        task.wait(1.2);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        u49:Destroy();
    end);
    local camera = workspace:FindFirstChild("NagiCam"):FindFirstChild("camera");
    local u58 = Vfx.Surpass.camera:Clone();
    u58.CFrame = camera.CFrame;
    u58.Parent = Folder;
    task.delay(16.5, function() -- Line: 87
        -- upvalues: u58 (copy)
        if typeof(u58) == "table" then
            for _, v in u58 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u58 then
            u58:Destroy();
        end;
    end);
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = u58;
    WeldConstraint.Part1 = camera;
    WeldConstraint.Parent = u58;
    Emit_All_With_Duration(camera);
    task.delay(0.016666666666666666, function() -- Line: 592
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u58 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;

        task.wait(0.6666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        task.wait(5.533333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;

        task.wait(3.65);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;

        task.wait(4.35);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = true;
            end;
        end;

        task.wait(2.55);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, child in u58:GetChildren() do
            if child:IsA("ParticleEmitter") then
                child.Enabled = false;
            end;
        end;
    end);
    local u59 = Vfx.Surpass.BALL:Clone();
    u59.CFrame = BALL.CFrame;
    u59.Parent = Folder;
    local WeldConstraint2 = Instance.new("WeldConstraint");
    WeldConstraint2.Part0 = u59;
    WeldConstraint2.Part1 = BALL;
    WeldConstraint2.Parent = u59;
    table.insert(u39, u59);
    task.delay(8.283333333333333, function() -- Line: 647
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), tweenColor (ref), u59 (copy), u40 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        tweenColor(u59.B0.T2, {
            Duration = 0.15,
            Conns = u40,
            Start = { 140, 140, 140 },
            Goal = { 255, 13, 106 }
        });
    end);
    local u60 = Vfx.Surpass.Surpass_VFX:Clone();
    u60:PivotTo(HumanoidRootPart.CFrame);
    u60.Parent = Folder;
    task.delay(16, function() -- Line: 87
        -- upvalues: u60 (copy)
        if typeof(u60) == "table" then
            for _, v in u60 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u60 then
            u60:Destroy();
        end;
    end);
    EnableVFX(u60.SaeArea, true);

    for _, child in u60.AfterPush["Timescale Dots"]:GetChildren() do
        if child:IsA("ParticleEmitter") then
            TweenService:Create(child, TweenInfo.new(2.316666666666667, Enum.EasingStyle.Linear), {
                TimeScale = 0.03
            }):Play();
        end;
    end;

    task.delay(14.033333333333333, function() -- Line: 669
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy), HumanoidRootPart (copy), TweenService (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        local Scale = u60.GroundWindMesh.End1.Mesh.Scale;
        u60.GroundWindMesh:PivotTo(HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(0.08375287801027298, -1.0552693605422974, 1.4828312089321116e-7));
        u60.GroundWindMesh.End1.Mesh.Scale = Scale / 2;
        u60.GroundWindMesh.End1.Decal1.Transparency = 1;
        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(0.08375294506549835, -1.0552703142166138, -2.846876157036604e-8)
        }):Play();
        TweenService:Create(u60.GroundWindMesh.End1.Mesh, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), {
            Scale = Scale
        }):Play();
        TweenService:Create(u60.GroundWindMesh.End1.Decal1, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), {
            Transparency = 0.85
        }):Play();
        task.wait(0.16666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u60.GroundWindMesh.End1.Decal1, TweenInfo.new(0.6333333333333333, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(-1.5634639263153076, 2.0861072540283203, -3.141352891921997)
        }):Play();
        task.wait(0.1);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(-0.11035151779651642, 2.0863211154937744, -3.141589641571045)
        }):Play();
        task.wait(0.18333333333333332);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.16666666666666666, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(1.277084231376648, 2.086324453353882, -3.141587972640991)
        }):Play();
        task.wait(0.16666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.18333333333333332, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(0.5783084630966187, -1.0552726984024048, -7.820954124326818e-7)
        }):Play();
        task.wait(0.18333333333333332);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        TweenService:Create(u60.GroundWindMesh.End1, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            CFrame = HumanoidRootPart.CFrame * CFrame.new(1.240667700767517, -2.219428539276123, -10.517353057861328) * CFrame.fromEulerAnglesYXZ(-0.6763835549354553, -1.0552703142166138, -5.488751071425213e-7)
        }):Play();
    end);

    for _, v in { u60.AfterPush.SnowyIn, u60.AfterPush.SnowyIn2 } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                task.delay(0.6833333333333333, function() -- Line: 729
                    -- upvalues: Folder (copy), Debris (ref), u33 (copy), descendant (copy), u40 (ref), RunService (ref), TweenService (ref)
                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u61 = descendant;
                    local u62 = 1;
                    local u63 = nil;
                    local os_clock_ret = os.clock();
                    local u64 = nil;
                    local u65 = 0.25;
                    local u66 = 1;
                    local u67 = 0.95;
                    u64 = RunService.Heartbeat:Connect(function(p68) -- Line: 107
                        -- upvalues: u63 (ref), os_clock_ret (copy), u65 (copy), TweenService (ref), u62 (ref), u66 (copy), u67 (copy), u61 (copy), u64 (ref)
                        u63 = (os.clock() - os_clock_ret) / u65;
                        u63 = TweenService:GetValue(u63, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u62 = u66 + (u67 - u66) * u63;
                        u61.Transparency = NumberSequence.new(u62, u62);

                        if u65 <= os.clock() - os_clock_ret then
                            u64:Disconnect();
                        end;
                    end);
                    table.insert(u40, u64);
                    task.wait(0.25);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u69 = descendant;
                    local u70 = 0.95;
                    local u71 = nil;
                    local os_clock_ret2 = os.clock();
                    local u72 = nil;
                    local u73 = 1.5833333333333333;
                    local u74 = 0.95;
                    local u75 = 1;
                    u72 = RunService.Heartbeat:Connect(function(p76) -- Line: 107
                        -- upvalues: u71 (ref), os_clock_ret2 (copy), u73 (copy), TweenService (ref), u70 (ref), u74 (copy), u75 (copy), u69 (copy), u72 (ref)
                        u71 = (os.clock() - os_clock_ret2) / u73;
                        u71 = TweenService:GetValue(u71, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u70 = u74 + (u75 - u74) * u71;
                        u69.Transparency = NumberSequence.new(u70, u70);

                        if u73 <= os.clock() - os_clock_ret2 then
                            u72:Disconnect();
                        end;
                    end);
                    table.insert(u40, u72);
                    task.wait(1.5833333333333333);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u77 = descendant;
                    local u78 = 1;
                    local u79 = nil;
                    local os_clock_ret3 = os.clock();
                    local u80 = nil;
                    local u81 = 2.816666666666667;
                    local u82 = 1;
                    local u83 = 0.95;
                    u80 = RunService.Heartbeat:Connect(function(p84) -- Line: 107
                        -- upvalues: u79 (ref), os_clock_ret3 (copy), u81 (copy), TweenService (ref), u78 (ref), u82 (copy), u83 (copy), u77 (copy), u80 (ref)
                        u79 = (os.clock() - os_clock_ret3) / u81;
                        u79 = TweenService:GetValue(u79, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u78 = u82 + (u83 - u82) * u79;
                        u77.Transparency = NumberSequence.new(u78, u78);

                        if u81 <= os.clock() - os_clock_ret3 then
                            u80:Disconnect();
                        end;
                    end);
                    table.insert(u40, u80);
                    task.wait(2.816666666666667);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u85 = descendant;
                    local u86 = 0.95;
                    local u87 = nil;
                    local os_clock_ret4 = os.clock();
                    local u88 = nil;
                    local u89 = 0.5833333333333334;
                    local u90 = 0.95;
                    local u91 = 1;
                    u88 = RunService.Heartbeat:Connect(function(p92) -- Line: 107
                        -- upvalues: u87 (ref), os_clock_ret4 (copy), u89 (copy), TweenService (ref), u86 (ref), u90 (copy), u91 (copy), u85 (copy), u88 (ref)
                        u87 = (os.clock() - os_clock_ret4) / u89;
                        u87 = TweenService:GetValue(u87, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u86 = u90 + (u91 - u90) * u87;
                        u85.Transparency = NumberSequence.new(u86, u86);

                        if u89 <= os.clock() - os_clock_ret4 then
                            u88:Disconnect();
                        end;
                    end);
                    table.insert(u40, u88);
                    task.wait(0.5833333333333334);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u93 = descendant;
                    local u94 = 1;
                    local u95 = nil;
                    local os_clock_ret5 = os.clock();
                    local u96 = nil;
                    local u97 = 0.4666666666666667;
                    local u98 = 1;
                    local u99 = 0.95;
                    u96 = RunService.Heartbeat:Connect(function(p100) -- Line: 107
                        -- upvalues: u95 (ref), os_clock_ret5 (copy), u97 (copy), TweenService (ref), u94 (ref), u98 (copy), u99 (copy), u93 (copy), u96 (ref)
                        u95 = (os.clock() - os_clock_ret5) / u97;
                        u95 = TweenService:GetValue(u95, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u94 = u98 + (u99 - u98) * u95;
                        u93.Transparency = NumberSequence.new(u94, u94);

                        if u97 <= os.clock() - os_clock_ret5 then
                            u96:Disconnect();
                        end;
                    end);
                    table.insert(u40, u96);
                    task.wait(0.4666666666666667);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u101 = descendant;
                    local u102 = 0.95;
                    local u103 = nil;
                    local os_clock_ret6 = os.clock();
                    local u104 = nil;
                    local u105 = 0.5833333333333334;
                    local u106 = 0.95;
                    local u107 = 1;
                    u104 = RunService.Heartbeat:Connect(function(p108) -- Line: 107
                        -- upvalues: u103 (ref), os_clock_ret6 (copy), u105 (copy), TweenService (ref), u102 (ref), u106 (copy), u107 (copy), u101 (copy), u104 (ref)
                        u103 = (os.clock() - os_clock_ret6) / u105;
                        u103 = TweenService:GetValue(u103, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u102 = u106 + (u107 - u106) * u103;
                        u101.Transparency = NumberSequence.new(u102, u102);

                        if u105 <= os.clock() - os_clock_ret6 then
                            u104:Disconnect();
                        end;
                    end);
                    table.insert(u40, u104);
                    task.wait(1.8666666666666667);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u109 = descendant;
                    local u110 = 1;
                    local u111 = nil;
                    local os_clock_ret7 = os.clock();
                    local u112 = nil;
                    local u113 = 0.6333333333333333;
                    local u114 = 1;
                    local u115 = 0.95;
                    u112 = RunService.Heartbeat:Connect(function(p116) -- Line: 107
                        -- upvalues: u111 (ref), os_clock_ret7 (copy), u113 (copy), TweenService (ref), u110 (ref), u114 (copy), u115 (copy), u109 (copy), u112 (ref)
                        u111 = (os.clock() - os_clock_ret7) / u113;
                        u111 = TweenService:GetValue(u111, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u110 = u114 + (u115 - u114) * u111;
                        u109.Transparency = NumberSequence.new(u110, u110);

                        if u113 <= os.clock() - os_clock_ret7 then
                            u112:Disconnect();
                        end;
                    end);
                    table.insert(u40, u112);
                    task.wait(4.683333333333334);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u117 = descendant;
                    local u118 = 0.95;
                    local u119 = nil;
                    local os_clock_ret8 = os.clock();
                    local u120 = nil;
                    local u121 = 0.5833333333333334;
                    local u122 = 0.95;
                    local u123 = 1;
                    u120 = RunService.Heartbeat:Connect(function(p124) -- Line: 107
                        -- upvalues: u119 (ref), os_clock_ret8 (copy), u121 (copy), TweenService (ref), u118 (ref), u122 (copy), u123 (copy), u117 (copy), u120 (ref)
                        u119 = (os.clock() - os_clock_ret8) / u121;
                        u119 = TweenService:GetValue(u119, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u118 = u122 + (u123 - u122) * u119;
                        u117.Transparency = NumberSequence.new(u118, u118);

                        if u121 <= os.clock() - os_clock_ret8 then
                            u120:Disconnect();
                        end;
                    end);
                    table.insert(u40, u120);
                end);
            end;
        end;
    end;

    for _, v in { u60.Windy.Wind, u60.Windy.Wind2 } do
        for _, descendant in v:GetDescendants() do
            if descendant:IsA("Beam") then
                descendant.Enabled = true;
                task.delay(8.283333333333333, function() -- Line: 770
                    -- upvalues: Folder (copy), Debris (ref), u33 (copy), descendant (copy), u40 (ref), RunService (ref), TweenService (ref)
                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    local u125 = descendant;
                    local u126 = 1;
                    local u127 = nil;
                    local os_clock_ret = os.clock();
                    local u128 = nil;
                    local u129 = 0.45;
                    local u130 = 1;
                    local u131 = 0.85;
                    u128 = RunService.Heartbeat:Connect(function(p132) -- Line: 107
                        -- upvalues: u127 (ref), os_clock_ret (copy), u129 (copy), TweenService (ref), u126 (ref), u130 (copy), u131 (copy), u125 (copy), u128 (ref)
                        u127 = (os.clock() - os_clock_ret) / u129;
                        u127 = TweenService:GetValue(u127, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u126 = u130 + (u131 - u130) * u127;
                        u125.Transparency = NumberSequence.new(u126, u126);

                        if u129 <= os.clock() - os_clock_ret then
                            u128:Disconnect();
                        end;
                    end);
                    table.insert(u40, u128);
                    task.wait(6.716666666666667);

                    if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                        return;
                    end;

                    if descendant.Name == "1" or (descendant.Name == "2" or (descendant.Name == "3" or descendant.Name == "9")) then
                        local u133 = descendant;
                        local u134 = 0.85;
                        local u135 = nil;
                        local os_clock_ret2 = os.clock();
                        local u136 = nil;
                        local u137 = 1.15;
                        local u138 = 0.85;
                        local u139 = 1;
                        u136 = RunService.Heartbeat:Connect(function(p140) -- Line: 107
                            -- upvalues: u135 (ref), os_clock_ret2 (copy), u137 (copy), TweenService (ref), u134 (ref), u138 (copy), u139 (copy), u133 (copy), u136 (ref)
                            u135 = (os.clock() - os_clock_ret2) / u137;
                            u135 = TweenService:GetValue(u135, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                            u134 = u138 + (u139 - u138) * u135;
                            u133.Transparency = NumberSequence.new(u134, u134);

                            if u137 <= os.clock() - os_clock_ret2 then
                                u136:Disconnect();
                            end;
                        end);
                        table.insert(u40, u136);

                        return;
                    end;

                    local u141 = descendant;
                    local u142 = 0.85;
                    local u143 = nil;
                    local os_clock_ret2 = os.clock();
                    local u144 = nil;
                    local u145 = 1.5;
                    local u146 = 0.85;
                    local u147 = 1;
                    u144 = RunService.Heartbeat:Connect(function(p148) -- Line: 107
                        -- upvalues: u143 (ref), os_clock_ret2 (copy), u145 (copy), TweenService (ref), u142 (ref), u146 (copy), u147 (copy), u141 (copy), u144 (ref)
                        u143 = (os.clock() - os_clock_ret2) / u145;
                        u143 = TweenService:GetValue(u143, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);
                        u142 = u146 + (u147 - u146) * u143;
                        u141.Transparency = NumberSequence.new(u142, u142);

                        if u145 <= os.clock() - os_clock_ret2 then
                            u144:Disconnect();
                        end;
                    end);
                    table.insert(u40, u144);
                end);
            end;
        end;
    end;

    for _, child in Vfx.Surpass.USER_VFX:GetChildren() do
        if Char[child.Name] then
            local v149 = child:Clone();
            v149.CFrame = Char[child.Name].CFrame;
            v149.Parent = Folder;
            local v150 = Char[child.Name];
            local WeldConstraint3 = Instance.new("WeldConstraint");
            WeldConstraint3.Part0 = v149;
            WeldConstraint3.Part1 = v150;
            WeldConstraint3.Parent = v149;
            u38[v149.Name] = v149;
        end;
    end;

    for _, descendant in u38["Right Arm"]:GetDescendants() do
        if descendant:IsA("ParticleEmitter") and descendant.Name == "Lines" then
            descendant.Enabled = true;
        elseif descendant:IsA("Trail") then
            descendant.Enabled = true;
        end;
    end;

    Emit_All_With_Duration(u60.AfterPush);
    task.delay(0.6, function() -- Line: 809
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u38 (ref), u60 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, descendant in u38["Right Arm"]:GetDescendants() do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Lines" then
                descendant.Enabled = false;
            end;
        end;

        EnableVFX(u60.Windy, true);
        EnableVFX(u60.AfterPush.SnowyIn, true);
    end);
    task.delay(2.0833333333333335, function() -- Line: 821
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u38 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, descendant in u38["Right Arm"]:GetDescendants() do
            if descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;
    end);
    task.delay(4.55, function() -- Line: 830
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), Victim (copy), Vfx (ref), u37 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        if Victim then
            for _, child in Vfx.Surpass.VICTIM_VFX:GetChildren() do
                if Victim[child.Name] then
                    local v151 = child:Clone();
                    v151.CFrame = Victim[child.Name].CFrame;
                    v151.Parent = Folder;
                    local v152 = Victim[child.Name];
                    local WeldConstraint3 = Instance.new("WeldConstraint");
                    WeldConstraint3.Part0 = v151;
                    WeldConstraint3.Part1 = v152;
                    WeldConstraint3.Parent = v151;
                    u37[v151.Name] = v151;
                end;
            end;
        end;

        for _, v in u37 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "NormalDark" then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                    descendant.Enabled = true;
                end;
            end;
        end;
    end);
    task.delay(4.85, function() -- Line: 857
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.AfterPush, false);
    end);
    task.delay(6.116666666666666, function() -- Line: 862
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u37 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, v in u37 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "NormalDark" then
                    descendant.Enabled = false;
                end;
            end;
        end;
    end);
    task.delay(6.2, function() -- Line: 873
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy), u37 (ref), u58 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.DespairBG, true);

        for _, v in u37 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Superdark" then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                    descendant.Enabled = true;
                end;
            end;
        end;

        EnableVFX(u58.twelve, true);
        EnableVFX(u58.thirteen, true);
    end);
    task.delay(7.433333333333334, function() -- Line: 891
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy), u37 (ref), u58 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.DespairBG, false);

        for _, v in u37 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name == "Superdark" then
                    descendant.Enabled = false;
                end;
            end;
        end;

        EnableVFX(u58.twelve, false);
        EnableVFX(u58.thirteen, false);
        task.wait(0.05);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.BallElasticoBeam, true);
    end);
    task.delay(8.283333333333333, function() -- Line: 911
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy), u38 (ref)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        Emit_All_With_Duration(u60.Expansion);
        EnableVFX(u60.BallElasticoBeam, false);
        task.wait(0.06666666666666667);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, v in u38 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and (descendant.Name ~= "EyeBruhlol" and descendant.Name ~= "Lines") then
                    descendant.Enabled = true;
                end;

                if descendant:IsA("Beam") then
                    descendant.Enabled = true;
                end;
            end;
        end;

        EnableVFX(u60.SaeArea, true);
    end);
    task.delay(9.3, function() -- Line: 934
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        Emit_All_With_Duration(u60.Expansion2);
    end);
    task.delay(11.983333333333333, function() -- Line: 939
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u58 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u58.twelve, true);
        EnableVFX(u58.thirteen, true);
    end);
    task.delay(12.25, function() -- Line: 945
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        Emit_All_With_Duration(u60.SweatRin);
        EnableVFX(u60.SweatRin, true);
    end);
    task.delay(13.466666666666667, function() -- Line: 951
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy), u38 (ref), u58 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.SweatRin, false);
        task.wait(0.03333333333333333);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        for _, v in u38 do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and descendant.Name ~= "Lines" then
                    descendant.Enabled = true;
                end;
            end;
        end;

        EnableVFX(u58.twelve, false);
        EnableVFX(u58.thirteen, false);
    end);
    local ImpactFramesSae = Players.LocalPlayer.PlayerGui.ImpactFramesSae;
    task.spawn(function() -- Line: 971
        -- upvalues: ImpactFramesSae (copy)
        game.ContentProvider:PreloadAsync({ ImpactFramesSae });
    end);
    task.delay(14.083333333333334, function() -- Line: 975
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u59 (copy), ImpactFramesSae (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u59, true);
        task.wait(0.1);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        ImpactFramesSae.Enabled = true;

        for i = 1, 8 do
            if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
                return;
            end;

            if i > 1 then
                ImpactFramesSae[`Frame{i - 1}`].Position = UDim2.new(0.5, 0, 1.5, 0);
            end;

            ImpactFramesSae["Frame" .. i].Position = UDim2.new(0.5, 0, 0.5, 0);
            task.wait(0.022222222222222223);
            local _ = i;
        end;

        for i = 1, 8 do
            ImpactFramesSae["Frame" .. i].Position = UDim2.new(0.5, 0, 1.5, 0);
            local _ = i;
        end;

        ImpactFramesSae.Enabled = false;
    end);
    task.delay(14.7, function() -- Line: 1000
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u59 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u59, false);
    end);
    task.delay(14.833333333333334, function() -- Line: 1005
        -- upvalues: Folder (copy), Debris (ref), u33 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        (function(p153, p154, u155, u156, p157, u158) -- Line: 1008, Name: ColorCorrectionEffect
            local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
            ColorCorrectionEffect.Saturation = p153;
            ColorCorrectionEffect.Contrast = p154;
            ColorCorrectionEffect.Parent = game:GetService("Lighting");
            task.delay(p157, function() -- Line: 1014
                -- upvalues: ColorCorrectionEffect (copy), u155 (copy), u156 (copy), u158 (copy)
                ColorCorrectionEffect.Saturation = u155;
                ColorCorrectionEffect.Contrast = u156;
                task.wait(u158);
                ColorCorrectionEffect:Destroy();
            end);
        end)(-1, -3, -1, 3, 0.04, 0.05);
    end);
    task.delay(14.933333333333334, function() -- Line: 1026
        -- upvalues: Folder (copy), Debris (ref), u33 (copy), u60 (copy)
        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.BallSpin, true);
        task.wait(0.26666666666666666);

        if not Folder:GetAttribute("Active") or Debris:FindFirstChild(u33) == nil then
            return;
        end;

        EnableVFX(u60.BallSpin, false);
    end);

    local function v159() -- Line: 1036
        -- upvalues: Folder (copy), u36 (copy), ImpactFramesSae (copy), u49 (copy), u43 (ref), u45 (ref), u46 (ref), u47 (ref), u48 (ref), u44 (ref), Blur (copy), Size (copy), workspace_CurrentCamera (copy), FieldOfView (copy), Vignette (copy), ColorCorrection (copy), TintColor (copy), Contrast (copy), Saturation (copy), Brightness (copy), Atmosphere (copy), Color (copy), Density (copy), Offset (copy), Decay (copy), Glare (copy), Haze (copy), Highlight (copy), u40 (ref), u37 (ref), u38 (ref), u39 (ref)
        if Folder then
            Folder:SetAttribute("Active", false);
            Folder.Name = "_";
        end;

        if u36 then
            u36:Destroy();
        end;

        if ImpactFramesSae then
            ImpactFramesSae.Enabled = false;
        end;

        if u49 then
            u49:Destroy();
        end;

        if u43 then
            u43:Pause();
        end;

        if u45 then
            u45:Pause();
        end;

        if u46 then
            u46:Pause();
        end;

        if u47 then
            u47:Pause();
        end;

        if u48 then
            u48:Pause();
        end;

        if u44 then
            u44:Destroy();
        end;

        task.spawn(function() -- Line: 1079
            -- upvalues: Blur (ref), Size (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Vignette (ref), ColorCorrection (ref), TintColor (ref), Contrast (ref), Saturation (ref), Brightness (ref), Atmosphere (ref), Color (ref), Density (ref), Offset (ref), Decay (ref), Glare (ref), Haze (ref)
            for i = 1, 4 do
                Blur.Size = Size;
                workspace_CurrentCamera.FieldOfView = FieldOfView;
                local _ = i;

                for _, v in { Vignette, Vignette.LL, Vignette.UR } do
                    v.ImageTransparency = 1;
                end;

                ColorCorrection.TintColor = TintColor;
                ColorCorrection.Contrast = Contrast;
                ColorCorrection.Saturation = Saturation;
                ColorCorrection.Brightness = Brightness;
                Atmosphere.Color = Color;
                Atmosphere.Density = Density;
                Atmosphere.Offset = Offset;
                Atmosphere.Decay = Decay;
                Atmosphere.Glare = Glare;
                Atmosphere.Haze = Haze;
                task.wait(0.05);
            end;
        end);

        if Highlight then
            Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
        end;

        for _, v in u40 do
            v:Disconnect();
        end;

        for _, v in { u37, u38, u39 } do
            for _, v2 in v do
                if v2 then
                    if v2:IsA("ParticleEmitter") or (v2:IsA("Beam") or v2:IsA("Trail")) then
                        v2.Enabled = false;
                    else
                        EnableVFX(v2, false);
                    end;

                    task.delay(2, function() -- Line: 87
                        -- upvalues: v2 (copy)
                        if typeof(v2) == "table" then
                            for _, v3 in v2 do
                                if v3 then
                                    v3:Destroy();
                                end;
                            end;

                            return;
                        end;

                        if v2 then
                            v2:Destroy();
                        end;
                    end);
                end;
            end;
        end;

        table.clear(u37);
        table.clear(u38);
        table.clear(u39);
        table.clear(u40);
        u40 = nil;
        u39 = nil;
        u37 = nil;
        u38 = nil;
    end;

    table.insert(u40, Folder.Destroying:Connect(v159));
    table.insert(u40, Folder.AttributeChanged:Connect(v159));
end;
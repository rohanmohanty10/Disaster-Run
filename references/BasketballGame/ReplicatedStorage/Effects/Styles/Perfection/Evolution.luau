 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), Effects (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 38
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u4;
        end;

        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 6);
        end;
    end);
    task.delay(10.35 - u4, function() -- Line: 57
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    game_Lighting:FindFirstChild("Atmosphere");
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u16 = nil;
    local u17 = nil;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(10.35, function() -- Line: 98
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u18 = SfxManager:playSound({
        Sound = "BBZ perfect your mom perfected awakening cutscene",
        Parent = workspace
    });
    task.delay(5, function() -- Line: 107
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "You don\'t know my name...",
                2,
                0.5
            },
            { u3, "for I am <animation style=\"glitch\"><font color=\"#77db29\">EVOLUTION INCARNATE</font>!</animation>", 2 }
        });
    end);
    local u19 = script.Camera_VFX:Clone();
    u19:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u19.Parent = Folder;
    u19.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u19.PrimaryPart);
    local u20 = script.Vignette:Clone();
    u20.Parent = PlayerGui;
    u20.Enabled = false;
    local Vignette = u20.Vignette;
    local Vignette1 = u20.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

    local u22 = script.Cutscene_VFX:Clone();
    u22:PivotTo(HumanoidRootPart.CFrame);
    u22.Parent = Folder;
    local Sphere = u22.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local v23 = script.BALL:Clone();
    v23.CFrame = BALL.CFrame;
    v23.Parent = Folder;
    Essentials:Weld(v23, BALL);
    VfxManager.Enable(u22.Enable, true);
    task.delay(0.083 - u4, function() -- Line: 164
        -- upvalues: Folder (copy), u20 (copy), Highlight (copy), TweenService (ref), Sphere (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20.Enabled = true;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Sphere, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(0.467 - u4, function() -- Line: 177
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), DepthOfField (copy), u16 (ref), TweenService (ref), u17 (ref), u22 (copy), Model (copy), Highlight (copy), Sphere (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        task.spawn(function() -- Line: 180
            -- upvalues: VfxManager (ref), u19 (ref), Folder (ref), DepthOfField (ref), u16 (ref), TweenService (ref), u17 (ref)
            VfxManager.Enable(u19.AtmosphericVFX.Attachment.WindScene.White, true);
            (function(u24, u25) -- Line: 181, Name: TransparencyTween
                if not (u24 and (u24.Transparency and u24.Transparency.Keypoints)) then
                    return;
                end;

                local Transparency = u24.Transparency;
                local Keypoints = Transparency.Keypoints;

                if #Keypoints == 0 then
                    return;
                end;

                local u26 = {};

                for _, v in ipairs(Keypoints) do
                    table.insert(u26, {
                        Time = v.Time,
                        Value = v.Value,
                        Envelope = v.Envelope
                    });
                end;

                local os_clock_ret = os.clock();
                local u27 = os_clock_ret + u25;
                local RunService2 = game:GetService("RunService");
                local u28 = nil;
                u28 = RunService2.Heartbeat:Connect(function() -- Line: 202
                    -- upvalues: os_clock_ret (copy), u25 (copy), u26 (copy), u24 (copy), u27 (copy), u28 (ref), Transparency (copy)
                    local os_clock_ret2 = os.clock();
                    local math_clamp_ret = math.clamp((os_clock_ret2 - os_clock_ret) / u25, 0, 1);
                    local v29 = {};

                    for _, v in ipairs(u26) do
                        table.insert(v29, NumberSequenceKeypoint.new(v.Time, v.Value + (1 - v.Value) * math_clamp_ret, v.Envelope));
                    end;

                    u24.Transparency = NumberSequence.new(v29);

                    if u27 <= os_clock_ret2 then
                        u28:Disconnect();
                        task.delay(2, function() -- Line: 213
                            -- upvalues: u24 (ref), Transparency (ref)
                            u24.Transparency = Transparency;
                        end);
                    end;
                end);
            end)(u19.AtmosphericVFX.Attachment.WindScene.White.White, 0.08);
            task.wait(0.05);

            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            DepthOfField.FarIntensity = 1;
            DepthOfField.FocusDistance = 1;
            DepthOfField.InFocusRadius = 0;
            DepthOfField.NearIntensity = 0;
            u16 = TweenService:Create(DepthOfField, TweenInfo.new(20), {
                FocusDistance = 90
            });
            u16:Play();
            u17 = TweenService:Create(DepthOfField, TweenInfo.new(10), {
                FarIntensity = 0.21,
                InFocusRadius = 0,
                NearIntensity = 0
            });
            u17:Play();
        end);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.HILEANDRE.GroundStartEmitEffect);
        VfxManager.Enable(u22.HILEANDRE.EnabledChargeFX, true);
        VfxManager.Enable(Model, true);

        for _, descendant in pairs(u22.HILEANDRE.GroundStartEmitEffect:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 263
                    -- upvalues: descendant (copy), Folder (ref)
                    local TimeScale = descendant.TimeScale;
                    game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.35), {
                        TimeScale = 0.5
                    }):Play();
                    task.wait(3);

                    if Folder == nil or Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    descendant.TimeScale = TimeScale;
                end);
            end;
        end;

        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.FillTransparency = 1;
        Highlight.FillColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        TweenService:Create(Sphere, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local Model2 = Instance.new("Model");
        Model2.Parent = Model;
        Model.Torso.Parent = Model2;
        local v30 = tick() + 2;

        while tick() < v30 do
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            Model2:ScaleTo(math.random() + 1);
            task.wait(0.1);
        end;

        task.wait(2);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Model2:ScaleTo(1);
    end);
    task.delay(1.133 - u4, function() -- Line: 308
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.AtmosphericVFX.Attachment.WindScene.White, true);
    end);
    task.delay(1.333 - u4, function() -- Line: 314
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22.Enable, false);
    end);
    task.delay(2.368 - u4, function() -- Line: 321
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Highlight (copy), u19 (copy), Vignette (copy), Vignette1 (copy), ColorCorrection (copy), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy), u15 (ref), u22 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game_Lighting);
        ColorCorrectionEffect.Brightness = -0.3;
        ColorCorrectionEffect.Contrast = 2;
        ColorCorrectionEffect.Saturation = 0.3;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(47, 255, 61);
        ColorCorrectionEffect.Enabled = true;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        VfxManager.Enable(u19.DunkCameraHorizontal, true);
        Vignette.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(67, 255, 142);
        ColorCorrection.TintColor = Color3.fromRGB(41, 223, 108);
        ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(97, 147, 255)
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u13:Play();
        task.delay(0.05, function() -- Line: 351
            -- upvalues: Folder (ref), ColorCorrectionEffect (copy), u14 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), u15 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrectionEffect.Enabled = false;
            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u14:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.155, function() -- Line: 361
                -- upvalues: Folder (ref), ColorCorrectionEffect (ref), u15 (ref), TweenService (ref), ColorCorrection (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                ColorCorrectionEffect:Destroy();
                u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u15:Play();
            end);
        end);
        VfxManager.Enable(u22.HILEANDRE.EnabledChargeFX, false);
        VfxManager.Emit(u22.Flash_steps.Flashstep_1);
        VfxManager.Enable(Model, false);

        for _, descendant in pairs(u22.Flash_steps.Flashstep_1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                task.spawn(function() -- Line: 377
                    -- upvalues: descendant (copy), Folder (ref)
                    descendant.Enabled = true;
                    task.wait(0.12);

                    if Folder == nil or Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(2.767 - u4, function() -- Line: 389
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), Model (copy), game_Lighting (copy), TweenService (ref), Highlight (copy), u19 (copy), Vignette1 (copy), ColorCorrection (copy), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22.HILEANDRE.EnabledChargeFX, true);
        VfxManager.Enable(Model, true);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game_Lighting);
        ColorCorrectionEffect.Brightness = -0.3;
        ColorCorrectionEffect.Contrast = 7;
        ColorCorrectionEffect.Saturation = 0.3;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 68, 255);
        ColorCorrectionEffect.Enabled = true;
        Highlight.FillTransparency = 1;
        VfxManager.Enable(u19.DunkCameraHorizontal, false);
        Vignette1.ImageColor3 = Color3.fromRGB(35, 57, 255);
        ColorCorrectionEffect.Enabled = true;
        ColorCorrection.TintColor = Color3.fromRGB(41, 223, 108);
        ColorCorrection.Brightness = 0.55;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(97, 147, 255)
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u13:Play();
        task.delay(0.05, function() -- Line: 424
            -- upvalues: Folder (ref), ColorCorrectionEffect (copy), u14 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrectionEffect.Enabled = false;
            ColorCorrectionEffect:Destroy();
            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u14:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
        VfxManager.Emit(u22.Flash_steps.Flashstep_2);
        VfxManager.Enable(u22.Ball_Spin, true);

        for _, descendant in pairs(u22.Flash_steps.Flashstep_1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                task.spawn(function() -- Line: 442
                    -- upvalues: descendant (copy), Folder (ref)
                    descendant.Enabled = true;
                    task.wait(0.12);

                    if Folder == nil or Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(3.8 - u4, function() -- Line: 453
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Highlight (copy), u19 (copy), Vignette1 (copy), ColorCorrection (copy), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy), u15 (ref), u22 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game_Lighting);
        ColorCorrectionEffect.Brightness = -0.3;
        ColorCorrectionEffect.Contrast = 7;
        ColorCorrectionEffect.Saturation = 0.3;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 68, 255);
        ColorCorrectionEffect.Enabled = true;
        Highlight.FillTransparency = 0;
        VfxManager.Enable(u19.DunkCameraHorizontal, true);
        Vignette1.ImageColor3 = Color3.fromRGB(35, 57, 255);
        ColorCorrectionEffect.Enabled = true;
        ColorCorrection.TintColor = Color3.fromRGB(41, 223, 108);
        ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(75, 255, 111)
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u13:Play();
        task.delay(0.05, function() -- Line: 479
            -- upvalues: Folder (ref), ColorCorrectionEffect (copy), u14 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), u15 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrectionEffect.Enabled = false;
            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u14:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.155, function() -- Line: 488
                -- upvalues: Folder (ref), ColorCorrectionEffect (ref), u15 (ref), TweenService (ref), ColorCorrection (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                ColorCorrectionEffect:Destroy();
                u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u15:Play();
            end);
        end);
        VfxManager.Enable(u22.HILEANDRE.EnabledChargeFX, false);
        VfxManager.Emit(u22.Flash_steps.Flashstep_2);
        VfxManager.Enable(Model, false);

        for _, descendant in pairs(u22.Flash_steps.Flashstep_1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant.Name == "Flash" then
                task.spawn(function() -- Line: 503
                    -- upvalues: descendant (copy), Folder (ref)
                    descendant.Enabled = true;
                    task.wait(0.12);

                    if Folder == nil or Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    descendant.Enabled = false;
                end);
            end;
        end;
    end);
    task.delay(4.233 - u4, function() -- Line: 515
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Impact);
    end);
    task.delay(4.8 - u4, function() -- Line: 522
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), game_Lighting (copy), TweenService (ref), Highlight (copy), u19 (copy), Vignette1 (copy), ColorCorrection (copy), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Flash_steps.Flashstep_3);
        task.wait(0.067);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game_Lighting);
        ColorCorrectionEffect.Brightness = -0.3;
        ColorCorrectionEffect.Contrast = 7;
        ColorCorrectionEffect.Saturation = 0.3;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 68, 255);
        ColorCorrectionEffect.Enabled = true;
        Highlight.FillTransparency = 1;
        VfxManager.Enable(u19.DunkCameraHorizontal, false);
        Vignette1.ImageColor3 = Color3.fromRGB(35, 57, 255);
        ColorCorrectionEffect.Enabled = true;
        ColorCorrection.TintColor = Color3.fromRGB(41, 223, 108);
        ColorCorrection.Brightness = 0.55;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(97, 147, 255)
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u13:Play();
        task.delay(0.05, function() -- Line: 558
            -- upvalues: Folder (ref), ColorCorrectionEffect (copy), u14 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            ColorCorrectionEffect.Enabled = false;
            ColorCorrectionEffect:Destroy();
            u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u14:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
        VfxManager.Enable(u22.HILEANDRE.EnabledChargeFX, true);
        VfxManager.Emit(u22.Grab);
        VfxManager.Enable(Model, true);
        task.wait(0.1);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Words.Evolve);
    end);
    task.delay(5.983 - u4, function() -- Line: 585
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribbles.Dribble_0);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Words.Speed);
    end);
    task.delay(6.783 - u4, function() -- Line: 596
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribbles.Dribble_1);
    end);
    task.delay(6.783 - u4, function() -- Line: 602
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribbles.Dribble_1);
    end);
    task.delay(6.983 - u4, function() -- Line: 610
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Words.Drbbling);
    end);
    task.delay(7.983 - u4, function() -- Line: 617
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribbles.Dribble_2);
    end);
    task.delay(9.117 - u4, function() -- Line: 623
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Words.Mom);
    end);

    local function v31() -- Line: 632
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u20 (copy), Highlight (copy), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u11 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        if u12 then
            u12:Pause();
        end;

        if u13 then
            u13:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if u17 then
            u17:Pause();
        end;

        if u20 then
            u20:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u18 then
            VfxManager.DestroyEffect(u18, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v31));
    table.insert(u11, Folder.Destroying:Connect(v31));
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local UserService = game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 22
    -- upvalues: Players (copy), UserService (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), VfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Stand = p2.Stand;
    local v3 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local u6;

    if Stand then
        u6 = Stand:GetAttribute("Name");

        if u6 and u6 ~= "NPC" then
            task.spawn(function() -- Line: 38
                -- upvalues: UserService (ref), u6 (ref)
                local success, result = pcall(function() -- Line: 39
                    -- upvalues: UserService (ref), u6 (ref)
                    return UserService:GetUserInfosByUserIdsAsync({ u6 });
                end);

                if success and (result and (result[1] and result[1].DisplayName)) then
                    u6 = result[1].DisplayName;
                end;
            end);
        else
            u6 = "NPC";
        end;
    else
        u6 = "NPC";
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u7 = workspace:FindFirstChild(script.Name .. "Cart");
    local u8 = workspace:FindFirstChild(script.Name .. "Book");
    local u9 = workspace:FindFirstChild(script.Name .. "HeyLadies");
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(1 - PassedTime, function() -- Line: 59
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "You ladies alright?", 1 }
        });
    end);
    task.delay(2 - PassedTime, function() -- Line: 69
        -- upvalues: Effects (ref), u6 (ref)
        Effects:SubtitleV2({
            { u6, "*Flattered UwU*", 1 }
        });
    end);
    task.delay(4 - PassedTime, function() -- Line: 79
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Don\'t foul!", 0.5 }
        });
    end);
    task.delay(4.5 - PassedTime, function() -- Line: 89
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Watch your feet!", 0.5 }
        });
    end);
    task.delay(6 - PassedTime, function() -- Line: 99
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Aaaaand...", 1 },
            {
                u5,
                "<animation style=\"glitch\">SCORE!</animation>",
                1,
                3
            }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 118
        -- upvalues: u1 (copy), u11 (ref), u10 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * PassedTime;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(9.567 - PassedTime, function() -- Line: 140
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.567, function() -- Line: 153
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Referee You Ladies Alright?",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u14 = script.Cutscene_VFX:Clone();
    u14:PivotTo(HumanoidRootPart.CFrame);
    u14.Parent = Folder;
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
    u15.Parent = Folder;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local u16 = script.Ball:Clone();
    u16.CFrame = BALL.CFrame;
    u16.Parent = Debris;
    Essentials:Weld(u16, BALL);
    VfxManager.Enable(u16.Aura, true);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette1 = u17.Vignette1;
    u17.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(9.567, function() -- Line: 194
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u19 = Bloom:Clone();
    u19.Name = "B";
    u19.Parent = Lighting;
    u19.Enabled = true;
    task.delay(9.567, function() -- Line: 209
        -- upvalues: u19 (copy), Lighting (ref), Bloom (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local u20 = nil;
    local u21 = nil;
    local u22 = nil;
    local u23 = nil;
    local u24 = nil;
    local u25 = nil;
    local u26 = nil;
    local u27 = nil;
    local u28 = nil;
    local u29 = nil;
    task.delay(0.9 - PassedTime, function() -- Line: 227
        -- upvalues: Folder (copy), u9 (copy), HumanoidRootPart (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u9 then
            u9:ScaleTo(0.25);
            local NumberValue = Instance.new("NumberValue", u9);
            NumberValue.Value = 0.25;
            NumberValue.Changed:Connect(function() -- Line: 235
                -- upvalues: NumberValue (copy), u9 (ref)
                if NumberValue.Value > 0 then
                    u9:ScaleTo(NumberValue.Value);
                end;
            end);
            u9.PrimaryPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.788, 2.444, 7.556) * CFrame.fromEulerAngles(-2.8889911509486534, -0.7304551985446668, 3.0867544084921312);
            TweenService:Create(u9.PrimaryPart, TweenInfo.new(0.016666666666666666), {
                CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.788, 2.444, 7.556) * CFrame.fromEulerAngles(-2.8889911509486534, -0.7304551985446668, -1.4710856666284606)
            }):Play();
            task.wait(0.016666666666666666);
            TweenService:Create(NumberValue, TweenInfo.new(0.08333333333333333), {
                Value = 0.65
            }):Play();
            TweenService:Create(u9.PrimaryPart, TweenInfo.new(0.21666666666666667), {
                CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.546, 2.376, 7.817) * CFrame.fromEulerAngles(-2.8889911509486534, -0.7304551985446668, 3.0867544084921312)
            }):Play();
            task.wait(0.08333333333333333);
            TweenService:Create(NumberValue, TweenInfo.new(0.18333333333333332), {
                Value = 0.3
            }):Play();
            task.wait(0.18333333333333332);
            TweenService:Create(NumberValue, TweenInfo.new(0.1), {
                Value = 0.75
            }):Play();
            task.wait(0.7666666666666667);
            u9:Destroy();
        end;
    end);
    task.delay(0.11666666666666667 - PassedTime, function() -- Line: 255
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 and u7:FindFirstChild("CartToRig") then
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.009"].Attachment, true);
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.012"].Attachment, true);
        end;
    end);
    task.delay(0.11666666666666667 - PassedTime, function() -- Line: 264
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 and u7:FindFirstChild("CartToRig") then
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.009"].Attachment, true);
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.012"].Attachment, true);
        end;
    end);
    task.delay(0.6333333333333333 - PassedTime, function() -- Line: 273
        -- upvalues: Folder (copy), u7 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 and u7:FindFirstChild("CartToRig") then
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.009"].Attachment, false);
            VfxManager.Enable(u7.CartToRig.MainBone["Bone.012"].Attachment, false);
        end;
    end);
    task.delay(0.65 - PassedTime, function() -- Line: 282
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u16.Catch);
        VfxManager.Enable(u16.Aura, false);
    end);
    task.delay(0.7 - PassedTime, function() -- Line: 289
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Land2);
    end);
    task.delay(1.8166666666666667, function() -- Line: 295
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.Aura, true);
        end;
    end);
    task.delay(2 - PassedTime, function() -- Line: 303
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), u16 (copy), Vignette1 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u14.PinkBackground, true);
        VfxManager.Enable(u16.Aura, true);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 123, 150);
        TweenService:Create(Vignette1, TweenInfo.new(0.5), {
            ImageTransparency = 0
        }):Play();
    end);
    task.delay(2.4 - PassedTime, function() -- Line: 313
        -- upvalues: Folder (copy), Stand (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v30 = script.Head:Clone();
        v30.Parent = Folder;
        v30.CFrame = Stand.Head.CFrame;
        VfxManager.Emit(v30);
    end);
    task.delay(2.9166666666666665 - PassedTime, function() -- Line: 322
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.Aura, false);
        end;
    end);
    task.delay(3.2666666666666666 - PassedTime, function() -- Line: 330
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u14.PinkBackground, false);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(3.3333333333333335 - PassedTime, function() -- Line: 338
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce);
    end);
    task.delay(3.8 - PassedTime, function() -- Line: 344
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce1);
    end);
    task.delay(4.233333333333333 - PassedTime, function() -- Line: 350
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce2);
    end);
    task.delay(4.283333333333333 - PassedTime, function() -- Line: 356
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), Vignette1 (copy), TweenService (ref), u19 (copy), Lighting (ref), u20 (ref), u18 (copy), u27 (ref), Bloom (copy), u21 (ref), u22 (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Dash1);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u19.Intensity = 15;
        u19.Threshold = 0.5;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u20 = TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
        u27 = TweenService:Create(u19, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.067);
        u21 = TweenService:Create(u18, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 1
        }):Play();
        task.wait(0.1);
        u22 = TweenService:Create(u18, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(4.366666666666666 - PassedTime, function() -- Line: 385
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce3);
    end);
    task.delay(4.6 - PassedTime, function() -- Line: 391
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce4);
    end);
    task.delay(4.716666666666667 - PassedTime, function() -- Line: 397
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), Vignette1 (copy), TweenService (ref), u19 (copy), Lighting (ref), u23 (ref), u18 (copy), u28 (ref), Bloom (copy), u24 (ref), u25 (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Dash2);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u19.Intensity = 15;
        u19.Threshold = 0.5;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u23 = TweenService:Create(u18, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.4
        }):Play();
        u28 = TweenService:Create(u19, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.067);
        u24 = TweenService:Create(u18, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 1
        }):Play();
        task.wait(0.35);
        u25 = TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(4.833333333333333 - PassedTime, function() -- Line: 426
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce5);
    end);
    task.delay(5.016666666666667 - PassedTime, function() -- Line: 432
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce6);
    end);
    task.delay(5.35 - PassedTime, function() -- Line: 438
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.BallBounce7);
    end);
    task.delay(5.883333333333334 - PassedTime, function() -- Line: 444
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u19 (copy), Lighting (ref), u29 (ref), TweenService (ref), Bloom (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightLines, true);
            VfxManager.Enable(CamRig.camera.LeftLines, true);
        end;

        u19.Intensity = 15;
        u19.Threshold = 0.5;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        VfxManager.DestroyEffect(BlurEffect, 0.855);
        u29 = TweenService:Create(u19, TweenInfo.new(0.35, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.Enable(u15.CameraAtmosphere, true);
        task.wait(1.85);
        VfxManager.Enable(u15.CameraAtmosphere, false);
    end);
    task.delay(6.333333333333333 - PassedTime, function() -- Line: 469
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightLines, false);
            VfxManager.Enable(CamRig.camera.LeftLines, false);
        end;
    end);
    task.delay(6.35 - PassedTime, function() -- Line: 478
        -- upvalues: Folder (copy), u14 (copy), VfxManager (ref), CamRig (copy), u26 (ref), TweenService (ref), u18 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u14.Box.PrimaryPart.Transparency = 0;
        VfxManager.Enable(u14.Box, true);
        VfxManager.Enable(u14.BeamBackground, true);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightLines, true);
            VfxManager.Enable(CamRig.camera.LeftLines, true);
            VfxManager.Enable(CamRig.camera.RightCinematicBars, true);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, true);
        end;

        u26 = TweenService:Create(u18, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
    end);
    task.delay(7.733333333333333 - PassedTime, function() -- Line: 495
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), CamRig (copy), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u14.BeamBackground, false);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.RightLines2, true);
            VfxManager.Enable(CamRig.camera.LeftLines2, true);
            VfxManager.Enable(CamRig.camera.RightLines, false);
            VfxManager.Enable(CamRig.camera.LeftLines, false);
            VfxManager.Enable(CamRig.camera.RightCinematicBars, false);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, false);
        end;

        u18.Brightness = ColorCorrection.Brightness;
    end);
    task.delay(7.75 - PassedTime, function() -- Line: 512
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), Vignette1 (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u14.Score);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 255, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(7.95 - PassedTime, function() -- Line: 522
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u16, false);
    end);
    task.delay(9.65, function() -- Line: 528
        -- upvalues: Folder (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u14:FindFirstChild("Box") then
            u14.Box:Destroy();
        end;
    end);
    local u31 = {};

    local function v32() -- Line: 537
        -- upvalues: u31 (ref), Folder (copy), u20 (ref), u21 (ref), u22 (ref), u23 (ref), u24 (ref), u25 (ref), u26 (ref), u27 (ref), u28 (ref), u29 (ref), u7 (copy), u8 (copy), u9 (copy), u16 (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), Bloom (copy)
        for _, v in pairs(u31) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u20 then
            u20:Pause();
        end;

        if u21 then
            u21:Pause();
        end;

        if u22 then
            u22:Pause();
        end;

        if u23 then
            u23:Pause();
        end;

        if u24 then
            u24:Pause();
        end;

        if u25 then
            u25:Pause();
        end;

        if u26 then
            u26:Pause();
        end;

        if u27 then
            u27:Pause();
        end;

        if u28 then
            u28:Pause();
        end;

        if u29 then
            u29:Pause();
        end;

        if u7 then
            u7:Destroy();
        end;

        if u8 then
            u8:Destroy();
        end;

        if u9 then
            u9:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        u31 = nil;
    end;

    table.insert(u31, Folder.AttributeChanged:Connect(v32));
    table.insert(u31, Folder.Destroying:Connect(v32));
end;
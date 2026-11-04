 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local u7 = Players:FindFirstChild(Other.Name) or Other.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Gotta admit you got me...", 1.5 }
        });
    end);
    task.delay(2.25 - u3, function() -- Line: 48
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "*Gasp*", 0.5 }
        });
    end);
    task.delay(2.75 - u3, function() -- Line: 58
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "What the-", 1.25 }
        });
    end);
    task.delay(4 - u3, function() -- Line: 68
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "What did he say?", 1 }
        });
    end);
    task.delay(5 - u3, function() -- Line: 78
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Eyes like mine?", 1 },
            { u7, "Hes got emperor eye too?", 1.5 }
        });
    end);
    task.delay(8.5 - u3, function() -- Line: 93
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Don\'t get the wrong idea though...", 1.5 }
        });
    end);
    task.delay(10.5 - u3, function() -- Line: 103
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<animation style=\"appear\">THERE ARE TOTALLY DIFFERENT LEVELS!</animation>", 1.5 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 116
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u3;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(15 - u3, function() -- Line: 138
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15 - u3, function() -- Line: 151
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Gold Im Better",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.PrimaryPart, CamRig.camera);
    local u14 = script.Head:Clone();
    u14.CFrame = Head.CFrame;
    u14.Parent = Folder;
    Essentials:Weld(u14, Head);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.Sweat:GetChildren()) do
        local v15 = Character:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model;
            Essentials:Weld(v16, v15);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v17 = Other:FindFirstChild(child.Name);

            if v17 then
                local v18 = child:Clone();
                v18.CFrame = v17.CFrame;
                v18.Parent = Model2;
                Essentials:Weld(v18, v17);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local Vignette = u19.Vignette;
    local Vignette1 = u19.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u20 = ColorCorrection:Clone();
    u20.Name = "CC";
    u20.Parent = Lighting;
    u20.Enabled = true;
    u20.Contrast = 0.6;
    u20.Brightness = 0.2;
    task.delay(15, function() -- Line: 221
        -- upvalues: u20 (copy), Lighting (ref), ColorCorrection (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u21 = Bloom:Clone();
    u21.Name = "B";
    u21.Parent = Lighting;
    u21.Enabled = true;
    u21.Intensity = 2;
    u21.Threshold = 2;
    task.delay(15 - u3, function() -- Line: 238
        -- upvalues: u21 (copy), Lighting (ref), Bloom (copy)
        u21:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u22 = DepthOfField:Clone();
    u22.Name = "D";
    u22.Parent = Lighting;
    u22.Enabled = true;
    u22.InFocusRadius = 0;
    u22.NearIntensity = 0;
    task.delay(15, function() -- Line: 255
        -- upvalues: u22 (copy), Lighting (ref), DepthOfField (copy)
        u22:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local Density = Lighting.Atmosphere.Density;
    Lighting.Atmosphere.Density = 0.15;
    local ExposureCompensation = Lighting.ExposureCompensation;
    Lighting.ExposureCompensation = -1;
    task.spawn(function() -- Line: 273
        -- upvalues: Folder (copy), u22 (copy), TweenService (ref), VfxManager (ref), u13 (copy), u14 (copy), Model (copy), Model2 (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u22.FarIntensity = 1;
        TweenService:Create(u22, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            FocusDistance = 65.88
        }):Play();
        VfxManager.Enable(u13.CameraShade, true);
        VfxManager.Enable(u14, true);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(Model2, true);
        u13.CameraShade.Light.RedSurfaceLight.Enabled = true;
        u13.CameraShade.Light.WhiteSurfaceLight.Enabled = true;
        local C = u13.CameraShade:FindFirstChild("C");
        C.TimeScale = 1;
        TweenService:Create(C, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.2
        }):Play();
        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(1.8666666666666667 - u3, function() -- Line: 296
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u20 (copy), ColorCorrection (copy), Vignette1 (copy), ClockTime (copy), ExposureCompensation (copy), Density (copy), u21 (copy), Bloom (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u20.Brightness = 0.6;
        u20.TintColor = Color3.fromRGB(255, 151, 60);
        TweenService:Create(u20, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = 0.2,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 151, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);

        if Lighting.ClockTime ~= ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        if Lighting.ExposureCompensation ~= ExposureCompensation then
            Lighting.ExposureCompensation = ExposureCompensation;
        end;

        if Lighting.Atmosphere.Density ~= Density then
            Lighting.Atmosphere.Density = Density;
        end;

        TweenService:Create(u20, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1
        }):Play();
        TweenService:Create(u21, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Intensity = Bloom.Intensity
        }):Play();
    end);
    task.delay(2.1166666666666667 - u3, function() -- Line: 330
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.CameraShade, false);
        u13.CameraShade.Light.RedSurfaceLight.Enabled = false;
        u13.CameraShade.Light.WhiteSurfaceLight.Enabled = false;
        u13.CameraVictimShade.Light.WhiteSurfaceLight.Enabled = true;
    end);
    task.delay(4.266666666666667 - u3, function() -- Line: 340
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.ZoomFX, true);
    end);
    task.delay(5.05 - u3, function() -- Line: 346
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.CameraStarsTransition);
    end);
    task.delay(5.066666666666666 - u3, function() -- Line: 352
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u20 (copy), ColorCorrection (copy), u13 (copy), TweenService (ref), VfxManager (ref), u19 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        task.spawn(function() -- Line: 355
            -- upvalues: u12 (ref)
            local v23 = tick();

            repeat
                task.wait();
                local Specs = u12.Specs;
                Specs.CFrame = Specs.CFrame * CFrame.Angles(0, -0.01658062789394613, 0);
            until tick() - v23 > 6.816666666666666;
        end);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 151, 60);
        Vignette1.ImageTransparency = 0.75;
        u20.Saturation = ColorCorrection.Saturation;
        local C = u13.CameraDribbleShade:FindFirstChild("C");
        C.TimeScale = 1;
        TweenService:Create(C, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
        task.delay(4, function() -- Line: 370
            -- upvalues: C (copy)
            C.TimeScale = 1;
        end);
        VfxManager.Enable(u13.ZoomFX, false);
        VfxManager.Enable(u13.CameraDribbleShade, true);
        VfxManager.Enable(u12.Aura, true);
        VfxManager.Enable(u12.Specs, true);
        VfxManager.Enable(u12.UserLights, true);
        u13.CameraVictimShade.Light.WhiteSurfaceLight.Enabled = false;
        u12.Part.Transparency = 0.9;
        u12.Sphere.Transparency = 0.9;
        TweenService:Create(u19.BottomFrame, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.955, 0)
        }):Play();
        TweenService:Create(u19.TopFrame, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, -0.114, 0)
        }):Play();
    end);
    task.delay(11.416666666666666 - u3, function() -- Line: 389
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Pass);
    end);
    task.delay(11.883333333333333 - u3, function() -- Line: 395
        -- upvalues: Folder (copy), Vignette1 (copy), VfxManager (ref), u13 (copy), u12 (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 1;
        VfxManager.Enable(u13.CameraDribbleShade, false);
        VfxManager.Enable(u12.UserLights, false);
        VfxManager.Enable(u12.Specs, false);
        VfxManager.Enable(u12.Aura, false);
        VfxManager.Enable(u14, false);
    end);
    task.delay(11.983333333333333 - u3, function() -- Line: 407
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), u12 (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.BetterEmit(u12.Catch);
        VfxManager.Enable(u13.CameraTeamateShade, true);
        u13.CameraTeamateShade.Attachment.SurfaceLight.Enabled = true;
    end);
    task.delay(12.65 - u3, function() -- Line: 420
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Dribble);
    end);
    task.delay(13.466666666666667 - u3, function() -- Line: 426
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.LandFX);
    end);
    task.delay(13.966666666666667 - u3, function() -- Line: 432
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.Cam_Lines, true);
        VfxManager.Enable(u12.Test, true);
    end);
    task.delay(14.5 - u3, function() -- Line: 439
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u20 (copy), ColorCorrection (copy), u12 (copy), u13 (copy), u22 (copy), DepthOfField (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0.6;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 151, 60);
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.35);
        u20.Brightness = 0.6;
        u20.TintColor = Color3.fromRGB(255, 151, 60);
        TweenService:Create(u20, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u20, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u12.Dunk);
        VfxManager.Enable(u13.CameraTeamateShade, false);
        VfxManager.Enable(u13.Cam_Lines, false);
        u13.CameraTeamateShade.Attachment.SurfaceLight.Enabled = false;
        u22.FarIntensity = DepthOfField.FarIntensity;
        u22.FocusDistance = DepthOfField.FocusDistance;
    end);
    local u24 = {};

    local function v25() -- Line: 467
        -- upvalues: u24 (ref), Folder (copy), u19 (copy), u20 (copy), Lighting (ref), ColorCorrection (copy), u21 (copy), Bloom (copy), u22 (copy), DepthOfField (copy), ClockTime (copy), ExposureCompensation (copy), Density (copy)
        for _, v in pairs(u24) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u19 then
            u19:Destroy();
        end;

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u21 then
            u21:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u22 then
            u22:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if Lighting.ClockTime ~= ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        if Lighting.ExposureCompensation ~= ExposureCompensation then
            Lighting.ExposureCompensation = ExposureCompensation;
        end;

        if Lighting.Atmosphere.Density ~= Density then
            Lighting.Atmosphere.Density = Density;
        end;

        u24 = nil;
    end;

    table.insert(u24, Folder.AttributeChanged:Connect(v25));
    table.insert(u24, Folder.Destroying:Connect(v25));
end;
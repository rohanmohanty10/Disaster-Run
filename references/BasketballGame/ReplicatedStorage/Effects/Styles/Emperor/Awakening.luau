 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), ReplicatedStorage (copy), UIController (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local Other2 = p2.Other2;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local u7 = Players:FindFirstChild(Other.Name) or "Chrollo";
    local u8 = Players:FindFirstChild(Other2.Name) or "Tatlis";
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.5 - u3, function() -- Line: 38
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "You\'re not going anywhere!", 1 }
        });
    end);
    task.delay(1.75 - u3, function() -- Line: 48
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Why don\'t you get out of my way?", 1.5 }
        });
    end);
    task.delay(3.25 - u3, function() -- Line: 58
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "You can\'t seriously think we\'ll do that?!", 2.75 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 68
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "Don\'t get ahead of yourself!", 2.25 }
        });
    end);
    task.delay(10.25 - u3, function() -- Line: 78
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<animation style=\"appear\"><font color=\"#ff0000\">No.</font>.</animation>", 0.75 },
            { u6, "My orders are...", 1.25 },
            { u6, "<animation style=\"appear\">...<font color=\"#ff0000\">absolute</font>.</animation>", 1 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 101
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u3;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(15.55 - u3, function() -- Line: 123
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15.55 - u3, function() -- Line: 136
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Emperor Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig.camera.CFrame);
    u14.Parent = Folder;
    Essentials:Weld(u14.PrimaryPart, CamRig.camera);
    local u15 = script.Ball:Clone();
    u15.CFrame = BALL.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v16 = Character:FindFirstChild(child.Name);

        if v16 then
            local v17 = child:Clone();
            v17.CFrame = v16.CFrame;
            v17.Parent = Model;
            Essentials:Weld(v17, v16);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v18 = Other:FindFirstChild(child.Name);

            if v18 then
                local v19 = child:Clone();
                v19.CFrame = v18.CFrame;
                v19.Parent = Model2;
                Essentials:Weld(v19, v18);
            end;
        end;
    end;

    local Model3 = Instance.new("Model");
    Model3.Parent = Folder;

    if Other2 then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v20 = Other2:FindFirstChild(child.Name);

            if v20 then
                local v21 = child:Clone();
                v21.CFrame = v20.CFrame;
                v21.Parent = Model3;
                Essentials:Weld(v21, v20);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u22 = script.Vignette:Clone();
    u22.Parent = PlayerGui;
    u22.Enabled = true;
    local Vignette = u22.Vignette;
    local Vignette1 = u22.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u23 = ColorCorrection:Clone();
    u23.Name = "CC";
    u23.Parent = Lighting;
    u23.Enabled = true;
    task.delay(15.55, function() -- Line: 219
        -- upvalues: u23 (copy), Lighting (ref), ColorCorrection (copy)
        u23:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u24 = Bloom:Clone();
    u24.Name = "B";
    u24.Parent = Lighting;
    u24.Enabled = true;
    task.delay(15.55, function() -- Line: 234
        -- upvalues: u24 (copy), Lighting (ref), Bloom (copy)
        u24:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u25 = DepthOfField:Clone();
    u25.Name = "D";
    u25.Parent = Lighting;
    u25.Enabled = true;
    u25.FarIntensity = 1;
    u25.FocusDistance = 68.24;
    u25.InFocusRadius = 0;
    u25.NearIntensity = 0;
    task.delay(15.55, function() -- Line: 253
        -- upvalues: u25 (copy), Lighting (ref), DepthOfField (copy)
        u25:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 260
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), VfxManager (ref), Model2 (copy), Model3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        VfxManager.Enable(Model2, true);
        VfxManager.Enable(Model3, true);
    end);
    task.delay(0.48333333333333334 - u3, function() -- Line: 271
        -- upvalues: Folder (copy), u13 (copy), VfxManager (ref), Model (copy), u14 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.AuraEmit);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u13.TheZone, true);
        VfxManager.Enable(u14.CameraShade, true);
        u14.CameraShade.Attachment.SurfaceLight.Enabled = true;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0.25;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 0.65;
        u23.Saturation = -1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u23, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(1 - u3, function() -- Line: 298
        -- upvalues: Folder (copy), u13 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Dribble1);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0.25;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 0.65;
        u23.Saturation = -1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u23, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.8 - u3, function() -- Line: 320
        -- upvalues: Folder (copy), u13 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Dribble1);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0.25;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.9166666666666667 - u3, function() -- Line: 339
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u13 (copy), VfxManager (ref), Model (copy), u14 (copy), u23 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u13.Sphere.Transparency = 0;
        u13.Part.Transparency = 0;
        VfxManager.Enable(Model, false);
        VfxManager.Enable(u14.FaceLight, true);
        u23.Saturation = -1;
    end);
    task.delay(2.8833333333333333 - u3, function() -- Line: 355
        -- upvalues: Folder (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.CamTrans);
    end);
    task.delay(2.9833333333333334 - u3, function() -- Line: 361
        -- upvalues: Folder (copy), TweenService (ref), u13 (copy), VfxManager (ref), u14 (copy), u24 (copy), Vignette1 (copy), Lighting (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u13.Sphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        TweenService:Create(u13.Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        VfxManager.Enable(u14.FaceLight, false);
        VfxManager.Enable(u14.VictimLight, true);
        local C = u14.VictimLight:FindFirstChild("C");
        C.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
        C.TimeScale = 1;
        TweenService:Create(C, TweenInfo.new(3, Enum.EasingStyle.Sine), {
            TimeScale = 0.1
        }):Play();
        TweenService:Create(u24, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Threshold = 1.5
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0.25;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 0.65;
        u23.Saturation = -1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u23, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(8.85 - u3, function() -- Line: 393
        -- upvalues: Folder (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.CamTrans);
    end);
    task.delay(8.933333333333334 - u3, function() -- Line: 399
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy), u13 (copy), VfxManager (ref), Model (copy), u14 (copy), u25 (copy), Lighting (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u13.Sphere.Transparency = 1;
        u13.Part.Transparency = 1;
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u14.CameraShadeV2, true);
        VfxManager.Enable(u14.VictimLight, false);
        u14.VictimLight:FindFirstChild("C").Color = ColorSequence.new(Color3.fromRGB(255, 35, 35));
        u25.FocusDistance = 15;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0.25;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 0.65;
        u23.Saturation = -1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u23, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(9.466666666666667 - u3, function() -- Line: 433
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.Dribble2);
    end);
    task.delay(10.283333333333333 - u3, function() -- Line: 439
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), u3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u14.CameraShadeV2, false);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v26 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v26.BackgroundTransparency = 0;
        v26.Parent = ScreenGui;
        UIController:PlayFlipbook(v26, "EmperorEye", 0.03139717425431711, u3);
        ScreenGui:Destroy();
    end);
    task.delay(13.2 - u3, function() -- Line: 457
        -- upvalues: Folder (copy), u13 (copy), u14 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u23 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u13.Sphere.Transparency = 0.7;
        u13.Part.Transparency = 0.7;
        shared.vfx.emit(u14.Cameravhs.Attachment);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u23.Brightness = 0.65;
        u23.Saturation = -1;
        u23.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u23, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u23, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(14 - u3, function() -- Line: 478
        -- upvalues: Folder (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.CamTrans);
    end);
    task.delay(14.15 - u3, function() -- Line: 484
        -- upvalues: Folder (copy), Vignette1 (copy), u13 (copy), u14 (copy), VfxManager (ref), BALL (copy), u15 (copy), Lighting (ref), u24 (copy), Character (copy), Other (copy), Other2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(103, 8, 8);
        Vignette1.ImageTransparency = 0.5;
        u13.Sphere.Transparency = 0;
        u13.Part.Transparency = 0;
        u13.Sphere.Color = Color3.fromRGB(103, 8, 8);
        u13.Part.Color = Color3.fromRGB(103, 8, 8);
        shared.vfx.emit(u14.Cameravhs.Attachment);
        VfxManager.Enable(u13.Background, true);
        VfxManager.Enable(u14.Speedlines, true);
        VfxManager.Enable(u14.CameraShadeV1, true);
        BALL.Transparency = 1;
        u15.Transparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 4;
        VfxManager.DestroyEffect(BlurEffect, 1.24);
        u24.Intensity = 3;
        u24.Threshold = 1;

        for _, v in { Character, Other, Other2 } do
            if v and v.Parent then
                local Highlight = Instance.new("Highlight");
                Highlight.Parent = Folder;
                Highlight.Adornee = v;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
                Highlight.FillTransparency = 0;
                Highlight.OutlineTransparency = 0.95;
            end;
        end;
    end);
    local u27 = {};

    local function v28() -- Line: 528
        -- upvalues: u27 (ref), Folder (copy), u22 (copy), u23 (copy), Lighting (ref), ColorCorrection (copy), u24 (copy), Bloom (copy), u25 (copy), DepthOfField (copy)
        for _, v in pairs(u27) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u22 then
            u22:Destroy();
        end;

        if u23 then
            u23:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u24 then
            u24:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u25 then
            u25:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u27 = nil;
    end;

    table.insert(u27, Folder.AttributeChanged:Connect(v28));
    table.insert(u27, Folder.Destroying:Connect(v28));
end;
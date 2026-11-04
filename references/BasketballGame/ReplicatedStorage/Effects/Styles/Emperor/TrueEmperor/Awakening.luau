 
 

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
    local u5 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = Players:FindFirstChild(Character.Name);
    local u8 = Players:FindFirstChild(Other.Name) or "Chrollo";
    local u9 = Players:FindFirstChild(Other2.Name) or "Tatlis";
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.5 - u3, function() -- Line: 40
        -- upvalues: Effects (ref), u9 (copy)
        Effects:SubtitleV2({
            { u9, "You\'re not going anywhere!", 1 }
        });
    end);
    task.delay(1.75 - u3, function() -- Line: 50
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Why don\'t you get out of my way?", 1.5 }
        });
    end);
    task.delay(3.25 - u3, function() -- Line: 60
        -- upvalues: Effects (ref), u8 (copy)
        Effects:SubtitleV2({
            { u8, "You can\'t seriously think we\'ll do that?!", 2.75 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 70
        -- upvalues: Effects (ref), u9 (copy)
        Effects:SubtitleV2({
            { u9, "Don\'t get ahead of yourself!", 2.25 }
        });
    end);
    task.delay(10.25 - u3, function() -- Line: 80
        -- upvalues: Effects (ref), u7 (copy), u5 (copy)
        Effects:SubtitleV2({
            { u7, `<animation style="appear"><font color="#{u5:ToHex()}">No.</font>.</animation>`, 0.75 },
            { u7, "My orders are...", 1.25 },
            { u7, `<animation style="appear">...<font color="#{u5:ToHex()}">absolute</font>.</animation>`, 1 }
        });
    end);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 103
        -- upvalues: u1 (copy), u11 (ref), u10 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u3;
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
    task.delay(15.55 - u3, function() -- Line: 125
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15.55 - u3, function() -- Line: 138
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
    local u14 = script.Cutscene_VFX:Clone();
    u14:PivotTo(HumanoidRootPart.CFrame);
    u14.Parent = Folder;
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig.camera.CFrame);
    u15.Parent = Folder;
    Essentials:Weld(u15.PrimaryPart, CamRig.camera);
    local u16 = script.Ball:Clone();
    u16.CFrame = BALL.CFrame;
    u16.Parent = Folder;
    Essentials:Weld(u16, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v17 = Character:FindFirstChild(child.Name);

        if v17 then
            local v18 = child:Clone();
            v18.CFrame = v17.CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, v17);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v19 = Other:FindFirstChild(child.Name);

            if v19 then
                local v20 = child:Clone();
                v20.CFrame = v19.CFrame;
                v20.Parent = Model2;
                Essentials:Weld(v20, v19);
            end;
        end;
    end;

    local Model3 = Instance.new("Model");
    Model3.Parent = Folder;

    if Other2 then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v21 = Other2:FindFirstChild(child.Name);

            if v21 then
                local v22 = child:Clone();
                v22.CFrame = v21.CFrame;
                v22.Parent = Model3;
                Essentials:Weld(v22, v21);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u23 = script.Vignette:Clone();
    u23.Parent = PlayerGui;
    u23.Enabled = true;
    local Vignette = u23.Vignette;
    local Vignette1 = u23.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u24 = ColorCorrection:Clone();
    u24.Name = "CC";
    u24.Parent = Lighting;
    u24.Enabled = true;
    task.delay(15.55, function() -- Line: 221
        -- upvalues: u24 (copy), Lighting (ref), ColorCorrection (copy)
        u24:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u25 = Bloom:Clone();
    u25.Name = "B";
    u25.Parent = Lighting;
    u25.Enabled = true;
    task.delay(15.55, function() -- Line: 236
        -- upvalues: u25 (copy), Lighting (ref), Bloom (copy)
        u25:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u26 = DepthOfField:Clone();
    u26.Name = "D";
    u26.Parent = Lighting;
    u26.Enabled = true;
    u26.FarIntensity = 1;
    u26.FocusDistance = 68.24;
    u26.InFocusRadius = 0;
    u26.NearIntensity = 0;
    task.delay(15.55, function() -- Line: 255
        -- upvalues: u26 (copy), Lighting (ref), DepthOfField (copy)
        u26:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 262
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
    task.delay(0.48333333333333334 - u3, function() -- Line: 273
        -- upvalues: Folder (copy), u14 (copy), VfxManager (ref), Model (copy), u15 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), u24 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.AuraEmit);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u14.TheZone, true);
        VfxManager.Enable(u15.CameraShade, true);
        u15.CameraShade.Attachment.SurfaceLight.Enabled = true;
        Vignette1.ImageColor3 = u5;
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
        u24.Brightness = 0.65;
        u24.Saturation = -1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(1 - u3, function() -- Line: 300
        -- upvalues: Folder (copy), u14 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u24 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.Dribble1);
        Vignette1.ImageColor3 = u5;
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
        u24.Brightness = 0.65;
        u24.Saturation = -1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.8 - u3, function() -- Line: 322
        -- upvalues: Folder (copy), u14 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u24 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.Dribble1);
        Vignette1.ImageColor3 = u5;
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
        u24.Brightness = 1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.9166666666666667 - u3, function() -- Line: 341
        -- upvalues: Folder (copy), Vignette (copy), u5 (copy), TweenService (ref), u14 (copy), VfxManager (ref), Model (copy), u15 (copy), u24 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = u5;
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u14.Sphere.Transparency = 0;
        u14.Part.Transparency = 0;
        VfxManager.Enable(Model, false);
        VfxManager.Enable(u15.FaceLight, true);
        u24.Saturation = -1;
    end);
    task.delay(2.8833333333333333 - u3, function() -- Line: 357
        -- upvalues: Folder (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u15.CamTrans);
    end);
    task.delay(2.9833333333333334 - u3, function() -- Line: 363
        -- upvalues: Folder (copy), TweenService (ref), u14 (copy), VfxManager (ref), u15 (copy), u25 (copy), Vignette1 (copy), u5 (copy), Lighting (ref), u24 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u14.Sphere, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        TweenService:Create(u14.Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.75
        }):Play();
        VfxManager.Enable(u15.FaceLight, false);
        VfxManager.Enable(u15.VictimLight, true);
        local C = u15.VictimLight:FindFirstChild("C");
        C.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
        C.TimeScale = 1;
        TweenService:Create(C, TweenInfo.new(3, Enum.EasingStyle.Sine), {
            TimeScale = 0.1
        }):Play();
        TweenService:Create(u25, TweenInfo.new(3, Enum.EasingStyle.Linear), {
            Threshold = 1.5
        }):Play();
        Vignette1.ImageColor3 = u5;
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
        u24.Brightness = 0.65;
        u24.Saturation = -1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(8.85 - u3, function() -- Line: 395
        -- upvalues: Folder (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u15.CamTrans);
    end);
    task.delay(8.933333333333334 - u3, function() -- Line: 401
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy), u14 (copy), VfxManager (ref), Model (copy), u15 (copy), u5 (copy), u26 (copy), Lighting (ref), u24 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u14.Sphere.Transparency = 1;
        u14.Part.Transparency = 1;
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u15.CameraShadeV2, true);
        VfxManager.Enable(u15.VictimLight, false);
        u15.VictimLight:FindFirstChild("C").Color = ColorSequence.new(u5);
        u26.FocusDistance = 15;
        Vignette1.ImageColor3 = u5;
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
        u24.Brightness = 0.65;
        u24.Saturation = -1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u24, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(9.466666666666667 - u3, function() -- Line: 435
        -- upvalues: Folder (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u14.Dribble2);
    end);
    task.delay(10.283333333333333 - u3, function() -- Line: 441
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), u3 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u15.CameraShadeV2, false);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v27 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v27.BackgroundTransparency = 0;
        v27.Parent = ScreenGui;
        UIController:PlayFlipbook(v27, "EmperorEye", 0.03139717425431711, u3);
        ScreenGui:Destroy();
    end);
    task.delay(13.2 - u3, function() -- Line: 459
        -- upvalues: Folder (copy), u14 (copy), u15 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u24 (copy), u5 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u14.Sphere.Transparency = 0.7;
        u14.Part.Transparency = 0.7;
        shared.vfx.emit(u15.Cameravhs.Attachment);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u24.Brightness = 0.65;
        u24.Saturation = -1;
        u24.TintColor = u5;
        TweenService:Create(u24, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u24, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(14 - u3, function() -- Line: 480
        -- upvalues: Folder (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u15.CamTrans);
    end);
    task.delay(14.15 - u3, function() -- Line: 486
        -- upvalues: Folder (copy), Vignette1 (copy), u5 (copy), u14 (copy), u15 (copy), VfxManager (ref), BALL (copy), u16 (copy), Lighting (ref), u25 (copy), Character (copy), Other (copy), Other2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = u5;
        Vignette1.ImageTransparency = 0.5;
        u14.Sphere.Transparency = 0;
        u14.Part.Transparency = 0;
        u14.Sphere.Color = u5;
        u14.Part.Color = u5;
        shared.vfx.emit(u15.Cameravhs.Attachment);
        VfxManager.Enable(u14.Background, true);
        VfxManager.Enable(u15.Speedlines, true);
        VfxManager.Enable(u15.CameraShadeV1, true);
        BALL.Transparency = 1;
        u16.Transparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 4;
        VfxManager.DestroyEffect(BlurEffect, 1.24);
        u25.Intensity = 3;
        u25.Threshold = 1;

        for _, v in { Character, Other, Other2 } do
            if v and v.Parent then
                local Highlight = Instance.new("Highlight");
                Highlight.Parent = Folder;
                Highlight.Adornee = v;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = u5;
                Highlight.FillTransparency = 0;
                Highlight.OutlineTransparency = 0.95;
            end;
        end;
    end);
    local u28 = {};

    local function v29() -- Line: 530
        -- upvalues: u28 (ref), Folder (copy), u23 (copy), u24 (copy), Lighting (ref), ColorCorrection (copy), u25 (copy), Bloom (copy), u26 (copy), DepthOfField (copy)
        for _, v in pairs(u28) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u23 then
            u23:Destroy();
        end;

        if u24 then
            u24:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u25 then
            u25:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u26 then
            u26:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u28 = nil;
    end;

    table.insert(u28, Folder.AttributeChanged:Connect(v29));
    table.insert(u28, Folder.Destroying:Connect(v29));
end;
 
 

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
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.25 - u3, function() -- Line: 37
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Step aside.", 1 }
        });
    end);
    task.delay(2.75 - u3, function() -- Line: 47
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Pathetic.", 1 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 57
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Stay in the air...", 0.75 },
            { u6, "...and realize my superiority.", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 75
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
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
    task.delay(12 - u3, function() -- Line: 97
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12 - u3, function() -- Line: 110
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Emperor Emperor.",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.PrimaryPart, CamRig.camera);
    local u13 = script.Ball:Clone();
    u13.CFrame = BALL.CFrame;
    u13.Parent = Folder;
    Essentials:Weld(u13, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Vignette = u16.Vignette;
    local Vignette1 = u16.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(12, function() -- Line: 163
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u18 = Bloom:Clone();
    u18.Name = "B";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(12 - u3, function() -- Line: 178
        -- upvalues: u18 (copy), Lighting (ref), Bloom (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u19 = DepthOfField:Clone();
    u19.Name = "D";
    u19.Parent = Lighting;
    u19.Enabled = true;
    u19.InFocusRadius = 0;
    u19.NearIntensity = 0;
    task.delay(12, function() -- Line: 195
        -- upvalues: u19 (copy), Lighting (ref), DepthOfField (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 202
        -- upvalues: Folder (copy), u11 (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Sphere.Transparency = 0;
        u11.Part.Transparency = 0;
        u17.Saturation = -1;
    end);
    task.delay(0.4 - u3, function() -- Line: 211
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), VfxManager (ref), Model (copy), u12 (copy), u19 (copy), Vignette1 (copy), Lighting (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u11.Sphere.Transparency = 1;
        u11.Part.Transparency = 1;
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u11.Zone, true);
        VfxManager.Enable(u12.CamShade, true);
        shared.vfx.emit(u11.AuraEmit, u12.CamTrans);
        local specs = u12.CamShade:FindFirstChild("specs");
        specs.TimeScale = 1;
        TweenService:Create(specs, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
        u19.FarIntensity = 0.5;
        u19.FocusDistance = 50;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(103, 8, 8)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(0.8666666666666667 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.1833333333333333 - u3, function() -- Line: 272
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.7666666666666666 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble3);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(2.15 - u3, function() -- Line: 316
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble4);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 69, 69);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(2.933333333333333 - u3, function() -- Line: 338
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.EmperorTrans);
    end);
    task.delay(4.366666666666666 - u3, function() -- Line: 344
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.EmperorTransV2);
    end);
    task.delay(4.433333333333334 - u3, function() -- Line: 350
        -- upvalues: Folder (copy), Vignette1 (copy), u11 (copy), VfxManager (ref), u12 (copy), BALL (copy), u13 (copy), Lighting (ref), u18 (copy), Character (copy), Other (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(103, 8, 8);
        Vignette1.ImageTransparency = 0.5;
        u11.Sphere.Transparency = 0;
        u11.Part.Transparency = 0;
        u11.Sphere.Color = Color3.fromRGB(103, 8, 8);
        u11.Part.Color = Color3.fromRGB(103, 8, 8);
        VfxManager.Enable(u11.Background, true);
        VfxManager.Enable(u12.Speedlines, true);
        VfxManager.Enable(u12.CamShade1, true);
        BALL.Transparency = 1;
        u13.Transparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 4;
        VfxManager.DestroyEffect(BlurEffect, 1.35);
        u18.Intensity = 3;
        u18.Threshold = 1;

        for _, v in { Character, Other } do
            if v and v.Parent then
                local Highlight = Instance.new("Highlight");
                Highlight.Parent = Folder;
                Highlight.Adornee = v;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = Color3.fromRGB(255, 0, 0);
                Highlight.FillTransparency = 0;
                Highlight.OutlineTransparency = 0.95;
                VfxManager.DestroyEffect(Highlight, 1.35);
            end;
        end;
    end);
    task.delay(5.783333333333333 - u3, function() -- Line: 393
        -- upvalues: Folder (copy), Vignette1 (copy), u11 (copy), VfxManager (ref), u12 (copy), BALL (copy), u13 (copy), u18 (copy), Bloom (copy), TweenService (ref), Lighting (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 1;
        u11.Sphere.Transparency = 1;
        u11.Part.Transparency = 1;
        u11.Sphere.Color = Color3.fromRGB(0, 0, 0);
        u11.Part.Color = Color3.fromRGB(0, 0, 0);
        VfxManager.Enable(u11.Background, false);
        VfxManager.Enable(u12.Speedlines, false);
        VfxManager.Enable(u12.CamShade1, false);
        shared.vfx.emit(u11.Jump);
        BALL.Transparency = 0;
        u13.Transparency = 1;
        u18.Intensity = Bloom.Intensity;
        u18.Threshold = Bloom.Threshold;
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
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.3 - u3, function() -- Line: 432
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.CamTrans);
    end);
    task.delay(6.333333333333333 - u3, function() -- Line: 438
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u12.CamShade, true);
        shared.vfx.emit(u11.Dribble5);
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
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.783333333333333 - u3, function() -- Line: 462
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble6);
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
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(7.283333333333333 - u3, function() -- Line: 484
        -- upvalues: Folder (copy), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.GetUpThere);
        u11.Zone.Trail.Lifetime = 1.25;
        u11.Zone.TrailV2.Lifetime = 1.25;
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
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(8.066666666666666 - u3, function() -- Line: 509
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Shot);
        TweenService:Create(u17, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            Brightness = -0.1,
            Saturation = -1
        }):Play();
    end);
    task.delay(10.15 - u3, function() -- Line: 517
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Zone.Trail.Lifetime = 0.35;
        u11.Zone.TrailV2.Lifetime = 0.35;
    end);
    task.delay(11.016666666666667 - u3, function() -- Line: 524
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

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
        u17.Brightness = 0.65;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(255, 69, 69);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        shared.vfx.emit(u11.Score);
    end);
    local u20 = {};

    local function v21() -- Line: 547
        -- upvalues: u20 (ref), Folder (copy), u16 (copy), u17 (copy), Lighting (ref), ColorCorrection (copy), u18 (copy), Bloom (copy), u19 (copy), DepthOfField (copy)
        for _, v in pairs(u20) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;
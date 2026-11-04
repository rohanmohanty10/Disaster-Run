 
 

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
    local u5 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.25 - u3, function() -- Line: 39
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Step aside.", 1 }
        });
    end);
    task.delay(2.75 - u3, function() -- Line: 49
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Pathetic.", 1 }
        });
    end);
    task.delay(6 - u3, function() -- Line: 59
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Stay in the air...", 0.75 },
            { u7, "...and realize my superiority.", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 77
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
    task.delay(12 - u3, function() -- Line: 99
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
    task.delay(12 - u3, function() -- Line: 112
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
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.PrimaryPart, CamRig.camera);
    local u14 = script.Ball:Clone();
    u14.CFrame = BALL.CFrame;
    u14.Parent = Folder;
    Essentials:Weld(u14, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v15 = Character:FindFirstChild(child.Name);

        if v15 then
            local v16 = child:Clone();
            v16.CFrame = v15.CFrame;
            v16.Parent = Model;
            Essentials:Weld(v16, v15);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(12, function() -- Line: 165
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
    task.delay(12 - u3, function() -- Line: 180
        -- upvalues: u19 (copy), Lighting (ref), Bloom (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u20 = DepthOfField:Clone();
    u20.Name = "D";
    u20.Parent = Lighting;
    u20.Enabled = true;
    u20.InFocusRadius = 0;
    u20.NearIntensity = 0;
    task.delay(12, function() -- Line: 197
        -- upvalues: u20 (copy), Lighting (ref), DepthOfField (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 204
        -- upvalues: Folder (copy), u12 (copy), u18 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Sphere.Transparency = 0;
        u12.Part.Transparency = 0;
        u18.Saturation = -1;
    end);
    task.delay(0.4 - u3, function() -- Line: 213
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u12 (copy), VfxManager (ref), Model (copy), u13 (copy), u20 (copy), Vignette1 (copy), u5 (copy), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u12.Sphere.Transparency = 1;
        u12.Part.Transparency = 1;
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u12.Zone, true);
        VfxManager.Enable(u13.CamShade, true);
        shared.vfx.emit(u12.AuraEmit, u13.CamTrans);
        local specs = u13.CamShade:FindFirstChild("specs");
        specs.TimeScale = 1;
        TweenService:Create(specs, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            TimeScale = 0.1
        }):Play();
        u20.FarIntensity = 0.5;
        u20.FocusDistance = 50;
        Vignette1.ImageColor3 = u5;
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(0.8666666666666667 - u3, function() -- Line: 252
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Dribble1);
        Vignette1.ImageColor3 = u5;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.1833333333333333 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Dribble2);
        Vignette1.ImageColor3 = u5;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(1.7666666666666666 - u3, function() -- Line: 296
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Dribble3);
        Vignette1.ImageColor3 = u5;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(2.15 - u3, function() -- Line: 318
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Dribble4);
        Vignette1.ImageColor3 = u5;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(2.933333333333333 - u3, function() -- Line: 340
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.EmperorTrans);
    end);
    task.delay(4.366666666666666 - u3, function() -- Line: 346
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.EmperorTransV2);
    end);
    task.delay(4.433333333333334 - u3, function() -- Line: 352
        -- upvalues: Folder (copy), Vignette1 (copy), u5 (copy), u12 (copy), VfxManager (ref), u13 (copy), BALL (copy), u14 (copy), Lighting (ref), u19 (copy), Character (copy), Other (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = u5;
        Vignette1.ImageTransparency = 0.5;
        u12.Sphere.Transparency = 0;
        u12.Part.Transparency = 0;
        u12.Sphere.Color = u5;
        u12.Part.Color = u5;
        VfxManager.Enable(u12.Background, true);
        VfxManager.Enable(u13.Speedlines, true);
        VfxManager.Enable(u13.CamShade1, true);
        BALL.Transparency = 1;
        u14.Transparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 4;
        VfxManager.DestroyEffect(BlurEffect, 1.35);
        u19.Intensity = 3;
        u19.Threshold = 1;

        for _, v in { Character, Other } do
            if v and v.Parent then
                local Highlight = Instance.new("Highlight");
                Highlight.Parent = Folder;
                Highlight.Adornee = v;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight.OutlineColor = u5;
                Highlight.FillTransparency = 0;
                Highlight.OutlineTransparency = 0.95;
                VfxManager.DestroyEffect(Highlight, 1.35);
            end;
        end;
    end);
    task.delay(5.783333333333333 - u3, function() -- Line: 395
        -- upvalues: Folder (copy), Vignette1 (copy), u12 (copy), VfxManager (ref), u13 (copy), BALL (copy), u14 (copy), u19 (copy), Bloom (copy), u5 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 1;
        u12.Sphere.Transparency = 1;
        u12.Part.Transparency = 1;
        u12.Sphere.Color = Color3.fromRGB(0, 0, 0);
        u12.Part.Color = Color3.fromRGB(0, 0, 0);
        VfxManager.Enable(u12.Background, false);
        VfxManager.Enable(u13.Speedlines, false);
        VfxManager.Enable(u13.CamShade1, false);
        shared.vfx.emit(u12.Jump);
        BALL.Transparency = 0;
        u14.Transparency = 1;
        u19.Intensity = Bloom.Intensity;
        u19.Threshold = Bloom.Threshold;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.3 - u3, function() -- Line: 434
        -- upvalues: Folder (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u13.CamTrans);
    end);
    task.delay(6.333333333333333 - u3, function() -- Line: 440
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u13.CamShade, true);
        shared.vfx.emit(u12.Dribble5);
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(6.783333333333333 - u3, function() -- Line: 464
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Dribble6);
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(7.283333333333333 - u3, function() -- Line: 486
        -- upvalues: Folder (copy), u12 (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.GetUpThere);
        u12.Zone.Trail.Lifetime = 1.25;
        u12.Zone.TrailV2.Lifetime = 1.25;
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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(8.066666666666666 - u3, function() -- Line: 511
        -- upvalues: Folder (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12.Shot);
    end);
    task.delay(10.15 - u3, function() -- Line: 517
        -- upvalues: Folder (copy), u12 (copy), TweenService (ref), u18 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u12.Zone.Trail.Lifetime = 0.35;
        u12.Zone.TrailV2.Lifetime = 0.35;
        TweenService:Create(u18, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            Brightness = -0.1,
            Saturation = -1
        }):Play();
    end);
    task.delay(11.016666666666667 - u3, function() -- Line: 526
        -- upvalues: Folder (copy), Vignette1 (copy), u5 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u18 (copy), ColorCorrection (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

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
        u18.Brightness = 0.65;
        u18.Saturation = -1;
        u18.TintColor = u5;
        TweenService:Create(u18, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        shared.vfx.emit(u12.Score);
    end);
    local u21 = {};

    local function v22() -- Line: 549
        -- upvalues: u21 (ref), Folder (copy), u17 (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), Bloom (copy), u20 (copy), DepthOfField (copy)
        for _, v in pairs(u21) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
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

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u21 = nil;
    end;

    table.insert(u21, Folder.AttributeChanged:Connect(v22));
    table.insert(u21, Folder.Destroying:Connect(v22));
end;
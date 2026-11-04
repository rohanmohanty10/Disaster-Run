 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v7 = Character:FindFirstChild("Right Arm");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy), u3 (copy)
        Effects:SubtitleV2({
            { u6, "Watch closely...", 2 }
        });
        task.wait(8.25 - u3);
        Effects:SubtitleV2({
            { u6, "I\'m not finished with you!", 2 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 61
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
    task.delay(12 - u3, function() -- Line: 83
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
    task.delay(12, function() -- Line: 96
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Dealer Final Cut",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Ball:Clone();
    u13.Parent = Folder;
    u13.CFrame = BALL.CFrame;
    Essentials:Weld(u13, BALL);
    local Bungee1 = u13.Bungee1;
    Bungee1.Parent = v7;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local Vignette1 = u14.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(12, function() -- Line: 133
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u16 = Bloom:Clone();
    u16.Name = "B";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(12 - u3, function() -- Line: 148
        -- upvalues: u16 (copy), Lighting (ref), Bloom (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u17 = DepthOfField:Clone();
    u17.Name = "D";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(12, function() -- Line: 163
        -- upvalues: u17 (copy), Lighting (ref), DepthOfField (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.23333333333333334 - u3, function() -- Line: 170
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce1);
        VfxManager.Enable(u13, true);
        VfxManager.Enable(u13.Bungee2, false);
    end);
    task.delay(0.65 - u3, function() -- Line: 178
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce2);
    end);
    task.delay(0.6833333333333333 - u3, function() -- Line: 184
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.CamTrans);
            VfxManager.Enable(CamRig.camera.CamTrans, true);
        end;
    end);
    task.delay(0.8833333333333333 - u3, function() -- Line: 193
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.CamTrans);
            VfxManager.Enable(CamRig.camera.CamTrans, false);
        end;
    end);
    task.delay(1.0166666666666666 - u3, function() -- Line: 202
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), u13 (copy), CamRig (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u16 (copy), Bloom (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Bounce3);
        VfxManager.Enable(u13, true);
        VfxManager.Enable(u12.Air, true);
        VfxManager.Enable(u12.Beams, true);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, true);
            VfxManager.Enable(CamRig.camera.CamTrans, false);
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u16.Intensity = 20;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        local v18 = script.FakeAtmo:Clone();
        v18.Parent = Lighting;
        local Brightness = Lighting.Brightness;
        local Ambient = Lighting.Ambient;
        local OutdoorAmbient = Lighting.OutdoorAmbient;
        Lighting.Brightness = 2;
        Lighting.Ambient = Color3.fromRGB(184, 47, 227);
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0);
        task.wait(10.016666666666667);
        v18:Destroy();

        if Lighting.Brightness == 2 then
            Lighting.Brightness = Brightness;
        end;

        if Lighting.Ambient == Color3.fromRGB(184, 47, 227) then
            Lighting.Ambient = Ambient;
        end;

        if Lighting.OutdoorAmbient == Color3.fromRGB(0, 0, 0) then
            Lighting.OutdoorAmbient = OutdoorAmbient;
        end;
    end);
    task.delay(2.216666666666667 - u3, function() -- Line: 261
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        TweenService:Create(Vignette1, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.3333333333333333);
        TweenService:Create(Vignette1, TweenInfo.new(1), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(4.166666666666667 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        u15.Brightness = 0.45;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(5.6 - u3, function() -- Line: 293
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), Lighting (ref), VfxManager (ref), u15 (copy), u17 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        TweenService:Create(u15, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Saturation = -1
        }):Play();
        TweenService:Create(u17, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(7.916666666666667 - u3, function() -- Line: 310
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Name = script.Parent.Name .. "Blur";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
    end);
    task.delay(9.5 - u3, function() -- Line: 319
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u17 (copy), DepthOfField (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local v19 = Lighting:FindFirstChild(script.Parent.Name .. "Blur");
        v19.Size = 35;
        TweenService:Create(v19, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v19, 0.455);
        TweenService:Create(u17, TweenInfo.new(0.6, Enum.EasingStyle.Sine), {
            FarIntensity = DepthOfField.FarIntensity,
            FocusDistance = DepthOfField.FocusDistance
        }):Play();
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(10.6 - u3, function() -- Line: 340
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        TweenService:Create(Vignette1, TweenInfo.new(0.3333333333333333, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5
        }):Play();
        task.wait(0.3333333333333333);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(11.033333333333333 - u3, function() -- Line: 353
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u16 (copy), Bloom (copy), u15 (copy), ColorCorrection (copy), u12 (copy), u13 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(184, 47, 227);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u16.Intensity = 20;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u15.Brightness = 1;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        VfxManager.Emit(u12.Score);
        VfxManager.Enable(u13, false);
        VfxManager.Enable(u12.Air, false);
        VfxManager.Enable(u12.Beams, false);

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera, false);
        end;
    end);
    local u20 = {};

    local function v21() -- Line: 387
        -- upvalues: u20 (ref), Folder (copy), Bungee1 (copy), u14 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy), u16 (copy), Bloom (copy), u17 (copy), DepthOfField (copy)
        for _, v in pairs(u20) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if Bungee1 then
            Bungee1:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;
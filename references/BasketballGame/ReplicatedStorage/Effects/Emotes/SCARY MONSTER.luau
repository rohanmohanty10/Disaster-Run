 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 41
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u3;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(6.35 - u3, function() -- Line: 63
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(6.35 - u3, function() -- Line: 72
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u10 = script.Cutscene_VFX:Clone();
    u10.Name = v4;
    u10.Parent = Folder;
    u10:PivotTo(HumanoidRootPart.CFrame);
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.PrimaryPart, CamRig.camera);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v12 = Character:FindFirstChild(child.Name);

        if v12 then
            local v13 = child:Clone();
            v13.CFrame = v12.CFrame;
            v13.Parent = Model;
            Essentials:Weld(v13, v12);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local _ = u14.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    u15.Contrast = 1;
    u15.Brightness = 0.15;
    task.delay(6.35, function() -- Line: 120
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Ambient = Lighting.Ambient;
    Lighting.Ambient = Color3.fromRGB(42, 35, 135);
    task.spawn(function() -- Line: 130
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u14 (copy), Lighting (ref), VfxManager (ref), Model (copy), u10 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        u14.Vignette2.ImageColor3 = Color3.fromRGB(102, 1, 1);
        u14.Vignette2.ImageTransparency = 0.5;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u10.BackgroundAura, true);
        VfxManager.Enable(u10.SmokeAura, true);
        VfxManager.Enable(u11.CamShade, true);
    end);
    task.delay(1.3333333333333333 - u3, function() -- Line: 150
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy), TweenService (ref), u15 (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u10.BackgroundAura, false);
        VfxManager.Enable(u10.SmokeAura, false);
        VfxManager.Enable(u11.CamShade, false);
        local Start = u10.Distortion.Start;
        Start.Material = Enum.Material.Glass;
        shared.vfx.emit(u10.Distortion);
        task.delay(1, function() -- Line: 162
            -- upvalues: Start (copy)
            Start.Material = Enum.Material.Neon;
        end);
        task.spawn(function() -- Line: 166
            -- upvalues: TweenService (ref), u15 (ref), u14 (ref), ColorCorrection (ref)
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(120, 255, 57)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(255, 234, 3)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(32, 54, 255)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(255, 39, 39)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(78, 42, 255)
            }):Play();
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(120, 255, 57)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u15, TweenInfo.new(0.05), {
                TintColor = Color3.fromRGB(255, 234, 3)
            }):Play();
            task.wait(0.05);
            TweenService:Create(u14.Vignette2, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ImageTransparency = 0,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            TweenService:Create(u15, TweenInfo.new(0.655), {
                Saturation = -1,
                TintColor = Color3.fromRGB(255, 255, 255),
                Contrast = ColorCorrection.Contrast
            }):Play();
        end);
    end);
    task.delay(2.2666666666666666 - u3, function() -- Line: 185
        -- upvalues: Folder (copy), TweenService (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u10.Sphere, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.6
        }):Play();
        TweenService:Create(u10.Part, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 0.6
        }):Play();
    end);
    task.delay(2.716666666666667 - u3, function() -- Line: 192
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.GlitchCam, true);
    end);
    task.delay(3.75 - u3, function() -- Line: 198
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u14 (copy), u10 (copy), VfxManager (ref), u11 (copy), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play();
        TweenService:Create(u14.Vignette2, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        u10.Sphere.Transparency = 1;
        u10.Part.Transparency = 1;
        VfxManager.Enable(u11.GlitchCam, false);
        u15.Saturation = ColorCorrection.Saturation;
    end);
    task.delay(4.566666666666666 - u3, function() -- Line: 213
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.CamShade, true);
        shared.vfx.emit(u11.CamTrans);
    end);
    local u16 = {};

    local function v17() -- Line: 222
        -- upvalues: u16 (ref), Folder (copy), u14 (copy), Lighting (ref), Ambient (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if Lighting.Ambient == Color3.fromRGB(42, 35, 135) then
            Lighting.Ambient = Ambient;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), Part_Icles (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local Other = p2.Other;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(1.5 - PassedTime, function() -- Line: 36
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "I just took that move from you recently.", 1.5 },
            { u5, "It\'s not yours anymore.", 2 }
        });
    end);
    task.delay(9.5 - PassedTime, function() -- Line: 51
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\" timeBetweenStep=\"0.1\">It\'s mine.</animation>", 2 }
        });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 64
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * PassedTime;
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
    task.delay(12.817 - PassedTime, function() -- Line: 86
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.817 - PassedTime, function() -- Line: 99
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Thief It\'s Mine",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local u12;

    if Head then
        u12 = script.Head:Clone();
        u12.CFrame = Head.CFrame;
        u12.Parent = Folder;
        Essentials:Weld(u12, Head);
    else
        u12 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local Vignette = u13.Vignette;
    local Vignette1 = u13.Vignette1;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local Highlight2 = Instance.new("Highlight", Other);
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight2.OutlineTransparency = 0;
    Highlight2.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(12.817, function() -- Line: 155
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 162
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.Ring);
    end);
    task.delay(0.016666666666666666 - PassedTime, function() -- Line: 168
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.AirTime);
    end);
    task.delay(0.25 - PassedTime, function() -- Line: 174
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.LightDash1);
    end);
    task.delay(0.95 - PassedTime, function() -- Line: 180
        -- upvalues: Folder (copy), Lighting (ref), VfxManager (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        VfxManager.DestroyEffect(BlurEffect, 1.6);
        TweenService:Create(BlurEffect, TweenInfo.new(0.05), {
            Size = 50
        }):Play();
        task.wait(0.05);
        TweenService:Create(BlurEffect, TweenInfo.new(0.9), {
            Size = 4
        }):Play();
        task.wait(0.9);
        TweenService:Create(BlurEffect, TweenInfo.new(0.2), {
            Size = 30
        }):Play();
        task.wait(0.2);
        TweenService:Create(BlurEffect, TweenInfo.new(0.45), {
            Size = 0
        }):Play();
    end);
    task.delay(0.9833333333333333 - PassedTime, function() -- Line: 201
        -- upvalues: Folder (copy), TweenService (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u10.Spotlight.SurfaceLight, TweenInfo.new(0.16666666666666666), {
            Color = Color3.fromRGB(255, 34, 34)
        }):Play();
    end);
    task.delay(1.1166666666666667 - PassedTime, function() -- Line: 207
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 1;
        TweenService:Create(Vignette, TweenInfo.new(0.1), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(1.7 - PassedTime, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), TweenService (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CamLines1);
        TweenService:Create(u10.Spotlight.SurfaceLight, TweenInfo.new(0.6666666666666666), {
            Color = Color3.fromRGB(38, 123, 255)
        }):Play();
    end);
    task.delay(1.75 - PassedTime, function() -- Line: 223
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.LightDash2);
    end);
    task.delay(1.8 - PassedTime, function() -- Line: 229
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy), Vignette1 (copy), Vignette (copy), u14 (copy), Highlight (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.End);
        u10.Black.Transparency = 0;
        u10.Ground.Transparency = 0;
        Vignette1.ImageTransparency = 0;
        Vignette.ImageTransparency = 0;
        u14.Brightness = -0.15;
        u14.Saturation = -1;
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(0.6666666666666666), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(1.8333333333333333 - PassedTime, function() -- Line: 244
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(2.4), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(1.9833333333333334 - PassedTime, function() -- Line: 250
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Emit);
    end);
    task.delay(2.183333333333333 - PassedTime, function() -- Line: 256
        -- upvalues: Folder (copy), Part_Icles (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u10.Swish);
    end);
    task.delay(3.55 - PassedTime, function() -- Line: 262
        -- upvalues: Folder (copy), TweenService (ref), u14 (copy), ColorCorrection (copy), Highlight (copy), Highlight2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u14, TweenInfo.new(1.9), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1.9), {
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Highlight2, TweenInfo.new(1.9), {
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(3.55 - PassedTime, function() -- Line: 270
        -- upvalues: Folder (copy), u12 (ref), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u12 then
            Part_Icles:AbsoluteEmit(u12);
        end;
    end);
    task.delay(5.9 - PassedTime, function() -- Line: 278
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CamLines2);
        Vignette1.ImageColor3 = Color3.fromRGB(38, 123, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 30;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(38, 123, 255);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(5.95 - PassedTime, function() -- Line: 300
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Hit);
    end);
    task.delay(7.7 - PassedTime, function() -- Line: 306
        -- upvalues: Folder (copy), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u10.Black.Transparency = 1;
        u10.Ground.Transparency = 1;
    end);
    task.delay(10.266666666666667 - PassedTime, function() -- Line: 313
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble1);
        Part_Icles:AbsoluteEmit(u10.DribbleMeshFlip1);
    end);
    task.delay(10.916666666666666 - PassedTime, function() -- Line: 320
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble2);
        Part_Icles:AbsoluteEmit(u10.DribbleMeshFlip2);
    end);
    task.delay(11.9 - PassedTime, function() -- Line: 327
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble3);
        Part_Icles:AbsoluteEmit(u10.DribbleMeshFlip3);
    end);
    local u15 = {};

    local function v16() -- Line: 335
        -- upvalues: u15 (ref), Folder (copy), u13 (copy), Highlight (copy), Highlight2 (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;
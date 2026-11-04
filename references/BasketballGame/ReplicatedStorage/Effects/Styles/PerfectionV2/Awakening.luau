 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
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

    local u6 = Players:FindFirstChild(Character.Name) or Character.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(1 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "You actually thought you stood a chance?", 2 }
        });
    end);
    task.delay(5 - u3, function() -- Line: 45
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Pathetic.", 1 }
        });
    end);
    task.delay(8.5 - u3, function() -- Line: 55
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Allow me to show you what perfection truly looks like.", 3 }
        });
    end);
    task.delay(13.5 - u3, function() -- Line: 65
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I\'ll put it simply.", 1 },
            { u6, "You\'re either perfect...", 1 },
            { u6, "...or you\'re not me.", 1 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 88
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
    task.delay(24 - u3, function() -- Line: 110
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
    task.delay(24 - u3, function() -- Line: 123
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Perfection V2 Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
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

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    if Other then
        for _, child in pairs(script.Sweat:GetChildren()) do
            local v14 = Other:FindFirstChild(child.Name);

            if v14 then
                local v15 = child:Clone();
                v15.CFrame = v14.CFrame;
                v15.Parent = Model2;
                Essentials:Weld(v15, v14);
            end;
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Vignette = u16.Vignette;
    local _ = u16.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(24, function() -- Line: 188
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 195
        -- upvalues: Folder (copy), Vignette (copy), Model (copy), u11 (copy), Model2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        shared.vfx.emit(Model, u11.REA, u11.SideDust, Model2:FindFirstChild("Head").FAKEE, Model2:FindFirstChild("Head").FAKE3, Model2:FindFirstChild("Head").FAKE, Model2:FindFirstChild("Head").REAL, Model2:FindFirstChild("Head").REALL, Model2:FindFirstChild("Head").REAL2);
    end);
    task.delay(2.466666666666667 - u3, function() -- Line: 204
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(3.4833333333333334 - u3, function() -- Line: 210
        -- upvalues: Folder (copy), u11 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Thunder1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 5;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u17.Brightness = 0.45;
        u17.TintColor = Color3.fromRGB(121, 215, 255);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(4.9 - u3, function() -- Line: 227
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 5;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u17.Brightness = 0.45;
        u17.TintColor = Color3.fromRGB(121, 215, 255);
        TweenService:Create(u17, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
        shared.vfx.emit(u11.Thunder2);
    end);
    task.delay(5.533333333333333 - u3, function() -- Line: 244
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Wind);
    end);
    task.delay(8.383333333333333 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Startup);
    end);
    task.delay(8.616666666666667 - u3, function() -- Line: 256
        -- upvalues: Folder (copy), u11 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Boom1);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u17.Brightness = 1;
        u17.Saturation = -1;
        u17.TintColor = Color3.fromRGB(72, 255, 69);
        TweenService:Create(u17, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u17, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(8.633333333333333 - u3, function() -- Line: 274
        -- upvalues: Folder (copy), u11 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.ScreenEffect, u11.CameraFX);

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera.REA, CamRig.Camera.SpeedLines);
        end;
    end);
    task.delay(10.516666666666667 - u3, function() -- Line: 283
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.CameraZoom, u11.CameraFX, u11.Land);
    end);
    task.delay(13.783333333333333 - u3, function() -- Line: 289
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.05);
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(14.483333333333333 - u3, function() -- Line: 297
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Teleport1);
    end);
    task.delay(14.616666666666667 - u3, function() -- Line: 303
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.13333333333333333), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.13333333333333333);
        TweenService:Create(Vignette, TweenInfo.new(0.13333333333333333), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(14.683333333333334 - u3, function() -- Line: 311
        -- upvalues: Folder (copy), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        task.wait(0.016666666666666666);
    end);
    task.delay(14.733333333333333 - u3, function() -- Line: 336
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Teleport2);
    end);
    task.delay(16.083333333333332 - u3, function() -- Line: 342
        -- upvalues: Folder (copy), u11 (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Lines, Model:FindFirstChild("Torso").Attachment.kI2);
    end);
    task.delay(18.833333333333332 - u3, function() -- Line: 348
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        TweenService:Create(Vignette, TweenInfo.new(0.1), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.1);
        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(18.983333333333334 - u3, function() -- Line: 357
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.08333333333333333), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.08333333333333333);
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(19.733333333333334 - u3, function() -- Line: 365
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.1), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.1);
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(19.8 - u3, function() -- Line: 373
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Boom2);
    end);
    task.delay(20.233333333333334 - u3, function() -- Line: 379
        -- upvalues: Folder (copy), u11 (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Boom3);
        TweenService:Create(Vignette, TweenInfo.new(0.016666666666666666), {
            BackgroundTransparency = 0.2
        }):Play();
        task.wait(0.016666666666666666);
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(20.783333333333335 - u3, function() -- Line: 390
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Boom4);
    end);
    task.delay(21.1 - u3, function() -- Line: 396
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 0.5
        }):Play();
        task.wait(0.03333333333333333);
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(21.5 - u3, function() -- Line: 404
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Teleport3);
    end);
    task.delay(22.566666666666666 - u3, function() -- Line: 410
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(22.75 - u3, function() -- Line: 416
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1.25), {
            BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    local u18 = {};

    local function v19() -- Line: 423
        -- upvalues: u18 (ref), Folder (copy), u16 (copy), Highlight (copy), u17 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u16 then
            u16:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u17 then
            u17:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;
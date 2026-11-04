 
 

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
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(3.25 - u3, function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Witness the definition of perfection.", 3 }
        });
    end);
    task.delay(14.5 - u3, function() -- Line: 45
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Sit down!", 1 }
        });
    end);
    task.delay(19.5 - u3, function() -- Line: 55
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Heh. This is too easy.", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 68
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
    task.delay(24 - u3, function() -- Line: 90
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
    task.delay(24 - u3, function() -- Line: 103
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Perfection V2 Perfect Self Alley",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Ball:Clone();
    u12.Parent = Folder;
    u12:PivotTo(BALL.CFrame);
    Essentials:Weld(u12, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v13 = Character:FindFirstChild(child.Name);

        if v13 then
            local v14 = child:Clone();
            v14.CFrame = v13.CFrame;
            v14.Parent = Model;
            Essentials:Weld(v14, v13);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local Vignette = u15.Vignette;
    local _ = u15.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local u16;

    if Other then
        u16 = Instance.new("Highlight", Other);
        u16.DepthMode = Enum.HighlightDepthMode.Occluded;
        u16.FillColor = Color3.fromRGB(0, 0, 0);
        u16.OutlineColor = Color3.fromRGB(0, 0, 0);
        u16.OutlineTransparency = 0;
        u16.FillTransparency = 1;
    else
        u16 = nil;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u17 = ColorCorrection:Clone();
    u17.Name = "CC";
    u17.Parent = Lighting;
    u17.Enabled = true;
    task.delay(24, function() -- Line: 168
        -- upvalues: u17 (copy), Lighting (ref), ColorCorrection (copy)
        u17:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 175
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), u11 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(1.5), {
            BackgroundTransparency = 1
        }):Play();
        shared.vfx.emit(u11.CameraFX1, u11.CameraFX2);

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera.fake, CamRig.Camera.fake2, CamRig.Camera.fake3, CamRig.Camera.REAL, CamRig.Camera.REALL, CamRig.Camera.REAL2);
        end;
    end);
    task.delay(0.7666666666666667 - u3, function() -- Line: 188
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(1.35 - u3, function() -- Line: 194
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(2 - u3, function() -- Line: 200
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(2.566666666666667 - u3, function() -- Line: 206
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(3.15 - u3, function() -- Line: 212
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(3.716666666666667 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(4.333333333333333 - u3, function() -- Line: 224
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(4.9 - u3, function() -- Line: 230
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(5.333333333333333 - u3, function() -- Line: 236
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble1);
    end);
    task.delay(5.766666666666667 - u3, function() -- Line: 242
        -- upvalues: Folder (copy), CamRig (copy), Highlight (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera["11"]["1"], CamRig.Camera["11"]["2"]);
        end;

        Highlight.OutlineColor = Color3.fromRGB(72, 255, 69);
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(1.5), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(5.9 - u3, function() -- Line: 254
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dribble2);
    end);
    task.delay(7.35 - u3, function() -- Line: 260
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Teleport1);
    end);
    task.delay(7.366666666666666 - u3, function() -- Line: 266
        -- upvalues: Folder (copy), u17 (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u17.Saturation = -1;
        Vignette.BackgroundColor3 = Color3.fromRGB(75, 255, 0);
        TweenService:Create(Vignette, TweenInfo.new(0.08333333333333333), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.08333333333333333);
        Vignette.BackgroundColor3 = Color3.fromRGB(204, 41, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(75, 255, 0);
        Vignette.BackgroundTransparency = 1;
        task.wait(0.03333333333333333);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundColor3 = Color3.fromRGB(204, 41, 255)
        }):Play();
        task.wait(0.05);
        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(75, 255, 0)
        }):Play();
    end);
    task.delay(8.45 - u3, function() -- Line: 285
        -- upvalues: Folder (copy), u17 (copy), ColorCorrection (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u17.Saturation = ColorCorrection.Saturation;
        Vignette.BackgroundColor3 = Color3.fromRGB(75, 255, 0);
        TweenService:Create(Vignette, TweenInfo.new(0.08333333333333333), {
            BackgroundTransparency = 0
        }):Play();
        task.wait(0.08333333333333333);
        Vignette.BackgroundColor3 = Color3.fromRGB(204, 41, 255);
        task.wait(0.016666666666666666);
        Vignette.BackgroundColor3 = Color3.fromRGB(75, 255, 0);
        Vignette.BackgroundTransparency = 1;
        task.wait(0.03333333333333333);
        Vignette.BackgroundTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.05), {
            BackgroundColor3 = Color3.fromRGB(204, 41, 255)
        }):Play();
        task.wait(0.05);
        TweenService:Create(Vignette, TweenInfo.new(0.03333333333333333), {
            BackgroundTransparency = 1,
            BackgroundColor3 = Color3.fromRGB(75, 255, 0)
        }):Play();
    end);
    task.delay(9.183333333333334 - u3, function() -- Line: 304
        -- upvalues: Folder (copy), u11 (copy), CamRig (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Teleport2);

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera.Object1, CamRig.Camera.Object2, CamRig.Camera.Object3, CamRig.Camera.Object4, CamRig.Camera.Object5, CamRig.Camera.Object7, CamRig.Camera.Object8, CamRig.Camera.Object9, CamRig.Camera.Object10, CamRig.Camera.Object11, CamRig.Camera.Object12, CamRig.Camera.Object13, CamRig.Camera.Object14, CamRig.Camera.Object15);
        end;
    end);
    task.delay(8.883333333333333 - u3, function() -- Line: 313
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.d1);
    end);
    task.delay(9.15 - u3, function() -- Line: 319
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.d2);
    end);
    task.delay(9.466666666666667 - u3, function() -- Line: 325
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.d3);
    end);
    task.delay(9.716666666666667 - u3, function() -- Line: 331
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.d4);
    end);
    task.delay(9.9 - u3, function() -- Line: 337
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.d5);
    end);
    task.delay(10.483333333333333 - u3, function() -- Line: 343
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.ScreenEffect);
    end);
    task.delay(10.516666666666667 - u3, function() -- Line: 349
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Boom);
    end);
    task.delay(12.15 - u3, function() -- Line: 355
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(Model, true);
    end);
    task.delay(12.4 - u3, function() -- Line: 361
        -- upvalues: Folder (copy), u12 (copy), CamRig (copy), Highlight (copy), TweenService (ref), u16 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u12);

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera["11"]["1"], CamRig.Camera["11"]["2"]);
        end;

        Highlight.OutlineColor = Color3.fromRGB(72, 255, 69);
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(0.5), {
            FillTransparency = 0.25
        }):Play();

        if u16 then
            u16.OutlineColor = Color3.fromRGB(255, 255, 255);
            u16.FillTransparency = 0;
            TweenService:Create(u16, TweenInfo.new(0.5), {
                FillTransparency = 0.25
            }):Play();
        end;
    end);
    task.delay(13.8 - u3, function() -- Line: 380
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u16 (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.25), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();

        if u16 then
            TweenService:Create(u16, TweenInfo.new(0.25), {
                FillTransparency = 1,
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
        end;
    end);
    task.delay(14.216666666666667 - u3, function() -- Line: 390
        -- upvalues: Folder (copy), Model (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(Model);
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
    task.delay(14.8 - u3, function() -- Line: 408
        -- upvalues: Folder (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.ScreenEffect);
    end);
    task.delay(15.25 - u3, function() -- Line: 414
        -- upvalues: Folder (copy), u11 (copy), CamRig (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u17 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        shared.vfx.emit(u11.Dunk);

        if CamRig and CamRig:FindFirstChild("Camera") then
            shared.vfx.emit(CamRig.Camera.DunkCameraSparks);
        end;

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
    local u18 = {};

    local function v19() -- Line: 436
        -- upvalues: u18 (ref), Folder (copy), u15 (copy), Highlight (copy), u16 (ref), u17 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
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

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;
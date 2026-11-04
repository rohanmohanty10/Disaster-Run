 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 19
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v4 = p2.passedTime or 0;
    local u5 = workspace:GetServerTimeNow() - p2.TimeSent + v4;
    local v6 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        if p2.Task == "Cleanup" then
            local v7 = Debris:FindFirstChild(v6);

            if v7 then
                v7:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "ChaosTurnOff" then
            local v8 = Char:FindFirstChild(v6 .. "Chaos");

            if v8 then
                v8:SetAttribute("Active", nil);
            end;

            while workspace.Debris:FindFirstChild((`{Char.Name}ChaosAura`)) do
                workspace.Debris:FindFirstChild((`{Char.Name}ChaosAura`)):Destroy();
            end;
        end;

        return;
    end;

    Effects:SubtitleV2({
        { u3, "Haaaaaah...", 1 }
    });
    task.delay(3.5, function() -- Line: 43
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "I dedicate this requiem...", 1.8 }
        });
    end);
    task.delay(7.2, function() -- Line: 53
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "<font color=\"#000000\"><animation style=\"glitch\">...to you.</animation></font>",
                1.2,
                0,
                Color3.new(1, 1, 1)
            }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 68
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u5;
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
    task.delay(11.45 - u5, function() -- Line: 87
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local ClockTime = game_Lighting.ClockTime;
    local u13 = script.ImpactFrameDark:Clone();
    u13.Parent = game_Lighting;
    local u14 = {};
    local u15 = nil;
    local u16 = nil;
    local u17 = {};

    for _, child in Char:GetChildren() do
        if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
            table.insert(u14, { "Part", child, child.Color });
        elseif child:IsA("Shirt") or child:IsA("Pants") then
            table.insert(u14, { "Clothes", child, child.Color3 });
        end;
    end;

    local Head = Char:FindFirstChild("Head");

    for _, descendant in Head:GetDescendants() do
        if descendant:IsA("Decal") then
            table.insert(u14, { "Decal", descendant, descendant.Transparency });
        end;
    end;

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    local Folder2 = Instance.new("Folder");
    Folder2.Name = v6 .. "Chaos";
    Folder2.Parent = Char;
    Folder2:SetAttribute("Active", true);
    task.delay(11.45, function() -- Line: 156
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u18 = SfxManager:playSound({
        Sound = "BBZ Chrollos Requiem",
        Parent = workspace
    });
    local u19 = script.Camera_VFX:Clone();
    u19:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u19.Parent = Folder;
    u19.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u19.PrimaryPart, CamRig.camera);
    local u20 = script.Vignette:Clone();
    u20.Parent = PlayerGui;
    u20.Enabled = true;
    local Vignette = u20.Vignette;
    local Vignette1 = u20.Vignette1;
    local SolidColor = u20.SolidColor;
    local _ = u20.CurrentBannerSolid;
    local CurrentBanner = u20.CurrentBanner;
    local Model = Instance.new("Model");
    Model.Parent = Folder2;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;

        if p2.AltChar and p2.AltChar:FindFirstChild(child.Name) then
            local v22 = child:Clone();
            v22.Name = `{Char.Name}ChaosAura`;
            v22.CFrame = p2.AltChar:FindFirstChild(child.Name).CFrame;
            v22.Parent = workspace.Debris;
            Essentials:Weld(v22, p2.AltChar:FindFirstChild(child.Name));
            VfxManager.Enable(v22, true);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder2;

    for _, child in script.LimbAura:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v23 = child:Clone();
            v23.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v23.Parent = Model2;
            Essentials:Weld(v23, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v23, false);
        end;

        if p2.AltChar and p2.AltChar:FindFirstChild(child.Name) then
            local v24 = child:Clone();
            v24.Name = `{Char.Name}ChaosAura`;
            v24.CFrame = p2.AltChar:FindFirstChild(child.Name).CFrame;
            v24.Parent = workspace.Debris;
            Essentials:Weld(v24, p2.AltChar:FindFirstChild(child.Name));
            VfxManager.Enable(v24, true);
        end;
    end;

    if p2.AltChar then
        local v25 = script.HeadAura:Clone();
        v25.Name = `{Char.Name}ChaosAura`;
        v25.CFrame = p2.AltChar.Head.CFrame;
        v25.Parent = workspace.Debris;
        Essentials:Weld(v25, p2.AltChar.Head);
        VfxManager.Enable(v25, true);
    end;

    local u26 = script.HeadAura:Clone();
    u26.CFrame = Head.CFrame;
    u26.Parent = Folder2;
    Essentials:Weld(u26, Head);
    VfxManager.Enable(u26, false);
    local u27 = script.HeadBreathing:Clone();
    u27.CFrame = Head.CFrame;
    u27.Parent = Folder;
    Essentials:Weld(u27, Head);
    VfxManager.Enable(u27, false);
    local u28 = script.Cutscene_VFX:Clone();
    u28:PivotTo(HumanoidRootPart.CFrame);
    u28.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    TweenService:Create(CurrentBanner, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
        ImageTransparency = 0.85
    }):Play();
    task.delay(0.255, function() -- Line: 262
        -- upvalues: Folder (copy), TweenService (ref), CurrentBanner (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(CurrentBanner, TweenInfo.new(0.555, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    SolidColor.ImageTransparency = 0;
    TweenService:Create(SolidColor, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        ImageTransparency = 1
    }):Play();
    Vignette.ImageTransparency = 1;
    Vignette1.ImageTransparency = 1;
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    u28.Sphere.Transparency = 0;
    ColorCorrection.Contrast = 0.75;
    ColorCorrection.Saturation = -0.5;
    VfxManager.Enable(u28.RunSpecs2, true);
    task.delay(0.667 - u5, function() -- Line: 282
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u28 (copy), Highlight (copy), Vignette (copy), Vignette1 (copy), u15 (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.655);
        VfxManager.Enable(u28.AuraFOrBeginning, true);
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u28.Sphere, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FillTransparency = 1
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.655, Enum.EasingStyle.Circular), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Circular), {
            ImageTransparency = 0
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 1;
        u15 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u15:Play();
        VfxManager.Enable(u19.CameraAuraFX2, true);
        VfxManager.Enable(u19.CamEnablingAura, true);
        VfxManager.Enable(u19.CameraAuraFXPOV, true);
    end);
    task.delay(1.5 - u5, function() -- Line: 312
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), SolidColor (copy), u28 (copy), u16 (ref), DepthOfField (copy), u19 (copy), u27 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u28.Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.45
        }):Play();
        u16 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FocusDistance = 34,
            FarIntensity = 1
        });
        u16:Play();
        VfxManager.Emit(u19.CamTrans);
        VfxManager.Enable(u27, true);
        VfxManager.Enable(Model, true);
    end);
    task.delay(3.75 - u5, function() -- Line: 335
        -- upvalues: Folder (copy), u28 (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), SolidColor (copy), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u28.Tornado.TopTornado.Decal.Transparency = 0.95;
        u28.Tornado.TopTornado3.Decal.Transparency = 0.5;
        u28.Tornado.TopTornado2.Transparency = 0.85;
        local Folder3 = Instance.new("Folder");
        Folder3.Parent = Folder;
        Folder3.Name = "LightAttribute_Folder";
        Folder3:SetAttribute("Active", true);
        task.spawn(function() -- Line: 350
            -- upvalues: Folder3 (copy), Folder (ref), u28 (ref)
            while Folder3:GetAttribute("Active") == true do
                if Folder3 == nil then
                    return;
                end;

                if Folder == nil then
                    return;
                end;

                if Folder:GetAttribute("Active") == nil then
                    return;
                end;

                local TopTornado = u28.Tornado.TopTornado;
                TopTornado.CFrame = TopTornado.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                local TopTornado2 = u28.Tornado.TopTornado2;
                TopTornado2.CFrame = TopTornado2.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                local TopTornado3 = u28.Tornado.TopTornado3;
                TopTornado3.CFrame = TopTornado3.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                local AuraFOrBeginning = u28.AuraFOrBeginning;
                AuraFOrBeginning.CFrame = AuraFOrBeginning.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                task.wait();
            end;
        end);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u19.CamTrans);
        VfxManager.Enable(u19.CamEnablingAura, false);
        VfxManager.Enable(u19.CameraAuraFXPOV, false);
    end);
    task.delay(5.383 - u5, function() -- Line: 379
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), SolidColor (copy), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
        VfxManager.Emit(u19.CamTrans);
        VfxManager.Enable(u19.CamEnablingAura, false);
        VfxManager.Enable(u19.CameraAuraFXPOV, false);
    end);
    task.delay(5.5 - u5, function() -- Line: 396
        -- upvalues: Folder (copy), u28 (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u13 (copy), u19 (copy), Model (copy), u26 (copy), u27 (copy), ColorCorrection (copy), u15 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u28.Tornado.TopTornado.Decal.Transparency = 0.95;
        u28.Tornado.TopTornado2.Transparency = 0.85;
        local LightAttribute_Folder = Folder:FindFirstChild("LightAttribute_Folder");
        task.spawn(function() -- Line: 406
            -- upvalues: LightAttribute_Folder (copy), Folder (ref), u28 (ref)
            while LightAttribute_Folder:GetAttribute("Active") == true do
                if LightAttribute_Folder == nil then
                    return;
                end;

                if Folder == nil then
                    return;
                end;

                if Folder:GetAttribute("Active") == nil then
                    return;
                end;

                local TopTornado = u28.Tornado.TopTornado;
                TopTornado.CFrame = TopTornado.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                local TopTornado2 = u28.Tornado.TopTornado2;
                TopTornado2.CFrame = TopTornado2.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                local AuraFOrBeginning = u28.AuraFOrBeginning;
                AuraFOrBeginning.CFrame = AuraFOrBeginning.CFrame * CFrame.Angles(0, -0.10471975511965978, 0);
                task.wait();
            end;
        end);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        u13.Enabled = true;
        task.delay(0.05, function() -- Line: 427
            -- upvalues: Folder (ref), u13 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u13.Enabled = false;
        end);
        VfxManager.Emit(u28.ImpactForAura);
        VfxManager.Enable(u19.VerticalLines, true);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u26, true);
        VfxManager.Enable(u27, true);
        VfxManager.Enable(u19.Glare, true);
        ColorCorrection.Brightness = 2;
        u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u15:Play();
    end);
    task.delay(8.033 - u5, function() -- Line: 448
        -- upvalues: Folder (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v29 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v29.Parent = ScreenGui;
        UIController:PlayFlipbook(v29, "ChrolloImpact3", 0.041666666666666664);
        task.wait(0.16666666666666666);
        ScreenGui:Destroy();
    end);
    task.delay(8.133 - u5, function() -- Line: 466
        -- upvalues: Folder (copy), u28 (copy), VfxManager (ref), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u28.Tornado.TopTornado.Decal.Transparency = 1;
        u28.Tornado.TopTornado3.Decal.Transparency = 1;
        u28.Tornado.TopTornado2.Transparency = 1;
        Folder:FindFirstChild("LightAttribute_Folder"):SetAttribute("Active", nil);
        VfxManager.Enable(u19, false);
    end);
    task.delay(8.933 - u5, function() -- Line: 481
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u28 (copy), Model (copy), u19 (copy), Char (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        TweenService:Create(u28.Sphere, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        TweenService:Create(u28.Sphere, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Transparency = 0.55
        }):Play();
        VfxManager.Emit(u28.ImpactForAura);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u19.DunkCameraSparks, true);
        VfxManager.Enable(u19.DunkCameraHorizontal, false);
        VfxManager.Enable(u19.Glare, true);

        for _, child in Char:GetChildren() do
            if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
                local _ = child.Color;
                child.Color = Color3.new(0, 0, 0);
            elseif child:IsA("Shirt") or child:IsA("Pants") then
                local _ = child.Color3;
                child.Color3 = Color3.fromRGB(0, 0, 0);
            end;
        end;

        for _, descendant in Char:FindFirstChild("Head"):GetDescendants() do
            if descendant:IsA("Decal") then
                local _ = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end);
    task.delay(9.05 - u5, function() -- Line: 520
        -- upvalues: Folder (copy), VfxManager (ref), u28 (copy), u19 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u28.ImpactForAura);
        VfxManager.Enable(u19.CameraAuraFXPOV2, true);
        VfxManager.Enable(u19.CameraAuraFX2, true);
    end);

    local function v30() -- Line: 529
        -- upvalues: u17 (ref), Folder (copy), VfxManager (ref), u15 (ref), u16 (ref), u20 (copy), u13 (copy), Highlight (copy), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
        for _, v in u17 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
                    descendant:Destroy();
                end;
            end;
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if u20 then
            u20:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u18 then
            u18:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        game_Lighting.ClockTime = ClockTime;
        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v30));
    table.insert(u17, Folder.Destroying:Connect(v30));
    task.delay(51.45 - v4, function() -- Line: 610
        -- upvalues: Folder2 (copy)
        if Folder2 == nil then
            return;
        end;

        if Folder2:GetAttribute("Active") == nil then
            return;
        end;

        Folder2:SetAttribute("Active", nil);
    end);
    local u31 = {};

    local function v35() -- Line: 619
        -- upvalues: Char (copy), u14 (copy), Folder2 (copy), VfxManager (ref), u31 (ref)
        if Char and u14 then
            for _, v in u14 do
                local v32, v33, v34 = unpack(v);

                if v33 then
                    if v32 == "Part" then
                        v33.Color = v34;
                    elseif v32 == "Clothes" then
                        v33.Color3 = v34;
                    elseif v32 == "Decal" then
                        v33.Transparency = v34;
                    end;
                end;
            end;
        end;

        if Folder2 then
            Folder2.Name = "_";
            VfxManager.Enable(Folder2, false);
            VfxManager.DestroyEffect(Folder2, 5);
        end;

        u31 = nil;
    end;

    table.insert(u31, Folder2.AttributeChanged:Connect(v35));
    table.insert(u31, Folder2.Destroying:Connect(v35));
    table.insert(u31, HumanoidRootPart.Destroying:Connect(v35));
    table.insert(u31, Char.Destroying:Connect(v35));
end;
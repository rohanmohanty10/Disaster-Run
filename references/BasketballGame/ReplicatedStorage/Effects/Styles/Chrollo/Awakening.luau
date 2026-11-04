 
 

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
        local v7 = p2.Task == "Cleanup" and Debris:FindFirstChild(v6);

        if v7 then
            v7:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(1.4, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "Hey Hoopers!",
                1,
                0.1
            },
            { u3, "Welcome to...", 1 }
        });
    end);
    task.delay(5.3, function() -- Line: 51
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            {
                u3,
                "<font color=\"#000000\"><animation style=\"glitch\">...my world.</animation></font>",
                1.5,
                0,
                Color3.new(1, 1, 1)
            }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 66
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u5;
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
    task.delay(9.95 - u5, function() -- Line: 85
        -- upvalues: u9 (ref)
        u9:Disconnect();
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
    local u12 = script.ImpactFrameDark:Clone();
    u12.Parent = game_Lighting;
    local u13 = {};
    local u14 = {};

    for _, child in Char:GetChildren() do
        if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
            table.insert(u13, { "Part", child, child.Color });
        elseif child:IsA("Shirt") or child:IsA("Pants") then
            table.insert(u13, { "Clothes", child, child.Color3 });
        end;
    end;

    local Head = Char:FindFirstChild("Head");

    for _, descendant in Head:GetDescendants() do
        if descendant:IsA("Decal") then
            table.insert(u13, { "Decal", descendant, descendant.Transparency });
        end;
    end;

    if Debris:FindFirstChild(v6) then
        Debris:FindFirstChild(v6):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v6;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.95, function() -- Line: 149
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = SfxManager:playSound({
        Sound = "BBZ Chrollo AWK",
        Parent = workspace
    });
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    u16.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u16.PrimaryPart, CamRig.camera);
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    local SolidColor = u17.SolidColor;
    local _ = u17.CurrentBannerSolid;
    local CurrentBanner = u17.CurrentBanner;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v18 = child:Clone();
            v18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v18, false);
        end;
    end;

    local u19 = script.HeadAura:Clone();
    u19.CFrame = Head.CFrame;
    u19.Parent = Folder;
    Essentials:Weld(u19, Head);
    VfxManager.Enable(u19, false);
    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    local u21 = TweenService:Create(DepthOfField, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
        FarIntensity = 1,
        FocusDistance = 14.68
    });
    u21:Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 18;
    TweenService:Create(BlurEffect, TweenInfo.new(1.25, Enum.EasingStyle.Circular), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 1.25);
    Vignette.ImageTransparency = 1;
    Vignette1.ImageTransparency = 1;
    ColorCorrection.Contrast = 2;
    ColorCorrection.Saturation = -1;
    ColorCorrection.TintColor = Color3.fromRGB(167, 167, 167);
    local u22 = TweenService:Create(ColorCorrection, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        Contrast = 0.2,
        TintColor = Color3_fromRGB_ret
    });
    u22:Play();
    local u23 = TweenService:Create(ColorCorrection, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        Saturation = 0.3
    });
    u23:Play();
    TweenService:Create(Vignette, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
        ImageTransparency = 0
    }):Play();
    TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        ImageTransparency = 0
    }):Play();
    SolidColor.ImageTransparency = 0;
    TweenService:Create(SolidColor, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(u20.Sphere, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
        Transparency = 0.35
    }):Play();
    task.delay(0.233 - u5, function() -- Line: 236
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u16 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.StompEffect1);
        VfxManager.Enable(u16.CameraAuraFXPOV, true);
        VfxManager.Enable(u16.CamEnablingAura, true);
        VfxManager.Enable(Model, true);
    end);
    task.delay(1.08 - u5, function() -- Line: 245
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.StompEffect2);
    end);
    task.delay(1.25 - u5, function() -- Line: 251
        -- upvalues: Folder (copy), u16 (copy), TweenService (ref), VfxManager (ref), SolidColor (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        for _, descendant in u16.CurrentAura:GetDescendants() do
            if descendant:IsA("Beam") then
                local Brightness = descendant.Brightness;
                local LightEmission = descendant.LightEmission;
                local TextureSpeed = descendant.TextureSpeed;
                descendant.Brightness = 0;
                descendant.LightEmission = 1;
                descendant.Enabled = true;
                TweenService:Create(descendant, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                    Brightness = Brightness,
                    LightEmission = LightEmission
                }):Play();
                TweenService:Create(descendant, TweenInfo.new(0.655, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    TextureSpeed = 1
                }):Play();
                task.delay(0.655, function() -- Line: 263
                    -- upvalues: descendant (copy), TweenService (ref), Brightness (copy), LightEmission (copy), TextureSpeed (copy)
                    if descendant then
                        TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                            Brightness = 0,
                            LightEmission = 1
                        }):Play();
                    end;

                    task.wait(0.5);

                    if descendant then
                        descendant.Enabled = false;
                        descendant.Brightness = Brightness;
                        descendant.LightEmission = LightEmission;
                        descendant.TextureSpeed = TextureSpeed;
                    end;
                end);
            end;
        end;

        VfxManager.Emit(u16.CamTrans);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(2.317 - u5, function() -- Line: 284
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), SolidColor (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.CamTrans);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(3.433 - u5, function() -- Line: 292
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), SolidColor (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.CamTrans);
        SolidColor.ImageTransparency = 0.25;
        TweenService:Create(SolidColor, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(4.477 - u5, function() -- Line: 300
        -- upvalues: Folder (copy), ColorCorrection (copy), u22 (ref), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Brightness = 1;
        u22 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u22:Play();
    end);
    task.delay(4.483 - u5, function() -- Line: 308
        -- upvalues: Folder (copy), u23 (ref), TweenService (ref), ColorCorrection (copy), VfxManager (ref), u19 (copy), CurrentBanner (copy), u12 (copy), u20 (copy), Char (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u23 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u23:Play();
        VfxManager.Enable(u19, true);
        TweenService:Create(CurrentBanner, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.55
        }):Play();
        task.delay(0.355, function() -- Line: 317
            -- upvalues: Folder (ref), TweenService (ref), CurrentBanner (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            TweenService:Create(CurrentBanner, TweenInfo.new(1, Enum.EasingStyle.Sine), {
                ImageTransparency = 1
            }):Play();
        end);
        u12.Enabled = true;
        task.delay(0.125, function() -- Line: 325
            -- upvalues: Folder (ref), u12 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            if u12 then
                u12.Enabled = false;
            end;
        end);
        VfxManager.Emit(u20.NeckCrack);

        for _, child in Char:GetChildren() do
            if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
                local Color = child.Color;
                child.Color = Color3.new(0, 0, 0);
                task.delay(4, function() -- Line: 341
                    -- upvalues: Folder (ref), child (copy), Color (copy)
                    if Folder == nil then
                        return;
                    end;

                    if Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    child.Color = Color;
                end);
            elseif child:IsA("Shirt") or child:IsA("Pants") then
                local Color32 = child.Color3;
                child.Color3 = Color3.fromRGB(0, 0, 0);
                task.delay(4, function() -- Line: 351
                    -- upvalues: Folder (ref), child (copy), Color32 (copy)
                    if Folder == nil then
                        return;
                    end;

                    if Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    child.Color3 = Color32;
                end);
            end;
        end;

        for _, descendant in Char:FindFirstChild("Head"):GetDescendants() do
            if descendant:IsA("Decal") then
                local Transparency = descendant.Transparency;
                descendant.Transparency = 1;
                task.delay(4, function() -- Line: 365
                    -- upvalues: Folder (ref), descendant (copy), Transparency (copy)
                    if Folder == nil then
                        return;
                    end;

                    if Folder:GetAttribute("Active") == nil then
                        return;
                    end;

                    descendant.Transparency = Transparency;
                end);
            end;
        end;
    end);
    task.delay(5.9 - u5, function() -- Line: 374
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u16.CamTrans2);
    end);
    task.delay(6.483 - u5, function() -- Line: 381
        -- upvalues: Folder (copy), Highlight (copy), VfxManager (ref), u20 (copy), u22 (ref), TweenService (ref), ColorCorrection (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.OutlineTransparency = 1;
        VfxManager.Emit(u20.StompEffect3);
        u22 = TweenService:Create(ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u22:Play();
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v24 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v24.Parent = ScreenGui;
        UIController:PlayFlipbook(v24, "ChrolloImpact2", 0.0416666666666667);
        task.wait(1.75);
        ScreenGui:Destroy();
    end);
    task.delay(8.467 - u5, function() -- Line: 405
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Highlight (copy), u20 (copy), ColorCorrection (copy), u22 (ref), u16 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect2 = Instance.new("BlurEffect", game_Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.455);
        Highlight.OutlineTransparency = 0;
        u20.Sphere.Transparency = 1;
        ColorCorrection.Brightness = 0.75;
        u22 = TweenService:Create(ColorCorrection, TweenInfo.new(2, Enum.EasingStyle.Exponential), {
            Brightness = -0.015
        });
        u22:Play();
        VfxManager.Enable(u16.CameraAuraFXPOV, false);
        VfxManager.Enable(u20["Star Flashes"], true);
        VfxManager.Enable(u16.Glare, true);
        VfxManager.Enable(u16.DunkCameraSparks, true);
    end);
    task.delay(8.6 - u5, function() -- Line: 428
        -- upvalues: Folder (copy), u12 (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12.Enabled = true;
        task.delay(0.05, function() -- Line: 434
            -- upvalues: u12 (ref)
            u12.Enabled = false;
        end);
        VfxManager.Emit(u20.AuraEmit);
    end);

    local function v28() -- Line: 441
        -- upvalues: u14 (ref), Folder (copy), VfxManager (ref), u13 (copy), u22 (ref), u23 (ref), u21 (ref), u17 (copy), u12 (copy), Highlight (copy), u15 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);

            for _, descendant in Folder:GetDescendants() do
                if descendant:IsA("Part") or (descendant:IsA("MeshPart") or descendant:IsA("Texture")) then
                    descendant.Transparency = 1;
                end;
            end;
        end;

        if u13 then
            for _, v in u13 do
                local v25, v26, v27 = unpack(v);

                if v25 == "Part" then
                    v26.Color = v27;
                elseif v25 == "Clothes" then
                    v26.Color3 = v27;
                elseif v25 == "Decal" then
                    v26.Transparency = v27;
                end;
            end;
        end;

        if u22 then
            u22:Pause();
        end;

        if u23 then
            u23:Pause();
        end;

        if u21 then
            u21:Pause();
        end;

        if u17 then
            u17:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            u15:Destroy();
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
        u14 = nil;
    end;

    table.insert(u14, Folder.AttributeChanged:Connect(v28));
    table.insert(u14, Folder.Destroying:Connect(v28));
end;
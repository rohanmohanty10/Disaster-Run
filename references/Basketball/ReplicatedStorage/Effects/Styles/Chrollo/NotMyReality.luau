 
 

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
    local BALL = Char:FindFirstChild("BALL", true);
    local _ = p2.passedTime or 0;
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(0.8, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "Your goal...", 1 }
        });
    end);
    task.delay(3.5, function() -- Line: 45
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "...is not a part of <animation style=\"glitch\">MY REALITY!</animation>", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 58
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u4 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u4;
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
    task.delay(8.983 - u4, function() -- Line: 77
        -- upvalues: u8 (ref)
        u8:Disconnect();
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
    local u11 = script.ImpactFrameDark:Clone();
    u11.Parent = game_Lighting;
    local u12 = {};
    local u13 = nil;
    local u14 = nil;
    local u15 = {};
    local u16 = nil;
    local u17 = nil;
    local u18 = nil;

    for _, child in Char:GetChildren() do
        if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
            table.insert(u12, { "Part", child, child.Color });
        elseif child:IsA("Shirt") or child:IsA("Pants") then
            table.insert(u12, { "Clothes", child, child.Color3 });
        end;
    end;

    local Head = Char:FindFirstChild("Head");

    for _, descendant in Head:GetDescendants() do
        if descendant:IsA("Decal") then
            table.insert(u12, { "Decal", descendant, descendant.Transparency });
        end;
    end;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(8.983, function() -- Line: 141
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u19 = SfxManager:playSound({
        Sound = "BBZ Chrollo Reality Cutscene",
        Parent = workspace
    });
    local u20 = script.Camera_VFX:Clone();
    u20:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u20.Parent = Folder;
    u20.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u20.PrimaryPart, CamRig.camera);
    local u21 = script.Vignette:Clone();
    u21.Parent = PlayerGui;
    u21.Enabled = true;
    local Vignette = u21.Vignette;
    local Vignette1 = u21.Vignette1;
    local _ = u21.SolidColor;
    local _ = u21.CurrentBannerSolid;
    local _ = u21.CurrentBanner;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v22 = child:Clone();
            v22.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v22.Parent = Model;
            Essentials:Weld(v22, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v22, false);
        end;
    end;

    local u23 = script.HeadAura:Clone();
    u23.CFrame = Head.CFrame;
    u23.Parent = Folder;
    Essentials:Weld(u23, Head);
    VfxManager.Enable(u23, false);
    local u24 = script.BALL:Clone();
    u24.CFrame = BALL.CFrame;
    u24.Parent = Folder;
    Essentials:Weld(u24, BALL);
    VfxManager.Enable(u24, false);
    local v25 = script.SMALLBALL:Clone();
    v25.CFrame = BALL.CFrame;
    v25.Parent = Folder;
    Essentials:Weld(v25, BALL);
    VfxManager.Enable(v25, false);
    local u26 = script.Cutscene_VFX:Clone();
    u26:PivotTo(HumanoidRootPart.CFrame);
    u26.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(1.55 - u4, function() -- Line: 210
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (copy), u26 (copy), u24 (copy), u20 (copy), u13 (ref), DepthOfField (copy), Vignette (copy), Vignette1 (copy), u14 (ref), ColorCorrection (copy), u16 (ref), u17 (ref), u18 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Circular), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
        u11.Enabled = true;
        task.delay(0.05, function() -- Line: 220
            -- upvalues: Folder (ref), u11 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u11.Enabled = false;
        end);
        VfxManager.Emit(u26.ImpactForFreeze);
        VfxManager.Enable(u24, true);
        VfxManager.Enable(u26.BeamConnector, true);
        VfxManager.Enable(u20.CameraAuraFXPOV, true);
        u13 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 49.1
        });
        u13:Play();
        u26.Sphere.Transparency = 0.35;
        TweenService:Create(Vignette, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.175), {
            Contrast = 2,
            TintColor = Color3.fromRGB(112, 30, 255)
        });
        u14:Play();
        task.delay(0.125, function() -- Line: 242
            -- upvalues: Folder (ref), u16 (ref), TweenService (ref), ColorCorrection (ref), u17 (ref), u18 (ref), Color3_fromRGB_ret (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u16 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125), {
                TintColor = Color3.fromRGB(120, 255, 57)
            });
            u16:Play();
            task.wait(0.125);

            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125), {
                TintColor = Color3.fromRGB(255, 234, 3)
            });
            u17:Play();
            task.wait(0.125);

            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655), {
                Saturation = -1,
                Contrast = 0.2,
                TintColor = Color3_fromRGB_ret
            });
            u18:Play();
        end);
    end);
    task.delay(2.517 - u4, function() -- Line: 264
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), DepthOfField (copy), VfxManager (ref), Model (copy), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            FocusDistance = 49.1,
            NearIntensity = 1
        });
        u13:Play();
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u23, true);
    end);
    task.delay(3.083 - u4, function() -- Line: 275
        -- upvalues: Folder (copy), u13 (ref), TweenService (ref), DepthOfField (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u13 = TweenService:Create(DepthOfField, TweenInfo.new(0.155, Enum.EasingStyle.Sine), {
            FocusDistance = 85,
            NearIntensity = 0
        });
        u13:Play();
    end);
    task.delay(3.567 - u4, function() -- Line: 283
        -- upvalues: Folder (copy), ColorCorrection (copy), u14 (ref), TweenService (ref), u26 (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Brightness = 1;
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Contrast = 0.75,
            Brightness = -0.015,
            Saturation = -0.5
        });
        u14:Play();
        u26.Sphere.Transparency = 0;
        VfxManager.Enable(u20.DunkCameraSparks, true);
        VfxManager.Enable(u20.CameraAuraFXPOV, true);
    end);
    task.delay(5.317 - u4, function() -- Line: 301
        -- upvalues: Folder (copy), TweenService (ref), u26 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u26.Sphere, TweenInfo.new(0.155, Enum.EasingStyle.Sine), {
            Transparency = 0.45
        }):Play();
    end);
    task.delay(6.88 - u4, function() -- Line: 308
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
        local v27 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v27.Parent = ScreenGui;
        UIController:PlayFlipbook(v27, "ChrolloImpact1", 0.0416666666666667);
        task.wait(0.1666666666666668);
        ScreenGui:Destroy();
    end);
    task.delay(7.65 - u4, function() -- Line: 326
        -- upvalues: Folder (copy), TweenService (ref), VfxManager (ref), Vignette (copy), ColorCorrection (copy), u14 (ref), u26 (copy), u24 (copy), Char (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Circular), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        Vignette.ImageColor3 = Color3.fromRGB(255, 255, 255);
        ColorCorrection.Brightness = 1;
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u26.CatchEmit);
        VfxManager.Enable(u24, true);
        VfxManager.Enable(u26.BeamConnector, false);

        for _, child in Char:GetChildren() do
            if child:IsA("Part") and child.Name ~= "HumanoidRootPart" then
                local Color = child.Color;
                child.Color = Color3.new(0, 0, 0);
                task.delay(2.5, function() -- Line: 353
                    -- upvalues: child (copy), Color (copy)
                    child.Color = Color;
                end);
            elseif child:IsA("Shirt") or child:IsA("Pants") then
                local Color32 = child.Color3;
                child.Color3 = Color3.fromRGB(0, 0, 0);
                task.delay(2.5, function() -- Line: 359
                    -- upvalues: child (copy), Color32 (copy)
                    child.Color3 = Color32;
                end);
            end;
        end;

        for _, descendant in Char:FindFirstChild("Head"):GetDescendants() do
            if descendant:IsA("Decal") then
                local Transparency = descendant.Transparency;
                descendant.Transparency = 1;
                task.delay(2.5, function() -- Line: 371
                    -- upvalues: descendant (copy), Transparency (copy)
                    descendant.Transparency = Transparency;
                end);
            end;
        end;
    end);

    local function v31() -- Line: 379
        -- upvalues: u15 (ref), Folder (copy), VfxManager (ref), u12 (copy), u14 (ref), u16 (ref), u17 (ref), u18 (ref), u13 (ref), u21 (copy), u11 (copy), Highlight (copy), u19 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
        for _, v in u15 do
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

        if u12 then
            for _, v in u12 do
                local v28, v29, v30 = unpack(v);

                if v28 == "Part" then
                    v29.Color = v30;
                elseif v28 == "Clothes" then
                    v29.Color3 = v30;
                elseif v28 == "Decal" then
                    v29.Transparency = v30;
                end;
            end;
        end;

        if u14 then
            u14:Pause();
        end;

        if u16 then
            u16:Pause();
        end;

        if u17 then
            u17:Pause();
        end;

        if u18 then
            u18:Pause();
        end;

        if u13 then
            u13:Pause();
        end;

        if u21 then
            u21:Destroy();
        end;

        if u11 then
            u11:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u19 then
            u19:Destroy();
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
        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v31));
    table.insert(u15, Folder.Destroying:Connect(v31));
end;
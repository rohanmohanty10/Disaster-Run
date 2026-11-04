 
 

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

return function(u1, u2) -- Line: 19
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = u2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local _ = u2.passedTime;
    local u3 = workspace:GetServerTimeNow() - u2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if u2.Task ~= "Cutscene" then
        local v5 = u2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(7.5, function() -- Line: 35
        -- upvalues: Effects (ref), u2 (copy)
        Effects:SubtitleV2({
            { game.Players:GetPlayerFromCharacter(u2.Other) or "Unfortunate Soul", "<i>*whimpers*</i>", 1 }
        });
    end);
    workspace:FindFirstChild("Player1");
    workspace:FindFirstChild("Player2");
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 51
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
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
    task.delay(12.4 - u3, function() -- Line: 70
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = {};
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u15 = nil;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.4, function() -- Line: 115
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "0620",
        Duration = 15,
        Parent = workspace
    });
    u16.TimePosition = u3;
    local u17 = script.Camera_VFX:Clone();
    u17:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u17.Parent = Folder;
    u17.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u17.PrimaryPart, CamRig.camera);
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local Vignette = u18.Vignette;
    local Vignette1 = u18.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v19 = child:Clone();
            v19.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v19.Parent = Model;
            Essentials:Weld(v19, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v19, false);
        end;
    end;

    local Model2 = Instance.new("Model");
    Model2.Parent = Folder;

    for _, child in script.EnemySweat:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v20 = child:Clone();
            v20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v20.Parent = Model;
            Essentials:Weld(v20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v20, false);
        end;
    end;

    local u21 = script.Cutscene_VFX:Clone();
    u21:PivotTo(HumanoidRootPart.CFrame);
    u21.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(0.417 - u3, function() -- Line: 182
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.Step1);
    end);
    task.delay(0.75 - u3, function() -- Line: 189
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.Step2);
    end);
    task.delay(1.317 - u3, function() -- Line: 196
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), Vignette1 (copy), game_Lighting (copy), u12 (ref), TweenService (ref), u13 (ref), u14 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.Warning);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 66, 69);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 66, 69);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u12:Play();
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(2.033 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy), game_Lighting (copy), Highlight (copy), VfxManager (ref), u21 (copy), Model2 (copy), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        game_Lighting.ColorCorrection.Saturation = -1;
        game_Lighting.DepthOfField.FocusDistance = 35;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        VfxManager.Enable(u21.AirSpecs, true);
        VfxManager.Enable(Model2, true);
        VfxManager.Enable(u17.Speedlines, true);
    end);
    task.delay(3.467 - u3, function() -- Line: 235
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u12 (ref), u15 (ref), Highlight (copy), u21 (copy), Model2 (copy), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(1.3, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.3);
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u12:Play();
        u15 = TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(1.45, Enum.EasingStyle.Linear), {
            FocusDistance = 100
        });
        u15:Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        VfxManager.Enable(u21.AirSpecs, false);
        VfxManager.Enable(Model2, false);
        VfxManager.Enable(u17, false);
    end);
    task.delay(3.583 - u3, function() -- Line: 257
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.FallFX);
    end);
    task.delay(4.867 - u3, function() -- Line: 264
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.Speedlines, true);
    end);
    task.delay(5.833 - u3, function() -- Line: 271
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, true);
    end);
    task.delay(6.133 - u3, function() -- Line: 278
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.CameraAtmosphere, true);
        VfxManager.Enable(u17.DunkCamera, true);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v22 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v22.Parent = ScreenGui;
        UIController:PlayFlipbook(v22, "TatlisOffTheBall", 0.041666666666666664);
        task.wait(0.375);
        ScreenGui:Destroy();
    end);
    task.delay(6.25 - u3, function() -- Line: 299
        -- upvalues: Folder (copy), Vignette1 (copy), game_Lighting (copy), u12 (ref), TweenService (ref), u13 (ref), u14 (ref), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(48, 48, 255);
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(48, 48, 255);
        game_Lighting.ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u12:Play();
        u13 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u13:Play();
        u14 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u21.AirSpecs, true);
    end);
    task.delay(7.433 - u3, function() -- Line: 320
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u17.DunkCamera, false);
        VfxManager.Enable(u17.DunkCameraVertical, true);
    end);
    task.delay(8.317 - u3, function() -- Line: 328
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u17 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.Enabled, true);
        VfxManager.Enable(u17, false);
        VfxManager.Enable(u21.AirSpecs, false);
    end);
    task.delay(9.5 - u3, function() -- Line: 338
        -- upvalues: Folder (copy), u11 (ref), DepthOfField (copy), ColorCorrection (copy), u12 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder == nil then
            MapFolder = workspace:FindFirstChild("Map2");
        end;

        for _, v in { workspace.Courts2, MapFolder } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("MeshPart") or (descendant:IsA("Part") or descendant:IsA("Decal")) then
                    table.insert(u11, { descendant, descendant.Transparency });
                    descendant.Transparency = 1;
                end;
            end;
        end;

        task.wait(0.1);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        DepthOfField.FarIntensity = 1;
        DepthOfField.FocusDistance = 120;
        DepthOfField.NearIntensity = 0;
        DepthOfField.InFocusRadius = 0;
        ColorCorrection.Brightness = -1;
        task.wait(0.2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Brightness = -0.015
        });
        u12:Play();
    end);

    local function v25() -- Line: 379
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u18 (copy), Highlight (copy), u16 (copy), u11 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
        for _, v in u10 do
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
            u12:Pause();
        end;

        if u13 then
            u13:Pause();
        end;

        if u14 then
            u14:Pause();
        end;

        if u15 then
            u15:Pause();
        end;

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u16 then
            VfxManager.DestroyEffect(u16, 2);
        end;

        if u11 then
            for _, v in u11 do
                local v23, v24 = unpack(v);
                v23.Transparency = v24;
            end;
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
        u10 = nil;
        u11 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v25));
    table.insert(u10, Folder.Destroying:Connect(v25));
end;
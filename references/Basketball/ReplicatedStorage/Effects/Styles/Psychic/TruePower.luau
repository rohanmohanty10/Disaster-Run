 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function ParticleOnly(p1: userdata, p2: boolean) -- Line: 19
    if p1 == nil then
        return;
    end;

    if p2 == nil then
        p2 = false;
    end;

    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p2;
        end;
    end;
end;

local function BeamOnly(p3: userdata, p4: boolean) -- Line: 32
    if p3 == nil then
        return;
    end;

    if p4 == nil then
        p4 = false;
    end;

    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = p4;
        end;
    end;
end;

return function(u5, p6) -- Line: 46
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), ParticleOnly (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v7 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v8 = p6.Task == "Cleanup" and Debris:FindFirstChild(v7);

        if v8 then
            v8:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u9 = SfxManager:playSound({
        Sound = "BBZ Psychic questionmark dunk cutscene",
        Parent = workspace
    });
    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 67
        -- upvalues: u5 (copy), u12 (ref), u11 (ref), u10 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u12:Disconnect();

            return;
        end;

        if u11 <= 0 then
            u11 = p13 * 60 * u10;
        end;

        u11 = u11 + p13 * 60;
        local v14 = script_Fov[math.ceil(u11)];

        if v14 ~= nil then
            if math.ceil(u11) >= #script_Fov then
                u12:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v14, p13 * 6);
        end;
    end);
    task.delay(29.417 - u10, function() -- Line: 86
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u16 = nil;
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    local Folder2 = Instance.new("Folder");
    Folder2.Name = v7 .. "Chaos";
    Folder2.Parent = Char;
    Folder2:SetAttribute("Active", true);
    task.delay(29.417, function() -- Line: 134
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u20 = script.Camera_VFX:Clone();
    u20:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u20.Parent = Folder;
    u20.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u20.PrimaryPart, CamRig.camera);
    local u21 = script.Vignette:Clone();
    u21.Parent = PlayerGui;
    u21.Enabled = true;
    local Vignette = u21.Vignette;
    local _ = u21.Vignette1;
    local MobVignette = u21.MobVignette;
    local FlatColor = u21.FlatColor;
    local Model = Instance.new("Model");
    Model.Parent = Folder2;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local u22 = child:Clone();
            u22.CFrame = Char:FindFirstChild(child.Name).CFrame;
            u22.Parent = Model;
            Essentials:Weld(u22, Char:FindFirstChild(child.Name));
            VfxManager.Enable(u22, false);
            task.delay(29, function() -- Line: 165
                -- upvalues: u22 (copy)
                u22:Destroy();
            end);
        end;
    end;

    local Head2 = p6.EnemyChar:FindFirstChild("Head");
    local Torso = p6.EnemyChar:FindFirstChild("Torso");
    local Torso2 = Char:FindFirstChild("Torso");
    local v23 = Char:FindFirstChild("Right Arm");
    local u24 = script.EnemyHead:Clone();
    u24.CFrame = Head2.CFrame;
    u24.Parent = Folder;
    VfxManager.Enable(u24, false);
    Essentials:Weld(u24, Head2);
    local u25 = script.EnemyTorsoVFX:Clone();
    u25.CFrame = Torso.CFrame;
    u25.Parent = Folder;
    VfxManager.Enable(u25, false);
    Essentials:Weld(u25, Torso);
    local v26 = script.PlayerHeadVFX:Clone();
    v26.CFrame = Head.CFrame;
    v26.Parent = Folder;
    VfxManager.Enable(v26, false);
    Essentials:Weld(v26, Head);
    local u27 = script.PlayerTorsoVFX:Clone();
    u27.CFrame = Torso2.CFrame;
    u27.Parent = Folder;
    VfxManager.Enable(u27, false);
    Essentials:Weld(u27, Torso2);
    local u28 = script.PlayerRightArmVFX:Clone();
    u28.CFrame = v23.CFrame;
    u28.Parent = Folder;
    VfxManager.Enable(u28, false);
    Essentials:Weld(u28, v23);
    local u29 = script.Cutscene_VFX:Clone();
    u29:PivotTo(HumanoidRootPart.CFrame);
    u29.Parent = Folder;
    local u30 = script.Dome:Clone();
    u30.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    u30["inverted sphere"].CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2843983173370361, 2.448972463607788, -3.258289337158203) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    u30.Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.6211225986480713, -3.3523690700531006, -3.3250999450683594) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    task.delay(4.25 - u10, function() -- Line: 227
        -- upvalues: Folder (copy), u30 (copy), HumanoidRootPart (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u30.Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.6211225986480713, -25.967021942138672, -3.3250999450683594) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
        u30["inverted sphere"].CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.2843983173370361, -20.165679931640625, -3.258289337158203) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    end);
    VfxManager.Enable(Model, true);
    ParticleOnly(u20.camstart, true);
    task.delay(3 - u10, function() -- Line: 239
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.questionmark);
    end);
    task.delay(4 - u10, function() -- Line: 246
        -- upvalues: Folder (copy), ParticleOnly (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camstart, false);
    end);
    task.delay(4.017 - u10, function() -- Line: 253
        -- upvalues: Folder (copy), ParticleOnly (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camtra, true);
        task.wait(0.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camtra, false);
    end);
    task.delay(5.583 - u10, function() -- Line: 267
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref), game_Lighting (copy), VfxManager (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette.ImageColor3 = Color3.fromRGB(102, 42, 255);
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 12;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.35);
        VfxManager.Emit(u29.AuraEmit);
    end);
    task.delay(5.717 - u10, function() -- Line: 283
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.rage, true);
        task.wait(0.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.rage, false);
    end);
    task.delay(6 - u10, function() -- Line: 297
        -- upvalues: Folder (copy), ParticleOnly (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camtra, true);
        task.wait(0.5);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camtra, false);
    end);
    task.delay(6.15 - u10, function() -- Line: 311
        -- upvalues: Folder (copy), ParticleOnly (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camstart, true);
        task.wait(4);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u20.camstart, false);
    end);
    task.delay(6.183 - u10, function() -- Line: 325
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), u29 (copy), VfxManager (ref), u28 (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(89, 24, 255)
        }):Play();
        TweenService:Create(u29.Sphere, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
        VfxManager.Enable(u28, true);
        VfxManager.Enable(u20.DunkCameraHorizontal, true);
    end);
    task.delay(7.067 - u10, function() -- Line: 336
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u20.DunkCameraHorizontal, false);
        VfxManager.Emit(u20.CameraTransition);
    end);
    task.delay(7.317 - u10, function() -- Line: 346
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.stepemit1);
    end);
    task.delay(7.667 - u10, function() -- Line: 353
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.stepemit2);
    end);
    task.delay(8.017 - u10, function() -- Line: 360
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.stepemit3);
    end);
    task.delay(8.083 - u10, function() -- Line: 367
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u29 (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.PassCamera1, true);
        VfxManager.Emit(u29.VictimEmit);
        VfxManager.Emit(u25);
    end);
    task.delay(8.633 - u10, function() -- Line: 376
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy), MobVignette (copy), TweenService (ref), Vignette (copy), game_Lighting (copy), u16 (ref), Color3_fromRGB_ret (copy), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.fall);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u29.gravity, true);
        task.delay(2, function() -- Line: 389
            -- upvalues: Folder (ref), VfxManager (ref), u29 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u29.gravity, false);
        end);
        MobVignette.ImageTransparency = 0;
        TweenService:Create(MobVignette, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Vignette.ImageColor3 = Color3.fromRGB(117, 48, 255);
        TweenService:Create(Vignette, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Parent = game_Lighting;
        BlurEffect.Size = 30;
        TweenService:Create(BlurEffect, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.655);
        game_Lighting.ColorCorrection.Brightness = 0.5;
        game_Lighting.ColorCorrection.Contrast = 0.75;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(224, 70, 255);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            TintColor = Color3_fromRGB_ret
        });
        u16:Play();
        TweenService:Create(u29.Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        VfxManager.Enable(u20.PassCamera1, false);
    end);
    task.delay(9.867 - u10, function() -- Line: 424
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.DunkCameraVertical, false);
        VfxManager.Enable(u20.camstart, true);
        u29.Sphere.Transparency = 0;
        task.delay(6, function() -- Line: 432
            -- upvalues: Folder (ref), VfxManager (ref), u20 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u20.camstart, false);
        end);
    end);
    task.delay(10.95 - u10, function() -- Line: 441
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.pull, true);
        task.wait(2);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.pull, false);
    end);
    task.delay(11.4 - u10, function() -- Line: 455
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.DunkCameraVertical, false);
        VfxManager.Enable(u20.camstart, true);
        u29.Sphere.Transparency = 0;
        task.delay(6, function() -- Line: 463
            -- upvalues: Folder (ref), VfxManager (ref), u20 (ref)
            if Folder == nil then
                return;
            end;

            if Folder:GetAttribute("Active") == nil then
                return;
            end;

            VfxManager.Enable(u20.camstart, true);
        end);
        VfxManager.Enable(u29.gravity, true);
        u29.Sphere.Transparency = 1;
    end);
    task.delay(11.617 - u10, function() -- Line: 475
        -- upvalues: Folder (copy), VfxManager (ref), u24 (copy), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u24, true);
        VfxManager.Enable(u29.gravity, false);
    end);
    task.delay(11.767 - u10, function() -- Line: 483
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 0.65;
        game_Lighting.ColorCorrection.Contrast = 1;
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
    end);
    task.delay(12.367 - u10, function() -- Line: 497
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.CameraWind, true);
        VfxManager.Enable(u20.PassCamera1, true);
    end);
    task.delay(12.867 - u10, function() -- Line: 505
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        VfxManager.Enable(u20.CameraWind, false);
        VfxManager.Enable(u20.PassCamera1, false);
    end);
    task.delay(13.4 - u10, function() -- Line: 518
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.CameraWind);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v31 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v31.Parent = ScreenGui;
        UIController:PlayFlipbook(v31, "TruePowerIF1", 0.04);
        task.wait(0.2);
        ScreenGui:Destroy();
    end);
    task.delay(14.217 - u10, function() -- Line: 539
        -- upvalues: Folder (copy), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Saturation = -1;
    end);
    task.delay(14.383 - u10, function() -- Line: 546
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy), game_Lighting (copy), TweenService (ref), Vignette (copy), u18 (ref), u19 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.HeadHit);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 25;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.655);
        u29.Sphere.Transparency = 0;
        TweenService:Create(u29.Sphere, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 0.75;
        game_Lighting.ColorCorrection.Contrast = 1;
        Vignette.ImageColor3 = Color3.fromRGB(243, 82, 255);
        TweenService:Create(Vignette, TweenInfo.new(1.85, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u19:Play();
    end);
    task.delay(17.15 - u10, function() -- Line: 577
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.FloatingDebris, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.FloatingDebris, false);
    end);
    task.delay(19.083 - u10, function() -- Line: 591
        -- upvalues: Folder (copy), FlatColor (copy), TweenService (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        FlatColor.ImageTransparency = 0;
        TweenService:Create(FlatColor, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(20.367 - u10, function() -- Line: 599
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), TweenService (ref), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.DunkCamera, true);
        TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1
        }):Play();
    end);
    task.delay(22 - u10, function() -- Line: 607
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), FlatColor (copy), TweenService (ref), u16 (ref), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.DunkCamera, false);
        FlatColor.ImageTransparency = 0;
        TweenService:Create(FlatColor, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u16:Play();
    end);
    task.delay(22.3 - u10, function() -- Line: 619
        -- upvalues: Folder (copy), TweenService (ref), u29 (copy), game_Lighting (copy), VfxManager (ref), u17 (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u29.Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 30;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.655);
        VfxManager.Enable(u29.ModeVFX, true);
        game_Lighting.ColorCorrection.Brightness = 0.65;
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u17:Play();
    end);
    task.delay(22.517 - u10, function() -- Line: 639
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.beforeimpact, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.beforeimpact, false);
    end);
    task.delay(22.55 - u10, function() -- Line: 653
        -- upvalues: Folder (copy), ParticleOnly (ref), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.lines2, true);
        task.wait(3);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ParticleOnly(u29.lines2, false);
    end);
    task.delay(23.55 - u10, function() -- Line: 667
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy), LocalPlayer (ref), ReplicatedStorage (ref), UIController (ref)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u29.ModeVFX, false);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        local v32 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v32.Parent = ScreenGui;
        UIController:PlayFlipbook(v32, "TruePowerIF2", 0.041666666666666664);
        task.wait(1.9583333333333333);
        ScreenGui:Destroy();
    end);
    task.delay(25.683 - u10, function() -- Line: 687
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), u27 (copy), u29 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u20.camstart, true);
        VfxManager.Enable(u27, true);
        VfxManager.Enable(u29.SpaceZoneSpecs, true);
    end);
    task.delay(26.9 - u10, function() -- Line: 696
        -- upvalues: Folder (copy), VfxManager (ref), u29 (copy), TweenService (ref), MobVignette (copy), game_Lighting (copy), Vignette (copy), u17 (ref), u18 (ref), Color3_fromRGB_ret (copy), u28 (copy), u27 (copy), u24 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u29.Score);
        TweenService:Create(u29.Sphere, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        MobVignette.ImageTransparency = 0;
        TweenService:Create(MobVignette, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 15;
        BlurEffect.Parent = game_Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1.35);
        Vignette.ImageColor3 = Color3.fromRGB(204, 85, 255);
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 0.65;
        game_Lighting.ColorCorrection.Contrast = 1;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(188, 144, 255);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Contrast = 0.2,
            Brightness = -0.015
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Enable(u28, false);
        VfxManager.Enable(u27, false);
        VfxManager.Enable(u29.SpaceZoneSpecs, false);
        VfxManager.Enable(u24, false);
    end);

    local function v33() -- Line: 729
        -- upvalues: u15 (ref), Folder (copy), VfxManager (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u21 (copy), Highlight (copy), u9 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
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
                elseif descendant:IsA("PointLight") or (descendant:IsA("SpotLight") or descendant:IsA("SurfaceLight")) then
                    descendant:Destroy();
                end;
            end;
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

        if u19 then
            u19:Pause();
        end;

        if u21 then
            u21:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u9 then
            VfxManager.DestroyEffect(u9, 2);
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

    table.insert(u15, Folder.AttributeChanged:Connect(v33));
    table.insert(u15, Folder.Destroying:Connect(v33));
end;
 
 

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
require(ReplicatedStorage.Controllers.UIController);
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
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local v8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(8.2, function() -- Line: 59
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Gum Gum...", 1.3 },
            { u7, "<animation style=\"glitch\">JET PISTOL!</animation>", 1.8 }
        });
    end);
    task.delay(14, function() -- Line: 74
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "<animation style=\"glitch\">I\'M GOING TO BE KING OF THE COURT!</animation>", 4 }
        });
    end);
    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 89
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
    task.delay(18.167 - u10, function() -- Line: 108
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local u15 = SfxManager:playSound({
        Sound = "BBZ Rubber JetPistolDunk cutscene",
        Parent = workspace
    });
    u15.TimePosition = u10;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = script.Vignette:Clone();
    u16.Parent = PlayerGui;
    u16.Enabled = true;
    local Vignette = u16.Vignette;
    local _ = u16.Vignette1;
    local BottomFrame = u16.BottomFrame;
    local TopFrame = u16.TopFrame;
    local SolidColor = u16.SolidColor;
    local StarVignette = u16.StarVignette;
    local u17 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u18 = nil;
    local u19 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local Offset = Atmosphere.Offset;
    local Haze = Atmosphere.Haze;
    local Decay = Atmosphere.Decay;
    local Glare = Atmosphere.Glare;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(18.167, function() -- Line: 174
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local u20 = child:Clone();
            u20.CFrame = Char:FindFirstChild(child.Name).CFrame;
            u20.Parent = Model;
            Essentials:Weld(u20, Char:FindFirstChild(child.Name));
            VfxManager.Enable(u20, false);
            task.delay(18.167, function() -- Line: 193
                -- upvalues: u20 (copy)
                u20:Destroy();
            end);
        end;
    end;

    local u21 = script.Camera_VFX:Clone();
    u21:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u21.Parent = Folder;
    u21.PrimaryPart.CFrame = CamRig.CamPart.CFrame;
    Essentials:Weld(u21.PrimaryPart, CamRig.camera);
    local u22 = script.Cutscene_VFX:Clone();
    u22:PivotTo(HumanoidRootPart.CFrame);
    u22.Parent = Folder;
    local Sphere = u22.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(15.95 - u10, function() -- Line: 223
        -- upvalues: Folder (copy), ColorCorrection (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.TintColor = Color3.fromRGB(255, 191, 191);
    end);
    game_Lighting.Bloom.Intensity = 1.35;
    Vignette.ZIndex = 0;
    Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        ImageColor3 = Color3.fromRGB(124, 101, 74)
    }):Play();
    Sphere.Transparency = 1;
    StarVignette.ImageTransparency = 1;
    TopFrame.Position = UDim2.new(-0.092, 0, -0.05, 0);
    BottomFrame.Position = UDim2.new(-0.087, 0, -0.02, 0);
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Highlight, TweenInfo.new(1.45, Enum.EasingStyle.Sine), {
        FillTransparency = 1
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 25;
    TweenService:Create(BlurEffect, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 1);
    SolidColor.ImageTransparency = 0;
    TweenService:Create(SolidColor, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
        ImageTransparency = 1
    }):Play();
    TweenService:Create(BottomFrame, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
        Position = UDim2.new(-0.087, 0, 0.99, 0)
    }):Play();
    TweenService:Create(TopFrame, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
        Position = UDim2.new(-0.087, 0, -0.02, 0)
    }):Play();
    TweenService:Create(Sphere, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        Transparency = 0.45
    }):Play();
    TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(1, Enum.EasingStyle.Sine), {
        FarIntensity = 1,
        FocusDistance = 35.62
    }):Play();
    VfxManager.Enable(u22.Clouds, true);
    VfxManager.Enable(u22.Laugh, true);
    VfxManager.Enable(u21.CameraAtmosphere, true);
    VfxManager.Emit(u22.slide);
    task.delay(0.883 - u10, function() -- Line: 265
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.ballhit1);
    end);
    task.delay(0.883 - u10, function() -- Line: 272
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.ballhit1);
    end);
    task.delay(1.45 - u10, function() -- Line: 279
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.ballhit2);
    end);
    task.delay(2.433 - u10, function() -- Line: 286
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.ballhit);
        VfxManager.Enable(u22.Clouds, false);
        VfxManager.Enable(u22.Laugh, false);
        VfxManager.Enable(u22.ballflare, true);
    end);
    task.delay(4.25 - u10, function() -- Line: 296
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), game_Lighting (copy), u18 (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0.9;
        TweenService:Create(Sphere, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Emit(u22.excla);
    end);
    task.delay(5.267 - u10, function() -- Line: 316
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), VfxManager (ref), u22 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0.9;
        TweenService:Create(Sphere, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        VfxManager.Enable(u22.ballflare, false);
        VfxManager.Enable(u21.CameraAtmosphere, false);
        VfxManager.Enable(u21.CameraAtmosphere, false);
        VfxManager.Enable(u21.camstart, true);
        VfxManager.Enable(u22.Clouds2, true);
        VfxManager.Enable(u22.Laugh2, true);
    end);
    task.delay(5.45 - u10, function() -- Line: 331
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step1);
    end);
    task.delay(5.65 - u10, function() -- Line: 338
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step2);
    end);
    task.delay(5.833 - u10, function() -- Line: 345
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step3);
    end);
    task.delay(6.033 - u10, function() -- Line: 352
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step4);
    end);
    task.delay(6.25 - u10, function() -- Line: 359
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step5);
    end);
    task.delay(6.45 - u10, function() -- Line: 366
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step6);
    end);
    task.delay(6.65 - u10, function() -- Line: 373
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.step7);
    end);
    task.delay(6.817 - u10, function() -- Line: 380
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.enabledhakilast);
        VfxManager.Emit(u21.DunkCameraVertical);
    end);
    task.delay(6.85 - u10, function() -- Line: 389
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Enable(u21.camstart, false);
        VfxManager.Emit(u22.questionmark);
    end);
    task.delay(8.233 - u10, function() -- Line: 407
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u22.Clouds2, false);
        VfxManager.Enable(u22.Laugh2, false);
    end);
    task.delay(8.733 - u10, function() -- Line: 415
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.CameraTransition);
    end);
    task.delay(9.4 - u10, function() -- Line: 422
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.CameraAtmosphere, true);
        VfxManager.Enable(u22.aura, true);
    end);
    task.delay(10.4 - u10, function() -- Line: 431
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.chargeup);
        VfxManager.Emit(u22.aura);
    end);
    task.delay(10.767 - u10, function() -- Line: 439
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.ballgrab);
    end);
    task.delay(12.9 - u10, function() -- Line: 446
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.balldunkhit);
    end);
    task.delay(13.85 - u10, function() -- Line: 453
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u22 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 23, 66);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Emit(u22.ballgrab2);
        VfxManager.Enable(u21.DunkCameraVertical, true);
    end);
    task.delay(14.75 - u10, function() -- Line: 471
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraVertical, false);
    end);
    task.delay(15.933 - u10, function() -- Line: 478
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy), u22 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Emit(u21.CAMATMO);
        VfxManager.Enable(u22.auralast, true);
        VfxManager.Enable(Model, true);
    end);

    local function v23() -- Line: 498
        -- upvalues: u17 (ref), Folder (copy), VfxManager (ref), u18 (ref), u19 (ref), u16 (copy), Highlight (copy), u15 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy)
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

        if u18 then
            u18:Pause();
        end;

        if u19 then
            u19:Pause();
        end;

        if u16 then
            u16:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            VfxManager.DestroyEffect(u15, 2);
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
        Atmosphere.Density = Density;
        Atmosphere.Glare = Glare;
        Atmosphere.Decay = Decay;
        Atmosphere.Offset = Offset;
        Atmosphere.Haze = Haze;
        Atmosphere.Color = Color;
        Bloom.Threshold = Threshold;
        Bloom.Size = Size;
        Bloom.Intensity = Intensity;
        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v23));
    table.insert(u17, Folder.Destroying:Connect(v23));
end;
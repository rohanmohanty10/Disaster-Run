 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
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
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), TweenService (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local v7 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v8 = p6.Task == "Cleanup" and Debris:FindFirstChild(v7);

        if v8 then
            v8:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u9 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 65
        -- upvalues: u5 (copy), u11 (ref), u10 (ref), u9 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u9;
        end;

        u10 = u10 + p12 * 60;
        local v13 = script_Fov[math.ceil(u10)];

        if v13 ~= nil then
            if math.ceil(u10) >= #script_Fov then
                u11:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v13, p12 * 6);
        end;
    end);
    task.delay(17.833 - u9, function() -- Line: 84
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);
    local u14 = SfxManager:playSound({
        Sound = "SPIDER AWAKENING",
        Parent = workspace
    });
    u14.TimePosition = u9;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = {};
    local game_Lighting = game.Lighting;
    game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u16 = nil;
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;
    local u20 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local _ = DepthOfField.FarIntensity;
    local _ = DepthOfField.FocusDistance;
    local _ = DepthOfField.InFocusRadius;
    local _ = DepthOfField.NearIntensity;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local _ = Atmosphere.Density;
    local _ = Atmosphere.Color;
    local _ = Atmosphere.Offset;
    local _ = Atmosphere.Haze;
    local _ = Atmosphere.Decay;
    local _ = Atmosphere.Glare;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local _ = Bloom.Intensity;
    local _ = Bloom.Size;
    local _ = Bloom.Threshold;
    local _ = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(17.833, function() -- Line: 144
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u21 = script.Camera_VFX:Clone();
    u21:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u21.Parent = Folder;
    u21.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u21.PrimaryPart, CamRig.camera);
    local u22 = script.Vignette:Clone();
    u22.Parent = PlayerGui;
    u22.Enabled = true;
    local _ = u22.Vignette;
    local _ = u22.Vignette1;
    local _ = u22.BottomFrame;
    local _ = u22.TopFrame;
    local SolidColor = u22.SolidColor;
    local _ = u22.StarVignette;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local u23 = child:Clone();
            u23.CFrame = Char:FindFirstChild(child.Name).CFrame;
            u23.Parent = Model;
            Essentials:Weld(u23, Char:FindFirstChild(child.Name));
            VfxManager.Enable(u23, false);
            task.delay(29, function() -- Line: 175
                -- upvalues: u23 (copy)
                u23:Destroy();
            end);
        end;
    end;

    local u24 = script.BALL:Clone();
    u24.CFrame = BALL.CFrame;
    u24.Parent = Folder;
    Essentials:Weld(u24, BALL);
    local u25 = script.Cutscene_VFX:Clone();
    u25:PivotTo(HumanoidRootPart.CFrame);
    u25.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    VfxManager.Enable(u21.CameraAtmosphere, true);
    task.delay(2.467 - u9, function() -- Line: 207
        -- upvalues: Folder (copy), game_Lighting (copy), u16 (ref), TweenService (ref), u17 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy), u25 (copy), u24 (copy), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 106, 255);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u16:Play();
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u17:Play();
        VfxManager.Enable(u21.CameraAtmosphere, false);
        VfxManager.Emit(u25.ballgrab);
        VfxManager.Enable(u24, true);
        VfxManager.Enable(Model, true);
        task.wait(0.016666666666666666);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, true);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u16:Play();
    end);
    task.delay(4.533 - u9, function() -- Line: 239
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), SolidColor (copy), TweenService (ref), u17 (ref), game_Lighting (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, false);
        SolidColor.ImageTransparency = 0;
        TweenService:Create(SolidColor, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u17:Play();
        VfxManager.Enable(u21.camend, true);
        VfxManager.Emit(u25.ballgrab2);
    end);
    task.delay(4.767 - u9, function() -- Line: 255
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, false);
        VfxManager.Emit(u25.Trip);
    end);
    task.delay(5.233 - u9, function() -- Line: 263
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.spin);
    end);
    task.delay(6.383 - u9, function() -- Line: 271
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u16 (ref), TweenService (ref), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, true);
        VfxManager.Enable(u21.camend, true);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u16:Play();
    end);
    task.delay(6.683 - u9, function() -- Line: 283
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy), u21 (copy), SolidColor (copy), TweenService (ref), u17 (ref), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.ballgrab3);
        VfxManager.Enable(u21.DunkCameraHorizontal, false);
        SolidColor.ImageTransparency = 0;
        TweenService:Create(SolidColor, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u17:Play();
        VfxManager.Enable(u21.camend, true);
        VfxManager.Emit(u25.ballgrab2);
    end);
    task.delay(6.8 - u9, function() -- Line: 298
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.camend, false);
    end);
    task.delay(9.983 - u9, function() -- Line: 305
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.step);
    end);
    task.delay(10.45 - u9, function() -- Line: 312
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.step);
    end);
    task.delay(11.017 - u9, function() -- Line: 319
        -- upvalues: Folder (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u25.jump);
    end);
    task.delay(11.367 - u9, function() -- Line: 326
        -- upvalues: Folder (copy), game_Lighting (copy), u16 (ref), TweenService (ref), u17 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy), u24 (copy), Model (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 106, 255);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u16:Play();
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u17:Play();
        VfxManager.Enable(u21.CameraAtmosphere, true);
        VfxManager.Enable(u24, true);
        VfxManager.Enable(Model["Left Arm"].second, true);
        VfxManager.Emit(u25.ballgrab3);
    end);
    task.delay(12.1 - u9, function() -- Line: 346
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy), Model (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 106, 255);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Enable(u21.CameraAtmosphere, false);
        VfxManager.Enable(Model["Left Arm"].second, false);
        VfxManager.Emit(u25.ballhit);
    end);
    task.delay(13.967 - u9, function() -- Line: 366
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), u16 (ref), TweenService (ref), game_Lighting (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, true);
        u16 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u16:Play();
    end);
    task.delay(15.5 - u9, function() -- Line: 376
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy), SolidColor (copy), TweenService (ref), u20 (ref), game_Lighting (copy), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u21.DunkCameraHorizontal, false);
        SolidColor.ImageTransparency = 0;
        TweenService:Create(SolidColor, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u20:Play();
        VfxManager.Enable(u21.camend, true);
        VfxManager.Emit(u25.ballgrab2);
    end);
    task.delay(15.883 - u9, function() -- Line: 390
        -- upvalues: Folder (copy), game_Lighting (copy), u18 (ref), TweenService (ref), u19 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u25 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(60, 106, 255);
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u18:Play();
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u19:Play();
        VfxManager.Emit(u25.Score);
    end);

    local function v26() -- Line: 408
        -- upvalues: u15 (ref), Folder (copy), VfxManager (ref), u16 (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u22 (copy), Highlight (copy), u14 (copy), LightingController (ref)
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

        if u20 then
            u20:Pause();
        end;

        if u22 then
            u22:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u14 then
            VfxManager.DestroyEffect(u14, 2);
        end;

        LightingController:ResetLighting(0.001);
        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v26));
    table.insert(u15, Folder.Destroying:Connect(v26));
end;
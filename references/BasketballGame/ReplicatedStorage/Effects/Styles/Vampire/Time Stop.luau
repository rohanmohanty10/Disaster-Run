 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
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
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), Effects (copy), LocalPlayer (copy), Debris (copy), TweenService (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local u8 = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(u8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u10 = workspace:GetServerTimeNow() - p6.previousTime + p6.passedTime;
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 65
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
    task.delay(5.167 - u10, function() -- Line: 84
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local u15 = SfxManager:playSound({
        Sound = "DioTimestop",
        Parent = workspace
    });
    u15.TimePosition = u10;
    task.delay(2.6 - u10, function() -- Line: 90
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "<animation style=\"glitch\">TIME STOP!!</animation>", 2 }
        });
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = {};
    local game_Lighting = game.Lighting;
    game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u17 = nil;
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

    if Debris:FindFirstChild(u8) then
        Debris:FindFirstChild(u8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = u8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(5.167, function() -- Line: 154
        -- upvalues: Folder (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local v18 = script.Camera_VFX:Clone();
    v18:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    v18.Parent = Folder;
    v18.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(v18.PrimaryPart, CamRig.camera);
    local u19 = script.Vignette:Clone();
    u19.Parent = PlayerGui;
    u19.Enabled = true;
    local _ = u19.Vignette;
    local _ = u19.Vignette1;
    local _ = u19.BottomFrame;
    local _ = u19.TopFrame;
    local _ = u19.SolidColor;
    local _ = u19.StarVignette;
    Instance.new("Model").Parent = Folder;
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
    game_Lighting.ColorCorrection.Brightness = 1;
    game_Lighting.ColorCorrection.Contrast = 2;
    game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
    local u21 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = -0.015,
        Contrast = 0.2
    });
    u21:Play();
    local u22 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
        TintColor = Color3_fromRGB_ret
    });
    u22:Play();
    VfxManager.Emit(v18.CameraAtmosphere);
    task.delay(2.517 - u10, function() -- Line: 223
        -- upvalues: Folder (copy), game_Lighting (copy), u21 (ref), TweenService (ref), u22 (ref), Color3_fromRGB_ret (copy), u17 (ref), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u21 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u21:Play();
        u22 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u22:Play();
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u17:Play();
        VfxManager.Emit(u20.timestop);
    end);
    task.delay(3.9 - u10, function() -- Line: 243
        -- upvalues: Folder (copy), game_Lighting (copy), u21 (ref), TweenService (ref), u22 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u21 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u21:Play();
        u22 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u22:Play();
        VfxManager.Emit(u20.dribble1);
    end);
    task.delay(4.417 - u10, function() -- Line: 259
        -- upvalues: Folder (copy), game_Lighting (copy), u21 (ref), TweenService (ref), u22 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u20 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u21 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u21:Play();
        u22 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u22:Play();
        VfxManager.Emit(u20.dribble1);
    end);
    task.delay(5.5, function() -- Line: 276
        -- upvalues: Debris (ref), u8 (copy)
        local v23 = Debris:FindFirstChild(u8);

        if v23 then
            v23:SetAttribute("Active", nil);
        end;
    end);
    task.delay(10 - u10, function() -- Line: 283
        -- upvalues: game_Lighting (copy)
        game_Lighting.ColorCorrection.Brightness = 0.05;
        game_Lighting.ColorCorrection.Contrast = 0.1;
        game_Lighting.ColorCorrection.Saturation = 0.3;
    end);

    local function v24() -- Line: 293
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u21 (ref), u22 (ref), u17 (ref), u19 (copy), Highlight (copy), u15 (copy), LightingController (ref), u7 (copy)
        for _, v in u16 do
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

        if u21 then
            u21:Pause();
        end;

        if u22 then
            u22:Pause();
        end;

        if u17 then
            u17:Pause();
        end;

        if u19 then
            u19:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            VfxManager.DestroyEffect(u15, 2);
        end;

        LightingController:ResetLighting(0.001);
        VfxManager.ModelTransparency(u7.Character, 0);
        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v24));
    table.insert(u16, Folder.Destroying:Connect(v24));
end;
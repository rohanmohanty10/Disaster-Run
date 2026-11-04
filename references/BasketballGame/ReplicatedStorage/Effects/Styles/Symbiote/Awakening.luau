 
 

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
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Debris (copy), TweenService (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;
    local u7 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
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
    task.delay(20.833 - u10, function() -- Line: 84
        -- upvalues: u12 (ref)
        u12:Disconnect();
    end);
    local u15 = SfxManager:playSound({
        Sound = "BBZ Symbiote Awakening V2",
        Parent = workspace
    });
    u15.TimePosition = u10;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u16 = {};
    local game_Lighting = game.Lighting;
    game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
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

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(20.833, function() -- Line: 144
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
    u21.PrimaryPart.CFrame = CamRig.CamPart.CFrame;
    Essentials:Weld(u21.PrimaryPart, CamRig.camera);
    local u22 = script.Vignette:Clone();
    u22.Parent = PlayerGui;
    u22.Enabled = true;
    local _ = u22.Vignette;
    local _ = u22.Vignette1;
    local _ = u22.BottomFrame;
    local _ = u22.TopFrame;
    local _ = u22.SolidColor;
    local _ = u22.StarVignette;
    Instance.new("Model").Parent = Folder;
    local u23 = script.Cutscene_VFX:Clone();
    u23:PivotTo(HumanoidRootPart.CFrame);
    u23.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    local u24 = script.Face:Clone();
    u24.CFrame = Head.CFrame;
    u24.Parent = Folder;
    Essentials:Weld(u24, Head);
    local u25 = script.Face1:Clone();
    u25.CFrame = Head.CFrame;
    u25.Parent = Folder;
    Essentials:Weld(u25, Head);
    u23.Sphere.Transparency = 0.45;
    TweenService:Create(u23.Sphere, TweenInfo.new(2.25 - u10), {
        Transparency = 0.85
    }):Play();
    task.delay(2.25 - u10, function() -- Line: 220
        -- upvalues: Folder (copy), TweenService (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u23.Sphere, TweenInfo.new(4.217), {
            Transparency = 0.45
        }):Play();
        task.wait(4.217);

        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u23.Sphere, TweenInfo.new(5.066), {
            Transparency = 0.7
        }):Play();
    end);
    task.delay(2.233 - u10, function() -- Line: 235
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Enable(u23.firstphaseaura, true);
    end);
    task.delay(5.267 - u10, function() -- Line: 252
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u25 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.mouthaura, true);
        VfxManager.Enable(u25, true);
        VfxManager.Enable(u21.CameraAtmosphere, true);
        VfxManager.Emit(u23.auraemit);
    end);
    task.delay(6.95 - u10, function() -- Line: 262
        -- upvalues: Folder (copy), VfxManager (ref), u23 (copy), u25 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u23.mouthaura, false);
        VfxManager.Enable(u25, false);
        VfxManager.Enable(u21.CameraAtmosphere, false);
        VfxManager.Enable(u23.firstphaseaura, false);
    end);
    task.delay(8.133 - u10, function() -- Line: 272
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u23.fall);
    end);
    task.delay(11.917 - u10, function() -- Line: 289
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Enable(u21.DunkCameraSparks, true);
    end);
    task.delay(12.117 - u10, function() -- Line: 306
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u23.wakeup);
        VfxManager.Enable(u23.aura, true);
    end);
    task.delay(12.217 - u10, function() -- Line: 324
        -- upvalues: Folder (copy), game_Lighting (copy), u19 (ref), TweenService (ref), u20 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u19 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u19:Play();
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u20:Play();
        VfxManager.Emit(u23.emit2);
    end);
    task.delay(14.933 - u10, function() -- Line: 340
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u21.DunkCameraVertical);
    end);
    task.delay(16.433 - u10, function() -- Line: 357
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy), u21 (copy), u24 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u23.roarvfx);
        VfxManager.Enable(u21.CameraAtmosphere, true);
        VfxManager.Enable(u24, true);
    end);
    task.delay(17.833 - u10, function() -- Line: 377
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u23 (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(0, 0, 0);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u23.auraemit);
        VfxManager.Enable(u21.CameraAtmosphere, false);
    end);

    local function v26() -- Line: 396
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u17 (ref), u18 (ref), u19 (ref), u20 (ref), u22 (copy), Highlight (copy), u15 (copy), LightingController (ref), u7 (copy)
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

        if u15 then
            VfxManager.DestroyEffect(u15, 2);
        end;

        LightingController:ResetLighting(0.001);
        VfxManager.ModelTransparency(u7.Character, 0);
        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v26));
    table.insert(u16, Folder.Destroying:Connect(v26));
end;
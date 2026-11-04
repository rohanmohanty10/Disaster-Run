 
 

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
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), SfxManager (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p6.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
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
    task.delay(5 - u9, function() -- Line: 84
        -- upvalues: u11 (ref)
        u11:Disconnect();
    end);
    local u14 = SfxManager:playSound({
        Sound = "BBZ Rubber HakiDominance cutscene",
        Parent = workspace
    });
    u14.TimePosition = u9;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local Vignette = u15.Vignette;
    local _ = u15.Vignette1;
    local _ = u15.BottomFrame;
    local _ = u15.TopFrame;
    local _ = u15.SolidColor;
    local StarVignette = u15.StarVignette;
    local u16 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u17 = nil;
    local u18 = nil;
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

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(5, function() -- Line: 150
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
            local u19 = child:Clone();
            u19.CFrame = Char:FindFirstChild(child.Name).CFrame;
            u19.Parent = Model;
            Essentials:Weld(u19, Char:FindFirstChild(child.Name));
            VfxManager.Enable(u19, false);
            task.delay(5, function() -- Line: 169
                -- upvalues: u19 (copy)
                u19:Destroy();
            end);
        end;
    end;

    local u20 = script.Camera_VFX:Clone();
    u20:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u20.Parent = Folder;
    u20.PrimaryPart.CFrame = CamRig.CamPart.CFrame;
    Essentials:Weld(u20.PrimaryPart, CamRig.camera);
    local u21 = script.Cutscene_VFX:Clone();
    u21:PivotTo(HumanoidRootPart.CFrame);
    u21.Parent = Folder;
    local Sphere = u21.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    task.delay(1.117 - u9, function() -- Line: 197
        -- upvalues: Folder (copy), u17 (ref), TweenService (ref), ColorCorrection (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.383, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 145, 145)
        });
        u17:Play();
    end);
    task.delay(1.2 - u9, function() -- Line: 205
        -- upvalues: Folder (copy), Atmosphere (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        Atmosphere.Color = Color3.fromRGB(255, 92, 92);
    end);
    task.delay(2.883 - u9, function() -- Line: 212
        -- upvalues: Folder (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Color (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        Atmosphere.Color = Color;
    end);
    game_Lighting.Bloom.Intensity = 1.35;
    Vignette.ZIndex = 0;
    Vignette.ImageColor3 = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        ImageColor3 = Color3.fromRGB(124, 101, 74)
    }):Play();
    Sphere.Transparency = 1;
    StarVignette.ImageTransparency = 1;
    task.delay(0.15 - u9, function() -- Line: 231
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.ballhit);
    end);
    task.delay(0.283 - u9, function() -- Line: 238
        -- upvalues: Folder (copy), VfxManager (ref), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u21.step1);
    end);
    task.delay(1.183 - u9, function() -- Line: 245
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), u20 (copy), Model (copy), u21 (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Emit(u20.CAMATMO);
        VfxManager.Enable(Model, true);
        VfxManager.Emit(u21.Hakiemit);
        VfxManager.Emit(u21.Hakienabled);
    end);
    task.delay(2.883 - u9, function() -- Line: 266
        -- upvalues: Folder (copy), game_Lighting (copy), u17 (ref), TweenService (ref), u18 (ref), Color3_fromRGB_ret (copy), VfxManager (ref), Model (copy)
        if Folder == nil then
            return;
        end;

        if Folder:GetAttribute("Active") == nil then
            return;
        end;

        game_Lighting.ColorCorrection.Brightness = 1;
        game_Lighting.ColorCorrection.Contrast = 2;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(255, 255, 255);
        u17 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2
        });
        u17:Play();
        u18 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
        VfxManager.Enable(Model, false);
    end);

    local function v22() -- Line: 283
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u17 (ref), u18 (ref), u15 (copy), Highlight (copy), u14 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy), Bloom (copy), Threshold (copy), Size (copy), Intensity (copy)
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

        if u15 then
            u15:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u14 then
            VfxManager.DestroyEffect(u14, 2);
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
        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v22));
    table.insert(u16, Folder.Destroying:Connect(v22));
end;
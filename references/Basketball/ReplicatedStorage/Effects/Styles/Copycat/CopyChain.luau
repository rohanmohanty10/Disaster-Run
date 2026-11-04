 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 17
    task.delay(p2, function() -- Line: 18
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

function Emit(p3, p4)
    for _, descendant in p3:GetDescendants() do
        if descendant:IsA("ParticleEmitter") ~= false then
            if descendant:GetAttribute("EmitDelay") == nil or descendant:GetAttribute("EmitDelay") <= 0 then
                if descendant:GetAttribute("EmitDuration") == nil or descendant:GetAttribute("EmitDuration") <= 0 then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                else
                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 39
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            else
                task.delay(descendant:GetAttribute("EmitDelay") - p4, function() -- Line: 27
                    -- upvalues: descendant (copy)
                    if descendant:GetAttribute("EmitDuration") == nil or descendant:GetAttribute("EmitDuration") <= 0 then
                        descendant:Emit(descendant:GetAttribute("EmitCount"));

                        return;
                    end;

                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 30
                        -- upvalues: descendant (ref)
                        descendant.Enabled = false;
                    end);
                end);
            end;
        end;
    end;
end;

return function(u5, p6) -- Line: 48
    -- upvalues: SfxManager (copy), RunService (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p6.Character;

    if not game.Players:FindFirstChild(Character.Name) then
        game.Players:GetPlayerFromCharacter(Character);
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    local u7 = workspace:GetServerTimeNow() - p6.TimeSent;
    local v8 = Character.Name .. script.Parent.Name .. script.Name;

    if p6.Task ~= "Cutscene" then
        local v9 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v9 then
            v9:SetAttribute("Active", nil);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "CopyChain",
        Parent = workspace
    });
    local script_Fov = require(script.Fov);
    local u10 = 0;
    local u11 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u11 = RunService.RenderStepped:Connect(function(p12) -- Line: 69
        -- upvalues: u5 (copy), u11 (ref), u10 (ref), u7 (copy), script_Fov (copy), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u11:Disconnect();

            return;
        end;

        if u10 <= 0 then
            u10 = p12 * 60 * u7;
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
    task.delay(10.933, function() -- Line: 88
        -- upvalues: u11 (ref)
        if u11 then
            u11:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v8) then
        Debris:FindFirstChild(v8):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local _ = workspace.Courts2.Court;
    local Folder = Instance.new("Folder");
    Folder.Name = v8;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(10.933, function() -- Line: 103
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = false;
    local Vignette = u14.Vignette;
    local Vignette1 = u14.Vignette1;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local Color = Atmosphere.Color;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(255, 41, 127);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Character;
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u15.Parent = Folder;
    u15.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u16 = {};
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;
    local u20 = nil;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Character:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Character:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Character:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

    Emit(Model, u7);
    local v22 = script.Cutscene_VFX:Clone();
    v22:PivotTo(HumanoidRootPart.CFrame);
    v22.Parent = Folder;
    Emit(v22, u7);

    for i = 1, 3 do
        local v23 = script:FindFirstChild("BALL" .. i):Clone();
        v23.CFrame = BALL.CFrame;
        v23.Parent = Folder;
        Essentials:Weld(v23, BALL);
        Emit(v23, u7);
        local _ = i;
    end;

    task.delay(0.567 - u7, function() -- Line: 195
        -- upvalues: Folder (copy), u14 (copy), Highlight (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u17 (ref), u18 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u14.Enabled = true;
        Highlight.OutlineColor = Color3.fromRGB(60, 255, 57);
        ColorCorrection.TintColor = Color3.fromRGB(75, 255, 132);
        ColorCorrection.Brightness = 0.5;
        Vignette1.ImageColor3 = Color3.fromRGB(80, 255, 71);
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Saturation = 0.3
        });
        u18:Play();
    end);
    task.delay(1.733 - u7, function() -- Line: 216
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), ColorCorrection (copy), Vignette1 (copy), u17 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 10;
        TweenService:Create(BlurEffect, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.255);
        ColorCorrection.TintColor = Color3.fromRGB(255, 61, 61);
        ColorCorrection.Brightness = 0.25;
        Vignette1.ImageColor3 = Color3.fromRGB(115, 14, 14);
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
    end);
    task.delay(2.117 - u7, function() -- Line: 231
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u19 (ref), DepthOfField (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(39, 68, 255)
        }):Play();
        u19 = TweenService:Create(DepthOfField, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 28.08
        });
        u19:Play();
        TweenService:Create(Vignette, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25,
            ImageColor3 = Color3.fromRGB(14, 15, 72)
        }):Play();
    end);
    task.delay(5.517 - u7, function() -- Line: 242
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), VfxManager (ref), u15 (copy), ColorCorrection (copy), Vignette (copy), game_Lighting (copy), Vignette1 (copy), u17 (ref), u18 (ref), u20 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(75, 44, 139)
        }):Play();
        VfxManager.Enable(u15.DunkCameraSlants, true);
        VfxManager.Enable(u15.CameraAtmosphere, true);
        ColorCorrection.TintColor = Color3.fromRGB(181, 97, 255);
        ColorCorrection.Brightness = 0.5;
        Vignette.ImageColor3 = Color3.fromRGB(181, 97, 255);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        TweenService:Create(Vignette1, TweenInfo.new(1.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u17:Play();
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u18:Play();
        u20 = TweenService:Create(ColorCorrection, TweenInfo.new(2.5, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u20:Play();
    end);
    task.delay(8.433 - u7, function() -- Line: 270
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), game_Lighting (copy), TweenService (ref), Highlight (copy), u19 (ref), DepthOfField (copy), Vignette1 (copy), Vignette (copy), ColorCorrection (copy), u17 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u15.DunkCameraSlants, false);
        VfxManager.Enable(u15.CameraAtmosphere, false);
        VfxManager.Enable(u15.DunkCameraVertical, true);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 14;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        Highlight.OutlineColor = Color3.fromRGB(255, 43, 128);
        Highlight.FillTransparency = 0.5;
        Highlight.FillColor = Color3.fromRGB(255, 41, 127);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u19 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FocusDistance = 90,
            FarIntensity = 1
        });
        u19:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 28, 138);
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(1.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(2.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        ColorCorrection.Brightness = 0.2;
        ColorCorrection.Contrast = 0.4;
        ColorCorrection.Saturation = 1;
        ColorCorrection.TintColor = Color3.fromRGB(255, 79, 111);
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(1.75, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3_fromRGB_ret
        });
        u17:Play();
    end);

    local function v24() -- Line: 305
        -- upvalues: u16 (ref), Folder (copy), VfxManager (ref), u17 (ref), u18 (ref), u20 (ref), u14 (copy), u19 (ref), Highlight (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Color (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u16 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u17 then
            u17:Pause();
        end;

        if u18 then
            u18:Pause();
        end;

        if u20 then
            u20:Pause();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u19 then
            u19:Pause();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Atmosphere.Density = Density;
        Atmosphere.Color = Color;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v24));
    table.insert(u16, Folder.Destroying:Connect(v24));
end;
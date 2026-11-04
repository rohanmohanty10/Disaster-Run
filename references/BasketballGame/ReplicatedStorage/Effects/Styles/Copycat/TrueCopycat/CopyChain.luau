 
 

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
    local u9 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);

    if p6.Task ~= "Cutscene" then
        local v10 = p6.Task == "Cleanup" and Debris:FindFirstChild(v8);

        if v10 then
            v10:SetAttribute("Active", nil);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "CopyChain",
        Parent = workspace
    });
    local script_Fov = require(script.Fov);
    local u11 = 0;
    local u12 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u12 = RunService.RenderStepped:Connect(function(p13) -- Line: 71
        -- upvalues: u5 (copy), u12 (ref), u11 (ref), u7 (copy), script_Fov (copy), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u5.MovementController.States.Ability == false then
            u12:Disconnect();

            return;
        end;

        if u11 <= 0 then
            u11 = p13 * 60 * u7;
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
    task.delay(10.933, function() -- Line: 90
        -- upvalues: u12 (ref)
        if u12 then
            u12:Disconnect();
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
    task.delay(10.933, function() -- Line: 105
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = false;
    local Vignette = u15.Vignette;
    local Vignette1 = u15.Vignette1;
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
    Highlight.FillColor = u9 or Color3.fromRGB(255, 41, 127);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Character;
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    u16.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local Model = Instance.new("Model");
    Model.Parent = Folder;
    local u17 = nil;
    local u18 = nil;
    local u19 = nil;
    local u20 = nil;
    local u21 = {};

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Character:FindFirstChild(child.Name) then
            local v22 = child:Clone();
            v22.CFrame = Character:FindFirstChild(child.Name).CFrame;
            v22.Parent = Model;
            Essentials:Weld(v22, Character:FindFirstChild(child.Name));
            VfxManager.Enable(v22, false);
        end;
    end;

    Emit(Model, u7);
    local v23 = script.Cutscene_VFX:Clone();
    v23:PivotTo(HumanoidRootPart.CFrame);
    v23.Parent = Folder;
    Emit(v23, u7);

    for i = 1, 3 do
        local v24 = script:FindFirstChild("BALL" .. i):Clone();
        v24.CFrame = BALL.CFrame;
        v24.Parent = Folder;
        Essentials:Weld(v24, BALL);
        Emit(v24, u7);
        local _ = i;
    end;

    task.delay(0.567 - u7, function() -- Line: 197
        -- upvalues: Folder (copy), u15 (copy), Highlight (copy), u9 (copy), ColorCorrection (copy), Vignette1 (copy), Vignette (copy), TweenService (ref), u18 (ref), u19 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u15.Enabled = true;
        Highlight.OutlineColor = u9 or Color3.fromRGB(60, 255, 57);
        ColorCorrection.TintColor = u9 or Color3.fromRGB(75, 255, 132);
        ColorCorrection.Brightness = 0.5;
        Vignette1.ImageColor3 = u9 or Color3.fromRGB(80, 255, 71);
        Vignette.ImageTransparency = 0;
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u18:Play();
        u19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Saturation = 0.3
        });
        u19:Play();
    end);
    task.delay(1.733 - u7, function() -- Line: 218
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), ColorCorrection (copy), Vignette1 (copy), u18 (ref)
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
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u18:Play();
    end);
    task.delay(2.117 - u7, function() -- Line: 233
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u9 (copy), u20 (ref), DepthOfField (copy), Vignette (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            OutlineColor = u9 or Color3.fromRGB(39, 68, 255)
        }):Play();
        u20 = TweenService:Create(DepthOfField, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 28.08
        });
        u20:Play();
        TweenService:Create(Vignette, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.25,
            ImageColor3 = u9 or Color3.fromRGB(14, 15, 72)
        }):Play();
    end);
    task.delay(5.517 - u7, function() -- Line: 244
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), u9 (copy), VfxManager (ref), u16 (copy), ColorCorrection (copy), Vignette (copy), game_Lighting (copy), Vignette1 (copy), u18 (ref), u19 (ref), u17 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            OutlineColor = u9 or Color3.fromRGB(75, 44, 139)
        }):Play();
        VfxManager.Enable(u16.DunkCameraSlants, true);
        VfxManager.Enable(u16.CameraAtmosphere, true);
        ColorCorrection.TintColor = u9 or Color3.fromRGB(181, 97, 255);
        ColorCorrection.Brightness = 0.5;
        Vignette.ImageColor3 = u9 or Color3.fromRGB(181, 97, 255);
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
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u18:Play();
        u19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u19:Play();
        u17 = TweenService:Create(ColorCorrection, TweenInfo.new(2.5, Enum.EasingStyle.Sine), {
            Saturation = -1
        });
        u17:Play();
    end);
    task.delay(8.433 - u7, function() -- Line: 272
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), game_Lighting (copy), TweenService (ref), Highlight (copy), u9 (copy), u20 (ref), DepthOfField (copy), Vignette1 (copy), Vignette (copy), ColorCorrection (copy), u18 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.DunkCameraSlants, false);
        VfxManager.Enable(u16.CameraAtmosphere, false);
        VfxManager.Enable(u16.DunkCameraVertical, true);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 14;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        Highlight.OutlineColor = u9 or Color3.fromRGB(255, 43, 128);
        Highlight.FillTransparency = 0.5;
        Highlight.FillColor = u9 or Color3.fromRGB(255, 41, 127);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u20 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FocusDistance = 90,
            FarIntensity = 1
        });
        u20:Play();
        Vignette1.ImageColor3 = u9 or Color3.fromRGB(255, 28, 138);
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
        ColorCorrection.TintColor = u9 or Color3.fromRGB(255, 79, 111);
        u18 = TweenService:Create(ColorCorrection, TweenInfo.new(1.75, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3,
            TintColor = Color3_fromRGB_ret
        });
        u18:Play();
    end);

    local function v25() -- Line: 307
        -- upvalues: u21 (ref), Folder (copy), VfxManager (ref), u18 (ref), u19 (ref), u17 (ref), u15 (copy), u20 (ref), Highlight (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Color (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u21 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u18 then
            u18:Pause();
        end;

        if u19 then
            u19:Pause();
        end;

        if u17 then
            u17:Pause();
        end;

        if u15 then
            u15:Destroy();
        end;

        if u20 then
            u20:Pause();
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
        u21 = nil;
    end;

    table.insert(u21, Folder.AttributeChanged:Connect(v25));
    table.insert(u21, Folder.Destroying:Connect(v25));
end;
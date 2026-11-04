 
 

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
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), Effects (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u4 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 37
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
    task.delay(9.617 - u4, function() -- Line: 56
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.617, function() -- Line: 106
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u12 = SfxManager:playSound({
        Sound = "BBZ perfect awakening cutscene",
        Parent = workspace
    });
    task.delay(3, function() -- Line: 114
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "You\'re either perfect...", 2 }
        });
    end);
    task.delay(7.5, function() -- Line: 120
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "...or you\'re not me.", 2 }
        });
    end);
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u13.Parent = Folder;
    u13.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u13.PrimaryPart);
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette = u14.Vignette;
    local Vignette1 = u14.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v15 = child:Clone();
            v15.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v15, false);
        end;
    end;

    local u16 = script.Cutscene_VFX:Clone();
    u16:PivotTo(HumanoidRootPart.CFrame);
    u16.Parent = Folder;
    local Sphere = u16.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local v17 = script.HeadAura:Clone();
    v17.CFrame = Head.CFrame;
    v17.Parent = Folder;
    Essentials:Weld(v17, Head);
    VfxManager.Enable(u16.Specs, true);
    local u18 = TweenService:Create(DepthOfField, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {
        FarIntensity = 1,
        FocusDistance = 90
    });
    u18:Play();
    ColorCorrection.Saturation = -1;
    Highlight.OutlineTransparency = 0;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    TweenService:Create(Highlight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
        FillTransparency = 1
    }):Play();
    local u19 = TweenService:Create(ColorCorrection, TweenInfo.new(1.25, Enum.EasingStyle.Circular), {
        Saturation = 0.3
    });
    u19:Play();
    Sphere.Transparency = 0;
    TweenService:Create(Sphere, TweenInfo.new(2, Enum.EasingStyle.Sine), {
        Transparency = 0.85
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", game_Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 1.5);
    Vignette1.ImageTransparency = 0;
    Vignette.ImageTransparency = 0;
    TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        ImageTransparency = 0.5
    }):Play();
    TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Linear), {
        ImageTransparency = 0.5
    }):Play();
    task.delay(0.3 - u4, function() -- Line: 201
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), Vignette1 (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(33, 55, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u16.PerfectDribble);
    end);
    task.delay(0.917 - u4, function() -- Line: 214
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), Vignette1 (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(33, 55, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u16.PerfectDribble);
    end);
    task.delay(1.633 - u4, function() -- Line: 226
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), Vignette1 (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(52, 255, 66);
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u16.PerfectDribble);
    end);
    task.delay(2.4 - u4, function() -- Line: 238
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), Vignette1 (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(52, 255, 66);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u16.PerfectDribble);
    end);
    task.delay(3.233 - u4, function() -- Line: 249
        -- upvalues: Folder (copy), Sphere (copy), TweenService (ref), Vignette1 (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.85
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(33, 55, 255);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u16.PerfectDribble);
    end);
    task.delay(5.917 - u4, function() -- Line: 261
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), Highlight (copy), Model (copy), u16 (copy), u18 (ref), TweenService (ref), game_Lighting (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u13.CamImpact);
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(255, 255, 255);
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u16.Enable, true);
        VfxManager.Emit(u16.HILEANDRE);
        u18 = TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(2.5, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 10.53
        });
        u18:Play();
    end);
    task.delay(6 - u4, function() -- Line: 281
        -- upvalues: Folder (copy), Sphere (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Highlight (copy), Vignette1 (copy), u19 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0;
        local BlurEffect2 = Instance.new("BlurEffect", game_Lighting);
        BlurEffect2.Size = 15;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.555);
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game_Lighting);
        ColorCorrectionEffect.Brightness = -0.3;
        ColorCorrectionEffect.Contrast = 7;
        ColorCorrectionEffect.Saturation = 0.3;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(39, 68, 255);
        ColorCorrectionEffect.Enabled = true;
        Highlight.FillTransparency = 0.25;
        Highlight.FillColor = Color3.fromRGB(255, 209, 23);
        Highlight.OutlineColor = Color3.fromRGB(255, 223, 41);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 190, 24);
        Vignette1.ImageTransparency = 0.5;
        task.delay(0.05, function() -- Line: 302
            -- upvalues: ColorCorrectionEffect (copy), u19 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Sphere (ref), Highlight (ref), Vignette1 (ref)
            ColorCorrectionEffect.Enabled = false;
            ColorCorrectionEffect:Destroy();
            u19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u19:Play();
            TweenService:Create(Sphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                Transparency = 1
            }):Play();
            TweenService:Create(Highlight, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
                FillTransparency = 1,
                FillColor = Color3.fromRGB(0, 0, 0)
            }):Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
                ImageTransparency = 0.65
            }):Play();
        end);
        TweenService:Create(Vignette, TweenInfo.new(1.35, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(8.038 - u4, function() -- Line: 318
        -- upvalues: Folder (copy), TweenService (ref), Sphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Transparency = 0.65
        }):Play();
    end);

    local function v20() -- Line: 324
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u19 (ref), u18 (ref), u14 (copy), Highlight (copy), u12 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        for _, v in u11 do
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

        if u19 then
            u19:Pause();
        end;

        if u18 then
            u18:Pause();
        end;

        if u14 then
            u14:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u12 then
            VfxManager.DestroyEffect(u12, 2);
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Atmosphere.Density = Density;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v20));
    table.insert(u11, Folder.Destroying:Connect(v20));
end;
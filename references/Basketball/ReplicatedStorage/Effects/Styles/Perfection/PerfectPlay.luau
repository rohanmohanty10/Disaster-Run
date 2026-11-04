 
 

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
local Debris = workspace:FindFirstChild("Debris");
local LocalPlayer = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 18
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 38
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
    task.delay(9.75 - u3, function() -- Line: 57
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u11 = nil;
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
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

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.75, function() -- Line: 109
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = SfxManager:playSound({
        Sound = "BBZ perfect sync dunk awk move",
        Parent = workspace
    });
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    u16.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = false;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v18 = child:Clone();
            v18.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v18.Parent = Model;
            Essentials:Weld(v18, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v18, false);
        end;
    end;

    local u19 = script.Cutscene_VFX:Clone();
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.Parent = Folder;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(27, 53, 140);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Char;
    local v20 = script.EyeFX:Clone();
    v20.CFrame = Head.CFrame;
    v20.Parent = Folder;
    Essentials:Weld(v20, Head);
    local u21 = script.BALL:Clone();
    u21.CFrame = BALL.CFrame;
    u21.Parent = Folder;
    Essentials:Weld(u21, BALL);
    local u22 = TweenService:Create(DepthOfField, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
        FarIntensity = 0.1,
        FocusDistance = 49.12
    });
    u22:Play();
    TweenService:Create(u19.FX.Sphere, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
        Transparency = 1
    }):Play();
    VfxManager.Enable(v20.Enabling, true);
    task.delay(0.117 - u3, function() -- Line: 175
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), Highlight (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX.Dribbles.Dribble);
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.5;
        Highlight.FillColor = Color3.fromRGB(56, 255, 42);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(0.717 - u3, function() -- Line: 185
        -- upvalues: VfxManager (ref), u19 (copy)
        VfxManager.Emit(u19.FX.Dribbles.Dribble2);
    end);
    task.delay(0.983 - u3, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX.Dribbles.Dribble3);
    end);
    task.delay(0.517 - u3, function() -- Line: 196
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX.Dribbles.Dribble4);
    end);
    task.delay(1.683 - u3, function() -- Line: 202
        -- upvalues: Folder (copy), Highlight (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(1.783 - u3, function() -- Line: 212
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (ref), ColorCorrection (copy), u12 (ref), Color3_fromRGB_ret (copy), u17 (copy), Vignette1 (copy), u13 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u11:Play();
        task.delay(0.05, function() -- Line: 224
            -- upvalues: Folder (ref), u12 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), u17 (ref), Vignette1 (ref), u13 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u12:Play();
            u17.Enabled = true;
            TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.355, function() -- Line: 232
                -- upvalues: Folder (ref), u12 (ref), TweenService (ref), ColorCorrection (ref), u13 (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                    Contrast = 0.2
                });
                u12:Play();
                u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u13:Play();
            end);
        end);
    end);
    task.delay(2.083 - u3, function() -- Line: 243
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), Vignette1 (copy), Highlight (copy), u22 (ref), DepthOfField (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        u22 = TweenService:Create(DepthOfField, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 49.12
        });
        u22:Play();
        TweenService:Create(u19.FX.Sphere, TweenInfo.new(1.25, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
    end);
    task.delay(2.85 - u3, function() -- Line: 257
        -- upvalues: Folder (copy), TweenService (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u19.FX.Sphere, TweenInfo.new(0.18, Enum.EasingStyle.Linear), {
            Transparency = 0.1
        }):Play();
    end);
    task.delay(3.017 - u3, function() -- Line: 263
        -- upvalues: Folder (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(39, 89, 255);
        ColorCorrection.TintColor = Color3.fromRGB(47, 109, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(3.05 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), TweenService (ref), DepthOfField (copy), u19 (copy), VfxManager (ref), u16 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(DepthOfField, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 15.2
        }):Play();
        TweenService:Create(u19.FX.Sphere, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {
            Transparency = 1
        }):Play();
        VfxManager.Emit(u16.CamImpact);
        VfxManager.Enable(Model, true);
    end);
    task.delay(3.183 - u3, function() -- Line: 293
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), u21 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.FX2.Specs, true);
        VfxManager.Enable(u21, true);
    end);
    task.delay(3.483 - u3, function() -- Line: 300
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX.Grab);
    end);
    task.delay(3.55 - u3, function() -- Line: 306
        -- upvalues: Folder (copy), Highlight (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.5;
        Highlight.FillColor = Color3.fromRGB(85, 116, 255);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(3.95 - u3, function() -- Line: 314
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX2.Dribbles.Dribble);
    end);
    task.delay(4.317 - u3, function() -- Line: 320
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX2.Dribbles.Dribble1);
    end);
    task.delay(4.45 - u3, function() -- Line: 326
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.FX.Spin, true);
    end);
    task.delay(4.783 - u3, function() -- Line: 333
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.FX.Spin, false);
        task.wait(0.03333333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX2.Dribbles.Dribble2);
    end);
    task.delay(5.8 - u3, function() -- Line: 343
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), u21 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX2.Jump);
        VfxManager.Enable(u21, false);
    end);
    task.delay(5.93 - u3, function() -- Line: 350
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (ref), ColorCorrection (copy), u12 (ref), Color3_fromRGB_ret (copy), Vignette1 (copy), u13 (ref), u14 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u11:Play();
        task.delay(0.05, function() -- Line: 362
            -- upvalues: Folder (ref), u12 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), u13 (ref), u14 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u12:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.01, function() -- Line: 369
                -- upvalues: Folder (ref), u13 (ref), TweenService (ref), ColorCorrection (ref), u14 (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                    Contrast = 0.2
                });
                u13:Play();
                u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.4, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u14:Play();
            end);
        end);
    end);
    task.delay(6.2 - u3, function() -- Line: 380
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.FX2.AirSpecs, true);
    end);
    task.delay(6.45 - u3, function() -- Line: 386
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.DunkCameraVertical, true);
    end);
    task.delay(6.8 - u3, function() -- Line: 392
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), Highlight (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.FX2.AirSpecs, false);
        VfxManager.Enable(u19.StarFlashs, true);
        u19.StarFlashs.Attachment.Beam.Enabled = true;
        task.wait(0.03333333333333333);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight.FillTransparency = 0.5;
        Highlight.FillColor = Color3.fromRGB(255, 191, 28);
        TweenService:Create(Highlight, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(6.983 - u3, function() -- Line: 414
        -- upvalues: Folder (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(39, 89, 255);
        ColorCorrection.TintColor = Color3.fromRGB(47, 109, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.016666666666666666);

        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.DunkCameraVertical, false);
    end);
    task.delay(7.83 - u3, function() -- Line: 441
        -- upvalues: Folder (copy), TweenService (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(u19.FX.Sphere, TweenInfo.new(0.07, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
    end);
    task.delay(7.85 - u3, function() -- Line: 446
        -- upvalues: Folder (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u19.StarFlashs.Attachment.Beam.Enabled = false;
    end);
    task.delay(7.9 - u3, function() -- Line: 452
        -- upvalues: Folder (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u19.StarFlashs.Attachment.Beam.Enabled = false;
    end);
    task.delay(8.13 - u3, function() -- Line: 458
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.FX2.Dunk);
        Vignette1.ImageColor3 = Color3.fromRGB(39, 89, 255);
        ColorCorrection.TintColor = Color3.fromRGB(47, 109, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u13:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);

    local function v23() -- Line: 480
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u22 (ref), u17 (copy), Highlight (copy), u15 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u11 then
            u11:Pause();
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

        if u22 then
            u22:Pause();
        end;

        if u17 then
            u17:Destroy();
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
        Atmosphere.Density = Density;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v23));
    table.insert(u10, Folder.Destroying:Connect(v23));
end;
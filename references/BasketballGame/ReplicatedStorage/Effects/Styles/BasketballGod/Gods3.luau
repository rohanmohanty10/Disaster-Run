 
 

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

return function(u1, p2) -- Line: 19
    -- upvalues: RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;

    if not game.Players:FindFirstChild(Char.Name) then
        game.Players:GetPlayerFromCharacter(Char);
    end;

    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local other = p2.other;
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
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 40
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
    task.delay(14.683 - u3, function() -- Line: 59
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
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u15 = nil;
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local u16 = nil;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(14.683, function() -- Line: 110
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u17 = SfxManager:playSound({
        Sound = "BBZ BasketballGod Gods Three",
        Parent = workspace
    });
    local u18 = script.BALL:Clone();
    u18.CFrame = BALL.CFrame;
    u18.Parent = Folder;
    Essentials:Weld(u18, BALL);
    VfxManager.Enable(u18, true);
    local u19 = script.Camera_VFX:Clone();
    u19:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u19.Parent = Folder;
    u19.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u19.PrimaryPart, CamRig.camera);
    local u20 = script.Vignette:Clone();
    u20.Parent = PlayerGui;
    u20.Enabled = true;
    local Vignette = u20.Vignette;
    local Vignette1 = u20.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v21 = child:Clone();
            v21.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v21.Parent = Model;
            Essentials:Weld(v21, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v21, false);
        end;
    end;

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
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight2.OutlineTransparency = 1;
    Highlight2.Parent = other;
    local Car = workspace:FindFirstChild("Car");
    local Highlight3 = Instance.new("Highlight");
    Highlight3.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight3.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight3.FillTransparency = 1;
    Highlight3.OutlineColor = Color3.new(0, 0, 0);
    Highlight3.OutlineTransparency = 1;
    Highlight3.Parent = Car;
    Bloom.Intensity = 1;
    Bloom.Threshold = 1.334;
    ColorCorrection.Contrast = 0.5;
    task.delay(0.233 - u3, function() -- Line: 191
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble0);
        u22.Dribble0.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble0.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(0.55 - u3, function() -- Line: 199
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble1);
        u22.Dribble1.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble1.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(0.95 - u3, function() -- Line: 207
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble2);
        u22.Dribble2.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble2.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(1.6 - u3, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref), Model (copy), u18 (copy), u19 (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), Color3_fromRGB_ret (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble3);
        u22.Dribble3.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble3.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
        VfxManager.Enable(Model, true);
        VfxManager.Enable(u18, true);
        VfxManager.Enable(u19.CameraAtmosphere.Background, true);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 192, 67);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        ColorCorrection.Brightness = 0.65;
        ColorCorrection.TintColor = Color3.fromRGB(255, 193, 105);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            TintColor = Color3_fromRGB_ret
        });
        u11:Play();
    end);
    task.delay(2.33 - u3, function() -- Line: 235
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble4);
        u22.Dribble4.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble4.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(2.85 - u3, function() -- Line: 243
        -- upvalues: Folder (copy), Sphere (copy), Highlight (copy), Highlight2 (copy), VfxManager (ref), u22 (copy), TweenService (ref), u19 (copy), u15 (ref), DepthOfField (copy), Vignette1 (copy), game_Lighting (copy), ColorCorrection (copy), u11 (ref), u12 (ref), u13 (ref), Color3_fromRGB_ret (copy), Vignette (copy), u14 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 0.3;
        Highlight.OutlineTransparency = 0;
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight2.OutlineTransparency = 0;
        Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
        VfxManager.Emit(u22.Dribble5);
        u22.Dribble5.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble5.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
        VfxManager.Enable(u22.SpaceZone, true);
        u22.SpaceZone.Transparency = 0;
        VfxManager.Enable(u19.DunkCameraHorizontal, true);
        u15 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            FarIntensity = 1,
            FocusDistance = 31.58
        });
        u15:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 160, 51);
        Vignette1.ImageTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        ColorCorrection.TintColor = Color3.fromRGB(172, 119, 26);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(216, 139, 51)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u12:Play();
        task.delay(0.05, function() -- Line: 278
            -- upvalues: Folder (ref), u13 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), Vignette (ref), u14 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u13:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.225, Enum.EasingStyle.Linear), {
                ImageTransparency = 0.5,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            TweenService:Create(Vignette, TweenInfo.new(0.225, Enum.EasingStyle.Linear), {
                ImageTransparency = 0
            }):Play();
            task.delay(0.255, function() -- Line: 286
                -- upvalues: Folder (ref), u14 (ref), TweenService (ref), ColorCorrection (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.255, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u14:Play();
            end);
        end);
    end);
    task.delay(4.25 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref), Sphere (copy), u19 (copy), u15 (ref), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), Vignette1 (copy), game_Lighting (copy), ColorCorrection (copy), u11 (ref), u12 (ref), u13 (ref), Color3_fromRGB_ret (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble6);
        u22.Dribble6.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble6.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
        TweenService:Create(Sphere, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        VfxManager.Enable(u22.SpaceZone, false);
        u22.SpaceZone.Transparency = 1;
        VfxManager.Enable(u19.CameraAtmosphere.Background, false);
        VfxManager.Enable(u19.DunkCameraHorizontal, false);
        u15 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            FarIntensity = FarIntensity,
            FocusDistance = FocusDistance
        });
        u15:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 160, 51);
        Vignette1.ImageTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        ColorCorrection.TintColor = Color3.fromRGB(172, 119, 26);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {
            TintColor = Color3.fromRGB(216, 139, 51)
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Saturation = 0.3
        });
        u12:Play();
        task.delay(0.05, function() -- Line: 327
            -- upvalues: Folder (ref), u13 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), Vignette (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u13:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.525, Enum.EasingStyle.Linear), {
                ImageTransparency = 0.5,
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            TweenService:Create(Vignette, TweenInfo.new(0.825, Enum.EasingStyle.Linear), {
                ImageTransparency = 0
            }):Play();
        end);
    end);
    task.delay(5.183 - u3, function() -- Line: 338
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u22 (copy), Sphere (copy), ColorCorrection (copy), Vignette1 (copy), u11 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        VfxManager.Emit(u22.FallFX);
        Sphere.Transparency = 0.2;
        TweenService:Create(Sphere, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        ColorCorrection.TintColor = Color3.fromRGB(255, 61, 61);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 61, 61);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u11:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(6.35 - u3, function() -- Line: 360
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble7);
        u22.Dribble7.Light.PointLight.Brightness = 6;
        TweenService:Create(u22.Dribble7.Light.PointLight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end);
    task.delay(7.083 - u3, function() -- Line: 369
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u15 (ref), DepthOfField (copy), Vignette1 (copy), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 25;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.355);
        u15 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            FarIntensity = 1
        });
        u15:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 160, 43);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Emit(u22.Jump);
    end);
    task.delay(7.633 - u3, function() -- Line: 386
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), u15 (ref), TweenService (ref), DepthOfField (copy), FarIntensity (copy), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Model, false);
        u15 = TweenService:Create(DepthOfField, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            FarIntensity = FarIntensity
        });
        u15:Play();
        VfxManager.Emit(u22.Shoot);
    end);
    task.delay(7.983 - u3, function() -- Line: 397
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Landing);
    end);
    task.delay(9.183 - u3, function() -- Line: 403
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.CameraAtmosphere, true);
        Vignette1.ImageColor3 = Color3.fromRGB(206, 160, 44);
    end);
    task.delay(10.217 - u3, function() -- Line: 410
        -- upvalues: Folder (copy), VfxManager (ref), Car (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(Car, true);
    end);
    task.delay(10.533 - u3, function() -- Line: 416
        -- upvalues: Folder (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), Vignette1 (copy), VfxManager (ref), u19 (copy), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        ColorCorrection.Brightness = 0.6;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u11:Play();
        Vignette1.ImageColor3 = Color3.fromRGB(255, 166, 58);
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u19.CameraAtmosphere, false);
        VfxManager.Emit(u22.CarHitFX);
    end);
    task.delay(12.35 - u3, function() -- Line: 430
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), Model (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), Color3_fromRGB_ret (copy), Vignette (copy), Vignette1 (copy), Highlight (copy), u16 (ref), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.GoalFX);
        VfxManager.Enable(Model, true);
        ColorCorrection.Brightness = 0.35;
        ColorCorrection.TintColor = Color3.fromRGB(255, 166, 102);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(1.155, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u13:Play();
        Vignette.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 165, 56);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 1,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            OutlineTransparency = 1
        }):Play();
        u16 = TweenService:Create(Bloom, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Intensity = Intensity,
            Size = Size,
            Threshold = Threshold
        });
        u16:Play();
    end);

    local function v23() -- Line: 458
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u20 (copy), Car (copy), Highlight (copy), Highlight2 (copy), u16 (ref), u17 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u15 then
            u15:Pause();
        end;

        if u20 then
            u20:Destroy();
        end;

        if Car then
            Car:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        if u16 then
            u16:Pause();
        end;

        if u17 then
            u17:Destroy();
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
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v23));
    table.insert(u10, Folder.Destroying:Connect(v23));
end;
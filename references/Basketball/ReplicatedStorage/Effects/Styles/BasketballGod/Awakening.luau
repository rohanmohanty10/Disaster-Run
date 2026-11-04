 
 

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

return function(u1, p2) -- Line: 19
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), LocalPlayer (copy), Debris (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p2.Char;
    local u3 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Head = Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Char:FindFirstChild("BALL", true);
    local TimeSent = p2.TimeSent;
    local u4 = workspace:GetServerTimeNow() - TimeSent;
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(8.5 - u4, function() -- Line: 35
        -- upvalues: Effects (ref), u3 (copy)
        Effects:SubtitleV2({
            { u3, "I\'ll show you animals <animation style=\"glitch\">REAL</animation> basketball!", 3.5 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 48
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
    task.delay(13.35 - u4, function() -- Line: 67
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u11 = {};
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u12 = nil;
    local u13 = nil;
    local u14 = nil;
    local u15 = nil;
    local u16 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u17 = nil;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(13.35, function() -- Line: 110
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u18 = SfxManager:playSound({
        Sound = "BBZ BasketballGod Awakening",
        Parent = workspace
    });
    u18.TimePosition = u4;
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
    local _ = u22.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    local v23 = script.HeadFX:Clone();
    v23.CFrame = Head.CFrame;
    v23.Parent = Folder;
    Essentials:Weld(v23, Head);
    VfxManager.Enable(v23, false);
    local Car = workspace:FindFirstChild("Car");
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.new(0, 0, 0);
    Highlight2.OutlineTransparency = 1;
    Highlight2.Parent = Car;
    task.delay(0.5 - u4, function() -- Line: 179
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble_0);
    end);
    task.delay(1.167 - u4, function() -- Line: 185
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy), TweenService (ref), game_Lighting (copy), Highlight (copy), Highlight2 (copy), ColorCorrection (copy), u12 (ref), Vignette1 (copy), Vignette (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Dribble_1);
        TweenService:Create(game_Lighting, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ClockTime = 3.021
        }):Play();
        Highlight.FillTransparency = 0;
        Highlight.OutlineTransparency = 1;
        Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
        Highlight2.FillTransparency = 0;
        Highlight2.OutlineTransparency = 0;
        Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        ColorCorrection.Brightness = 0.45;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Saturation = -1
        });
        u12:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        VfxManager.Enable(u19.CameraAtmosphere.CameraAtmosphereAttachment, true);
    end);
    task.delay(2.133 - u4, function() -- Line: 210
        -- upvalues: Folder (copy), Highlight (copy), Highlight2 (copy), game_Lighting (copy), TweenService (ref), Vignette1 (copy), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.FillTransparency = 0;
        Highlight.OutlineTransparency = 1;
        Highlight2.FillTransparency = 0;
        Highlight2.OutlineTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Name = "BASKETBALLGODBLUR";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        }):Play();
    end);
    task.delay(2.967 - u4, function() -- Line: 225
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Car (copy), u19 (copy), ColorCorrection (copy), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy), Vignette (copy), Vignette1 (copy), u17 (ref), DepthOfField (copy), Highlight (copy), Highlight2 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BASKETBALLGODBLUR = game_Lighting:FindFirstChild("BASKETBALLGODBLUR");
        BASKETBALLGODBLUR.Size = 15;
        TweenService:Create(BASKETBALLGODBLUR, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BASKETBALLGODBLUR, 0.455);

        for _, child in Car["Plane.006"].FX.Lights:GetChildren() do
            if child:IsA("SurfaceLight") then
                local Range = child.Range;
                local Brightness = child.Brightness;
                local Angle = child.Angle;
                child.Range = 0;
                child.Brightness = 0;
                child.Angle = 0;
                child.Enabled = true;
                TweenService:Create(child, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
                    Range = Range,
                    Brightness = Brightness,
                    Angle = Angle
                }):Play();
            end;
        end;

        VfxManager.Enable(u19.CameraAtmosphere, false);
        VfxManager.Enable(Car["Plane.006"].FX, true);
        VfxManager.Emit(Car["Plane.006"].FXEmit);
        ColorCorrection.Brightness = 0.85;
        ColorCorrection.TintColor = Color3.fromRGB(255, 166, 102);
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u13:Play();
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(1.155, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u14:Play();
        Vignette.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 165, 56);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        }):Play();
        u17 = TweenService:Create(DepthOfField, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            FarIntensity = 1
        });
        u17:Play();
        TweenService:Create(Highlight, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineTransparency = 0
        }):Play();
        TweenService:Create(Highlight2, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(3.983 - u4, function() -- Line: 270
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u19 (copy), ColorCorrection (copy), u15 (ref), u16 (ref), Color3_fromRGB_ret (copy), Vignette1 (copy), Vignette (copy), Highlight (copy), Highlight2 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        VfxManager.Enable(u19.CameraAtmosphere.CameraAtmosphereAttachment, false);
        u19.CameraAtmosphere.CameraLines.Enabled = true;
        u19.CameraAtmosphere.Lines.Enabled = true;
        ColorCorrection.Brightness = 0.85;
        ColorCorrection.TintColor = Color3.fromRGB(255, 166, 102);
        u15 = TweenService:Create(ColorCorrection, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Brightness = -0.015
        });
        u15:Play();
        u16 = TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u16:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(243, 148, 39)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.255, Enum.EasingStyle.Linear), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
            FillTransparency = 0.8,
            FillColor = Color3.fromRGB(255, 199, 56)
        }):Play();
        TweenService:Create(Highlight2, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
            FillTransparency = 1
        }):Play();
    end);
    task.delay(5.017 - u4, function() -- Line: 298
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), game_Lighting (copy), TweenService (ref), ColorCorrection (copy), u12 (ref), Highlight2 (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u19.CameraAtmosphere, false);
        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Name = "BASKETBALLGODBLUR";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 10
        }):Play();
        ColorCorrection.Brightness = 0.65;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Saturation = -1,
            Brightness = -0.5
        });
        u12:Play();
        TweenService:Create(Highlight2, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            OutlineTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(6.183 - u4, function() -- Line: 317
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy), game_Lighting (copy), ClockTime (copy), ColorCorrection (copy), VfxManager (ref), u12 (ref), Highlight2 (copy), Vignette1 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            FillTransparency = 1
        }):Play();
        TweenService:Create(game_Lighting, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            ClockTime = ClockTime
        }):Play();
        ColorCorrection.Brightness = 0.7;
        local BASKETBALLGODBLUR = game_Lighting:FindFirstChild("BASKETBALLGODBLUR");
        TweenService:Create(BASKETBALLGODBLUR, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BASKETBALLGODBLUR, 0.655);
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Saturation = 0.3
        });
        u12:Play();
        TweenService:Create(Highlight2, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            OutlineTransparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            FillTransparency = 1
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(255, 211, 99)
        }):Play();
    end);
    task.delay(10.767 - u4, function() -- Line: 337
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Stomp1);
    end);
    task.delay(10.9 - u4, function() -- Line: 343
        -- upvalues: Folder (copy), VfxManager (ref), u22 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u22.Stomp2);
    end);

    local function v24() -- Line: 350
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), u13 (ref), u14 (ref), u15 (ref), u16 (ref), u17 (ref), u20 (copy), Car (copy), Highlight (copy), u18 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), game_Lighting (copy), ClockTime (copy)
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

        if u16 then
            u16:Pause();
        end;

        if u17 then
            u17:Pause();
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

        if u18 then
            u18:Destroy();
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
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v24));
    table.insert(u11, Folder.Destroying:Connect(v24));
end;
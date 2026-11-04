 
 

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

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 18
    task.delay(p2, function() -- Line: 19
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 24
    -- upvalues: Effects (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), SfxManager (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p4.Char;
    local u5 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local Char2 = p4.Char;
    local HumanoidRootPart = Char2:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u6 = workspace:GetServerTimeNow() - p4.TimeSent;
    local v7 = Char.Name .. script.Parent.Name .. script.Name;

    if p4.Task ~= "Cutscene" then
        local v8 = p4.Task == "Cleanup" and Debris:FindFirstChild(v7);

        if v8 then
            v8:SetAttribute("Active", nil);
        end;

        return;
    end;

    task.delay(0.25, function() -- Line: 39
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Nobody ever cares about defense...", 2 }
        });
    end);
    task.delay(9, function() -- Line: 45
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "That\'s why I love it!", 2.5 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 54
        -- upvalues: u3 (copy), u10 (ref), u9 (ref), u6 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u6;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(13, function() -- Line: 73
        -- upvalues: u10 (ref)
        if u10 then
            u10:Disconnect();
        end;
    end);

    if Debris:FindFirstChild(v7) then
        Debris:FindFirstChild(v7):Destroy();
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = {};
    local u14 = {};
    local Folder = Instance.new("Folder");
    Folder.Name = v7;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.683, function() -- Line: 89
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = SfxManager:playSound({
        Sound = "lock awakening",
        Parent = workspace
    });
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u16.Parent = Folder;
    u16.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local u17 = script.EyeFX:Clone();
    u17.CFrame = Char2:FindFirstChild("Head").CFrame;
    u17.Parent = Folder;
    Essentials:Weld(u17, Char2:FindFirstChild("Head"));
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = false;
    local Vignette = u18.Vignette;
    local Vignette1 = u18.Vignette1;
    local u19 = script.Cutscene_VFX:Clone();
    u19:PivotTo(HumanoidRootPart.CFrame);
    u19.Parent = Folder;
    local Sphere = u19.Sphere;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.new(1, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Char2;
    local game_Lighting = game.Lighting;
    local ColorCorrection = game_Lighting:FindFirstChild("ColorCorrection");
    local Color3_fromRGB_ret = Color3.fromRGB(255, 255, 255);
    local u20 = nil;
    local Atmosphere = game_Lighting:FindFirstChild("Atmosphere");
    local Density = Atmosphere.Density;
    local u21 = nil;
    local DepthOfField = game_Lighting:FindFirstChild("DepthOfField");
    local FarIntensity = DepthOfField.FarIntensity;
    local FocusDistance = DepthOfField.FocusDistance;
    local InFocusRadius = DepthOfField.InFocusRadius;
    local NearIntensity = DepthOfField.NearIntensity;
    local u22 = nil;
    task.delay(0.233 - u6, function() -- Line: 155
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy), u20 (ref), TweenService (ref), game_Lighting (copy), Sphere (copy), Highlight (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19["HEFELL!"]);
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.1,
            Contrast = -0.1,
            Saturation = -0.3
        });
        u20:Play();
        TweenService:Create(Sphere, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Transparency = 0
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(1.267 - u6, function() -- Line: 167
        -- upvalues: Folder (copy), u20 (ref), TweenService (ref), ColorCorrection (copy), u18 (copy), Sphere (copy), Vignette (copy), Vignette1 (copy), VfxManager (ref), u19 (copy), u16 (copy), u21 (ref), Atmosphere (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u20 = TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            Brightness = -0.2,
            Contrast = 0.5,
            Saturation = -1
        });
        u20:Play();
        u18.Enabled = true;
        Sphere.Transparency = 0.5;
        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        VfxManager.Enable(u19.Ink, true);
        VfxManager.Enable(u16.PassCamera1, true);
        u21 = TweenService:Create(Atmosphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Density = 0.833
        });
        u21:Play();
        TweenService:Create(Vignette1, TweenInfo.new(2, Enum.EasingStyle.Quint), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(2, Enum.EasingStyle.Quint), {
            ImageTransparency = 0,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(2.583 - u6, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u19 (copy), u22 (ref), TweenService (ref), game_Lighting (copy), u21 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.PassCamera1, false);
        VfxManager.Enable(u19.Ink, false);
        u22 = TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(1, Enum.EasingStyle.Quint), {
            FarIntensity = 1,
            FocusDistance = 115.78,
            InFocusRadius = 25.875
        });
        u22:Play();
        u21 = TweenService:Create(game_Lighting.Atmosphere, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
            Density = 0.447
        });
        u21:Play();
    end);
    task.delay(7.167 - u6, function() -- Line: 204
        -- upvalues: Folder (copy), Highlight (copy), Sphere (copy), game_Lighting (copy), VfxManager (ref), u16 (copy), u17 (copy), u19 (copy), Char2 (copy), Essentials (ref), u14 (copy), Vignette (copy), TweenService (ref), u20 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Highlight.OutlineColor = Color3.fromRGB(122, 14, 255);
        Sphere.Transparency = 1;
        game_Lighting.ColorCorrection.Brightness = 0.4;
        game_Lighting.ColorCorrection.Contrast = 0.5;
        game_Lighting.ColorCorrection.Saturation = -1;
        game_Lighting.ColorCorrection.TintColor = Color3.fromRGB(122, 14, 255);
        VfxManager.Emit(u16.DunkCameraVertical);
        VfxManager.Emit(u17.Emit);
        VfxManager.Enable(u17.Enabling, true);
        VfxManager.Enable(u19.LineGroundFlame, true);
        VfxManager.Enable(u19.Intensitylines, true);
        VfxManager.Enable(u19.SphereFX, true);
        u17.Attachment.SpotLight.Enabled = true;

        for _, child in script.AuraBodyWelds:GetChildren() do
            if Char2:FindFirstChild(child.Name) then
                local v23 = child:Clone();
                v23.CFrame = Char2:FindFirstChild(child.Name).CFrame;
                v23.Parent = Folder;
                Essentials:Weld(v23, Char2:FindFirstChild(child.Name));
                VfxManager.Enable(v23, true);
                table.insert(u14, v23);
            end;
        end;

        Vignette.ImageColor3 = Color3.fromRGB(86, 34, 255);
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.1,
            Contrast = -0.1,
            Saturation = -0.3,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        u20:Play();
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(8.333 - u6, function() -- Line: 250
        -- upvalues: Folder (copy), Sphere (copy), VfxManager (ref), u19 (copy), u22 (ref), TweenService (ref), game_Lighting (copy), u21 (ref), Density (copy), u20 (ref), Vignette (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Sphere.Transparency = 1;
        VfxManager.Enable(u19.LineGroundFlame, false);
        VfxManager.Emit(u19.BreakFree);
        u22 = TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 15.78,
            InFocusRadius = 0
        });
        u22:Play();
        u21 = TweenService:Create(game_Lighting.Atmosphere, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Density = Density
        });
        u21:Play();
        u20 = TweenService:Create(game_Lighting.ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = -0.015,
            Contrast = 0.2,
            Saturation = 0.3
        });
        u20:Play();
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(86, 34, 255)
        }):Play();
    end);
    task.delay(9.533 - u6, function() -- Line: 270
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Enable(u16.DunkCameraVertical, false);
    end);
    local u24 = false;
    task.delay(11.683 - u6, function() -- Line: 277
        -- upvalues: Folder (copy), u24 (ref), u6 (copy), u15 (copy), VfxManager (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        u24 = true;
        Folder:SetAttribute("Active", nil);
        task.delay(12.683 - (11.683 - u6), function() -- Line: 283
            -- upvalues: u15 (ref), VfxManager (ref)
            if u15 then
                VfxManager.DestroyEffect(u15, 2);
            end;
        end);
    end);

    local function v25() -- Line: 290
        -- upvalues: u13 (ref), Folder (copy), VfxManager (ref), u20 (ref), u21 (ref), u22 (ref), u18 (copy), u24 (ref), u15 (copy), Highlight (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy)
        for _, v in u13 do
            v:Disconnect();
        end;

        if Folder then
            Folder.Name = "_";
            VfxManager.Enable(Folder, false);
            VfxManager.DestroyEffect(Folder, 2);
        end;

        if u20 then
            u20:Pause();
        end;

        if u21 then
            u21:Pause();
        end;

        if u22 then
            u22:Pause();
        end;

        if u18 then
            u18:Destroy();
        end;

        if not u24 and u15 then
            VfxManager.DestroyEffect(u15, 2);
        end;

        if Highlight then
            Highlight:Destroy();
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
        u13 = nil;
    end;

    table.insert(u13, Folder.AttributeChanged:Connect(v25));
    table.insert(u13, Folder.Destroying:Connect(v25));
end;
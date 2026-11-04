 
 

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

    local _ = p2.other;
    Char:FindFirstChild("Head");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local v4 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Activate" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 39
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
    task.delay(3.45 - u3, function() -- Line: 58
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
    local _ = game_Lighting:FindFirstChild("Atmosphere").Density;
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

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.45, function() -- Line: 123
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u14 = SfxManager:playSound({
        Sound = "ACE AWK DUNK SFX BBZ",
        Parent = workspace
    });
    local u15 = script.Camera_VFX:Clone();
    u15:PivotTo(CamRig:FindFirstChild("camera").CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
    u15.Parent = Folder;
    Essentials:Weld(CamRig.camera, u15.PrimaryPart);
    local v16 = script.BALL:Clone();
    v16.CFrame = BALL.CFrame;
    v16.Parent = Folder;
    Essentials:Weld(v16, BALL);
    VfxManager.Enable(v16, false);
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local _ = u17.Vignette;
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
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.FillTransparency = 1;
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.Parent = Char;
    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight2.FillTransparency = 1;
    Highlight2.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight2.OutlineTransparency = 0;
    Highlight2.Parent = BALL;
    Atmosphere.Density = 0.419;
    Atmosphere.Offset = 0.713;
    Atmosphere.Color = Color3.fromRGB(0, 0, 0);
    Atmosphere.Decay = Color3.fromRGB(0, 0, 0);
    Atmosphere.Glare = 0;
    Atmosphere.Haze = 3.64;
    Bloom.Intensity = 0.45;
    Bloom.Size = 24;
    Bloom.Threshold = 2;
    VfxManager.Enable(Model, true);
    VfxManager.Enable(v16, true);
    local u20 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FocusDistance = 60
    });
    u20:Play();
    task.delay(0.4 - u3, function() -- Line: 203
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Throw);
    end);
    task.delay(0.467 - u3, function() -- Line: 209
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble1);
    end);
    task.delay(0.733 - u3, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble2);
    end);
    task.delay(0.933 - u3, function() -- Line: 221
        -- upvalues: Folder (copy), VfxManager (ref), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u19.Dribbles.Dribble3);
    end);
    task.delay(1.2 - u3, function() -- Line: 227
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u11 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Vignette1 (copy), u12 (ref), u13 (ref), u19 (copy), u15 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        task.delay(0.05, function() -- Line: 235
            -- upvalues: Folder (ref), u11 (ref), TweenService (ref), ColorCorrection (ref), Color3_fromRGB_ret (ref), Vignette1 (ref), u12 (ref), u13 (ref)
            if Folder == nil or Folder:GetAttribute("Active") == nil then
                return;
            end;

            u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Linear), {
                Brightness = -0.015,
                TintColor = Color3_fromRGB_ret
            });
            u11:Play();
            TweenService:Create(Vignette1, TweenInfo.new(0.325, Enum.EasingStyle.Linear), {
                ImageColor3 = Color3.fromRGB(0, 0, 0)
            }):Play();
            task.delay(0.01, function() -- Line: 242
                -- upvalues: Folder (ref), u12 (ref), TweenService (ref), ColorCorrection (ref), u13 (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                    Contrast = 0.2
                });
                u12:Play();
                u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u13:Play();
            end);
        end);
        VfxManager.Emit(u19.Jump);
        VfxManager.Enable(u15.CameraAtmosphere, true);
        VfxManager.Enable(u19.AirSpecs, true);
    end);
    task.delay(2.05 - u3, function() -- Line: 258
        -- upvalues: Folder (copy), Vignette1 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), Color3_fromRGB_ret (copy), u12 (ref), u13 (ref), VfxManager (ref), u15 (copy), u19 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = Color3.fromRGB(94, 79, 255);
        ColorCorrection.TintColor = Color3.fromRGB(94, 79, 255);
        ColorCorrection.Brightness = 0.75;
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
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
        VfxManager.Enable(u15.DunkCamera, true);
        VfxManager.Emit(u19.Dunk);
    end);

    local function v21() -- Line: 282
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u20 (ref), u17 (copy), Highlight (copy), Highlight2 (copy), u14 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u20 then
            u20:Pause();
        end;

        if u17 then
            u17:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        Atmosphere.Density = Density;
        Atmosphere.Glare = Glare;
        Atmosphere.Decay = Decay;
        Atmosphere.Offset = Offset;
        Atmosphere.Haze = Haze;
        Atmosphere.Color = Color;
        DepthOfField.FarIntensity = FarIntensity;
        DepthOfField.FocusDistance = FocusDistance;
        DepthOfField.InFocusRadius = InFocusRadius;
        DepthOfField.NearIntensity = NearIntensity;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v21));
    table.insert(u10, Folder.Destroying:Connect(v21));
end;
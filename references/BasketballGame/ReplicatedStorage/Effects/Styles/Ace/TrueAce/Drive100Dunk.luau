 
 

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
    local u4 = script.Parent:GetAttribute("Color") or Color3.fromRGB(255, 255, 255);
    local v5 = Char.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Activate" then
        local v6 = p2.Task == "Cleanup" and Debris:FindFirstChild(v5);

        if v6 then
            v6:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 41
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
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
    task.delay(3.45 - u3, function() -- Line: 60
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

    if Debris:FindFirstChild(v5) then
        Debris:FindFirstChild(v5):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v5;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(3.45, function() -- Line: 125
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u15 = SfxManager:playSound({
        Sound = "ACE AWK DUNK SFX BBZ",
        Parent = workspace
    });
    local u16 = script.Camera_VFX:Clone();
    u16:PivotTo(CamRig:FindFirstChild("camera").CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
    u16.Parent = Folder;
    Essentials:Weld(CamRig.camera, u16.PrimaryPart);
    local v17 = script.BALL:Clone();
    v17.CFrame = BALL.CFrame;
    v17.Parent = Folder;
    Essentials:Weld(v17, BALL);
    VfxManager.Enable(v17, false);
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local _ = u18.Vignette;
    local Vignette1 = u18.Vignette1;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in script.AuraBodyPartsToWeld:GetChildren() do
        if Char:FindFirstChild(child.Name) then
            local v19 = child:Clone();
            v19.CFrame = Char:FindFirstChild(child.Name).CFrame;
            v19.Parent = Model;
            Essentials:Weld(v19, Char:FindFirstChild(child.Name));
            VfxManager.Enable(v19, false);
        end;
    end;

    local u20 = script.Cutscene_VFX:Clone();
    u20:PivotTo(HumanoidRootPart.CFrame);
    u20.Parent = Folder;
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
    VfxManager.Enable(v17, true);
    local u21 = TweenService:Create(DepthOfField, TweenInfo.new(0.01, Enum.EasingStyle.Linear), {
        FocusDistance = 60
    });
    u21:Play();
    task.delay(0.4 - u3, function() -- Line: 205
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Throw);
    end);
    task.delay(0.467 - u3, function() -- Line: 211
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble1);
    end);
    task.delay(0.733 - u3, function() -- Line: 217
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble2);
    end);
    task.delay(0.933 - u3, function() -- Line: 223
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.Dribbles.Dribble3);
    end);
    task.delay(1.2 - u3, function() -- Line: 229
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), u12 (ref), ColorCorrection (copy), Color3_fromRGB_ret (copy), Vignette1 (copy), u13 (ref), u14 (ref), u20 (copy), u16 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.555);
        task.delay(0.05, function() -- Line: 237
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
            task.delay(0.01, function() -- Line: 244
                -- upvalues: Folder (ref), u13 (ref), TweenService (ref), ColorCorrection (ref), u14 (ref)
                if Folder == nil or Folder:GetAttribute("Active") == nil then
                    return;
                end;

                u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Linear), {
                    Contrast = 0.2
                });
                u13:Play();
                u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Linear), {
                    Saturation = -1,
                    Brightness = -0.1
                });
                u14:Play();
            end);
        end);
        VfxManager.Emit(u20.Jump);
        VfxManager.Enable(u16.CameraAtmosphere, true);
        VfxManager.Enable(u20.AirSpecs, true);
    end);
    task.delay(2.05 - u3, function() -- Line: 260
        -- upvalues: Folder (copy), Vignette1 (copy), u4 (copy), ColorCorrection (copy), u12 (ref), TweenService (ref), Color3_fromRGB_ret (copy), u13 (ref), u14 (ref), VfxManager (ref), u16 (copy), u20 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Vignette1.ImageColor3 = u4;
        ColorCorrection.TintColor = u4;
        ColorCorrection.Brightness = 0.75;
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            TintColor = Color3_fromRGB_ret
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.655, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u13:Play();
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Brightness = -0.015
        });
        u14:Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        VfxManager.Enable(u16.DunkCamera, true);
        VfxManager.Emit(u20.Dunk);
    end);

    local function v22() -- Line: 284
        -- upvalues: u11 (ref), Folder (copy), VfxManager (ref), u12 (ref), u13 (ref), u14 (ref), u21 (ref), u18 (copy), Highlight (copy), Highlight2 (copy), u15 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), Atmosphere (copy), Density (copy), Glare (copy), Decay (copy), Offset (copy), Haze (copy), Color (copy), DepthOfField (copy), FarIntensity (copy), FocusDistance (copy), InFocusRadius (copy), NearIntensity (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u21 then
            u21:Pause();
        end;

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if Highlight2 then
            Highlight2:Destroy();
        end;

        if u15 then
            u15:Destroy();
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
        u11 = nil;
    end;

    table.insert(u11, Folder.AttributeChanged:Connect(v22));
    table.insert(u11, Folder.Destroying:Connect(v22));
end;
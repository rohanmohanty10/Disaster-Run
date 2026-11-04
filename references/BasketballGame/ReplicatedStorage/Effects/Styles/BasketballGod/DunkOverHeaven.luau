 
 

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
    Char:FindFirstChild("BALL", true);
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local _ = p2.other;
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
    task.delay(7.9 - u3, function() -- Line: 59
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
    local Bloom = game_Lighting:FindFirstChild("Bloom");
    local Intensity = Bloom.Intensity;
    local Size = Bloom.Size;
    local Threshold = Bloom.Threshold;
    local u15 = nil;
    local ClockTime = game_Lighting.ClockTime;

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(7.9, function() -- Line: 101
        -- upvalues: Folder (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u16 = SfxManager:playSound({
        Sound = "BBZ BasketballGod Gods Dunk",
        Parent = workspace
    });
    local u17 = script.Camera_VFX:Clone();
    u17:PivotTo(CamRig:FindFirstChild("camera").CFrame);
    u17.Parent = Folder;
    u17.PrimaryPart.CFrame = CamRig.camera.CFrame;
    Essentials:Weld(u17.PrimaryPart, CamRig.camera);
    local u18 = script.Vignette:Clone();
    u18.Parent = PlayerGui;
    u18.Enabled = true;
    local Vignette = u18.Vignette;
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
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.Parent = Char;
    ColorCorrection.Saturation = -1;
    ColorCorrection.Brightness = -0.25;
    Vignette1.ImageTransparency = 0;
    Vignette.ImageTransparency = 0;
    task.delay(0.567 - u3, function() -- Line: 155
        -- upvalues: Folder (copy), game_Lighting (copy), TweenService (ref), VfxManager (ref), Vignette1 (copy), Vignette (copy), ColorCorrection (copy), u11 (ref), u12 (ref), u13 (ref), u14 (ref), Color3_fromRGB_ret (copy), Highlight (copy), Bloom (copy), u20 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        Vignette1.ImageColor3 = Color3.fromRGB(255, 165, 56);
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0.5
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5
        }):Play();
        ColorCorrection.Brightness = 0.55;
        ColorCorrection.TintColor = Color3.fromRGB(255, 166, 102);
        u11 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = 0.3
        });
        u11:Play();
        u12 = TweenService:Create(ColorCorrection, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Saturation = 0.5
        });
        u12:Play();
        u13 = TweenService:Create(ColorCorrection, TweenInfo.new(0.555, Enum.EasingStyle.Sine), {
            Brightness = -0.05
        });
        u13:Play();
        u14 = TweenService:Create(ColorCorrection, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            TintColor = Color3_fromRGB_ret
        });
        u14:Play();
        Highlight.OutlineTransparency = 0;
        TweenService:Create(game_Lighting, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            ClockTime = 4
        }):Play();
        Bloom.Intensity = 0.5;
        Bloom.Size = 25;
        Bloom.Threshold = 2.25;
        VfxManager.Emit(u20.JumpStomp1);
        VfxManager.Emit(Model);
    end);
    local u21 = nil;
    task.delay(1.133 - u3, function() -- Line: 195
        -- upvalues: Folder (copy), u20 (copy), Char (copy), LocalPlayer (ref), u21 (ref), RunService (ref), u10 (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        local BodyTrailAura = u20.BodyTrailAura;
        local Torso = Char.Torso;
        BodyTrailAura.Anchored = false;
        local u22 = CFrame.new(0, 0, 0) * CFrame.fromEulerAnglesYXZ(-0, 1.5707963705062866, 0);

        if LocalPlayer.Team.Name == "Away" then
            u22 = CFrame.new(0, 0, 0) * CFrame.fromEulerAnglesYXZ(-0, -1.5707963705062866, 0);
        end;

        u21 = RunService.Heartbeat:Connect(function() -- Line: 207
            -- upvalues: BodyTrailAura (copy), Torso (copy), u22 (ref)
            if BodyTrailAura and Torso then
                BodyTrailAura.CFrame = CFrame.new(Torso.Position) * u22;
            end;
        end);
        table.insert(u10, u21);
    end);
    task.delay(1.167 - u3, function() -- Line: 215
        -- upvalues: Folder (copy), VfxManager (ref), u20 (copy), Model (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u20.JumpStomp1);
        VfxManager.Emit(Model);
        VfxManager.Emit(u20.BodyTrailAura);
    end);
    task.delay(2.033 - u3, function() -- Line: 223
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.CameraAuraFXPOV);
    end);
    task.delay(4.333 - u3, function() -- Line: 229
        -- upvalues: Folder (copy), VfxManager (ref), u17 (copy), u20 (copy), TweenService (ref)
        if Folder == nil or Folder:GetAttribute("Active") == nil then
            return;
        end;

        VfxManager.Emit(u17.DunkCameraHorizontal);

        for _, child in u20.LightingOnDaHoop.Attachment:GetChildren() do
            if child:IsA("SurfaceLight") then
                local Range = child.Range;
                local Brightness = child.Brightness;
                local Angle = child.Angle;
                child.Range = 0;
                child.Brightness = 0;
                child.Angle = 0;
                child.Enabled = true;
                TweenService:Create(child, TweenInfo.new(0.255, Enum.EasingStyle.Sine), {
                    Range = Range,
                    Brightness = Brightness,
                    Angle = Angle
                }):Play();
            end;
        end;
    end);
    task.delay(5.3 - u3, function() -- Line: 245
        -- upvalues: u20 (copy), ColorCorrection (copy), u11 (ref), TweenService (ref), u12 (ref), u13 (ref), Color3_fromRGB_ret (copy), Vignette (copy), Vignette1 (copy), Highlight (copy), VfxManager (ref), game_Lighting (copy), u15 (ref), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
        for _, child in u20.LightingOnDaHoop.Attachment:GetChildren() do
            if child:IsA("SurfaceLight") then
                child.Enabled = false;
            end;
        end;

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
        VfxManager.Emit(u20.LandFX);
        VfxManager.Emit(u20.GoalFX);
        TweenService:Create(game_Lighting, TweenInfo.new(0.65, Enum.EasingStyle.Sine), {
            ClockTime = 12.8
        }):Play();
        u15 = TweenService:Create(Bloom, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Intensity = Intensity,
            Size = Size,
            Threshold = Threshold
        });
        u15:Play();
    end);

    local function v23() -- Line: 280
        -- upvalues: u10 (ref), Folder (copy), VfxManager (ref), u11 (ref), u12 (ref), u13 (ref), u14 (ref), u18 (copy), Highlight (copy), u15 (ref), u16 (copy), ColorCorrection (copy), Color3_fromRGB_ret (copy), game_Lighting (copy), ClockTime (copy), Bloom (copy), Intensity (copy), Size (copy), Threshold (copy)
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

        if u18 then
            u18:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u15 then
            u15:Pause();
        end;

        if u16 then
            u16:Destroy();
        end;

        ColorCorrection.TintColor = Color3_fromRGB_ret;
        ColorCorrection.Contrast = 0.2;
        ColorCorrection.Saturation = 0.3;
        ColorCorrection.Brightness = -0.015;
        game_Lighting.ClockTime = ClockTime;
        Bloom.Intensity = Intensity;
        Bloom.Size = Size;
        Bloom.Threshold = Threshold;
        u10 = nil;
    end;

    table.insert(u10, Folder.AttributeChanged:Connect(v23));
    table.insert(u10, Folder.Destroying:Connect(v23));
end;
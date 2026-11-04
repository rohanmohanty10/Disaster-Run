 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: Players (copy), LocalPlayer (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 36
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "He pulls up for a 3.", 1.5 } });
    end);
    task.delay(2 - u3, function() -- Line: 46
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "And... just short of the rim.", 1.5 } });
    end);
    task.delay(4.5 - u3, function() -- Line: 56
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "And there comes Air flying in miraculous putback dunk for the save!", 5 } });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 69
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
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
    task.delay(7.617 - u3, function() -- Line: 91
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(7.617, function() -- Line: 104
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Air Flying Dunk",
        Parent = workspace
    }).TimePosition = u3;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local v11 = script.Ball:Clone();
    v11.CFrame = BALL.CFrame;
    v11.Parent = Folder;
    Essentials:Weld(v11, BALL);
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local Vignette = u12.Vignette;
    local Vignette1 = u12.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    task.delay(7.617 - u3, function() -- Line: 137
        -- upvalues: u13 (copy), Lighting (ref), ColorCorrection (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u14 = Bloom:Clone();
    u14.Name = "B";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(7.617 - u3, function() -- Line: 152
        -- upvalues: u14 (copy), Lighting (ref), Bloom (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u15 = DepthOfField:Clone();
    u15.Name = "D";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(7.617, function() -- Line: 167
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.1 - u3, function() -- Line: 174
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v16 = script.Bounce:Clone();
        v16.Parent = Folder;
        v16.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 2);
    end);
    task.delay(1.15 - u3, function() -- Line: 184
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Throw);
    end);
    task.delay(2.1666666666666665 - u3, function() -- Line: 190
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), Lighting (ref), u13 (copy), u15 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.RimBounce);
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        TweenService:Create(u13, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        TweenService:Create(u15, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(3.5 - u3, function() -- Line: 209
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.CameraPart.Model);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Name = script.Parent.Name .. "Blur";
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Linear), {
            Size = 8
        }):Play();
    end);
    task.delay(4.45 - u3, function() -- Line: 222
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Jump2);
        Vignette1.ImageColor3 = Color3.fromRGB(229, 48, 48);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local v17 = Lighting:FindFirstChild(script.Parent.Name .. "Blur");
        v17.Size = 20;
        TweenService:Create(v17, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(v17, 0.25);
        u14.Intensity = 15;
        u14.Threshold = 0.5;
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = DepthOfField.FarIntensity,
            FocusDistance = DepthOfField.FocusDistance
        }):Play();
        u13.Brightness = 0.65;
        u13.Saturation = -1;
        u13.TintColor = Color3.fromRGB(229, 48, 48);
        TweenService:Create(u13, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(4.816666666666666 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u10.Jump1);
    end);
    task.delay(5.983333333333333 - u3, function() -- Line: 256
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u10 (copy), Character (copy), Vignette1 (copy), Lighting (ref), TweenService (ref), u14 (copy), Bloom (copy), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.CameraPart.Was);
        end;

        VfxManager.Emit(u10.Score);
        local Highlight = Instance.new("Highlight", Character);
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.FillColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
        Highlight.OutlineTransparency = 0;
        Highlight.FillTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(229, 48, 48);
        Vignette1.ImageTransparency = 0;
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u14.Intensity = 20;
        u14.Threshold = 0.5;
        TweenService:Create(u14, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u13.Brightness = 1;
        u13.Saturation = -1;
        u13.TintColor = Color3.fromRGB(229, 48, 48);
        task.wait(0.5);
        TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            OutlineTransparency = 1,
            FillTransparency = 1
        }):Play();
        VfxManager.DestroyEffect(Highlight, 0.5);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    local u18 = {};

    local function v19() -- Line: 300
        -- upvalues: u18 (ref), Folder (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if u13 then
            u13:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;
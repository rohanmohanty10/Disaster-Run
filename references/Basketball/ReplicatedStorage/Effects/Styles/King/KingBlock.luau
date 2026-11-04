 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
require(ReplicatedStorage.Controllers.UIController);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 22
    -- upvalues: Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(0.25 - u3, function() -- Line: 35
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Commentator", "Opponent pushing up the court.", 1 }, { "Commentator", "King drilling.", 1 }, { "Commentator", "Goes up and... <animation style=\"glitch\"><font color=\"#ffcd00\">BLOCKED BY KING</font>!</animation>", 4 } });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 58
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
    task.delay(7.317 - u3, function() -- Line: 80
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
    task.delay(7.317 - u3, function() -- Line: 93
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local u10 = SfxManager:playSound({
        Sound = "BBZ King King\'s Block",
        Parent = workspace
    });
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Ball:Clone();
    u12.Parent = Folder;
    u12.CFrame = BALL.CFrame;
    Essentials:Weld(u12, BALL);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local Vignette = u13.Vignette;
    local Vignette1 = u13.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(7.317, function() -- Line: 126
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(7.317, function() -- Line: 141
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u16 = DepthOfField:Clone();
    u16.Name = "D";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(7.317, function() -- Line: 156
        -- upvalues: u16 (copy), Lighting (ref), DepthOfField (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.4666666666666667 - u3, function() -- Line: 163
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v17 = script.Bounce:Clone();
        v17.Parent = Folder;
        v17.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v17);
        VfxManager.DestroyEffect(v17, 2);
    end);
    task.delay(0.7333333333333333 - u3, function() -- Line: 173
        -- upvalues: Folder (copy), BALL (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v18 = script.Bounce:Clone();
        v18.Parent = Folder;
        v18.CFrame = CFrame.new(BALL.Position) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 2);
    end);
    task.delay(1.0666666666666667 - u3, function() -- Line: 183
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Vignette1 (copy), TweenService (ref), Vignette (copy), Lighting (ref), u16 (copy), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Jump2);
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        TweenService:Create(Vignette, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.455);
        TweenService:Create(u16, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 30
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
    end);
    task.delay(1.1333333333333333 - u3, function() -- Line: 203
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.Model);
        end;

        VfxManager.Emit(u11.Jump1);
    end);
    task.delay(3.1666666666666665 - u3, function() -- Line: 213
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u15 (copy), Bloom (copy), u16 (copy), DepthOfField (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u12.Block);
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 234, 76);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u15.Intensity = 20;
        u15.Threshold = 0.5;
        TweenService:Create(u15, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(u16, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FarIntensity = DepthOfField.FarIntensity,
            FocusDistance = DepthOfField.FocusDistance
        }):Play();
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(255, 234, 76);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(3.6166666666666667 - u3, function() -- Line: 242
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.nr2, true);
        end;
    end);
    task.delay(7.266666666666667 - u3, function() -- Line: 250
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera.nr2, false);
        end;
    end);
    local u19 = {};

    local function v20() -- Line: 259
        -- upvalues: u19 (ref), Folder (copy), u13 (copy), u10 (copy), TweenService (ref), VfxManager (ref), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), Bloom (copy), u16 (copy), DepthOfField (copy)
        for _, v in pairs(u19) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u10 then
            TweenService:Create(u10, TweenInfo.new(1), {
                Volume = 0
            }):Play();
            VfxManager.DestroyEffect(u10, 1);
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u19 = nil;
    end;

    table.insert(u19, Folder.AttributeChanged:Connect(v20));
    table.insert(u19, Folder.Destroying:Connect(v20));
end;
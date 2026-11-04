 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
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

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:FindFirstChild(script.Parent.Name .. "Room");
    local BALL = Character:FindFirstChild("BALL", true);
    task.spawn(function() -- Line: 33
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Doctor", "Perfect...", 1 } });
    end);
    task.delay(1.5 - PassedTime, function() -- Line: 43
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Doctor", "Just like that.", 1 } });
    end);
    task.delay(3 - PassedTime, function() -- Line: 53
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Doctor", "Okay, let\'s give it a shot!", 1 } });
    end);
    task.delay(9.75 - PassedTime, function() -- Line: 63
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Doctor", "*Gasp*", 0.5 } });
    end);
    task.delay(10.75 - PassedTime, function() -- Line: 73
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Doctor", "IMPOSSIBLE!", 1 } });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 86
        -- upvalues: u1 (copy), u7 (ref), u6 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * PassedTime;
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
    task.delay(12.467 - PassedTime, function() -- Line: 108
        -- upvalues: u7 (ref)
        u7:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(12.467 - PassedTime, function() -- Line: 121
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Genius Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local v12 = script.Ball:Clone();
    v12.CFrame = BALL.CFrame;
    v12.Parent = Folder;
    Essentials:Weld(v12, BALL);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local Vignette = u13.Vignette;
    local Vignette1 = u13.Vignette1;
    Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.delay(12.467, function() -- Line: 166
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(2.65 - PassedTime, function() -- Line: 173
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Step1);
    end);
    task.delay(3.3333333333333335 - PassedTime, function() -- Line: 179
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Step2);
    end);
    task.delay(4.983333333333333 - PassedTime, function() -- Line: 185
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u14 (copy), ColorCorrection (copy), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 138, 255);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u14.Brightness = 1;
        u14.Contrast = 2;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(60, 138, 255);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u10.Button);
    end);
    task.delay(5.016666666666667 - PassedTime, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Thing2);
    end);
    task.delay(6.833333333333333 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 20
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(7.083333333333333 - PassedTime, function() -- Line: 225
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(7.033333333333333 - PassedTime, function() -- Line: 231
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraFX.Misc);
    end);
    task.delay(9.4 - PassedTime, function() -- Line: 237
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), Vignette1 (copy), u5 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 20
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            BackgroundTransparency = 0
        }):Play();

        if u5 and u5:FindFirstChild("Model") then
            local SpotLight = u5.Model["Cube.002"].Attachment.SpotLight;
            SpotLight.Color = Color3.fromRGB(255, 0, 0);

            while Folder and Folder:GetAttribute("Active") do
                task.wait(0.5);
                SpotLight.Brightness = 1;
                task.wait(0.5);
                SpotLight.Brightness = 0;
            end;
        end;
    end);
    task.delay(9.65 - PassedTime, function() -- Line: 260
        -- upvalues: Folder (copy), TweenService (ref), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            BackgroundTransparency = 1
        }):Play();
    end);
    task.delay(9.933333333333334 - PassedTime, function() -- Line: 266
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.GlitchFX);
        VfxManager.BetterEmit(u10.WakeUp);
    end);
    local u15 = {};

    local function v16() -- Line: 274
        -- upvalues: u15 (ref), Folder (copy), u13 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), ClockTime (copy)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;
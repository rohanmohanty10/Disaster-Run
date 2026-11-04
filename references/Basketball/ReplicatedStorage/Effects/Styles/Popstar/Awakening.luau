 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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
    local u5 = workspace:FindFirstChild(script.Parent.Name .. "Piano");
    local u6 = workspace:FindFirstChild(script.Parent.Name .. "Stage");
    Character:FindFirstChild("BALL", true);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 37
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
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
    task.delay(19.217 - PassedTime, function() -- Line: 59
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(19.217 - PassedTime, function() -- Line: 72
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Popstar Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local Model = Instance.new("Model");
    Model.Parent = Folder;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v12 = Character:FindFirstChild(child.Name);

        if v12 then
            local v13 = child:Clone();
            v13.CFrame = v12.CFrame;
            v13.Parent = Model;
            Essentials:Weld(v13, v12);
        end;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local Vignette1 = u14.Vignette1;
    u14.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(19.217 - PassedTime, function() -- Line: 115
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u16 = Bloom:Clone();
    u16.Name = "B";
    u16.Parent = Lighting;
    u16.Enabled = true;
    local ClockTime = Lighting.ClockTime;
    Lighting.ClockTime = 0;
    task.delay(19.217 - PassedTime, function() -- Line: 133
        -- upvalues: u16 (copy), Lighting (ref), Bloom (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    task.spawn(function() -- Line: 140
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera["camatmo(Super)"], true);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, true);
            VfxManager.Enable(CamRig.camera.RightCinematicBars, true);
        end;

        VfxManager.Enable(Model["Right Arm"].Trail, true);
        VfxManager.Enable(Model["Left Arm"].Trail, true);
        VfxManager.Enable(Model["Left Leg"].Trail, true);
        VfxManager.Enable(Model["Right Leg"].Trail, true);
        VfxManager.Enable(Model.Torso, true);
    end);
    task.delay(5.933333333333334 - PassedTime, function() -- Line: 156
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera["camatmo(Super)"], false);
            VfxManager.Enable(CamRig.camera.LeftCinematicBars, false);
            VfxManager.Enable(CamRig.camera.RightCinematicBars, false);
        end;
    end);
    task.delay(5.95 - PassedTime, function() -- Line: 166
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.Portal, true);
    end);
    task.delay(6.3 - PassedTime, function() -- Line: 172
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(Model["Right Arm"].Trail, false);
        VfxManager.Enable(Model["Left Arm"].Trail, false);
        VfxManager.Enable(Model["Left Leg"].Trail, false);
        VfxManager.Enable(Model["Right Leg"].Trail, false);
    end);
    task.delay(7.333333333333333 - PassedTime, function() -- Line: 181
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.Portal, false);
        VfxManager.Enable(Model["Left Arm"].LastingTrail, false);
        VfxManager.Enable(Model["Right Arm"].LastingTrail, false);
    end);
    task.delay(7.95 - PassedTime, function() -- Line: 189
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), u15 (copy), ColorCorrection (copy), u16 (copy), Bloom (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Land);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u15.Brightness = 1;
        u15.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u15, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        u16.Intensity = 20;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.45, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        TweenService:Create(Vignette1, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(8.166666666666666 - PassedTime, function() -- Line: 212
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref), Model (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera["camatmo(Super)"], true);
        end;

        VfxManager.Enable(Model["Left Arm"].LastingTrail, false);
        VfxManager.Enable(Model["Right Arm"].LastingTrail, false);
        VfxManager.Enable(Model.Torso, false);
    end);
    task.delay(11.133333333333333 - PassedTime, function() -- Line: 224
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera["camatmo(Super)"], false);
            VfxManager.Enable(CamRig.camera["camatmo(Normal)"], true);
        end;
    end);
    task.delay(11.733333333333333 - PassedTime, function() -- Line: 233
        -- upvalues: Folder (copy), u5 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u5 and u5:FindFirstChild("fffs") then
            VfxManager.Emit(u5.fffs.Bone.Catch);
        end;
    end);
    task.delay(12.533333333333333 - PassedTime, function() -- Line: 241
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.AuraMusic, true);
    end);
    task.delay(15.166666666666666 - PassedTime, function() -- Line: 247
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Enable(CamRig.camera["camatmo(Normal)"], false);
        end;
    end);
    task.delay(15.483333333333333 - PassedTime, function() -- Line: 255
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Enable(u11.AuraMusic, false);
    end);
    task.delay(15.716666666666667 - PassedTime, function() -- Line: 261
        -- upvalues: u6 (copy)
        if u6 then
            u6:Destroy();
        end;
    end);
    task.delay(17.416666666666668 - PassedTime, function() -- Line: 267
        -- upvalues: Folder (copy), VfxManager (ref), Model (copy), Lighting (ref), TweenService (ref), u15 (copy), ColorCorrection (copy), u16 (copy), Bloom (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(Model["Left Arm"].Glitchy);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.8);
        u15.Brightness = 1;
        u15.TintColor = Color3.fromRGB(191, 116, 229);
        TweenService:Create(u15, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        u16.Intensity = 15;
        u16.Threshold = 0.5;
        TweenService:Create(u16, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(191, 116, 229);
        TweenService:Create(Vignette1, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    local u17 = {};

    local function v18() -- Line: 291
        -- upvalues: u17 (ref), Folder (copy), u5 (copy), u6 (copy), u14 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy), u16 (copy), Bloom (copy), ClockTime (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u14 then
            u14:Destroy();
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;
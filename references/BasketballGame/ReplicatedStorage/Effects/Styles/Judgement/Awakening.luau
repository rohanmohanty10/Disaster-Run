 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local UIController = require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), UIController (copy), VfxManager (copy), TweenService (copy)
    local PassedTime = p2.PassedTime;
    local Character = p2.Character;
    local OtherRig1 = p2.OtherRig1;
    local OtherRig2 = p2.OtherRig2;
    local v3 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v4 = p2.Task == "Cleanup" and Debris:FindFirstChild(v3);

        if v4 then
            v4:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:FindFirstChild(script.Parent.Name .. "Scale");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    task.delay(3 - PassedTime, function() -- Line: 35
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Everyone come back!", 3 }
        });
    end);
    task.delay(8 - PassedTime, function() -- Line: 45
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "We\'re having a retrial!", 3 }
        });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 58
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
    task.delay(12.516 - PassedTime, function() -- Line: 80
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
    task.delay(12.516 - PassedTime, function() -- Line: 93
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Judgement Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local v10 = script.Cutscene_VFX:Clone();
    v10:PivotTo(HumanoidRootPart.CFrame);
    v10.Parent = Folder;
    local u11 = script.Camera_VFX:Clone();
    u11:PivotTo(CamRig.camera.CFrame);
    u11.Parent = Folder;
    Essentials:Weld(u11.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local _ = u12.Vignette1;
    u12.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    u13.Saturation = 0.5;
    task.delay(12.516, function() -- Line: 129
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
    u14.Intensity = 1.35;
    u14.Threshold = 2;
    task.delay(12.516, function() -- Line: 146
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
    u15.FarIntensity = 1;
    u15.FocusDistance = 35.62;
    task.delay(12.516, function() -- Line: 163
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local u16 = script.FakeAtmo:Clone();
    u16.Parent = Lighting;
    task.delay(12.516, function() -- Line: 173
        -- upvalues: u16 (copy)
        u16:Destroy();
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(12.516666666666667 - PassedTime, function() -- Line: 185
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    task.spawn(function() -- Line: 194
        -- upvalues: PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), PassedTime (copy)
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v17 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v17.BackgroundTransparency = 0;
        v17.Parent = ScreenGui;
        UIController:PlayFlipbook(v17, "JudgementGavel", 0.04031445273130417, PassedTime);
        ScreenGui:Destroy();
    end);
    task.delay(2.8833333333333333 - PassedTime, function() -- Line: 209
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), OtherRig2 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
        local v18 = script.Aura2:Clone();
        v18.Weld.Part0 = OtherRig2:FindFirstChild("Torso");
        v18.Parent = Folder;
        VfxManager.BetterEmit(v18);
    end);
    task.delay(2.9833333333333334 - PassedTime, function() -- Line: 220
        -- upvalues: Folder (copy), u13 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u13.Brightness = 1;
        u13.Contrast = 2;
        u13.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u13, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(7.716666666666667 - PassedTime, function() -- Line: 230
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(7.816666666666666 - PassedTime, function() -- Line: 236
        -- upvalues: Folder (copy), OtherRig1 (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v19 = script.Aura1:Clone();
        v19.Weld.Part0 = OtherRig1:FindFirstChild("Torso");
        v19.Parent = Folder;
        VfxManager.BetterEmit(v19);
    end);
    task.delay(7.85 - PassedTime, function() -- Line: 245
        -- upvalues: Folder (copy), u13 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u13.Brightness = 1;
        u13.Contrast = 2;
        u13.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u13, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(10.533333333333333 - PassedTime, function() -- Line: 255
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(10.716666666666667 - PassedTime, function() -- Line: 261
        -- upvalues: Folder (copy), u13 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u13.Brightness = 1;
        u13.Contrast = 2;
        u13.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u13, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    local u20 = {};

    local function v21() -- Line: 272
        -- upvalues: u20 (ref), Folder (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy), u16 (copy), ClockTime (copy), MapFolder (copy)
        for _, v in pairs(u20) do
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

        if u16 then
            u16:Destroy();
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        u20 = nil;
    end;

    table.insert(u20, Folder.AttributeChanged:Connect(v21));
    table.insert(u20, Folder.Destroying:Connect(v21));
end;
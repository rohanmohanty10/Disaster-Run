 
 

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
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), UIController (copy), VfxManager (copy), TweenService (copy)
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

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:WaitForChild("CamRig", 5);
    local u5 = 0;
    local u6 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u6 = RunService.RenderStepped:Connect(function(p7) -- Line: 33
        -- upvalues: u1 (copy), u6 (ref), u5 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u6:Disconnect();

            return;
        end;

        if u5 <= 0 then
            u5 = p7 * 60 * PassedTime;
        end;

        u5 = u5 + p7 * 60;
        local v8 = script_Fov[math.ceil(u5)];

        if v8 ~= nil then
            if math.ceil(u5) >= #script_Fov then
                u6:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v8, p7 * 6);
        end;
    end);
    task.delay(9.816 - PassedTime, function() -- Line: 55
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.816 - PassedTime, function() -- Line: 68
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Curse King Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u9 = script.Cutscene_VFX:Clone();
    u9:PivotTo(HumanoidRootPart.CFrame);
    u9.Parent = Folder;
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u10 = script.Vignette:Clone();
    u10.Parent = PlayerGui;
    u10.Enabled = true;
    local Vignette1 = u10.Vignette1;
    u10.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u11 = ColorCorrection:Clone();
    u11.Name = "CC";
    u11.Parent = Lighting;
    u11.Enabled = true;
    u11.Saturation = 0.5;
    task.delay(9.816, function() -- Line: 99
        -- upvalues: u11 (copy), Lighting (ref), ColorCorrection (copy)
        u11:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u12 = Bloom:Clone();
    u12.Name = "B";
    u12.Parent = Lighting;
    u12.Enabled = true;
    u12.Intensity = 1.35;
    u12.Threshold = 2;
    task.delay(9.816, function() -- Line: 116
        -- upvalues: u12 (copy), Lighting (ref), Bloom (copy)
        u12:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u13 = DepthOfField:Clone();
    u13.Name = "D";
    u13.Parent = Lighting;
    u13.Enabled = true;
    u13.FarIntensity = 1;
    u13.FocusDistance = 53.34;
    task.delay(9.816, function() -- Line: 133
        -- upvalues: u13 (copy), Lighting (ref), DepthOfField (copy)
        u13:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local u14 = script.FakeAtmo:Clone();
    u14.Parent = Lighting;
    task.delay(9.816, function() -- Line: 143
        -- upvalues: u14 (copy)
        u14:Destroy();
    end);
    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(9.816 - PassedTime, function() -- Line: 150
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    task.spawn(function() -- Line: 159
        -- upvalues: PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), PassedTime (copy)
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v15 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v15.BackgroundTransparency = 0;
        v15.Parent = ScreenGui;
        UIController:PlayFlipbook(v15, "CurseKingPond", 0.04109645337607365, PassedTime);
        ScreenGui:Destroy();
    end);
    task.delay(6.65 - PassedTime, function() -- Line: 174
        -- upvalues: Folder (copy), VfxManager (ref), u9 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u11 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Explosions);
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        u11.Brightness = 1;
        u11.Contrast = 2;
        u11.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u11, TweenInfo.new(0.85, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u11, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(6.9 - PassedTime, function() -- Line: 195
        -- upvalues: Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u11 (copy), ColorCorrection (copy)
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u11.Brightness = 0.65;
        u11.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u11, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        task.wait(0.25);
        TweenService:Create(u11, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = -0.1,
            Saturation = -1
        }):Play();
    end);
    task.delay(8.066666666666666 - PassedTime, function() -- Line: 214
        -- upvalues: Folder (copy), VfxManager (ref), u9 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u11 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u9.Domain);
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        u11.Brightness = 1;
        u11.Contrast = 2;
        u11.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u11, TweenInfo.new(0.85, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u11, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Saturation = 0.5,
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(9.2 - PassedTime, function() -- Line: 235
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u9 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u9.Explosions);
    end);
    task.delay(9.566666666666666 - PassedTime, function() -- Line: 246
        -- upvalues: Folder (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v16 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v16.BackgroundTransparency = 0;
        v16.Parent = ScreenGui;
        UIController:PlayFlipbook(v16, "CurseKingRed", 0.04109645337607365, 0);
        ScreenGui:Destroy();
    end);
    local u17 = {};

    local function v18() -- Line: 264
        -- upvalues: u17 (ref), Folder (copy), u10 (copy), u11 (copy), Lighting (ref), ColorCorrection (copy), u12 (copy), Bloom (copy), u13 (copy), DepthOfField (copy), u14 (copy), MapFolder (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u10 then
            u10:Destroy();
        end;

        if u11 then
            u11:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u12 then
            u12:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u13 then
            u13:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        if u14 then
            u14:Destroy();
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;
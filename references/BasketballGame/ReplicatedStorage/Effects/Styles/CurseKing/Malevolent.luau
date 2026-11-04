 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), TweenService (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Teammate;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 35
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
    task.delay(10.066 - u3, function() -- Line: 57
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
    task.delay(10.066 - u3, function() -- Line: 70
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Curse King Malevolent Dunk",
        Parent = workspace
    }).TimePosition = u3;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
    local v11 = script.Camera_VFX:Clone();
    v11:PivotTo(CamRig.camera.CFrame);
    v11.Parent = Folder;
    Essentials:Weld(v11.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u12 = script.Vignette:Clone();
    u12.Parent = PlayerGui;
    u12.Enabled = true;
    local Vignette1 = u12.Vignette1;
    u12.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    task.delay(10.066, function() -- Line: 105
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
    task.delay(10.066, function() -- Line: 122
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
    u15.FocusDistance = 35;
    task.delay(10.066, function() -- Line: 139
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    local MapFolder = workspace:FindFirstChild("MapFolder");

    if MapFolder then
        MapFolder.Parent = ReplicatedStorage;
        task.delay(8.85, function() -- Line: 154
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    local Court = workspace:FindFirstChild("Court");

    if Court then
        for _, descendant in Court:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                local Transparency = descendant.Transparency;

                if Transparency ~= 1 then
                    descendant.Transparency = 1;
                    task.delay(8.833333333333334, function() -- Line: 170
                        -- upvalues: descendant (copy), Transparency (copy)
                        descendant.Transparency = Transparency;
                    end);
                end;
            end;
        end;
    end;

    local Courts2 = workspace:FindFirstChild("Courts2");

    if Courts2 then
        for _, descendant in Courts2:GetDescendants() do
            if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                local Transparency = descendant.Transparency;

                if Transparency ~= 1 then
                    descendant.Transparency = 1;
                    task.delay(8.833333333333334, function() -- Line: 185
                        -- upvalues: descendant (copy), Transparency (copy)
                        descendant.Transparency = Transparency;
                    end);
                end;
            end;
        end;
    end;

    local AnimatedHome = workspace:FindFirstChild("AnimatedHome");

    if AnimatedHome then
        AnimatedHome.Net.Net.Transparency = 1;
        task.delay(8.833333333333334, function() -- Line: 196
            -- upvalues: AnimatedHome (copy)
            AnimatedHome.Net.Net.Transparency = 0;
        end);
    end;

    local AnimatedAway = workspace:FindFirstChild("AnimatedAway");

    if AnimatedAway then
        AnimatedAway.Net.Net.Transparency = 1;
        task.delay(8.833333333333334, function() -- Line: 204
            -- upvalues: AnimatedAway (copy)
            AnimatedAway.Net.Net.Transparency = 0;
        end);
    end;

    task.delay(1.6666666666666667 - u3, function() -- Line: 209
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 0;
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 10
        }):Play();
        task.wait(1);
        TweenService:Create(BlurEffect, TweenInfo.new(1), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 1);
    end);
    task.delay(2 - u3, function() -- Line: 220
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = 0.65;
        u13.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = 0.1
        }):Play();
    end);
    task.delay(3.3333333333333335 - u3, function() -- Line: 241
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = 0.65;
        u13.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(4.866666666666666 - u3, function() -- Line: 262
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u10.Shoot);
    end);
    task.delay(5.916666666666667 - u3, function() -- Line: 273
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = 0.65;
        u13.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = 0.1
        }):Play();
    end);
    task.delay(6.55 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Slap);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = 0.65;
        u13.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    task.delay(7.133333333333334 - u3, function() -- Line: 317
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Fall);
    end);
    task.delay(7.283333333333333 - u3, function() -- Line: 323
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Grab);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(8.05 - u3, function() -- Line: 334
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dash);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(8.85 - u3, function() -- Line: 345
        -- upvalues: Folder (copy), u10 (copy), VfxManager (ref), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u10.Map:Destroy();
        VfxManager.BetterEmit(u10.Score);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u13.Brightness = 1;
        u13.TintColor = Color3.fromRGB(155, 42, 42);
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(155, 42, 42);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 1
        }):Play();
    end);
    local u16 = {};

    local function v17() -- Line: 371
        -- upvalues: u16 (ref), Folder (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy), ClockTime (copy), MapFolder (copy)
        for _, v in pairs(u16) do
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

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        if MapFolder and not workspace:FindFirstChild("MapFolder") then
            MapFolder.Parent = workspace;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;
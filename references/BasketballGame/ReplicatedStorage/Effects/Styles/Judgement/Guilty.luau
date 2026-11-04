 
 

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
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), ReplicatedStorage (copy), VfxManager (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.OtherRig1;
    local _ = p2.OtherRig2;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    workspace:FindFirstChild(script.Parent.Name .. "Scale");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    task.spawn(function() -- Line: 36
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Chrollo", "No... no no no no no no no!", 2 } });
    end);
    task.delay(2 - u3, function() -- Line: 46
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Chrollo", "There has been a misunderanding!", 2 } });
    end);
    task.delay(4 - u3, function() -- Line: 56
        -- upvalues: Effects (ref)
        Effects:SubtitleV2({ { "Tatlis", "It\'s inevitable.", 1 }, { "Tatlis", "The law is blind, but this outcome is clear.", 3 } });
    end);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 74
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
    task.delay(16.65 - u3, function() -- Line: 96
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
    task.delay(16.65 - u3, function() -- Line: 109
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Judgement Guilty",
        Parent = workspace
    }).TimePosition = u3;
    local u10 = script.Cutscene_VFX:Clone();
    u10:PivotTo(HumanoidRootPart.CFrame);
    u10.Parent = Folder;
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
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u13 = ColorCorrection:Clone();
    u13.Name = "CC";
    u13.Parent = Lighting;
    u13.Enabled = true;
    u13.Saturation = 0.5;
    task.delay(16.65, function() -- Line: 152
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
    task.delay(16.65, function() -- Line: 169
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
    task.delay(16.65, function() -- Line: 186
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    local u16 = script.FakeAtmo:Clone();
    u16.Parent = Lighting;
    task.delay(16.65, function() -- Line: 196
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
        task.delay(12.516666666666667 - u3, function() -- Line: 208
            -- upvalues: Folder (copy), MapFolder (copy)
            if not (Folder and Folder:GetAttribute("Active")) then
                return;
            end;

            if not workspace:FindFirstChild("MapFolder") then
                MapFolder.Parent = workspace;
            end;
        end);
    end;

    task.delay(4.116666666666666 - u3, function() -- Line: 217
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(7.966666666666667 - u3, function() -- Line: 223
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition);
    end);
    task.delay(8.116666666666667 - u3, function() -- Line: 229
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CamStart);
        VfxManager.BetterEmit(u11.CameraAtmosphere);
    end);
    task.delay(8.316666666666666 - u3, function() -- Line: 236
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u10.HammerSlam);
    end);
    task.delay(8.833333333333334 - u3, function() -- Line: 247
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u10.HammerSlam);
    end);
    task.delay(9.283333333333333 - u3, function() -- Line: 258
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u10.HammerSlam);
    end);
    task.delay(9.783333333333333 - u3, function() -- Line: 269
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        VfxManager.BetterEmit(u10.HammerSlam);
    end);
    task.delay(10.75 - u3, function() -- Line: 280
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine), {
            FillTransparency = 0,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.08333333333333333);
        TweenService:Create(Highlight, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(10.833333333333334 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.HammerSlam);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
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
    task.delay(13.483333333333333 - u3, function() -- Line: 305
        -- upvalues: Folder (copy), TweenService (ref), Highlight (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Highlight, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Sine), {
            FillTransparency = 0,
            OutlineColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        task.wait(0.08333333333333333);
        TweenService:Create(Highlight, TweenInfo.new(0.6666666666666666, Enum.EasingStyle.Sine), {
            FillTransparency = 1,
            OutlineColor = Color3.fromRGB(0, 0, 0)
        }):Play();
    end);
    task.delay(13.566666666666666 - u3, function() -- Line: 313
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u13 (copy), TweenService (ref), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Hamilton);
        VfxManager.BetterEmit(u10.Something);
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
    local u17 = {};

    local function v18() -- Line: 327
        -- upvalues: u17 (ref), Folder (copy), u12 (copy), Highlight (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), DepthOfField (copy), u16 (copy), ClockTime (copy), MapFolder (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u12 then
            u12:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
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

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;
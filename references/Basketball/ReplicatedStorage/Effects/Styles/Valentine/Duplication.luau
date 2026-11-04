 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 20
    -- upvalues: Players (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy), Knit (copy), Effects (copy)
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

    local u5 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 36
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
    task.delay(11.083 - PassedTime, function() -- Line: 58
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
    task.delay(11.083 - PassedTime, function() -- Line: 71
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Valentine Duplication",
        Parent = workspace
    }).TimePosition = PassedTime;
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
    task.delay(11.083, function() -- Line: 114
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
    task.delay(11.083, function() -- Line: 131
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
    task.delay(11.083, function() -- Line: 146
        -- upvalues: u15 (copy), Lighting (ref), DepthOfField (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(0.4666666666666667 - PassedTime, function() -- Line: 153
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.CameraTransition1);
    end);
    task.delay(0.5666666666666667 - PassedTime, function() -- Line: 159
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Emit1);
    end);
    task.delay(1.65 - PassedTime, function() -- Line: 165
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
    task.delay(1.7333333333333334 - PassedTime, function() -- Line: 173
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Background);
        VfxManager.BetterEmit(u11.CamAtmo);
        VfxManager.BetterEmit(u11.Atmosphere.glaresandstuff);
        VfxManager.BetterEmit(u11.Background);
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
    task.delay(3.0833333333333335 - PassedTime, function() -- Line: 193
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

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
    task.delay(3.9166666666666665 - PassedTime, function() -- Line: 208
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Scared);
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
    task.delay(4.583333333333333 - PassedTime, function() -- Line: 225
        -- upvalues: TweenService (ref), u13 (copy), u15 (copy)
        TweenService:Create(u13, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            FarIntensity = 1,
            FocusDistance = 35
        }):Play();
    end);
    task.delay(4.65 - PassedTime, function() -- Line: 230
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Emit2);
        VfxManager.BetterEmit(u11.MissLOL);
    end);
    task.delay(5.4 - PassedTime, function() -- Line: 237
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Throw);
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
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u13, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(6.466666666666667 - PassedTime, function() -- Line: 254
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy), u11 (copy), Lighting (ref), TweenService (ref), u13 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.FlashingLight);
        VfxManager.BetterEmit(u11.Atmosphere.CAM2Shading);
        VfxManager.BetterEmit(u11.Atmosphere.gold);
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
    task.delay(7.316666666666666 - PassedTime, function() -- Line: 273
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.TP1);
    end);
    task.delay(8.483333333333333 - PassedTime, function() -- Line: 279
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble1);
    end);
    task.delay(8.8 - PassedTime, function() -- Line: 285
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.TP2);
    end);
    task.delay(9.666666666666666 - PassedTime, function() -- Line: 291
        -- upvalues: Folder (copy), VfxManager (ref), u10 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u10.Dribble2);
    end);
    local u16 = {};

    local function v17() -- Line: 298
        -- upvalues: u16 (ref), Folder (copy), u12 (copy), u13 (copy), Lighting (ref), ColorCorrection (copy), u14 (copy), Bloom (copy), u15 (copy), Highlight (copy), u5 (copy), LocalPlayer (ref), Knit (ref), Effects (ref)
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
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        u16 = nil;

        if u5 and u5.Team == LocalPlayer.Team then
            local Controller = Knit.GetController("AbilityController");
            Controller.InDuplication = true;

            if u5 == LocalPlayer then
                Effects:Popup("DUPLICATED DRIBBLING POWER FOR YOU AND YOUR TEAMMATES.", 2, Color3.new(0.6, 0.8, 1));
                task.delay(0.5, function() -- Line: 342
                    -- upvalues: Effects (ref)
                    Effects:Popup("DOJYAAAN!", 2, Color3.new(1, 0.607843, 0.772549));
                end);
                task.delay(1, function() -- Line: 345
                    -- upvalues: Effects (ref)
                    Effects:Popup("BOOSTS END IN 30 SECONDS.", 2, Color3.new(1, 0.2, 0.2));
                end);
            else
                Effects:Popup("DUPLICATED DRIBBLING POWER.", 2, Color3.new(0.6, 0.8, 1));
                task.delay(0.5, function() -- Line: 350
                    -- upvalues: Effects (ref)
                    Effects:Popup("BOOSTS END IN 30 SECONDS.", 2, Color3.new(1, 0.2, 0.2));
                end);
            end;

            task.delay(25, function() -- Line: 355
                -- upvalues: Effects (ref)
                for i = 1, 5 do
                    Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                    task.wait(1);
                    local _ = i;
                end;

                Effects:Popup("BOOST ENDED.");
            end);
            task.delay(30, function() -- Line: 363
                -- upvalues: Controller (copy)
                Controller.InDuplication = nil;
            end);
        end;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;
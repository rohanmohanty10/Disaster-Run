 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), ReplicatedStorage (copy), UIController (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if p2.Task ~= "Cutscene" then
        local v5 = p2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v7 = Character:FindFirstChild("Left Arm");
    local v8 = Character:FindFirstChild("Right Arm");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    task.spawn(function() -- Line: 35
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I\'m sorry...", 1 }
        });
    end);
    task.delay(1.5 - u3, function() -- Line: 45
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "It\'s just that the world feels so...", 3 }
        });
    end);
    task.delay(4.5 - u3, function() -- Line: 55
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "So, wonderful right now...", 2 }
        });
    end);
    task.delay(7.5 - u3, function() -- Line: 65
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Throughout heaven and earth...", 2 }
        });
    end);
    task.delay(10.5 - u3, function() -- Line: 75
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "I alone...", 2 }
        });
    end);
    task.delay(12 - u3, function() -- Line: 85
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Am the... <font color=\"#ffd45d\">HONORED ONE</font>.", 2 }
        });
    end);
    task.delay(14.5 - u3, function() -- Line: 95
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Imaginary technique...", 2 }
        });
    end);
    task.delay(16.5 - u3, function() -- Line: 105
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Hollow...", 2 }
        });
    end);
    task.delay(18.5 - u3, function() -- Line: 115
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<font color=\"#911cff\">PURPLE.</font>", 1 }
        });
    end);
    local u9 = 0;
    local u10 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u10 = RunService.RenderStepped:Connect(function(p11) -- Line: 128
        -- upvalues: u1 (copy), u10 (ref), u9 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u10:Disconnect();

            return;
        end;

        if u9 <= 0 then
            u9 = p11 * 60 * u3;
        end;

        u9 = u9 + p11 * 60;
        local v12 = script_Fov[math.ceil(u9)];

        if v12 ~= nil then
            if math.ceil(u9) >= #script_Fov then
                u10:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v12, p11 * 6);
        end;
    end);
    task.delay(19.483 - u3, function() -- Line: 150
        -- upvalues: u10 (ref)
        u10:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(19.483 - u3, function() -- Line: 163
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Honored One Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u13 = script.Cutscene_VFX:Clone();
    u13:PivotTo(HumanoidRootPart.CFrame);
    u13.Parent = Folder;
    local u14 = script.Camera_VFX:Clone();
    u14:PivotTo(CamRig.camera.CFrame);
    u14.Parent = Folder;
    Essentials:Weld(u14.camera, CamRig.camera);
    local u15 = script["Left Arm"]:Clone();
    u15.CFrame = v7.CFrame;
    u15.Parent = Folder;
    Essentials:Weld(u15, v7);
    local u16 = script["Right Arm"]:Clone();
    u16.CFrame = v8.CFrame;
    u16.Parent = Folder;
    Essentials:Weld(u16, v8);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u17 = script.Vignette:Clone();
    u17.Parent = PlayerGui;
    u17.Enabled = true;
    local Vignette = u17.Vignette;
    local Vignette1 = u17.Vignette1;
    Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u18 = ColorCorrection:Clone();
    u18.Name = "CC";
    u18.Parent = Lighting;
    u18.Enabled = true;
    task.delay(19.483, function() -- Line: 215
        -- upvalues: u18 (copy), Lighting (ref), ColorCorrection (copy)
        u18:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u19 = Bloom:Clone();
    u19.Name = "B";
    u19.Parent = Lighting;
    u19.Enabled = true;
    task.delay(19.483, function() -- Line: 230
        -- upvalues: u19 (copy), Lighting (ref), Bloom (copy)
        u19:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local DepthOfField = Lighting:FindFirstChild("DepthOfField");
    DepthOfField.Enabled = false;
    local u20 = DepthOfField:Clone();
    u20.Name = "D";
    u20.Parent = Lighting;
    u20.Enabled = true;
    task.delay(19.483, function() -- Line: 245
        -- upvalues: u20 (copy), Lighting (ref), DepthOfField (copy)
        u20:Destroy();

        if not Lighting:FindFirstChild("D") then
            DepthOfField.Enabled = true;
        end;
    end);
    task.delay(6.616666666666666 - u3, function() -- Line: 252
        -- upvalues: Folder (copy), Vignette (copy), TweenService (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette, TweenInfo.new(0.5), {
            BackgroundTransparency = 0
        }):Play();
    end);
    task.delay(7.116666666666666 - u3, function() -- Line: 259
        -- upvalues: Folder (copy), TweenService (ref), Vignette (copy), PlayerGui (copy), ReplicatedStorage (ref), UIController (ref), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(Vignette, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Parent = PlayerGui;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = -1;
        local v21 = ReplicatedStorage.Assets.UI.ImageFrame:Clone();
        v21.Parent = ScreenGui;
        UIController:PlayFlipbook(v21, "HonoredOneSky", 0.041666666666666664);
        ScreenGui:Destroy();
        VfxManager.BetterEmit(u14.Transition);
    end);
    task.delay(13.116666666666667 - u3, function() -- Line: 279
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.Emit);
    end);
    task.delay(14.55 - u3, function() -- Line: 285
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), u13 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u16.Blue);
        VfxManager.BetterEmit(u13.BlueEmit);
        Vignette1.ImageColor3 = Color3.fromRGB(39, 76, 215);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = 1;
        u18.Contrast = 2;
        u18.TintColor = Color3.fromRGB(39, 76, 215);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(16.116666666666667 - u3, function() -- Line: 309
        -- upvalues: Folder (copy), VfxManager (ref), u15 (copy), u13 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u15.Red);
        VfxManager.BetterEmit(u13.RedEmit);
        Vignette1.ImageColor3 = Color3.fromRGB(215, 39, 53);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = 1;
        u18.Contrast = 2;
        u18.TintColor = Color3.fromRGB(215, 39, 53);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(17.933333333333334 - u3, function() -- Line: 333
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u16.Purple);
        Vignette1.ImageColor3 = Color3.fromRGB(145, 28, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u18.Brightness = 1;
        u18.Contrast = 2;
        u18.TintColor = Color3.fromRGB(145, 28, 255);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
    end);
    task.delay(18.766666666666666 - u3, function() -- Line: 356
        -- upvalues: Folder (copy), VfxManager (ref), u14 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u14.Speed);
    end);
    task.delay(18.783333333333335 - u3, function() -- Line: 362
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), u18 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.PurpleEmit);
        Vignette1.ImageColor3 = Color3.fromRGB(145, 28, 255);
        Vignette1.ImageTransparency = 0;
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u18.Brightness = 1;
        u18.Contrast = 1;
        u18.Saturation = -1;
        u18.TintColor = Color3.fromRGB(145, 28, 255);
        TweenService:Create(u18, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u18, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(18.833333333333332 - u3, function() -- Line: 385
        -- upvalues: Folder (copy), VfxManager (ref), u16 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u16.Purple);
    end);
    local u22 = {};

    local function v23() -- Line: 392
        -- upvalues: u22 (ref), Folder (copy), u17 (copy), Highlight (copy), u18 (copy), Lighting (ref), ColorCorrection (copy), u19 (copy), Bloom (copy), u20 (copy), DepthOfField (copy)
        for _, v in pairs(u22) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u17 then
            u17:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u18 then
            u18:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u19 then
            u19:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if u20 then
            u20:Destroy();

            if not Lighting:FindFirstChild("D") then
                DepthOfField.Enabled = true;
            end;
        end;

        u22 = nil;
    end;

    table.insert(u22, Folder.AttributeChanged:Connect(v23));
    table.insert(u22, Folder.Destroying:Connect(v23));
end;
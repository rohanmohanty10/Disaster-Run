 
 

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
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local BALL = Character:FindFirstChild("BALL", true);
    task.delay(2.75 - u3, function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Surprise?", 1 }
        });
    end);
    task.delay(3.75 - u3, function() -- Line: 48
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Foot Angle <animation style=\"glitch\"><font color=\"#3cff3c\">Off</animation>.", 1 }
        });
    end);
    task.delay(4.75 - u3, function() -- Line: 58
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Ball: <animation style=\"glitch\"><font color=\"#3cff3c\">Right Hand</font>:</animation>.", 1 }
        });
    end);
    task.delay(5.75 - u3, function() -- Line: 68
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Reaction Time: <animation style=\"glitch\"><font color=\"#ff0000\">Slow</font></animation>.", 1 }
        });
    end);
    task.delay(7 - u3, function() -- Line: 78
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Yeah, I\'ve got you!", 2 }
        });
    end);
    task.delay(11.5 - u3, function() -- Line: 88
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Surely, your IQ is touching <animation style=\"glitch\"><font color=\"#ff0000\">0</font></animation>.", 3 }
        });
    end);
    task.delay(14.5 - u3, function() -- Line: 98
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "MOVE IT!", 1 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 111
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u3;
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
    task.delay(15.267 - u3, function() -- Line: 133
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(15.267, function() -- Line: 146
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Genius Decline",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
    local u13 = script.Ball:Clone();
    u13.CFrame = BALL.CFrame;
    u13.Parent = Folder;
    Essentials:Weld(u13, BALL);

    if Head then
        local v14 = script.Head:Clone();
        v14.CFrame = Head.CFrame;
        v14.Parent = Folder;
        Essentials:Weld(v14, Head);
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local Vignette = u15.Vignette;
    local Vignette1 = u15.Vignette1;
    local Highlight = Instance.new("Highlight", Character);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
    Highlight.OutlineTransparency = 0;
    Highlight.FillTransparency = 1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u16 = ColorCorrection:Clone();
    u16.Name = "CC";
    u16.Parent = Lighting;
    u16.Enabled = true;
    task.delay(15.267, function() -- Line: 200
        -- upvalues: u16 (copy), Lighting (ref), ColorCorrection (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.38333333333333336 - u3, function() -- Line: 207
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble1);
    end);
    task.delay(0.95 - u3, function() -- Line: 213
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Spin);
    end);
    task.delay(1.45 - u3, function() -- Line: 219
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Dribble2);
    end);
    task.delay(2.533333333333333 - u3, function() -- Line: 225
        -- upvalues: Folder (copy), Vignette (copy), Vignette1 (copy), TweenService (ref), Highlight (copy), Lighting (ref), VfxManager (ref), u16 (copy), ColorCorrection (copy), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette.ImageTransparency = 0;
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 255, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.Saturation = -1;
        u16.TintColor = Color3.fromRGB(60, 255, 60);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u11.Step);
        VfxManager.BetterEmit(u11.Crosshair);
        VfxManager.BetterEmit(u12.CameraFX.CamTrans);
    end);
    task.delay(3.4166666666666665 - u3, function() -- Line: 253
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13);
    end);
    task.delay(3.6666666666666665 - u3, function() -- Line: 259
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CameraFX.Misc);
    end);
    task.delay(3.783333333333333 - u3, function() -- Line: 265
        -- upvalues: Folder (copy), Lighting (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local v17 = script.FakeCC:Clone();
        v17.Parent = Lighting;
        task.wait(3.2666666666666666);
        v17:Destroy();
    end);
    task.delay(7.016666666666667 - u3, function() -- Line: 276
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.Throw);
    end);
    task.delay(9.066666666666666 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), u16 (copy), ColorCorrection (copy), VfxManager (ref), u11 (copy), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 255, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.Saturation = -1;
        u16.TintColor = Color3.fromRGB(60, 255, 60);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u11.AuraForEmit);
        VfxManager.BetterEmit(u11.Crosshair);
        VfxManager.BetterEmit(u11.BeamsBack);
        VfxManager.BetterEmit(u12.CameraFX.CamTrans);
        VfxManager.BetterEmit(u12.GlitchFX);
    end);
    task.delay(9.416666666666666 - u3, function() -- Line: 303
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Highlight (copy), Lighting (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
    end);
    task.delay(10.633333333333333 - u3, function() -- Line: 319
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.SpeedLines);
    end);
    task.delay(11.466666666666667 - u3, function() -- Line: 325
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u11.BallEmit);
    end);
    task.delay(14.416666666666666 - u3, function() -- Line: 331
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Highlight (copy), Lighting (ref), VfxManager (ref), u16 (copy), ColorCorrection (copy), u11 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(60, 255, 60);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        Highlight.FillTransparency = 0;
        TweenService:Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.Saturation = -1;
        u16.TintColor = Color3.fromRGB(60, 255, 60);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.Emit(u11.DashForward);
    end);
    local u18 = {};

    local function v19() -- Line: 357
        -- upvalues: u18 (ref), Folder (copy), u15 (copy), Highlight (copy), u16 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u18) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if Highlight then
            Highlight:Destroy();
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u18 = nil;
    end;

    table.insert(u18, Folder.AttributeChanged:Connect(v19));
    table.insert(u18, Folder.Destroying:Connect(v19));
end;
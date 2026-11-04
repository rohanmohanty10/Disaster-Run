 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.UIController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 21
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Part_Icles (copy)
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
    local u7 = Players:FindFirstChild(p2.Enemy.Name) or p2.Enemy.Name;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    Character:FindFirstChild("BALL", true);
    task.delay(1 - u3, function() -- Line: 38
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "<animation style=\"glitch\">Know your king.</animation>", 1.5 }
        });
    end);
    task.delay(2 - u3, function() -- Line: 48
        -- upvalues: Effects (ref), u7 (copy)
        Effects:SubtitleV2({
            { u7, "Kings could fall!", 1.5 }
        });
    end);
    task.delay(5 - u3, function() -- Line: 58
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "You fool!", 1.5 }
        });
    end);
    task.delay(8 - u3, function() -- Line: 68
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Not in <animation style=\"glitch\">New York</animation>!", 1.5 }
        });
    end);
    task.delay(9.5 - u3, function() -- Line: 78
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "This city is <animation style=\"glitch\">MINE</animation>!", 1.5 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 91
        -- upvalues: u1 (copy), u9 (ref), u8 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u9:Disconnect();

            return;
        end;

        if u8 <= 0 then
            u8 = p10 * 60 * u3;
        end;

        u8 = u8 + p10 * 60;
        local v11 = script_Fov[math.ceil(u8)];

        if v11 ~= nil then
            if math.ceil(u8) >= #script_Fov then
                u9:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v11, p10 * 6);
        end;
    end);
    task.delay(11.667 - u3, function() -- Line: 113
        -- upvalues: u9 (ref)
        u9:Disconnect();
    end);

    if Debris:FindFirstChild(v4) then
        Debris:FindFirstChild(v4):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(11.667 - u3, function() -- Line: 126
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ King Of NYC Clutch",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u14 = script.Vignette:Clone();
    u14.Parent = PlayerGui;
    u14.Enabled = true;
    local _ = u14.Vignette;
    local Vignette1 = u14.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u15 = ColorCorrection:Clone();
    u15.Name = "CC";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(11.667, function() -- Line: 160
        -- upvalues: u15 (copy), Lighting (ref), ColorCorrection (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(3.566666666666667 - u3, function() -- Line: 167
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 0.65;
        u15.TintColor = Color3.fromRGB(255, 145, 55);
        TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 145, 55);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = -0.1
        }):Play();
    end);
    task.delay(3.6 - u3, function() -- Line: 188
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.CameraAtmosphere);
    end);
    task.delay(3.6166666666666667 - u3, function() -- Line: 194
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble1);
    end);
    task.delay(3.6333333333333333 - u3, function() -- Line: 200
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.SideLines1);
    end);
    task.delay(3.65 - u3, function() -- Line: 206
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.MissLOL1);
    end);
    task.delay(3.75 - u3, function() -- Line: 212
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.CameraAtmosphere);
    end);
    task.delay(4.25 - u3, function() -- Line: 218
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble2);
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 115, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 0.65;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(255, 115, 0);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(4.75 - u3, function() -- Line: 241
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble3);
    end);
    task.delay(5.566666666666666 - u3, function() -- Line: 247
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble4);
    end);
    task.delay(6.433333333333334 - u3, function() -- Line: 253
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy), Vignette1 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble5);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 0.65;
        u15.TintColor = Color3.fromRGB(255, 145, 55);
        TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 145, 55);
        TweenService:Create(Vignette1, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            ImageTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(0, 0, 0)
        }):Play();
        task.wait(0.25);
        TweenService:Create(u15, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Saturation = -1,
            Brightness = -0.1
        }):Play();
    end);
    task.delay(7.016666666666667 - u3, function() -- Line: 276
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble6);
    end);
    task.delay(7.033333333333333 - u3, function() -- Line: 282
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.MissLOL2);
    end);
    task.delay(7.1 - u3, function() -- Line: 288
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.CameraAtmosphere);
    end);
    task.delay(8.116666666666667 - u3, function() -- Line: 294
        -- upvalues: Folder (copy), Vignette1 (copy), TweenService (ref), Lighting (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Vignette1.ImageTransparency = 0;
        Vignette1.ImageColor3 = Color3.fromRGB(255, 115, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.25);
        u15.Brightness = 0.65;
        u15.Saturation = -1;
        u15.TintColor = Color3.fromRGB(255, 115, 0);
        TweenService:Create(u15, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.delay(8.216666666666667 - u3, function() -- Line: 315
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble7);
    end);
    task.delay(8.983333333333333 - u3, function() -- Line: 321
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Dribble8);
    end);
    task.delay(9.6 - u3, function() -- Line: 327
        -- upvalues: Folder (copy), Part_Icles (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u13.SideLines2);
    end);
    task.delay(10.766666666666667 - u3, function() -- Line: 333
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u15 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Throw);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 15;
        TweenService:Create(BlurEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.75);
        u15.Brightness = 0.45;
        u15.TintColor = Color3.fromRGB(255, 145, 55);
        TweenService:Create(u15, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u15, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness
        }):Play();
    end);
    task.delay(10.966666666666667 - u3, function() -- Line: 350
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Spin);
    end);
    local u16 = {};

    local function v17() -- Line: 357
        -- upvalues: u16 (ref), Folder (copy), u14 (copy), u15 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
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

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
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

return function(u1, u2) -- Line: 20
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Part_Icles (copy)
    local TimeSent = u2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = u2.Character;
    local v4 = Character.Name .. script.Parent.Name .. script.Name;

    if u2.Task ~= "Cutscene" then
        local v5 = u2.Task == "Cleanup" and Debris:FindFirstChild(v4);

        if v5 then
            v5:SetAttribute("Active", nil);
        end;

        return;
    end;

    local u6 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u7 = workspace:FindFirstChild(script.Parent.Name .. "UFO");
    Character:FindFirstChild("BALL", true);
    task.delay(1.25 - u3, function() -- Line: 37
        -- upvalues: Effects (ref), u2 (copy)
        Effects:SubtitleV2({
            { u2.Enemy, "Woah, what-", 1 },
            { u2.Enemy, "What is that?", 1 }
        });
    end);
    task.delay(12.5 - u3, function() -- Line: 52
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "This era...", 0.5 },
            { u6, "<animation style=\"glitch\">...is mine.</animation>", 1 }
        });
    end);
    local u8 = 0;
    local u9 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u9 = RunService.RenderStepped:Connect(function(p10) -- Line: 70
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
    task.delay(15.833 - u3, function() -- Line: 92
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
    task.delay(15.833 - u3, function() -- Line: 105
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Alien Awakening",
        Parent = workspace
    }).TimePosition = u3;
    local u12 = script.Cutscene_VFX:Clone();
    u12:PivotTo(HumanoidRootPart.CFrame);
    u12.Parent = Folder;
    local u13 = script.Camera_VFX:Clone();
    u13:PivotTo(CamRig.camera.CFrame);
    u13.Parent = Folder;
    Essentials:Weld(u13.camera, CamRig.camera);
    local u14;

    if Torso then
        u14 = script.Torso:Clone();
        u14.CFrame = Torso.CFrame;
        u14.Parent = Folder;
        Essentials:Weld(u14, Torso);
    else
        u14 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u15 = script.Vignette:Clone();
    u15.Parent = PlayerGui;
    u15.Enabled = true;
    local _ = u15.Vignette1;
    u15.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u16 = ColorCorrection:Clone();
    u16.Name = "CC";
    u16.Parent = Lighting;
    u16.Enabled = true;
    u16.Saturation = 0.5;
    task.delay(15.833, function() -- Line: 149
        -- upvalues: u16 (copy), Lighting (ref), ColorCorrection (copy)
        u16:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.6666666666666666 - u3, function() -- Line: 156
        -- upvalues: Folder (copy), u16 (copy), TweenService (ref), ColorCorrection (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.TintColor = Color3.fromRGB(119, 255, 78);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u12.PortalOpen);
    end);
    task.delay(0.6833333333333333 - u3, function() -- Line: 168
        -- upvalues: Folder (copy), VfxManager (ref), u13 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u13.CamStart);
    end);
    task.delay(0.7166666666666667 - u3, function() -- Line: 174
        -- upvalues: Folder (copy), u7 (copy), Part_Icles (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u7 then
            Part_Icles:AbsoluteEmit(u7["1.001"]);
        end;
    end);
    task.delay(1.2333333333333334 - u3, function() -- Line: 182
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Land);
    end);
    task.delay(5.233333333333333 - u3, function() -- Line: 188
        -- upvalues: Folder (copy), TweenService (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u12.Black, TweenInfo.new(1.05), {
            Transparency = 0
        }):Play();
    end);
    task.delay(5.3 - u3, function() -- Line: 194
        -- upvalues: Folder (copy), u14 (ref), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u14 then
            VfxManager.BetterEmit(u14);
        end;
    end);
    task.delay(5.333333333333333 - u3, function() -- Line: 202
        -- upvalues: Folder (copy), u16 (copy), TweenService (ref), ColorCorrection (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u16.Brightness = 1;
        u16.Contrast = 2;
        u16.TintColor = Color3.fromRGB(121, 255, 80);
        TweenService:Create(u16, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u16, TweenInfo.new(0.655, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        VfxManager.BetterEmit(u12.PortalOpen2);
    end);
    task.delay(5.383333333333334 - u3, function() -- Line: 214
        -- upvalues: Folder (copy), Part_Icles (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Part_Icles:AbsoluteEmit(u12.Fly);
        Part_Icles:AbsoluteEmit(u12.Sphere);
        Part_Icles:AbsoluteEmit(u12.Tunnel);
        Part_Icles:AbsoluteEmit(u12.s);
        Part_Icles:AbsoluteEmit(u12.spee);
        Part_Icles:AbsoluteEmit(u12.sdg);
        Part_Icles:AbsoluteEmit(u12.sqgf);
    end);
    task.delay(11.533333333333333 - u3, function() -- Line: 226
        -- upvalues: Folder (copy), TweenService (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u12.Black, TweenInfo.new(0.5666666666666667), {
            Transparency = 1
        }):Play();
    end);
    task.delay(11.666666666666666 - u3, function() -- Line: 232
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.Ground);
    end);
    task.delay(12.6 - u3, function() -- Line: 238
        -- upvalues: Folder (copy), TweenService (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        TweenService:Create(u12.Black, TweenInfo.new(2.1166666666666667), {
            Transparency = 0.5
        }):Play();
    end);
    local u17 = {};

    local function v18() -- Line: 245
        -- upvalues: u17 (ref), Folder (copy), u15 (copy), u16 (copy), Lighting (ref), ColorCorrection (copy)
        for _, v in pairs(u17) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u15 then
            u15:Destroy();
        end;

        if u16 then
            u16:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;
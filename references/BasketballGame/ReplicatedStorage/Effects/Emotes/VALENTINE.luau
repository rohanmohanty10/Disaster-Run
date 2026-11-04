 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 19
    -- upvalues: SfxManager (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
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

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v6 = workspace:FindFirstChild(Character.Name .. "D4C");
    local CamRig = workspace:WaitForChild("CamRig", 5);
    SfxManager:playSound({
        Sound = script.Sound,
        Parent = workspace
    }).TimePosition = u3;
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 41
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
    task.delay(4.883 - u3, function() -- Line: 63
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);
    local Folder = Instance.new("Folder");
    Folder.Name = v4;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(4.883 - u3, function() -- Line: 72
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    local v11 = script.Cutscene_VFX:Clone();
    v11.Name = v4;
    v11.Parent = Folder;
    v11:PivotTo(HumanoidRootPart.CFrame);
    local u12 = script.Camera_VFX:Clone();
    u12:PivotTo(CamRig.camera.CFrame);
    u12.Parent = Folder;
    Essentials:Weld(u12.camera, CamRig.camera);
    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    local Highlight = Instance.new("Highlight", v6);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(65, 122, 255);
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    TweenService:Create(Highlight, TweenInfo.new(2), {
        FillTransparency = 1,
        OutlineTransparency = 0.95
    }):Play();
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    u14.Saturation = 0.5;
    task.delay(4.883, function() -- Line: 114
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local ClockTime = Lighting.ClockTime;

    if ClockTime ~= 0 then
        Lighting.ClockTime = 0;
    end;

    task.delay(3, function() -- Line: 126
        -- upvalues: Folder (copy), VfxManager (ref), u12 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.BetterEmit(u12.CamSpeed);
    end);
    task.delay(3.283333333333333, function() -- Line: 132
        -- upvalues: Folder (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.755);
        u14.Brightness = 1;
        u14.Contrast = 2;
        u14.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u14, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    local u15 = {};

    local function v16() -- Line: 148
        -- upvalues: u15 (ref), Folder (copy), u13 (copy), u14 (copy), ColorCorrection (copy), ClockTime (copy), Lighting (ref)
        for _, v in pairs(u15) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u14 then
            u14:Destroy();
            ColorCorrection.Enabled = true;
        end;

        if ClockTime ~= 0 and not workspace:GetAttribute("NightMode") then
            Lighting.ClockTime = ClockTime;
        end;

        u15 = nil;
    end;

    table.insert(u15, Folder.AttributeChanged:Connect(v16));
    table.insert(u15, Folder.Destroying:Connect(v16));
end;
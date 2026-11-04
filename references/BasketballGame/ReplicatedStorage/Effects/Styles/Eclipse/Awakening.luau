 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(u1, p2) -- Line: 18
    -- upvalues: Players (copy), Effects (copy), workspace_CurrentCamera (copy), RunService (copy), script_Fov (copy), Essentials (copy), Debris (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), VfxManager (copy), TweenService (copy)
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
    local Torso = Character:FindFirstChild("Torso");
    workspace:WaitForChild("CamRig", 5);
    local u6 = workspace:FindFirstChild(script.Parent.Name .. "Room");
    Character:FindFirstChild("BALL", true);
    task.delay(0.25 - PassedTime, function() -- Line: 34
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "I\'ll show you...", 1 },
            { u5, "The true form of <font color=\"#780000\">Eclipse</font>!", 3 }
        });
    end);
    task.delay(9 - PassedTime, function() -- Line: 49
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "<animation style=\"glitch\">Now... the awakening begins.</animation>", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 62
        -- upvalues: u1 (copy), u8 (ref), u7 (ref), PassedTime (copy), script_Fov (ref), workspace_CurrentCamera (ref), FieldOfView (ref), Essentials (ref)
        if not u1.MovementController.States.Ability then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * PassedTime;
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
    task.delay(9.15 - PassedTime, function() -- Line: 84
        -- upvalues: u8 (ref)
        u8:Disconnect();
    end);

    if Debris:FindFirstChild(v3) then
        Debris:FindFirstChild(v3):Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = v3;
    Folder.Parent = Debris;
    Folder:SetAttribute("Active", true);
    task.delay(9.15 - PassedTime, function() -- Line: 97
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Eclipse Awakening",
        Parent = workspace
    }).TimePosition = PassedTime;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;

    if Torso then
        local v12 = script.Torso:Clone();
        v12.CFrame = Torso.CFrame;
        v12.Parent = Folder;
        Essentials:Weld(v12, Torso);
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local Vignette1 = u13.Vignette1;
    u13.Vignette.ImageTransparency = 0;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(9.15, function() -- Line: 135
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local u15 = script.FakeAtmo:Clone();
    u15.Parent = Lighting;
    local ClockTime = Lighting.ClockTime;
    Lighting.ClockTime = 0;
    task.delay(3.9833333333333334 - PassedTime, function() -- Line: 148
        -- upvalues: Folder (copy), u6 (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if u6 then
            u6:Destroy();
        end;
    end);
    task.delay(8.166666666666666 - PassedTime, function() -- Line: 156
        -- upvalues: Folder (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), u14 (copy), Vignette1 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        VfxManager.Emit(u11.Landing);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 12;
        TweenService:Create(BlurEffect, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.35);
        TweenService:Create(u14, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(0, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.082);
        TweenService:Create(u14, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            Brightness = 0.4
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
        task.wait(0.067);
        TweenService:Create(u14, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = 0.05,
            Saturation = 5,
            TintColor = Color3.fromRGB(120, 0, 0)
        }):Play();
        Vignette1.ImageColor3 = Color3.fromRGB(120, 0, 0);
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 0
        }):Play();
        task.wait(0.055);
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.7);
        TweenService:Create(u14, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(Vignette1, TweenInfo.new(0.067, Enum.EasingStyle.Sine), {
            ImageTransparency = 1
        }):Play();
    end);
    local u16 = {};

    local function v17() -- Line: 199
        -- upvalues: u16 (ref), Folder (copy), u13 (copy), u6 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), ClockTime (copy)
        for _, v in pairs(u16) do
            v:Disconnect();
        end;

        if Folder then
            Folder:Destroy();
        end;

        if u13 then
            u13:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;

        if u14 then
            u14:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();
        end;

        if ClockTime then
            Lighting.ClockTime = ClockTime;
        end;

        u16 = nil;
    end;

    table.insert(u16, Folder.AttributeChanged:Connect(v17));
    table.insert(u16, Folder.Destroying:Connect(v17));
end;
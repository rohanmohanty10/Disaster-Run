 
 

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
    local Enemy = p2.Enemy;
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
    Character:FindFirstChild("BALL", true);
    task.delay(1.5 - u3, function() -- Line: 39
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Looks like the cards are dying to dance~", 3 }
        });
    end);
    task.delay(6.75 - u3, function() -- Line: 49
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Ara~", 0.5 }
        });
    end);
    task.delay(7.75 - u3, function() -- Line: 59
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Want to see something cool?", 2 }
        });
    end);
    task.delay(14.25 - u3, function() -- Line: 69
        -- upvalues: Effects (ref), u6 (copy)
        Effects:SubtitleV2({
            { u6, "Looks like your <animation style=\"glitch\">balance</animation> took the day off~", 2 }
        });
    end);
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 82
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
    task.delay(17.4 - u3, function() -- Line: 104
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
    task.delay(17.4, function() -- Line: 117
        -- upvalues: Folder (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        Folder:SetAttribute("Active", nil);
    end);
    SfxManager:playSound({
        Sound = "BBZ Dealer Card Flick",
        Parent = workspace
    }).TimePosition = u3;
    local u11 = script.Cutscene_VFX:Clone();
    u11:PivotTo(HumanoidRootPart.CFrame);
    u11.Parent = Folder;
    local u12;

    if Head then
        u12 = script.Head:Clone();
        u12.CFrame = Head.CFrame;
        u12.Parent = Folder;
        Essentials:Weld(u12, Head);
    else
        u12 = nil;
    end;

    local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui");
    local u13 = script.Vignette:Clone();
    u13.Parent = PlayerGui;
    u13.Enabled = true;
    local _ = u13.Vignette;
    local _ = u13.Vignette1;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u14 = ColorCorrection:Clone();
    u14.Name = "CC";
    u14.Parent = Lighting;
    u14.Enabled = true;
    task.delay(17.4, function() -- Line: 154
        -- upvalues: u14 (copy), Lighting (ref), ColorCorrection (copy)
        u14:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u15 = Bloom:Clone();
    u15.Name = "B";
    u15.Parent = Lighting;
    u15.Enabled = true;
    task.delay(17.4 - u3, function() -- Line: 169
        -- upvalues: u15 (copy), Lighting (ref), Bloom (copy)
        u15:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);

    if Enemy then
        Essentials:HideCharacter(Enemy, {});
    end;

    task.delay(4.75 - u3, function() -- Line: 180
        -- upvalues: Folder (copy), u11 (copy), HumanoidRootPart (copy), VfxManager (ref), u12 (ref), CamRig (copy), Lighting (ref), TweenService (ref), u15 (copy), Bloom (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Aura:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 22.835, 0));
        VfxManager.Emit(u11.Boom);

        if u12 then
            VfxManager.Emit(u12.Emit);
            VfxManager.Enable(u12.Enabling, true);
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.DunkCameraVertical, true);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u15.Intensity = 20;
        u15.Threshold = 0.5;
        TweenService:Create(u15, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u14.Brightness = 1;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
        local v16 = script.FakeAtmo:Clone();
        v16.Parent = Lighting;
        local Brightness = Lighting.Brightness;
        local Ambient = Lighting.Ambient;
        local OutdoorAmbient = Lighting.OutdoorAmbient;
        Lighting.Brightness = 2;
        Lighting.Ambient = Color3.fromRGB(184, 47, 227);
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0);
        task.wait(12.233333333333333);
        v16:Destroy();

        if Lighting.Brightness == 2 then
            Lighting.Brightness = Brightness;
        end;

        if Lighting.Ambient == Color3.fromRGB(184, 47, 227) then
            Lighting.Ambient = Ambient;
        end;

        if Lighting.OutdoorAmbient == Color3.fromRGB(0, 0, 0) then
            Lighting.OutdoorAmbient = OutdoorAmbient;
        end;
    end);
    task.delay(9 - u3, function() -- Line: 238
        -- upvalues: Folder (copy), Enemy (copy), Essentials (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if Enemy then
            Essentials:UnhideCharacter(Enemy, {});
        end;
    end);
    task.delay(9.633333333333333 - u3, function() -- Line: 246
        -- upvalues: Folder (copy), CamRig (copy), VfxManager (ref)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        if CamRig and CamRig:FindFirstChild("camera") then
            VfxManager.Emit(CamRig.camera.DunkCameraVertical, false);
        end;
    end);
    task.delay(16.983333333333334 - u3, function() -- Line: 254
        -- upvalues: Folder (copy), u11 (copy), HumanoidRootPart (copy), u12 (ref), VfxManager (ref), Lighting (ref), TweenService (ref), u15 (copy), Bloom (copy), u14 (copy), ColorCorrection (copy)
        if not (Folder and Folder:GetAttribute("Active")) then
            return;
        end;

        u11.Aura:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -1000, 0));

        if u12 then
            VfxManager.Emit(u12.Emit);
            VfxManager.Enable(u12.Enabling, false);
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u15.Intensity = 15;
        u15.Threshold = 0.5;
        TweenService:Create(u15, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u14.Brightness = 0.6;
        u14.Saturation = -1;
        u14.TintColor = Color3.fromRGB(184, 47, 227);
        TweenService:Create(u14, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u14, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    local u17 = {};

    local function v18() -- Line: 282
        -- upvalues: u17 (ref), Folder (copy), u13 (copy), u14 (copy), Lighting (ref), ColorCorrection (copy), u15 (copy), Bloom (copy), Enemy (copy), Essentials (ref)
        for _, v in pairs(u17) do
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

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end;

        if u15 then
            u15:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end;

        if Enemy then
            Essentials:UnhideCharacter(Enemy, {});
        end;

        u17 = nil;
    end;

    table.insert(u17, Folder.AttributeChanged:Connect(v18));
    table.insert(u17, Folder.Destroying:Connect(v18));
end;
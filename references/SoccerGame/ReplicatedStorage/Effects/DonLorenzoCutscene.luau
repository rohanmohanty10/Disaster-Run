  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local script_Fov = require(script.Fov);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.Name ~= "Sweat" and (v.ClassName == "ParticleEmitter" or v.ClassName == "Beam") then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 27
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local function Destroy_Effect(u4: userdata, p5: number) -- Line: 37
    task.delay(p5, function() -- Line: 38
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

return function(p6) -- Line: 43
    -- upvalues: SpectatorController (copy), SoundManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), TweenService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("AwakeningDonzo", 0.75, workspace, 130, false);
    local u7 = 0;
    local u8 = nil;
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 53
        -- upvalues: u7 (ref), script_Fov (ref), u8 (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        u7 = u7 + p9 * 60;
        local v10 = script_Fov[math.ceil(u7)];

        if v10 ~= nil then
            if math.ceil(u7) >= #script_Fov then
                u8:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v10, p9 * 10);
        end;
    end);
    local Character = p6.Plr.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Head = Character:FindFirstChild("Head");
    local ColorCorrection = game.Lighting.ColorCorrection;
    ColorCorrection.Brightness = -0.5;
    local DepthOfField = game.Lighting.DepthOfField;
    DepthOfField.FarIntensity = 1;
    DepthOfField.FocusDistance = 48.36;
    DepthOfField.InFocusRadius = 29.12;
    DepthOfField.NearIntensity = 0.429;
    task.delay(0.2, function() -- Line: 79
        -- upvalues: TweenService (ref), DepthOfField (copy), ColorCorrection (copy)
        TweenService:Create(DepthOfField, TweenInfo.new(1.4, Enum.EasingStyle.Sine), {
            FarIntensity = 0.21,
            FocusDistance = 9.1,
            InFocusRadius = 0,
            NearIntensity = 0
        }):Play();
        TweenService:Create(ColorCorrection, TweenInfo.new(1.5, Enum.EasingStyle.Quad), {
            Brightness = 0
        }):Play();
    end);
    local u11 = script.HeadFX:Clone();
    u11.Parent = Head;
    u11.CFrame = Head.CFrame;
    u11.WeldConstraint.Part0 = u11;
    u11.WeldConstraint.Part1 = Head;
    local AwakeningCam = workspace:FindFirstChild("AwakeningCam");
    local u12 = script.CameraFX:Clone();
    u12.Parent = AwakeningCam;
    u12.Weld.Part0 = AwakeningCam:FindFirstChild("camera");
    u12.Weld.Part1 = u12;
    local u13 = script.Background:Clone();
    u13.Parent = workspace.Debris;
    u13:PivotTo(HumanoidRootPart.CFrame * CFrame.new(4.673, 4.259, -6.346));
    local u14 = script.VFX.CashEmit:Clone();
    u14.Parent = workspace.Debris;
    u14.CFrame = HumanoidRootPart.CFrame;
    local u15 = script.VFX.CashRainFlashes:Clone();
    u15.Parent = workspace.Debris;
    u15:PivotTo(HumanoidRootPart.CFrame);
    task.delay(11.533, function() -- Line: 38
        -- upvalues: u15 (copy)
        u15:Destroy();
    end);
    task.delay(11.533, function() -- Line: 38
        -- upvalues: u13 (copy)
        u13:Destroy();
    end);
    task.delay(11.533, function() -- Line: 38
        -- upvalues: u12 (copy)
        u12:Destroy();
    end);
    task.delay(11.533, function() -- Line: 38
        -- upvalues: u11 (copy)
        u11:Destroy();
    end);
    task.delay(1.817, function() -- Line: 113
        -- upvalues: u11 (copy), TweenService (ref), u12 (copy)
        EnableVFX(u11.Enabling, true);
        EmitAll(u11.Emit:GetDescendants());
        TweenService:Create(u11.Enabling.Attachment.SpotLight, TweenInfo.new(0.255, Enum.EasingStyle.Quint), {
            Brightness = 4
        }):Play();
        EmitAll(u12.Vignette.Emit:GetDescendants());
        EnableVFX(u12.Vignette.Enable, true);
        task.delay(1.5, function() -- Line: 122
            -- upvalues: u12 (ref), u11 (ref)
            EnableVFX(u12.Vignette.Enable, false);
            EnableVFX(u11, false);
            u11.Enabling.Attachment.SpotLight.Brightness = 0;
        end);
    end);
    task.delay(3.267, function() -- Line: 129
        -- upvalues: u12 (copy)
        EnableVFX(u12.Static.Enable, true);
        u12.Extra.Enabled = true;
    end);
    task.delay(5.417, function() -- Line: 134
        -- upvalues: Character (copy), TweenService (ref), u13 (copy), u12 (copy), u11 (copy), u14 (copy), u15 (copy)
        EnableVFX(Character, true);
        TweenService:Create(game.Lighting.DepthOfField, TweenInfo.new(0.455, Enum.EasingStyle.Quint), {
            FarIntensity = 1
        }):Play();
        local Background = u13.Background;
        Background.Transparency = 1;
        EnableVFX(Background, false);
        EnableVFX(u12, false);
        EnableVFX(u11, false);
        task.wait(0.155);
        EmitAll(u14:GetDescendants());
        local v16 = u15;
        EnableVFX(v16, true);
        v16["Star Flashes"].Attachment.Beam.Enabled = true;
        v16.Dollars.Attachment.PointLight.Enabled = true;
        local ColorCorrection2 = game.Lighting.ColorCorrection;
        ColorCorrection2.Brightness = 1;
        ColorCorrection2.Contrast = 1;
        ColorCorrection2.TintColor = Color3.fromRGB(130, 41, 255);
        TweenService:Create(ColorCorrection2, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
            Brightness = 0,
            Contrast = 0.25,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Parent = game.Lighting;
        BlurEffect.Size = 10;
        TweenService:Create(BlurEffect, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.755, function() -- Line: 38
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end);
    task.delay(7.68, function() -- Line: 170
        -- upvalues: u11 (copy)
        EmitAll(u11.TeethSparkle:GetDescendants());
    end);
    task.delay(9.533, function() -- Line: 174
        -- upvalues: u11 (copy), u15 (copy), TweenService (ref), ColorCorrection (copy), DepthOfField (copy), u13 (copy), u12 (copy), CutsceneUtils (ref), ReplicatedStorage (ref)
        EnableVFX(u11.Enabling, false);
        local v17 = u15;
        EnableVFX(u15, false);
        v17["Star Flashes"].Attachment.Beam.Enabled = false;
        v17.Dollars.Attachment.PointLight.Enabled = false;
        TweenService:Create(ColorCorrection, TweenInfo.new(0.5), {
            Brightness = 0,
            Contrast = 0.25,
            Saturation = 0.5,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(DepthOfField, TweenInfo.new(0.5), {
            FarIntensity = 0.21,
            FocusDistance = 90,
            InFocusRadius = 0,
            NearIntensity = 0
        }):Play();
        task.wait(2);
        pcall(function() -- Line: 197
            -- upvalues: u13 (ref), u15 (ref), u12 (ref), u11 (ref), CutsceneUtils (ref), ReplicatedStorage (ref)
            u13:Destroy();
            u15:Destroy();
            u12:Destroy();
            u11:Destroy();
            CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
        end);
    end);
end;
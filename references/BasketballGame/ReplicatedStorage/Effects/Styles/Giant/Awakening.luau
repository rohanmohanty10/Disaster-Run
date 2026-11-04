 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 16
    task.delay(p2, function() -- Line: 17
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 22
    -- upvalues: Effects (copy), SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), ReplicatedStorage (copy), TweenService (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p4.Character;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 0.5);
    Character:WaitForChild("Torso", 0.5);
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    local v6 = game.Players:FindFirstChild(Character.Name) or game.Players:GetPlayerFromCharacter(Character);
    Effects:SubtitleV2({
        {
            v6,
            "<animation style=\"appear\" timeBetweenStep=\"0.2\">Crush...</animation>",
            3,
            0.5
        },
        { v6, "<animation style=\"appear\" timeBetweenStep=\"0.1\">...crush all the <font color=\"#ff0000\"><animation style=\"glitch\" timeBetweenStep=\"0.1\">bugs</animation></font> that get in your way.</animation>", 5 }
    });
    SfxManager:playSound({
        Sound = "GiantAwaken",
        Parent = workspace
    });
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 54
        -- upvalues: u3 (copy), u8 (ref), u7 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u5;
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
    task.delay(10, function() -- Line: 73
        -- upvalues: u8 (ref)
        if u8 then
            u8:Disconnect();
        end;
    end);
    local game_Lighting = game.Lighting;
    local u11 = game_Lighting.DepthOfField:Clone();
    u11.Parent = ReplicatedStorage;
    local u12 = game_Lighting.ColorCorrection:Clone();
    u12.Parent = ReplicatedStorage;
    u12.Name = "OldColorCorrect";
    u11.Name = "OldDepth";
    TweenService:Create(game_Lighting.DepthOfField, TweenInfo.new(4, Enum.EasingStyle.Sine), {
        FarIntensity = 1,
        FocusDistance = 35
    }):Play();
    local u13 = script.GiantAwakeningEffects:Clone();
    u13.Parent = workspace.Debris;
    u13:PivotTo(HumanoidRootPart.CFrame);
    local u14 = script.CameraFX:Clone();
    u14.Parent = u13;
    u14:PivotTo(CamRig:FindFirstChild("camera").CFrame);

    for _, child in u14:GetChildren() do
        Essentials:Weld(CamRig:FindFirstChild("camera"), child);
    end;

    local u15 = script.HeadFX:Clone();
    u15.Parent = u13;
    u15.CFrame = Character:FindFirstChild("Head").CFrame;
    Essentials:Weld(Character:FindFirstChild("Head"), u15);
    local u16 = script.AuraBodyWelds:Clone();
    u16.Parent = u13;

    for _, child in u16:GetChildren() do
        local v17 = Character:FindFirstChild(child.Name);

        if v17 then
            child.CFrame = v17.CFrame;
            Essentials:Weld(v17, child);
        end;
    end;

    local u18 = Character:FindFirstChildWhichIsA("Highlight", true);

    if u18 then
        u18.FillTransparency = 0;
        u18.FillColor = Color3.fromRGB(0, 0, 0);
        u18.OutlineColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u18, TweenInfo.new(2, Enum.EasingStyle.Quad), {
            FillTransparency = 1
        }):Play();
        task.delay(3, function() -- Line: 121
            -- upvalues: u18 (copy), TweenService (ref)
            u18.FillColor = Color3.fromRGB(255, 39, 104);
            u18.FillTransparency = 0.35;
            TweenService:Create(u18, TweenInfo.new(1, Enum.EasingStyle.Quad), {
                FillTransparency = 1,
                FillColor = Color3.fromRGB(255, 255, 255),
                OutlineColor = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
        task.delay(9.8, function() -- Line: 127
            -- upvalues: TweenService (ref), u18 (copy)
            TweenService:Create(u18, TweenInfo.new(1, Enum.EasingStyle.Quad), {
                OutlineColor = Color3.fromRGB(0, 0, 0)
            }):Play();
        end);
    end;

    task.delay(1.217 - u5, function() -- Line: 132
        -- upvalues: VfxManager (ref), u15 (copy), u14 (copy), TweenService (ref)
        VfxManager.Emit(u15.Emit);
        VfxManager.Enable(u15.Enabling, true);
        u15.Attachment.SpotLight.Enabled = true;
        VfxManager.Enable(u14.CameraAtmosphere, true);
        local _ = game.Lighting;
        local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
        TweenService:Create(game.Lighting:FindFirstChild("Bloom"), TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Intensity = 1,
            Size = 24,
            Threshold = 1.414
        }):Play();
        ColorCorrection.Saturation = -1;
        ColorCorrection.Contrast = 1;
        ColorCorrection.TintColor = Color3.fromRGB(255, 41, 70);
        TweenService:Create(ColorCorrection, TweenInfo.new(0.225, Enum.EasingStyle.Sine), {
            Saturation = 0.3,
            Contrast = 0.2,
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
    end);
    task.delay(2.8 - u5, function() -- Line: 146
        -- upvalues: VfxManager (ref), u13 (copy), u16 (copy), u14 (copy), TweenService (ref)
        VfxManager.Emit(u13.StompEmit);
        VfxManager.Enable(u13.Wind_Floor, true);
        VfxManager.Enable(u13.LegIntensity, true);
        VfxManager.Enable(u16, true);
        VfxManager.Enable(u14.CameraAtmosphere, false);
        VfxManager.Enable(u14.CameraLines, true);
        VfxManager.Enable(u14.CameraAuraFX, true);
        local game_Lighting2 = game.Lighting;
        local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");

        if ColorCorrection then
            ColorCorrection.Saturation = -1;
            ColorCorrection.Contrast = 2;
            ColorCorrection.Brightness = 1.5;
            ColorCorrection.TintColor = Color3.fromRGB(255, 43, 89);
            TweenService:Create(ColorCorrection, TweenInfo.new(0.325, Enum.EasingStyle.Sine), {
                Saturation = 0.3,
                Contrast = 0.2,
                Brightness = -0.015,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting2);
        BlurEffect.Size = 10;
        TweenService:Create(BlurEffect, TweenInfo.new(0.755, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.755, function() -- Line: 17
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end);
    task.delay(3.617 - u5, function() -- Line: 169
        -- upvalues: VfxManager (ref), u14 (copy), u13 (copy), TweenService (ref)
        VfxManager.Enable(u14.PassCamera1, true);
        VfxManager.Enable(u14.CameraLines, false);
        VfxManager.Enable(u14.CameraAuraFX, false);
        VfxManager.Enable(u13.SpaceZone, true);
        VfxManager.Enable(u13.LegIntensity, false);
        local _ = game.Lighting;
        local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
        local DepthOfField = game.Lighting:FindFirstChild("DepthOfField");

        if ColorCorrection then
            TweenService:Create(ColorCorrection, TweenInfo.new(4, Enum.EasingStyle.Quint), {
                Saturation = -1,
                Contrast = 0.3,
                Brightness = -0.1
            }):Play();
        end;

        if DepthOfField then
            TweenService:Create(DepthOfField, TweenInfo.new(2, Enum.EasingStyle.Sine), {
                FarIntensity = 1,
                FocusDistance = 3.34,
                NearIntensity = 0.083
            }):Play();
        end;
    end);
    task.delay(4.3 - u5, function() -- Line: 187
        -- upvalues: VfxManager (ref), u13 (copy)
        VfxManager.Emit(u13.LandFX);
    end);
    task.delay(5.567 - u5, function() -- Line: 191
        -- upvalues: u13 (copy), VfxManager (ref), u14 (copy), TweenService (ref)
        local BackgroundGalaxy = u13.BackgroundGalaxy;
        BackgroundGalaxy.Void.Transparency = 0;
        VfxManager.Enable(BackgroundGalaxy, true);
        VfxManager.Enable(u13.HeadIntensity, true);
        VfxManager.Enable(u13.FinalAura, true);
        VfxManager.Emit(u13.FinalEmit);
        VfxManager.Enable(u14.PassCamera1, false);
        VfxManager.Enable(u14.CameraAuraFX, false);
        VfxManager.Enable(u14.FakeCamera1, true);
        VfxManager.Enable(u14.FakeCamera2, true);
        VfxManager.Enable(u14.FakeCamera3, true);
        VfxManager.Enable(u13.FinalAura, true);
        local game_Lighting2 = game.Lighting;
        local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
        local DepthOfField = game.Lighting:FindFirstChild("DepthOfField");

        if ColorCorrection then
            local v19 = TweenService:Create(ColorCorrection, TweenInfo.new(0.125, Enum.EasingStyle.Sine), {
                Saturation = -1,
                Contrast = 1,
                Brightness = -0.015,
                TintColor = Color3.fromRGB(255, 41, 70)
            });
            v19:Play();
            v19.Completed:Connect(function() -- Line: 214
                -- upvalues: TweenService (ref), ColorCorrection (copy)
                TweenService:Create(ColorCorrection, TweenInfo.new(0.155, Enum.EasingStyle.Sine), {
                    Saturation = 0.3,
                    Contrast = 0.2,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
            end);
        end;

        if DepthOfField then
            TweenService:Create(DepthOfField, TweenInfo.new(3, Enum.EasingStyle.Quint), {
                FarIntensity = 0.21,
                FocusDistance = 90,
                NearIntensity = 0
            }):Play();
        end;

        local BlurEffect = Instance.new("BlurEffect", game_Lighting2);
        BlurEffect.Size = 17;
        TweenService:Create(BlurEffect, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.delay(0.355, function() -- Line: 17
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
    end);
    task.delay(9.7 - u5, function() -- Line: 229
        -- upvalues: u13 (copy), u11 (copy), u12 (copy), LightingController (ref)
        u13:Destroy();
        local _ = game.Lighting;
        local ColorCorrection = game.Lighting:FindFirstChild("ColorCorrection");
        local DepthOfField = game.Lighting:FindFirstChild("DepthOfField");

        if ColorCorrection then
            ColorCorrection:Destroy();
        end;

        if DepthOfField then
            DepthOfField:Destroy();
        end;

        u11.Parent = game.Lighting;
        u11.Name = "DepthOfField";
        u12.Parent = game.Lighting;
        u12.Name = "ColorCorrection";
        LightingController:ResetLighting(1);
    end);
end;
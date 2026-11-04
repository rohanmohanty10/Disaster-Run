 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local LightingController = require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), LightingController (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    SfxManager:playSound({
        Sound = "FlashAwakenMove",
        Parent = workspace
    });
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 27
        -- upvalues: u1 (copy), u5 (ref), u4 (ref), u3 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u1.MovementController.States.Ability == false then
            u5:Disconnect();

            return;
        end;

        if u4 <= 0 then
            u4 = p6 * 60 * u3;
        end;

        u4 = u4 + p6 * 60;
        local v7 = script_Fov[math.ceil(u4)];

        if v7 ~= nil then
            if math.ceil(u4) >= #script_Fov then
                u5:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v7, p6 * 6);
        end;
    end);
    task.delay(12, function() -- Line: 46
        -- upvalues: u5 (ref)
        if u5 then
            u5:Disconnect();
        end;
    end);
    local Character = p2.Character;
    local CamRig = workspace:FindFirstChild("CamRig");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Torso = Character:FindFirstChild("Torso");
    local camera = CamRig:FindFirstChild("camera");
    local u8 = script.VFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(HumanoidRootPart.CFrame);
    local MainAura = u8.MainAura;
    MainAura.CFrame = Torso.CFrame * CFrame.new(0.172, -2.837, -0.277) * CFrame.Angles(0.0079412480965742, -0.4024729255098924, 0.05300564938306779);
    Essentials:Weld(Torso, MainAura);
    local u9 = script.CameraLines:Clone();
    u9.Parent = u8;
    u9.CFrame = camera.CFrame;
    Essentials:Weld(camera, u9);
    local v10 = script.HeadVFX:Clone();
    v10.Parent = u8;
    v10.CFrame = Character:FindFirstChild("Head").CFrame;
    Essentials:Weld(Character:FindFirstChild("Head"), v10);
    LightingController:SetLighting({
        Atmosphere = {
            Density = 0.419,
            Color = Color3.fromRGB(0, 0, 0)
        }
    });
    task.delay(3.3, function() -- Line: 81
        -- upvalues: LightingController (ref)
        LightingController:SetLighting({
            Atmosphere = {
                Density = 0.6,
                Color = Color3.fromRGB(0, 0, 0)
            }
        }, 0.6);
    end);
    task.delay(8.083, function() -- Line: 90
        -- upvalues: LightingController (ref)
        LightingController:ResetLighting(0.5);
    end);
    task.delay(3.6, function() -- Line: 96
        -- upvalues: VfxManager (ref), MainAura (copy), u9 (copy)
        VfxManager.Enable(MainAura, true);
        VfxManager.Enable(u9, true);
    end);
    task.delay(5.2, function() -- Line: 101
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Tp1);
    end);
    task.delay(5.58, function() -- Line: 105
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Tp2);
    end);
    task.delay(6.35, function() -- Line: 109
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.FirstHitImpact);
    end);
    task.delay(6.933, function() -- Line: 113
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Actualhit);
    end);
    task.delay(6.983, function() -- Line: 117
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.GroundHit);
    end);
    task.delay(8.083, function() -- Line: 121
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;
 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
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
    -- upvalues: Effects (copy), SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy), LightingController (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Char = p4.Char;
    local u5 = game.Players:FindFirstChild(Char.Name) or game.Players:GetPlayerFromCharacter(Char);
    local u6 = workspace:GetServerTimeNow() - p4.TimeSent;
    task.delay(0.75, function() -- Line: 30
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Heh...", 0.8 }
        });
    end);
    task.delay(6.5, function() -- Line: 36
        -- upvalues: Effects (ref), u5 (copy)
        Effects:SubtitleV2({
            { u5, "Let\'s see if your eyes can keep up.", 2 }
        });
    end);
    SfxManager:playSound({
        Sound = "FlashAwaken",
        Parent = workspace
    });
    local u7 = 0;
    local u8 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u8 = RunService.RenderStepped:Connect(function(p9) -- Line: 47
        -- upvalues: u3 (copy), u8 (ref), u7 (ref), u6 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u8:Disconnect();

            return;
        end;

        if u7 <= 0 then
            u7 = p9 * 60 * u6;
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
    task.delay(12, function() -- Line: 66
        -- upvalues: u8 (ref)
        if u8 then
            u8:Disconnect();
        end;
    end);
    local camera = workspace:FindFirstChild("CamRig"):FindFirstChild("camera");
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    local BALL = Char:FindFirstChild("BALL", true);
    local u11 = script.VFX:Clone();
    u11.Parent = workspace.Debris;
    u11:PivotTo(HumanoidRootPart.CFrame);
    local u12 = script.cameraVFX:Clone();
    u12.Parent = u11;
    u12.CFrame = camera.CFrame;
    Essentials:Weld(camera, u12);
    local u13 = script.CameraLines:Clone();
    u13.Parent = u11;
    u13:PivotTo(camera.CFrame);
    Essentials:Weld(camera, u13.PrimaryPart);
    local MainAura = u11.MainAura;
    MainAura.CFrame = Torso.CFrame * CFrame.new(0.006, -2.694, -0.237) * CFrame.Angles(0.016179202165987436, 0.11669271378834087, 0.03665191429188092);
    Essentials:Weld(Torso, MainAura);
    local u14 = script.HeadVFX.VFX:Clone();
    u14.Parent = Char:FindFirstChild("Head");
    local u15 = script.BALLVFX:Clone();
    u15.Parent = u11;
    u15.CFrame = BALL.CFrame;
    Essentials:Weld(BALL, u15);
    local CFrame2 = u11.Sphere.CFrame;
    u11.Sphere.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 100, 0);
    task.delay(4.6 - u6, function() -- Line: 106
        -- upvalues: VfxManager (ref), u12 (copy), u13 (copy)
        VfxManager.Enable(u12, true);
        VfxManager.Enable(u13, true);
    end);
    task.delay(3.367 - u6, function() -- Line: 112
        -- upvalues: VfxManager (ref), u11 (copy)
        VfxManager.Emit(u11.TP);
    end);
    task.delay(4.5 - u6, function() -- Line: 116
        -- upvalues: u11 (copy), CFrame2 (copy)
        u11.Sphere.CFrame = CFrame2;
    end);
    task.delay(5.7 - u6, function() -- Line: 120
        -- upvalues: VfxManager (ref), u11 (copy)
        print("step");
        VfxManager.Emit(u11.Step);
    end);
    task.delay(5.917 - u6, function() -- Line: 125
        -- upvalues: VfxManager (ref), u15 (copy)
        VfxManager.Enable(u15, true);
    end);
    task.delay(1.35 - u6, function() -- Line: 131
        -- upvalues: VfxManager (ref), u11 (copy)
        VfxManager.Emit(u11.Pop);
    end);
    task.delay(1.517 - u6, VfxManager.Emit, u11.Dribble1);
    task.delay(1.867 - u6, VfxManager.Emit, u11.Dribble2);
    task.delay(2.067 - u6, VfxManager.Emit, u11.Dribble3);
    task.delay(2.717 - u6, VfxManager.Emit, u11.Dribble4);
    task.delay(3.167 - u6, VfxManager.Emit, u11.Dribble5);
    task.delay(3.367 - u6, VfxManager.Emit, u11.Dribble6);
    task.delay(9.367 - u6, function() -- Line: 143
        -- upvalues: u14 (copy), u11 (copy), LightingController (ref)
        u14:Destroy();
        u11:Destroy();
        LightingController:ResetLighting(1);
    end);
end;
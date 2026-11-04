 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local _ = game.Players.LocalPlayer;

return function(u1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "PhantomOop",
        Parent = workspace
    });
    local TeamMate = p2.TeamMate;
    local u4 = 0;
    local u5 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u5 = RunService.RenderStepped:Connect(function(p6) -- Line: 29
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
    task.delay(9.5 - u3, function() -- Line: 47
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    local Torso = TeamMate:WaitForChild("Torso");
    local u8 = script.VFX.VFXModel:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(HumanoidRootPart.CFrame);
    local CamRig = workspace:WaitForChild("CamRig");
    local u9 = script.CameraFX.Speedlines:Clone();
    u9.Parent = u8;
    u9.S1.Weld.Part0 = CamRig.camera;
    u9.S2.Weld.Part0 = CamRig.camera;
    u9.S1.Weld.Part1 = u9.S1;
    u9.S2.Weld.Part1 = u9.S2;
    local u10 = script.CameraFX.Transition:Clone();
    u10.Parent = u8;
    u10.Screen1.CFrame = CamRig.camera.CFrame * CFrame.new(-0.662, 0.032, -8.283) * CFrame.Angles(-0.05529203070318036, 0.015899949485668342, -0.09136798634190316);
    u10.Screen2.CFrame = CamRig.camera.CFrame * CFrame.new(-0.802, 0.029, -8.28) * CFrame.Angles(-0.05529203070318036, 0.015899949485668342, -0.09136798634190316);
    Essentials:Weld(CamRig.camera, u10.Screen1);
    Essentials:Weld(CamRig.camera, u10.Screen2);
    local u11 = script.MainAura:Clone();
    u11.Parent = u8;
    u11.CFrame = Torso.CFrame * CFrame.new(0, -3, 0);
    Essentials:Weld(Torso, u11);
    local v12 = script.Runningaura:Clone();
    v12.Parent = u8;
    v12.CFrame = Torso.CFrame * CFrame.new(0, -3, 0);
    Essentials:Weld(Torso, v12);
    task.delay(0.41, function() -- Line: 83
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Dribble.Dribble1);
    end);
    task.delay(1.26, function() -- Line: 87
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Dribble.Dribble2);
    end);
    task.delay(2.7 - u3, function() -- Line: 91
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Teleport);
    end);
    task.delay(3.733 - u3, function() -- Line: 95
        -- upvalues: VfxManager (ref), u9 (copy)
        VfxManager.Enable(u9, true);
    end);
    task.delay(3 - u3, function() -- Line: 99
        -- upvalues: VfxManager (ref), u11 (copy)
        VfxManager.Enable(u11, true);
    end);
    task.delay(3.833 - u3, function() -- Line: 103
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Footstepcharged);
    end);
    task.delay(4.833 - u3, function() -- Line: 107
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.Slowdribble);
    end);
    task.delay(4.95 - u3, function() -- Line: 111
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TransitionCam);
        u8.void.Transparency = 0;
    end);
    task.delay(5.6 - u3, function() -- Line: 116
        -- upvalues: VfxManager (ref), u10 (copy)
        VfxManager.Emit(u10);
    end);
    task.delay(6 - u3, function() -- Line: 120
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8.Stars, true);
        VfxManager.Emit(u8.Throw);
    end);
    task.delay(6.9 - u3, function() -- Line: 125
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8["Touch/Tapball"]);
    end);
    task.delay(7.483 - u3, function() -- Line: 129
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8["Impact/Dunk"]);
    end);
    task.delay(7.75 - u3, function() -- Line: 133
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8.ChargeScreenEffect1, true);
        VfxManager.Enable(u8.ChargeScreenEffect2, true);
    end);
    task.delay(9.56 - u3, function() -- Line: 138
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;
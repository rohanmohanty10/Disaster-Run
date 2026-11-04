 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local script_Fov = require(script.Fov);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
require(ReplicatedStorage.Effects.Base.Zone);
local _ = game.Players.LocalPlayer;

local function Destroy_Effect(u1: userdata, p2: number) -- Line: 16
    task.delay(p2, function() -- Line: 17
        -- upvalues: u1 (copy)
        u1:Destroy();
    end);
end;

return function(u3, p4) -- Line: 22
    -- upvalues: SfxManager (copy), RunService (copy), script_Fov (copy), Essentials (copy), VfxManager (copy), TweenService (copy)
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local Character = p4.Character;
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart", 0.5);
    Character:WaitForChild("Torso", 0.5);
    local CamRig = workspace:WaitForChild("CamRig", 5);
    local u5 = workspace:GetServerTimeNow() - p4.TimeSent;
    SfxManager:playSound({
        Sound = "PlaymakerAwaken",
        Parent = workspace
    });
    local u6 = 0;
    local u7 = nil;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    u7 = RunService.RenderStepped:Connect(function(p8) -- Line: 35
        -- upvalues: u3 (copy), u7 (ref), u6 (ref), u5 (copy), script_Fov (ref), workspace_CurrentCamera (copy), FieldOfView (ref), Essentials (ref)
        if u3.MovementController.States.Ability == false then
            u7:Disconnect();

            return;
        end;

        if u6 <= 0 then
            u6 = p8 * 60 * u5;
        end;

        u6 = u6 + p8 * 60;
        local v9 = script_Fov[math.ceil(u6)];

        if v9 ~= nil then
            if math.ceil(u6) >= #script_Fov then
                u7:Disconnect();

                return;
            end;

            workspace_CurrentCamera.FieldOfView = FieldOfView;
            FieldOfView = Essentials:Lerp(FieldOfView, v9, p8 * 6);
        end;
    end);
    task.delay(8, function() -- Line: 54
        -- upvalues: u7 (ref)
        if u7 then
            u7:Disconnect();
        end;
    end);
    local BALL = Character:FindFirstChild("BALL", true);
    local u10 = script.VFX:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(HumanoidRootPart.CFrame);
    local Ball_Emit = u10.Ball_Emit;
    Ball_Emit.CFrame = BALL.CFrame;
    Essentials:Weld(BALL, Ball_Emit);
    local u11 = script.BALLVFX:Clone();
    u11.Parent = u10;
    u11.CFrame = BALL.CFrame;
    Essentials:Weld(BALL, u11);
    local camera = CamRig:FindFirstChild("camera");
    local u12 = script.L_RCamera:Clone();
    u12.Parent = u10;
    u12:PivotTo(camera.CFrame);
    Essentials:Weld(camera, u12.camera);
    local u13 = {};
    task.delay(0.35 - u5, function() -- Line: 81
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_0);
    end);
    task.delay(1.167 - u5, function() -- Line: 86
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_1);
    end);
    task.delay(1.833 - u5, function() -- Line: 91
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_2);
    end);
    task.delay(2.367 - u5, function() -- Line: 96
        -- upvalues: u10 (copy), VfxManager (ref), Character (copy), u13 (copy)
        VfxManager.Emit(u10.Dribble.Dribble_3);

        for _, child in script.Aura:GetChildren() do
            if Character:FindFirstChild(child.Name) then
                local v14 = child;

                for _, child2 in child:GetChildren() do
                    local v15 = child2:Clone();

                    if v15:IsA("Attachment") then
                        VfxManager.Enable(v15, true);
                    elseif v15:IsA("ParticleEmitter") then
                        v15.Enabled = true;
                    end;

                    v15.Parent = Character:FindFirstChild(v14.Name);
                    table.insert(u13, v15);
                end;
            end;
        end;
    end);
    task.delay(2.567 - u5, function() -- Line: 117
        -- upvalues: VfxManager (ref), Ball_Emit (copy), u11 (copy), u12 (copy), u10 (copy)
        VfxManager.Emit(Ball_Emit);
        VfxManager.Enable(u11, true);
        VfxManager.Enable(u12.camera, true);
        VfxManager.Enable(u10.Speedlines, true);
    end);
    task.delay(3.817 - u5, function() -- Line: 130
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Release);
    end);
    task.delay(3.933 - u5, function() -- Line: 135
        -- upvalues: u10 (copy), VfxManager (ref), u12 (copy)
        local BackgroundFX = u10.BackgroundFX;
        BackgroundFX.Sphere2.Transparency = 0;
        VfxManager.Enable(BackgroundFX, true);
        VfxManager.Enable(u12, true);
        BackgroundFX.Zone2.Transparency = 0;
        u10.BackgroundFX.Spot_Light.SpotLight.Enabled = true;
        local DepthOfField = game:GetService("Lighting").DepthOfField;
        DepthOfField.FarIntensity = 1;
        DepthOfField.FocusDistance = 0.1;
        VfxManager.Emit(u12.camera.Zone);
    end);
    task.delay(4.55 - u5, function() -- Line: 158
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_4);
    end);
    task.delay(4.967 - u5, function() -- Line: 163
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_5);
    end);
    task.delay(5.3 - u5, function() -- Line: 168
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_6);
    end);
    task.delay(5.4 - u5, function() -- Line: 173
        -- upvalues: TweenService (ref)
        TweenService:Create(game:GetService("Lighting").DepthOfField, TweenInfo.new(2), {
            FarIntensity = 0.21,
            FocusDistance = 5
        }):Play();
    end);
    task.delay(5.65 - u5, function() -- Line: 180
        -- upvalues: u10 (copy), VfxManager (ref)
        VfxManager.Emit(u10.Dribble.Dribble_7);
    end);
    task.delay(6.7 - u5, function() -- Line: 185
        -- upvalues: u11 (copy), u10 (copy), u13 (copy), VfxManager (ref), TweenService (ref)
        u11:Destroy();
        u10:Destroy();

        for _, v in u13 do
            if v:IsA("Attachment") then
                VfxManager.Enable(v, false);
            elseif v:IsA("ParticleEmitter") then
                v.Enabled = false;
            end;

            task.delay(2, function() -- Line: 195
                -- upvalues: v (copy)
                v:Destroy();
            end);
        end;

        table.clear(u13);
        TweenService:Create(game:GetService("Lighting").DepthOfField, TweenInfo.new(0.1), {
            FarIntensity = 0.21,
            FocusDistance = 90
        }):Play();
    end);
end;
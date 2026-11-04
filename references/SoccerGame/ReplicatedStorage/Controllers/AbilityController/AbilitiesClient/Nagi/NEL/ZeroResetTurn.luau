  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

local function Lerp(p1, p2, p3) -- Line: 29
    return p1 + (p2 - p1) * p3;
end;

local function QuadBezier(p4, p5, p6, p7) -- Line: 33
    local v8 = p4 + (p5 - p4) * p7;

    return v8 + (p5 + (p6 - p5) * p7 - v8) * p7;
end;

return function() -- Line: 41
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), LocalPlayer (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage2 (copy), RunService (copy), TweenService (copy)
    local ZeroResetTurn = AbilityBalancing.ZeroResetTurn;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and (AbilityUtils.rules.slotReady(2) and not interface.__trapped)) then
        local Character, u9, v10, _ = AbilityUtils.getCharacter();
        interface:AbilityCooldown(2, LocalPlayer.PlayerStats.Flow.Value == "Singularity" and LocalPlayer.PlayerStats.InFlow.Value and ZeroResetTurn.Cooldown * 0.85 or ZeroResetTurn.Cooldown);
        local ABC = interface.ABC;
        local _ = v10.MoveDirection.Unit;
        StatesController.States.Ability = true;
        local Track = AnimationController:GetTrack("Abilities", "ZeroResetTurnAnim");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("ZeroResetTurnBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("ZeroResetTurn");
        ABC:Add(function() -- Line: 75
            -- upvalues: StatesController (ref), BallController (ref), ReplicatedStorage2 (ref)
            StatesController.States.Ability = false;
            BallController:DragBall();
            ReplicatedStorage2.Football.Value.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
        end);
        local v11, v12 = AbilityUtils.FastDashTo(Character, (u9.CFrame * CFrame.new(0, 0, -5)).Position, 2, 0.1);
        ABC:Add(v11);
        ABC:Add(v12);
        ABC:Add(task.delay(0.2, function() -- Line: 87
            -- upvalues: u9 (copy), ABC (copy), ZeroResetTurn (copy), RunService (ref), TweenService (ref)
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = u9;
            BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000);
            local BodyGyro = Instance.new("BodyGyro");
            BodyGyro.Parent = u9;
            BodyGyro.MaxTorque = Vector3.new(40000, 0, 40000);
            ABC:Add(BodyVelocity);
            ABC:Add(BodyGyro);
            local u13 = ZeroResetTurn.Distance * 1;
            local Vector3Value = Instance.new("Vector3Value");
            local v14 = u9.CFrame * CFrame.new(0, 0, 20);
            local CFrame_new_ret = CFrame.new(u9.Position, v14.Position);
            Vector3Value.Value = (CFrame_new_ret.Position - v14.Position).Unit;
            local Position = u9.Position;
            local Position2 = (u9.CFrame * CFrame.new(0, 0, 50)).Position;
            local _ = (Position - Position2).Magnitude;
            local Position3 = (CFrame_new_ret * CFrame.new(-30, 0, -25)).Position;
            local v16 = RunService.RenderStepped:Connect(function(p15) -- Line: 114
                -- upvalues: BodyVelocity (copy), Vector3Value (copy), u13 (copy)
                BodyVelocity.Velocity = Vector3Value.Value * u13 * 1.7999999999999998;
            end);

            for i = 1, 10 do
                local v17 = i / 10;
                local v18 = Position + (Position3 - Position) * v17;
                local v19 = TweenService:Create(Vector3Value, TweenInfo.new(0.02), {
                    Value = (v18 + (Position3 + (Position2 - Position3) * v17 - v18) * v17 - u9.Position).Unit
                });
                v19:Play();
                v19.Completed:Wait();
                v19:Destroy();
                local _ = i;
            end;

            v16:Disconnect();
            BodyVelocity:Destroy();
            BodyGyro:Destroy();
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 134
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;
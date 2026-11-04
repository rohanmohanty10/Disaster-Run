  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local workspace_CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 31
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), RunService (copy), BallController (copy), ReplicatedStorage2 (copy), workspace_CurrentCamera (copy)
    local BackspinAcceleratingShot = AbilityBalancing.BackspinAcceleratingShot;
    AbilityUtils.rules.onball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    StatesController.NoJump = true;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(1, BackspinAcceleratingShot.Cooldown);
    local Track = AnimationController:GetTrack("Abilities", "BackspinAcceleratingShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("BackspinAcceleratingShot");
    local u2 = false;
    local u3 = nil;
    u3 = RunService.Heartbeat:Connect(function() -- Line: 61
        -- upvalues: AbilityUtils (ref), u2 (ref), Track (copy), u3 (ref), BackspinAcceleratingShot (copy), AnimationController (ref), interface (ref)
        local v4 = AbilityUtils.findNearestPlayer({
            distance = 7,
            team = "Enemy"
        });

        if v4 and v4.Values.Sliding.Value == true or u2 == true then
            Track:Stop();
            u3:Disconnect();
            u3 = nil;
            u2 = true;
            local v5 = AbilityUtils.findNearestPlayer({
                team = "Ally",
                distance = BackspinAcceleratingShot.ActivationRangePlayer
            });
            local Track2 = AnimationController:GetTrack("Abilities", "BackspinCounter");
            Track2.Looped = false;
            Track2.Priority = Enum.AnimationPriority.Action3;
            Track2:Play();
            local BallTrack = AnimationController:GetBallTrack("BackspinCounterBall");
            BallTrack.Looped = false;
            BallTrack.Priority = Enum.AnimationPriority.Action3;
            BallTrack:Play();
            interface.AbilityService.Ability:Fire("BackspinAcceleratingShot", {
                Target = v5
            });
        end;
    end);
    task.delay(0.85, function() -- Line: 86
        -- upvalues: u3 (ref)
        if u3 then
            u3:Disconnect();
            u3 = nil;
        end;
    end);
    ABC:Connect(interface.AbilityService.Ability, function(u6, p7) -- Line: 93
        -- upvalues: StatesController (ref), BackspinAcceleratingShot (copy), ABC (copy), RunService (ref), u1 (copy), BallController (ref), ReplicatedStorage2 (ref), workspace_CurrentCamera (ref), Character (copy)
        StatesController.NoJump = false;
        StatesController.States.Ability = false;
        print(p7);

        if p7 == "Shot" then
            local LookVector = game.Workspace.CurrentCamera.CFrame.LookVector;
            u6.AssemblyLinearVelocity = LookVector * BackspinAcceleratingShot.ShotPower;

            if LookVector.Y < 0.15 then
                Vector3.new(LookVector.X, 0.15, LookVector.Z);
            end;

            task.delay(0.4, function() -- Line: 109
                -- upvalues: ABC (ref), RunService (ref), u6 (copy), u1 (ref)
                local u8 = -43;
                ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 112
                    -- upvalues: u8 (ref), ABC (ref), u6 (ref), u1 (ref)
                    u8 = u8 + 50 * p9;

                    if u8 >= -37 then
                        ABC:Clean();
                    end;

                    u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u6.AssemblyLinearVelocity + -u1.CFrame.UpVector * u8, 8 * p9);
                end);
            end);
            BallController:DragBall(ReplicatedStorage2.Football.Value);

            return;
        end;

        if p7 == nil then
            print("ShotHere");
            u6.AssemblyLinearVelocity = (workspace_CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0)) * 180;

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = p7.HumanoidRootPart;
        local u10 = (HumanoidRootPart2.Position + HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1) - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.5, 0);
        local math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 1.5, 0, 150);
        u6.AssemblyLinearVelocity = u10 * math_clamp_ret;
        BallController:DragBall(u6);
        local u11 = tick();
        ABC:Connect(RunService.Heartbeat, function(p12) -- Line: 143
            -- upvalues: u11 (copy), u6 (copy), ABC (ref), HumanoidRootPart2 (copy), u10 (ref), math_clamp_ret (ref), HumanoidRootPart (copy), BallController (ref)
            if tick() > u11 + 2 or (not u6 or u6.OnPlayer.Value) then
                return ABC:Clean();
            end;

            local _ = HumanoidRootPart2.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v13 = tick() > u11 + 0.55;
            u10 = u10:Lerp((HumanoidRootPart2.Position - u6.Position).Unit + Vector3.new(0, v13 and 0.15 or 0.35, 0), 6.5 * p12);
            math_clamp_ret = math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 2.75, 0, 150);

            if u6.Position.Y < 5 or (HumanoidRootPart2.Position - u6.Position).Magnitude <= 7 then
                return ABC:Clean();
            end;

            u6.AssemblyLinearVelocity = u6.AssemblyLinearVelocity:Lerp(u10 * math_clamp_ret, 6.5 * p12);
            BallController:DragBall(u6);
        end);
    end);
    ABC:Add(function() -- Line: 177
        -- upvalues: StatesController (ref)
        StatesController.NoJump = false;
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 183
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
  

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
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), interface (copy), AbilityBalancing (copy), AnimationController (copy), StatesController (copy), RunService (copy), BallController (copy), ReplicatedStorage (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local ABC = interface.ABC;
    ABC:Clean();
    local LeftFootedCurve = AbilityBalancing.LeftFootedCurve;
    interface:AbilityCooldown(2, LeftFootedCurve.Cooldown);
    local Character, u1, v2, _ = AbilityUtils.getCharacter();
    local _ = v2.MoveDirection.Unit;
    local v3 = Character.HumanoidRootPart.CFrame:vectorToObjectSpace(Character.Humanoid.MoveDirection);
    local u4 = math.round(v3.X) == 0 and 1 or math.round(v3.X);
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "LeftFootedCurve");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.MotorCar = nil;
    StatesController.States.AllowedAbility = nil;
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("LeftFootedCurve");
    ABC:Connect(interface.AbilityService.Ability, function(u5) -- Line: 65
        -- upvalues: u1 (copy), u4 (copy), ABC (copy), LeftFootedCurve (copy), RunService (ref), BallController (ref), ReplicatedStorage (ref)
        local u6 = u1.CFrame.RightVector * u4;
        ABC:Clean();
        local v7 = game.Workspace.CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.2, 0) + u6 / 2;
        u5.AssemblyLinearVelocity = v7 * LeftFootedCurve.ShotPower;

        if v7.Y < 0.15 then
            Vector3.new(v7.X, 0.15, v7.Z);
        end;

        task.delay(0.1, function() -- Line: 78
            -- upvalues: ABC (ref), RunService (ref), u5 (copy), u6 (copy)
            local u8 = -43;
            ABC:Connect(RunService.Heartbeat, function(p9) -- Line: 81
                -- upvalues: u8 (ref), ABC (ref), u5 (ref), u6 (ref)
                u8 = u8 + 40 * p9;

                if u8 >= -25 then
                    ABC:Clean();
                end;

                u5.AssemblyLinearVelocity = u5.AssemblyLinearVelocity:Lerp(u5.AssemblyLinearVelocity + u6 * u8, 8 * p9);
            end);
        end);
        BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    ABC:Add(function() -- Line: 92
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.States.AllowedAbility = nil;
    end);
    ABC:Add(task.delay(1.8, function() -- Line: 97
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
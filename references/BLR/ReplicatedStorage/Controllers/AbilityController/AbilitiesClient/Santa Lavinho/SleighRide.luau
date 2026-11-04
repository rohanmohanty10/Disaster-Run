  

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
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local SleighRide = require(ReplicatedStorage2.AbilityBalancing).SleighRide;

return function() -- Line: 29
    -- upvalues: AbilityUtils (copy), interface (copy), StatesController (copy), SleighRide (copy), AnimationController (copy), RunService (copy)
    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    StatesController.States.Ability = true;
    local UseJumpPower = Character.Humanoid.UseJumpPower;

    if not UseJumpPower then
        Character.Humanoid.UseJumpPower = true;
    end;

    Character.Humanoid.JumpPower = 0;
    AbilityUtils.clearMovers(Character);
    interface:AbilityCooldown(2, SleighRide.Cooldown);
    local Track = AnimationController:GetTrack("Abilities", "SleighRide");
    Track:Play();
    interface.AbilityService.Ability:Fire("SleighRide", {
        Time = workspace:GetServerTimeNow(),
        Pos = Track.TimePosition
    });
    task.wait(0.4);
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.MaxForce = Vector3.new(50000, 0, 50000);
    BodyVelocity.Velocity = u1.CFrame.LookVector * SleighRide.MoveSpeedValue;
    BodyVelocity.Parent = u1;
    ABC:Add(RunService.RenderStepped:Connect(function() -- Line: 68
        -- upvalues: BodyVelocity (copy), u1 (copy), SleighRide (ref)
        if not BodyVelocity then
            return;
        end;

        BodyVelocity.Velocity = u1.CFrame.LookVector * SleighRide.MoveSpeedValue;
    end));
    ABC:Add(function() -- Line: 73
        -- upvalues: BodyVelocity (copy), UseJumpPower (copy), Character (copy), StatesController (ref)
        if BodyVelocity then
            BodyVelocity:Destroy();
        end;

        if not UseJumpPower then
            Character.Humanoid.UseJumpPower = false;
        end;

        Character.Humanoid.JumpPower = 50;
        StatesController.States.Ability = false;
    end);
    task.delay(1.2, function() -- Line: 84
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;
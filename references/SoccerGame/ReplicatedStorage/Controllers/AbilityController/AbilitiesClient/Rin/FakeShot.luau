  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
game:GetService("RunService");
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
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), interface (copy), AnimationController (copy), AbilityBalancing (copy), StatesController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and interface.FakeShot)) then
        return;
    end;

    local Track = AnimationController:GetTrack("Abilities", "RinFakeShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.FakeShot = false;
    local _ = AbilityBalancing.CurveShot;
    interface:AbilityCooldown(1, 30);
    local ABC = interface.ABC;
    local Character, u1, v2, _ = AbilityUtils.getCharacter();
    local _ = v2.MoveDirection.Unit;
    ABC:Clean();
    AnimationController:StopAnims();
    interface.AbilityService.Ability:Fire("NewCurveShot", {
        Fake = true
    });
    local Track2 = AnimationController:GetTrack("Abilities", "RinFakeShot");
    Track2.Looped = false;
    Track2.Priority = Enum.AnimationPriority.Action3;
    Track2:Play();
    task.wait(0.1);
    StatesController.States.Ability = true;
    ABC:Add(task.delay(0.45, function() -- Line: 67
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v3 = u1.CFrame.RightVector * u1.CFrame.LookVector;
        local Unit = Vector3.new(v3.X, 0, v3.Z).Unit;
        local v4, v5 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * 35, -2, 0.25);
        ABC:Add(v4);
        ABC:Add(v5);
    end));
    ABC:Add(function() -- Line: 77
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(0.7, function() -- Line: 81
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
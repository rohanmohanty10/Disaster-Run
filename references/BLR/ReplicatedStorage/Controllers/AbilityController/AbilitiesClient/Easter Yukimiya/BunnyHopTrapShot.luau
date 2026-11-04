  

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
    -- upvalues: AbilityUtils (copy), interface (copy), AbilityBalancing (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;

    if not Character:GetAttribute("Trapped") then
        return;
    end;

    interface.TrapShot = false;
    local BunnyHopTrap = AbilityBalancing.BunnyHopTrap;
    interface:AbilityCooldown(1, BunnyHopTrap.Cooldown);
    StatesController.States.Ability = true;
    interface.Shooting = true;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "BunnyHopTrapShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("BunnyHopTrapShotBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("BunnyHopTrapShot", "Start");
    ABC:Add(task.delay(1.3, function() -- Line: 71
        -- upvalues: interface (ref), ABC (copy), AbilityUtils (ref), BunnyHopTrap (copy)
        interface.AbilityService.Ability:Fire("BunnyHopTrapShot", "Shot");
        ABC:Add(AbilityUtils.execute.shot(BunnyHopTrap));
    end));
    ABC:Add(function() -- Line: 78
        -- upvalues: StatesController (ref), interface (ref)
        StatesController.States.Ability = false;
        interface.Shooting = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 85
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
  

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
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local SneakyVolley = AbilityBalancing.SneakyVolley;
    interface.FlashyShot = false;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(2, SneakyVolley.Cooldown);
    local ABC = interface.ABC;
    local Character, u1, v2, _ = AbilityUtils.getCharacter();
    local _ = v2.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "SneakyVolley");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("SneakyVolleyBall");
    BallTrack.Looped = false;
    BallTrack.Priority = Enum.AnimationPriority.Action4;
    BallTrack:Play();
    interface.AbilityService.Ability:Fire("SneakyVolley");
    ABC:Add(task.delay(0.35, function() -- Line: 62
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), SneakyVolley (copy), ABC (copy)
        local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.LookVector * (SneakyVolley.Distance / 2), 2, 0.2);
        ABC:Add(v3);
        ABC:Add(v4);
    end));
    ABC:Add(AbilityUtils.execute.shot(SneakyVolley));
    ABC:Add(function() -- Line: 74
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 78
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
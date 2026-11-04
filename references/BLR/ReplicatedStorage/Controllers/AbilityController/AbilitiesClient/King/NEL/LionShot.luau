  

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
local workspace_CurrentCamera = workspace.CurrentCamera;

return function() -- Line: 28
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy), workspace_CurrentCamera (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    print("Here");
    local LionShot = AbilityBalancing.LionShot;
    interface.FlashyShot = false;
    StatesController.States.Ability = true;
    interface:AbilityCooldown(1, LionShot.Cooldown);
    local ABC = interface.ABC;
    local Character, _, v1, _ = AbilityUtils.getCharacter();
    local _ = v1.MoveDirection.Unit;
    AnimationController:StopAnims();
    local Track = AnimationController:GetTrack("Abilities", "LionShot");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    LionShot.ShotPower = Character:GetAttribute("PredatorEye") and 200 or 180;
    interface.AbilityService.Ability:Fire("LionShot");
    ABC:Add(AbilityUtils.execute.shot(LionShot, workspace_CurrentCamera.CFrame.LookVector + Vector3.new(0, 0.1, 0), ABC));
    ABC:Add(function() -- Line: 62
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(2, function() -- Line: 66
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
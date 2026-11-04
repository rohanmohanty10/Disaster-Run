  

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
local JetCounter = require(ReplicatedStorage2.AbilityBalancing).JetCounter;
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 28, Name: JetCounter
    -- upvalues: AbilityUtils (copy), interface (copy), StatesController (copy), JetCounter (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    StatesController.States.AllowedAbility = { 2 };
    interface.LeftFootedCurve = true;
    ABC:Add(function() -- Line: 43
        -- upvalues: StatesController (ref), interface (ref), JetCounter (ref)
        StatesController.States.AllowedAbility = nil;
        interface.LeftFootedCurve = false;
        StatesController.States.Ability = false;
        interface:AbilityCooldown(1, JetCounter.Cooldown);
    end);
    interface:AbilityCooldown(1, 0.5);
    local Track = AnimationController:GetTrack("Abilities", "JetCounter");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track.TimePosition = 0.3;
    Track:Play();
    interface.AbilityService.Ability:Fire("JetCounter");
    ABC:Add(task.delay(1.5, function() -- Line: 61
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(Character.Humanoid.Died:Connect(function() -- Line: 65
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(task.delay(0.7, function() -- Line: 69
        -- upvalues: u1 (copy), JetCounter (ref), AbilityUtils (ref), Character (copy), ABC (copy)
        local LookVector = u1.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v2, v3 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * JetCounter.TravelDistance, -2, 0.8);
        ABC:Add(v2);
        ABC:Add(v3);
    end));
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local IllusiveFireworks = require(ReplicatedStorage.AbilityBalancing).IllusiveFireworks;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityUtils (copy), LocalPlayer (copy), interface (copy), IllusiveFireworks (copy), AnimationController (copy), StatesController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(3, IllusiveFireworks.Cooldown);
    AnimationController:StopAnims();
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("IllusiveFireworks");
    ABC:Add(function() -- Line: 53
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 57
        -- upvalues: StatesController (ref), Character (copy), IllusiveFireworks (ref), AbilityUtils (ref), ABC (copy)
        StatesController.States.Ability = false;
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, Character.HumanoidRootPart.Position + Unit * IllusiveFireworks.MoveSpeedValue, 2, IllusiveFireworks.MoveSpeedDuration);
        ABC:Clean();
    end);
    ABC:Add(task.delay(1, function() -- Line: 69
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
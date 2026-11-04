  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
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
local PhantomDribble = require(ReplicatedStorage.AbilityBalancing).PhantomDribble;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(p1, p2, p3) -- Line: 27
    -- upvalues: AbilityUtils (copy), PhantomDribble (copy), Popup (copy), AnimationController (copy), StatesController (copy)
    local ABC = p1.ABC;

    if ABC then
        ABC:Clean();
    end;

    local v4 = AbilityUtils.findNearestPlayer({
        distance = PhantomDribble.ActivationRangePlayer
    });

    if not v4 then
        return Popup.Popup(p2, "You need to be near an enemy to use this!");
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "PhantomDribble"):Play();
    p1:AbilityCooldown(2, PhantomDribble.Cooldown);
    StatesController.States.Ability = true;
    p1.AbilityService.Ability:Fire("PhantomDribble", {
        Target = v4
    });
    ABC:Connect(p1.AbilityService.Ability, function() -- Line: 46
        -- upvalues: Character (copy), PhantomDribble (ref), AbilityUtils (ref), ABC (copy)
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, Character.HumanoidRootPart.Position + Unit * PhantomDribble.MoveSpeedValue, 2, PhantomDribble.MoveSpeedDuration);
        task.wait(0.5);
        ABC:Clean();
    end);
    ABC:Add(task.delay(1.5, function() -- Line: 56
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
    ABC:Add(function() -- Line: 60
        -- upvalues: ABC (copy), StatesController (ref)
        ABC:Destroy();
        StatesController.States.Ability = false;
    end);
end;
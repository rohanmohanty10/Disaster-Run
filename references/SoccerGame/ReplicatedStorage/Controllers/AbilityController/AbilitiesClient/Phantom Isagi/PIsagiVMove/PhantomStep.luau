  

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
local PhantomStep = require(ReplicatedStorage.AbilityBalancing).PhantomStep;
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);

return function(u1, p2, p3) -- Line: 27
    -- upvalues: AbilityUtils (copy), AnimationController (copy), PhantomStep (copy), StatesController (copy)
    if p2.PlayerStats:FindFirstChild("HasShot") and p2.PlayerStats.HasShot.Value == true then
        return;
    end;

    if p3.Values.HasBall.Value then
        return;
    end;

    local ABC = u1.ABC;

    if ABC then
        ABC:Clean();
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "PhantomStep"):Play();
    u1:AbilityCooldown(2, PhantomStep.Cooldown);
    local u4 = false;
    local UseJumpPower = Character.Humanoid.UseJumpPower;

    if not UseJumpPower then
        Character.Humanoid.UseJumpPower = true;
    end;

    StatesController.SpeedBoost = 10;
    Character.Humanoid.JumpPower = 0;
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    u1.AbilityService.Ability:Fire("PhantomStep", {
        Start = true
    });
    ABC:Add(function() -- Line: 61
        -- upvalues: u4 (ref), StatesController (ref), Character (copy), ABC (copy), UseJumpPower (copy)
        u4 = true;
        StatesController.SpeedBoost = 0;
        Character.Humanoid.JumpPower = 50;
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
        ABC:Destroy();

        if not UseJumpPower then
            Character.Humanoid.UseJumpPower = false;
        end;
    end);
    ABC:Connect(u1.AbilityService.Ability, function() -- Line: 73
        -- upvalues: Character (copy), PhantomStep (ref), AbilityUtils (ref), u1 (copy), ABC (copy)
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, Character.HumanoidRootPart.Position + Unit * PhantomStep.MoveSpeedValue, 2, PhantomStep.MoveSpeedDuration);
        local v5 = AbilityUtils.findNearestPlayer({
            distance = PhantomStep.ActivationRangePlayer
        });

        if v5 then
            u1.AbilityService.Ability:Fire("PhantomStep", {
                Target = v5
            });
        end;

        task.wait(PhantomStep.MoveSpeedDuration);
        print("Cleaning");
        ABC:Clean();
    end);
    ABC:Add(task.delay(2, function() -- Line: 90
        -- upvalues: u4 (ref), ABC (copy)
        if u4 == true then
            return;
        end;

        print("Cleaning");
        ABC:Clean();
    end));
end;
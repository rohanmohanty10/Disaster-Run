  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Modules.getPlayerTarget);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
require(ReplicatedStorage.Controllers.BallController);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 27, Name: ZombieSteal
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), AnimationController (copy), StatesController (copy)
    local ZombieSteal = AbilityBalancing.ZombieSteal;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local Humanoid = Character:FindFirstChild("Humanoid");

    if not (Humanoid and Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false);
    ABC:Add(function() -- Line: 46
        -- upvalues: Character (copy)
        if Character and Character:FindFirstChild("Humanoid") then
            Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true);
        end;
    end);
    interface.AbilityService.Ability:Fire("ZombieSteal");
    interface:AbilityCooldown(2, ZombieSteal.Cooldown);
    ABC:Connect(interface.AbilityService.Ability, function(p1) -- Line: 56
        -- upvalues: AnimationController (ref), Character (copy), ZombieSteal (copy), AbilityUtils (ref), ABC (copy), StatesController (ref)
        local Track = AnimationController:GetTrack("Abilities", "ZombieSteal");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local LookVector = Character.HumanoidRootPart.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        AbilityUtils.FastDashTo(Character, Character.HumanoidRootPart.Position + Unit * ZombieSteal.DashDistance, 2, 0.6);
        task.delay(0.65, function() -- Line: 69
            -- upvalues: Track (copy), ABC (ref), StatesController (ref)
            Track:Stop();
            ABC:Clean();
            StatesController.States.Ability = false;
        end);
        task.delay(1.1, function() -- Line: 73
            -- upvalues: ABC (ref), StatesController (ref)
            if ABC then
                ABC:Clean();
                StatesController.States.Ability = false;
            end;
        end);
    end);
    ABC:Add(task.delay(3, function() -- Line: 82
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end));
end;
  

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
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local HelperDribble = require(ReplicatedStorage.AbilityBalancing).HelperDribble;
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 32
    -- upvalues: AbilityUtils (copy), Popup (copy), LocalPlayer (copy), interface (copy), HelperDribble (copy), StatesController (copy), AnimationController (copy)
    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, _, _, v1 = AbilityUtils.getCharacter();

    if v1 and v1.IsInPenalty.Value then
        return Popup.Popup(LocalPlayer, "You cannot be in a penalty box while using this!");
    end;

    local ABC = interface.ABC;

    if ABC then
        ABC:Clean();
    end;

    interface:AbilityCooldown(2, HelperDribble.Cooldown);
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 56
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    AnimationController:StopAnims();
    AnimationController:GetTrack("Abilities", "HelperDribble"):Play();
    interface.AbilityService.Ability:Fire("HelperDribble");
    ABC:Add(interface.AbilityService.Ability:Connect(function(p2, p3, p4) -- Line: 66
        -- upvalues: Character (copy), interface (ref), StatesController (ref), ABC (copy)
        if p4 ~= "First" then
            local HumanoidRootPart = p3.HumanoidRootPart;
            local HumanoidRootPart2 = Character.HumanoidRootPart;
            p2.AssemblyLinearVelocity = ((HumanoidRootPart2.Position - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.1, 0)) * math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 3, 0, 150);
            interface.BallController:DragBall(p2);
            ABC:Clean();

            return;
        end;

        local HumanoidRootPart = Character.HumanoidRootPart;
        local HumanoidRootPart2 = p3.HumanoidRootPart;
        p2.AssemblyLinearVelocity = ((HumanoidRootPart2.Position - HumanoidRootPart.Position).Unit + Vector3.new(0, 0.1, 0)) * math.clamp((HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude * 3, 0, 150);
        interface.BallController:DragBall(p2);
        StatesController.SpeedBoost = 10;
        task.delay(1.5, function() -- Line: 79
            -- upvalues: StatesController (ref)
            StatesController.SpeedBoost = 0;
        end);
    end));
    task.delay(2, function() -- Line: 101
        -- upvalues: ABC (copy)
        if ABC then
            ABC:Clean();
        end;
    end);
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
local BallController = require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 31
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), interface (copy), StatesController (copy), AnimationController (copy), BallController (copy), ReplicatedStorage2 (copy), RunService (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy)
    local _, _, _, _ = AbilityUtils.getCharacter();
    local PhysicalPressure = AbilityBalancing.PhysicalPressure;

    if not (AbilityUtils.rules.offball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    interface:AbilityCooldown(3, PhysicalPressure.Cooldown);
    local ABC = interface.ABC;
    local Character, u1, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    StatesController.OwnWalkState = true;
    ABC:Add(function() -- Line: 49
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
        StatesController.OwnWalkState = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "PhysicalPressure");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("PhysicalPressure", {
        Type = "Effect"
    });
    ABC:Connect(interface.AbilityService.Ability, function() -- Line: 61
        -- upvalues: BallController (ref), ReplicatedStorage2 (ref)
        BallController:DragBall(ReplicatedStorage2.Football.Value);
    end);
    task.delay(0.3, function() -- Line: 65
        -- upvalues: u1 (copy), PhysicalPressure (copy), AbilityUtils (ref), Character (copy), ABC (copy), RunService (ref), getPlayerTarget (ref), Players (ref), LocalPlayer (ref), interface (ref)
        local LookVector = u1.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v2, v3 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * PhysicalPressure.TravelDistance, -2, 0.1);
        ABC:Add(v2);
        ABC:Add(v3);
        local u4 = nil;
        tick();
        ABC:Connect(RunService.Heartbeat, function() -- Line: 77
            -- upvalues: u4 (ref), getPlayerTarget (ref), u1 (ref), PhysicalPressure (ref), Players (ref), LocalPlayer (ref), interface (ref), ABC (ref)
            u4 = getPlayerTarget(false, function(p5, p6) -- Line: 78
                -- upvalues: u1 (ref), PhysicalPressure (ref), Players (ref), LocalPlayer (ref)
                if p5:GetAttribute("IsTrainingDummy") then
                    return (p5.HumanoidRootPart.Position - u1.Position).Magnitude <= PhysicalPressure.ActivationRangePlayer;
                end;

                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);

                if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p5.HumanoidRootPart.Position - u1.Position).Magnitude <= PhysicalPressure.ActivationRangePlayer and not (p5.Values.Goalie.Value and p5.Values.IsInPenalty.Value))) then
                    return true;
                end;
            end);

            if u4 then
                interface.AbilityService.Ability:Fire("PhysicalPressure", {
                    target = u4
                });
                ABC:Clean();
            end;
        end);
    end);
    task.delay(0.5, function() -- Line: 96
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;
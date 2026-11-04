  

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
local Popup = require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local BaitDribble = AbilityBalancing.BaitDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2)) then
        local Character, u1, v2, _ = AbilityUtils.getCharacter();

        if not getPlayerTarget(false, function(p3, p4) -- Line: 44
            -- upvalues: u1 (copy), BaitDribble (copy), Players (ref), LocalPlayer (ref), RunService (ref)
            if p3:GetAttribute("IsTrainingDummy") then
                return (p3.HumanoidRootPart.Position - u1.Position).Magnitude <= BaitDribble.ActivationRangePlayer;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

            if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p3.HumanoidRootPart.Position - u1.Position).Magnitude <= BaitDribble.ActivationRangePlayer and not (PlayerFromCharacter.Character.Values.Goalie.Value and PlayerFromCharacter.Character.Values.IsInPenalty.Value))) or RunService:IsStudio() then
                return true;
            end;
        end) then
            return Popup.Popup(LocalPlayer, "Must be near an enemy player");
        end;

        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        interface:AbilityCooldown(2, BaitDribble.Cooldown);
        local Track = AnimationController:GetTrack("Abilities", "BaitDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("BaitDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("BaitDribble");
        local TravelDistance = BaitDribble.TravelDistance;
        ABC:Add(task.delay(0.1, function() -- Line: 80
            -- upvalues: u1 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local LookVector = (u1.CFrame * CFrame.Angles(0, -0.7853981633974483, 0)).LookVector;
            local v5, v6 = AbilityUtils.FastDashTo(Character, u1.Position + LookVector * TravelDistance, 2, 0.3);
            ABC:Add(v5);
            ABC:Add(v6);
        end));
        ABC:Add(task.delay(0.5, function() -- Line: 92
            -- upvalues: u1 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local LookVector = (u1.CFrame * CFrame.Angles(0, 0.7853981633974483, 0)).LookVector;
            local v7, v8 = AbilityUtils.FastDashTo(Character, u1.Position + LookVector * TravelDistance, 2, 0.3);
            ABC:Add(v7);
            ABC:Add(v8);
        end));
        ABC:Add(function() -- Line: 103
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.7, function() -- Line: 107
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;
  

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
require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local LocalPlayer = Players.LocalPlayer;
local _ = ClientGlobals.PlayerData;
local _ = workspace.CurrentCamera;

return function() -- Line: 38
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy), RunService (copy), StatesController (copy), AnimationController (copy)
    local OppositeDirection = AbilityBalancing.OppositeDirection;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    local u4 = getPlayerTarget(false, function(p2, p3) -- Line: 51
        -- upvalues: u1 (copy), OppositeDirection (copy), Players (ref), LocalPlayer (ref)
        if p2:GetAttribute("IsTrainingDummy") then
            return (p2.HumanoidRootPart.Position - u1.Position).Magnitude < OppositeDirection.ActivationRangePlayer;
        end;

        local PlayerFromCharacter = Players:GetPlayerFromCharacter(p2);

        if not PlayerFromCharacter then
            return false;
        end;

        if PlayerFromCharacter.Team == LocalPlayer.Team then
            return false;
        end;

        local Values = p2.Values;
        local _ = Values.HasBall.Value;

        if Values.IsInPenalty.Value then
            local _ = Values.Goalie.Value;
        end;

        if Values.InCutscene.Value then
            return false;
        end;

        if (p2.HumanoidRootPart.Position - u1.Position).Magnitude < OppositeDirection.ActivationRangePlayer then
            return true;
        end;
    end);

    if RunService:isStudio() and (u4 == nil and (workspace.PassRig.HumanoidRootPart.Position - u1.Position).Magnitude < OppositeDirection.ActivationRangePlayer) then
        u4 = workspace.PassRig;
    end;

    interface:AbilityCooldown(2, OppositeDirection.Cooldown);
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 80
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "OppositeDirection");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    interface.AbilityService.Ability:Fire("OppositeDirection", u4);
    ABC:Add(task.delay(0.3, function() -- Line: 91
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local v5 = -u1.CFrame.RightVector;
        local Unit = Vector3.new(v5.X, 0, v5.Z).Unit;
        local v6, v7 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * 20, -2, 0.6);
        ABC:Add(v6);
        ABC:Add(v7);
    end));
    ABC:Add(task.delay(0.9, function() -- Line: 101
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
        local RightVector = u1.CFrame.RightVector;
        local Unit = Vector3.new(RightVector.X, 0, RightVector.Z).Unit;
        local v8, v9 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * 50, -2, 0.6);
        ABC:Add(v8);
        ABC:Add(v9);
    end));
    ABC:Add(task.delay(1.6, function() -- Line: 111
        -- upvalues: u4 (ref), u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy), AnimationController (ref)
        if not u4 then
            AnimationController:StopAnims();
            ABC:Clean();

            return;
        end;

        local LookVector = u1.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v10, v11 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * 70, -2, 0.5);
        ABC:Add(v10);
        ABC:Add(v11);
    end));
    ABC:Add(task.delay(2.1, function() -- Line: 129
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
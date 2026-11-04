  

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

return function() -- Line: 31
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), getPlayerTarget (copy), Players (copy), RunService (copy), Popup (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local MagicDribble = AbilityBalancing.MagicDribble;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded(LocalPlayer) and AbilityUtils.rules.slotReady(1)) then
        local Character, u1, v2, _ = AbilityUtils.getCharacter();
        local v5 = getPlayerTarget(false, function(p3, p4) -- Line: 42
            -- upvalues: u1 (copy), MagicDribble (copy), Players (ref), LocalPlayer (ref), RunService (ref)
            if p3:GetAttribute("IsTrainingDummy") then
                return (p3.HumanoidRootPart.Position - u1.Position).Magnitude <= MagicDribble.ActivationRangePlayer;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p3);

            if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p3.HumanoidRootPart.Position - u1.Position).Magnitude <= MagicDribble.ActivationRangePlayer and not (PlayerFromCharacter.Character.Values.Goalie.Value and PlayerFromCharacter.Character.Values.IsInPenalty.Value))) or RunService:IsStudio() then
                return true;
            end;
        end);

        if RunService:IsStudio() then
            v5 = workspace.PassRig;
        end;

        if not v5 then
            return Popup.Popup(LocalPlayer, "Must be near an enemy player");
        end;

        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        StatesController.OwnWalkState = true;
        interface:AbilityCooldown(1, 0.8);
        local Track = AnimationController:GetTrack("Abilities", "MagicDribble");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("MagicDribbleBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("MagicDribble");
        local TravelDistance = MagicDribble.TravelDistance;
        local Vector3_new_ret = Vector3.new(v5.HumanoidRootPart.Position.X, u1.Position.Y, v5.HumanoidRootPart.Position.Z);
        local CFrame_new_ret = CFrame.new(u1.Position, Vector3_new_ret);
        ABC:Add(task.delay(0.1, function() -- Line: 86
            -- upvalues: CFrame_new_ret (ref), u1 (copy), Vector3_new_ret (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local v6 = u1.Position + -CFrame_new_ret.RightVector * 15;
            CFrame_new_ret = CFrame.new(v6, Vector3_new_ret);
            local v7, v8 = AbilityUtils.FastDashTo(Character, v6, 2, 0.3);
            ABC:Add(v7);
            ABC:Add(v8);
        end));
        ABC:Add(task.delay(0.4, function() -- Line: 99
            -- upvalues: Vector3_new_ret (copy), u1 (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local v9 = CFrame.new(Vector3_new_ret, u1.Position) * CFrame.new(-8, 0, 0);
            local v10, v11 = AbilityUtils.FastDashTo(Character, v9.Position, 2, 0.2);
            ABC:Add(v10);
            ABC:Add(v11);
        end));
        ABC:Add(task.delay(0.6, function() -- Line: 109
            -- upvalues: u1 (copy), TravelDistance (copy), AbilityUtils (ref), Character (copy), ABC (copy)
            local LookVector = (u1.CFrame * CFrame.Angles(0, 0.5235987755982988, 0)).LookVector;
            local v12, v13 = AbilityUtils.FastDashTo(Character, u1.Position + LookVector * TravelDistance, 2, 0.2);
            ABC:Add(v12);
            ABC:Add(v13);
        end));
        ABC:Add(function() -- Line: 120
            -- upvalues: StatesController (ref)
            StatesController.OwnWalkState = false;
            StatesController.States.Ability = false;
        end);
        interface.MagicPass = true;
        ABC:Add(task.delay(1, function() -- Line: 127
            -- upvalues: ABC (copy), interface (ref), MagicDribble (copy)
            ABC:Clean();
            task.wait(2);

            if interface.MagicPass then
                interface.MagicPass = false;
                interface:AbilityCooldown(1, MagicDribble.Cooldown);
            end;
        end));

        return true;
    end;
end;
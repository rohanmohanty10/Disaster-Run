  

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
local AbilityBalancing = require(ReplicatedStorage2.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage2.Shared.AbilityUtils);
local _ = AbilityUtils.Lerp;
local _ = AbilityUtils.QuadBezier;
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
require(ReplicatedStorage2.Shared.utils.countStyleMastery);
local _ = Players.LocalPlayer;
local _ = ClientGlobals.PlayerData;
local _ = workspace.CurrentCamera;

return function() -- Line: 38
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local OppositeDirection = AbilityBalancing.OppositeDirection;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(3))) then
        return;
    end;

    local Character, u1, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    interface:AbilityCooldown(3, OppositeDirection.Cooldown);
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 55
        -- upvalues: StatesController (ref)
        print("Ended");
        StatesController.OwnWalkState = false;
        StatesController.States.Ability = false;
    end);
    ABC:Add(task.delay(0.25, function() -- Line: 61
        -- upvalues: StatesController (ref)
        StatesController.OwnWalkState = true;
    end));
    ABC:Add(task.delay(0.5, function() -- Line: 65
        -- upvalues: Character (copy), u1 (copy), interface (ref), AbilityUtils (ref), ABC (copy), AnimationController (ref)
        local v2 = Character.HumanoidRootPart.CFrame:vectorToObjectSpace(Character.Humanoid.MoveDirection);
        local v3 = v2.Z < -0.45 and u1.CFrame.LookVector;

        if not v3 then
            if math.abs(v2.X) > v2.Z then
                v3 = u1.CFrame.RightVector * math.round(v2.X);
            else
                v3 = false;
            end;
        end;

        if v3 then
            local v4;

            if v2.Z < -0.45 then
                v4 = "Forward";
            elseif math.abs(v2.X) > v2.Z then
                v4 = v2.X > 0 and "Right" or (v2.X < 0 and "Left" or false);
            else
                v4 = false;
            end;

            interface.AbilityService.Ability:Fire("DribbleZone", {
                Type = "Dash",
                Side = v4
            });
            local Unit = Vector3.new(v3.X, 0, v3.Z).Unit;
            local v5, v6 = AbilityUtils.FastDashTo(Character, u1.Position + Unit * 60, -2, 0.4);
            ABC:Add(v5);
            ABC:Add(v6);
            local Track = AnimationController:GetTrack("Abilities", "DribbleZone" .. v4 .. "Clone");
            Track.Looped = false;
            Track.Priority = Enum.AnimationPriority.Action3;
            Track:Play();
        end;
    end));
    interface.AbilityService.Ability:Fire("DribbleZone");
    ABC:Add(task.delay(0.9, function() -- Line: 93
        -- upvalues: ABC (copy)
        ABC:Clean();
    end));
end;
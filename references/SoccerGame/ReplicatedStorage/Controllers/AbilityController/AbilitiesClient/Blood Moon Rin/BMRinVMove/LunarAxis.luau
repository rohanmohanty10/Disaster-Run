  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
require(ReplicatedStorage.Controllers.StylePassiveController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
require(ReplicatedStorage.Packages.Trove);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Spring);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Shared.AbilityCleanupTrove);
require(ReplicatedStorage.Packages.Observers);
local getPlayerTarget = require(ReplicatedStorage.Modules.getPlayerTarget);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function(u1, p2, u3) -- Line: 23
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), StatesController (copy), AnimationController (copy), ReplicatedStorage (copy), RunService (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy)
    local LunarAxis = AbilityBalancing.LunarAxis;
    u1:AbilityCooldown(2, LunarAxis.Cooldown);
    local ABC = u1.ABC;
    local _, u4, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 34
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "LunarAxis");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    u1.AbilityService.Ability:Fire("LunarAxis", {
        Type = "Effect"
    });
    u1.ABC:Connect(u1.AbilityService.Ability, function() -- Line: 46
        -- upvalues: u1 (copy), ReplicatedStorage (ref)
        u1.BallController:DragBall(ReplicatedStorage.Football.Value);
    end);
    task.delay(0.3, function() -- Line: 50
        -- upvalues: u4 (copy), LunarAxis (copy), AbilityUtils (ref), u3 (copy), ABC (copy), RunService (ref), getPlayerTarget (ref), Players (ref), LocalPlayer (ref), u1 (copy)
        local LookVector = u4.CFrame.LookVector;
        local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
        local v5, v6 = AbilityUtils.FastDashTo(u3, u4.Position + Unit * LunarAxis.TravelDistance, -2, 0.1);
        ABC:Add(v5);
        ABC:Add(v6);
        local u7 = nil;
        tick();
        ABC:Connect(RunService.Heartbeat, function() -- Line: 62
            -- upvalues: u7 (ref), getPlayerTarget (ref), u4 (ref), LunarAxis (ref), Players (ref), LocalPlayer (ref), u1 (ref), ABC (ref)
            u7 = getPlayerTarget(false, function(p8, p9) -- Line: 63
                -- upvalues: u4 (ref), LunarAxis (ref), Players (ref), LocalPlayer (ref)
                if p8:GetAttribute("IsTrainingDummy") then
                    return (p8.HumanoidRootPart.Position - u4.Position).Magnitude <= LunarAxis.ActivationRangePlayer;
                end;

                local PlayerFromCharacter = Players:GetPlayerFromCharacter(p8);

                if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p8.HumanoidRootPart.Position - u4.Position).Magnitude <= LunarAxis.ActivationRangePlayer and not (p8.Values.Goalie.Value and p8.Values.IsInPenalty.Value))) then
                    return true;
                end;
            end);

            if u7 then
                u1.AbilityService.Ability:Fire("LunarAxis", {
                    target = u7
                });
                ABC:Clean();
            end;
        end);
    end);
    task.delay(0.5, function() -- Line: 81
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;
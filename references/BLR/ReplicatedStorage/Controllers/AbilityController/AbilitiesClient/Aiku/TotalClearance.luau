  

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

return function(u1, p2, p3) -- Line: 23
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), StatesController (copy), AnimationController (copy), RunService (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy)
    local TotalClearance = AbilityBalancing.TotalClearance;
    AbilityUtils.rules.offball(nil, false);

    if not (AbilityUtils.rules.grounded() and (AbilityUtils.rules.offball() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    u1:AbilityCooldown(2, TotalClearance.Cooldown);
    local ABC = u1.ABC;
    local _, u4, _, _ = AbilityUtils.getCharacter();
    StatesController.States.Ability = true;
    ABC:Add(function() -- Line: 43
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    local Track = AnimationController:GetTrack("Abilities", "TotalClearance");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    u1.AbilityService.Ability:Fire("TotalClearance", {
        Type = "Effect"
    });
    local LookVector = u4.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local v5, v6 = AbilityUtils.FastDashTo(p3, u4.Position + Unit * TotalClearance.TravelDistance, -2, 0.4);
    ABC:Add(v5);
    ABC:Add(v6);
    local u7 = nil;
    tick();
    ABC:Connect(RunService.Heartbeat, function() -- Line: 66
        -- upvalues: u7 (ref), getPlayerTarget (ref), u4 (copy), TotalClearance (copy), Players (ref), LocalPlayer (ref), u1 (copy), ABC (copy), RunService (ref)
        u7 = getPlayerTarget(false, function(p8, p9) -- Line: 67
            -- upvalues: u4 (ref), TotalClearance (ref), Players (ref), LocalPlayer (ref)
            if p8:GetAttribute("IsTrainingDummy") then
                return (p8.HumanoidRootPart.Position - u4.Position).Magnitude <= TotalClearance.ActivationRangePlayer;
            end;

            local PlayerFromCharacter = Players:GetPlayerFromCharacter(p8);

            if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p8.HumanoidRootPart.Position - u4.Position).Magnitude <= TotalClearance.ActivationRangePlayer and not (PlayerFromCharacter.Character.Values.Goalie.Value and PlayerFromCharacter.Character.Values.IsInPenalty.Value))) then
                return true;
            end;
        end);

        if u7 then
            u1.AbilityService.Ability:Fire("TotalClearance", {
                target = u7
            });
            ABC:Clean();
        end;

        if RunService:IsStudio() then
            u1.AbilityService.Ability:Fire("TotalClearance", {
                target = workspace.PassRig
            });
            ABC:Clean();
        end;
    end);
    task.delay(0.5, function() -- Line: 88
        -- upvalues: ABC (copy)
        ABC:Clean();
    end);
end;
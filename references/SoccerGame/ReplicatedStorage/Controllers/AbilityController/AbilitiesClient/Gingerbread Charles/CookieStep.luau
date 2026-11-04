  

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
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage2.Controllers.AnimationController);
require(ReplicatedStorage2.Controllers.CameraController);
require(ReplicatedStorage2.Controllers.BallController);
local getPlayerTarget = require(ReplicatedStorage2.Modules.getPlayerTarget);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 29
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy), RunService (copy), getPlayerTarget (copy), Players (copy), LocalPlayer (copy)
    local CookieStep = AbilityBalancing.CookieStep;

    if AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        interface.CookieStep = false;
        interface:AbilityCooldown(1, CookieStep.Cooldown);
        local Character, u1, v2, _ = AbilityUtils.getCharacter();
        local ABC = interface.ABC;
        local _ = v2.MoveDirection.Unit;
        StatesController.States.Ability = true;
        AnimationController:StopAnims();
        local Track = AnimationController:GetTrack("Abilities", "CookieStep");
        Track.Looped = false;
        Track.Priority = Enum.AnimationPriority.Action3;
        Track:Play();
        local BallTrack = AnimationController:GetBallTrack("CookieStepBall");
        BallTrack.Looped = false;
        BallTrack.Priority = Enum.AnimationPriority.Action4;
        BallTrack:Play();
        interface.AbilityService.Ability:Fire("CookieStep");
        ABC:Add(task.delay(0.15, function() -- Line: 64
            -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), CookieStep (copy), ABC (copy), RunService (ref), getPlayerTarget (ref), Players (ref), LocalPlayer (ref), interface (ref)
            local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + (u1.CFrame.RightVector + u1.CFrame.LookVector * 0.5) * CookieStep.Distance, 2, 0.3);
            ABC:Add(v3);
            ABC:Add(v4);
            ABC:Connect(RunService.Heartbeat, function() -- Line: 71
                -- upvalues: getPlayerTarget (ref), Players (ref), LocalPlayer (ref), u1 (ref), CookieStep (ref), interface (ref)
                local v7 = getPlayerTarget(false, function(p5, p6) -- Line: 72
                    -- upvalues: Players (ref), LocalPlayer (ref), u1 (ref), CookieStep (ref)
                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p5);

                    if PlayerFromCharacter and (PlayerFromCharacter.Team ~= LocalPlayer.Team and ((p5.HumanoidRootPart.Position - u1.Position).Magnitude <= CookieStep.ActivationRangePlayer and not (p5.Values.Goalie.Value and p5.Values.IsInPenalty))) then
                        return true;
                    end;
                end);

                if v7 then
                    interface.AbilityService.Ability:Fire("CookieStep", v7);
                end;
            end);
        end));
        ABC:Add(function() -- Line: 86
            -- upvalues: StatesController (ref)
            StatesController.States.Ability = false;
        end);
        ABC:Add(task.delay(0.5, function() -- Line: 90
            -- upvalues: ABC (copy)
            ABC:Clean();
        end));

        return true;
    end;
end;
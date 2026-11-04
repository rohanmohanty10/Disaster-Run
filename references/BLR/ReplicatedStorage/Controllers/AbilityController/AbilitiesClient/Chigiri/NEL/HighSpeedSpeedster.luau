  

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
require(ReplicatedStorage2.Shared.AbilityUtils);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 27, Name: Speedster
    -- upvalues: AbilityUtils (copy), AbilityBalancing (copy), LocalPlayer (copy), interface (copy), AnimationController (copy), StatesController (copy), RunService (copy)
    local Character, _, _, _ = AbilityUtils.getCharacter();
    local HighSpeedSpeedster = AbilityBalancing.HighSpeedSpeedster;

    if LocalPlayer.Team == game.Teams.Visitor then
        return;
    end;

    if LocalPlayer.PlayerStats.Stamina.Value <= HighSpeedSpeedster.Stamina then
        return;
    end;

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    if interface.AbilityThree - tick() < 3 then
        interface:AbilityCooldown(3, 3);
    end;

    interface:AbilityCooldown(1, HighSpeedSpeedster.MoveSpeedDuration);
    interface.StaminaService.DecreaseStamina:Fire(HighSpeedSpeedster.Stamina);
    local ABC = interface.ABC;
    local Track = AnimationController:GetTrack("Abilities", "KingsRun");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    StatesController.SpeedBoost = HighSpeedSpeedster.MoveSpeedValue;
    ABC:Connect(RunService.Heartbeat, function() -- Line: 63
        -- upvalues: LocalPlayer (ref), Character (copy), Track (copy)
        if LocalPlayer == nil then
            return;
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            return;
        end;

        if Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude >= 5 then
            if Track.IsPlaying == false then
                Track:Play();
            end;
        else
            Track:Stop();
        end;
    end);
    interface.ParkourShot = true;
    local u2 = tick() + 4;
    local u3 = false;

    local function cleanup() -- Line: 92
        -- upvalues: u3 (ref), StatesController (ref), Track (copy), ABC (copy), u2 (copy), interface (ref), HighSpeedSpeedster (copy)
        if u3 then
            return;
        end;

        u3 = true;
        xpcall(function() -- Line: 97
            -- upvalues: StatesController (ref), Track (ref), ABC (ref), u2 (ref), interface (ref), HighSpeedSpeedster (ref)
            StatesController.States.Ability = false;
            StatesController.SpeedBoost = 0;
            Track:Stop();
            StatesController.OwnWalkState = false;
            StatesController.SpeedBoost = 0;
            ABC:Clean();

            if u2 <= tick() then
                task.delay(1.4, function() -- Line: 109
                    -- upvalues: interface (ref), HighSpeedSpeedster (ref)
                    if interface.ParkourShot then
                        interface.ParkourShot = false;
                        interface:AbilityCooldown(1, HighSpeedSpeedster.Cooldown);
                    end;
                end);

                return;
            end;

            interface.ParkourShot = false;
            interface:AbilityCooldown(1, HighSpeedSpeedster.Cooldown);
        end, warn);
    end;

    ABC:Add(task.spawn(function() -- Line: 121
        -- upvalues: HighSpeedSpeedster (copy), u3 (ref), StatesController (ref), Track (copy), ABC (copy), u2 (copy), interface (ref)
        task.wait(HighSpeedSpeedster.MoveSpeedDuration);

        if u3 then
            return;
        end;

        u3 = true;
        xpcall(function() -- Line: 97
            -- upvalues: StatesController (ref), Track (ref), ABC (ref), u2 (ref), interface (ref), HighSpeedSpeedster (ref)
            StatesController.States.Ability = false;
            StatesController.SpeedBoost = 0;
            Track:Stop();
            StatesController.OwnWalkState = false;
            StatesController.SpeedBoost = 0;
            ABC:Clean();

            if u2 <= tick() then
                task.delay(1.4, function() -- Line: 109
                    -- upvalues: interface (ref), HighSpeedSpeedster (ref)
                    if interface.ParkourShot then
                        interface.ParkourShot = false;
                        interface:AbilityCooldown(1, HighSpeedSpeedster.Cooldown);
                    end;
                end);

                return;
            end;

            interface.ParkourShot = false;
            interface:AbilityCooldown(1, HighSpeedSpeedster.Cooldown);
        end, warn);
    end));
    ABC:Add(cleanup);
    interface.AbilityService.Ability:Fire("Speedster", true);
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local StatesController = require(ReplicatedStorage.Controllers.StatesController);
local AnimationController = require(ReplicatedStorage.Controllers.AnimationController);
require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Controllers.BallController);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 27
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), ReplicatedStorage (copy), LocalPlayer (copy), interface (copy), StatesController (copy), AnimationController (copy), RunService (copy)
    local BunnyHopTrap = AbilityBalancing.BunnyHopTrap;

    if not (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(1)) then
        return;
    end;

    if ReplicatedStorage.Football.Value.Anchored then
        return;
    end;

    if ReplicatedStorage.GameValues.AbilityDb.Value > workspace:GetServerTimeNow() then
        return;
    end;

    if LocalPlayer.Character:GetAttribute("Trapped") then
        return;
    end;

    local Character, _, _, _ = AbilityUtils.getCharacter();
    local ABC = interface.ABC;
    interface:AbilityCooldown(1, 1.5);
    interface.TrapShot = true;
    StatesController.States.Ability = true;
    local Value = Character.Values.HasBall.Value;
    interface.AbilityService.Ability:Fire("BunnyHopTrap");

    for _, descendant in Character.HumanoidRootPart:GetDescendants() do
        if descendant:IsA("BodyMover") then
            descendant:Destroy();
        end;
    end;

    local Track = AnimationController:GetTrack("Abilities", "BunnyHopTrap");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    local BallTrack = AnimationController:GetBallTrack("BunnyHopTrapBall");
    BallTrack.Looped = true;
    BallTrack.Priority = Enum.AnimationPriority.Action3;
    BallTrack:Play();
    task.delay(0.5, function() -- Line: 75
        -- upvalues: interface (ref), ABC (copy), RunService (ref), Character (copy), StatesController (ref), Value (ref), BallTrack (copy), Track (copy)
        interface.JustOne = tick() + 0.3;
        ABC:Connect(RunService.Heartbeat, function() -- Line: 77
            -- upvalues: Character (ref), ABC (ref), StatesController (ref), interface (ref), Value (ref), BallTrack (ref), Track (ref)
            if Character ~= nil then
                if tick() >= interface.JustOne or (StatesController.States.Ability == false or Character.Values.HasBall.Value == false and Value) then
                    ABC:Clean();
                end;

                if Character.Values.HasBall.Value then
                    BallTrack:Play();
                    Track:AdjustSpeed(0);
                    Value = true;
                end;

                return;
            end;

            print("CLEAn");

            if ABC then
                ABC:Clean();
            end;

            StatesController.States.Ability = false;
        end);
    end);
    task.delay(3, function() -- Line: 101
        -- upvalues: Track (copy), BallTrack (copy), ABC (copy), interface (ref)
        Track:Stop();
        BallTrack:Stop();

        if ABC and not interface.Shooting then
            ABC:Clean();
        end;
    end);
    ABC:Add(function() -- Line: 109
        -- upvalues: Value (ref), interface (ref), BunnyHopTrap (copy), StatesController (ref)
        task.delay(1.4, function() -- Line: 115
            -- upvalues: interface (ref), BunnyHopTrap (ref)
            if interface.TrapShot and not interface.Shooting then
                interface.TrapShot = false;
                interface:AbilityCooldown(1, BunnyHopTrap.Cooldown);
            end;
        end);
        StatesController.States.Ability = false;
    end);
end;
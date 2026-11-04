  

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
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;

return function() -- Line: 33
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), interface (copy), StatesController (copy), AnimationController (copy)
    local MagicianMirage = AbilityBalancing.MagicianMirage;

    if not (AbilityUtils.rules.onball() and (AbilityUtils.rules.grounded() and AbilityUtils.rules.slotReady(2))) then
        return;
    end;

    local Character, u1, v2, _ = AbilityUtils.getCharacter();
    interface:AbilityCooldown(2, 2);
    local ABC = interface.ABC;
    local _ = v2.MoveDirection.Unit;
    StatesController.States.Ability = true;
    interface.AbilityService.Ability:Fire("MagicianMirage");
    local Track = AnimationController:GetTrack("Abilities", "MagicianMirage");
    Track.Looped = false;
    Track.Priority = Enum.AnimationPriority.Action3;
    Track:Play();
    ABC:Add(task.delay(0.1, function() -- Line: 63
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), MagicianMirage (copy), ABC (copy)
        local v3, v4 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.RightVector * (MagicianMirage.Distance / 2), 2, 0.4);
        ABC:Add(v3);
        ABC:Add(v4);
    end));
    ABC:Add(task.delay(0.75, function() -- Line: 71
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), MagicianMirage (copy), ABC (copy)
        local v5, v6 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.LookVector.Unit * (MagicianMirage.Distance / 2), 2, 0.3);
        ABC:Add(v5);
        ABC:Add(v6);
    end));
    ABC:Add(task.delay(1.5, function() -- Line: 80
        -- upvalues: u1 (copy), AbilityUtils (ref), Character (copy), MagicianMirage (copy), ABC (copy)
        local v7, v8 = AbilityUtils.FastDashTo(Character, u1.Position + u1.CFrame.LookVector.Unit * MagicianMirage.Distance, 2, 0.3);
        ABC:Add(v7);
        ABC:Add(v8);
    end));
    ABC:Add(function() -- Line: 89
        -- upvalues: StatesController (ref)
        StatesController.States.Ability = false;
    end);
    interface.FlexibleSpell = true;
    ABC:Add(task.delay(1.9, function() -- Line: 95
        -- upvalues: ABC (copy), interface (ref), MagicianMirage (copy)
        ABC:Clean();
        task.wait(4);

        if interface.FlexibleSpell then
            interface.FlexibleSpell = false;
            interface:AbilityCooldown(2, MagicianMirage.Cooldown);
        end;
    end));
end;
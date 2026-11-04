  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local StatesController = require(ReplicatedStorage2.Controllers.StatesController);
local Passive_LandingMetavision = require(ReplicatedStorage2.Controllers.StylePassiveController.Passive_LandingMetavision);
local Passive_CooldownMetavision = require(ReplicatedStorage2.Controllers.StylePassiveController.Passive_CooldownMetavision);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;

local function cleanupMetavision() -- Line: 33
    -- upvalues: u1 (ref)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;
end;

local function enableMetavision() -- Line: 40
    -- upvalues: u1 (ref), LocalPlayer (copy), Trove (copy), Passive_LandingMetavision (copy), Passive_CooldownMetavision (copy), StatesController (copy)
    if u1 then
        u1:Destroy();
        u1 = nil;
    end;

    if not LocalPlayer.Character then
        return;
    end;

    local u2 = Trove.new();
    u1 = u2;
    local u3 = select(1, Passive_LandingMetavision:hook());
    local u4 = select(1, Passive_CooldownMetavision:hook());

    if u3 then
        u2:Add(function() -- Line: 55
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
    end;

    if u4 then
        u2:Add(function() -- Line: 61
            -- upvalues: u4 (copy)
            u4:Destroy();
        end);
    end;

    u2:Add(function() -- Line: 66
        -- upvalues: u1 (ref), u2 (copy), StatesController (ref)
        if u1 == u2 then
            u1 = nil;
        end;

        StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionEnd");
    end);
    u2:Add(LocalPlayer.CharacterRemoving:Connect(function() -- Line: 73
        -- upvalues: u1 (ref)
        if u1 then
            u1:Destroy();
            u1 = nil;
        end;
    end));
    StatesController.CharacterEvents.CustomEvent:Fire("CooldownMetavisionStart");
    task.delay(60, function() -- Line: 79
        -- upvalues: u1 (ref), u2 (copy)
        if u1 == u2 and u1 then
            u1:Destroy();
            u1 = nil;
        end;
    end);
end;

return function() -- Line: 86
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy), enableMetavision (copy)
    local RavenAwaken = AbilityBalancing.RavenAwaken;

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(1))) then
        return;
    end;

    interface.AbilityService.Ability:Fire(script.Name);
    AbilityUtils.clientCutsceneSkill(interface, RavenAwaken, 15, 1, false);
    task.delay(10, function() -- Line: 106
        -- upvalues: LocalPlayer (ref), enableMetavision (ref)
        if LocalPlayer.Character then
            enableMetavision();
        end;
    end);
end;
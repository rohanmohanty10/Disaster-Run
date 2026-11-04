  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 23
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), interface (copy)
    local ReoDragonDrive = AbilityBalancing.ReoDragonDrive;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.airBall(LocalPlayer, 100) and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    interface.AbilityService.Ability:Fire("ReoDragonDrive");
    AbilityUtils.clientCutsceneSkill(interface, ReoDragonDrive, 20, 3, true, workspace.CurrentCamera.CFrame.LookVector);
end;
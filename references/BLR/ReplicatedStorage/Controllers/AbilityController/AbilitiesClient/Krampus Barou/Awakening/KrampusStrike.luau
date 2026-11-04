  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 32
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), RunService (copy), interface (copy)
    local KrampusStrike = AbilityBalancing.KrampusStrike;
    local v1 = AbilityUtils.rules.enemyTarget(KrampusStrike.Range);

    if not (v1 and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.onball(LocalPlayer) and AbilityUtils.rules.slotReady(1)))) then
        return;
    end;

    if RunService:IsStudio() then
        v1 = nil;
    end;

    LocalPlayer.Character:SetAttribute("PredatorKrampus", nil);
    interface.AbilityService.Ability:Fire("KrampusStrike", v1);
    AbilityUtils.clientCutsceneSkill(interface, KrampusStrike, 25, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;
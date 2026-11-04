  

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
require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage2.Shared.AbilityUtils);
require(ReplicatedStorage2.AbilityBalancing);
local _ = workspace.CurrentCamera;
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
local interface = require(ReplicatedStorage.Controllers.AbilityController.interface);
local LocalPlayer = Players.LocalPlayer;

return function() -- Line: 28
    -- upvalues: AbilityBalancing (copy), AbilityUtils (copy), LocalPlayer (copy), ReplicatedStorage2 (copy), interface (copy)
    local ReoSerpentRedirect = AbilityBalancing.ReoSerpentRedirect;

    if not (AbilityUtils.rules.offball(LocalPlayer) and (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.airBall(LocalPlayer, 80) and AbilityUtils.rules.slotReady(3)))) then
        return;
    end;

    local Value = ReplicatedStorage2.Football.Value;
    local Unit = (AbilityUtils.clientAimTarget() - Value.Position).Unit;
    interface.AbilityService.Ability:Fire("ReoSnakeRedirect");
    AbilityUtils.clientCutsceneSkill(interface, ReoSerpentRedirect, 12, 3, true, Unit);
end;
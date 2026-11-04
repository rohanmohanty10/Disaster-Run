  

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
    -- upvalues: AbilityBalancing (copy), ReplicatedStorage (copy), LocalPlayer (copy), AbilityUtils (copy), RunService (copy), interface (copy)
    local PlanetHotline = AbilityBalancing.PlanetHotline;
    local Value = ReplicatedStorage.Football.Value;
    local v1;

    if Value then
        v1 = Value.Char.Value;
    else
        v1 = Value;
    end;

    local v2;

    if v1 then
        v2 = v1:GetAttribute("IsTrainingDummy");
    else
        v2 = v1;
    end;

    local v3 = nil;

    if v2 and Value.OnPlayer.Value then
        local Character = LocalPlayer.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        local v4;

        if v1 then
            v4 = v1:FindFirstChild("HumanoidRootPart");
        else
            v4 = v1;
        end;

        if Character and v4 then
            if (v4.Position - Character.Position).Magnitude > PlanetHotline.Range then
                v1 = v3;
            end;
        else
            v1 = v3;
        end;
    else
        v1 = AbilityUtils.rules.ballTeammate(LocalPlayer, PlanetHotline.Range);
    end;

    print(v1);

    if not (AbilityUtils.rules.grounded(LocalPlayer) and (AbilityUtils.rules.offball(LocalPlayer) and (v1 and AbilityUtils.rules.slotReady(1)))) then
        return;
    end;

    print("ah");

    if RunService:IsStudio() then
        v1 = nil;
    end;

    interface.AbilityService.Ability:Fire(script.Name, v1);
    AbilityUtils.clientCutsceneSkill(interface, PlanetHotline, 30, 1, true, workspace.CurrentCamera.CFrame.LookVector);
end;
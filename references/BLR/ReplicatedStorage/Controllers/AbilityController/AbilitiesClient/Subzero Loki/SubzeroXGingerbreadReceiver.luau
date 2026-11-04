  

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
local AbilityUtils = require(ReplicatedStorage.Shared.AbilityUtils);
local AbilityBalancing = require(ReplicatedStorage.AbilityBalancing);
require(ReplicatedStorage.Controllers.AnimationController);
local interface = require(ReplicatedStorage2.Controllers.AbilityController.interface);
local _ = Players.LocalPlayer;

return function(p1, p2, p3, p4, p5) -- Line: 31
    -- upvalues: AbilityBalancing (copy), Players (copy), AbilityUtils (copy), interface (copy)
    local SubzeroXGBCharles = AbilityBalancing.SubzeroXGBCharles;
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p4);

    if not (p4 and PlayerFromCharacter) then
        return;
    end;

    if PlayerFromCharacter.Team ~= p2.Team then
        return;
    end;

    if p3 then
        p3 = p3:FindFirstChild("HumanoidRootPart");
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v6 = workspace_CurrentCamera and workspace_CurrentCamera.CFrame.LookVector;

    if v6 then
        p3 = v6;
    elseif p3 then
        p3 = p3.CFrame.LookVector;
    end;

    if not p3 then
        return;
    end;

    if typeof(p5) ~= "function" then
        return;
    end;

    local success, result = pcall(p5);

    if not (success and (typeof(result) == "table" and result.Ok == true)) then
        return;
    end;

    AbilityUtils.clientCutsceneSkill(interface, SubzeroXGBCharles, 25, nil, true, p3);
end;
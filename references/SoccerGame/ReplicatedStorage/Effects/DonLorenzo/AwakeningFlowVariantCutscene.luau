  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(p1) -- Line: 7
    -- upvalues: Players (copy), SpectatorController (copy), Essentials (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local v2;

    if Char then
        v2 = Char:FindFirstChild("HumanoidRootPart");
    else
        v2 = Char;
    end;

    local v3;

    if Char then
        v3 = Char:FindFirstChildOfClass("Humanoid");
    else
        v3 = Char;
    end;

    if not (v2 and v3) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local Massless = v2.Massless;
    local Archivable = Char.Archivable;
    local v4 = {};

    for _, v in { Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.Climbing } do
        v4[v] = v3:GetStateEnabled(v);
    end;

    local v5 = Essentials:HideCosmetics(Char);
    local v7, v8 = xpcall(function() -- Line: 22
        -- upvalues: CutsceneUtils (ref), Char (copy)
        local v6 = require(script.Subtitles)({
            Name = "Don Lorenzo",
            Icon = ""
        });
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene(Char, {
            lorenzo = Char
        }, "Don LorenzoAwakeningFlowVariant", script.CodeEvents, nil, v6, script.SoundEvents);
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v5);
    workspace_CurrentCamera.FieldOfView = FieldOfView;

    if v2.Parent then
        v2.Massless = Massless;
    end;

    if Char.Parent then
        Char.Archivable = Archivable;
    end;

    if v3.Parent then
        for i, v in v4 do
            v3:SetStateEnabled(i, v);
        end;
    end;

    if not v7 then
        warn("[LorenzoAwakeningFlowVariant] " .. tostring(v8));
    end;
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 7
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    local u2 = p1.EnemyChar or p1.enemy;
    local v3;

    if Char then
        v3 = Char:FindFirstChild("HumanoidRootPart");
    else
        v3 = Char;
    end;

    local v4;

    if Char then
        v4 = Char:FindFirstChildOfClass("Humanoid");
    else
        v4 = Char;
    end;

    if not (v3 and v4) then
        return;
    end;

    local v5 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Values");

    if v5 then
        v5 = v5:FindFirstChild("Goalie");
    end;

    if v5 and (v5.Value and (Char ~= LocalPlayer.Character and u2 ~= LocalPlayer.Character)) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local Anchored = v3.Anchored;
    local Massless = v3.Massless;
    local Archivable = Char.Archivable;
    local v6;

    if u2 then
        v6 = u2.Archivable;
    else
        v6 = u2;
    end;

    local v7 = {};

    for _, v in { Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.Climbing } do
        v7[v] = v4:GetStateEnabled(v);
    end;

    local v9, v10 = xpcall(function() -- Line: 28
        -- upvalues: CutsceneUtils (ref), Char (copy), u2 (copy)
        local v8 = require(script.Subtitles)({
            Name = "Don Lorenzo",
            Icon = ""
        });
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene(Char, {
            Rekysui = Char,
            MitaFbx = u2
        }, "Don LorenzoYoMichael", script.CodeEvents, nil, v8, script.SoundEvents);
    end, debug.traceback);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if workspace_CurrentCamera.Parent then
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end;

    if v3.Parent then
        v3.Anchored = Anchored;
        v3.Massless = Massless;
    end;

    if Char.Parent then
        Char.Archivable = Archivable;
    end;

    if u2 and u2.Parent then
        u2.Archivable = v6;
    end;

    if v4.Parent then
        for i, v in v7 do
            v4:SetStateEnabled(i, v);
        end;
    end;

    if not v9 then
        warn("[YoMichael] " .. tostring(v10));
    end;
end;
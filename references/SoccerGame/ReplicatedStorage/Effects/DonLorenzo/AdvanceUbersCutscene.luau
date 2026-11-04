  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local script_CameraPlayback = require(script.CameraPlayback);

return function(p1) -- Line: 8
    -- upvalues: Players (copy), SpectatorController (copy), script_CameraPlayback (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    local LocalPlayer = Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
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

    local u4 = p1.Teammates or {};
    local v5 = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Values");

    if v5 and (v5.Goalie.Value and (LocalPlayer.Character ~= Char and not table.find(u4, LocalPlayer.Character))) then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = workspace_CurrentCamera.FieldOfView;
    local Massless = v2.Massless;
    local v6 = {};

    for _, v in { Char, table.unpack(u4) } do
        v6[v] = v.Archivable;
    end;

    local v7 = {};

    for _, v in { Enum.HumanoidStateType.FallingDown, Enum.HumanoidStateType.Physics, Enum.HumanoidStateType.Climbing } do
        v7[v] = v3:GetStateEnabled(v);
    end;

    local v9, v10 = xpcall(function() -- Line: 31
        -- upvalues: script_CameraPlayback (ref), Char (copy), CutsceneUtils (ref), u4 (copy)
        script_CameraPlayback.Prepare(Char);
        local v8 = require(script.Subtitles)({
            Name = "Don Lorenzo",
            Icon = ""
        });
        CutsceneUtils.ChangeLighting(script.LightingConfig);
        CutsceneUtils.PlayCutscene(Char, {
            Rekysui = Char,
            npc1 = u4[1],
            npc2 = u4[2]
        }, "Don LorenzoAdvanceUbers", script.CodeEvents, nil, v8, script.SoundEvents);
    end, debug.traceback);
    script_CameraPlayback.Stop();
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);

    if workspace_CurrentCamera.Parent then
        workspace_CurrentCamera.FieldOfView = FieldOfView;
    end;

    if v2.Parent then
        v2.Massless = Massless;
    end;

    for i, v in v6 do
        if i.Parent then
            i.Archivable = v;
        end;
    end;

    if v3.Parent then
        for i, v in v7 do
            v3:SetStateEnabled(i, v);
        end;
    end;

    if not v9 then
        warn("[AdvanceUbers] " .. tostring(v10));
    end;
end;
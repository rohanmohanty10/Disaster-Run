  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local SubtitleIcons = require(ReplicatedStorage.Modules.CutsceneUtils.SubtitleIcons);

return function(p1) -- Line: 10
    -- upvalues: Players (copy), SpectatorController (copy), SubtitleIcons (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local v2 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (PlayerFromCharacter and v.Team ~= PlayerFromCharacter.Team) then
            v2 = v.Character;
            break;
        end;
    end;

    local v3 = {
        Name = Char.Name,
        Icon = SubtitleIcons.Reo
    };
    local v4 = require(script.Subtitles)(v3);
    local u5 = RunService.Heartbeat:Connect(function() -- Line: 33
        workspace.CurrentCamera.FieldOfView = 15;
    end);
    task.delay(3, function() -- Line: 36
        -- upvalues: u5 (ref)
        u5:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        ["Trial shenanigans"] = Char,
        R6 = v2
    }, "NEL ReoStrikeAwk", script.CodeEvents, nil, v4, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
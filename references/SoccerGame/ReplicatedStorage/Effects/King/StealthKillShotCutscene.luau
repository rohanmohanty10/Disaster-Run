  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local u1 = { "npc2", "npc3", "npc4", "npc5", "npc6", "npc7" };

return function(p2) -- Line: 10
    -- upvalues: Players (copy), SpectatorController (copy), u1 (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p2.Char;

    if not Char then
        return;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local v3 = {};

    if PlayerFromCharacter then
        for _, v in Players:GetPlayers() do
            if v ~= PlayerFromCharacter and (v.Character and (v.Team == PlayerFromCharacter.Team and v.Team ~= game.Teams.Visitor)) then
                table.insert(v3, v.Character);
            end;
        end;
    end;

    local v4 = {
        Rekysui = Char
    };

    for i, v in u1 do
        if v3[i] then
            v4[v] = v3[i];
        end;
    end;

    local v5 = require(script.Subtitles)({
        Name = "Barou",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, v4, "KingStealthKillShot", script.CodeEvents, 19.666666666666668, v5, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
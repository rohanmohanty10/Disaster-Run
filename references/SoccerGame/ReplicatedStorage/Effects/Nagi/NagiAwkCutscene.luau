  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 9
    -- upvalues: Players (copy), SpectatorController (copy), RunService (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = {
        Icon = "rbxassetid://132221246687326",
        Name = Char.Name
    };
    local v3 = require(script.Subtitles)(v2);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 24
        workspace.CurrentCamera.FieldOfView = 20;
    end);
    task.delay(1, function() -- Line: 27
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and v.Team ~= PlayerFromCharacter.Team then
            v5 = v.Character;
            break;
        end;
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        nagi = Char,
        isagi = v5
    }, "NagiLegAwk", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
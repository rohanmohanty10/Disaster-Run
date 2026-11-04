  

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
        Icon = "rbxassetid://71078596127903",
        Name = Char.Name
    };
    local v3 = require(script.Subtitles)(v2);
    local u4 = RunService.Heartbeat:Connect(function() -- Line: 22
        workspace.CurrentCamera.FieldOfView = 15;
    end);
    task.delay(3, function() -- Line: 25
        -- upvalues: u4 (ref)
        u4:Disconnect();
    end);
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and v.Team ~= PlayerFromCharacter.Team then
            v5 = v.Character;
            break;
        end;
    end;

    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        ["Trial shenanigans"] = Char,
        R6 = v5
    }, "NagiEffortlessMiracle", script.CodeEvents, nil, v3, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
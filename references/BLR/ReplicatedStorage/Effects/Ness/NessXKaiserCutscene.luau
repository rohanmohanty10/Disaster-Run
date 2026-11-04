  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
require(ReplicatedStorage.Shared.SoundManager);
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

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(Char);

    if not PlayerFromCharacter then
        return;
    end;

    local v2 = {};

    for _, v in Players:GetPlayers() do
        if v.Team ~= game.Teams.Visitor and (v.Team ~= PlayerFromCharacter.Team and v.Character) then
            table.insert(v2, v.Character);

            if #v2 == 2 then
                break;
            end;
        end;
    end;

    local v3 = {
        Kaiser = Char
    };

    if v2[1] then
        v3.random = v2[1];
    end;

    if v2[2] then
        v3.random2 = v2[2];
    end;

    local TeammateChar = p1.TeammateChar;
    local v4 = TeammateChar and TeammateChar.Name or "Ness";
    local v5 = {
        {
            Timestamp = "1:00",
            Duration = 1,
            Text = "Give me the ball",
            Speaker = v4,
            Color = Color3.fromRGB(120, 120, 120)
        },
        {
            Timestamp = "3:00",
            Duration = 2.5,
            Text = "Let\'s make the impossible",
            Speaker = v4,
            Color = Color3.fromRGB(120, 120, 120)
        },
        {
            Timestamp = "6:50",
            Duration = 2.5,
            Text = "The magician will always have your back",
            Speaker = v4,
            Color = Color3.fromRGB(255, 0, 179)
        }
    };
    local u6 = RunService.Heartbeat:Connect(function() -- Line: 72
        workspace.CurrentCamera.FieldOfView = 15;
    end);
    task.delay(1, function() -- Line: 75
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, v3, "NessXKaiserCR", script.CodeEvents, nil, v5, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

local function findClosestEnemies(p1, p2) -- Line: 8
    -- upvalues: Players (copy)
    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p1);
    local v3 = {};

    for _, v in Players:GetPlayers() do
        if v ~= PlayerFromCharacter and (v.Team ~= game.Teams:FindFirstChild("Visitor") and (not PlayerFromCharacter or v.Team ~= PlayerFromCharacter.Team)) then
            local Character = v.Character;

            if Character and Character:FindFirstChild("HumanoidRootPart") then
                local v4 = Character:FindFirstChildOfClass("Humanoid");

                if v4 and v4.Health > 0 then
                    table.insert(v3, Character);
                end;
            end;
        end;
    end;

    local v5 = {};

    for i = 1, p2 do
        local _ = i;
        local v6 = (1 / 0);
        local v7 = nil;

        for _, v in v3 do
            local Magnitude = (p1.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude;

            if Magnitude < v6 then
                v7 = v;
                v6 = Magnitude;
            end;
        end;

        if not v7 then
            break;
        end;

        table.insert(v5, v7);
        local table_find_ret = table.find(v3, v7);

        if table_find_ret then
            table.remove(v3, table_find_ret);
        end;
    end;

    return v5;
end;

return function(p8) -- Line: 42
    -- upvalues: Players (copy), SpectatorController (copy), findClosestEnemies (copy), CutsceneUtils (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p8.Char;

    if not Char then
        return;
    end;

    local v9 = findClosestEnemies(Char, 5);
    local v10 = require(script.Subtitles)({
        Name = "Isagi",
        Icon = ""
    });
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.PlayCutscene(Char, {
        isagi = Char,
        rig1 = v9[1],
        rig2 = v9[2],
        rig3 = v9[3],
        rig4 = v9[4],
        rig5 = v9[5]
    }, "IsagiNELAwkCutscene", script.CodeEvents, 11.65, v10, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
end;
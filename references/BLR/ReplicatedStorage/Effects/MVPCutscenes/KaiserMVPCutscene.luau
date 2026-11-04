  

game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SoundService = game:GetService("SoundService");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return function(p1) -- Line: 12
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy), SoundService (copy), Essentials (copy), ReplicatedStorage (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not (SpectatorController.IsSpectating or Players.LocalPlayer:GetAttribute("MVPPreviewActive")) then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = {
        Icon = "",
        Name = Char.Name
    };
    require(script.Subtitles)(v2);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    local u3 = p1.Teammates or {};
    task.spawn(function() -- Line: 30
        -- upvalues: u3 (copy)
        local VFX = workspace:WaitForChild("VFX", 2);

        if not VFX then
            return;
        end;

        for i = 1, 5 do
            local v4;

            if u3[i] then
                v4 = i;
            else
                local v5 = VFX:FindFirstChild("" .. i);

                if v5 then
                    v5:Destroy();
                    v4 = i;
                else
                    v4 = i;
                end;
            end;
        end;
    end);
    SoundService.SoundGroup.OST.Volume = 0;
    local v6 = Essentials:HideCosmetics(Char);
    local v7 = {};

    for _, v in u3 do
        v7[v] = Essentials:HideCosmetics(v);
    end;

    CutsceneUtils.PlayCutscene(Char, {
        kaiser = Char,
        ["2"] = u3[1],
        ["3"] = u3[2],
        ["4"] = u3[3],
        ["5"] = u3[4]
    }, "KaiserMVPCutscene", script.CodeEvents, nil, nil, script.SoundEvents);
    CutsceneUtils.ChangeLighting(ReplicatedStorage.Assets.MainLighting);
    Essentials:UnhideCosmetics(v6);

    for _, v in v7 do
        Essentials:UnhideCosmetics(v);
    end;
end;
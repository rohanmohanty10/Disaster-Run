  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local CutsceneUtils = require(ReplicatedStorage.Modules.CutsceneUtils);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 7
    -- upvalues: Players (copy), SpectatorController (copy), CutsceneUtils (copy)
    if Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local v2 = require(script.Subtitles)({
        Name = "Shidou",
        Icon = ""
    });
    CutsceneUtils.PlayCutscene({
        MoonFileName = "ShidouBigBangDrive",
        Length = 19,
        Character = Char,
        CharsToReplace = {
            Shidou = Char
        },
        CodeEvents = script.CodeEvents,
        Subtitles = v2,
        SoundCues = script.SoundEvents
    });
end;
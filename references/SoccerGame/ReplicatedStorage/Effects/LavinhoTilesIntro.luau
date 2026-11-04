  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Popup = require(ReplicatedStorage.Shared.Popup);

return function() -- Line: 7
    -- upvalues: ReplicatedStorage (copy), Popup (copy), LocalPlayer (copy)
    ReplicatedStorage.Assets.Sfx.LavinhoTilesIntro:Play();
    local SubtitleNoTeam = Popup.SubtitleNoTeam;
    task.delay(0, function() -- Line: 12
        -- upvalues: SubtitleNoTeam (copy), LocalPlayer (ref)
        SubtitleNoTeam(LocalPlayer, "Welcome to Lavinho Tiles!", 4);
    end);
    task.delay(3.5, function() -- Line: 16
        -- upvalues: SubtitleNoTeam (copy), LocalPlayer (ref)
        SubtitleNoTeam(LocalPlayer, "Your goal is to walk around, destroy tiles", 5);
        task.wait(5);
        SubtitleNoTeam(LocalPlayer, "and be the last egoist standing.", 3.5);
    end);
    task.delay(12, function() -- Line: 22
        -- upvalues: SubtitleNoTeam (copy), LocalPlayer (ref)
        SubtitleNoTeam(LocalPlayer, "Last three players get a prize.", 4);
    end);
    task.delay(16, function() -- Line: 26
        -- upvalues: SubtitleNoTeam (copy), LocalPlayer (ref)
        SubtitleNoTeam(LocalPlayer, "Goodluck and Let it Snow!", 8);
    end);
end;
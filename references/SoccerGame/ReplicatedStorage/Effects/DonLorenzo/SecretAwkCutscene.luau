  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
local _ = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SoundManager (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    SoundManager.SpawnSound("LorenzoSecretAwk", 0.6, workspace, 150);
    CutsceneUtils.ChangeLighting(script.LightingConfig);
    CutsceneUtils.CutsceneText("0:01", 3, "I NEED LUCKY SPINS", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.CutsceneText("6:36", 1, "Hey", Color3.fromRGB(255, 234, 0));
    CutsceneUtils.CutsceneText("8:5", 1, "eHhh??", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.CutsceneText("9:31", 1, "You said you want lucky spins? the here use my tablet", Color3.fromRGB(255, 234, 0));
    CutsceneUtils.CutsceneText("12:28", 1, "it gives you a lucky spin every time you tap it, see?", Color3.fromRGB(255, 234, 0));
    CutsceneUtils.CutsceneText("13:55", 1, "haha it\'s so cool, you try?", Color3.fromRGB(255, 234, 0));
    CutsceneUtils.CutsceneText("15:32", 1, "Ok", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.CutsceneText("17:14", 0.4, "Ah", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.CutsceneText("18:20", 1, "LUCKY", Color3.fromRGB(115, 0, 255));
    local v2 = 19.44;

    for i = 1, 7 do
        v2 = v2 + i / 10;
        CutsceneUtils.CutsceneText(tostring(v2), 0.1, "SPIN", Color3.fromRGB(115, 0, 255));
        task.wait(0.1);
        local _ = i;
    end;

    CutsceneUtils.CutsceneText("23:56", 1, "HAHAHAHAHHAHAHAHAHHAAAAAAA", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.CutsceneText("25:27", 1, "JACKPOT", Color3.fromRGB(115, 0, 255));
    CutsceneUtils.PlayCutscene(Char, {
        Lorenzo = Char
    }, "Don LorenzoSecretAwk", script.CodeEvents, 26.25);
    CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
end;
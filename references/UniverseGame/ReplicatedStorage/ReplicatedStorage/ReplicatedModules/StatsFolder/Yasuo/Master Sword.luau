  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Yasuo"
    },
    Sounds = {
        PoseMusic = {
            SoundId = 18513748923,
            Volume = 2.25,
            Looped = true,
            PlaybackSpeed = 1,
            SoundEffects = {}
        },
        TornadoVoice1 = {
            SoundId = "rbxassetid://8938146915",
            Volume = 3
        },
        TornadoVoice2 = {
            SoundId = "rbxassetid://8938147476",
            Volume = 3
        },
        Steel2Voice2 = {
            SoundId = "rbxassetid://8938144362",
            Volume = 3
        },
        Steel2Voice1 = {
            SoundId = "rbxassetid://8938145283",
            Volume = 3
        },
        SteelVoice2 = {
            SoundId = "rbxassetid://8938145770",
            Volume = 3
        },
        SteelVoice3 = {
            SoundId = "rbxassetid://8938146305",
            Volume = 3
        },
        SteelVoice4 = {
            SoundId = "rbxassetid://8938295928",
            Volume = 3
        },
        SteelVoice1 = {
            SoundId = "rbxassetid://8938297841",
            Volume = 3
        },
        WindwallVoice = {
            SoundId = "rbxassetid://8938293978",
            Volume = 3
        },
        ["Tornado Spawn"] = {
            SoundId = "rbxassetid://7913104609",
            Volume = 6
        },
        ["GatheringStorm-Voiceline"] = {
            SoundId = "rbxassetid://8938295928",
            Volume = 3
        },
        ["Galeforce-Voiceline"] = {
            SoundId = "rbxassetid://8938147476",
            Volume = 3
        },
        ["UltStartup-Voiceline"] = {
            SoundId = "rbxassetid://8938146915",
            Volume = 3
        },
        ["GrabStartup-Voiceline"] = {
            SoundId = "rbxassetid://8938145770",
            Volume = 3
        },
        GrabSFX = {
            SoundId = 9865293802,
            Volume = 1.5
        },
        ["GrabSFX-1"] = {
            SoundId = "",
            Volume = 0
        },
        ["GrabSFX-2"] = {
            SoundId = "",
            Volume = 0
        },
        ["GrabSFX-3"] = {
            SoundId = "",
            Volume = 0
        },
        ["GrabSFX-4"] = {
            SoundId = "",
            Volume = 0
        },
        ["GrabSFX-5"] = {
            SoundId = "",
            Volume = 0
        },
        UltSFX = {
            SoundId = 9864868797,
            Volume = 2
        },
        Ult = {
            SoundId = "",
            Volume = 0
        }
    }
};
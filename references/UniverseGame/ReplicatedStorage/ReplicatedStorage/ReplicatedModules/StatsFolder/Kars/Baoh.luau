  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 5
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);

return {
    Inherit = {
        AbilityName = "Kars"
    },
    Sounds = {
        ["Supernatural Regeneration Voiceline"] = {
            SoundId = 99468102501374,
            Volume = 1
        },
        ["Supernatural Regeneration SFX"] = {
            SoundId = 14255013487,
            Looped = true,
            Volume = 1
        },
        ["Sonic Blink"] = {
            SoundId = 18256644046,
            Volume = 1
        },
        ["Superhuman Agility"] = {
            SoundId = 18256645198,
            Volume = 1
        },
        ["Visceral Animosity SFX"] = {
            SoundId = 18303447799,
            Volume = 1
        },
        ["Visceral Animosity Voice"] = {
            SoundId = 121435043874710,
            Volume = 1
        },
        ["Ground Slam"] = {
            SoundId = 18303447374,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 102179072443150,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 86890361088789,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 78666352692495,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 119883841901510,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 18303446879,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 18303448853,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 18303446673,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 18303447576,
            Volume = 1
        },
        ["Dropkick Voiceline"] = {
            SoundId = 138229029220650,
            Volume = 1
        },
        ["Dropkick SFX"] = {
            SoundId = 14187497626,
            Volume = 1
        },
        ["Arm Bash SFX"] = {
            SoundId = 14187497177,
            Volume = 1
        },
        ["Arm Bash Voiceline"] = {
            SoundId = 117505362077586,
            Volume = 1
        },
        ["Arm Bash Hit SFX"] = {
            SoundId = 14187497792,
            Volume = 1
        },
        ["Arm Bash Hit Voiceline"] = {
            SoundId = 80350262108869,
            Volume = 1
        },
        ["Cross Slice SFX"] = {
            SoundId = 18303450373,
            Volume = 1
        },
        ["Cross Slice Voiceline"] = {
            SoundId = 72461379180195,
            Volume = 1
        },
        ["Ricochet Storm Voiceline"] = {
            SoundId = 124570375109832,
            Volume = 1
        },
        ["Ricochet Storm SFX"] = {
            SoundId = 18303452240,
            Volume = 1
        },
        ["Wamuu User Summon Voiceline"] = {
            SoundId = 111587595669426,
            Volume = 1
        },
        ["Tornado SFX"] = {
            SoundId = 14321229264,
            Volume = 1
        },
        ["Wamuu SFX"] = {
            SoundId = 14321229636,
            Volume = 1
        },
        ["Wamuu Voiceline"] = {
            SoundId = 18362864611,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 127506237407656,
            Volume = 1,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = 127506237407656,
            Volume = 1,
            Looped = true
        },
        ["Lotus Grip Startup SFX"] = {
            SoundId = 18256643510,
            Volume = 1.25
        },
        ["Lotus Grip Startup Voiceline"] = {
            SoundId = 115481526444160,
            Volume = 1
        },
        ["Lotus Grip SFX"] = {
            SoundId = 18256643788,
            Volume = 1.25
        },
        ["Lotus Grip Voiceline"] = {
            SoundId = 117852753813255,
            Volume = 1
        },
        ["Lotus Grip Slam"] = {
            SoundId = 18256643024,
            Volume = 1.25
        },
        ["Death-Voiceline"] = {
            SoundId = 106088083462360,
            Volume = 1
        },
        ["Bone Blade Equip"] = {
            SoundId = 18256645420,
            Volume = 1
        },
        ["Light Dancer Voiceline"] = {
            SoundId = 118306839666905,
            Volume = 1
        },
        ["Light Dancer SFX"] = {
            SoundId = 18256644977,
            Volume = 1.25
        },
        ["Light Dancer Ambience"] = {
            SoundId = 18256645756,
            Volume = 1
        },
        ["Light Dancer Music"] = {
            SoundId = 18256645420,
            Volume = 0
        },
        ["Light Dancer End"] = {
            SoundId = 18256645951,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 78602077752243,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 78693705266457,
            Volume = 1
        },
        ["Counter Attempt SFX"] = {
            SoundId = 18303450743,
            Volume = 1
        },
        ["Counter Attempt Voiceline"] = {
            SoundId = 121121139302755,
            Volume = 1
        },
        ["Counter SFX"] = {
            SoundId = 18304360236,
            Volume = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 94731212263530,
            Volume = 1
        },
        ["Blind SFX"] = {
            SoundId = 18303451914,
            Volume = 1
        },
        ["Blind Voiceline"] = {
            SoundId = 111788087756653,
            Volume = 1
        },
        ["Eisidisi Summon Voiceline"] = {
            SoundId = 127025063713027,
            Volume = 1
        },
        ["Eisidisi Leap Voiceline"] = {
            SoundId = 18362865497,
            Volume = 1
        },
        ["Eisidisi Leap SFX"] = {
            SoundId = 18304358585,
            Volume = 1
        },
        ["Eisidisi Leap Slam"] = {
            SoundId = 18304358300,
            Volume = 1
        },
        ["Eisidisi Dash Voiceline"] = {
            SoundId = 18362864182,
            Volume = 1
        },
        ["Eisidisi Dash SFX"] = {
            SoundId = 18304359967,
            Volume = 1
        },
        ["Pose Pillarmen Reveal"] = {
            SoundId = 18363001156,
            Volume = 1
        },
        ["Beatdown Attempt Voiceline"] = {
            SoundId = 75833513608840,
            Volume = 1
        },
        ["Beatdown Attempt SFX"] = {
            SoundId = 18363001692,
            Volume = 1
        },
        ["Beatdown Voiceline"] = {
            SoundId = 78184060529588,
            Volume = 1
        },
        ["Beatdown SFX"] = {
            SoundId = 18363002029,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://79293387665760",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = " Baoh-ru-ru-ru-ru-ru-ru!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://139518108242790",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Baoh-Baoh-ru!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://130952412734618",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Gawh!",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};
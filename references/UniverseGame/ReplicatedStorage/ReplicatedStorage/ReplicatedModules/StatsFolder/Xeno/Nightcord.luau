  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

local function CreateQuote(p1, p2) -- Line: 9
    return {
        SoundVolume = 2,
        YieldSound = true,
        Visible = true,
        SoundId = `rbxassetid://{p1}`,
        FullQuote = {
            {
                Quote = p2
            }
        }
    };
end;

return {
    Inherit = {
        AbilityName = "Xeno"
    },
    Stats = {
        Pose = {
            StandMusicAmount = 7,
            MusicAmount = 6,
            Callbacks = {
                Transformer = function(p3) -- Line: 33, Name: Transformer
                    -- upvalues: CollectionService (copy), TableUtil (copy)
                    local v4 = CollectionService:HasTag(p3.Character, "Summoned");
                    local v5 = TableUtil.Copy(p3.Stats, true);
                    v5.PoseMusic = v4 and "StandPoseMusic" or "PoseMusic";
                    local v6;

                    if v4 then
                        v6 = v5.StandMusicAmount;
                    else
                        v6 = v5.MusicAmount;
                    end;

                    v5.MusicAmount = v6;

                    return v5;
                end
            }
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                CreateQuote(73226169341430, "This is a Z4 level threat."),
                CreateQuote(78539482960258, "Do you take noobie pay?"),
                CreateQuote(108072908996252, "I\'ve been waiting."),
                CreateQuote(127726839844096, "Me Am Nub: Uhifa style, form 203: Feel My Epic Flow!"),
                CreateQuote(90335344038362, "Kitto. Todoku hazu."),
                CreateQuote(125395860434023, "SEKAAAAAAAAAI!"),
                CreateQuote(79635532407736, "Hi Sera."),
                CreateQuote(
                    135267518684410,
                    "ONE BAD GLOOP, AND SHE DO WHAT I YOINKY TWO BIG SPLURGS AND A BIG nub GLOOPY THREE MORE YOINKS THEN BUY ME A SMOOTHE POURED UP A GLOOP THAT\'S A GLOOPAND A SPLURGY"
                )
            }
        }
    },
    Sounds = {
        ["Grab-Voiceline"] = {
            SoundId = 72202864189118,
            Volume = 2.5
        },
        ["Grab-Hit-Voiceline"] = {
            SoundId = 132851722409110,
            Volume = 2.5
        },
        ["ShadowWheel-Voiceline"] = {
            SoundId = 92014934659430,
            Volume = 2.5
        },
        ["Sigils-Voiceline"] = {
            SoundId = 131517540391702,
            Volume = 2.5
        },
        ["ShadowBurst-Voiceline"] = {
            SoundId = 140179386330842,
            Volume = 2.5
        },
        ["Enchain-Voiceline"] = {
            SoundId = 99376029686363,
            Volume = 2.5
        },
        ["UnseenEdge-Activate-Voiceline"] = {
            SoundId = 119838975854004,
            Volume = 3.5
        },
        ["SpectralPlay-Startup-Voiceline"] = {
            SoundId = 131271132001668,
            Volume = 2.5
        },
        ["SpectralPlay-End-Voiceline"] = {
            SoundId = 134894251844427,
            Volume = 2.5
        },
        ["CrossBlow-Voiceline"] = {
            SoundId = 117067576361011,
            Volume = 2.5
        },
        ["CriticalStrike-Voiceline"] = {
            SoundId = 102228750196876,
            Volume = 2.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 100077838770406,
            Volume = 2.5
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 118868820280827,
            Volume = 2.5
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 91531555866906,
            Volume = 2.5
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 104203987386356,
            Volume = 2.5
        },
        ["Summon-Voiceline"] = {
            SoundId = 131075683712022,
            Volume = 2.5
        },
        MeterUp2 = {
            SoundId = 129852993217891,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 118090275677710,
            Volume = 1
        },
        ["PoseMusic-1"] = {
            Looped = true,
            SoundId = 70381467904845,
            Volume = 1.5
        },
        ["PoseMusic-2"] = {
            Looped = true,
            SoundId = 83261710400664,
            Volume = 1.5
        },
        ["PoseMusic-3"] = {
            Looped = true,
            SoundId = 138541791702342,
            Volume = 1.5
        },
        ["PoseMusic-4"] = {
            Looped = true,
            SoundId = 132473291130452,
            Volume = 1.5
        },
        ["PoseMusic-5"] = {
            Looped = true,
            SoundId = 84744770832850,
            Volume = 1.5,
            PlaybackSpeed = 1.6778523489932886
        },
        ["PoseMusic-6"] = {
            Looped = true,
            SoundId = 116250756027284,
            Volume = 1.5
        },
        ["StandPoseMusic-1"] = {
            Looped = true,
            SoundId = 78578225821546,
            Volume = 1.5
        },
        ["StandPoseMusic-2"] = {
            Looped = true,
            SoundId = 95968955037142,
            Volume = 1.5
        },
        ["StandPoseMusic-3"] = {
            Looped = true,
            SoundId = 81512897660378,
            Volume = 1.5,
            PlaybackSpeed = 1.858736059479554
        },
        ["StandPoseMusic-4"] = {
            Looped = true,
            SoundId = 117536481071007,
            Volume = 1.5,
            PlaybackSpeed = 2.1367521367521367
        },
        ["StandPoseMusic-5"] = {
            Looped = true,
            SoundId = 116585286704673,
            Volume = 1.5
        },
        ["StandPoseMusic-6"] = {
            Looped = true,
            SoundId = 137834683915712,
            Volume = 1.5,
            PlaybackSpeed = 2.7247956403269757
        },
        ["StandPoseMusic-7"] = {
            Looped = true,
            SoundId = 96908897287608,
            Volume = 1.5,
            PlaybackSpeed = 1
        }
    }
};
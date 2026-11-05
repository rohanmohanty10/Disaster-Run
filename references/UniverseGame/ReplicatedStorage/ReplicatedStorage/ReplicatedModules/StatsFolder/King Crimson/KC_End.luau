  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

local function CreateQuote(p1, p2, p3) -- Line: 8
    return {
        SoundVolume = 2,
        YieldSound = true,
        MaxYield = 120,
        Visible = true,
        SoundId = `rbxassetid://{p1}`,
        PlaybackSpeed = p3,
        FullQuote = {
            {
                Quote = p2
            }
        }
    };
end;

return {
    Inherit = {
        AbilityName = "King Crimson"
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                CreateQuote(124889833926529, "The things that my sword cannot cut...are next to none!"),
                CreateQuote(
                    78741911086216,
                    " Yo it\'s me Roland from Library of Ruina on the Nintendo Switch..Open the curtains lights on don\'t miss a moment of this experiment oh,-"
                ),
                CreateQuote(75608574291729, "Moku~ Moku~ Mok-...~Moku Moku Mo- mmmm hm..hm. Ara Youmu~!"),
                CreateQuote(134011694421778, "알아들을 수 없는 한국어"),
                CreateQuote(
                    133151940372690,
                    "Don\'t touch my pizza- DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING  DING"
                ),
                CreateQuote(102297385795940, "🐻 🎩", 4),
                CreateQuote(
                    134492461874874,
                    "I have nothing but my sorrow, and I want nothing more. It has been, it still is, faithful to me.\n\nWhy should I begrudge it, since during the hours, when my soul crushed the depths of my heart, it was seated there beside me?\n\nO sorrow, I have ended, you see, by respecting you, because I am certain you will never leave me. Ah, I realize it: your beugy lies in the force of your being.\n\nBecause I know that on the day of my final agony, you will be there, lying in my sheets, O sorrow, so that you might once again attempt to enter my heart.\n"
                ),
                CreateQuote(
                    134123564665157,
                    "Ya hauhghhghghhygggggggggg uhghahahdhs HUHAGGHSGGHGGGG hjhuhygggghhhh eraahhhhhh kkkkk"
                ),
                CreateQuote(83295852169618, "Some random touhou voiceline idk"),
                {
                    SoundId = "rbxassetid://131301527926568",
                    SoundVolume = 1.5,
                    YieldSound = true,
                    Visible = true,
                    DisplayQuote = "우린 말이 아니야. 우린 사람이야. 사람우...",
                    FullQuote = { {
                            Quote = "We are not horses",
                            ScaleTime = 1.25,
                            EndLag = 2.75,
                            EraseQuote = true
                        }, {
                            Quote = "We are humans",
                            ScaleTime = 0.75,
                            EndLag = 2,
                            EraseQuote = true
                        }, {
                            Quote = "Humans are...",
                            ScaleTime = 0.75
                        } }
                }
            }
        }
    },
    Stats = {
        Summon = {
            CharacterAuraOnly = true,
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(170, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(170, 0, 255)) }),
            CustomTransparency = {
                Texture = {
                    SummonTransparency = 0.5
                }
            },
            Properties = {
                Brightness = 1,
                LightEmission = 0
            }
        },
        Pose = {
            Callbacks = {
                Transformer = function(p4, p5) -- Line: 100, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v6 = TableUtil.Copy(p4.Stats, true);
                    local v7 = {};

                    for _, child in p4.Character.Stand.StandHumanoidRootPart:GetChildren() do
                        if child:IsA("Sound") and string.find(child.Name, "PoseMusic") then
                            table.insert(v7, child);
                        end;
                    end;

                    v6.PoseMusic = v7[Random.new():NextInteger(1, #v7)].Name;
                    table.clear(v7);

                    return v6;
                end
            }
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 83283629075022,
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = 83992043724360,
            Volume = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitVoiceline = {
            SoundId = 106514192832197,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpaleVoiceline = {
            SoundId = 109252171679774,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ScalpelThrowVoiceline = {
            SoundId = 114856736138601,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 137934779320858
        },
        CleavingStrikesVoiceline = {
            SoundId = 131512080404466,
            Volume = 3.15
        },
        ChopVoiceline = {
            SoundId = 115544534046979,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowVoiceline = {
            SoundId = 117729129733119,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbedVoiceline = {
            SoundId = 111246413034259,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabVoiceline = {
            SoundId = 134232871111638,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ImpaledVoiceline = {
            SoundId = 70561554645437,
            Volume = 3.15
        },
        GroundSlamVoiceline = {
            SoundId = 82387373166633,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightAmbience = {
            SoundId = 135299276321054,
            Volume = 3,
            PlaybackSpeed = 4
        },
        ForesightVoiceline = {
            SoundId = 107153793869985
        },
        ForesightEnd = {
            SoundId = 96499519319815
        },
        ImpaleVoiceline = {
            SoundId = 100499401672833,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseVoiceline = {
            SoundId = 73505354923738,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseAmbient = {
            SoundId = 114805317195928,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseEnd = {
            SoundId = 75706203826863,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrikeVoiceline = {
            SoundId = ""
        },
        DownwardStrike = {
            SoundId = ""
        },
        DownwardStrikeImpact = {
            SoundId = 88297078242329,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlow = {
            SoundId = 135534511270284,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOn-WitnessHitVoiceline"] = {
            SoundId = 83990387672018,
            Volume = 3.15
        },
        ["StandOn-WitnessVoiceline"] = {
            SoundId = 122832853311964,
            Volume = 3.15
        },
        WitnessHitVoiceline = {
            SoundId = 83990387672018,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessVoiceline = {
            SoundId = 122832853311964,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GrabVoiceline = {
            SoundId = 128120667657700,
            Volume = 2
        },
        GrabbedVoiceline = {
            SoundId = 139291894552197,
            Volume = 2
        },
        Grabbed = {
            SoundId = "",
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 95211915868594,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 76598270560995,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 120691273335401,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 95211915868594,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 18429902587,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        PoseMusic2 = {
            SoundId = 18431567497,
            Volume = 2.75,
            Looped = true
        },
        ["PoseMusic-1"] = {
            SoundId = 119393835497645,
            Volume = 2,
            PlaybackSpeed = 1.7507002801120446
        },
        ["PoseMusic-2"] = {
            SoundId = 135720536834246,
            Volume = 2
        },
        ["PoseMusic-3"] = {
            SoundId = 120972575553308,
            Volume = 2
        },
        ["PoseMusic-4"] = {
            SoundId = 76892790548622,
            Volume = 2
        },
        ["PoseMusic-5"] = {
            SoundId = 128068230044763,
            Volume = 2
        },
        ["PoseMusic-6"] = {
            SoundId = 110827877239506,
            Volume = 2
        },
        ["PoseMusic-7"] = {
            SoundId = 127491200481790,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 136404910900134,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 136103187317504,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 131344366120165,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 100334853690301,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 136404910900134,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = 136103187317504,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = 131344366120165,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = 100334853690301,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    }
};
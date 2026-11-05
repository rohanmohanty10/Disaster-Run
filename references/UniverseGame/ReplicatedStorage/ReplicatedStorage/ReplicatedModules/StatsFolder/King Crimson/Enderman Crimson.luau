  

 

local v1 = { {
        Name = "Output",
        Arguments = { "FX", "Q_HIT_EMIT", "__Legacy" }
    } };
local v2 = {
    HitRemotes = { v1 },
    HitSounds = {
        Hit = {
            SoundId = 13187281406,
            Volume = 3
        }
    }
};
local v3 = {
    HitRemotes = { v1 },
    HitSounds = {
        Hit = {
            SoundId = 13187283029,
            Volume = 3
        }
    }
};

return {
    Inherit = {
        AbilityName = "King Crimson",
        Info = {
            MeterColor = Color3.fromRGB(99, 0, 148)
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = "rbxassetid://13187008779",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://13187010742",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://13187003386",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Lethality = {
            SoundId = "rbxassetid://11158798881",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://11106419580",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://13187668170",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://11106419958",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://13187665756",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://11106420290",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://13187663181",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://11106420747",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://13187660394",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://13187668170",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://13187665756",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://13187663181",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://13187660394",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CleavingStrikes = {
            SoundId = "rbxassetid://11107271326",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://11157628753",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://13187771400",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Chop = {
            SoundId = "rbxassetid://13187369382",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ChopVoiceline = {
            SoundId = "rbxassetid://13187365387",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlam = {
            SoundId = "rbxassetid://11157917672",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlamVoiceline = {
            SoundId = "rbxassetid://13187186983",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impale = {
            SoundId = "rbxassetid://13187372638",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ImpaleVoiceline = {
            SoundId = "rbxassetid://13187509227",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impaled = {
            SoundId = "rbxassetid://11107293582",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrike = {
            SoundId = "rbxassetid://13187505802",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DownwardStrikeVoiceline = {
            SoundId = "rbxassetid://13187503101",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlow = {
            SoundId = "rbxassetid://13187381078",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowRecall = {
            SoundId = "rbxassetid://13187056468",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitSkip = {
            SoundId = "rbxassetid://13187056468",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHit = {
            SoundId = "rbxassetid://13187363252",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowHitVoiceline = {
            SoundId = "rbxassetid://13187303375",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpale = {
            SoundId = "rbxassetid://13187361302",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SuddenBlowImpaleVoiceline = {
            SoundId = "rbxassetid://13187304798",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ScalpelThrow = {
            SoundId = "rbxassetid://11158014862",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ScalpelThrowVoiceline = {
            SoundId = "rbxassetid://13187201288",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Foresight = {
            SoundId = "rbxassetid://13187658005",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightVoiceline = {
            SoundId = "rbxassetid://13187721111",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightDodge = {
            SoundId = "rbxassetid://11107355236",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ForesightEnd = {
            SoundId = "rbxassetid://13187860556",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Witness = {
            SoundId = "rbxassetid://13187499532",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHit = {
            SoundId = "rbxassetid://13187574211",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WitnessHitVoiceline = {
            SoundId = "rbxassetid://13187501297",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrab = {
            SoundId = "rbxassetid://11107368895",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbed = {
            SoundId = "rbxassetid://11107369239",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FierceGrabbedVoiceline = {
            SoundId = "rbxassetid://13187654866",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeErase = {
            SoundId = "rbxassetid://13187770453",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseVoiceline = {
            SoundId = "rbxassetid://13187010742",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseAmbient = {
            SoundId = "rbxassetid://13187769033",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeEraseEnd = {
            SoundId = "rbxassetid://11107390542",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipTeleport = {
            SoundId = "rbxassetid://13187056468",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlow = {
            SoundId = "rbxassetid://13187720351",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimeSkipBlowEnd = {
            SoundId = "rbxassetid://13187719562",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Grab = {
            SoundId = 11247095448,
            Volume = 2
        },
        Grabbed = {
            SoundId = 11247095195,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 13187865447,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13187885660,
            Volume = 2
        },
        PoseMusic = {
            SoundId = "rbxassetid://13187937992",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        }
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 11, 27)), ColorSequenceKeypoint.new(1, Color3.fromRGB(99, 0, 148)) })
        },
        ["Rush Attack"] = {
            ["LMB-1"] = v2,
            ["LMB-4"] = v3,
            ["StandOff-LMB-1"] = v2,
            ["StandOff-LMB-4"] = v3
        }
    },
    QuoteInfo = {
        Groups = {
            StandOff = {
                Visible = true
            },
            StandOn = {
                Visible = false
            }
        },
        Quotes = {
            StandOn = { {
                    SoundId = "rbxassetid://13186940689",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hey"
                        } }
                }, {
                    SoundId = "rbxassetid://13186946321",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What\'s up?"
                        } }
                }, {
                    SoundId = "rbxassetid://13186947979",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Look for the eye."
                        } }
                } },
            StandOff = { {
                    SoundId = "rbxassetid://13186949483",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oof."
                        } }
                } }
        }
    }
};
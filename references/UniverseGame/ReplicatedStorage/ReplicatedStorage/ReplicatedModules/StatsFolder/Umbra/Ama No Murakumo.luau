  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Umbra"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 98430721790948,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 81863168714161,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 81863168714161,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 106557054852303,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Piercing Void"] = {
            ["PiercingVoid-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 103518653768522,
                        Volume = 1.5
                    }
                }
            },
            ["PiercingVoid-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 72072340776089,
                        Volume = 2
                    }
                }
            }
        },
        ["Sky Shatter"] = {
            HitSounds = {
                Hit = {
                    SoundId = 71694263061269,
                    Volume = 1.5
                }
            }
        },
        ["Empty Mist"] = {
            HitSounds = {
                Hit = {
                    SoundId = 131102196444615,
                    Volume = 1
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 87577439887439,
                        Volume = 1
                    }
                }
            }
        },
        ["Snowstorm Helix"] = {
            HitSounds = {
                Hit = {
                    SoundId = 87322637190835,
                    Volume = 1.5
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 110737801742877,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Clear Clouds"] = {
            HitSounds = {
                Hit = {
                    SoundId = 122089503351989,
                    Volume = 1.5
                }
            }
        },
        ["Wind Shower"] = {
            Slashes = {
                HitSounds = {
                    Hit = {
                        SoundId = 77142594619773,
                        Volume = 1.5
                    }
                }
            },
            FinalSlash = {
                HitSounds = {
                    Hit = {
                        SoundId = 131570509903598,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Swallowing Void"] = {
            ["SwallowingVoid-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 112509526845141,
                        Volume = 1.5
                    }
                }
            }
        },
        Devastation = {
            MoveProjectile = {
                HitSounds = {
                    Hit = {
                        SoundId = 126082094670847,
                        Volume = 1
                    }
                }
            }
        },
        ["Fallen Leaves"] = {
            HitSounds = {
                Hit = {
                    SoundId = 126594428085964,
                    Volume = 1.5
                }
            }
        },
        Whirlwind = {
            HitSounds = {
                Hit = {
                    SoundId = 115405067790921,
                    Volume = 1.5
                }
            }
        },
        ["Sword Impalement"] = {
            HitSounds = {
                Hit = {
                    SoundId = 105236617849457,
                    Volume = 1.5
                }
            }
        },
        ["Ascended Punishment"] = {
            HitSounds = {
                Hit = {
                    SoundId = 78445083762333,
                    Volume = 1
                }
            }
        },
        ["Threefold Slice"] = {
            HitSounds = {
                Hit = {
                    SoundId = 76603692633329,
                    Volume = 1.5
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1, p2) -- Line: 211, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v3 = TableUtil.Copy(p1.Stats, true);
                    v3.PoseMusic = "PoseMusic" .. math.random(1, 2);

                    return v3;
                end
            }
        }
    },
    Animations = {
        Idle = {
            Idle = 8117886753
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 101882481247645,
            Volume = 1.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 85067790272818,
            Volume = 1.5
        },
        ["LMB-2"] = {
            SoundId = 90759542940617,
            Volume = 1.5
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 120410308025024,
            Volume = 1.5
        },
        ["LMB-3"] = {
            SoundId = 120626891168035,
            Volume = 1.5
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 138371758483114,
            Volume = 1.5
        },
        ["LMB-4"] = {
            SoundId = 84302281638206,
            Volume = 1.5
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 71196800746464,
            Volume = 1.5
        },
        ["Grab-Startup"] = {
            SoundId = 128134747625599,
            Volume = 1.5
        },
        ["Grab-Voiceline"] = {
            SoundId = 135435552422848,
            Volume = 1.5
        },
        ["Grab-Hit"] = {
            SoundId = 74883423744328,
            Volume = 0
        },
        MeterUp1 = {
            SoundId = 125549241109696,
            Volume = 0
        },
        MeterUp2 = {
            SoundId = 112871862468131,
            Volume = 1.5
        },
        MeterUp3 = {
            SoundId = 121305089043490,
            Volume = 1.5
        },
        MeterUp4 = {
            SoundId = 129880977986329,
            Volume = 1.5
        },
        ["PiercingVoid-First"] = {
            SoundId = 130445393934810,
            Volume = 1.5
        },
        ["PiercingVoid-Second"] = {
            SoundId = 102007083806129,
            Volume = 1.5
        },
        SkyShatter = {
            SoundId = 87412151156841,
            Volume = 1.5
        },
        SnowstormHelix = {
            SoundId = 79863436495343,
            Volume = 1.5
        },
        ["SnowstormHelix-Voiceline"] = {
            SoundId = 92471461973961,
            Volume = 1.5
        },
        ["EmptyMist-Startup"] = {
            SoundId = 96246442672122,
            Volume = 1.5
        },
        ["EmptyMist-Loop"] = {
            SoundId = 117046576002812,
            Volume = 1.5,
            Looped = true
        },
        ["EmptyMist-Finisher"] = {
            SoundId = 96836985588010,
            Volume = 1.5
        },
        ["EmptyMist-Finisher-Voiceline"] = {
            SoundId = 76653305246418,
            Volume = 1.5
        },
        WindShower = {
            SoundId = 116955710268610,
            Volume = 1.5
        },
        ["WindShower-Voiceline"] = {
            SoundId = 134146007120145,
            Volume = 1.5
        },
        ["ClearClouds-Startup"] = {
            SoundId = 131111021859831,
            Volume = 1.5
        },
        ["ClearClouds-Startup-Voiceline"] = {
            SoundId = 93763652987686,
            Volume = 1.5
        },
        ["ClearClouds-Teleport"] = {
            SoundId = 102269692968318,
            Volume = 1.5
        },
        ["ClearClouds-Final"] = {
            SoundId = 130109058479915,
            Volume = 1.5
        },
        ["ClearClouds-Final-Voiceline"] = {
            SoundId = 139253552525406,
            Volume = 1.5
        },
        ["Ultimate-Startup"] = {
            SoundId = 137917450401603,
            Volume = 1.5
        },
        ["Ultimate-Startup-Voiceline"] = {
            SoundId = 100210050533325,
            Volume = 1.5
        },
        Ultimate = {
            SoundId = 124085949455106,
            Volume = 1.5
        },
        ["Ultimate-Voiceline"] = {
            SoundId = 133113215013036,
            Volume = 1.5
        },
        ["Ultimate-Theme"] = {
            SoundId = 140348655645293,
            Volume = 1.5,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.25
                }
            }
        },
        SovereignAwaken = {
            SoundId = 95717868680727,
            Volume = 1.5
        },
        ["Sovereign-Voiceline"] = {
            SoundId = 88704678034912,
            Volume = 1.5
        },
        SovereignMusic = {
            SoundId = 128326178094035,
            Volume = 1.5,
            Looped = true
        },
        Whirlwind = {
            SoundId = 77316778281276,
            Volume = 1.5
        },
        ["SwallowingVoid-First"] = {
            SoundId = 89158302180489,
            Volume = 1.5
        },
        ["SwallowingVoid-Second"] = {
            SoundId = 79979141001909,
            Volume = 1.5
        },
        Devastation = {
            SoundId = 101631504292944,
            Volume = 1.5
        },
        ["Devastation-Impact"] = {
            SoundId = 70563609594009,
            Volume = 1.5
        },
        FallenLeaves = {
            SoundId = 82669447055633,
            Volume = 1.5
        },
        ["FallenLeaves-Teleport"] = {
            SoundId = 88294488304735,
            Volume = 1.5
        },
        ["FallenLeaves-Voiceline"] = {
            SoundId = 93327696421472,
            Volume = 2
        },
        ["FallenLeaves-Jump"] = {
            SoundId = 88294488304735,
            Volume = 1.5
        },
        ["SwordImpalement-Startup"] = {
            SoundId = 107449578069774,
            Volume = 1.5
        },
        ["SwordImpalement-Spawn"] = {
            SoundId = 78425763447587,
            Volume = 1.5
        },
        ["SwordImpalement-Final"] = {
            SoundId = 107774253311228,
            Volume = 1.5
        },
        ["SwordImpalement-Loop"] = {
            SoundId = 89468396420076,
            Volume = 1.5,
            Looped = true
        },
        AscendedPunishment = {
            SoundId = 70497571149015,
            Volume = 1.5
        },
        ["AscendedPunishment-Voiceline"] = {
            SoundId = 124335969368922,
            Volume = 2
        },
        ThreefoldSlice = {
            SoundId = 80247626679926,
            Volume = 1.5
        },
        ["ThreefoldSlice-Voiceline"] = {
            SoundId = 135766093228311,
            Volume = 2
        },
        UmbralDash = {
            SoundId = 8091560121,
            Volume = 1.5
        },
        PoseMusic1 = {
            Looped = true,
            SoundId = 97740857370975,
            Volume = 2
        },
        PoseMusic2 = {
            Looped = true,
            SoundId = 95650640649218,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = 110231110302802,
            Volume = 2
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
                {
                    SoundId = "rbxassetid://9062233697",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I thought you were supposed to be tough.",
                            ScaleTime = 1.5
                        } }
                },
                {
                    SoundId = "rbxassetid://9062236473",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t help it.",
                            ScaleTime = 0.5
                        }, {
                            Quote = " This is what my ability is capable of.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://9062239975",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I should be executed for everything, right?",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://95396305263108",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not a chance.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://94118700260967",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Oops. you\'re Benn Beckman.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://126314832687236",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Have you ever been kicked at the speed of light?",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://139080108729826",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Speed can pack a real punch.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://86984059351375",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is Kizaru!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://113142959215285",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ve arrived.",
                            ScaleTime = 1
                        } }
                }
            }
        }
    }
};
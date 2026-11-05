  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World"
    },
    Animations = {
        Action = {
            PoseTransition = 10148577242,
            PoseIdle = 10148579389,
            ["LMB-1"] = 9590350054,
            ["LMB-2"] = 9590352534,
            ["LMB-3"] = 9590355134,
            ["LMB-4"] = 9590357465
        },
        Idle = {
            Idle = 10179349430,
            SummonedIdle = 10179338264
        }
    },
    Stats = {
        Summon = {
            CustomAura = {
                AuraName = "Greatest High"
            }
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13146815725,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 13146820433,
                        Volume = 1.5
                    }
                }
            }
        },
        Barrage = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 13146774558,
                        Volume = 1
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 13146815724,
                        Volume = 1
                    }
                }
            },
            ClashHit = {
                HitSounds = {
                    Hit = {
                        SoundId = 10626812045,
                        Volume = 1
                    }
                }
            },
            ClashFinisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 10725853580,
                        Volume = 1
                    }
                }
            }
        },
        ["Strong Punch"] = {
            HitSounds = {
                Hit = {
                    SoundId = 13146838490,
                    Volume = 1.5
                }
            }
        },
        Impale = {
            HitSounds = {
                Hit = {
                    SoundId = 13146838506,
                    Volume = 1.5
                }
            }
        },
        Pose = {
            Callbacks = {
                Transformer = function(p1) -- Line: 115, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    local v3 = {};

                    for _, child in p1.Character.Stand.StandHumanoidRootPart:GetChildren() do
                        if child:IsA("Sound") and string.find(child.Name, "PoseMusic") then
                            table.insert(v3, child);
                        end;
                    end;

                    v2.PoseMusic = v3[Random.new():NextInteger(1, #v3)].Name;
                    table.clear(v3);

                    return v2;
                end
            }
        }
    },
    Sounds = {
        ["Timestop Voiceline"] = {
            SoundId = "rbxassetid://18445776603",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Strong Punch Voiceline"] = {
            SoundId = "rbxassetid://18445755054",
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["Counter Voiceline"] = {
            SoundId = "rbxassetid://18445754754",
            Volume = 2.75,
            PlaybackSpeed = 1
        },
        ["StopSign-Voice"] = {
            SoundId = "rbxassetid://18445754198",
            Volume = 2.75,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-Voiceline"] = {
            SoundId = "rbxassetid://18445755494",
            Volume = 2.75
        },
        ["RoadRoller-Voiceline"] = {
            SoundId = "rbxassetid://18445756588",
            Volume = 2.75
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://18445755983",
            Volume = 2.75
        },
        ["Checkmate Activation Voiceline"] = {
            SoundId = "rbxassetid://18445754463",
            Volume = 3
        },
        ["Bloodsuck Voiceline"] = {
            SoundId = "rbxassetid://18445753943",
            Volume = 3
        },
        PoseMusic = {
            SoundId = 10118067634,
            Volume = 2.25,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = 18489542442,
            Volume = 2.25,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(42.25, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Summon-SFX"] = {
            SoundId = 13146815734,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13146774561,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 13146815737,
            Volume = 1
        },
        ["Timestop End SFX"] = {
            SoundId = "rbxassetid://11498446637",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop End Voiceline"] = {
            SoundId = "rbxassetid://4878674256",
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Timestop SFX"] = {
            SoundId = "rbxassetid://13146886574",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6773724319",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["FullPower-Hit-Voice"] = {
            SoundId = "rbxassetid://13146875347",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Hit"] = {
            SoundId = "rbxassetid://13146875349",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup-Voice"] = {
            SoundId = "rbxassetid://13146875332",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["FullPower-Startup"] = {
            SoundId = "rbxassetid://13146875330",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Impale-Voice"] = {
            SoundId = "rbxassetid://13146838505",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Impale-Startup"] = {
            SoundId = "rbxassetid://13146815744",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Strong Punch SFX"] = {
            SoundId = "rbxassetid://13146838489",
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["StopSign-Startup"] = {
            SoundId = "rbxassetid://13146684952",
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["Stop Sign Slam"] = {
            SoundId = 12816581578,
            Volume = 2.5,
            PlaybackSpeed = 1
        },
        ["RoadRoller-Startup-SFX"] = {
            SoundId = "rbxassetid://13146864514",
            Volume = 1
        },
        ["RoadRoller-Hit"] = {
            SoundId = "rbxassetid://7098582420",
            Volume = 0
        },
        ["RoadRoller-SFX"] = {
            SoundId = "rbxassetid://13146864563",
            Volume = 1
        },
        Barrage = {
            SoundId = 13146729447,
            Volume = 1
        },
        ["Checkmate Activation SFX"] = {
            SoundId = 11206834039,
            Volume = 2
        },
        ["Checkmate Windup"] = {
            SoundId = 11206836144,
            Volume = 2
        },
        Knives_Hit = {
            SoundId = 11206836835,
            Volume = 2
        },
        Knives_Ding = {
            SoundId = 11206837650,
            Volume = 2
        },
        Knives_Ting = {
            SoundId = 11206839775,
            Volume = 2
        },
        SuddenStrikeVoice = {
            SoundId = 13146886551,
            Volume = 1
        },
        SuddenStrikeSFX = {
            SoundId = 13146886563,
            Volume = 1
        },
        KickBarrageVoice = {
            SoundId = 13146774567,
            Volume = 1
        },
        KickBarrageSFX = {
            SoundId = 13146774577,
            Volume = 1
        },
        ["Bloodsuck Startup"] = {
            SoundId = 13146684950,
            Volume = 3
        },
        ["Bloodsuck SFX"] = {
            SoundId = 13146684976,
            Volume = 3
        },
        ["LMB-1"] = {
            SoundId = 11499912913,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 11499913422,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 11499913311,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 11499913144,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 13146815725,
            Volume = 0
        },
        ["SwingLMB 4"] = {
            SoundId = 13146820433,
            Volume = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = 11499912913,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 11499913422,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 11499913311,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 11499913144,
            Volume = 1
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 11499912997,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = 100094313108014,
            Volume = 3.75
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
                    SoundId = "rbxassetid://10436898457",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Immortality, Eternal life!.. And Stand Power this proves that no one can surpass DIO, Puny humans I shall rule you all!"
                        } }
                }, {
                    SoundId = "rbxassetid://10437135083",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is truly the greatest high."
                        } }
                } }
        }
    }
};
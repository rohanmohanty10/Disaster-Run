  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Locke"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 14, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "StandOnPoseMusic";

                        return v2;
                    end;

                    v2.PoseMusic = "StandOffPoseMusic";

                    return v2;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 106778872553326,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100071355213490,
                        Volume = 1.5
                    }
                }
            },
            ["StandOff-LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 106778872553326,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Dual Shocker"] = {
            HitSounds = {
                Hit = {
                    SoundId = 130276560308812,
                    Volume = 2.5
                }
            }
        },
        ["Electric Strike"] = {
            HitSounds = {
                Hit = {
                    SoundId = 119613848907859,
                    Volume = 2.5
                }
            }
        },
        ["Kinetic Charge"] = {
            HitSounds = {
                Hit = {
                    SoundId = 89501954698613,
                    Volume = 2.5
                }
            }
        },
        ["Kinetic Blast"] = {
            HitSounds = {
                Hit = {
                    SoundId = 136865832926624,
                    Volume = 2.5
                }
            }
        },
        Discharge = {
            HitSounds = {
                Hit = {
                    SoundId = 136865832926624,
                    Volume = 2.5
                }
            }
        },
        ["Shock Stab"] = {
            HitSounds = {
                Hit = {
                    SoundId = 101599405315130,
                    Volume = 3
                }
            }
        }
    },
    Sounds = {
        ["Energy-Overflow"] = {
            SoundId = 138216862950570,
            Volume = 2.5
        },
        ["Energy-Overflow-Voiceline"] = {
            SoundId = 126920067350419,
            Volume = 2.5
        },
        ["Shock-Stab"] = {
            SoundId = 101032062755646,
            Volume = 2.5
        },
        ["Shock-Stab-Voiceline"] = {
            SoundId = 135795839768760,
            Volume = 2.5
        },
        Discharge = {
            SoundId = 136811527665927,
            Volume = 2.5
        },
        ["Discharge-Voiceline"] = {
            SoundId = 102870883739851,
            Volume = 2.5
        },
        ["Discharge-End"] = {
            SoundId = 86594356912366,
            Volume = 2.5
        },
        ["Discharge-End-Voiceline"] = {
            SoundId = 116462080367212,
            Volume = 2.5
        },
        ["Static-Buster-Startup"] = {
            SoundId = 132271440385925,
            Volume = 2.5
        },
        ["Static-Buster-Startup-Voiceline"] = {
            SoundId = 106270208496303,
            Volume = 2.5
        },
        ["Static-Buster-Hit"] = {
            SoundId = 81508490002125,
            Volume = 3
        },
        ["Static-Buster-Hit-Voiceline"] = {
            SoundId = 92445732316222,
            Volume = 2.5
        },
        ["Overvolt-Startup"] = {
            SoundId = 88782998914805,
            Volume = 2.5
        },
        ["Overvolt-Startup-Voiceline"] = {
            SoundId = 133316152506634,
            Volume = 2.5
        },
        ["Overvolt-Hit"] = {
            SoundId = 78796335418004,
            Volume = 2.5
        },
        ["Overvolt-Hit-Voiceline"] = {
            SoundId = 84764116228818,
            Volume = 2.5
        },
        ["Electric-Strike"] = {
            SoundId = 108099299716321,
            Volume = 2.5
        },
        ["Kinetic-Blast"] = {
            SoundId = 124396025254931,
            Volume = 2.5
        },
        ["Kinetic-Blast-Voiceline"] = {
            SoundId = 74423050743308,
            Volume = 2.5
        },
        ["Kingslayer-Dash"] = {
            SoundId = 113710722466488,
            Volume = 2.5
        },
        ["Kingslayer-Grab"] = {
            SoundId = 130030827949023,
            Volume = 2.5
        },
        ["DualShocker-SFX"] = {
            SoundId = 110705394838148,
            Volume = 2.5
        },
        ["DualShocker-Voiceline"] = {
            SoundId = 94774701959612,
            Volume = 2.5
        },
        ["DualShocker-1"] = {
            SoundId = 110705394838148,
            Volume = 0
        },
        ["DualShocker-2"] = {
            SoundId = 110705394838148,
            Volume = 0
        },
        OrbExplode = {
            SoundId = 136865832926624,
            PlayOnRemove = true,
            Volume = 2.5
        },
        OrbStartup = {
            SoundId = 109383705863906,
            Volume = 2.5
        },
        ["KineticOrb-Voiceline"] = {
            SoundId = 94624589678640,
            Volume = 2.5
        },
        OrbSFX = {
            SoundId = 91584987697447,
            Volume = 2.5
        },
        KineticCharge = {
            SoundId = 139651537400978,
            Volume = 2.5
        },
        ["KineticCharge-Voiceline"] = {
            SoundId = 98458258011064,
            Volume = 2.5
        },
        ["LMB-1"] = {
            SoundId = 139506054331381,
            Volume = 2.5
        },
        ["LMB-2"] = {
            SoundId = 86786047067185,
            Volume = 2.5
        },
        ["LMB-3"] = {
            SoundId = 111237276354053,
            Volume = 2.5
        },
        ["LMB-4"] = {
            SoundId = 78707180915200,
            Volume = 2.5
        },
        ["StandOff-LMB-1"] = {
            SoundId = 139506054331381,
            Volume = 2.5
        },
        ["StandOff-LMB-2"] = {
            SoundId = 86786047067185,
            Volume = 2.5
        },
        ["StandOff-LMB-3"] = {
            SoundId = 111237276354053,
            Volume = 2.5
        },
        ["StandOff-LMB-4"] = {
            SoundId = 78707180915200,
            Volume = 2.5
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 0
        },
        SummonSound = {
            SoundId = 127087962098901,
            Volume = 2.5
        },
        Desummon = {
            SoundId = 140171506230803,
            Volume = 2.5
        },
        StandOnPoseMusic = {
            Looped = true,
            SoundId = 70495327585202,
            Volume = 2,
            PlaybackSpeed = 1.79856115108
        },
        StandOffPoseMusic = {
            Looped = true,
            SoundId = 91578759414946,
            Volume = 2
        },
        ["TakedownAttempt-Voiceline"] = {
            SoundId = 126317773790325,
            Volume = 2
        },
        TakedownAttempt = {
            SoundId = 121580613476409,
            Volume = 2.5
        },
        ["Takedown-Voiceline"] = {
            SoundId = 108493220565754,
            Volume = 2
        },
        Takedown = {
            SoundId = 72038521122596,
            Volume = 2.5
        },
        MeterUp2 = {
            SoundId = 116606499574430,
            Volume = 1.5
        },
        MeterUp4 = {
            SoundId = 122937925117769,
            Volume = 1.5
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
                    SoundId = "rbxassetid://127462165413594",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*Cricket noises*"
                        } }
                },
                {
                    SoundId = "rbxassetid://125969750939877",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🦗🦗🦗"
                        } }
                },
                {
                    SoundId = "rbxassetid://109533896777823",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Did you know? The not-clever ones die first in this world."
                        } }
                },
                {
                    SoundId = "rbxassetid://70826435673032",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You don\'t know what curse I am, do you?"
                        } }
                },
                {
                    SoundId = "rbxassetid://107999753782493",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "HUH??!? ahuh haughhh haa huhehhe hiiwahhh ahhahhehhuyhahha hahhehhahha hehiohui hoa...This guy....is clever!"
                        } }
                },
                {
                    SoundId = "rbxassetid://76088975656191",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t insult me! I know that much! I\'m clever!"
                        } }
                },
                {
                    SoundId = "rbxassetid://129271817075764",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "🥮🧧👲🏮㊗️ 🈶️ 🈯️ 🈳️"
                        } }
                }
            }
        }
    }
};
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(Knit.Util.Trove);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Anubis"
    },
    Animations = {
        Action = {
            PoseIdle = 17000573069,
            PoseTransition = 17000580416
        },
        Movement = {
            Walk = 17000588289,
            Run = 17000589793
        },
        Idle = {
            Idle = 17000569366
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 17026548119,
            Volume = 1.25
        },
        ["LMB-2"] = {
            SoundId = 17026548731,
            Volume = 1.25
        },
        ["LMB-3"] = {
            SoundId = 17026549054,
            Volume = 1.25
        },
        ["LMB-4"] = {
            SoundId = 17026549202,
            Volume = 1.25
        },
        ["Cursed Descent"] = {
            SoundId = 17026561112,
            Volume = 1.25
        },
        ["Cursed Descent Impact"] = {
            SoundId = 17026544933,
            Volume = 1.25
        },
        ["Accursed Laceration"] = {
            SoundId = 17026544666,
            Volume = 1.25
        },
        Slam = {
            SoundId = 17026544933,
            Volume = 1.25
        },
        ["Soul Severance"] = {
            SoundId = 17026544102,
            Volume = 1.25
        },
        Shadowstrike = {
            SoundId = 17026546027,
            Volume = 1.25
        },
        ["Phantom Finisher"] = {
            SoundId = 17026548917,
            Volume = 1.25
        },
        ["Phantom Finisher Success"] = {
            SoundId = 17026546865,
            Volume = 1.25
        },
        ["Achilles Strike"] = {
            SoundId = 17026545238,
            Volume = 1.25
        },
        Flash = {
            SoundId = 17026049427,
            Volume = 1.25
        },
        Awakening = {
            SoundId = 17026547293,
            Volume = 1.25
        },
        AwakeningVoice = {
            SoundId = 17026550604,
            Volume = 1.25
        },
        AwakeningAmbience = {
            SoundId = 17026548515,
            Volume = 1.25,
            Looped = true
        },
        Command = {
            SoundId = 17026547793,
            Volume = 1.25
        },
        CommandSuccess = {
            SoundId = 17026546393,
            Volume = 1.25
        },
        CommandSuccessVoice = {
            SoundId = 17026553187,
            Volume = 1.25
        },
        PoseMusic = {
            SoundId = 17026552916,
            Volume = 1.3,
            Looped = true
        }
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549895,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549895,
                        Volume = 1.5
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549626,
                        Volume = 0.4
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549386,
                        Volume = 1.5
                    }
                }
            }
        },
        ["Accursed Laceration"] = {
            HitSounds = {
                Hit = {
                    SoundId = 17026545699,
                    Volume = 1.25
                }
            }
        },
        ["Achilles Strike"] = {
            Projectile = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026544504,
                        Volume = 1.25
                    }
                }
            }
        },
        Shadowstrike = {
            HitSounds = {
                Hit = {
                    SoundId = 17026549626,
                    Volume = 1.25
                }
            },
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549895,
                        Volume = 0.3
                    }
                }
            }
        },
        ["Cursed Command"] = {
            Attempt = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026549386,
                        Volume = 0.4
                    }
                }
            },
            Kick = {
                HitSounds = {
                    Hit = {
                        SoundId = 17026547541,
                        Volume = 1.25
                    }
                }
            }
        },
        ["Cursed Descent"] = {
            HitSounds = {
                Hit = {
                    SoundId = 17026549386,
                    Volume = 1.5
                }
            }
        },
        ["Soul Severance"] = {
            HitSounds = {
                Hit = {
                    SoundId = 17026549386,
                    Volume = 1.5
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseEnd = function(p2, p3) -- Line: 251, Name: PoseEnd
                    local _ = p2.Stats;
                    local _ = p2.Player;
                    local Character = p2.Character;

                    if Character:FindFirstChild("Left Arm"):FindFirstChild("PoseObj") then
                        Character:FindFirstChild("Left Arm"):FindFirstChild("PoseObj"):Destroy();
                    end;
                end,

                PoseTransition = function(p4, p5) -- Line: 260, Name: PoseTransition
                    -- upvalues: u1 (copy)
                    local _ = p4.Stats;
                    local _ = p4.Player;
                    local Character = p4.Character;
                    local Attachment = Instance.new("Attachment");
                    Attachment.Name = "PoseObj";
                    Attachment.Parent = Character:FindFirstChild("Left Arm");
                    Attachment.Position = Vector3.new(0, -1, 0);
                    u1.FireAllClients("Tesseract_Pose", {
                        Character = Character,
                        Reference = Attachment
                    });
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
            Universal = { {
                    SoundId = "rbxassetid://17026550331",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A 4th dimensional bubble, cast a 3 dimensional shadow. It is beyond... COMPREHENSION!"
                        } }
                }, {
                    SoundId = "rbxassetid://17026550080",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What? 4th Dimensional?"
                        } }
                }, {
                    SoundId = "rbxassetid://17026550773",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No way, I\'m like the smartest guy on Ooo thanks to these glasses."
                        } }
                } }
        }
    }
};
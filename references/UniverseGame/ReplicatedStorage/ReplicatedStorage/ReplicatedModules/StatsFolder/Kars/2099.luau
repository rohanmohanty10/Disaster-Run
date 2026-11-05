  

 

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
    Animations = {
        Action = {
            ["Supernatural Regeneration"] = 18324895715,
            ["Supernatural Regeneration Loop"] = 18324897555,
            ["Dodge 1"] = 18324561699,
            ["Dodge 2"] = 18324563553,
            ["Dodge 3"] = 18324565090,
            ["Bone Blade Activation"] = 18330511044,
            ["LMB-1"] = 18324850244,
            ["LMB-2"] = 18324851867,
            ["LMB-3"] = 18324853458,
            ["LMB-4"] = 18324854737,
            PoseTransition = 18324860226,
            PoseIdle = 18324856486,
            BladesPoseTransition = 18333176401,
            BladesPoseIdle = 18333182316,
            EisidisiPoseTransition = 18333169762,
            EisidisiPoseIdle = 18333178888,
            WamuuPoseTransition = 18333174091,
            WamuuPoseIdle = 18333180318,
            Block = 18330982120,
            BlockHit1 = 18330983653,
            BlockHit2 = 18330985201,
            BlockHit3 = 18330987081,
            BlockBreak = 18330979725,
            ["Visceral Animosity"] = 18324901065,
            ["Brilliant Bone Blades"] = 18324557840,
            ["Ricochet Storm"] = 18324861782,
            ["Cross Slice"] = 18324559749,
            ["Arm Bash Leap"] = 18324825073,
            ["Arm Bash User"] = 18324828736,
            ["Arm Bash Victim"] = 18324827444,
            ["Aerial Assault"] = 13857456626,
            ["Stun Locked"] = 13857738336,
            ["Thrusting Kick"] = 13862332712,
            ["Light Dancer"] = 18324839129,
            ["Eisidisi Light Dancer"] = 18324569945,
            ["Wamuu Light Dancer"] = 18324907365,
            ["Lotus Grip Attempt"] = 18324840908,
            ["Lotus Grip Player"] = 18324842725,
            ["Lotus Grip Enemy"] = 18169730818,
            ["Lotus Grip Player Spin"] = 18324844769,
            ["Lotus Grip Enemy Spin"] = 18211418987,
            Wamuu = 18324905071,
            Eisidisi = 18324566651,
            ["Eisidisi Lunge"] = 18324568661,
            ["Supersonic Dropkick"] = 18324899184,
            ["Sonic Blitz Startup"] = 18202002802,
            ["Sonic Blitz"] = 18202013559,
            ["Lacerative Lunge Start"] = 14606101348,
            ["Lacerative Lunge Run Loop"] = 14606109283,
            ["Lacerative Lunge Miss"] = 14606116219,
            ["Lacerative Lunge Attacker"] = 14606123455,
            ["Lacerative Lunge Enemy"] = 14606101348,
            ForwardDash1 = 18324571999,
            ForwardDash2 = 18324574598,
            BackwardDash = 18324550990,
            LeftDash = 18324846615,
            RightDash = 18324863497,
            ["Counter Input"] = 18324835108,
            ["Counter Loop"] = 18324836390,
            ["Counter Victim"] = 18249790684,
            ["Counter Player"] = 18324837622,
            ["Counter Decoy"] = 18249809172,
            ["Beatdown Startup Player"] = 18324554802,
            ["Beatdown Startup Wamuu"] = 18324556164,
            ["Beatdown Startup Eisidisi"] = 18324552866,
            ["Beatdown Camera"] = 18272390123,
            ["Beatdown Player"] = 18324832004,
            ["Beatdown Victim"] = 18272395790,
            ["Beatdown Eisidisi"] = 18324830064,
            ["Beatdown Wamuu"] = 18324833368,
            ["Default-Grab"] = 18324867275,
            ["Default-Throw"] = 18324892826,
            ["Default-ThrowVictim"] = 18324894274
        },
        Movement = {
            ["BoneBlades-Walk"] = 18324902973,
            ["BoneBlades-Run"] = 18330509350,
            Walk = 18324902973,
            Run = 18324865327,
            Jump = 18330930807,
            Fall = 18330935820
        },
        Idle = {
            ["BoneBlades-Idle"] = 18330506920,
            Idle = 18324575889
        }
    },
    Stats = {
        ["Ricochet Storm"] = {
            HitSounds = {
                Hit = {
                    SoundId = 113598854430681,
                    Volume = 0.65
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 75259353634036,
                        Volume = 1
                    }
                }
            }
        },
        ["Visceral Animosity"] = {
            Slash = {
                HitSounds = {
                    Hit = {
                        SoundId = 96838184380733,
                        Volume = 1
                    }
                }
            },
            FinalSlash = {
                HitSounds = {
                    Hit = {
                        SoundId = 99532051501963,
                        Volume = 1
                    }
                }
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 84336293045601,
                        Volume = 1
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 124535501103658,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 111612676989863,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 94528078760688,
                        Volume = 1
                    }
                }
            }
        },
        ["Arm Bash"] = {
            Punch = {
                HitSounds = {
                    Hit = {
                        SoundId = 18366585301,
                        Volume = 1
                    }
                }
            }
        },
        Grab = {
            CustomPrefix = "Default",
            Throw = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/ArmBash/Punch",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            },
            ExtraFrames = {
                { 15, function(p2, p3) -- Line: 246
                        -- upvalues: u1 (ref)
                        local MoveData = p2:GetCache("Cache").MoveData;

                        if MoveData then
                            local Player = MoveData.Player;
                            local Character = MoveData.Character;
                            local v4 = MoveData.Trove:Construct(Instance, "Attachment");
                            v4.Position = Vector3.new(0, -1, 0);
                            v4.Parent = Character["Right Arm"];
                            u1.FireAllClients("Bezier Trails", {
                                Path = "Particles/VisceralAnimosity/WindupTrail",
                                Amount = 15,
                                Lifetime = 0.85,
                                Amplitude = 2,
                                Delay = 0.135,
                                Player = Player,
                                RelativePart = v4
                            });
                        end;
                    end }
            },
            Callbacks = {
                OnStart = function(u5, p6) -- Line: 272, Name: OnStart
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Kars_Trail", {
                        Value = true,
                        Blades = "Left",
                        Character = u5.Character
                    });
                    u1.FireAllClients("Kars_BoneBlades", u5.Character, true);
                    u5.Trove:Add(function() -- Line: 281
                        -- upvalues: u1 (ref), u5 (copy)
                        u1.FireAllClients("Kars_Trail", {
                            Value = false,
                            Blades = "Left",
                            Character = u5.Character
                        });
                        u1.FireAllClients("Kars_BoneBlades", u5.Character, false);
                    end);
                end
            }
        }
    },
    Sounds = {
        ["Supernatural Regeneration Voiceline"] = {
            SoundId = 14255013395,
            Volume = 0
        },
        ["Supernatural Regeneration SFX"] = {
            SoundId = 14255013487,
            Looped = true,
            Volume = 1
        },
        ["Sonic Blink"] = {
            SoundId = 18366586992,
            Volume = 1
        },
        ["Superhuman Agility"] = {
            SoundId = 18256645198,
            Volume = 1
        },
        ["Visceral Animosity SFX"] = {
            SoundId = 127223261626866,
            Volume = 1
        },
        ["Visceral Animosity Voice"] = {
            SoundId = 122219663251362,
            Volume = 1.5
        },
        ["Ground Slam"] = {
            SoundId = 88255815858884,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 18384927857,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 18384928296,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 18384928506,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 18384928066,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 89924200435184,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 134322853392404,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 80524336212626,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 80901417772285,
            Volume = 1
        },
        ["Dropkick Voiceline"] = {
            SoundId = 14187497484,
            Volume = 0
        },
        ["Dropkick SFX"] = {
            SoundId = 18366584800,
            Volume = 1
        },
        ["Arm Bash SFX"] = {
            SoundId = 18366583540,
            Volume = 1
        },
        ["Arm Bash Voiceline"] = {
            SoundId = 14187497286,
            Volume = 0
        },
        ["Arm Bash Hit SFX"] = {
            SoundId = 18366585917,
            Volume = 1
        },
        ["Arm Bash Hit Voiceline"] = {
            SoundId = 18384929803,
            Volume = 1.25
        },
        ["Cross Slice SFX"] = {
            SoundId = 130618094523300,
            Volume = 1
        },
        ["Cross Slice Voiceline"] = {
            SoundId = 18384929555,
            Volume = 1
        },
        ["Ricochet Storm Voiceline"] = {
            SoundId = 18384930054,
            Volume = 1.25
        },
        ["Ricochet Storm SFX"] = {
            SoundId = 110589803193313,
            Volume = 1
        },
        ["Wamuu User Summon Voiceline"] = {
            SoundId = 18384927589,
            Volume = 1
        },
        ["Tornado SFX"] = {
            SoundId = 18366590937,
            Volume = 1
        },
        ["Wamuu SFX"] = {
            SoundId = 18366591282,
            Volume = 1
        },
        ["Wamuu Voiceline"] = {
            SoundId = 18366590618,
            Volume = 1
        },
        PoseMusic2 = {
            SoundId = 137159316262063,
            Volume = 1,
            Looped = true
        },
        PoseMusic1 = {
            SoundId = 127179836256610,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.25
                }
            }
        },
        ["Lotus Grip Startup SFX"] = {
            SoundId = 18366588971,
            Volume = 1
        },
        ["Lotus Grip Startup Voiceline"] = {
            SoundId = 18256643252,
            Volume = 0
        },
        ["Lotus Grip SFX"] = {
            SoundId = 111319253477170,
            Volume = 1
        },
        ["Lotus Grip Voiceline"] = {
            SoundId = 120538403245094,
            Volume = 2
        },
        ["Lotus Grip Slam"] = {
            SoundId = 18366590165,
            Volume = 1
        },
        ["Bone Blade Equip"] = {
            SoundId = 136790710907571,
            Volume = 1
        },
        ["Light Dancer Voiceline"] = {
            SoundId = 70410888798984,
            Volume = 1.25
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
            SoundId = 18384928905,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 18384928668,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 18384929329,
            Volume = 1
        },
        ["Counter Attempt SFX"] = {
            SoundId = 125594895178451,
            Volume = 1
        },
        ["Counter Attempt Voiceline"] = {
            SoundId = 77875673100059,
            Volume = 1
        },
        ["Counter SFX"] = {
            SoundId = 105090326851894,
            Volume = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 71673953776140,
            Volume = 1.5
        },
        ["Blind SFX"] = {
            SoundId = 105029816392821,
            Volume = 1
        },
        ["Blind Voiceline"] = {
            SoundId = 18303451034,
            Volume = 0
        },
        ["Eisidisi Summon Voiceline"] = {
            SoundId = 18384929107,
            Volume = 1
        },
        ["Eisidisi Leap Voiceline"] = {
            SoundId = 18366593463,
            Volume = 1
        },
        ["Eisidisi Leap SFX"] = {
            SoundId = 18366593071,
            Volume = 1
        },
        ["Eisidisi Leap Slam"] = {
            SoundId = 18366592324,
            Volume = 1
        },
        ["Eisidisi Dash Voiceline"] = {
            SoundId = 18366591836,
            Volume = 1
        },
        ["Eisidisi Dash SFX"] = {
            SoundId = 18366592693,
            Volume = 1
        },
        ["Beatdown Attempt Voiceline"] = {
            SoundId = 71673953776140,
            Volume = 1.5
        },
        ["Beatdown Attempt SFX"] = {
            SoundId = 18384930284,
            Volume = 1
        },
        ["Beatdown Voiceline"] = {
            SoundId = 131415057415679,
            Volume = 1.5
        },
        ["Beatdown SFX"] = {
            SoundId = 139643063092877,
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
                    SoundId = "rbxassetid://100830724281385",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My name is Miguel O\' Hara. I\'m this dimension\'s one and only spiderman.. At least I was. But I\'m not like the others, I don\'t always like what I have to do... But I know I have to be the one to do it. I\'ve given up too much to stop now."
                        } }
                }, {
                    SoundId = "rbxassetid://76054509141873",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "And all this time... I HAVE BEEN THE ONLY ONE HOLDING IT TOGETHER!"
                        } }
                }, {
                    SoundId = "rbxassetid://85751254902833",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not you, I\'ve had the right amount of you."
                        } }
                }, {
                    SoundId = "rbxassetid://101872280192812",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "But I\'m a good guy, you just have to shut up and trust me."
                        } }
                } }
        }
    }
};
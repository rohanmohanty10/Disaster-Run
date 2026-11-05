  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.BaseStatsModule);
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};

local function CreateMultiIndicator(p4) -- Line: 40
    local v5 = {};

    for i, v in pairs(p4) do
        if i ~= "Overrides" then
            table.insert(v5, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p4.Overrides then
        for _, v in ipairs(v5) do
            for i, v4 in pairs(p4.Overrides) do
                v[i] = v4;
            end;
        end;
    end;

    return v5;
end;

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            X = "Beatdown",
            C = "Quickstep",
            E = "Air Palm",
            R = "Teleportation Kick",
            T = "Reversal Red",
            Y = "Blue Amplification",
            V = "Teleport",
            B = "Infinity Burst",
            G = "Infinite Void",
            H = "Hollow Purple"
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 10571338890,
            ["LMB-2"] = 10571341987,
            ["LMB-3"] = 10571344976,
            ["LMB-4"] = 10571348040,
            TeleportationKick = 6490852120,
            ["Air Palm"] = 10571329944,
            KickStarter = 10628205744,
            ["Hollow Purple"] = 7005477388,
            AttackPose = 6307839827,
            BlueAmplificationThrow = 13448784605,
            Snap = 13448786937,
            DomainExpansion = 6539490566,
            PoseIdle = 6544470612,
            AOE = 10438583499,
            ReversalRed = 7026655617,
            Beatdown = 13448452134,
            BeatdownVictim = 13448450332,
            GrabAttempt = 13448443334,
            GrabFail = 9390593282,
            DEActivate = 9856849601,
            DECutscene = 9510613580,
            DECutsceneVictim = 9510620622,
            DECutsceneCamera = 13436662836,
            AirPalmRecoil = 10631991742
        },
        Idle = {
            Idle = 7317390939
        }
    },
    Stats = {
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Indicators = CreateMultiIndicator({
                Universal = "Rush Attack"
            }),
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = {
                Damage = 8,
                Meter = true,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMBSwing1" }, { 15, "Attack" }, { 21, "End" } },
                Stun = {
                    Time = 0.75,
                    Priority = EnumsModule.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 8,
                    Time = 0.1
                },
                Block = {
                    PerfectBlockable = false
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 13514574971,
                        TimePosition = 0.4
                    }
                }
            },
            ["LMB-2"] = {
                Speed = 1,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMBSwing2" }, { 15, "Attack" }, { 21, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 13514575127
                    }
                }
            },
            ["LMB-3"] = {
                Speed = 1,
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMBSwing3" }, { 18, "Attack" }, { 25, "End" } },
                HitSounds = {
                    Hit = {
                        SoundId = 13514575054
                    }
                }
            },
            ["LMB-4"] = {
                Cooldown = 1,
                Damage = 21,
                Speed = 1.75,
                HitAnimations = "Default",
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMBSwing4" }, { 18, "Attack" }, { 23, "End" } },
                Block = {
                    Unblockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 13514575194
                    }
                }
            }
        },
        ["Air Palm"] = {
            Active = true,
            Damage = 20,
            Stun = 0.4,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Air Palm"
            }),
            Cooldown = {
                Time = 8,
                AfterMove = true
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(15, 15, 30),
                Debug = false,
                Offset = CFrame.new(0, 0, -15)
            },
            HitAnimations = { "rbxassetid://10631991742" },
            HitSounds = {
                Hit = {
                    SoundId = 7029708570,
                    Volume = 1
                }
            },
            HitRemotes = { v3 }
        },
        ["Blue Amplification"] = {
            Active = true,
            Damage = 10,
            Distance = 2,
            Stun = 1,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Blue Amplification"
            }),
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            Meter = {
                RequiredLevel = 1,
                MeterGain = 0
            },
            Block = {
                PerfectBlockable = false
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(30, 30, 30),
                Debug = false,
                Offset = CFrame.identity
            }
        },
        ["Reversal Red"] = {
            Active = true,
            Damage = 32.25,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Reversal Red"
            }),
            Ragdoll = {
                Time = 1.5
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(30, 30, 30),
                Debug = false,
                Offset = CFrame.identity
            }
        },
        Beatdown = {
            Active = true,
            Damage = 7,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Beatdown"
            }),
            Properties = {
                Armor = true
            },
            Cooldown = {
                Time = 18,
                AfterMove = true
            },
            Block = {
                Unblockable = true
            },
            HitRemotes = { v2 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            FinalHit = {
                Damage = 18,
                Block = {
                    Unblockable = true
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2,
                    Velocity = Vector3.new(0, 20, 0)
                },
                HitRemotes = { v3 }
            }
        },
        ["Hollow Purple"] = {
            Active = true,
            Damage = 70,
            Distance = 20,
            Piercing = true,
            Stun = 1,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Hollow Purple"
            }),
            Cooldown = {
                Time = 25,
                AfterMove = true
            },
            Block = {
                Unblockable = true
            },
            Meter = {
                RequiredLevel = 2,
                MeterGain = 0
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 6969752955,
                    Volume = 1
                }
            }
        },
        ["Teleportation Kick"] = {
            Active = true,
            Damage = 15,
            Stun = 1,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Teleportation Kick"
            }),
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = {
                    SoundId = 6969752955,
                    Volume = 1
                }
            },
            Kick = {
                Damage = 20,
                Stun = 1,
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = {
                        SoundId = 6969753943,
                        Volume = 1
                    }
                }
            }
        },
        ["Infinity Burst"] = {
            Active = true,
            Damage = 35,
            Stun = 0.85,
            Actionable = {
                Active = true
            },
            Indicators = CreateMultiIndicator({
                Universal = "Infinity Burst"
            }),
            Block = {
                Blockable = true
            },
            Cooldown = {
                Time = 22,
                AfterMove = true
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 64,
                Time = 0.2,
                Velocity = Vector3.new(0, 40, 0)
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(30, 30, 30),
                Debug = false,
                Offset = CFrame.identity
            }
        },
        Teleport = {
            From = "Combat.Teleport"
        },
        ["Infinite Void"] = {
            Active = true,
            DELength = 25,
            Actionable = {
                Active = true,
                DomainExpansion = false
            },
            Indicators = CreateMultiIndicator({
                Universal = "Infinite Void"
            }),
            Cooldown = {
                Name = "Infinite Void",
                Time = 60,
                Manual = true
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 39,
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            Meter = {
                RequiredLevel = 4
            },
            VoidFinisher = {
                Block = {
                    BypassCounter = true,
                    Unblockable = true
                },
                HitRemotes = { v2 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                }
            },
            HeadRip = {
                Damage = 80,
                TrueDamage = true,
                Priority = EnumsModule.Intangible.Move,
                Stun = {
                    Time = 0.35
                },
                Ragdoll = {
                    Time = 0.5
                },
                Block = {
                    BypassCounter = true,
                    Unblockable = true
                },
                HitRemotes = { v2 }
            }
        }
    },
    Sounds = {
        AirPalmWindup = {
            SoundId = 13514574113
        },
        AirPalm = {
            SoundId = 13514574320
        },
        BlueAmpExplosion = {
            SoundId = 13514574193
        },
        BlueAmpThrow = {
            SoundId = 13514574269
        },
        BlueAmpWindup = {
            SoundId = 13514574562
        },
        ReversalRedWindup = {
            SoundId = 13514575276
        },
        ReversalRedExplosion = {
            SoundId = 13514575378,
            Volume = 2.5
        },
        ReversalRedVoiceline = {
            SoundId = 6893465424,
            Volume = 3
        },
        BeatdownSwing = {
            SoundId = 13514574359
        },
        Beatdown = {
            SoundId = 13514574429
        },
        Burst = {
            SoundId = 13514574517,
            Volume = 2
        },
        BurstWindup = {
            SoundId = 13514574612
        },
        HollowPurple = {
            SoundId = 7019059544,
            Volume = 3
        },
        HollowSwing = {
            SoundId = 6706981173,
            Volume = 0.800000011920929,
            PlaybackSpeed = 0.699999988079071
        },
        HollowSwing2 = {
            SoundId = 6706981173,
            Volume = 0.800000011920929,
            PlaybackSpeed = 0.5
        },
        Teleport = {
            SoundId = 6921223861,
            Volume = 2,
            PlaybackSpeed = 1.7000000476837158
        },
        TeleportSFX = {
            SoundId = 6920489474,
            Volume = 2,
            PlaybackSpeed = 1.7000000476837158
        },
        VoidEnd = {
            SoundId = 9062183597
        },
        VoidVL = {
            SoundId = 6863715225
        },
        VoidGrab = {
            SoundId = 9630851614
        },
        Shatter = {
            SoundId = 7330377498,
            Volume = 2
        },
        Interrupt = {
            SoundId = 6898045058,
            Volume = 3
        },
        LMBSwing1 = {
            SoundId = 13514574665
        },
        LMBSwing2 = {
            SoundId = 13514574809
        },
        LMBSwing3 = {
            SoundId = 13514574730
        },
        LMBSwing4 = {
            SoundId = 13514574879
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
                    SoundId = "rbxassetid://6507310858",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Haha! Don\'t worry, after all.. You\'re weak!"
                        } }
                }, {
                    SoundId = "rbxassetid://6507311213",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Who are... You?"
                        } }
                }, {
                    SoundId = "rbxassetid://6507311039",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t worry, I\'m the strongest."
                        } }
                } }
        }
    }
};
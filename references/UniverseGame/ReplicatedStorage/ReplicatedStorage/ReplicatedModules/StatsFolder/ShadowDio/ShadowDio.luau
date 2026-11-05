  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = ReplicatedStorage["Client Assets"];
local Output = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
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
local v21 = {
    Block = {
        From = "Combat.Block"
    },
    Quickstep = {
        From = "Combat.Quickstep"
    },
    Pose = {
        From = "Combat.Pose",
        Callbacks = {
            PoseTransition = function(p4, p5) -- Line: 54, Name: PoseTransition
                -- upvalues: Output (copy), EnableBirthmark (copy)
                local _ = p4.Stats;
                local Character = p4.Character;
                local v6 = Character:FindFirstChild("ShadowStand") or Character.Stand;
                Output:FireAllClients("FX", "ToggleTransparency", v6, p4.ParentStats.Summon.LeaveParts, 0.2, 0);

                for _, descendant in pairs(v6:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") and descendant.Name:match("StandAura") then
                        descendant.Enabled = true;
                    end;
                end;

                EnableBirthmark(p4.Character, true);
            end,

            Transformer = function(p7, p8) -- Line: 66, Name: Transformer
                -- upvalues: TableUtil (copy)
                local v9 = TableUtil.Copy(p7.Stats, true);
                local v10 = {};

                for _, child in p7.Character.Stand.StandHumanoidRootPart:GetChildren() do
                    if child:IsA("Sound") and string.find(child.Name, "PoseMusic") then
                        table.insert(v10, child);
                    end;
                end;

                v9.PoseMusic = v10[Random.new():NextInteger(1, #v10)].Name;
                table.clear(v10);

                return v9;
            end,

            PoseEnd = function(p11, p12) -- Line: 78, Name: PoseEnd
                -- upvalues: Output (copy), EnableBirthmark (copy)
                local _ = p11.Stats;
                local Character = p11.Character;
                local v13 = Character:FindFirstChild("ShadowStand") or Character.Stand;
                Output:FireAllClients("FX", "ToggleTransparency", v13, p11.ParentStats.Summon.LeaveParts, 0.2, 1);

                for _, descendant in pairs(v13:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") and descendant.Name:match("StandAura") then
                        descendant.Enabled = false;
                    end;
                end;

                EnableBirthmark(p11.Character, false);
            end
        }
    },
    Summon = {
        From = "Combat.Summon",
        Cooldown = 0.6,
        LeaveParts = { "StandHumanoidRootPart", "Exception" }
    },
    Crouch = {
        Cooldown = 0.5,
        Actionable = {}
    },
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        MaxCombo = 4,
        ComboTick = 1.5,
        Damage = 11.25,
        ["LMB-1"] = TableUtil.Reconcile({
            Speed = 1,
            Sequence = {
                { 0, "Start" },
                { 0, function(p14, p15, p16) -- Line: 115
                        -- upvalues: Knit (copy), Output (copy)
                        local v17 = Knit.CollectionService:HasTag(p16.Character, "Crouching");
                        Output:FireAllClients("FX", "ShadowDioJab", p16.Character.HumanoidRootPart, v17 == true and "Crouching" or "Normal", {
                            Player = p16.Player,
                            Character = p16.Character
                        });
                    end },
                { 0, "PlaySound", "Punch" },
                { 10, 15, "Attack" },
                { 20, "End" }
            },
            Stun = {
                Time = 0.5,
                Priority = EnumsModule.Stun.Medium
            },
            HitRemotes = { v2 },
            HitSounds = {
                Hit = {
                    SoundId = 5581386321,
                    Volume = 1
                }
            }
        }, BaseStatsModule.Stand_Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            Cooldown = 1.5,
            Stun = {
                Time = 0.25
            },
            HitRemotes = { v3 },
            Block = {
                Unblockable = true
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        Callbacks = {
            StateChecker = function(p18, p19) -- Line: 161, Name: StateChecker
                -- upvalues: TableUtil (copy)
                if p18.Character:GetAttribute("Crouching") then
                    local v20 = TableUtil.Copy(p18.Stats);
                    v20.CustomPrefix = "Crawl-LMB";

                    return v20;
                end;
            end
        }
    }
};
v21["Rush Attack"]["Crawl-LMB-1"] = v21["Rush Attack"]["LMB-1"];
v21["Rush Attack"]["Crawl-LMB-4"] = v21["Rush Attack"]["LMB-4"];
v21["High Kick"] = {
    Active = true,
    Damage = 30,
    Stun = 0.375,
    Cooldown = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 70,
        Time = 0.2
    },
    Ragdoll = {
        Time = 0.5
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 5581325281,
            Volume = 1
        }
    }
};
v21.Uppercut = {
    Active = true,
    Damage = 25,
    Stun = 0.7,
    Cooldown = 14,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3 },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.2,
        Velocity = Vector3.new(0, 8, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 5581325281,
            Volume = 1
        }
    }
};
v21["Knife Barrage"] = {
    Active = true,
    Damage = 1.042,
    Distance = 5,
    Stun = 0.3,
    Cooldown = 8,
    DistanceHitbox = false,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    HitRemotes = { v2 },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 6883673408,
            Volume = 1
        }
    }
};
v21["Space Ripper"] = {
    Active = true,
    Damage = 18.5,
    Distance = 5,
    Stun = 0.3,
    Cooldown = 15,
    Collision = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    CollisionSounds = {
        Default = {
            ID = 7172258964,
            Props = {
                Volume = 1,
                RollOffMaxDistance = 60
            }
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 6883673408,
            Volume = 1
        }
    }
};
v21["Stand Uppercut"] = {
    Active = true,
    Damage = 8,
    Stun = 0.9,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 5581325281,
            Volume = 1
        }
    },
    HitRemotes = { v2 },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    }
};
v21["Stand Strike"] = {
    Active = true,
    Damage = 35,
    Stun = 0.4,
    Armor = false,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Ragdoll = {
        Time = 0.5
    },
    Hitbox = {
        Type = "Region3",
        OriginPart = "StandHumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        MaxDistance = 100,
        Debug = false
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6883695371,
            Volume = 1
        }
    }
};
v21["Blood Suck"] = {
    Active = true,
    CheckPVPSafe = true,
    Cooldown = 18,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    }
};
v21.Counter = {
    Active = true,
    Cooldown = 15,
    Damage = 20,
    Stun = 1,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 1
    }
};
v21.Timestop = {
    Active = true,
    Cooldown = 60,
    Speed = 1,
    Actionable = {
        Active = true,
        CanTimestop = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "PlaySound", "TSVoice" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 50, "Timestop" }, { 80, "End" } },
    Meter = {
        RequiredLevel = 2,
        RemoveMeter = false
    },
    Timestop = {
        Time = 6,
        Size = 150,
        StopSounds = { "TimestopSFX", "Timestop-Voice" },
        ResumeSounds = { "TimestopEnd" }
    }
};
v21.Punishment = {
    Active = true,
    Cooldown = 15,
    Damage = 25,
    Stun = 1.25,
    Distance = 5,
    DistanceHitbox = true,
    Collision = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Block = {
        BlockBreak = true
    },
    Meter = {
        RequiredLevel = 2,
        MeterGain = 0
    },
    CollisionSounds = {
        Default = {
            ID = 7172258964,
            Props = {
                Volume = 1,
                RollOffMaxDistance = 60
            }
        }
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 6883695371,
            Volume = 1
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    }
};
v21.Teleport = {
    Active = true,
    Cooldown = 5,
    Actionable = {
        Active = true
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0.75,
            Color = Color3.new(1, 1, 1)
        },
        End = {
            Transparency = 1
        }
    }
};
v21.Swipe = {
    Active = true,
    Damage = 20,
    Cooldown = 10,
    Stun = 0.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 5581325281,
            Volume = 1
        }
    },
    Block = {
        BlockBreak = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            Crouching = {
                Visible = false,
                Priority = 1
            },
            Standing = {
                Visible = true,
                Priority = 2
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Crouch = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Summon = {
                DefaultKeybind = "U",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["High Kick"] = {
                DefaultKeybind = "E",
                State = "Standing",
                Unlocked = true,
                Description = "Perform a quick kick."
            },
            Uppercut = {
                DefaultKeybind = "E",
                State = "Crouching",
                Unlocked = true,
                Description = "Unleash an uppercut."
            },
            Swipe = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Unleash a jab"
            },
            ["Knife Barrage"] = {
                DefaultKeybind = "T",
                State = "Standing",
                Description = "Throw out mutliple knives forward three times.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Space Ripper"] = {
                DefaultKeybind = "T",
                State = "Crouching",
                Description = "Charge up before sending out beams through your eyes.",
                LevelRequirement = 75,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Blood Suck"] = {
                DefaultKeybind = "Y",
                Description = "Grab someone as you take their blood before throwing them away.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Stand Strike"] = {
                DefaultKeybind = "G",
                State = "Standing",
                Description = "The stand is quickly sent out while punching.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Stand Uppercut"] = {
                DefaultKeybind = "G",
                State = "Crouching",
                Description = "The stand jabs twice before uppercutting.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Punishment = {
                DefaultKeybind = "H",
                Description = "The stand jabs someone, if hit, time is stopped for a split second as multiple knives are thrown towards the target.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Instantly teleport in the direction you\'re facing.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Counter = {
                DefaultKeybind = "B",
                Description = "Enter a counterattack-state, when activated you will teleport behind the victim.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "X",
                Description = "Stop time within a radius.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 5743143026,
            ["LMB-2"] = 5743143026,
            ["LMB-3"] = 5743143026,
            ["LMB-4"] = 5743143026,
            ["Crawl-LMB-1"] = 5744018959,
            ["Crawl-LMB-2"] = 5744018959,
            ["Crawl-LMB-3"] = 5744018959,
            ["Crawl-LMB-4"] = 5744018959,
            Block = 6884411469,
            ["Air High Kick"] = 5745210729,
            ["High Kick"] = 5743435734,
            Swipe = 5743637619,
            ["Crawl Swipe"] = 5744536754,
            ["Knife Barrage"] = 6877202553,
            ["Stand Uppercut"] = 5814791131,
            Timestop = 5743687667,
            Uppercut = 5744251865,
            ["Stand Punishment"] = 6883716199,
            ["User Punishment"] = 6884146636,
            ["Punishment Taunt"] = 6884166974,
            Counter = 5808743686,
            ["Space Ripper"] = 6890349160,
            ["Stand Strike"] = 10501998179,
            PoseTransition = 7816711555,
            PoseIdle = 7816710198,
            Summon = 8083279582,
            TeleportPose = 10513224024,
            ChargeRipper = 6890347724,
            ["Blood Suck Attempt"] = 7365253855,
            ["Blood Suck Hit"] = 7351554341,
            ["Blood Suck Victim"] = 7351624747
        },
        Movement = {
            Walk = 5743812382,
            Run = 7037969480,
            ["Crouch-Walk"] = 5743942990,
            ["Crouch-Run"] = 5743942990
        },
        Idle = {
            Idle = 5743161197,
            ["Crouch-Idle"] = 5743942990,
            ["ShadowStand-Idle"] = 8083281888
        }
    },
    Stats = v21,
    Sounds = {
        PoseMusic = {
            SoundId = "rbxassetid://9992369214",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        woob = {
            SoundId = "rbxassetid://4626987771",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        h2 = {
            SoundId = "rbxassetid://5581325281",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        h1 = {
            SoundId = "rbxassetid://5581386321",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        deatjh = {
            SoundId = "rbxassetid://6883697798",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        YellSFX = {
            SoundId = "rbxassetid://4815052770",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wry = {
            SoundId = "rbxassetid://7365669432",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        VoicelineThing1 = {
            SoundId = "rbxassetid://3077287610",
            Volume = 2,
            PlaybackSpeed = 0.8999999761581421,
            Looped = false,
            TimePosition = 0
        },
        TimestopSFX = {
            SoundId = "rbxassetid://6883706480",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TimestopEnd = {
            SoundId = "rbxassetid://6859642317",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSVoice = {
            SoundId = "rbxassetid://6883833644",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Theme = {
            SoundId = "rbxassetid://9073415157",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        Teleport = {
            SoundId = "rbxassetid://6338868464",
            Volume = 10,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TakeThis = {
            SoundId = "rbxassetid://6883839795",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TakeThat = {
            SoundId = "rbxassetid://4814810509",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TSBurst = {
            SoundId = "rbxassetid://6883709210",
            Volume = 1,
            PlaybackSpeed = 0.8999999761581421,
            Looped = false,
            TimePosition = 0
        },
        Swings = {
            SoundId = "rbxassetid://6880537326",
            Volume = 0.25,
            PlaybackSpeed = 0.8999999761581421,
            Looped = false,
            TimePosition = 0
        },
        Summon = {
            SoundId = "rbxassetid://6883073574",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StingyEyesCharged = {
            SoundId = "rbxassetid://4783615055",
            Volume = 1,
            PlaybackSpeed = 0.8999999761581421,
            Looped = false,
            TimePosition = 0
        },
        StingyEyes = {
            SoundId = "rbxassetid://4783615055",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        StandJumpSFX = {
            SoundId = "rbxassetid://5872684313",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ShineSFX = {
            SoundId = "rbxassetid://6883671683",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Punishment = {
            SoundId = "rbxassetid://6883284088",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Punch = {
            SoundId = "rbxassetid://200632136",
            Volume = 0.25,
            PlaybackSpeed = 1.25,
            Looped = false,
            TimePosition = 0
        },
        KnifeThrowS = {
            SoundId = "rbxassetid://4783355889",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KnifeEquip = {
            SoundId = "rbxassetid://6883287128",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Knife = {
            SoundId = "rbxassetid://6883288144",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Kick = {
            SoundId = "rbxassetid://4774842889",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Hurt2 = {
            SoundId = "rbxassetid://4775602783",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Hurt = {
            SoundId = "rbxassetid://4775570960",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = "rbxassetid://4775664676",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Haha = {
            SoundId = "rbxassetid://6883285125",
            Volume = 0.3499999940395355,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Guard = {
            SoundId = "rbxassetid://648479338",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dodge = {
            SoundId = "rbxassetid://453318796",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Die = {
            SoundId = "rbxassetid://4776194748",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://6883671332",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Dash = {
            SoundId = "rbxassetid://858508159",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        CounterTeleport = {
            SoundId = "rbxassetid://4767242174",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Counter = {
            SoundId = "rbxassetid://4775994326",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ChargeAttack = {
            SoundId = "rbxassetid://6796766306",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BloodSucking = {
            SoundId = "rbxassetid://7365223914",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BloodSuckVoiceline = {
            SoundId = "rbxassetid://6754948670",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Blood = {
            SoundId = "rbxassetid://4775664015",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
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
                    SoundId = "rbxassetid://6883711772",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You are next."
                        } }
                }, {
                    SoundId = "rbxassetid://4845894614",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re looking at me, aren\'t you!"
                        } }
                }, {
                    SoundId = "rbxassetid://6883712770",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What is it that you desire?"
                        } }
                } }
        }
    },
    Metadata = {
        PostRig = function(p22) -- Line: 1159, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p22.Player;
            local Character = p22.Character;
            local SkinName = p22.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v23 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v23.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v23;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};
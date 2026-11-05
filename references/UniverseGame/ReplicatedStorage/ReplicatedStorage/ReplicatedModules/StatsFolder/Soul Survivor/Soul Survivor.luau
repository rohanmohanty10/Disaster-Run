  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local v1 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            Unlock = {
                Show = false,
                Visible = false,
                Priority = 4
            },
            Hyper = {
                Show = false,
                Visible = false,
                Priority = 6
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
            Brutalize = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Thy End Is Now"] = {
                DefaultKeybind = "E",
                State = "Universal",
                Unlocked = true,
                Description = "An ugomatic four punch combo, with the user teleporting to the nearest target and dashing before each punch. Final hit knocks enemies away.",
                IndicatorInfo = {
                    DisplayName = "\"Thy end is now!\""
                }
            },
            ["Uppercut / Overhead"] = {
                DefaultKeybind = "R",
                State = "Universal",
                Unlocked = true,
                Description = "When on the ground, perform an uppercut that sends the user and anyone hit high into the air.\nWhen in the air, performaA overhead strike which slams enemies into the ground. Overhead can be performed immediately after an uppercut.",
                IndicatorInfo = {
                    DisplayName = "Uppercut",
                    ActiveName = "Uppercut",
                    CooldownName = "Uppercut"
                }
            },
            ["Prepare Thyself"] = {
                DefaultKeybind = "T",
                State = "Universal",
                Description = "Send out a serpentine projectile that gradually homes in on targets.",
                LevelRequirement = 60,
                IndicatorInfo = {
                    DisplayName = "\"Prepare thyself!\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Judgement = {
                DefaultKeybind = "Y",
                State = "Universal",
                Description = "Wind up before teleporting directly in front of someone, performing an explosive dropkick.",
                LevelRequirement = 35,
                IndicatorInfo = {
                    DisplayName = "\"Judgement!\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Die = {
                DefaultKeybind = "G",
                State = "Universal",
                Description = "Jump into the air and aims before instantly slamming into the ground, dealing AOE damage upon impact.",
                LevelRequirement = 25,
                IndicatorInfo = {
                    DisplayName = "\"Die!\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Crush = {
                DefaultKeybind = "H",
                State = "Universal",
                Description = "Wind up before slamming directly into the ground below. If used midair, instantly slam into the ground from the air.",
                LevelRequirement = 75,
                IndicatorInfo = {
                    DisplayName = "\"Crush!\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Useless = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "A devastating open palm counter.",
                LevelRequirement = 50,
                IndicatorInfo = {
                    DisplayName = "\"Useless!\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            WEAK = {
                DefaultKeybind = "B",
                State = "Universal",
                Description = "Awakening which reduces damage taken, increases attack speed, and increases attack damage by 25%.",
                LevelRequirement = 90,
                IndicatorInfo = {
                    DisplayName = "\"WEAK.\""
                },
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Timestop = {
                DefaultKeybind = "U",
                State = "Unlock",
                DisplayName = "Chaos Control",
                Description = "Teh, faker.",
                Unlocked = true
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "U+",
                State = "Unlock",
                Unlocked = true
            },
            HyperTeleport = {
                DefaultKeybind = "C",
                State = "Hyper",
                DisplayName = "Chaos Teleport",
                Description = "Taste my power.",
                Unlocked = true
            }
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    Assets = ClientAssets["Soul Survivor"]
};
local v2 = {
    Damage = 10,
    NoKnockbackOnBlock = true,
    HitAnimations = "Default",
    Meter = false,
    Priority = EnumsModule.Intangible.Ragdoll,
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false,
        PerfectBlockBreak = false,
        BypassCounter = true
    },
    HitRemotes = { v1.Resources.LightHit },
    OnStanding = {
        Priority = EnumsModule.Intangible.Ragdoll,
        Knockback = {
            Type = "Velocity",
            RelativeTowards = "Target",
            Speed = 12,
            Velocity = Vector3.new(0, 12, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        }
    },
    OnRagdoll = {
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25,
            Override = true
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativeTowards = "Target",
                Speed = 8,
                Velocity = Vector3.new(0, 48, 0),
                Time = 0.2
            }, {
                Type = "Force",
                Force = Vector3.new(0, 215, 0),
                Time = 0.45
            } },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        }
    }
};
v1.Stats.Brutalize = {
    Active = true,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Startup = {
        Damage = 10,
        Grab = true,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Strike = {
        Damage = 20,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    ExternalStrike = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.15,
            Intangible = EnumsModule.Intangible.Ragdoll
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Knockback = {
            Type = "Velocity",
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.3
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Velocity = Vector3.new(0, 18, 0),
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Shockwave = TableUtil.Reconcile({}, v2)
};
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.7825,
        Sequence = { { 0, "Start" }, { 26, 30, "Attack" }, { 40, "End" } },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = { v1.Sounds["LMB-Hit"] }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.7825,
        Sequence = { { 0, "Start" }, { 29, 33, "Attack" }, { 40, "End" } },
        HitSounds = { v1.Sounds["LMB-Hit"] }
    },
    ["LMB-3"] = {
        Speed = 1.86875,
        Sequence = { { 0, "Start" }, { 26, 39, "Attack" }, { 40, "End" } },
        HitSounds = { v1.Sounds["LMB-Hit"] }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.7825,
        Sequence = { { 0, "Start" }, { 28, 32, "Attack" }, { 40, "End" } },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Sounds["LMB-Finisher"] }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p3) -- Line: 485, Name: Transformer
            -- upvalues: PathShortcuts (copy), TableUtil (copy)
            local v4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
            local Character = p3.Character;
            local v5 = Character:GetAttribute("Awakening");
            local v6 = TableUtil.Copy(p3.Stats, true);

            if v5 then
                v6.TimePosition = v4.FetchSound(Character, "AwakeningMusic").TimePosition or 47.5;
                v6.PoseMusic = "AwakeningPoseMusic";
            end;

            return v6;
        end,

        PoseTransition = function(p7) -- Line: 498, Name: PoseTransition
            -- upvalues: PathShortcuts (copy)
            local v8 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
            local Character = p7.Character;

            if Character:GetAttribute("Awakening") then
                v8.FetchSound(Character, "Awakening").Volume = 0;

                return;
            end;

            v8.FetchSound(Character, "Awakening").Volume = 2;
        end,

        PoseEnd = function(p9) -- Line: 510, Name: PoseEnd
            -- upvalues: PathShortcuts (copy)
            require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService").FetchSound(p9.Character, "Awakening").Volume = 2;
        end
    }
};
v1.Stats["Thy End Is Now"] = {
    AllowClientStacking = true,
    Active = true,
    VoicelineRange = 2,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 24,
        Offset = CFrame.new(0, 0, 0)
    },
    Hit = {
        Damage = 7.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 16,
            Time = 0.1
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = { v1.Sounds.ThyEndIsNowHit }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 14),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 1.25,
            Override = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Sounds.ThyEndIsNowFinisher }
    }
};
v1.Stats.Uppercut = {
    AllowClientStacking = true,
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 2.5, -4)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false,
        PerfectBlockBreak = false
    },
    Stun = {
        Time = 0.8
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Velocity = Vector3.new(0, 60, 0),
        Time = 0.1
    },
    HitRemotes = { v1.Resources.LightHit },
    HitSounds = { v1.Sounds.UppercutHit }
};
v1.Stats.Overhead = {
    AllowClientStacking = true,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Active = {
        Ignore = { "Uppercut" }
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 64,
        Offset = CFrame.new(0, 0, 0)
    },
    Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 9, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Stun = {
            Time = 0.3
        },
        Ragdoll = {
            Time = 1.5,
            Override = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Velocity = Vector3.new(0, -96, 0),
            Time = 0.1
        },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = { v1.Sounds.OverheadHit }
    }
};
v1.Stats["Uppercut / Overhead"] = {
    Indicators = { {
            Group = "Universal",
            Name = "Overhead",
            CooldownName = "Overhead",
            ActiveName = "Overhead",
            InputText = "%s^",
            Priority = 1,
            Visible = true
        } },

    Invoke = function(p10) -- Line: 724, Name: Invoke
        -- upvalues: Knit (copy)
        local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
        local _ = p10.Input;
        Knit.GetController("MoveInputController");
        Knit.GetService("MoveInputService"):FireInput(p10.RawInput, Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall);
    end
};
v1.Stats["Prepare Thyself"] = {
    AllowClientStacking = true,
    Active = true,
    Damage = 22.5,
    HitAnimations = "Default",
    VoicelineRange = 2,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Stun = {
        Time = 0.3
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 40,
        Time = 0.1
    },
    HitRemotes = { v1.Resources.SerpentHit },
    HitSounds = { v1.Sounds.PrepareThyselfHit }
};
v1.Stats.Judgement = {
    AllowClientStacking = true,
    Active = true,
    VoicelineRange = 2,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Name = "Judgement",
        Time = 18,
        AfterMove = true,
        Manual = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Search = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = 48,
        Offset = CFrame.new(0, 0, 0)
    },
    Hit = {
        Damage = 10,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 1,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = Vector3.new(6, 5, 7.5),
            Debug = false,
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -3.5)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Explosion = {
        Damage = 30,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 52,
            Velocity = Vector3.new(0, 30, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 1,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = 15,
            Debug = false,
            Offset = CFrame.new(0, 0, -3.5)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.LightHit },
        HitSounds = { v1.Sounds.JudgementHit }
    },
    Shockwave = TableUtil.Reconcile({
        Priority = 0
    }, v2)
};
v1.Stats.Die = {
    AllowClientStacking = true,
    Active = true,
    VoicelineRange = 2,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        ManualClient = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Meter = false,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 2.2,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = 8,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Explosion = {
        Damage = 20,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 48,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.45,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = 14,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Shockwave = v2,

    Invoke = function(p11) -- Line: 972, Name: Invoke
        -- upvalues: Knit (copy)
        local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
        local _ = p11.Input;
        Knit.GetController("MoveInputController");
        Knit.GetService("MoveInputService"):FireInput(p11.RawInput, Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall);
    end
};
v1.Stats.Crush = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Active = {
            Ignore = { "Thy End Is Now" }
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        ManualClient = true
    },
    Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Ragdoll = {
            Time = 2,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = 8,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Explosion = {
        CheckPVPSafe = true,
        Damage = 20,
        HitAnimations = "Default",
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 36,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 2,
            Override = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "StandHumanoidRootPart",
            Size = 14,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        HitRemotes = { v1.Resources.LightHit }
    },
    Shockwave = v2,

    Invoke = function(p12) -- Line: 1069, Name: Invoke
        -- upvalues: Knit (copy)
        local Humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid");
        local _ = p12.Input;
        Knit.GetController("MoveInputController");
        Knit.GetService("MoveInputService"):FireInput(p12.RawInput, Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall);
    end
};
v1.Stats.Useless = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    },
    Countered = {
        HitAnimations = "Default",
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    },
    Attack = {
        Damage = 35,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        HitRemotes = { v1.Resources.HeavyHit }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 52,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25,
            Override = true
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        }
    }
};
v1.Stats.WEAK = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 90,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 3,
        RemoveMeter = true
    }
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v1;
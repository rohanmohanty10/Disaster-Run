  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v2 = { {
        Name = "Output",
        Arguments = { "FX", "Box Emit Particle", "__Legacy" }
    } };
local v3 = {
    EmitType = "Enabled",
    EmitDuration = 0.2,
    Particle = ClientAssets["Crazy Diamond"].BarrageEffect.Attachment
};
local v4 = {
    EmitType = "Enabled",
    EmitDuration = 0.2,
    Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
};
local v5 = {
    EmitType = "Enabled",
    EmitDuration = 0.175,
    CustomParent = "Torso",
    Particle = ClientAssets["Crazy Diamond"].BarrageEffect.Attachment
};
v1.Summon = {
    From = "Combat.Summon",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            Name = "Summon",
            InputText = "%s",
            Visible = true
        } },
    LeaveParts = { "StandHumanoidRootPart", "Stand Torso", "Stand Head", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg", "HeadFace" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 96, 139)), ColorSequenceKeypoint.new(1, Color3.fromRGB(102, 181, 255)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = true
    },
    Indicators = { {
            Group = "Universal",
            Name = "Rush Attack",
            ActiveName = "Rush Attack",
            CooldownName = "Rush Attack",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 29, 36, "Attack" }, { 38, "End" } },
        Stun = {
            Time = 0.625,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = v2,
        HitData = v3,
        HitSounds = {
            Hit = {
                SoundId = 11713885181,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.45,
        Sequence = { { 0, "Start" }, { 40, 50, "Attack" }, { 55, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = v2,
        HitData = v4,
        HitSounds = {
            Hit = {
                SoundId = 11713885288,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            InputText = "%s",
            Visible = true
        } },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1.Barrage = TableUtil.Reconcile({
    Active = true,
    From = {
        ["Combat.Barrage"] = "Barrage"
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Name = "STANDON-E",
        Time = 8
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Barrage",
            ActiveName = "Barrage",
            CooldownName = "STANDON-E",
            InputText = "%s",
            Visible = true
        } },
    Hit = {
        Damage = 0.6,
        HitRemotes = v2,
        HitData = v3,
        HitSounds = {
            Hit = {
                SoundId = 10105987622,
                Volume = 0.85
            }
        }
    },
    Finisher = {
        Damage = 15,
        HitRemotes = v2,
        HitData = v4,
        HitSounds = {
            Hit = {
                SoundId = 11845593780,
                Volume = 1.5
            }
        }
    },
    ClashHit = {},
    ClashFinisher = {}
}, BaseStatsModule.Stand_Barrage);
v1.RMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "One Two Combination",
            ActiveName = "RMoves",
            CooldownName = "STANDON-R",
            InputText = "%s",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Restoration Uppercut",
            ActiveName = "RMoves",
            CooldownName = "STANDON-R-RESTORATION",
            InputText = "%s",
            Visible = false
        } },
    OneTwoCombination = {
        Cooldown = {
            Name = "STANDON-R",
            Time = 7.5
        },
        Hit1 = {
            DoNotHeal = true,
            Damage = 22.5,
            HitAnimations = "Default",
            Hitbox = {
                Type = "Region3",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = Vector3.new(7, 7, 8),
                Debug = true,
                Offset = CFrame.new(0, 0, -4)
            },
            Stun = {
                Time = 0.75,
                Priority = EnumsModule.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 5,
                Time = 0.1
            },
            HitRemotes = v2,
            HitSounds = {
                Hit = {
                    SoundId = 11845591898,
                    Volume = 1.5
                }
            },
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.175,
                Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
            }
        },
        Hit2 = {
            DoNotHeal = true,
            Damage = 12.5,
            HitAnimations = "Default",
            Hitbox = {
                Type = "Region3",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = true,
                Offset = CFrame.new(0, 0, -3.75)
            },
            Block = {
                PerfectBlockable = false,
                BlockBreak = true
            },
            Stun = {
                Time = 0.25,
                Priority = EnumsModule.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 50,
                Time = 0.3
            },
            HitRemotes = v2,
            HitSounds = {
                Hit = {
                    SoundId = 11845591898,
                    Volume = 2.5
                }
            },
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.175,
                Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
            }
        }
    },
    RestorationUppercut = {
        Cooldown = {
            Name = "STANDON-R-RESTORATION",
            Time = 18.25
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(5.3, 5.3, 5.3),
            Debug = true,
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        DoNotHeal = true,
        Damage = 32,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Heavy
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.3
        },
        HitRemotes = v2,
        HitData = {
            EmitType = "Enabled",
            EmitDuration = 0.175,
            Particle = ClientAssets["Crazy Diamond"].RestorationUppercutHeal.Attachment
        },
        HitAnimations = "Default",
        HitSounds = {
            Hit = {
                SoundId = 10358334745,
                Volume = 2.5
            }
        },
        UppercutHeal = {
            Damage = 10,
            Priority = EnumsModule.Intangible.Move,
            HitRemotes = v2,
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.175,
                Particle = ClientAssets["Crazy Diamond"].HealEffect.Attachment
            }
        }
    }
};
v1.TMoves = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Active = true,
    Indicators = { {
            Group = "StandOn",
            Name = "Lightning Jabs",
            ActiveName = "TMoves",
            InputText = "%s",
            CooldownName = "STANDON-T",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Rising Star",
            ActiveName = "TMoves",
            CooldownName = "STANDON-T-RESTORATION",
            InputText = "%s",
            Visible = false
        } },
    Cooldown = {
        Name = "STANDON-T",
        Time = 18.25,
        Manual = true
    },
    Attempt = {
        DoNotHeal = true,
        Damage = 5,
        Stun = 3.13,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            Debug = true,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitRemotes = v2,
        HitData = v5
    },
    Hit = {
        DoNotHeal = true,
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = v2,
        HitData = v5
    },
    Throw = {
        Priority = EnumsModule.Intangible.Move,
        Knockback = {
            RelativeTowards = "Target",
            Speed = 65,
            Time = 0.3,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 0.75
        }
    },
    RisingStar = {
        Cooldown = {
            Name = "STANDON-T-RESTORATION",
            Time = 18.25
        },
        Hit = {
            DoNotHeal = true,
            Stun = 3.75,
            Damage = 4.5,
            Priority = EnumsModule.Intangible.Move,
            HitRemotes = v2,
            HitData = v5
        },
        Barrage = {
            DoNotHeal = true,
            Damage = 0.9,
            Priority = EnumsModule.Intangible.Move,
            HitRemotes = v2,
            HitData = v5
        },
        Slam = {
            DoNotHeal = true,
            Damage = 2,
            Priority = EnumsModule.Intangible.Move
        }
    }
};
v1.YMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Pressure Cutter",
            ActiveName = "YMoves",
            InputText = "%s",
            CooldownName = "STANDON-Y",
            Visible = true
        }, {
            Group = "StandOn",
            Name = "Deadeye Shot",
            ActiveName = "YMoves",
            CooldownName = "STANDON-Y-HELD",
            InputText = "%s+",
            Visible = true
        } },
    PressureCutter = {
        Cooldown = {
            Name = "STANDON-Y",
            Time = 12
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 9),
            Debug = true,
            Offset = CFrame.new(0, 0, -4.25)
        },
        DoNotHeal = true,
        Damage = 23.5,
        Stun = {
            Time = 2,
            Priority = EnumsModule.Stun.Medium
        },
        HitAnimations = "Default",
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.1
        },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11845590230,
                Volume = 1.5
            }
        },
        HitData = {
            EmitType = "Enabled",
            EmitDuration = 0.15,
            Particle = ClientAssets["Crazy Diamond"].BloodEffect
        },
        Hit2 = {
            DoNotHeal = true,
            Damage = 11.5,
            HitAnimations = "Default",
            Priority = EnumsModule.Intangible.Move,
            Knockback = {
                RelativeTowards = "Target",
                Speed = 50,
                Time = 0.3
            },
            Ragdoll = {
                Time = 0.75
            },
            HitRemotes = v2,
            HitData = {
                EmitType = "Enabled",
                EmitDuration = 0.15,
                Particle = ClientAssets["Crazy Diamond"].BloodEffect2.Attachment
            }
        }
    },
    DeadeyeShot = {
        Damage = 40,
        HitAnimations = "Default",
        Cooldown = {
            Name = "STANDON-Y-HELD",
            Time = 12
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 20,
            Time = 0.3
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = v2,
        HitData = {
            EmitType = "Enabled",
            EmitDuration = 0.2,
            Particle = ClientAssets["Crazy Diamond"].DeadeyeHit.Attachment
        },
        HitSounds = {
            Hit = {
                SoundId = 11845589930,
                Volume = 2
            }
        }
    },

    Invoke = function(p6) -- Line: 565, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p6.Input;
        local v7 = Knit.GetController("MoveInputController");
        local v8 = Knit.GetService("MoveInputService");
        local v9 = os.clock();
        local v10 = false;

        while v7.Inputs[Input] do
            if os.clock() - v9 >= 0.2 then
                v10 = true;
                break;
            end;

            task.wait();
        end;

        v8:FireInput(Input, v10);
    end
};
v1.GMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Restoration Mode",
            ActiveName = "GMoves",
            InputText = "%s",
            CooldownName = "G",
            Visible = true
        } },
    Cooldown = {
        Name = "G",
        Time = 1
    }
};
v1.HMoves = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Instigation",
            ActiveName = "HMoves",
            CooldownName = "STANDON-H",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "STANDON-H",
        Time = 20,
        Manual = true
    }
};
v1.VMoves = {
    Active = true,
    DoNotHeal = true,
    Damage = 20,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Indicators = { {
            Group = "StandOn",
            Name = "Line Breaker",
            ActiveName = "VMoves",
            CooldownName = "STANDON-V",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "STANDON-V",
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(9, 9, 9),
        Debug = true,
        Offset = CFrame.new(0, 0, 0)
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    HitRemotes = v2,
    HitSounds = {
        Hit = {
            SoundId = 10357795859,
            Volume = 1.5
        }
    },
    HitData = {
        EmitType = "Enabled",
        EmitDuration = 0.2,
        Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
    }
};
v1.BMoves = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Active = true,
    Indicators = { {
            Group = "StandOn",
            Name = "Rock Wall",
            ActiveName = "BMoves",
            CooldownName = "STANDON-B",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "STANDON-B",
        Time = 3
    },
    ["Wall Creation"] = {
        DoNotHeal = true,
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(8.25, 5.3, 8.25),
            Debug = true,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = v2,
        HitData = {
            EmitType = "Enabled",
            EmitDuration = 0.2,
            Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
        }
    },
    ["Wall Punch"] = {
        DoNotHeal = true,
        Damage = 15,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(5.3, 5.3, 8.25),
            Debug = true,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 50,
            Time = 0.2,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 0.75
        },
        HitRemotes = v2,
        HitSounds = {
            Hit = {
                SoundId = 11845593398,
                Volume = 1.5
            }
        },
        HitData = {
            EmitType = "Enabled",
            EmitDuration = 0.175,
            Particle = ClientAssets["Crazy Diamond"].HeavyHitEffect.Attachment
        }
    }
};

return {
    CD_R = v1
};
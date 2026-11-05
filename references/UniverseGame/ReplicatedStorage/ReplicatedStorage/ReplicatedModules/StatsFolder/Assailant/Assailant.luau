  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2 = nil;
local u3 = nil;
local u4 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
Knit.OnStart():andThen(function() -- Line: 17
    -- upvalues: u2 (ref), Knit (copy), u3 (ref)
    if game:GetService("RunService"):IsServer() then
        u2 = Knit.GetService("EffectService");

        return;
    end;

    if game:GetService("RunService"):IsClient() then
        u3 = Knit.GetController("CombatController");
    end;
end);
local v5 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    },
    ["Blood Splatter"] = {
        Name = "Output",
        Arguments = {
            "FX",
            "Blood Rays",
            {
                Part = "__Target",
                SearchPart = "HumanoidRootPart",
                TrailRange = NumberRange.new(2, 3)
            }
        }
    },
    ["Blood Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/BloodHit",
                AutoSerialize = true
            } }
    }
};
local v6 = {
    Name = "Bleed",
    Stats = {
        Damage = 3.5,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        }
    }
};
v1.Breaker = {
    From = "Combat.Breaker"
};
v1["Phantom Step"] = {
    From = "Sorcerer Killer.Breakneck Dash",
    Active = true,
    Actionable = {
        Stunned = false,
        Disabled = true,
        Ragdolled = true,
        Active = {
            Ignore = { "Block" }
        },

        Check = function(p7, p8) -- Line: 114, Name: Check
            -- upvalues: u4 (copy)
            local v9 = u4.IsStunned(p7);

            if v9 and not p7:GetAttribute("EvasiveAvailable") then
                return false;
            end;

            if v9 and p7:GetAttribute("EvasiveAvailable") then
                p7:SetAttribute("EvasiveAvailable", false);
            end;

            return true;
        end
    },
    ClientActionable = {
        Stunned = false,
        Disabled = true,
        Active = {
            Ignore = { "Block", "Block_Client" }
        },

        Check = function(p10, p11) -- Line: 133, Name: Check
            -- upvalues: u3 (ref)
            return (not u3.IsStunned(p10) or p10:GetAttribute("EvasiveAvailable")) and true or false;
        end
    },
    Cooldown = {
        Name = "Phantom Step",
        Time = 1.5,
        Force = true,
        CooldownReduction = false,
        Manual = true
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Grab = {
    From = "Combat.Grab"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 27, "Attack" }, { 32, "End" } },
        HitRemotes = { v5["Light Hit"] },
        Stun = {
            Time = 0.7
        },
        HitSounds = {
            Hit = {
                SoundId = 89510492139581,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.15,
        Sequence = { { 0, "Start" }, { 27, "Attack" }, { 35, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 24, "Attack" }, { 29, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 89510492139581,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 40, "Attack" }, { 50, "End" } },
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 70914022198521,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Flurry = {
    Active = true,
    CustomPrefix = "Flurry",
    Speed = 1.15,
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75
    },
    Callbacks = {
        BarrageEffect = function(p12, p13, p14, p15) -- Line: 273, Name: BarrageEffect
            -- upvalues: Knit (copy), u2 (ref)
            local Character = p13.Character;

            if p15 then
                Knit.CollectionService:AddTag(Character, "Barrage");
                u2.FireAllClients("Shadow_BarrageEffect", {
                    Size = Vector3.new(5, 13.333333, 5),
                    Character = Character,
                    SkinName = p13.SkinName,
                    Color = Color3.fromRGB(144, 255, 122)
                });
                p14.SequenceTrove:Add(function() -- Line: 286
                    -- upvalues: Knit (ref), Character (copy), u2 (ref)
                    Knit.CollectionService:RemoveTag(Character, "Barrage");
                    u2.FireAllClients("Shadow_BarrageEffect", {
                        Character = Character
                    });
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barrage");
            end;

            return true;
        end
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Hit = TableUtil.Reconcile({
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(7.5, 7.5, 7.5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 89510492139581,
                Volume = 0.7
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitRemotes = { v5["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 86935034632231,
                Volume = 1
            }
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher,
    Sequence = {
        { 0, function(p16, p17, p18) -- Line: 350
                local _ = p18.Character;
                local _ = p18.Trove;
            end },
        { 0, "Barrage", true },
        { 0, "BarrageEffect", false },
        { 0, "PlaySound", "Flurry", {
                Cancelable = true
            } },
        { 15, "Cancelable", true },
        { 15, "CreateTag", "MaxWalkSpeed", 8 },
        { 37, "Clashable", true },
        { 38, "BarrageEffect", true },
        { 38, 196, "BarrageAttack", "Hit" },
        { 196, "BarrageEffect", false },
        { 196, "Cancelable", false },
        { 196, "Clashable", false },
        { 233, "BarrageAttack", "Finisher" },
        { 250, "End" }
    }
};
v1["Shattering Swing"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Light = {
        Damage = 12.5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 9, 12),
            HitboxType = "ClientHitbox",
            Tolerance = 4,
            Offset = CFrame.new(0, 0, -8)
        },
        Stun = {
            Time = 0.45
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.2
        },
        HitRemotes = { v5["Light Hit"] },
        StatusEffects = { v6 },
        HitSounds = {
            Hit = {
                SoundId = 89510492139581,
                Volume = 1.5
            }
        }
    },
    Heavy = {
        Damage = 20,
        CinnabarCrystallineInfliction = true,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 14),
            HitboxType = "ClientHitbox",
            Tolerance = 4.5,
            Offset = CFrame.new(0, 0, -10)
        },
        Stun = {
            Time = 0.7
        },
        Ragdoll = {
            Time = 0.6
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 70,
            Time = 0.15
        },
        StatusEffects = { v6 },
        Block = {
            BlockBreak = true,
            PerfectBlockBreak = true
        },
        HitRemotes = { v5["Heavy Hit"], v5["Blood Splatter"] },
        HitSounds = {
            Hit = {
                SoundId = 70914022198521,
                Volume = 1.5
            }
        }
    }
};
v1["Swift Assault"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 15
    },
    Attempt = {
        Damage = 10,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11.5, 9, 40),
            Offset = CFrame.new(0, 0, -20)
        },
        Stun = {
            Time = 1.5,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = true
        },
        HitRemotes = { v5["Light Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 70914022198521,
                Volume = 1.5
            }
        }
    },
    Grab = {
        Stab = {
            Damage = 15,
            MinHealth = 1,
            Priority = EnumsModule.Intangible.Move,
            HitRemotes = { v5["Blood Hit"], v5["Blood Splatter"] },
            StatusEffects = { v6 }
        },
        Kick = {
            Damage = 25,
            Priority = EnumsModule.Intangible.Move,
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.2,
                Velocity = Vector3.new(0, 5, 0)
            },
            Ragdoll = {
                Time = 1
            },
            HitRemotes = { v5["Heavy Hit"] }
        }
    }
};
v1["Void Pin"] = {
    Active = true,
    Damage = 30,
    RecastTime = 5,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 16,
        Manual = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Throw = {
        Meter = {
            RequiredAmount = 25
        }
    },
    Ragdoll = {
        Time = 0.6
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 25,
        Time = 0.15
    },
    HitSounds = {
        Hit = {
            SoundId = 72219684545461,
            Volume = 1.6
        }
    },
    HitRemotes = { v5["Heavy Hit"] }
};

return {
    Stats = v1,
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
                Priority = 5
            }
        },
        MovesInfo = {
            ["Amplified Reflexes"] = {
                State = "Passive",
                Description = "Your <b>Dash</b> is capable of escaping a <b>stunned</b> state, this has a <b>35 second</b> cooldown.",
                Equipped = true
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true
            },
            ["Phantom Step"] = {
                DefaultKeybind = "C",
                Equipped = true,
                Description = "Perform a dash that reaches further than normal Quicksteps."
            },
            Flurry = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Unleash a barrage of slashes with your dagger, ending with a powerful kick."
            },
            ["Shattering Swing"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "Wind up and perform a spinning slash, propelling you forwards while dealing moderate damage to foes. Inflicts <b>bleed</b>."
            },
            ["Void Pin"] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "Throw your dagger forwards. On contact with a target, the dagger will embed itself into the target, slowing it down and making it take increased damage. <b>Recast</b> to discard the embedded dagger early and teleport to the target."
            },
            ["Swift Assault"] = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "After a brief wind up, instantly dash forward, impaling any target in the way and knocking them away with a kick afterwards. Inflicts <b>bleed</b>."
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 131518009640224,
            Volume = 1.5
        },
        ["LMB-2"] = {
            SoundId = 115353045444086,
            Volume = 1.5
        },
        ["LMB-3"] = {
            SoundId = 85681342854445,
            Volume = 1.5
        },
        ["LMB-4"] = {
            SoundId = 100618300366506,
            Volume = 1.5
        },
        Flurry = {
            SoundId = 135293677684752,
            Volume = 1.5
        },
        ["Shattering Swing"] = {
            SoundId = 72779260784774,
            Volume = 1.5
        },
        ["Void Pin"] = {
            SoundId = 140005862520381,
            Volume = 1.5
        },
        ["Void Pin Teleport"] = {
            SoundId = 127047908669104,
            Volume = 1.5
        },
        ["Void Pin Ambience"] = {
            SoundId = 136269645960936,
            Volume = 0.6,
            Looped = true
        },
        ["Swift Assault"] = {
            SoundId = 125971711190326,
            Volume = 1.5
        },
        ["Swift Assault Grab"] = {
            SoundId = 111795093695576,
            Volume = 1.5
        },
        Dash = {
            SoundId = 18948742605,
            Volume = 2
        },
        DashForward = {
            SoundId = 18948742361,
            Volume = 2
        },
        PassiveSigil = {
            SoundId = 108769487702101,
            Volume = 0.125,
            PlaybackSpeed = 1.35,
            Looped = true
        },
        PoseMusic = {
            SoundId = 96877693485889,
            Volume = 2,
            Looped = true
        }
    },
    Animations = {
        Action2 = {
            ["LMB-1"] = 102255283517712,
            ["LMB-2"] = 105956070576612,
            ["LMB-3"] = 106160772208663,
            ["LMB-4"] = 135691082656738,
            Flurry = 128054060545249,
            ["Shattering Swing"] = 136833215885115,
            ["Swift Assault"] = 132582899554307,
            ["Swift Assault Target"] = 74476885404194,
            ["Swift Assault User"] = 81055456178035,
            ["Void Pin"] = 99590156318599,
            PoseIdle = 85153912087436,
            PoseTransition = 111537384507093
        },
        Action = {
            ForwardDash1 = 16731260577,
            ForwardDash2 = 16731262071,
            BackwardDash = 16731258517,
            LeftDash = 16731263558,
            RightDash = 16731264589
        },
        Movement = {
            Walk = 108312896124964,
            Run = 100993475626350
        },
        Idle = {
            Idle = 96016434622510
        }
    }
};
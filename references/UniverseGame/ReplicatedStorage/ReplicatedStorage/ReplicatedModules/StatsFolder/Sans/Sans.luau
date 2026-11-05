  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage.Remotes;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local u2 = ReplicatedStorage["Client Assets"];
local CollectionService = game:GetService("CollectionService");
game:GetService("ServerStorage");
local RunService = game:GetService("RunService");
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: PathShortcuts (copy), u3 (ref), u4 (ref), Knit (copy), u5 (ref), u6 (ref)
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u4 = Knit.GetService("EffectService");
    u5 = Knit.GetService("TagService");
    u6 = Knit.GetService("StatService");
end);
local v7 = {
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "geeettttttt dunked on!!",
                ScaleTime = 1,
                Expression = 6,
                Interval = 0.03,
                PrefixIgnore = true,
                Voice = true,
                Dialogue = { "geeettttttt dunked on!!" }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "you\'re gonna have a bad time.",
                ScaleTime = 1.5,
                Expression = 7,
                Interval = 0.03,
                Dialogue = { "you\'re gonna have a bad time." }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "just give up, ",
                Interval = 0.03,
                Dialogue = { "just give up,", "i did." },
                Expression = { 4, 5 }
            }, {
                Quote = " i did.",
                ScaleTime = 0.75
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "you look frustrated for some reason. ",
                ScaleTime = 1.5,
                Interval = 0.03,
                Dialogue = { "you look frustrated for some reason.", "guess i\'m pretty good at my job, huh?" },
                Expression = { 1, 6 }
            }, {
                Quote = "guess i\'m pretty good at my job, huh?",
                ScaleTime = 1.9
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "let\'s just get to the point.",
                ScaleTime = 1.3,
                Expression = 4,
                Interval = 0.03,
                Dialogue = { "let\'s just get to the point." }
            } }
    },
    {
        SoundId = "",
        SoundVolume = 2,
        YieldSound = false,
        Visible = true,
        FullQuote = { {
                Quote = "human, ",
                ScaleTime = 0.4,
                Expression = 2,
                Voice = false,
                Interval = 0.15,
                Dialogue = { "human, i remember you\'re neutrals." }
            }, {
                Quote = "i remember you\'re ",
                ScaleTime = 1.5
            }, {
                Quote = "neutrals.",
                ScaleTime = 3
            } }
    }
};

local function QuoteCallback(p8, p9) -- Line: 162
    -- upvalues: EffectsHandler (copy)
    if not p9 then
        return;
    end;

    local v10 = p9.FullQuote[1];
    local v11 = {
        Character = "Sans",
        PrefixIgnore = true,
        Expression = v10.Expression,
        Dialogue = v10.Dialogue,
        Interval = v10.Interval,
        Voice = v10.Voice or true
    };
    local LocalPlayer = game:GetService("Players").LocalPlayer;

    if game:GetService("Players"):GetPlayerFromCharacter(p8) ~= LocalPlayer then
        local Settings = LocalPlayer:FindFirstChild("Settings");

        if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
            return;
        end;
    end;

    EffectsHandler.CallEffect("Q_RADIAL", {
        Origin = p8.HumanoidRootPart.CFrame,
        Distance = p8:GetAttribute("InCombat") and 20 or 55,
        Effect = {
            {
                Effect = "Undertale Dialogue",
                Arguments = { v11 }
            }
        }
    });
end;

for _, v in v7 do
    v.ClientCallback = QuoteCallback;
end;

v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p12) -- Line: 216, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v13 = TableUtil.Copy(p12.Stats, true);
            local v14 = math.random(1, 100);
            local v15 = { "PoseMusic2", "PoseMusic4" };

            if v14 <= 75 then
                return v13;
            end;

            if v14 <= 99 then
                v13.PoseMusic = v15[math.random(1, #v15)];

                return v13;
            end;

            v13.PoseMusic = "SpecialPose";

            return v13;
        end
    }
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = false
    },
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
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        Speed = 1.3,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, function(p16, p17, p18) -- Line: 279
                    -- upvalues: u2 (copy)
                    local u19 = u2.Sans.BoneWeapon:Clone();
                    u19.Parent = p18.Character;
                    task.delay(0.4, function() -- Line: 283
                        -- upvalues: u19 (copy)
                        u19:Destroy();
                    end);
                end },
            { 19, 22, "Attack" },
            { 27, "End" }
        },
        Stun = {
            Time = 0.45,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect",
                    "__Legacy",
                    {
                        Color = Color3.new(0.588235, 0.588235, 0.87451)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 1.5
            }
        },
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "KQ_MARK_SHA_TARGET"
            } }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 1.3,
        Sequence = {
            { 0, "Start" },
            { 0, function(p20, p21, p22) -- Line: 335
                    -- upvalues: u2 (copy)
                    local u23 = u2.Sans.BoneWeapon:Clone();
                    u23.Parent = p22.Character;
                    task.delay(0.4, function() -- Line: 339
                        -- upvalues: u23 (copy)
                        u23:Destroy();
                    end);
                end },
            { 16, 18, "Attack" },
            { 19, "End" }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect",
                    "__Legacy",
                    {
                        Color = Color3.new(0.588235, 0.588235, 0.87451)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-3"] = {
        Speed = 1.25,
        Sequence = {
            { 0, "Start" },
            { 0, function(p24, p25, p26) -- Line: 370
                    -- upvalues: u2 (copy)
                    local u27 = u2.Sans.BoneWeapon:Clone();
                    u27.Parent = p26.Character;
                    task.delay(0.4, function() -- Line: 374
                        -- upvalues: u27 (copy)
                        u27:Destroy();
                    end);
                end },
            { 19, 22, "Attack" },
            { 27, "End" }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HitEffect",
                    "__Legacy",
                    {
                        Color = Color3.new(0.588235, 0.588235, 0.87451)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 6706979361,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.3,
        Cooldown = 0.75,
        HitAnimations = "Default",
        Sequence = {
            { 0, "Start" },
            { 0, function(p28, p29, p30) -- Line: 405
                    -- upvalues: u2 (copy)
                    local u31 = u2.Sans.BoneWeapon:Clone();
                    u31.Parent = p30.Character;
                    task.delay(0.4, function() -- Line: 409
                        -- upvalues: u31 (copy)
                        u31:Destroy();
                    end);
                end },
            { 22, 24, "Attack" },
            { 26, "End" }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HeavyEffect",
                    "__Legacy",
                    {
                        Color = Color3.new(0.670588, 0.670588, 1)
                    }
                }
            }
        },
        HitSounds = {
            Hit = {
                SoundId = 7243326637,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p32, p33) -- Line: 442, Name: StateChecker
            -- upvalues: CollectionService (copy), TableUtil (copy)
            local Stats = p32.Stats;

            if not CollectionService:HasTag(p32.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1.Switch = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Cooldown = {
        Time = 1
    }
};
v1["Bone Guard"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Velocity = Vector3.new(0, 5, 0),
        Time = 0.2
    },
    Cooldown = {
        Time = 10
    },
    Block = {
        BlockBreak = true
    }
};
v1["Gaster Blaster"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15.3, 15.3, 15.3),
        Debug = false,
        Offset = CFrame.identity
    },
    Block = {
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 13
    }
};
v1.Heh = {
    Active = true,
    Damage = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Block = {
        Unblockable = true
    },
    Stun = {
        Time = 2.5,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HeavyEffect",
                "__Legacy",
                {
                    Color = Color3.new(0.333333, 0.666667, 1)
                }
            }
        }
    },
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Cooldown = {
        Time = 25
    }
};
v1.Bait = {
    Active = true,
    Damage = 3.125,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 30, 30),
        Debug = false,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.4,
        Priority = Enums.Stun.Medium
    },
    Meter = {
        RequiredLevel = 0
    },
    Block = {
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 15
    },
    Initial = {
        CheckPVPSafe = true,
        Hitbox = {
            Size = 10,
            Debug = false,
            Offset = CFrame.identity
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        }
    }
};
v1.Teleport = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Cooldown = {
        Time = 5
    }
};
v1["Bone Launch"] = {
    Active = true,
    Damage = 20,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.identity
    },
    Stun = {
        Time = 0.7,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Velocity = Vector3.new(0, 5, 0),
        Time = 0.2
    },
    Meter = {
        RequiredLevel = 1,
        MeterGain = 0
    },
    Cooldown = {
        Time = 20
    }
};
v1.End = {
    Active = true,
    Damage = 1,
    Actionable = {
        Stunned = true,
        Active = true,
        Summoned = false,
        Disabled = true
    },
    Priority = Enums.Intangible.Move + 1,
    Block = {
        Blockable = false
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = {
        {
            Name = "Output",
            Arguments = {
                "FX",
                "HeavyEffect",
                "__Legacy",
                {
                    Color = Color3.new(0.333333, 0.666667, 1)
                }
            }
        }
    },
    Cooldown = {
        Time = 30
    },
    Meter = {
        RequiredAmount = 65,
        MeterGain = 0
    },
    Bone = {
        Damage = 20,
        Stun = {
            Time = 5,
            Priority = Enums.Stun.Medium
        },
        Block = {
            PerfectBlockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 6843021165,
                Volume = 1
            }
        },
        HitRemotes = {
            {
                Name = "Output",
                Arguments = {
                    "FX",
                    "HeavyEffect",
                    "__Legacy",
                    {
                        Color = Color3.new(0.333333, 0.666667, 1)
                    }
                }
            }
        }
    }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
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
            Switch = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Bone Guard"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Unleash bones from the ground, impaling those directly in front of you."
            },
            ["Gaster Blaster"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Summon a Gaster Blaster, which shoots a beam from its mouth."
            },
            Heh = {
                DefaultKeybind = "T",
                Description = "Strike a pose and impale anyone with a bone who attacks you.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Bait = {
                DefaultKeybind = "Y",
                Description = "Throw a bone that summons Gaster Blasters that shoot beams where the bone lands.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Bone Launch"] = {
                DefaultKeybind = "B",
                Description = "Summon a bone from the ground, launching you into the air while damaging enemies nearby.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            End = {
                DefaultKeybind = "H",
                Description = "Throw a bone. If this lands on a target, raise them into the air, before striking them with a barrage of bones and blasts from all sides.",
                LevelRequirement = 100,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            Teleport = {
                DefaultKeybind = "V",
                Description = "Teleport forward.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            Switch = 6745399620,
            ["Bone Guard"] = 7272561672,
            ["StandOff-LMB-1"] = 7298024103,
            ["StandOff-LMB-2"] = 7298030784,
            ["StandOff-LMB-3"] = 7298037078,
            ["StandOff-LMB-4"] = 7298041852,
            Teleport = 7298009816,
            Bait = 6888629358,
            BoneLaunch = 6861728070,
            PoseTransition = 7782503795,
            PoseIdle = 7782502700,
            GasterBlaster = 6843121557,
            End = 7421927022,
            Counter = 6838598193,
            SansImpale = 6839200594,
            DodgeAnimation1 = 16731258517,
            DodgeAnimation2 = 11005538985,
            DodgeAnimation3 = 13110059106,
            DodgeAnimation4 = 13110059920
        },
        Movement = {
            Walk = 7272215843,
            Run = 7272215238
        },
        Idle = {
            Idle = 7272213387
        }
    },
    Stats = v1,
    Sounds = {
        Sound = {
            SoundId = "rbxassetid://4836187667",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        tp = {
            SoundId = "rbxassetid://6843073630",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://6843015517",
            Volume = 1,
            PlaybackSpeed = 1.05,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://6843015517",
            Volume = 1,
            PlaybackSpeed = 1.1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://6843015517",
            Volume = 1,
            PlaybackSpeed = 1.15,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://6843015517",
            Volume = 1,
            PlaybackSpeed = 1.2,
            Looped = false,
            TimePosition = 0
        },
        swing = {
            SoundId = "rbxassetid://6843015517",
            Volume = 2,
            PlaybackSpeed = 1.25,
            Looped = false,
            TimePosition = 0
        },
        gsl = {
            SoundId = "rbxassetid://6853300303",
            Volume = 1,
            PlaybackSpeed = 1.25,
            Looped = false,
            TimePosition = 0
        },
        OwO = {
            SoundId = "rbxassetid://7251868863",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GottemBadtime = {
            SoundId = "rbxassetid://7251777382",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        End = {
            SoundId = "rbxassetid://5490442418",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://10384542111",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        PoseMusic2 = {
            SoundId = "rbxassetid://99852408232705",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        PoseMusic3 = {
            SoundId = "rbxassetid://137396143358038",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        PoseMusic4 = {
            SoundId = "rbxassetid://77009731395830",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        SpecialPose = {
            SoundId = "rbxassetid://85162893715710",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        ["Move Indicator"] = {
            SoundId = 13628117086,
            Volume = 1,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 0.38)
        },
        LastBreathPose = {
            SoundId = 104570124025358,
            Volume = 3.25
        },
        TheKillSound = {
            SoundId = 2892218731,
            Volume = 5
        },
        TheKOSound = {
            SoundId = 6883696417,
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
            Universal = v7
        }
    },
    Metadata = {
        PostRig = function(p34) -- Line: 1037, Name: PostRig
            -- upvalues: RunService (copy), Trove (copy), u3 (ref), u5 (ref), u6 (ref)
            local Player = p34.Player;
            local _ = p34.Character;

            if not (RunService:IsServer() and Player) then
                return;
            end;

            local u35 = "AnyResurrection" .. tick();
            local Character = Player.Character;
            local Humanoid = Character.Humanoid;
            Random.new();
            local u36 = Trove.new();
            u36:AttachToInstance(Character);
            u3.AttackHook:Unhook("Inbound", u35);

            local function LastBreathRevive() -- Line: 1053
                -- upvalues: Humanoid (copy), u3 (ref), u35 (copy), u5 (ref), Character (copy), u36 (copy), u6 (ref)
                if Humanoid:GetAttribute("IsReviving") then
                    return;
                end;

                Humanoid:SetAttribute("IsReviving", true);
                u3.AttackHook:Unhook("Inbound", u35);
                local v37 = u5:GetContainer(Character);
                local v38 = u36:Extend();
                u6.GetStatsInfo(Character);
                local Animation = Instance.new("Animation");
                Animation.AnimationId = "rbxassetid://7070248368";
                local v39 = Humanoid.Animator:LoadAnimation(Animation);
                v39.Priority = Enum.AnimationPriority.Action4;
                v39.Looped = false;
                local u40 = u3.GetSound(Character, "LastBreathPose");
                u40.TimePosition = 16.1;
                u36:Add(u5:Add(v37, "DamageMultiplier", 2));
                u36:Add(u5:Add(v37, "DamageReceivalMultiplier", 1.75));
                u36:Add(u5:Add(v37, "CooldownMultiplier", 0.75));
                u36:Add(u5:Add(v37, "TimescaleMultiplier", 1.25));
                v38:Add(function() -- Line: 1092
                    -- upvalues: Humanoid (ref)
                    if Humanoid then
                        Humanoid:SetAttribute("IsReviving", nil);
                        Humanoid.RootPart.Anchored = false;
                    end;
                end);
                Humanoid.Health = 0.001;
                Humanoid.RootPart.Anchored = true;
                v38:Add(u5:Add(v37, "Intangible", u3.Enums.Intangible.True));
                v38:Add(u5:Add(v37, "NoRotate"));
                v38:Add(u5:Add(v37, "DisableInputs", true));
                v38:Add(u5:Add(v37, "MaxWalkSpeed", 0));
                v38:Add(u5:Add(v37, "MaxJumpPower", 0));
                v39:Play();
                u3.PlaySound(Character, "TheKillSound");
                task.wait(1.5);
                v39:AdjustSpeed(0);
                u3.PlaySound(Character, "TheKOSound");
                task.wait(2);

                for i = 1, 25 do
                    Humanoid.Health = Humanoid.MaxHealth / (25 - i);

                    if i >= 4.166666666666667 and not u40.IsPlaying then
                        u40:Resume();
                        v39:AdjustSpeed(-0.325);
                    end;

                    task.wait(0.2);
                end;

                Humanoid.Health = Humanoid.MaxHealth;

                if v39.IsPlaying then
                    v39.Stopped:Wait();
                end;

                v39:Stop();
                v38:Destroy();

                if Humanoid then
                    u36:Connect(Humanoid.Died, function() -- Line: 1131
                        -- upvalues: u40 (copy)
                        u40.TimePosition = 235.5;
                        u40.Looped = false;
                    end);
                    local u42 = task.spawn(function() -- Line: 1135
                        -- upvalues: Humanoid (ref)
                        while true do
                            task.wait(0.625);

                            if not (Humanoid and Humanoid.RootPart) then
                                break;
                            end;

                            local v41 = Humanoid;
                            v41.Health = v41.Health - 2.05;
                        end;
                    end);
                    u36:Add(function() -- Line: 1145
                        -- upvalues: u42 (copy)
                        if u42 then
                            task.cancel(u42);
                        end;
                    end);
                end;
            end;

            local u43 = nil;

            local function ReviveFunction() -- Line: 1154
                -- upvalues: Player (copy), Character (copy), Humanoid (copy), u3 (ref), u43 (ref), LastBreathRevive (copy)
                if not Player:FindFirstChild("PersonalUnlocker") or Character.SansEye.Handle.Blue.Value then
                    return;
                end;

                Humanoid.Health = Humanoid.MaxHealth;
                u3.Interrupted:Fire(Character, {
                    Type = "Ragdoll"
                });

                if u43 then
                    u43:Disconnect();
                end;

                task.spawn(LastBreathRevive);
            end;

            u43 = Humanoid.Died:Once(ReviveFunction);
            u3.AttackHook:Hook("Inbound", u35, 6, function(p44) -- Line: 1171
                -- upvalues: Character (copy), Player (copy), Humanoid (copy), ReviveFunction (copy)
                local Stats = p44.Stats;

                if p44.State.Halt then
                    return true;
                end;

                if p44.Target == Character and Stats.Damage and (Player:FindFirstChild("PersonalUnlocker") and (not Character.SansEye.Handle.Blue.Value and Humanoid.Health - Stats.Damage <= 1) or Humanoid:GetAttribute("IsReviving")) then
                    p44.State.Halt = true;
                    p44.State.Continue = false;
                    ReviveFunction();
                    Stats.Damage = 0;
                    Stats.Stun = nil;
                end;

                return true;
            end);
            u36:Add(function() -- Line: 1194
                -- upvalues: u43 (ref), u3 (ref), u35 (copy)
                if u43 then
                    u43:Disconnect();
                end;

                u3.AttackHook:Unhook("Inbound", u35);
            end);
        end
    }
};
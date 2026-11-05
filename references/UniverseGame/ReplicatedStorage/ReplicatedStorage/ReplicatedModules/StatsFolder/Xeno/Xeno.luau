  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Utility);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local CurrentCamera = workspace.CurrentCamera;
game:GetService("CollectionService");
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 15
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MoveInputService");
end);
local v2 = {};
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "XenoHit",
            LookAt = "Attacker"
        } }
};
local v4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "XenoHeavy",
            LookAt = "Attacker"
        } }
};
local v5 = {
    SoundId = 14939219547,
    Volume = 1
};

local function GetFacing(p6, p7) -- Line: 58
    -- upvalues: CurrentCamera (copy)
    local v8 = nil;
    local v9 = nil;
    local v10 = p7 or 10;
    local HumanoidRootPart = p6:FindFirstChild("HumanoidRootPart");
    local Humanoid = p6:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p6 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v11 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v11 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v10 >= Magnitude then
                            if v8 then
                                if Magnitude < v9 then
                                    v8 = child;
                                end;
                            else
                                v8 = child;
                                v9 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v8;
    end;
end;

local function CreateIndicator(p12) -- Line: 96
    return {
        Group = p12.Group or "Universal",
        Name = p12.Name,
        DisplayName = p12.DisplayName or p12.Name,
        CooldownName = p12.CooldownName or p12.Name,
        ActiveName = p12.ActiveName or p12.Name,
        InputText = p12.InputText or "%s",
        Visible = p12.Visible or true
    };
end;

v2.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
    Callbacks = {
        Summon = function(p13) -- Line: 120, Name: Summon
            for _, descendant in p13.AbilityModel:GetDescendants() do
                if descendant.Name == "StandAura" and descendant:IsA("Trail") then
                    descendant.Enabled = true;
                end;
            end;
        end,

        Desummon = function(p14) -- Line: 129, Name: Desummon
            for _, descendant in p14.AbilityModel:GetDescendants() do
                if descendant.Name == "StandAura" and descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;
        end
    }
};
v2.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p15) -- Line: 143, Name: PoseTransition
            -- upvalues: Knit (copy)
            Knit.GetService("EffectService").FireAllClients("XenoPoseEffect", {
                Player = p15.Player,
                Attacker = p15.Character
            });
        end
    }
};
v2["Rush Attack"] = {
    From = "Combat.Rush Attack",
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Damage = 8,
        Sequence = { { 0, "Start" }, { 10, 20, "Attack" }, { 25, "End" } },
        Stun = {
            Time = 0.75,
            StunDecay = true
        },
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 14939219547,
                Volume = 1
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 10, 20, "Attack" }, { 25, "End" } }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 15, 20, "Attack" }, { 25, "End" } }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 21,
        Sequence = { { 0, "Start" }, { 15, 25, "Attack" }, { 30, "End" } },
        Stun = {
            Time = 0.3,
            StunDecay = true
        },
        HitRemotes = { v4 },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14939219391,
                Volume = 1
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = {
        Stun = {
            Time = 0.75,
            StunDecay = true
        }
    }
};
v2["Rush Attack"] = TableUtil.Reconcile(v2["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v2.Block = {
    From = "Combat.Block"
};
v2.Quickstep = {
    From = "Combat.Quickstep"
};
v2["Shadow Burst"] = {
    Active = true,
    Damage = 20,
    Stun = 0.75,
    Amount = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.identity
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    }
};
v2["Critical Strike"] = {
    Active = true,
    Damage = 35,
    CritBonus = 1.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium + 1
    },
    Ragdoll = {
        Time = 0.5
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Velocity = Vector3.new(0, 15, 0),
        Time = 0.25
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 14939231883,
            Volume = 1
        }
    }
};
v2["Shadow Wheel"] = {
    Active = true,
    Damage = 2,
    Distance = 2.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false,
        BypassCounter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 8,
        Offset = CFrame.identity
    },
    HitSounds = {
        Hit = v5
    }
};
v2["Cross Blow"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    First = {
        Damage = 12,
        Stun = {
            Time = 0.75,
            StunDecay = true,
            Priority = EnumsModule.Stun.Medium + 1
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Second = {
        Damage = 12,
        Stun = {
            Time = 0.85,
            StunDecay = true,
            Priority = EnumsModule.Stun.Medium + 1
        },
        Block = {
            PerfectBlockable = false
        }
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 14939252405,
            Volume = 1
        }
    }
};
v2["Burst Barrage"] = {
    Active = true,
    Damage = 6.25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium + 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v3 },
    HitSounds = { v5 }
};
v2["Spectral Play"] = {
    Active = true,
    Damage = 20,
    Stun = 2,
    MaxDistance = 50,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 15,
        Manual = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0,
        RemoveMeter = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 14939267149,
            Volume = 1
        }
    },
    Block = {
        PerfectBlockable = false
    }
};
v2["Illuminated Sigils"] = {
    Active = true,
    Damage = 10,
    Stun = 0.5,
    Distance = 2.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        Manual = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 5,
        Offset = CFrame.identity
    },
    Block = {
        PerfectBlockable = false
    },
    Meter = {
        MeterGain = 0
    }
};
v2["Unseen Edge"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        Manual = true
    },
    Meter = {
        MeterGain = 0
    },
    Light = {
        Damage = 2.5,
        Stun = 0.5,
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 14939306859,
                Volume = 1
            }
        }
    },
    Heavy = {
        Damage = 25,
        Stun = 0.5,
        Block = {
            Unblockable = true
        },
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Velocity = Vector3.new(0, 15, 0),
            Time = 0.25
        },
        HitRemotes = { v4 },
        HitSounds = {
            Hit = {
                SoundId = 14939307204,
                Volume = 1
            }
        }
    }
};
v2.Enchain = {
    Active = true,
    Damage = 45,
    Actionable = {
        Active = true,
        Summoned = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25,
        MeterGain = 0
    },
    Stun = {
        Time = 2,
        Priority = EnumsModule.Stun.Heavy
    },
    Block = {
        Unblockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 15, 30),
        Debug = false,
        Offset = CFrame.identity
    },
    HitRemotes = { v4 },
    HitSounds = {
        Hit = {
            SoundId = 14939219391,
            Volume = 1
        }
    }
};
v2.Grab = {
    Active = true,
    Distance = 5,
    MaxDistance = 50,
    Damage = 20,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 15,
        MeterGain = 0
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Stun = {
        Time = 2,
        Priority = EnumsModule.Stun.Medium + 1
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    HitRemotes = { v3 },
    HitSounds = {
        Hit = {
            SoundId = 14939591603,
            Volume = 1
        }
    }
};
v2["Phantom Pierce"] = {
    Active = true,
    Cooldown = 8,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium + 1
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 12),
        Offset = CFrame.new(0, 0, -6)
    },
    HitRemotes = { v3 },
    HitSounds = { v5 }
};
v2["Phantom Prison"] = {
    Active = true,
    Damage = 8,
    Tick = 0.5,
    Duration = 20,
    DrainAmount = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        Manual = true
    },
    Meter = {
        RequiredAmount = 50,
        RemoveMeter = false,
        MeterGain = 0
    },
    Block = {
        PerfectBlockable = false,
        BypassCounter = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 25
    },
    HitRemotes = { v3 },
    HitSounds = { v5 }
};

local function CreateQuote(p16, p17) -- Line: 745
    return {
        SoundVolume = 2,
        YieldSound = true,
        Visible = true,
        SoundId = `rbxassetid://{p16}`,
        FullQuote = {
            {
                Quote = p17
            }
        }
    };
end;

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            StandOff = {
                Visible = true,
                Priority = 1
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
            Summon = {
                DefaultKeybind = "Q",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Shadow Burst"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Unlocked = true,
                Description = "Emit multiple shadow orbs around you before commanding them to burst into an explosion."
            },
            ["Critical Strike"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Deliver a strong right hand strike, blowing victims away."
            },
            ["Shadow Wheel"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Unlocked = true,
                Description = "Command a wheel of seeking shadow blades to home onto a victim, exterminating them."
            },
            ["Cross Blow"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform two chops through the shadows in a quick succession."
            },
            ["Burst Barrage"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Unlocked = true,
                Description = "Perform four consecutive strikes"
            },
            ["Spectral Play"] = {
                DefaultKeybind = "T+",
                State = "StandOn",
                LevelRequirement = 50,
                Description = "Home onto a victim as you warp through the shadows, striking them with a sudden teleport attack upon releasing the key."
            },
            ["Illuminated Sigils"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                LevelRequirement = 100,
                Description = "Illuminate 2 bursts of seeking shadow explosions into the world as u discharge them at your victim."
            },
            ["Unseen Edge"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                LevelRequirement = 125,
                Description = "Entering a counter state, gain the edge on your opponents as you dissect them through the shadows with a series of blows."
            },
            Grab = {
                DefaultKeybind = "X",
                Description = "Expand forwards a dark tendril of shadows, pulling any victim that comes in contact with it to yourself.",
                LevelRequirement = 50
            },
            Enchain = {
                DefaultKeybind = "V",
                State = "StandOn",
                LevelRequirement = 75,
                Description = "Raise your stands hand up as you rain shadows down with an enchaining ground slam."
            },
            ["Phantom Pierce"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                LevelRequirement = 25,
                Description = "Pierce those infront"
            },
            ["Phantom Prison"] = {
                DefaultKeybind = "Z",
                State = "StandOff",
                LevelRequirement = 100,
                Description = "Create a zone where Xeno will strike a random target frequently"
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14874406116,
            ["LMB-2"] = 14874408628,
            ["LMB-3"] = 14874410243,
            ["LMB-4"] = 14874411954,
            Grab = 14874763597,
            Pull = 14874767713,
            ["Shadow Burst"] = 14876267463,
            ["Sigil Throw"] = 14876314392,
            ["Shadow Wheel"] = 14876726384,
            ["Phantom Pierce"] = 11371980872,
            ["Critical Strike"] = 14876369649,
            ["Cross Blow"] = 14876398564,
            Enchain = 14876719885,
            ["Burst Barrage"] = 6972374480,
            ["Spectral Startup"] = 14876441527,
            ["Spectral Dash"] = 14882625986,
            ["Counter Startup"] = 14876880843,
            ["Counter Loop"] = 14876884956,
            Counter = 14876887202,
            ["Counter Slam"] = 14876889342,
            PoseTransition = 16688341308,
            PoseIdle = 16688343977
        },
        Movement = {
            Run = 16688183740,
            Walk = 16688188010,
            SummonedRun = 16688183740,
            SummonedWalk = 16688188010
        },
        Idle = {
            SummonedIdle = 16688346435,
            Idle = 16688346435
        }
    },
    Stats = v2,
    Sounds = {
        ["Grab-SFX"] = {
            SoundId = 14939591733,
            Volume = 1
        },
        ["Grab-Voiceline"] = {
            SoundId = 14939591487,
            Volume = 1
        },
        ["Grab-Hit-Voiceline"] = {
            SoundId = 14939591883,
            Volume = 1
        },
        ["ShadowWheel-SFX"] = {
            SoundId = 14939558919,
            Volume = 1
        },
        ["ShadowWheel-Voiceline"] = {
            SoundId = 14939558757,
            Volume = 1
        },
        ["ShadowWheel-Hit"] = {
            SoundId = 14939558581,
            Volume = 1
        },
        ["Sigils-SFX"] = {
            SoundId = 14939530471,
            Volume = 1
        },
        ["Sigils-Voiceline"] = {
            SoundId = 14939530107,
            Volume = 1
        },
        ["Sigils-Shoot-1"] = {
            SoundId = 14939529987,
            Volume = 1
        },
        ["Sigils-Shoot-2"] = {
            SoundId = 14939530239,
            Volume = 1
        },
        ["Sigils-Hit"] = {
            SoundId = 14939530662,
            Volume = 1
        },
        ["ShadowBurst-SFX"] = {
            SoundId = 14939503555,
            Volume = 1
        },
        ["ShadowBurst-Voiceline"] = {
            SoundId = 14939503371,
            Volume = 1
        },
        ["Enchain-SFX"] = {
            SoundId = 14939359536,
            Volume = 1
        },
        ["Enchain-Voiceline"] = {
            SoundId = 14939359788,
            Volume = 1
        },
        ["UnseenEdge-SFX"] = {
            SoundId = 14939307372,
            Volume = 1
        },
        ["UnseenEdge-Activate-SFX"] = {
            SoundId = 14939307027,
            Volume = 1
        },
        ["UnseenEdge-Activate-Voiceline"] = {
            SoundId = 14939307614,
            Volume = 1
        },
        ["SpectralPlay-Startup-SFX"] = {
            SoundId = 14939266633,
            Volume = 1
        },
        ["SpectralPlay-Startup-Voiceline"] = {
            SoundId = 14939266986,
            Volume = 1
        },
        ["SpectralPlay-End-SFX"] = {
            SoundId = 14939267382,
            Volume = 1
        },
        ["SpectralPlay-End-Voiceline"] = {
            SoundId = 14939266830,
            Volume = 1
        },
        ["CrossBlow-SFX"] = {
            SoundId = 14939252205,
            Volume = 1
        },
        ["CrossBlow-Voiceline"] = {
            SoundId = 14939252590,
            Volume = 1
        },
        ["CriticalStrike-SFX"] = {
            SoundId = 14939232001,
            Volume = 1
        },
        ["CriticalStrike-Voiceline"] = {
            SoundId = 14939232117,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 14939206725,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14939205888,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14939206848,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14939206031,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 14939206602,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 14939206181,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 14939206327,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 14939206490,
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = 14939173694,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 14939173396,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 14939173587,
            Volume = 1
        },
        PoseMusic = {
            Looped = true,
            SoundId = 10456081808,
            Volume = 1.5
        },
        ["PhantomPierce-SFX"] = {
            SoundId = 14939307372,
            Volume = 1
        },
        ["PhantomPrison-SFX"] = {
            SoundId = 14939503555,
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
            Universal = {
                CreateQuote(14939626046, "I gotta make sure that this doesn\'t affect in the future."),
                CreateQuote(14939626636, "You will never get my feelings..."),
                CreateQuote(14939626396, "That will do for now."),
                CreateQuote(14939626245, "Good grief, I have no talent for rough stuff... But it can\'t be helped."),
                CreateQuote(14939626521, "Win. Otherwise everything is gonna be for naught.")
            }
        }
    },
    MasteryData = {
        MaxMasteryRank = 2,

        PointCap = function(p18) -- Line: 1135, Name: PointCap
            return 100;
        end
    }
};
  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CurrentCamera = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local StoreHandler = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 21
    -- upvalues: u3 (ref), Knit (copy), u1 (ref), PathShortcuts (copy), u2 (ref)
    u3 = Knit.GetService("AchievementService");
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
    u2 = u1.GetMiddleware("CombatService");
end);
local _ = game.GameId == 1782832995;
local v4 = ReplicatedStorage["Client Assets"];
local v5 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Scythe",
            AutoSerialize = true,
            LookAt = "Attacker",
            PathFolder = v4
        }
    }
};
({
    Name = "Output"
}).Arguments = {
    "FX",
    "HitEffect V3",
    {
        Attacker = "__Attacker",
        Target = "__Target",
        AutoSerialize = true,
        LookAt = "Attacker",
        Particle = v4.Reaper.HitEffects.Light
    }
};
local v6 = {
    SoundId = 13109386977,
    Volume = 1
};
local v7 = {
    SoundId = 13109387026,
    Volume = 1
};

local function GetFacing(p8, p9) -- Line: 82
    -- upvalues: CurrentCamera (copy)
    local v10 = nil;
    local v11 = nil;
    local v12 = p9 or 10;
    local HumanoidRootPart = p8:FindFirstChild("HumanoidRootPart");
    local Humanoid = p8:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p8 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v13 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v13 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v12 >= Magnitude then
                            if v10 then
                                if Magnitude < v11 then
                                    v10 = child;
                                end;
                            else
                                v10 = child;
                                v11 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v10;
    end;
end;

local v20 = {
    Pose = {
        From = "Combat.Pose"
    },
    Breaker = {
        From = "Combat.Breaker"
    },
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        MaxCombo = 4,
        ComboTick = 1.5,
        ["LMB-1"] = TableUtil.Reconcile({
            Speed = 1,
            SoulScaling = 0.03,
            MasteryRank = 2,
            Stun = 0.75,
            Sequence = { { 0, "Start" }, { 13, 23, "Attack" }, { 25, "End" } },
            HitRemotes = { v5 },
            HitSounds = {
                Hit = v6
            }
        }, BaseStatsModule.Stand_Rush_Attack),
        ["LMB-4"] = TableUtil.Reconcile({
            SoulScaling = 0.08,
            MasteryRank = 2,
            Stun = 0.75,
            Sequence = { { 0, "Start" }, { 12, 30, "Attack" }, { 32, "End" } },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = 8,
                Offset = CFrame.identity
            },
            HitRemotes = { v5 },
            HitSounds = {
                Hit = v7
            }
        }, BaseStatsModule.Stand_Rush_Attack_Finisher),
        ["StandOff-LMB-1"] = {
            SoulScaling = 0.03,
            MasteryRank = 2
        },
        ["StandOff-LMB-4"] = {
            SoulScaling = 0.08,
            MasteryRank = 2
        },
        Callbacks = {
            PreAnim = function(p14) -- Line: 197, Name: PreAnim
                -- upvalues: CollectionService (copy)
                local v15 = CollectionService:HasTag(p14.Character, "Summoned");
                local SwingTrail = p14.Character:FindFirstChild("Stand"):FindFirstChild("SwingTrail", true);

                if not (v15 and SwingTrail) then
                    return;
                end;

                SwingTrail.Enabled = true;
            end,

            PostAnim = function(p16) -- Line: 206, Name: PostAnim
                local SwingTrail = p16.Character:FindFirstChild("Stand"):FindFirstChild("SwingTrail", true);

                if not SwingTrail then
                    return;
                end;

                SwingTrail.Enabled = false;
            end,

            StateChecker = function(p17, p18) -- Line: 214, Name: StateChecker
                -- upvalues: CollectionService (copy), TableUtil (copy)
                if not CollectionService:HasTag(p17.Character, "Summoned") then
                    local v19 = TableUtil.Copy(p17.Stats);
                    v19.CustomPrefix = "StandOff-LMB";

                    return v19;
                end;
            end
        }
    }
};
v20["Rush Attack"] = TableUtil.Reconcile(v20["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v20.Block = {
    From = "Combat.Block"
};
v20.Quickstep = {
    From = "Combat.Quickstep"
};
v20.Summon = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v20["Soul Transport"] = {
    Active = true,
    From = "Combat.Teleport",
    RawPath = false,
    Path = "Teleport",
    Actionable = {
        Active = true
    },
    PathFolder = v4
};
v20["Scythe Barrage"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Frequency = 8,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    HitRemotes = { v5 },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    },
    Light = {
        Damage = 3,
        SoulScaling = 0.01,
        MasteryRank = 4,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 8,
            Time = 0.15
        },
        Stun = {
            Time = 0.65
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    Heavy = {
        Damage = 15,
        SoulScaling = 0.1,
        MasteryRank = 4,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.15
        },
        Ragdoll = {
            Time = 0.85
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v7
        }
    }
};
v20["Quick Draw"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = 8,
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    ["Hit-1"] = {
        Damage = 10,
        Stun = 1,
        SoulScaling = 0.06,
        MasteryRank = 5,
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    ["Hit-2"] = {
        Damage = 10,
        Stun = 1,
        SoulScaling = 0.06,
        MasteryRank = 5,
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    ["Hit-3"] = {
        Damage = 10,
        Stun = 1.5,
        SoulScaling = 0.06,
        MasteryRank = 5,
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v7
        }
    }
};
v20["Radial Swings"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Properties = {
        Armor = true
    },
    Cooldown = 10,
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 12,
        Offset = CFrame.identity
    },
    ["Hit-1"] = {
        Damage = 10,
        Stun = 0.5,
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    ["Hit-2"] = {
        Damage = 10,
        Stun = 0.5,
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    ["Hit-3"] = {
        Damage = 20,
        Stun = 0.5,
        Block = {
            Unblockable = true
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v7
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 45,
            Time = 0.2,
            Velocity = Vector3.new(0, 20, 0)
        }
    }
};
v20["Scythe Rapture"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Light = {
        Damage = 15,
        Stun = 0.65,
        SoulScaling = 0.1,
        MasteryRank = 7,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Offset = CFrame.identity
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.15
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    Heavy = {
        Damage = 15,
        SoulScaling = 0.2,
        MasteryRank = 7,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 0.85
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 25, 0)
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v7
        }
    }
};
v20["Soul Reap"] = {
    Active = true,
    Damage = 20,
    Stun = 1.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v6
    }
};
v20["Death Slash"] = {
    Active = true,
    Damage = 20,
    Stun = 0.5,
    HealAmount = 0.05,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 45,
        Time = 0.2,
        Velocity = Vector3.new(0, 20, 0)
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Offset = CFrame.new(0, 0, -7.5)
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v7
    }
};
v20["Cloaked Entrance"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Throw = {
        Distance = 8,
        Damage = 15,
        Collision = true,
        ClientCollision = false,
        HitAnimations = "Default",
        Stun = {
            Time = 0.85
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    Teleport = {
        Damage = 15,
        HitAnimations = "Default",
        Stun = {
            Time = 0.85
        },
        Block = {
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 12,
            Offset = CFrame.identity
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    }
};
v20["Scythe Flourish"] = {
    Active = true,
    Frequency = 7,
    ReturnFrame = 82,
    Damage = 3.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        Size = 10
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Block = {
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = -20,
        Time = 0.15
    },
    Stun = {
        Time = 0.85
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v6
    }
};
v20["Soul Harvester"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Damage = 40,
    Stun = 0.5,
    Cooldown = 30,
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 4
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v6
    },
    Uppercut = {
        Damage = 15
    },
    ["Slash-1"] = {
        Damage = 15
    },
    ["Slash-2"] = {
        Damage = 15
    },
    ["Slash-3"] = {
        Damage = 15
    },
    ["Slash-4"] = {
        Damage = 15
    },
    Stab = {
        Damage = 15
    },
    Throw = {
        Damage = 15
    },

    Invoke = function(p21) -- Line: 778, Name: Invoke
        -- upvalues: CollectionService (copy), Knit (copy), GetFacing (copy)
        local Character = p21.Character;
        CollectionService:HasTag(Character, "Summoned");
        Knit.GetController("MoveInputController");
        local v22 = Knit.GetService("MoveInputService");
        local v23 = GetFacing(Character, 50);

        if not v23 then
            return;
        end;

        v22:FireInput(p21.RawInput, v23);
    end
};
v20["Death Sentence"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Damage = 15,
    Stun = 0.5,
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 75
    },
    Startup = {
        CheckPVPSafe = true,
        Meter = false,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12.5, 10, 25),
            IgnoreNPCS = true,
            Offset = CFrame.new(0, 0, -12.5)
        },
        Block = {
            Blockable = false,
            BlockCancel = true,
            PerfectBlockCancel = false
        }
    },
    HitRemotes = { v5 },
    Kick = {
        Damage = 23,
        MinHealth = 1
    },
    Slash = {
        Damage = 2,
        MinHealth = 1
    },
    Grab = {
        Damage = 7.5,
        MinHealth = 1
    },
    Throw = {
        Damage = 22.5
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0.5,
            Color = Color3.fromRGB(0, 255, 127)
        },
        End = {
            Transparency = 1
        }
    }
};
v20["Soul Trespass"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Damage = 5,
    Frequency = 6,
    CheckPVPSafe = true,
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Offset = CFrame.identity
    },
    Block = {
        Unblockable = true
    },
    HitRemotes = { v5 },
    Kick = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = {
                SoundId = 10626698543,
                Volume = 3
            }
        }
    },
    Slash1 = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Stun = {
            Time = 0.5
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    },
    Slash2 = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15
        },
        HitRemotes = { v5 },
        HitSounds = {
            Hit = v6
        }
    }
};
v20["Rift Slice"] = {
    Active = true,
    Cooldown = 15,
    Distance = 15,
    Damage = 30,
    Piercing = true,
    SoulScaling = 0.3,
    MasteryRank = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Block = {
        PerfectBlockable = false
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1
    },
    Stun = {
        Time = 0.85
    },
    HitRemotes = { v5 },
    HitSounds = {
        Hit = v6
    }
};
v20["Scythe Slam"] = {
    Active = true,
    Damage = 50,
    Cooldown = 10,
    SoulScaling = 0.4,
    MasteryRank = 9,
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 30
    },
    HitRemotes = { v5 },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.new(0, 0, -6)
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.15,
        Velocity = Vector3.new(0, 35, 0)
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true
    }
};

local function UpdateSoulStats(p24) -- Line: 1077
    -- upvalues: Knit (copy), StoreHandler (copy)
    local Character = p24.Character;
    local Player = p24.Player;
    local v25 = Knit.GetService("StatService");
    local v26 = v25.GetStatsInfo(Character);

    if not v26 then
        return true;
    end;

    if Player.Data.Ability.Value ~= 666 then
        v26:SetExternalStats("ReaperStats", nil);

        return true;
    end;

    local v27 = Player:GetAttribute("ReaperSouls") * 1;
    local u28 = StoreHandler.GetStore("ReaperStats");

    if not u28[Player] then
        u28[Player] = {
            Attack = 0,
            Health = 0,
            Defense = 0,
            Special = 0
        };
        Player.Destroying:Connect(function() -- Line: 1103
            -- upvalues: u28 (copy), Player (copy)
            u28[Player] = nil;
        end);
    end;

    local v29 = u28[Player];
    local v30 = 0;

    for _, v in v29 do
        v30 = v30 + v;
    end;

    if v30 / 1 > Player:GetAttribute("ReaperSouls") then
        for i, _ in v29 do
            v29[i] = 0;
        end;

        v30 = 0;
    end;

    if v30 < v27 then
        local v31 = Random.new();
        local v32 = math.floor((v27 - v30) / 1);
        local v33 = { v31:NextInteger(0, v32), v31:NextInteger(0, v32), v31:NextInteger(0, v32) };
        table.sort(v33);
        local v34 = { "Attack", "Health", "Defense", "Special" };
        v31:Shuffle(v34);

        for i, v in {
            [`{v34[1]}`] = v33[1],
            [`{v34[2]}`] = v33[2] - v33[1],
            [`{v34[3]}`] = v33[3] - v33[2],
            [`{v34[4]}`] = v32 - v33[3]
        } do
            v29[i] = v29[i] + v * 1;
        end;
    end;

    v26:SetExternalStats("ReaperStats", (v25.CreateStatsObject(v29)));

    return true;
end;

return {
    Stats = v20,
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
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
            ["Scythe Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Rapidly spin and slice at anyone around you."
            },
            ["Scythe Rapture"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "A whirling spin followed with a finishing slash."
            },
            ["Scythe Flourish"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                Description = "Throw your scythe outwards to pull in any victims caught in its trajectory.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Scythe Slam"] = {
                DefaultKeybind = "Y",
                State = "StandOn",
                Description = "Slam the ground with your scythe.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Death Sentence"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Teleport and unleash a devastating series of attacks on a target.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Soul Transport"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "Teleport in the direction you are moving.",
                LevelRequirement = 30,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Death Slash"] = {
                DefaultKeybind = "B",
                State = "StandOn",
                Description = "A counter which heals for every target caught in its radius.",
                LevelRequirement = 70,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Soul Reap"] = {
                DefaultKeybind = "B",
                State = "StandOff",
                Description = "A counter which teleports you behind the target to slash.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Quick Draw"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Quickly draw and summon your scythe to perform a vertical spinning slash.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Radial Swings"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Perform a series of three spinning slashes.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Cloaked Entrance"] = {
                DefaultKeybind = "T",
                State = "StandOff",
                Description = "Throw your scythe forward. Upon connection with someone, teleport to them to perform a follow-up slice. Recasting forces the teleport.",
                LevelRequirement = 80,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Rift Slice"] = {
                DefaultKeybind = "Y",
                State = "StandOff",
                Description = "Slash and unleash a wide wave of energy forward.",
                LevelRequirement = 60,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Soul Trespass"] = {
                DefaultKeybind = "X",
                State = "Universal",
                Description = "Dash forward. Upon connection with someone, slice consecutively at your target.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            }
        }
    },
    Sounds = {
        DeathSentence = {
            SoundId = 14036196641,
            Volume = 1
        },
        SoulGain = {
            SoundId = 13957642209,
            Volume = 1
        },
        ["SoulTrespass-Startup"] = {
            SoundId = 13957642100,
            Volume = 1
        },
        SoulTrespass = {
            SoundId = 13957641896,
            Volume = 1
        },
        RiftSlice = {
            SoundId = 13957641769,
            Volume = 1
        },
        Teleport = {
            SoundId = 13957641641,
            Volume = 1
        },
        Quickdraw = {
            SoundId = 13957641429,
            Volume = 1
        },
        RadialSwings = {
            SoundId = 13957641288,
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = 13957641177,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 13957641368,
            Volume = 1
        },
        ["DeathSlash-Startup"] = {
            SoundId = 13957642292,
            Volume = 1
        },
        DeathSlash = {
            SoundId = 13957641548,
            Volume = 1
        },
        ["SoulReap-Startup"] = {
            SoundId = 13957640960,
            Volume = 1
        },
        SoulReap = {
            SoundId = 13957641066,
            Volume = 1
        },
        ScytheSlam = {
            SoundId = 13108888108,
            Volume = 1
        },
        ["ScytheSlam-Startup"] = {
            SoundId = 13108886939,
            Volume = 1
        },
        Barrage = {
            SoundId = 13109386879,
            Volume = 1
        },
        Flourish = {
            SoundId = 13115781969,
            Volume = 1
        },
        ["ScytheRapture-1"] = {
            SoundId = 13109688688,
            Volume = 1
        },
        ["ScytheRapture-2"] = {
            SoundId = 13109688688,
            Volume = 1,
            PlaybackSpeed = 0.85
        },
        ["SwingLMB 1-3"] = {
            SoundId = 11499913187,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13109688688,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13109688806,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13109688905,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13109688688,
            Volume = 1,
            PlaybackSpeed = 0.85
        },
        PoseMusic = {
            Looped = true,
            SoundId = 13754052800,
            Volume = 3
        }
    },
    Animations = {
        Action = {
            ["Soul Trespass Dash"] = 12199800182,
            ["Soul Trespass Follow Up"] = 12791539382,
            ["Soul Trespass Victim"] = 12791538402,
            ["Scythe Rapture"] = 12199795291,
            ["Scythe Slam"] = 12199793742,
            ["Scythe Flourish"] = 12199792135,
            ["Scythe Barrage"] = 12199788497,
            ["Quick Draw"] = 13715631375,
            ["Radial Swings"] = 13726627103,
            ["Soul Reap Startup"] = 13726793083,
            ["Soul Reap Loop"] = 13726796743,
            ["Soul Reap"] = 13726803983,
            ["Death Slash Startup"] = 13727060183,
            ["Death Slash Loop"] = 13727062555,
            ["Death Slash"] = 13727063871,
            ["Soul Harvester Startup"] = 13753344724,
            ["Soul Harvester"] = 13753345490,
            ["Soul Harvester Victim"] = 13753346776,
            ["Soul Harvester Camera"] = 13753347720,
            ["Death Sentence Startup"] = 13753344724,
            ["Death Sentence"] = 14035075485,
            ["Death Sentence Victim"] = 14035076685,
            ["Death Sentence Camera"] = 14035073944,
            ["Cloaked Entrance Throw"] = 14075959351,
            ["Cloaked Entrance"] = 13762950177,
            ["Rift Slice"] = 13763261705,
            ["LMB-1"] = 12199778823,
            ["LMB-2"] = 12199780680,
            ["LMB-3"] = 12199782347,
            ["LMB-4"] = 12199784224,
            PoseTransition = 14044338525,
            PoseIdle = 14044336647,
            Summon = 12198273866,
            Desummon = 12179394433,
            ["Stand-Block"] = 12499353550,
            ["Stand-BlockHit1"] = 12499359012,
            ["Stand-BlockHit2"] = 12499360090,
            ["Stand-BlockHit3"] = 12499361466,
            ["Stand-BlockBreak"] = 12499357071
        },
        Movement = {
            Walk = 13811918039,
            Run = 13811919323,
            SummonedWalk = 12179434794,
            SummonedRun = 12179437325
        },
        Idle = {
            SummonedIdle = 12199310856,
            Idle = 12179421963
        }
    },
    Metadata = {
        AbilityOutbound = function(p35) -- Line: 1588, Name: AbilityOutbound
            -- upvalues: u2 (ref), u3 (ref), Knit (copy), UpdateSoulStats (copy)
            local State = p35.State;
            local Attacker = p35.Attacker;
            local Target = p35.Target;

            if not (State.Killed or State.IsDead) then
                return;
            end;

            if typeof(Attacker) ~= "Instance" or typeof(Target) ~= "Instance" then
                return;
            end;

            if Target:GetAttribute("SOUL_COLLECTED") then
                return;
            end;

            local u36;

            if Attacker:GetAttribute("NPC") then
                u36 = Attacker;
            else
                u36 = p35.AttackerPlayer;
            end;

            if not u36 then
                return;
            end;

            local v37 = 250;
            local v38 = {
                [1] = 25,
                [3] = 25,
                [6] = 25,
                [10] = 25
            };
            local v39;

            if p35.AttackerAbility then
                v39 = p35.AttackerAbility:GetAttribute("MasteryRank");
            else
                v39 = nil;
            end;

            if v39 then
                for i, v in v38 do
                    if v39 >= i then
                        v37 = v37 + v;
                    end;
                end;
            end;

            if u36.Data.Ability.Value ~= 666 or v37 <= u36:GetAttribute("ReaperSouls") then
                return;
            end;

            local v40;

            if Target:GetAttribute("NPC") then
                v40 = Target;
            else
                v40 = p35.TargetPlayer;
            end;

            if v40 then
                u2.PlaySound(Attacker, "SoulGain");
                Target:SetAttribute("SOUL_COLLECTED", true);
                u36:SetAttribute("ReaperSouls", u36:GetAttribute("ReaperSouls") + 1);
                u3.IncrementAchievement(u36, "ReaperSoulsCollected");
                pcall(function() -- Line: 1626
                    -- upvalues: Attacker (copy), Knit (ref), u36 (copy)
                    local HumanoidRootPart = Attacker.HumanoidRootPart;
                    Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                        Path = "Soul_Collect",
                        PathFolder = Knit.ClientAssets,
                        Player = u36,
                        AttachTo = {
                            Part = HumanoidRootPart
                        }
                    });
                end);
                task.spawn(UpdateSoulStats, {
                    Player = u36,
                    Character = Attacker
                });

                return true;
            end;
        end,

        AbilityInbound = function(p41) -- Line: 1645, Name: AbilityInbound
            local Target = p41.Target;

            if not Target then
                return;
            end;

            if not (Target:GetAttribute("NPC") or Target:GetAttribute("Dummy")) then
                return;
            end;

            local Attacker = p41.Attacker;

            if not Attacker:GetAttribute("NPC") then
                Attacker = p41.AttackerPlayer;
            end;

            if not Attacker then
                return;
            end;

            local v42 = Attacker:GetAttribute("ReaperSouls") or 0;
            local v43 = not p41.AttackerAbility and 0 or p41.AttackerAbility:GetAttribute("MasteryRank");
            local Stats = p41.Stats;

            if Stats.MasteryRank and v43 < Stats.MasteryRank then
                return;
            end;

            if not Stats.SoulScaling then
                return;
            end;

            Stats.Damage = Stats.Damage + Stats.SoulScaling * v42;
        end,

        Hooks = {
            StatSetup = {
                CombatHook = "Moves",
                HookType = "PreMove",
                HookName = "ReaperStatHook",
                Priority = 1,
                HookFunction = UpdateSoulStats
            },
            OnSpawn = {
                CombatHook = "Setup",
                HookType = "OnSpawn",
                HookName = "ReaperOnSpawn",
                Priority = 1,

                HookFunction = function(p44) -- Line: 1675, Name: HookFunction
                    -- upvalues: Knit (copy)
                    local Player = p44.Player;
                    local Character = p44.Character;
                    local v45 = Knit.GetService("StatService").GetStatsInfo(Character);

                    if v45 and Player.Data.Ability.Value ~= 666 then
                        v45:SetExternalStats("ReaperStats", nil);
                    end;

                    return true;
                end
            }
        },

        CustomAddon = function(p46) -- Line: 1690, Name: CustomAddon
            local Player = p46.Player;
            local _ = p46.Character;

            if Player:GetAttribute("ReaperSouls") then
                return;
            end;

            Player:SetAttribute("ReaperSouls", 0);
        end,

        PostRig = function(p47) -- Line: 1697, Name: PostRig
            -- upvalues: u2 (ref), TableUtil (copy), ParticleHandler (copy)
            local Player = p47.Player;
            local Character = p47.Character;
            local SkinName = p47.SkinName;
            local v48 = Player:IsA("Player") and Player.Data.Skin.Value;
            local v49 = Player:IsA("Player") and Player.Data.Skin:GetAttribute("UnusualHueId");
            local u50 = ({
                ["6"] = {
                    SpecialHue = 72,
                    MeterColor = Color3.fromRGB(108, 59, 170),
                    OverlayColors = {
                        Blade = Color3.fromRGB(212, 0, 0),
                        Blade2 = Color3.fromRGB(255, 0, 0),
                        Handle = Color3.fromRGB(108, 1, 0),
                        Handle2 = Color3.fromRGB(138, 0, 0),
                        Yellow = Color3.fromRGB(255, 0, 0)
                    },
                    DamageSound = {
                        SoundId = 4735718618,
                        Volume = 6
                    },
                    BlockSound = {
                        SoundId = 74773462225365,
                        Volume = 1.5
                    }
                }
            })[v48];

            if u50 and (v49 == u50.SpecialHue and u50.OverlayColors) then
                local Stand = Character:FindFirstChild("Stand");

                if not Stand then
                    return;
                end;

                for i, v in u50.OverlayColors do
                    local v51 = Stand:FindFirstChild(i);

                    if v51 then
                        local SurfaceAppearance = v51:FindFirstChild("SurfaceAppearance");

                        if SurfaceAppearance then
                            SurfaceAppearance.Color = v;
                        end;
                    end;
                end;
            end;

            if u50 and (u50.DamageSound and u50.BlockSound) then
                local u52 = `{Player.Name}-JevilSFX`;
                u2.AttackHook:Hook("Inbound", u52, 2, function(p53) -- Line: 1738
                    -- upvalues: Character (copy), TableUtil (ref), u50 (copy)
                    local Stats = p53.Stats;

                    if p53.Target.Name == Character.Name then
                        if p53.State.Blocked then
                            Stats.HitSounds = Stats.HitSounds and TableUtil.Extend(Stats.HitSounds, {
                                Hit = u50.BlockSound
                            }) or {
                                Hit = u50.BlockSound
                            };
                        elseif Stats.Damage then
                            Stats.HitSounds = Stats.HitSounds and TableUtil.Extend(Stats.HitSounds, {
                                Hit = u50.DamageSound
                            }) or {
                                Hit = u50.DamageSound
                            };
                        end;
                    end;

                    return true;
                end);
                p47.Trove:Add(function() -- Line: 1749
                    -- upvalues: u2 (ref), u52 (copy)
                    u2.AttackHook:Unhook("Inbound", u52);
                end);
            end;

            local v54 = u50 and u50.MeterColor or Color3.fromRGB(0, 255, 127);
            Character:SetAttribute("MeterColor", (ParticleHandler.TryHSVShift(v54, ParticleHandler.GetUnusualHSVData({
                Character = Character
            }))));
            local SwingTrail = Character:FindFirstChild("SwingTrail", true);

            if SwingTrail then
                local v55 = ParticleHandler.GetSkinInfo(SkinName);
                local v56 = type(v55) == "table" and ((v55.SwingTrail or {}).HSVShift or (v55.Metadata or {}).HSVShift);

                if v56 then
                    SwingTrail.Color = ParticleHandler.HSVShift(SwingTrail.Color, v56);
                end;
            end;
        end
    },
    MasteryData = {
        MaxMasteryRank = 10,

        PointCap = function(p57) -- Line: 1771, Name: PointCap
            return 100;
        end
    }
};
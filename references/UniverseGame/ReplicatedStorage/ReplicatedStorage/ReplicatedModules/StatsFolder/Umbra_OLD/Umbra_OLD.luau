  

 

game:GetService("PhysicsService");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = game.ReplicatedStorage.Remotes.InputFunc;
local Output = game.ReplicatedStorage.Remotes.Output;
local _ = game.ReplicatedStorage["Client Assets"];
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("MoveInputService");
end);

local function FindNearest(p2) -- Line: 25
    -- upvalues: CollectionService (copy)
    local Distance = p2.Distance;
    local Origin = p2.Origin;
    local v3 = p2.Ignore or {};
    local v4 = {};

    for _, v in ipairs(p2.Objects or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if not (CollectionService:HasTag(v, "Intangible") or table.find(v3, v)) then
            local v5 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v5 and (v5.Position - Origin.Position).Magnitude <= Distance then
                table.insert(v4, v);
            end;
        end;
    end;

    table.sort(v4, function(p6, p7) -- Line: 43
        -- upvalues: Origin (copy)
        local v8 = p6:IsA("Model") and p6.PrimaryPart or p6:FindFirstChild("HumanoidRootPart");
        local v9 = p7:IsA("Model") and p7.PrimaryPart or p7:FindFirstChild("HumanoidRootPart");

        return (v8.Position - Origin.Position).Magnitude < (v9.Position - Origin.Position).Magnitude;
    end);

    for _, v in ipairs(v4) do
        local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
    end;

    return p2.Multiple and v4 and v4 or v4[1];
end;

local v10 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            HueShift = -45,
            Particle = ClientAssets.Umbra["PS Hit OLD"]
        }
    }
};
local v17 = {
    Summon = {
        From = "Combat.Summon",
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 0, 1)), ColorSequenceKeypoint.new(1, Color3.new(1, 0.666667, 1)) })
    },
    Pose = {
        From = "Combat.Pose"
    },
    Grab = {
        From = "Combat.Grab",
        Actionable = {
            Active = true
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
    },
    Block = {
        From = "Combat.Block"
    },
    ["Rush Attack"] = {
        From = "Combat.Rush Attack",
        Actionable = {},
        Damage = 4,
        MaxCombo = 5,
        ComboTick = 8,
        Sequence = { { 0, "PlayAnim", nil, {} }, { 0, "PlaySound", "LMB-1-3" }, { 0, "PlayVoiceline" }, { 15, 20, "Attack" }, { 25, "End" } },
        Hitbox = {
            Type = "Region3",
            Size = Vector3.new(8, 8, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        Block = {
            PerfectBlockable = false
        },
        Stun = {
            Time = 0.75,
            Priority = EnumsModule.Stun.Medium
        },
        HitRemotes = { v10 },
        Texture1 = {
            frames = 15,
            fps = 60,
            rows = 3,
            columns = 5,
            front = "http://www.roblox.com/asset/?id=7943227207",
            back = "http://www.roblox.com/asset/?id=7945726042",
            size = Vector3.new(12, 12, 0),
            color = Color3.fromRGB(255, 144, 244),
            part = ReplicatedStorage["Client Assets"].Misc.slash
        },
        SlashData = {
            Color = Color3.new(1, 0, 1)
        },
        ["LMB-1"] = {
            Block = {
                PerfectBlockable = false
            }
        },
        ["LMB-4"] = {
            Damage = 4,
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.5,
                Priority = EnumsModule.Stun.Medium
            },
            Sequence = { { 0, "PlayAnim", nil, {} }, { 0, "PlaySound", nil, {
                        Properties = {
                            TimePosition = 0.5
                        }
                    } }, { 0, "PlayVoiceline" }, { 10, "Attack", {
                        Multiple = true
                    } }, { 15, "Attack", {
                        Multiple = true
                    } }, { 20, "Attack", {
                        Multiple = true
                    } }, { 25, "End" } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 12),
                Debug = false,
                Offset = CFrame.new(0, 0, -6)
            }
        },
        ["LMB-5"] = {
            Damage = 2.2,
            Cooldown = 1.5,
            Block = {
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 64,
                Time = 0.2
            },
            Ragdoll = {
                Time = 0.8
            },
            Sequence = { { 0, "PlayAnim", nil, {} }, { 0, "PlaySound" }, { 0, "PlayVoiceline" }, { 10, "Attack", {
                        Multiple = true
                    } }, { 15, "Attack", {
                        Multiple = true
                    } }, { 20, "Attack", {
                        Multiple = true
                    } }, { 25, "Attack", {
                        Multiple = true
                    } }, { 30, "Attack", {
                        Multiple = true
                    } }, { 35, "End" } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 10, 15),
                Debug = false,
                Offset = CFrame.new(0, 0, -7.5)
            },
            Tweens = {
                End = { 0.5, Enum.EasingStyle.Sine }
            },
            Props = {
                Start = {
                    Transparency = 0,
                    Color = Color3.new(1, 0, 1)
                },
                End = {
                    Transparency = 1
                }
            }
        },
        Callbacks = {
            StateChecker = function(p11, p12) -- Line: 262, Name: StateChecker
                -- upvalues: TableUtil (copy), CollectionService (copy)
                local _ = p11.Player;
                local _ = p11.Input;
                local v13 = TableUtil.Copy(p11.Stats, true);

                if CollectionService:HasTag(p11.Character, "Sovereign") then
                    v13.CustomPrefix = "Sovereign-LMB";
                end;

                return v13;
            end,

            PreAnim = function(p14, p15) -- Line: 271, Name: PreAnim
                -- upvalues: TableUtil (copy), Output (copy), TweenService (copy)
                local Player = p14.Player;
                local AttackStats = p15.AttackStats;
                local _ = p14.Input;
                local v16 = Player:IsA("Model") and Player and Player or Player.Character;
                local HumanoidRootPart = v16.HumanoidRootPart;

                if p15.MoveState.Count >= 4 then
                    if p15.MoveState.Count == 4 then
                        return;
                    end;

                    if p15.MoveState.Count == 5 then
                        AttackStats.Hitbox.Origin = HumanoidRootPart.CFrame;

                        if Player:IsA("Model") then
                            Output:FireAllClients("FX", "Umbra Clone", v16, 0.15, 0, 0, AttackStats.Tweens, AttackStats.Props);
                            TweenService:Create(HumanoidRootPart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
                                CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -15)
                            }):Play();

                            return;
                        end;

                        Output:FireAllClients("FX", "Dash Raycast", HumanoidRootPart, 15, { 0.1, Enum.EasingStyle.Sine });
                        Output:FireAllClients("FX", "Umbra Clone", v16, 0.15, 0, 0.3, AttackStats.Tweens, AttackStats.Props);
                    end;

                    return;
                end;

                local Texture1 = TableUtil.Copy(AttackStats, true).Texture1;

                if p15.MoveState.Count ~= 2 then
                    Texture1.preset = "RIGHT";
                end;

                Output:FireAllClients("FX", "Create FX", "Slash FX V2", v16, Texture1);
            end
        }
    }
};
v17["Rush Attack"]["Sovereign-LMB-4"] = v17["Rush Attack"]["LMB-4"];
v17["Rush Attack"]["Sovereign-LMB-5"] = v17["Rush Attack"]["LMB-5"];
v17.Slashes = {
    Active = true,
    Damage = 10,
    Cooldown = 8,
    Distance = 5,
    Tick = 0.2,
    Piercing = true,
    Collision = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        MeterGain = 0
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Texture1 = {
        frames = 15,
        fps = 60,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.fromRGB(255, 144, 244),
        part = ReplicatedStorage["Client Assets"].Misc.slash
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
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v10 }
};
v17.Erasure = {
    Active = true,
    Damage = 45,
    Distance = 10,
    Cooldown = 15,
    Piercing = true,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p18) -- Line: 356, Name: Check
            -- upvalues: CollectionService (copy)
            return CollectionService:HasTag(p18, "Sovereign");
        end
    },
    Stun = {
        Time = 3.65,
        Priority = EnumsModule.Stun.Heavy
    },
    Meter = {
        RequiredAmount = 25
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 8102914291,
            Volme = 3
        }
    },
    HitRemotes = { v10 }
};
v17["Last Rites"] = {
    Active = true,
    Damage = 30,
    Cooldown = 5,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Properties = {
        Armor = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 20),
        Debug = false,
        Offset = CFrame.new()
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 64,
        Time = 0.2
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v10 },
    UmbraData = {
        StartSize = Vector3.new(5, 1, 5),
        FinalSize = Vector3.new(40, 8, 40),
        Speed = 10,
        Time = 0.5,
        HitName = "UmbraData",
        Color = Color3.new(1, 0, 1),
        Angle = CFrame.new()
    }
};
v17["Finis Aeternam"] = {
    Active = true,
    Damage = 15,
    Cooldown = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true,

        Check = function(p19) -- Line: 437, Name: Check
            -- upvalues: CollectionService (copy)
            return CollectionService:HasTag(p19, "Sovereign");
        end
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 50
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(100, 100, 100),
        Debug = false,
        Offset = CFrame.new()
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v10 }
};
v17["Elegant Bladework"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = 10,
    Barrage = {
        Damage = 6,
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            PerfectBlockable = false,
            Blockable = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 8),
            Debug = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = {
            Hit = {
                SoundId = 7181838845,
                Volme = 3
            }
        },
        HitRemotes = { v10 }
    },
    ["AOE Slash"] = {
        Damage = 15,
        Stun = {
            Time = 0.5,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.2
        },
        Block = {
            BlockBreak = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 15, 15),
            Debug = false,
            Offset = CFrame.new()
        },
        HitSounds = {
            Hit = {
                SoundId = 7181838845,
                Volme = 3
            }
        },
        HitRemotes = { v10 }
    },
    HitAnimations = "Default",
    Texture1 = {
        frames = 15,
        fps = 60,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.fromRGB(255, 144, 244),
        part = ReplicatedStorage["Client Assets"].Misc.slash
    }
};
v17["Judgement Cut"] = {
    Active = true,
    Damage = 12.5,
    Speed = 200,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 1,
        RemoveMeter = false
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Stun = {
        Time = 1.2,
        Priority = EnumsModule.Stun.Heavy
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 15, 15),
        Debug = false,
        Offset = CFrame.new()
    },
    HitSounds = {
        Hit = {
            SoundId = 8102779385,
            Volme = 3
        }
    },
    HitRemotes = { v10 },

    Invoke = function(p20) -- Line: 589, Name: Invoke
        -- upvalues: u1 (ref), FindNearest (copy)
        local _ = p20.Stats;
        local _ = p20.Player;
        local Character = p20.Character;
        u1:FireInput(p20.Input, (FindNearest({
            Distance = 50,
            Origin = Character.HumanoidRootPart.CFrame,
            Ignore = { Character }
        })));
    end
};
v17["Umbral Execution"] = {
    Active = true,
    Damage = 55,
    Cooldown = 30,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Ragdoll = { 0.75 },
    Stun = {
        Time = 0.25,
        Priority = EnumsModule.Stun.Medium
    },
    Meter = {
        Amount = 0,
        RequiredLevel = 3
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(30, 30, 30),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new()
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v10 },
    FXData = {
        Color = Color3.new(1, 0, 1)
    }
};
v17.Foresight = {
    Active = true,
    Damage = 25,
    CounterTime = 10,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        MeterGain = 0,
        RequiredAmount = 50
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 5, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Texture1 = {
        frames = 15,
        fps = 60,
        rows = 3,
        columns = 5,
        front = "http://www.roblox.com/asset/?id=7943227207",
        back = "http://www.roblox.com/asset/?id=7945726042",
        size = Vector3.new(12, 12, 0),
        color = Color3.fromRGB(255, 144, 244),
        part = ReplicatedStorage["Client Assets"].Misc.slash
    },
    HitSounds = {
        Hit = {
            SoundId = 8102907278,
            Volme = 5
        }
    },
    HitRemotes = { v10 }
};
v17.Sovereign = {
    Active = true,
    FXDuration = 6,
    Actionable = {
        Active = true
    },
    Heat = {
        RequiredAmount = 100,
        RemoveMeter = false
    },
    SovereignColor = Color3.fromRGB(255, 85, 255)
};
v17["Umbral Blades"] = {
    Active = true,
    Damage = 15,
    Amount = 6,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Umbral Blades",
        Time = 10,
        Manual = true
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 7181838845,
            Volme = 3
        }
    },
    HitRemotes = { v10 }
};
v17["Umbral Dash"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Active = {
            Ignore = { "Block" }
        }
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Time = 1.5,
        CooldownReduction = false
    },
    Tweens = {
        End = { 0.5, Enum.EasingStyle.Sine }
    },
    Props = {
        Start = {
            Transparency = 0,
            Color = Color3.new(1, 0, 1)
        },
        End = {
            Transparency = 1
        }
    },

    Invoke = function(p21) -- Line: 768, Name: Invoke
        -- upvalues: RunService (copy), u1 (ref)
        local Input = p21.Input;
        local _ = p21.Stats;
        local _ = p21.Player;
        local Character = p21.Character;
        local _ = Character.HumanoidRootPart;
        local Humanoid = Character.Humanoid;
        local UserInputService = game:GetService("UserInputService");
        TweenInfo.new(0.1, Enum.EasingStyle.Sine);
        local v22 = {
            W = CFrame.new(0, 0, -15),
            A = CFrame.new(-15, 0, 0),
            S = CFrame.new(0, 0, 15),
            D = CFrame.new(15, 0, 0)
        };
        local v23 = "W";

        if RunService:IsServer() then
            local MoveDirection = Humanoid.MoveDirection;

            if MoveDirection.X > MoveDirection.Z then
                v23 = MoveDirection.X < 0 and "A" or "D";
            else
                v23 = MoveDirection.Z < 0 and "S" or "W";
            end;
        elseif UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
            v23 = UserInputService:IsKeyDown(Enum.KeyCode.W) and "W" or (UserInputService:IsKeyDown(Enum.KeyCode.A) and "A" or (UserInputService:IsKeyDown(Enum.KeyCode.S) and "S" or (UserInputService:IsKeyDown(Enum.KeyCode.D) and "D" or v23)));
        end;

        local v24 = v22[v23];

        if RunService:IsServer() then
            return;
        end;

        u1:FireInput(Input, v24);
    end
};
v17.Breaker = {
    From = "Combat.Breaker"
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 4
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            },
            Sovereign = {
                Visible = false,
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
            ["Umbral Dash"] = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Slashes = {
                DefaultKeybind = "E",
                State = "Universal",
                Unlocked = true,
                Description = "Perform three quick projectile slashes"
            },
            ["Last Rites"] = {
                DefaultKeybind = "R",
                State = "Universal",
                Unlocked = true,
                Description = "Perform a radial slash"
            },
            Erasure = {
                DefaultKeybind = "E",
                State = "Universal",
                LevelRequirement = 100,
                Description = "Shoot out a wave of lightning",
                Cost = {
                    AscensionRank = 3,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Finis Aeternam"] = {
                DefaultKeybind = "R",
                State = "Universal",
                LevelRequirement = 120,
                Description = "Summon a giant sword to pierce the earth",
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Elegant Bladework"] = {
                DefaultKeybind = "T",
                State = "Universal",
                LevelRequirement = 10,
                Description = "Perform several slashes, can be recasted at the end to do a radial slash",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Judgement Cut"] = {
                DefaultKeybind = "Y",
                State = "Universal",
                LevelRequirement = 35,
                Description = "Enter a stance and shoot out three ugo aim dimensional cuts after a delay",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Foresight = {
                DefaultKeybind = "V",
                State = "Universal",
                LevelRequirement = 60,
                Description = "Enter a flow in which you counter any incoming attacks. When the move ends or on recast perform a radial slash. During Sovereign state these counterattacks become judgement cuts",
                Cost = {
                    AscensionRank = 5,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Umbral Execution"] = {
                DefaultKeybind = "G",
                State = "Universal",
                LevelRequirement = 75,
                Description = "Summon a giant zone in which you cut everything within the space after a delay",
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            Sovereign = {
                DefaultKeybind = "H",
                State = "Universal",
                LevelRequirement = 110,
                Description = "Transform into an awakened state and gain buffs. During this state some moves may change",
                Cost = {
                    AscensionRank = 10,
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Umbral Blades"] = {
                DefaultKeybind = "G",
                State = "Universal",
                LevelRequirement = 25,
                Description = "Summon several swords to act as a follow up on your next successful attack",
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            }
        }
    },
    Animations = {
        Action = {
            Summon = 10431821435,
            ["Sovereign Summon"] = 7745633118,
            ["LMB-1"] = 10431845470,
            ["LMB-2"] = 10431848729,
            ["LMB-3"] = 10431851260,
            ["LMB-4"] = 10431853479,
            ["LMB-5"] = 10431855534,
            ["Sovereign-LMB-1"] = 10431845470,
            ["Sovereign-LMB-2"] = 10431848729,
            ["Sovereign-LMB-3"] = 10431851260,
            ["Sovereign-LMB-4"] = 10431853479,
            ["Sovereign-LMB-5"] = 10431855534,
            Slashes = 10431839028,
            ["Last Rites"] = 10431842071,
            ["Elegant Bladework"] = 7715956827,
            Spin = 7716289017,
            ["Judgement Stance"] = 7732399959,
            ["Counter-1"] = 7720884211,
            ["Counter-2"] = 7721099916,
            ["Counter-3"] = 7721105359,
            ["Counter-4"] = 7721107482,
            ["Counter-5"] = 7721109688,
            ["Umbral Execution"] = 6969944759,
            HeavySlash = 5854371740,
            Lunge = 5220947619,
            Pin = 5220941171,
            Dash = 5191300871,
            PoseIdle = 6969965321,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132,
            ["Stand-Block"] = 12499353550,
            ["Stand-BlockHit1"] = 12499359012,
            ["Stand-BlockHit2"] = 12499360090,
            ["Stand-BlockHit3"] = 12499361466,
            ["Stand-BlockBreak"] = 12499357071,
            ["StandOn-Grab"] = 11110729280,
            ["StandOn-Throw"] = 11110730939,
            ["StandOn-ThrowVictim"] = 11110732132
        },
        Movement = {
            ["Counter Stance"] = 8053101773,
            Run = 10421345302,
            Walk = 10421341888,
            SovereignRun = 10421345302,
            SovereignWalk = 10421341888
        },
        Idle = {
            Idle = 10421339013,
            SovereignIdle = 7745662002
        }
    },
    Stats = v17,
    Sounds = {
        ["LMB-1-3"] = {
            SoundId = 6929399424,
            Volume = 3,
            PlaybackSpeed = 1.5
        },
        ["LMB-4"] = {
            SoundId = 6929399716,
            Volume = 3
        },
        ["LMB-5"] = {
            SoundId = 6929399985,
            Volume = 3
        },
        ["Sovereign-LMB-4"] = {
            SoundId = 6929399716,
            Volume = 3
        },
        ["Sovereign-LMB-5"] = {
            SoundId = 6929399985,
            Volume = 3
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 8092340823,
            Volume = 3
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 8092341470,
            Volume = 3
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 8092341961,
            Volume = 3
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 8092342588,
            Volume = 3
        },
        ["LMB-5-Voiceline"] = {
            SoundId = 8092343090,
            Volume = 3
        },
        ["Sovereign-LMB-1-Voiceline"] = {
            SoundId = 8102342788,
            Volume = 3
        },
        ["Sovereign-LMB-2-Voiceline"] = {
            SoundId = 8102343410,
            Volume = 3
        },
        ["Sovereign-LMB-3-Voiceline"] = {
            SoundId = 8102343864,
            Volume = 3
        },
        ["Sovereign-LMB-4-Voiceline"] = {
            SoundId = 8102344724,
            Volume = 3
        },
        ["Sovereign-LMB-5-Voiceline"] = {
            SoundId = 8102345240,
            Volume = 3
        },
        EVoice = {
            SoundId = 8092410323,
            Volume = 3
        },
        ["Sovereign-EVoice"] = {
            SoundId = 8102464991,
            Volume = 3
        },
        RVoice = {
            SoundId = 8092511908,
            Volume = 3
        },
        ["Sovereign-RVoice"] = {
            SoundId = 8102484508,
            Volume = 3
        },
        YVoice = {
            SoundId = 8093145734,
            Volume = 3
        },
        ["Sovereign-YVoice"] = {
            SoundId = 8102517447,
            Volume = 3
        },
        ["Counter Voice"] = {
            SoundId = 8093161396,
            Volume = 3
        },
        ["Sovereign-Counter Voice"] = {
            SoundId = 8102544770,
            Volume = 3
        },
        SpinVoice = {
            SoundId = 8093246472,
            Volume = 3
        },
        ["Sovereign-SpinVoice"] = {
            SoundId = 8102562167,
            Volume = 3
        },
        UltVoice = {
            SoundId = 8102721820,
            Volume = 3
        },
        ["Sovereign-UltVoice"] = {
            SoundId = 8102620543,
            Volume = 3
        },
        SovereignVoice = {
            SoundId = 8102278015,
            Volume = 3
        },
        SummonSound = {
            SoundId = 7185883762,
            Volume = 3
        },
        Startup = {
            SoundId = 7181837835,
            Volume = 3
        },
        Slashes = {
            SoundId = 7181838406,
            Volume = 3
        },
        ["Last Rites"] = {
            SoundId = 6929400152,
            Volume = 3
        },
        ["Elegant Bladework"] = {
            SoundId = 8102748330,
            Volume = 3
        },
        TSpin = {
            SoundId = 8102765536,
            Volume = 3
        },
        ["Judgement Cut"] = {
            SoundId = 8102773563,
            Volume = 3
        },
        ["Umbral Blades"] = {
            SoundId = 8103146449,
            Volume = 3
        },
        Counter = {
            SoundId = 9062285735,
            Volume = 3
        },
        ["Counter Spin"] = {
            SoundId = 8102896888,
            Volume = 3
        },
        Ult = {
            SoundId = 6891206605,
            Volume = 3
        },
        Sovereign = {
            SoundId = 9066049772,
            Volume = 3
        },
        Erasure = {
            SoundId = 8102912240,
            Volume = 3
        },
        ["Umbral Dash"] = {
            SoundId = 6922519241,
            Volume = 3
        },
        Pose = {
            Looped = true,
            SoundId = 9073344155,
            Volume = 2
        },
        Pose2 = {
            Looped = true,
            SoundId = 9707799701,
            Volume = 2
        },
        ["Sovereign Theme"] = {
            SoundId = 12365907238,
            Volume = 3,
            Looped = false
        },
        DeathSound = {
            SoundId = 8102950660,
            Volume = 3
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            },
            Sovereign = {
                Visible = false
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://8092501857",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m motivated!",
                            ScaleTime = 0.5
                        } }
                }, {
                    SoundId = "rbxassetid://8093296787",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you stand a chance?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8093297404",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "....",
                            ScaleTime = 1,
                            EndLag = 0
                        }, {
                            Quote = " Disappointing.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8093297839",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Might...",
                            ScaleTime = 0.5,
                            EndLag = 0.5
                        }, {
                            Quote = " Controls...",
                            ScaleTime = 0.5,
                            EndLag = 0.5
                        }, {
                            Quote = " Everything!",
                            ScaleTime = 0.5
                        } }
                } },
            Sovereign = { {
                    SoundId = "rbxassetid://8102654106",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Show me your motivation.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8102688333",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This shall be your grave.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8102701668",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you stand a chance?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://9973361842",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re wasting my time.",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};
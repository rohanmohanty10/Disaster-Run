  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local _ = Knit.Remotes.Output;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 17
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);

local function Transparency(p4, p5) -- Line: 25
    if p4.Sword:GetAttribute("KeepTransparency") then
        for _, descendant in pairs(p4.Sword:GetDescendants()) do
            if descendant:IsA("BasePart") then
                descendant.Transparency = p5;
            elseif descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                if descendant.Name == "StandAura" then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 20);
                else
                    descendant.Enabled = p5 == 0;
                end;
            end;
        end;

        return;
    end;

    p4.Sword.Transparency = p5;
end;

function OpacityToggle(p6, p7, p8)
    if p6:FindFirstChild(p7) then
        local v9 = p6:FindFirstChild(p7);

        if v9:GetAttribute("Transparency") then
            for _, descendant in pairs(v9:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.Transparency = p8 and 0 or 1;
                elseif descendant:IsA("ParticleEmitter") then
                    descendant.Enabled = p8;
                end;
            end;

            return;
        end;

        v9.Transparency = p8 and 0 or 1;
    end;
end;

function IsSkin(p10, p11)
    if p10 and (p11 and p10.Data.Skin:GetAttribute("SkinName") == p11) then
        return true;
    end;
end;

v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p12, p13, p14) -- Line: 84
                    -- upvalues: Transparency (copy)
                    local Stand = p14.Character.Stand;
                    local _ = Stand.Sword;
                    Transparency(Stand, 0);
                    task.delay(0.37, function() -- Line: 88
                        -- upvalues: Transparency (ref), Stand (copy)
                        Transparency(Stand, 1);
                    end);
                end },
            { 23, 26, "Attack" },
            { 28, "End" }
        },
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 566593606,
                Volume = 2
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p15, p16, p17) -- Line: 111
                    -- upvalues: Transparency (copy)
                    local Stand = p17.Character.Stand;
                    local _ = Stand.Sword;
                    Transparency(Stand, 0);
                    task.delay(0.36, function() -- Line: 115
                        -- upvalues: Transparency (ref), Stand (copy)
                        Transparency(Stand, 1);
                    end);
                end },
            { 19, 22, "Attack" },
            { 28, "End" }
        },
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Medium
        }
    },
    ["LMB-3"] = {
        Speed = 1.2,
        Sequence = {
            { 0, "Start" },
            { 0, function(p18, p19, p20) -- Line: 131
                    -- upvalues: Transparency (copy)
                    local Stand = p20.Character.Stand;
                    local _ = Stand.Sword;
                    Transparency(Stand, 0);
                    task.delay(0.425, function() -- Line: 135
                        -- upvalues: Transparency (ref), Stand (copy)
                        Transparency(Stand, 1);
                    end);
                end },
            { 22, 24, "Attack" },
            { 31, "End" }
        },
        Stun = {
            Time = 0.7,
            Priority = EnumsModule.Stun.Medium
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = {
            { 0, "Start" },
            { 0, function(p21, p22, p23) -- Line: 153
                    -- upvalues: Transparency (copy)
                    local Stand = p23.Character.Stand;
                    local _ = Stand.Sword;
                    Transparency(Stand, 0);
                    task.delay(0.386, function() -- Line: 157
                        -- upvalues: Transparency (ref), Stand (copy)
                        Transparency(Stand, 1);
                    end);
                end },
            { 27, 30, "Attack" },
            { 30, "End" }
        },
        Block = {
            Unblockable = true
        },
        HitSounds = {
            Hit = {
                SoundId = 566593606,
                Volume = 2,
                Pitch = 0.9
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher)
};
v1.Grab = {
    From = "Combat.Grab",
    AttackFrame = 90,
    Actionable = {
        Active = true
    },
    Callbacks = {
        OnStart = function(p24, p25) -- Line: 189, Name: OnStart
            -- upvalues: u3 (ref)
            local _ = p24.Stats;
            local Player = p24.Player;
            local Character = p24.Character;
            local _ = p24.RootPart;
            local _ = p24.Trove;
            local _ = p24.AbilityModel;

            if IsSkin(Player, "1x1x1x1") then
                u3.FetchSound(Character, "GrabStart"):Play();

                return;
            end;

            if IsSkin(Player, "The Virtuoso") then
                u3.FetchSound(Character, "Virtuoso-GrabStart"):Play();
            end;
        end,

        OnGrab = function(p26, p27, p28) -- Line: 204, Name: OnGrab
            -- upvalues: u3 (ref)
            local _ = p26.Stats;
            local Player = p26.Player;
            local Character = p26.Character;
            local _ = p26.RootPart;
            local Trove = p26.Trove;
            local AbilityModel = p26.AbilityModel;
            OpacityToggle(AbilityModel, "Hammer", true);

            if IsSkin(Player, "1x1x1x1") then
                u3.FetchSound(Character, "GrabHit"):Play();
            elseif IsSkin(Player, "The Virtuoso") then
                u3.FetchSound(Character, "Virtuoso-GrabLand"):Play();
                u3.FetchSound(Character, "Virtuoso-GrabVoiceline"):Play();
            else
                u3.FetchSound(Character, "BuildWall"):Play();
                u3.FetchSound(Character, "TA-DAH"):Play();
            end;

            Trove:Add(function() -- Line: 223
                -- upvalues: AbilityModel (copy)
                OpacityToggle(AbilityModel, "Hammer", false);
            end);
        end,

        OnThrow = function(p29, p30, p31) -- Line: 228, Name: OnThrow
            -- upvalues: u3 (ref), u2 (ref)
            local _ = p29.Stats;
            local Player = p29.Player;
            local Character = p29.Character;
            local _ = p29.RootPart;
            local _ = p29.Trove;
            local _ = p29.AbilityModel;

            local function Rng(p32, p33) -- Line: 236
                return Random.new():NextNumber(p32 or 0, p33 or 1);
            end;

            if IsSkin(Player, "The Virtuoso") then
                u3.FetchSound(Character, "Virtuoso-GrabHit"):Play();
            elseif not IsSkin(Player, "1x1x1x1") then
                u3.FetchSound(Character, "RocketShoot"):Play();
            end;

            if p31 and p31:FindFirstChild("Head") then
                local Head = p31.Head;

                if not IsSkin(Player, "The Virtuoso") then
                    u2.FireAllClients("BrickbattleStud", Head.Position, Head.Color, math.random(8, 15), math.random(2, 25));
                end;
            end;
        end
    },
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        Damage = 45,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Pellet Barrage"] = {
    ProjectileName = "SlingshotPellet",
    Active = true,
    Damage = 2.5,
    Cooldown = {
        Time = 10
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.5,
        Priority = EnumsModule.Stun.Medium
    }
};
v1["Ban Slam"] = {
    Active = true,
    Damage = 40,
    Cooldown = {
        Time = 10
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 8,
        Debug = false,
        Offset = CFrame.new(0, 0, -8.5)
    },
    Ragdoll = {
        Time = 1
    },
    Stun = {
        Time = 0.25,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.2
    }
};
v1["Fire Paint"] = {
    ProjectileName = "Paintball",
    Active = true,
    Damage = 6.25,
    Cooldown = {
        Time = 15
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Block = {
        PerfectBlockable = false
    },
    Stun = {
        Time = 0.3,
        Priority = EnumsModule.Stun.Medium
    }
};
v1["Bomb Jump"] = {
    Active = true,
    Damage = 30,
    Cooldown = {
        Time = 20
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 16.5,
        Debug = false,
        Offset = CFrame.new(0, 0, 0)
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Ragdoll = {
        Time = 1
    },
    Knockback = {
        Time = 0.1,
        Speed = 40,
        RelativeTowards = "Target"
    },
    Block = {
        PerfectBlockable = false
    },
    Meter = {
        RequiredLevel = 2
    }
};
v1["Build Wall"] = {
    CastAmount = 3,
    Active = true,
    Damage = 10,
    Cooldown = {
        Time = 10,
        Manual = true
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Stun = {
        Time = 0.75,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        PerfectBlockable = false
    },
    Hitbox = {
        Type = "Magnitude",
        Size = Vector3.new(4, 1, 2),
        Predict = true,
        Offset = CFrame.new(0, 0, 0)
    }
};
v1["Throw Superball"] = {
    ProjectileName = "Superball",
    Active = true,
    Damage = 35,
    Cooldown = {
        Time = 10
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Block = {
        PerfectBlockable = false,
        Blockable = false
    },
    Stun = {
        Time = 0.25,
        Priority = EnumsModule.Stun.Medium
    }
};
v1["Launch Rocket"] = {
    ProjectileName = "Rocket",
    Active = true,
    Cooldown = {
        Time = 30
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Explosion = {
        Damage = 45,
        Hitbox = {
            Type = "Magnitude",
            Size = 8,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        Knockback = {
            Time = 0.1,
            Speed = 40,
            RelativeTowards = "Target"
        },
        Stun = {
            Time = 2.75,
            Priority = EnumsModule.Stun.Medium
        },
        Block = {
            Unblockable = true,
            PerfectBlockable = false
        }
    }
};
v1["Nostalgic Nutrition"] = {
    Active = true,
    Heal = 15,
    Cooldown = {
        Time = 30
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Block = {
        Unblockable = true
    },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 2
    }
};
v1.Pose = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1.5,
        AfterMove = true
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
            Summon = {
                DefaultKeybind = "Q",
                Equipped = false,
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
            ["Pellet Barrage"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Send out a bunch of pellets as the move is held down."
            },
            ["Ban Slam"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Pull out a ban hammer as you slam with it."
            },
            ["Throw Superball"] = {
                DefaultKeybind = "T",
                Description = "Throw a superball which reflects upon hitting a wall.",
                LevelRequirement = 15,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Fire Paint"] = {
                DefaultKeybind = "Y",
                Description = "Send out a bunch of paintballs as the key is held down, which explode upon impact and blind the target hit.",
                LevelRequirement = 45,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Build Wall"] = {
                DefaultKeybind = "G",
                Description = "Build a wall right in front of you to defend yourself.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Launch Rocket"] = {
                DefaultKeybind = "H",
                Description = "Pull out a rocket launcher and send a rocket forward which explodes once it hits a player or a wall, this will also destroy a wall if the wall is created by the user.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Bomb Jump"] = {
                DefaultKeybind = "V",
                Description = "Bring out a bomb and plant it right below yourself, causing it to explode as you launch up in the air.",
                LevelRequirement = 85,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Nostalgic Nutrition"] = {
                DefaultKeybind = "B",
                Description = "Bring out food / drinks and consume them while this move is held down.",
                LevelRequirement = 90,
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
            ["Hammer Slam"] = 8987751217,
            ["Fire Rocket"] = 8987760061,
            ["Place Bomb"] = 8987763805,
            ["Build Wall"] = 8987767273,
            ["Item Pull"] = 9281773907,
            ["Equip Paint"] = 9281777834,
            ["Fire Paint"] = 9281780974,
            ["Slingshot Fling"] = 9489815142,
            ["Throw Superball"] = 9489777674,
            ["Monster Mash"] = 35654637,
            ["StandOff-Grab"] = 105149978676307,
            ["StandOff-Throw"] = 88026629725269,
            ["StandOff-ThrowVictim"] = 90320165747496,
            ["LMB-1"] = 9489835071,
            ["LMB-2"] = 9489848902,
            ["LMB-3"] = 9489855712,
            ["LMB-4"] = 9489863948,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132
        },
        Movement = {
            Run = 180426354,
            Walk = 180426354,
            Jump = 8958971025,
            Fall = 8958971025
        },
        Idle = {
            Idle = 180435571
        }
    },
    Stats = v1,
    Sounds = {
        BanHammerUse = {
            SoundId = 9281812168,
            Volume = 1
        },
        ["TA-DAH"] = {
            SoundId = 121201120407551,
            Volume = 1
        },
        RocketShoot = {
            SoundId = 88843442856765,
            Volume = 0.7
        },
        BombEquip = {
            SoundId = 71353714538845,
            Volume = 1
        },
        BuildWall = {
            SoundId = 12221944,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 12222216,
            Volume = 1,
            TimePosition = 0.1
        },
        ["LMB-2"] = {
            SoundId = 12222216,
            Volume = 1,
            TimePosition = 0.1
        },
        ["LMB-3"] = {
            SoundId = 12222216,
            Volume = 1,
            TimePosition = 0.1
        },
        ["LMB-4"] = {
            SoundId = 12222208,
            Volume = 1,
            Pitch = 0.95
        },
        MonsterMash = {
            SoundId = 35930009,
            Volume = 1,
            Looped = true
        },
        PaintFire = {
            SoundId = 11900833,
            Volume = 0.8
        },
        RocketSpawn = {
            SoundId = 9281813571,
            Volume = 1.5
        },
        SlingshotFire = {
            SoundId = 844029237,
            Volume = 0.65
        },
        SwordLunge = {
            SoundId = 12222208,
            Volume = 0.75
        },
        Unsheath = {
            SoundId = 12222225,
            Volume = 1
        },
        Boing = {
            SoundId = "rbxasset://sounds//short spring sound.wav",
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
                    SoundId = "rbxassetid://1237557124",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "oof"
                        } }
                }, {
                    SoundId = "rbxassetid://1237557124",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "uuhhh"
                        } }
                } }
        }
    }
};
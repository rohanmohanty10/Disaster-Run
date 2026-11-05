  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EnableBirthmark = require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local ClientAssets = PathShortcuts.ClientAssets;
local v3 = {
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
            ["Accelerated Barrage"] = {
                DefaultKeybind = "E",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash a devastating barrage of blows.\nIf used while Time Acceleration is active, teleport to the nearest target."
            },
            ["Heavenly Strike"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "A two stage move, starting with ramming Made In Heaven into a target, before unleashing a double kick."
            },
            ["Instant Slice"] = {
                DefaultKeybind = "R+",
                State = "StandOn",
                Description = "Crouch down before instantly dashing forward at an incredible speed, slicing at anyone caught in your way.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Knife Throw"] = {
                DefaultKeybind = "T",
                State = "Universal",
                Description = "Dash backwards while throwing a flurry of knives forward.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            Checkmate = {
                DefaultKeybind = "T+",
                State = "Universal",
                Description = "Throw out a volley of knives. Can be charged to narrow the spread of the knives, increasing accuracy.",
                LevelRequirement = 50,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Divine Judgment"] = {
                DefaultKeybind = "G",
                State = "StandOn",
                Description = "Perform a dropkick. Upon connection, perform a divine combination on your target.",
                LevelRequirement = 110,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Made In Heaven"] = {
                DefaultKeybind = "H",
                State = "Universal",
                Description = "Rapidly accelerate time even further, strengthening the effects of Time Acceleration to slow down those around you, as well as increasing your speed further, at the cost of draining your dials faster.",
                LevelRequirement = 120,
                Cost = {
                    Currencies = {
                        UCoins = 1000000
                    }
                }
            },
            ["Godly Speed"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "Instantly teleport in the direction you are moving at the cost of draining your dials.",
                LevelRequirement = 10,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Time Accelerate"] = {
                DefaultKeybind = "B",
                State = "Universal",
                Description = "Consume Heat to fill one dial of Time Acceleration. Time Acceleration strength increases with active dials.",
                LevelRequirement = 40,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Accelerated Rushdown"] = {
                DefaultKeybind = "E",
                State = "StandOff",
                Description = "Wind up and dash forward to grab someone. Upon grabbing a target, they will be ruthlessly pummeled before being thrown.",
                LevelRequirement = 25,
                Cost = {
                    Currencies = {
                        UCoins = 500000
                    }
                }
            },
            ["Throat Slit"] = {
                DefaultKeybind = "R",
                State = "StandOff",
                Description = "Dash forward and slice the throats of anyone caught in your trajectory.",
                LevelRequirement = 35,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Hand of Destiny"] = {
                DefaultKeybind = "G",
                State = "StandOff",
                Description = "Strike a target with your hand, slowing them down immensely for a brief moment.",
                LevelRequirement = 65,
                Cost = {
                    Currencies = {
                        UCoins = 750000
                    }
                }
            },
            ["Prime Numbers"] = {
                DefaultKeybind = "J",
                State = "Universal",
                Description = "Count prime numbers to yourself, slowly regenerating health for every number counted.",
                LevelRequirement = 70,
                Cost = {
                    Currencies = {
                        UCoins = 250000
                    }
                }
            },
            ["Sanctimonious Counter"] = {
                DefaultKeybind = "Y",
                State = "Universal",
                Description = "Strike a stance and teleport behind your enemey dealing a devastating blow if attacked.",
                LevelRequirement = 55
            }
        }
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    Assets = ClientAssets["Made In Heaven"],
    Metadata = {
        PostRig = function(p1) -- Line: 267, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p1.Player;
            local Character = p1.Character;
            local SkinName = p1.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Torso = Character:FindFirstChild("Torso");
            local v2 = AssetHandler.CloneAsset("Particles/Birthmark", {
                AbilityName = "Crazy Diamond",
                SkinName = SkinName
            });
            v2.Parent = Torso;
            local Weld = Instance.new("Weld");
            Weld.Part0 = Torso;
            Weld.Part1 = v2;
            Weld.C0 = Weld.C0 * CFrame.new(-0.6, 0.9, 0.55);
            Weld.Parent = Torso;
        end
    }
};
v3.Stats.Summon = {
    From = "Combat.Summon",
    SummonV2 = true,
    StandAura = false,
    LeaveParts = { "head 2", "StandHumanoidRootPart", "TRANSPARENT" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 125, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 125, 255)) }),
    Callbacks = {
        Summon = function(p4) -- Line: 307, Name: Summon
            -- upvalues: Knit (copy)
            Knit.GetService("AnimationService").Get(p4.Character.Humanoid.Animator):PlayAnimation("Summon");
            local v5 = Knit.GetService("EffectService");
            local AbilityModel = p4.AbilityModel;
            v5.FireAllClients("MIH_SUMMON", AbilityModel["Stand Torso"]);

            for _, descendant in pairs(AbilityModel:GetDescendants()) do
                if not descendant:GetAttribute("StandTrail") then
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = true;
                        descendant.Archivable = false;

                        if descendant.Name == "Connector" then
                            descendant.Transparency = NumberSequence.new(0);
                        end;
                    elseif descendant:IsA("Light") then
                        descendant.Enabled = true;
                    end;
                end;
            end;

            for _, child in pairs(p4.Character:GetChildren()) do
                if child:IsA("BasePart") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2.Name == "StandAura" and child2:IsA("ParticleEmitter") then
                            child2.Enabled = true;
                            child2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 125, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 125, 255)) });
                        end;
                    end;
                end;
            end;
        end,

        Unsummon = function(p6) -- Line: 345, Name: Unsummon
            for _, descendant in pairs(p6.AbilityModel:GetDescendants()) do
                if not descendant:GetAttribute("StandTrail") then
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = false;
                    elseif descendant:IsA("Light") then
                        descendant.Enabled = false;
                    end;
                end;
            end;

            for _, child in pairs(p6.Character:GetChildren()) do
                if child:IsA("BasePart") then
                    for _, child2 in pairs(child:GetChildren()) do
                        if child2.Name == "StandAura" and child2:IsA("ParticleEmitter") then
                            child2.Enabled = false;
                        end;
                    end;
                end;
            end;
        end
    }
};
v3.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 14, 18, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.4
        },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = {
            Hit = v3.Resources.LMB1Hit
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-2"] = {
        Speed = 0.8,
        Sequence = { { 0, "Start" }, { 8, 12, "Attack" }, { 13, "End" } },
        HitSounds = {
            Hit = v3.Resources.LMB2Hit
        }
    },
    ["LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 14, 18, "Attack" }, { 26, "End" } },
        HitSounds = {
            Hit = v3.Resources.LMB3Hit
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 2,
        Sequence = { { 0, "Start" }, { 34, 38, "Attack" }, { 59, "End" } },
        Stun = {
            Time = 0.3
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {
            Hit = v3.Resources.LMB4Hit
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    ["StandOff-LMB-1"] = TableUtil.Reconcile({
        Speed = 1.1,
        Sequence = { { 0, "Start" }, { 19, 24, "Attack" }, { 28, "End" } },
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 11038124693,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["StandOff-LMB-2"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 8, 13, "Attack" }, { 18, "End" } }
    },
    ["StandOff-LMB-3"] = {
        Speed = 0.9,
        Sequence = { { 0, "Start" }, { 10, 13, "Attack" }, { 18, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11038126028,
                Volume = 1.5
            }
        }
    },
    ["StandOff-LMB-4"] = TableUtil.Reconcile({
        Speed = 2.1,
        Sequence = {
            { 0, "Start" },
            { 0, function(u7, p8, p9) -- Line: 501
                    -- upvalues: ClientAssets (copy)
                    u7.UserData.Attachment = ClientAssets.Whitesnake.CrossEffects.Attachment:Clone();
                    u7.UserData.Attachment.Parent = p9.Character["Left Arm"];
                    u7.UserData.Attachment.StartupShine:Emit(1);
                    u7.UserData.Attachment.StartupTwinkle:Emit(1);
                    task.delay(0.05, function() -- Line: 508
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment.Twinkle1:Emit(3);
                        u7.UserData.Attachment.Twinkle2:Emit(3);
                        u7.UserData.Attachment.Swirls:Emit(3);
                    end);
                    task.delay(0.15, function() -- Line: 514
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment.ParticleEmitter:Emit(8);
                    end);
                    task.delay(0.6, function() -- Line: 518
                        -- upvalues: u7 (copy)
                        u7.UserData.Attachment:Destroy();
                    end);
                end },
            { 36, 42, "Attack" },
            { 48, "End" }
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 11038126198,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p10, p11) -- Line: 539, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p10.Stats;

            if not Knit.CollectionService:HasTag(p10.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v3.Stats.Block = {
    From = "Combat.Block"
};
v3.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p12, p13) -- Line: 563, Name: PoseTransition
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p12.Character, true);
        end,

        Transformer = function(p14) -- Line: 566, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v15 = p14.Character:GetAttribute("MadeInHeaven");
            local v16 = TableUtil.Copy(p14.Stats, true);

            if not Knit.CollectionService:HasTag(p14.Character, "Summoned") then
                if v15 then
                    v16.PoseMusic = "MIHPoseMusic";
                end;

                return v16;
            end;

            if v15 then
                v16.PoseMusic = "StandOnMIHPoseMusic";
            else
                v16.PoseMusic = "StandOnPoseMusic";
            end;

            v16.StartAnim = "StandPoseTransition";
            v16.LoopAnim = "StandPoseIdle";

            return v16;
        end,

        PoseEnd = function(p17, p18) -- Line: 585, Name: PoseEnd
            -- upvalues: EnableBirthmark (copy)
            EnableBirthmark(p17.Character, false);
        end
    }
};
v3.Stats.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = true
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
v3.Stats["Accelerated Barrage"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    TeleportCooldown = {
        Name = "STANDON-E-TELEPORT",
        Time = 16,
        AfterMove = true
    },
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, function(p19, p20, p21) -- Line: 639
                -- upvalues: PathShortcuts (copy), Knit (copy), ClientAssets (copy)
                local Player = p21.Player;
                local Character = p21.Character;
                local HumanoidRootPart = Character.HumanoidRootPart;

                if Character:GetAttribute("TimeAccelLevel") < 1 then
                    return;
                end;

                local v22 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                local v23 = Knit.GetService("PingService");

                if v22.GetCooldown(Character, p21.Stats.TeleportCooldown) then
                    return;
                end;

                local v24 = v22.Hitbox({
                    Caster = Character,
                    Stats = p21.Stats.Search
                });
                local v25;

                if Player then
                    v25 = v23.Get(Player);
                else
                    v25 = Player;
                end;

                local Position = HumanoidRootPart.Position;

                if v25 then
                    Position = v25.MouseHit.Position;
                end;

                local v26 = {};

                for _, v in pairs(v24) do
                    local HumanoidRootPart2 = v.Character:FindFirstChild("HumanoidRootPart");

                    if HumanoidRootPart2 then
                        table.insert(v26, {
                            Character = v.Character,
                            Part = HumanoidRootPart2,
                            Distance = (Position - HumanoidRootPart2.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v26, function(p27, p28) -- Line: 679
                    return p27.Distance < p28.Distance;
                end);
                local v29 = v26[1];

                if not v29 then
                    return;
                end;

                local v30 = Vector3.new(HumanoidRootPart.Position.X, v29.Part.Position.Y, HumanoidRootPart.Position.Z);
                Knit.Remotes.Output:FireAllClients("FX", "Emit Particle V3", {
                    AutoSerialize = true,
                    Origin = CFrame.lookAt(v30, v29.Part.Position),
                    Particle = ClientAssets["Made In Heaven"].Godly_Speed.Effect,
                    Player = Player
                });
                HumanoidRootPart.CFrame = CFrame.lookAt(v29.Part.Position, v30) * CFrame.new(0, 0, -4) * CFrame.Angles(0, 3.141592653589793, 0);
                v22.FetchSound(Character, "BarrageTeleport"):Play();
                v22.CreateCooldown(Character, p21.Stats.TeleportCooldown);
            end },
        { 24, "Barrage", true },
        { 24, 144, "BarrageAttack", "Hit" },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "BarrageFinisher" },
        { 163, "BarrageAttack", "Finisher" },
        { 193, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    Search = {
        Size = 16,
        Offset = CFrame.new(0, 0, -8)
    },
    Hit = TableUtil.Reconcile({
        HitRemotes = { v3.Resources.LightHit },
        HitSounds = {
            Hit = v3.Sounds.BarrageHit
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {
            Hit = v3.Sounds.BarrageFinisher
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher,
    Callbacks = {
        BarrageEffect = function(p31, p32, p33, p34) -- Line: 738, Name: BarrageEffect
            -- upvalues: Knit (copy)
            local Character = p32.Character;

            if p34 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                Knit.Remotes.Output:FireAllClients("FX", "Stand_Barrage", Character, {
                    AbilityName = p32.AbilityName,
                    SkinName = p32.SkinName,
                    Offset = CFrame.new(0, 0, -2.5)
                });
                p33.SequenceTrove:Add(function() -- Line: 748
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    }
};
v3.Stats["Accelerated Rushdown"] = {
    Active = true,
    Frequency = 8,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true
    },
    Startup = {
        Damage = 15,
        HitAnimations = "Default",
        Meter = false,
        Hitbox = {
            Size = Vector3.new(10, 10, 20),
            Offset = CFrame.new(0, 0, -10)
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        Stun = {
            Time = 0.65
        },
        HitRemotes = { v3.Resources.BloodHit }
    },
    Hit = {
        Damage = 0.5,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.25
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    Finisher = {
        Damage = 25,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.75
        },
        Block = {
            PerfectBlockable = false,
            Blockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 55,
            Time = 0.15
        },
        HitRemotes = { v3.Resources.HeavyHit }
    }
};
v3.Stats["Throat Slit"] = {
    Active = true,
    Damage = 20,
    HitAnimations = "Default",
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
    Hitbox = {
        Size = Vector3.new(18, 10, 30),
        Offset = CFrame.new(0, 0, -15)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true
    },
    Stun = {
        Time = 1
    },
    HitRemotes = { v3.Resources.BloodHit },
    HitSounds = {
        Hit = v3.Sounds.ThroatSlitHit
    }
};
v3.Stats["Instant Slice"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
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
    Hitbox = {
        Size = Vector3.new(18, 10, 40),
        Offset = CFrame.new(0, 0, -20)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true,
        BlockBreak = false,
        PerfectBlockBreak = false
    },
    Stun = {
        Time = 0.75
    },
    Ragdoll = {
        Time = 0.75
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 75,
        Velocity = Vector3.new(0, 25, 0),
        Time = 0.1
    },
    HitRemotes = { v3.Resources.BloodHit },
    HitSounds = {
        Hit = {
            SoundId = 12939571780,
            Volume = 2
        }
    }
};
v3.Stats["Heavenly Strike"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hit = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 10, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Stun = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 12,
            Time = 0.1
        },
        HitRemotes = { v3.Resources.BloodHit },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        HitSounds = {
            Hit = v3.Sounds.HeavenlyStrikeHit
        }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 10, 12),
            Offset = CFrame.new(0, 0, -6)
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 54,
            Time = 0.1
        },
        HitRemotes = { v3.Resources.HeavyHit },
        HitSounds = {
            Hit = v3.Sounds.HeavenlyStrikeHit
        }
    }
};
v3.Stats["Knife Throw"] = {
    Active = true,
    Damage = 3.75,
    HitAnimations = "Default",
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
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    },
    Stun = {
        Time = 0.25
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    HitRemotes = { v3.Resources.BloodHit },
    HitSounds = {
        Hit = v3.Sounds.KnifeThrowHit
    }
};
v3.Stats.Checkmate = {
    Active = true,
    Damage = 4.25,
    HitAnimations = "Default",
    Priority = EnumsModule.Intangible.Quickstep,
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
    Block = {
        PerfectBlockable = false,
        Unblockable = true
    },
    Stun = {
        Time = 0.25
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 4,
        Time = 0.1
    },
    HitRemotes = { v3.Resources.BloodHit },
    HitSounds = {
        Hit = v3.Sounds.CheckmateHit
    }
};
v3.Stats["Sanctimonious Counter"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Attack = {
        Damage = 42.5,
        HitAnimations = "Default",
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Medium
        },
        Knockback = {
            Velocity = Vector3.new(0, -36, 0),
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.25
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        HitRemotes = { v3.Resources.HeavyHit }
    }
};
v3.Stats["Hand of Destiny"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
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
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = true,
        Amount = 0
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = true,
        BlockBreak = true,
        PerfectBlockBreak = false
    },
    Stun = {
        Time = 0.8
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 16,
        Time = 0.1
    },
    HitRemotes = { v3.Resources.LightHit },
    HitSounds = {
        Hit = v3.Sounds.HandOfDestinyHit
    }
};
v3.Stats["Divine Judgment"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75,
        RemoveMeter = true
    },
    Startup = {
        CheckPVPSafe = true,
        Meter = false,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 10, 20),
            Offset = CFrame.new(0, 0, -10)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = false
        },
        Stun = {
            Time = 0.65
        }
    },
    Kick = {
        Damage = 5,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Haymaker = {
        Damage = 15,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Slam = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    LauncherKick = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    UpwardKick = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    BlitzKick = {
        Damage = 1.5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    StandRush = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.LightHit }
    },
    StandFinisher = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v3.Resources.HeavyHit }
    },
    Release = {
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Velocity = Vector3.new(0, -64, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v3.Stats["Made In Heaven"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Name = "Made In Heaven",
        Time = 30,
        AfterMove = true,
        Manual = true
    }
};
v3.Stats["Godly Speed"] = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = true,

        Check = function(p35) -- Line: 1336, Name: Check
            return p35:GetAttribute("TimeAccel") >= 200;
        end
    },
    ClientActionable = {
        Active = true,
        Stunned = true,

        Check = function(p36) -- Line: 1343, Name: Check
            return p36:GetAttribute("TimeAccel") >= 200;
        end
    },
    Cooldown = {
        Name = "Godly Speed",
        AfterMove = true,
        Time = 3.5
    },

    Invoke = function(p37) -- Line: 1353, Name: Invoke
        -- upvalues: PathShortcuts (copy), Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

        if Character:GetAttribute("Mount") then
            return;
        end;

        local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
        local v38 = TagService:GetContainer(LocalPlayer);

        if v38 and TagService:Get(v38, "DisableInputs") then
            return;
        end;

        local v39 = Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v40 = Knit.GetService("MoveInputService");

        if v39.GetCooldown(Character, "Godly Speed") then
            return;
        end;

        v40:FireInput(p37.RawInput);
        local v41 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler).Get(Humanoid.Animator);

        if Knit.CollectionService:HasTag(Character, "Stunned") then
            return;
        end;

        v39.SetActive(Character, "Timeskip_Client", {
            Priority = v39.Enums.Active.Main
        });
        local v42 = RaycastParams.new();
        v42.FilterType = Enum.RaycastFilterType.Exclude;
        v42.FilterDescendantsInstances = { Character, workspace.Effects };
        local v43 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local v44 = workspace:Raycast(HumanoidRootPart.Position, v43 * 18, v42);
        local v45 = not (v44 and v44.Position) and 18 or (HumanoidRootPart.Position - v44.Position).Magnitude;
        local v46 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v43).LookVector.Unit * v45;
        game:GetService("TweenService"):Create(HumanoidRootPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            CFrame = v46
        }):Play();
        local v47 = HumanoidRootPart.CFrame:VectorToObjectSpace(v43);
        local v48 = math.atan2(v47.X, -v47.Z);
        local v49 = math.deg(v48) - 0.5;
        local v50 = math.ceil(v49);
        local v51 = v50 > 45 and v50 < 135 and "Right" or (v50 < -45 and v50 > -135 and "Left" or ((v50 <= -135 or v50 >= 135) and "Backward" or "Forward"));
        local v52;

        if v51 == "Forward" then
            Character:SetAttribute("AccelCounter", Character:GetAttribute("AccelCounter") == 2 and 1 or (Character:GetAttribute("AccelCounter") == 1 and 2 or 1));
            v52 = Character:GetAttribute("AccelCounter");
        else
            v52 = "";
        end;

        v41:PlayAnimation("" .. v51 .. "Accel" .. v52, 1.45);
        task.wait(0.25);
        v39.SetActive(Character, "Timeskip_Client", nil);
    end
};
v3.Stats["Time Accelerate"] = {
    Active = true,
    Amount = 25,
    Gain = 150,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Name = "Time Accelerate",
        Time = 0.25,
        AfterMove = true,
        Manual = true
    },
    Meter = {}
};
v3.Stats["Prime Numbers"] = {
    From = "Whitesnake.PrimeNumbers",
    Active = true,
    Actionable = {
        Active = true
    },
    PrimeNumbers = {}
};

return v3;
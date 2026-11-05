  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u2 (ref), PathShortcuts (copy), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u6 (ref), u7 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u3 = Knit.GetController("CombatController");
    u4 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = Knit.GetService("MoveInputService");
    u6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u7 = Knit.GetService("EffectService");
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/Misc/Light",
        LookAt = "Attacker"
    } };
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/Misc/Heavy",
        LookAt = "Attacker"
    } };
v1.Block = {
    From = "Combat.Block",
    CustomPrefix = "Rokushiki-"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
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
        Damage = 45,
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Active = true
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    NoEndlag = true,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 125459473960513,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 125459473960513,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 125459473960513,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.35,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 129157537243259,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p8, p9) -- Line: 182, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Count = p8.CharacterState["Rush Attack"].Count;
            local v10 = TableUtil.Copy(p8.Stats, true);
            local v11 = v10["LMB-" .. Count];
            v11.Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            };
            v11.Stun = {
                Time = 0.6
            };
            v11.ApplyPoison = true;

            return v10;
        end,

        PreAnim = function(p12) -- Line: 203, Name: PreAnim
            -- upvalues: ParticleHandler (copy)
            ParticleHandler.EnableVFX(p12.Character.Stand, true, { "Trail" });
        end,

        PostAnim = function(p13) -- Line: 208, Name: PostAnim
            -- upvalues: ParticleHandler (copy)
            ParticleHandler.EnableVFX(p13.Character.Stand, false, { "Trail" });
        end
    }
};
v1["Compound Eye Hexagon"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Barrage = {
        Frequency = 6,
        Damage = 1,
        ApplyPoison = true,
        Hitbox = {
            Size = Vector3.new(8, 8, 12.5),
            Offset = CFrame.new(0, 0, -5.7)
        },
        Stun = {
            Time = 0.7
        },
        HitSounds = {
            Hit = {
                SoundId = 139520746709357,
                Volume = 1
            }
        }
    },
    Lunge = {
        TravelDistance = 50,
        Damage = 25,
        ApplyPoison = true,
        Hitbox = {
            Size = Vector3.new(8, 8, 13),
            Offset = CFrame.new(0, 0, -5)
        },
        Stun = {
            Time = 1.5
        },
        HitSounds = {
            Hit = {
                SoundId = 113934135302325,
                Volume = 1
            }
        }
    }
};
v1["True Flutter"] = {
    Active = true,
    ApplyPoison = true,
    Damage = 15,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 10
    },
    Hitbox = {
        Size = Vector3.new(14, 14, 34)
    },
    HitSounds = {
        Hit = {
            SoundId = 113934135302325,
            Volume = 1
        }
    },
    Stun = {
        Time = 0.6
    },
    Burst = {
        Damage = 35,
        Hitbox = {
            Size = 17
        },
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 25, 0),
            Time = 0.13
        }
    }
};
v1["Hundred-Legged Zigzag"] = {
    Active = true,
    Damage = 2.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 25,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 45
    },
    Ragdoll = {
        Time = 1
    },
    Priority = EnumsModule.Intangible.Ragdoll,
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 25,
        Offset = CFrame.new(0, 0, -3)
    },
    HitSounds = {
        Hit = {
            SoundId = 74855823383740,
            Volume = 1
        }
    },
    Lunge = {
        ApplyPoison = true,
        Damage = 25,
        Priority = EnumsModule.Intangible.Ragdoll,
        Hitbox = {
            Size = Vector3.new(10, 10, 16),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 50,
            Time = 0.15,
            Velocity = Vector3.new(0, 22, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 129157537243259,
                Volume = 1
            }
        }
    }
};
v1.Caprice = {
    Active = true,
    ApplyPoison = true,
    Damage = 45,
    Speed = 60,
    Duration = 120,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Hitbox = {
        Size = 20
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 50,
        Time = 0.13,
        Velocity = Vector3.new(0, 35, 0)
    }
};
v1["Luminous Petal Bloom"] = {
    Active = true,
    ApplyPoison = true,
    Damage = 2.5,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 17.5,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Hitbox = {
        Size = 15,
        Offset = CFrame.new(0, -2.5, -14)
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 2,
        Time = 0.03
    },
    HitSounds = {
        Hit = {
            SoundId = 118051825474186,
            Volume = 1
        }
    }
};
v1["Mantis Slash"] = {
    Active = true,
    ApplyPoison = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 30
    },
    Hitbox = {
        Size = Vector3.new(15, 20, 15),
        Offset = CFrame.new(0, 7.5, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 2,
        Velocity = Vector3.new(0, 60, 0),
        Time = 0.1
    },
    Stun = {
        Time = 1.25
    },
    HitSounds = {
        Hit = {
            SoundId = 113051373279895,
            Volume = 1
        }
    }
};
v1.Fluorescence = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 12.5),
        Offset = CFrame.new(0, 0, -8)
    },
    Kick = {
        Damage = 1.5,
        Priority = EnumsModule.Intangible.Move
    },
    Slice = {
        Damage = 3,
        Priority = EnumsModule.Intangible.Move
    },
    Tornado = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Target",
            Time = 0.15,
            Speed = 0,
            Velocity = Vector3.new(0, 9, 0)
        },
        Stun = {
            Time = 0.25,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(50, 45, 50),
            Offset = CFrame.new(1.721, 19.462, -43.049)
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        }
    }
};
v1["Illusory Light"] = {
    Active = true,
    ApplyPoison = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Hitbox = {
        Size = 25
    },
    Stun = {
        Time = 1.75
    },
    HitSounds = {
        Hit = {
            SoundId = 70598798709132,
            Volume = 1
        }
    },
    Burst = {
        Damage = 7.5,
        Hitbox = {
            Size = 30
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 75,
            Time = 0.12,
            Velocity = Vector3.new(0, 44, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 123475841586315,
                Volume = 1
            }
        }
    }
};

return {
    Moveset = {
        Groups = {
            Universal = {
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Compound Eye Hexagon"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Let out a rapid barrage of thrusts before dashing forwards with your sword, dragging along anyone ahead of you."
            },
            ["True Flutter"] = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "Dash forwards swiftly to knock your enemy away."
            },
            ["Hundred-Legged Zigzag"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "Travel in a zigzag pattern dragging anyone along with you, before finishing off with a powerful strike."
            },
            ["Mantis Slash"] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "Launch yourself upwards and take anyone close enough with you."
            },
            Caprice = {
                DefaultKeybind = "Y",
                Equipped = true,
                Description = "Your character ascends to the sky, you appear as a butterfly and you are able to choose where to strike. You cannot take damage during this move and your movement speed is slightly increased."
            },
            ["Luminous Petal Bloom"] = {
                DefaultKeybind = "B",
                Equipped = true,
                Description = "Quickly fall back before creating afterimages, slashing wildly in quick succession at anyone unfortunate enough to be caught in this."
            },
            Fluorescence = {
                DefaultKeybind = "H",
                Equipped = true,
                Description = "Dash forwards and kick your opponent upwards to perform a powerful beatdown."
            },
            ["Illusory Light"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                Description = "Turn into a butterfly and begin attacking anyone caught within your viscinity."
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 135663478780744,
            PoseIdle = 117788046267036,
            ["LMB-1"] = 90540356171039,
            ["LMB-2"] = 127810857298443,
            ["LMB-3"] = 92832040654645,
            ["LMB-4"] = 84929851827031,
            ["Compound Eye Hexagon"] = 70772427889049,
            ["True Flutter"] = 85795548637615,
            ["Hundred-Legged Zigzag"] = 79303713132656,
            ["Mantis Slash"] = 82703457936324,
            ["Luminous Petal Bloom"] = 103269391295766,
            Afterimage = 99659355938961,
            ["Caprice Start"] = 125793242047114,
            ["Caprice End"] = 102558108264732,
            ["Caprice Visual"] = 105809100359487,
            ["Illusory Light Start"] = 85896508209384,
            ["Illusory Light End"] = 88516693313685,
            ["Illusory Light Butterfly"] = 84662615658595,
            ["Fluorescence Attacker"] = 117945040285897,
            ["Fluorescence Camera"] = 102652299758859,
            ["Fluorescence Victim"] = 131691505418738,
            ["Fluorescence Startup"] = 115602833010977
        },
        Movement = {
            Walk = 98696755836083,
            Run = 99987401164889
        },
        Idle = {
            Idle = 103049817457515
        }
    },
    Stats = v1,
    Sounds = {
        PoseMusic = {
            SoundId = 85559493234845,
            Volume = 1,
            Looped = true
        },
        MeterUp2 = {
            SoundId = 88929990216734,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 129136879516785,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 94353805448728,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 72166481856535,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 74126425736587,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 121692386141357,
            Volume = 1
        },
        ["Illusory Light SFX"] = {
            SoundId = 133866067822113,
            Volume = 1
        },
        ["Compound Eye Hexagon SFX"] = {
            SoundId = 131740259949008,
            Volume = 1
        },
        ["True Flutter SFX"] = {
            SoundId = 103005490663970,
            Volume = 1
        },
        ["Hundred-Legged Zigzag SFX"] = {
            SoundId = 80822679963069,
            Volume = 1
        },
        ["Caprice Startup SFX"] = {
            SoundId = 93220036961015,
            Volume = 1
        },
        ["Caprice User Loop SFX"] = {
            SoundId = 122222122492793,
            Volume = 0.75,
            Looped = true
        },
        ["Caprice Indicator Loop SFX"] = {
            SoundId = 113923909565666,
            Volume = 0.5,
            Looped = true
        },
        ["Caprice Launch SFX"] = {
            SoundId = 106439664914312,
            Volume = 1
        },
        ["Caprice Slam SFX"] = {
            SoundId = 82139201839036,
            Volume = 1
        },
        ["Luminous Petal Bloom SFX"] = {
            SoundId = 98995014960754,
            Volume = 1
        },
        ["Mantis Slash SFX"] = {
            SoundId = 70578939322012,
            Volume = 1
        },
        ["Fluorescence Grab SFX"] = {
            SoundId = 139039881298205,
            Volume = 1
        },
        ["Fluorescence Grab Music"] = {
            SoundId = 110623729069449,
            Volume = 1
        },
        ["Fluorescence Startup SFX"] = {
            SoundId = 80272058738559,
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
            Universal = {}
        }
    },
    Metadata = {
        PostRig = function(p14) -- Line: 890, Name: PostRig
            -- upvalues: u6 (ref), PathShortcuts (copy), u7 (ref), Knit (copy), Trove (copy), AssetHandler (copy), ParticleHandler (copy), RunService (copy), EnumsModule (copy)
            local Character = p14.Character;
            local Player = p14.Player;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player and Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            task.defer(function() -- Line: 898
                -- upvalues: u6 (ref), PathShortcuts (ref), u7 (ref), Knit (ref), Trove (ref), Character (copy), AssetHandler (ref), ParticleHandler (ref), RunService (ref), EnumsModule (ref)
                if not u6 then
                    u6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                end;

                if not u7 then
                    u7 = Knit.GetService("EffectService");
                end;

                local u15 = {};
                local u16 = Trove.new();
                u16:AttachToInstance(Character);
                u16:Connect(u6.Attacked, function(p17, p18) -- Line: 918
                    -- upvalues: Character (ref), u15 (copy), u16 (copy), AssetHandler (ref), ParticleHandler (ref), RunService (ref), u6 (ref), EnumsModule (ref), u7 (ref)
                    if p17 ~= "Outbound" or p18.Attacker ~= Character then
                        return;
                    end;

                    local Target = p18.Target;
                    local Stats = p18.Stats;

                    if Target and (Stats and (Stats.ApplyPoison and (p18.State.Success and p18.State.Continue))) then
                        if not u15[Target] then
                            u15[Target] = {
                                Potency = 0.1,
                                LastTick = os.clock()
                            };
                            local u19 = u16:Extend();
                            u19:AttachToInstance(Target);
                            local Highlight = Instance.new("Highlight");
                            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                            Highlight.FillColor = Color3.fromRGB(72, 125, 43);
                            Highlight.OutlineColor = Color3.fromRGB(92, 18, 202);
                            Highlight.OutlineTransparency = 1;
                            Highlight.FillTransparency = 0.5;
                            Highlight.Parent = Target;
                            local u20 = AssetHandler.CloneAsset("Particles/Misc/Poison", {
                                AbilityName = "Insect Breathing"
                            });
                            u20.Parent = Target;
                            ParticleHandler.AttachTo(u20, {
                                Part = Target.Torso
                            });
                            u19:Add(function() -- Line: 951
                                -- upvalues: u15 (ref), Target (copy), ParticleHandler (ref), u20 (copy), Highlight (copy)
                                u15[Target] = nil;
                                ParticleHandler.DestroyEmit(u20);
                                ParticleHandler.EnableAllParticles(u20, false);
                                local v21 = game.TweenService:Create(Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                    FillTransparency = 1,
                                    OutlineTransparency = 1
                                });
                                v21:Play();
                                v21.Completed:Connect(function() -- Line: 962
                                    -- upvalues: Highlight (ref)
                                    Highlight:Destroy();
                                end);
                            end);
                            u19:Connect(RunService.Heartbeat, function(p22) -- Line: 967
                                -- upvalues: Target (copy), u15 (ref), u19 (copy), Highlight (copy), u6 (ref), Character (ref), EnumsModule (ref)
                                if not Target or (not Target.Parent or (not u15[Target] or u15[Target].Potency <= 0)) then
                                    u19:Destroy();

                                    return;
                                end;

                                if os.clock() - u15[Target].LastTick >= 0.5 then
                                    u15[Target].LastTick = os.clock();
                                    local FillColor = Highlight.FillColor;
                                    local FillTransparency = Highlight.FillTransparency;
                                    Highlight.FillColor = Color3.fromRGB(116, 198, 86);
                                    Highlight.FillTransparency = 0.25;
                                    game.TweenService:Create(Highlight, TweenInfo.new(0.375, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                                        FillTransparency = FillTransparency,
                                        FillColor = FillColor
                                    }):Play();
                                    u6.Attack({
                                        Attacker = Character,
                                        Target = Target,
                                        Stats = {
                                            DamageIndicator = "InsectPoison",
                                            Damage = 5,
                                            IgnoreDamageScaling = true,
                                            Priority = EnumsModule.Intangible.Move,
                                            Block = {
                                                Blockable = false,
                                                PerfectBlockable = false,
                                                BypassCounter = true
                                            },
                                            Meter = {
                                                MeterGain = 0
                                            },
                                            HitSounds = {
                                                Hit = {
                                                    SoundId = 76999379238175,
                                                    Volume = 0.2
                                                }
                                            }
                                        }
                                    });
                                end;

                                local v23 = u15[Target];
                                v23.Potency = v23.Potency - 0.15384615384615385 * p22;
                                Highlight.OutlineTransparency = 1 - u15[Target].Potency;
                            end);
                            u15[Target].Trove = u19;
                        end;

                        local Trove2 = u15[Target].Trove;
                        local v24 = math.clamp((p18.Damage or 0) / 75, 0, 1);
                        local v25 = u15[Target];
                        v25.Potency = v25.Potency + v24;

                        if u15[Target].Potency >= 1 then
                            Trove2:Destroy();
                            u6.Attack({
                                Attacker = Character,
                                Target = Target,
                                Stats = {
                                    DamageIndicator = "InsectPoison",
                                    Damage = 25,
                                    IgnoreDamageScaling = true,
                                    Priority = EnumsModule.Intangible.Move,
                                    Block = {
                                        Blockable = false,
                                        PerfectBlockable = false,
                                        BypassCounter = true
                                    },
                                    Meter = {
                                        MeterGain = 0
                                    },
                                    HitSounds = {
                                        Hit = {
                                            SoundId = 122174699592035,
                                            Volume = 0.5
                                        }
                                    }
                                }
                            });
                            u7.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Misc/PoisonBurst",
                                Character = Character,
                                Origin = Target.HumanoidRootPart
                            });
                        end;
                    end;
                end);
            end);
        end
    }
};
  

 

local v1 = {};
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ClientModulesPath.TweenModule);
Knit.OnStart():await();
local u2 = Knit.GetService("AnimationService");
local u3 = Knit.GetService("TagService");
local u4 = Knit.GetService("EffectService");
local u5;

if game:GetService("RunService"):IsServer() then
    u5 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u5 = nil;
end;

v1.Summon = {
    From = "Combat.Summon",
    LeaveParts = { "StandHumanoidRootPart" },
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 246, 211)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 243, 183)) })
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 10, 15, "Attack" }, { 19, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11499501562,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 4" }, { 10, 15, "Attack" }, { 19, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 11499501218,
                Volume = 3
            }
        }
    }, BaseStatsModule.Stand_Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p6, p7) -- Line: 116, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p6.Stats;

            if not Knit.CollectionService:HasTag(p6.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1["Rush Attack"] = TableUtil.Reconcile(v1["Rush Attack"], BaseStatsModule["StandOff Rush Attack"]);
v1.Barrage = TableUtil.Reconcile({
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Hit = {
        HitSounds = {
            Hit = {
                SoundId = 10626812045,
                Volume = 3
            }
        }
    },
    Finisher = {
        HitSounds = {
            Hit = {
                SoundId = 10725853580,
                Volume = 2
            }
        }
    }
}, BaseStatsModule.Stand_Barrage);
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Grab = {
    From = "Combat.Grab",
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
v1.Pose = {
    From = "Combat.Pose"
};
v1["Heavy Punch"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(10, 10, 10),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true,
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 10983670277,
            Volume = 5
        }
    }
};
v1["Stand Jump"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    }
};
v1["Instant Dash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    }
};
v1["Time Erase"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    TimeErase = {
        Length = 8,
        Cooldown = {
            Name = "Time Erase",
            Time = 60
        }
    }
};
v1["Time Accelerate"] = {
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
    }
};
v1.Timestop = {
    Speed = 1.2,
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = true
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Sequence = { { 0, "PlayAnim", "Timestop" }, { 0, "CreateTag", "MaxWalkSpeed", 0 }, { 0, "CreateTag", "MaxJumpPower", 0 }, { 70, "Timestop" }, { 127, "End" } },
    Timestop = {
        Time = 60,
        Size = 700,
        StopSounds = { "Timestop SFX" },
        ResumeSounds = { "Timeresume SFX" }
    }
};
v1["Timestop Movement"] = {
    Time = 5,
    Actionable = {
        Timestopped = false
    }
};
v1["Return To Zero"] = {
    Active = true,
    IgnoreTimestop = true,
    Actionable = {
        Active = true,
        Timestopped = false
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Priority = EnumsModule.Intangible.PerfectBlock,
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true
    }
};
v1.Reversal = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = false,
        Ragdolled = false
    },
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Indicators = { {
            Group = "Universal",
            Name = "Reversal",
            InputText = "%s",
            ActiveName = "Reversal",
            CooldownName = "Reversal",
            Visible = true
        } }
};
v1["Destructive Combination"] = {
    Actionable = {
        Active = true,
        Summoned = true
    },
    Active = true,
    Cooldown = {
        Time = 0.25,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(6, 6, 7.5),
        Offset = CFrame.new(0, 0, -4)
    },
    Block = {
        Unblockable = true
    },
    Hit = {
        Damage = 1,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Heavy = {
        Damage = 18,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Head = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/HeadHit",
                        AutoSerialize = true,
                        LookAt = "Attacker"
                    } }
            } }
    },
    Finisher = {
        Priority = EnumsModule.Intangible.Move,
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        }
    }
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
            StandOff = {
                Visible = true,
                Priority = 2
            },
            StandOn = {
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
            Barrage = {
                DefaultKeybind = "E",
                State = "StandOn",
                Equipped = true,
                Description = ""
            },
            ["Heavy Punch"] = {
                DefaultKeybind = "R",
                State = "StandOn",
                Unlocked = true,
                Description = "Unleash a heavy blow in front of you."
            },
            Reversal = {
                DefaultKeybind = "Y",
                State = "Universal",
                Description = "Reverses targets around the user to a past position.\nIf the target is already stunned or ragdolled, their inactionability will be extended, allowing this to be used as a combo extender."
            },
            ["Return To Zero"] = {
                DefaultKeybind = "Y+",
                State = "Universal",
                Description = "Returns all targets around the user to a position in the past, stunning them and slowing them down heavily.Cancels various other moves, such as Time Stop and Time Erase.",
                LevelRequirement = 1
            },
            ["Stand Jump"] = {
                DefaultKeybind = "Z",
                State = "Universal",
                Equipped = true,
                Description = ""
            },
            ["Instant Dash"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Equipped = true,
                Description = ""
            },
            ["Destructive Combination"] = {
                DefaultKeybind = "T",
                State = "StandOn",
                LevelRequirement = 1,
                Description = ""
            },
            ["Time Erase"] = {
                DefaultKeybind = "H",
                State = "StandOn",
                Equipped = true,
                Description = ""
            },
            ["Time Accelerate"] = {
                DefaultKeybind = "B",
                State = "Universal",
                Equipped = true,
                Description = ""
            },
            Timestop = {
                DefaultKeybind = "G",
                State = "StandOn",
                Equipped = true,
                Description = "Stop time within a radius."
            },
            ["Timestop Movement"] = {
                DefaultKeybind = "G+",
                Description = "You can now move for 1-2 seconds in an existing timestop.",
                LevelRequirement = 1
            }
        }
    },
    Animations = {
        Action = {
            ReturnToZero = 13802915735,
            Beatdown_Startup = 11320522791,
            Beatdown_Camera = 11320552981,
            Beatdown_UserSuccessful = 11320555645,
            Beatdown_Target = 11320554701,
            LoveTrainStartup = 8675840017,
            ["LMB-1"] = 10618698480,
            ["LMB-2"] = 10618701589,
            ["LMB-3"] = 10618705069,
            ["LMB-4"] = 10618709770,
            ["StandOff-LMB-1"] = 12483102391,
            ["StandOff-LMB-2"] = 12483106270,
            ["StandOff-LMB-3"] = 12483107424,
            ["StandOff-LMB-4"] = 12483108580,
            StandBlock = 10808688837,
            StandBlockHit1 = 10808692075,
            StandBlockHit2 = 10808695355,
            StandBlockHit3 = 10808697696,
            StandBlockBreak = 10808701329,
            BarrageStartup = 10838298509,
            Barrage = 10838301380,
            BarrageFinisher = 10603516376,
            BarrageClashEnd = 10839831781,
            Grab = 10906128504,
            Throw = 10906131878,
            ThrowVictim = 10906132668,
            ["Stand Jump"] = 5889373753,
            Timestop = 17251516277,
            TimeErase = 11108625453,
            ["Heavy Punch"] = 11386536360
        },
        Movement = {
            Walk = 13070481387,
            SummonedWalk = 13070481387,
            Run = 13070480214,
            SummonedRun = 13070480214,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289
        },
        Idle = {
            Idle = 13070478617,
            SummonedIdle = 13070478617
        }
    },
    Sounds = {
        DialLevel1 = {
            SoundId = 13137418766,
            Volume = 2
        },
        DialLevel2 = {
            SoundId = 13137418904,
            Volume = 2
        },
        DialLevel3 = {
            SoundId = 13137419149,
            Volume = 2
        },
        DialLevel4 = {
            SoundId = 13137419356,
            Volume = 2
        },
        DialLevel5 = {
            SoundId = 13137419356,
            Volume = 2
        },
        TimeAccelPreloop = {
            SoundId = 13288864064,
            Volume = 1.5
        },
        TimeAccelLoop = {
            SoundId = 13288863759,
            Volume = 1.5,
            Looped = true
        },
        BeatdownAttempt = {
            SoundId = 11320643652,
            Volume = 2
        },
        Beatdown = {
            SoundId = 11320643845,
            Volume = 2
        },
        Reversal = {
            SoundId = 13803266381,
            Volume = 2
        },
        ReturnToZero = {
            SoundId = 13803267060,
            Volume = 2
        },
        ReturnToZeroVoiceline = {
            SoundId = 13803266515,
            Volume = 2
        },
        ["Timestop Second Voiceline"] = {
            SoundId = 17269822232,
            Volume = 1
        },
        ["Timestop Startup Voiceline"] = {
            SoundId = 17269822418,
            Volume = 1
        },
        ["Timestop Startup SFX"] = {
            SoundId = 17269822305,
            Volume = 1
        },
        ["Timestop SFX"] = {
            SoundId = 17269822500,
            Volume = 1
        },
        ["Timestop Alternative Startup Voiceline"] = {
            SoundId = 17269822587,
            Volume = 1
        },
        ["Timestop Alternative Second Voiceline"] = {
            SoundId = 13147270006,
            Volume = 1
        },
        ["Timeresume Voice"] = {
            SoundId = 13147263792,
            Volume = 1
        },
        ["Timeresume SFX"] = {
            SoundId = 13147267393,
            Volume = 1
        }
    },
    Metadata = {
        Hooks = {
            Mimicry_Copy = {
                CombatHook = "Attack",
                HookType = "Outbound",
                HookName = "CC_Mimicry",
                Priority = 99,

                HookFunction = function(p8) -- Line: 817, Name: HookFunction
                    -- upvalues: PathShortcuts (copy), Knit (copy)
                    local _ = p8.State;
                    local Attacker = p8.Attacker;
                    local Target = p8.Target;

                    if not p8.Damage then
                        return true;
                    end;

                    local v9 = p8.AttackerPlayer and p8.AttackerPlayer:FindFirstChild("Data") or p8.AttackerCharacter and p8.AttackerCharacter:FindFirstChild("Data");
                    local v10 = p8.TargetPlayer and p8.TargetPlayer:FindFirstChild("Data") or p8.TargetCharacter and p8.TargetCharacter:FindFirstChild("Data");

                    if not v9 then
                        return true;
                    end;

                    if v9.Ability.Value ~= 3701 then
                        return true;
                    end;

                    local v11 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                    local StandsModule = require(PathShortcuts.StandsModule);
                    local WhitelistHandler = require(game.ReplicatedStorage.ReplicatedModules.Handlers.WhitelistHandler);
                    local v12 = Knit.GetService("MoveService");

                    if p8.AttackerPlayer and not v12.IsMoveEquipped(p8.AttackerPlayer, "Mimicry") then
                        return true;
                    end;

                    if not Attacker:GetAttribute("MimicryDamage") then
                        Attacker:SetAttribute("MimicryDamage", 0);
                        Attacker:SetAttribute("MaxMimicryDamage", 30);
                    end;

                    if v10 then
                        v10 = v10.Ability.Value;
                    end;

                    if v10 ~= Attacker:GetAttribute("MimicryAbilityId") and (v10 ~= Attacker:GetAttribute("MimicryStoredId") and Attacker:GetAttribute("MimicryAbilityId") ~= nil) then
                        return true;
                    end;

                    if not (WhitelistHandler.IsAbilityIdCR(v10) or p8.AttackerPlayer and WhitelistHandler.IsUserWhitelistedForAbilityId(p8.AttackerPlayer.UserId, v10)) then
                        return true;
                    end;

                    if Attacker:GetAttribute("MimicryActive") then
                        return true;
                    end;

                    local v13 = Attacker:GetAttribute("MimicryDamage") + p8.Damage;
                    Attacker:SetAttribute("MimicryDamage", (math.clamp(v13, 0, Attacker:GetAttribute("MaxMimicryDamage"))));

                    if Attacker:GetAttribute("MimicryDamage") >= Attacker:GetAttribute("MaxMimicryDamage") and (v10 and (nil):CanCopy(Attacker, Target)) then
                        Attacker:SetAttribute("MimicryDamage", 0);

                        if Attacker:GetAttribute("MimicryAbilityId") == nil and Attacker:GetAttribute("MimicryStoredId") ~= v10 then
                            (nil):SetMimicryAbility(Attacker, v10);
                        end;

                        local v14;

                        if Attacker:GetAttribute("MimicryStoredId") == v10 and Attacker:GetAttribute("MimicryStoredAmount") < Attacker:GetAttribute("MimicryMax") then
                            (nil):AddStoredMimicry(Attacker, 1);
                            v14 = true;
                        else
                            v14 = false;
                        end;

                        if Attacker:GetAttribute("MimicryAbilityId") == v10 and Attacker:GetAttribute("MimicryAmount") < Attacker:GetAttribute("MimicryMax") then
                            (nil):AddMimicry(Attacker, 1);
                            v14 = true;
                        end;

                        if v14 and p8.AttackerPlayer then
                            Knit.Remotes.UIOutput:FireClient(p8.AttackerPlayer, "CreateMiddleNotification", {
                                NumericalContent = 1,
                                NumericalSuffix = "Mimicry Stack",
                                Verb = "Copied",
                                NumericalContentColor = Color3.fromRGB(255, 0, 200),
                                Subject = StandsModule[v10],
                                SubjectColor = Color3.fromRGB(255, 0, 200)
                            });
                            Knit.Remotes.Output:FireAllClients("FX", "HighlightObject", Attacker, {
                                OutlineTransparency = 0,
                                Lifetime = 1,
                                Tween = true,
                                DepthMode = Enum.HighlightDepthMode.Occluded,
                                FillColor = Color3.fromRGB(255, 0, 200),
                                OutlineColor = Color3.fromRGB(255, 0, 200)
                            });
                            v11.FetchSound(Attacker, "MimicryCopy"):Play();
                        end;
                    end;

                    return true;
                end
            }
        },

        PostRig = function(p15) -- Line: 916, Name: PostRig
            -- upvalues: u3 (copy), u2 (copy), u5 (ref), Knit (copy), EnumsModule (copy), Trove (copy), u4 (copy)
            local Character = p15.Character;
            local Player = p15.Player;
            local Trove2 = p15.Trove;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local Humanoid = Character:FindFirstChild("Humanoid");
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

            if not (Humanoid and HumanoidRootPart) then
                warn("Cannot find Humanoid or RootPart");

                return;
            end;

            local u16 = u3:GetContainer(Character);

            if not u16 then
                warn("Cannot find Tags");

                return;
            end;

            local u17 = u2.Get(Humanoid:FindFirstChildWhichIsA("Animator"));

            if not u17 then
                warn("Cannot find Animator");

                return;
            end;

            local u18 = u5.GetMiddleware("CombatService");
            local u19 = Knit.GetService("StatService").GetStatsInfo(Character);

            if p15.AbilityValue ~= 23 then
                u19:SetExternalStats("ArmorStats", nil);

                return;
            end;

            u19:SetExternalStats("ArmorStats", (u19.CreateStatsObject({
                Defense = 10,
                Health = 25
            })));
            Trove2:Add(function() -- Line: 961
                -- upvalues: u19 (copy), u18 (copy), Character (copy)
                u19:SetExternalStats("ArmorStats", nil);
                u18.AttackHook:Unhook("Inbound", "DKRebirth" .. Character.Name);
            end);

            if not Character:GetAttribute("DKRebirth") then
                u18.AttackHook:Hook("Inbound", "DKRebirth" .. Character.Name, 105, function(p20) -- Line: 967
                    -- upvalues: Character (copy), Humanoid (copy), u18 (copy), EnumsModule (ref), u19 (copy), Trove (ref), u3 (ref), u16 (copy), u17 (copy), u4 (ref), HumanoidRootPart (copy), Player (copy)
                    local Stats = p20.Stats;

                    if Character:GetAttribute("DKRebirth") then
                        return true;
                    end;

                    if p20.State.Halt then
                        return true;
                    end;

                    if p20.Target == Character and (Stats.Damage and Humanoid.Health - Stats.Damage < 1) then
                        p20.State.Halt = true;
                        p20.State.Continue = false;
                        u18.Interrupted:Fire(Character, {
                            Type = "Ragdoll"
                        });
                        local u21 = {
                            Damage = 25,
                            Priority = EnumsModule.Intangible.Ragdoll,
                            Hitbox = {
                                RelativePart = "HumanoidRootPart",
                                Size = 12,
                                Predict = false,
                                Offset = CFrame.new(0, 0, -6)
                            },
                            StatusEffects = { {
                                    ApplyTo = "Target",
                                    Name = "Burn",
                                    Damage = 0.5,
                                    Overrides = {
                                        Lifetime = 6,
                                        Rate = 0.25
                                    }
                                } },
                            HitSounds = {
                                Hit = {
                                    SoundId = 17191619985,
                                    Volume = 1
                                }
                            },
                            Block = {
                                Blockable = false,
                                BlockBreak = false,
                                Unblockable = true,
                                BypassCounter = true,
                                PerfectBlockable = false
                            },
                            Ragdoll = {
                                Time = 2
                            },
                            Knockback = {
                                RelativePart = "Attacker",
                                Speed = 20,
                                Time = 0.25,
                                Velocity = Vector3.new(0, 10, 0)
                            }
                        };
                        Character:SetAttribute("DKRebirth", true);
                        u19:SetExternalStats("ArmorStats", (u19.CreateStatsObject({
                            Attack = 50,
                            Special = 35,
                            Defense = 10
                        })));
                        Humanoid.MaxHealth = 200;
                        Humanoid:SetAttribute("BaseHealth", 200);
                        Humanoid.Health = 100;
                        task.spawn(function(...) -- Line: 1054
                            -- upvalues: Trove (ref), Character (ref), u18 (ref), u3 (ref), u16 (ref), u17 (ref), u4 (ref), HumanoidRootPart (ref), Player (ref), u21 (copy)
                            local u22 = Trove.new();
                            u22:AttachToInstance(Character);
                            local v28 = u22:Construct(u18.CreateSequence, Character, {
                                Name = "Rebirth",
                                Speed = 1,
                                SequenceV2 = true,
                                Frames = {
                                    { 0, function(p23) -- Line: 1065
                                            -- upvalues: u22 (copy), u3 (ref), u16 (ref), u18 (ref), Character (ref), u17 (ref)
                                            u22:Add(u3:Add(u16, "Intangible", u18.Enums.Intangible.Move));
                                            u22:Add(u3:Add(u16, "MaxWalkSpeed", 0));
                                            u22:Add(u3:Add(u16, "MaxJumpPower", 0));
                                            u22:Add(u3:Add(u16, "NoRotate"));
                                            u18.PlaySound(Character, "Rebirth");
                                            u17:PlayAnimation("Rebirth", p23:GetSpeed());
                                        end },
                                    { 32, function(p24) -- Line: 1075
                                            -- upvalues: u4 (ref), HumanoidRootPart (ref), Player (ref), Character (ref), u18 (ref), u21 (ref)
                                            u4.FireAllClients("DK Explosion", {
                                                Origin = HumanoidRootPart.CFrame,
                                                Object = HumanoidRootPart,
                                                Player = Player
                                            });
                                            local v25 = next;
                                            local v26, v27 = Character:GetDescendants();

                                            for _, v in v25, v26, v27 do
                                                if (v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail"))) and v.Name == "AbilityAura" then
                                                    v.Enabled = true;
                                                    v:SetAttribute("Awakened", true);
                                                end;
                                            end;

                                            for _, v in u18.Hitbox({
                                                Caster = Character,
                                                Stats = u21
                                            }) do
                                                u18.Attack({
                                                    Attacker = Character,
                                                    Target = v.Character,
                                                    Stats = u21
                                                });
                                            end;
                                        end },
                                    { 79, "End" }
                                }
                            });
                            v28:Play();

                            while v28:IsPlaying() do
                                task.wait(0.1);
                            end;

                            u22:Destroy();
                        end);

                        if Stats.Damage then
                            Stats.Damage = 0;
                        end;
                    end;

                    return true;
                end);
            end;
        end
    }
};
  

 

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
local u8 = nil;
Knit.OnStart():andThen(function() -- Line: 17
    -- upvalues: PathShortcuts (copy), u2 (ref), u6 (ref), Knit (copy), u8 (ref), u3 (ref), u4 (ref), u7 (ref), u5 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u6 = Knit.GetController("CombatController");
    u8 = Knit.GetService("MoveInputService");
    u3 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u4 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
    u7 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = require(PathShortcuts.ReplicatedModules.StatsHandler);
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u9 = os.clock();
local u10 = os.clock();
local u11 = 0;
local u12 = nil;
local v13 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Light",
            LookAt = "Attacker"
        } }
};
local v14 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Heavy",
            LookAt = "Attacker"
        } }
};
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
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",

    Invoke = function(p15) -- Line: 107, Name: Invoke
        -- upvalues: Knit (copy)
        local v16 = Knit.GetService("MoveInputService");
        local Character = game.Players.LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        Character:WaitForChild("HumanoidRootPart");
        local v17 = Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall;
        v16:FireInput(p15.RawInput, v17);
    end,

    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.4,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 0, "PlaySound", "LMB1-Voiceline" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 71381733831360,
                Volume = 1.5
            }
        },
        HitRemotes = { v13 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 90291810418922,
                Volume = 1.5
            }
        },
        HitRemotes = { v13 }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 71381733831360,
                Volume = 1.5
            }
        },
        HitRemotes = { v13 }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 78147049996803,
                Volume = 1.5
            }
        },
        HitRemotes = { v14 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p18, p19) -- Line: 219, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local v20 = Knit.GetService("EffectService");
            local Count = p18.CharacterState["Rush Attack"].Count;
            local Character = p18.Character;
            local v21 = TableUtil.Copy(p18.Stats, true);
            v20.FireAllClients("Rokushiki LMB", {
                Player = p18.Player,
                Character = Character,
                Count = Count,
                Speed = v21["LMB-" .. Count].Speed or (v21["LMB-1"].Speed or 1)
            });

            return v21;
        end,

        PostHit = function(p22, p23) -- Line: 239, Name: PostHit
            -- upvalues: Knit (copy), PathShortcuts (copy), Trove (copy)
            if not p22.Arguments[1] then
                return;
            end;

            local u24 = Knit.GetService("EffectService");
            local v25 = Knit.GetService("MoveService");
            local Timer = require(Knit.Util.Timer);
            local u26 = require(PathShortcuts.ReplicatedModules.EffectsFolder.Devs.Anime.General["Air Lock"]);

            local function AirLock(p27, p28) -- Line: 249
                -- upvalues: u24 (copy), u26 (copy)
                local v29 = game.Players:GetPlayerFromCharacter(p27);
                p28.Character = p27;

                if v29 then
                    u24.FireClient(v29, "Air Lock", p28);

                    return;
                end;

                u26(p28);
            end;

            local Stats = p22.Stats;
            local Character = p22.Character;
            local Player = p22.Player;
            local CharacterState = p22.CharacterState;
            local ValidHits = p23.ValidHits;

            if not ValidHits or #ValidHits <= 0 then
                return;
            end;

            if CharacterState.ResetTimer then
                CharacterState.ResetTimer:Disconnect();
                CharacterState.ResetTimer = nil;
            end;

            local function ResetTimer() -- Line: 275
                -- upvalues: CharacterState (copy), Timer (copy), Knit (ref)
                if not CharacterState.ResetTimer then
                    local AirLockTrove = CharacterState.AirLockTrove;
                    CharacterState.ResetTimer = AirLockTrove:Add((Timer.Simple(1.5, function() -- Line: 278
                        -- upvalues: AirLockTrove (copy)
                        if AirLockTrove and getmetatable(AirLockTrove) then
                            AirLockTrove:Destroy();
                        end;
                    end, false, Knit.RunService.Heartbeat, os.clock)));
                end;
            end;

            if not CharacterState.AirLockTrove then
                local u30 = Trove.new();
                u30:AttachToInstance(Character);

                local function CheckRagdoll(p31, p32) -- Line: 291
                    -- upvalues: CheckRagdoll (copy)
                    if p31.Ragdoll ~= nil == true then
                        return true;
                    end;

                    for _, v in p31 do
                        if type(v) == "table" and CheckRagdoll(v, p31) == true then
                            return true;
                        end;
                    end;

                    return false;
                end;

                u30:Connect(v25.Signal, function(p33, p34) -- Line: 309
                    -- upvalues: Player (copy), Stats (copy), u30 (copy), CharacterState (copy), ResetTimer (copy)
                    if p34.Player == Player and (p33 == "MoveCasted" and p34.MoveName ~= Stats.MoveName) then
                        if p34.MoveData.Stats.EndAirLock or p34.MoveName == "Pose" then
                            u30:Destroy();

                            return;
                        end;

                        if CharacterState.ResetTimer then
                            CharacterState.ResetTimer:Disconnect();
                            CharacterState.ResetTimer = nil;
                        end;

                        p34.MoveData.Trove:Add(ResetTimer);
                    end;
                end);
                local v35 = {
                    State = true
                };
                local v36 = game.Players:GetPlayerFromCharacter(Character);
                v35.Character = Character;

                if v36 then
                    u24.FireClient(v36, "Air Lock", v35);
                else
                    u26(v35);
                end;

                u30:Add(function() -- Line: 335
                    -- upvalues: CharacterState (copy), Character (copy), u24 (copy), u26 (copy)
                    CharacterState.AirLockTrove = nil;
                    local v37 = Character;
                    local v38 = {
                        State = false
                    };
                    local v39 = game.Players:GetPlayerFromCharacter(v37);
                    v38.Character = v37;

                    if v39 then
                        u24.FireClient(v39, "Air Lock", v38);

                        return;
                    end;

                    u26(v38);
                end);
                CharacterState.AirLockTrove = u30;
            end;

            ResetTimer();

            if CharacterState.AirLockTrove then
                for _, v in ValidHits do
                    local Character2 = v.Character;
                    local v40 = Character2;
                    local v41 = {
                        State = true,
                        Attacker = Character
                    };
                    local v42 = game.Players:GetPlayerFromCharacter(v40);
                    v41.Character = v40;

                    if v42 then
                        u24.FireClient(v42, "Air Lock", v41);
                    else
                        u26(v41);
                    end;

                    CharacterState.AirLockTrove:Add(function() -- Line: 353
                        -- upvalues: Character2 (ref), u24 (copy), u26 (copy)
                        local v43 = Character2;
                        local v44 = {
                            State = false
                        };
                        local v45 = game.Players:GetPlayerFromCharacter(v43);
                        v44.Character = v43;

                        if v45 then
                            u24.FireClient(v45, "Air Lock", v44);

                            return;
                        end;

                        u26(v44);
                    end);
                end;
            end;

            if CharacterState["Rush Attack"].Count == 4 and CharacterState.AirLockTrove then
                CharacterState.AirLockTrove:Destroy();
            end;
        end
    }
};
v1.Soru = {
    Active = true,
    Speed = 80,
    VanishTime = 0.33,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 2,
        AfterMove = true
    }
};
v1["Soru: Blink"] = {
    Active = true,
    MaxDistance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },

    Invoke = function(p46) -- Line: 396, Name: Invoke
        -- upvalues: u8 (ref)
        local LocalPlayer = game.Players.LocalPlayer;
        local v47 = LocalPlayer:GetMouse();
        u8:FireInput(p46.RawInput, LocalPlayer.Character.HumanoidRootPart.CFrame, v47.Hit);
    end
};
v1.Shigan = {
    EndAirLock = true,
    Active = true,
    Distance = 15,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 10),
        Offset = CFrame.new(0, 0, -4.5)
    },
    Block = {
        PerfectBlockable = true,
        BlockBreak = false
    },
    Ragdoll = {
        Time = 0.6
    },
    HitSounds = {
        Hit = {
            SoundId = 101286811986972,
            Volume = 1.5
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 40,
        Time = 0.07
    },
    HitRemotes = { v14 }
};
v1["Shigan Flurry"] = {
    Active = true,
    Frequency = 4,
    Damage = 2,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 0.2
    },
    HitSounds = {
        Hit = {
            SoundId = 80775503393016,
            Volume = 1.5
        }
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 6,
        Time = 0.1
    },
    HitRemotes = { v13 }
};
v1.Rankyaku = {
    Active = true,
    LevelRequirement = 30,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 20
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Projectile = {
        Damage = 25,
        Hitbox = {
            Size = Vector3.new(17, 10, 10)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Ragdoll = {
            Time = 0.5
        },
        HitSounds = {
            Hit = {
                SoundId = 135271237069875,
                Volume = 1.5
            }
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.15
        },
        HitRemotes = { v13 }
    }
};
v1["Dangan Kyaku"] = {
    EndAirLock = true,
    LevelRequirement = 15,
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 10
    },
    Cooldown = {
        Time = 12.5,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 9),
        Offset = CFrame.new(0, 0, -4.25)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = false
    },
    HitSounds = {
        Hit = {
            SoundId = 83143967642240,
            Volume = 1.5
        }
    },
    Stun = {
        Time = 1.2
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 1,
        Velocity = Vector3.new(0, 86, 0),
        Time = 0.2
    }
};
v1.Tekkai = {
    LevelRequirement = 40,
    Active = true,
    MaxBlockDMG = 1250,
    MeterLossRate = 1,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 5
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    }
};
v1.Rokuogan = {
    Active = true,
    LevelRequirement = 90,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 75
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 30),
        Offset = CFrame.new(0, 0, -15)
    },
    Block = {
        PerfectBlockable = false,
        BlockBreak = true,
        Blockable = true
    },
    Impact = {
        Damage = 60,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Character Rock Trail", {
                        State = true,
                        Duration = 2,
                        MinDistance = 3,
                        Attribute = "GomuRifleTargetRocks",
                        Character = "__Target"
                    } }
            } },
        Block = {
            PerfectBlockable = false,
            Blockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 90,
            Velocity = Vector3.new(0, 20, 0),
            Time = 0.75
        }
    }
};
v1.Geppo = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    ClientActionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Time = 0.3,
        Manual = true,
        CooldownReduction = false
    },

    Invoke = function(p48) -- Line: 723, Name: Invoke
        -- upvalues: u9 (ref), u10 (ref), u11 (ref), u3 (ref), Trove (copy), RunService (copy), u12 (ref), u4 (ref), u7 (ref), u8 (ref), u6 (ref)
        if os.clock() - u9 < 0.5 then
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;

            if os.clock() - u10 > 7 then
                u11 = 0;
            end;

            if Character.HumanoidRootPart:FindFirstChild("Air Lock") then
                return;
            end;

            local v49 = Character:GetAttribute("InCombat") and 2 or 7;

            if (LocalPlayer:GetAttribute("UnlimitedGeppos") and 1000000 or v49) <= u11 then
                return;
            end;

            local v50 = u3:GetContainer(LocalPlayer);

            if v50 and u3:Get(v50, "DisableInputs") then
                return;
            end;

            local v51 = Trove.new();
            u11 = u11 + 1;
            u10 = os.clock();
            local Humanoid = Character:WaitForChild("Humanoid");
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
            v51:Add(u3:Add(v50, "NoRotate"));
            local v52 = Humanoid.MoveDirection ~= Vector3.new(0, 0, 0);
            local u53 = v52 and Humanoid.MoveDirection or HumanoidRootPart.CFrame.LookVector;
            local v54 = u53 * (v52 and 60 or 0) + Vector3.new(0, 60 * (v52 and 0.5 or 1), 0);
            local v55 = v51:Construct(Instance, "Attachment");
            v55.Parent = HumanoidRootPart;
            local u56 = v51:Construct(Instance, "LinearVelocity");
            u56.RelativeTo = Enum.ActuatorRelativeTo.World;
            u56.Attachment0 = v55;
            u56.MaxForce = 1000000;
            u56.VectorVelocity = v54;
            u56.Parent = v55;
            v51:Connect(RunService.RenderStepped, function() -- Line: 771
                -- upvalues: HumanoidRootPart (copy), u53 (copy)
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + u53 * Vector3.new(1, 0, 1));
            end);

            if not u12 and Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                u12 = Humanoid.StateChanged:Connect(function(p57, p58) -- Line: 776
                    -- upvalues: u12 (ref), u11 (ref)
                    u12:Disconnect();
                    u12 = nil;
                    u11 = 0;
                end);
            end;

            task.spawn(u4.CallEffect, "Geppo", {
                Player = LocalPlayer,
                Character = Character,
                Velocity = v54
            });
            u7.Get(Humanoid.Animator):PlayAnimation("Geppo " .. (v52 and "Movement " or "Idle ") .. (u11 % 2 == 0 and 1 or 2));
            u8:FireInput(p48.RawInput, HumanoidRootPart.CFrame, v54);
            u6.SetActive(Character, "Geppo_Client", {
                Priority = u6.Enums.Active.Main
            });
            v51:Add(function() -- Line: 799
                -- upvalues: u6 (ref), Character (copy)
                u6.SetActive(Character, "Geppo_Client", nil);
            end);
            u4.Wait(0.2);
            v55:Destroy();
            u4.Wait(0.1);
            v51:Destroy();
            v51:Connect(u6.QuickstepInterrupted, function() -- Line: 811
                -- upvalues: u56 (copy)
                u56:Destroy();
            end);
        end;

        u9 = os.clock();
    end
};
v1.Tenraku = {
    EndAirLock = true,
    Active = true,
    LevelRequirement = 50,
    Armor = true,
    Damage = 25,
    Priority = EnumsModule.Intangible.Ragdoll,
    Actionable = {
        Active = true,

        Check = function(p59) -- Line: 825, Name: Check
            -- upvalues: u2 (ref)
            if u2.RaycastMap(p59.HumanoidRootPart.Position, Vector3.new(0, -0, 0)) == nil or p59:GetAttribute("Geppoing") then
                return u2.RaycastMap(p59.HumanoidRootPart.Position, Vector3.new(0, -75, 0)) ~= nil;
            end;

            return false;
        end
    },
    Meter = {
        RequiredAmount = 30
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Hitbox = {
        Size = 30
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },
    Ragdoll = {
        Time = 0.5
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
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
            Soru = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Soru: Blink"] = {
                DefaultKeybind = "V",
                LevelRequirement = 15
            },
            ["Shigan Flurry"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            Shigan = {
                DefaultKeybind = "R",
                Equipped = true
            },
            Rankyaku = {
                DefaultKeybind = "T",
                LevelRequirement = 30
            },
            ["Dangan Kyaku"] = {
                DefaultKeybind = "Y",
                LevelRequirement = 45
            },
            Tekkai = {
                DefaultKeybind = "Q",
                LevelRequirement = 60
            },
            Rokuogan = {
                DefaultKeybind = "G",
                LevelRequirement = 75
            },
            Geppo = {
                DefaultKeybind = "Space",
                Equipped = true,
                IndicatorInfo = {
                    Input = "^^"
                }
            },
            Tenraku = {
                DefaultKeybind = "B",
                Equipped = true,
                LevelRequirement = 90,
                IndicatorInfo = {
                    Input = "%s^"
                }
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
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 89430071190711,
            PoseIdle = 90872547944395,
            ["Rokushiki-Block"] = 115379077231478,
            ["Rokushiki-BlockHit1"] = 115379077231478,
            ["Rokushiki-BlockBreak"] = 12499357071,
            ["StandOff-Grab"] = 73093760194577,
            ["StandOff-Throw"] = 138929214254191,
            ["StandOff-ThrowVictim"] = 83947659063949,
            ["LMB-1"] = 130829313529863,
            ["LMB-2"] = 73688242165228,
            ["LMB-3"] = 118957323788001,
            ["LMB-4"] = 99298706423013,
            Shigan = 138924611320389,
            Flurry = 79442340120176,
            ["Tekkai Start"] = 116437231226221,
            ["Tekkai Loop"] = 103749154594316,
            ["Dangan Kyaku"] = 130819550126522,
            Tenraku = 89354601824902,
            Rankyaku = 108334305577780,
            ["Rokugan Startup"] = 123150688659511,
            ["Rokugan Camera"] = 117339537396340,
            ["Rokugan Attacker"] = 83600202093784,
            ["Rokugan Victim"] = 71380156354633,
            ["Geppo Idle 1"] = 76772115004590,
            ["Geppo Idle 2"] = 107521893228210,
            ["Geppo Movement 1"] = 136892605741793,
            ["Geppo Movement 2"] = 127655117013443
        },
        Movement = {
            Walk = 139446621618606,
            Run = 100574633999858
        },
        Idle = {
            Idle = 100570376250073
        }
    },
    Stats = v1,
    Sounds = {
        MeterUp2 = {
            SoundId = 89202652887220,
            Volume = 2,
            PlaybackSpeed = 1
        },
        MeterUp4 = {
            SoundId = 96703931743353,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 98017258409169,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 125331756063407,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 140400718585524,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 138124359456710,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 70652622654835,
            Volume = 1
        },
        ["Soru Start"] = {
            SoundId = 105257198777350,
            Volume = 1
        },
        ["Soru End"] = {
            SoundId = 130067222760176,
            Volume = 1
        },
        ["Soru Blink"] = {
            SoundId = 73534332952136,
            Volume = 1
        },
        ["Dangan Kyaku"] = {
            SoundId = 128710143753179,
            Volume = 1
        },
        Rankyaku = {
            SoundId = 122716797621950,
            Volume = 1
        },
        ["Shigan Flurry"] = {
            SoundId = 115791183063316,
            Volume = 1
        },
        Shigan = {
            SoundId = 114994970138018,
            Volume = 1
        },
        Tekkai = {
            SoundId = 95008644319217,
            Volume = 1
        },
        Rokugan = {
            SoundId = 129798026173676,
            Volume = 1
        },
        ["Rokugan Startup"] = {
            SoundId = 137051593852440,
            Volume = 1
        },
        ["Tenraku Impact"] = {
            SoundId = 96719405899943,
            Volume = 1
        },
        Tenraku = {
            SoundId = 71994857242196,
            Volume = 1
        },
        Geppo = {
            SoundId = 111381188156084,
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
    }
};
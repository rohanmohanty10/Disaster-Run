  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets["Gold Experience Requiem"];
local u1;

if game:GetService("RunService"):IsServer() then
    local v2 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Cursed Child", true);
    u1 = require(v2.Common);
else
    u1 = nil;
end;

local v11 = {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            User = {
                Visible = true,
                Priority = 1
            },
            Rika = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),
    Metadata = {
        Hooks = {
            Mimicry_Copy = {
                CombatHook = "Attack",
                HookType = "Outbound",
                HookName = "CC_Mimicry",
                Priority = 99,

                HookFunction = function(p3) -- Line: 75, Name: HookFunction
                    -- upvalues: PathShortcuts (copy), Knit (copy), u1 (ref)
                    local _ = p3.State;
                    local Attacker = p3.Attacker;
                    local Target = p3.Target;

                    if not p3.Damage then
                        return true;
                    end;

                    local v4 = p3.AttackerPlayer and p3.AttackerPlayer:FindFirstChild("Data") or p3.AttackerCharacter and p3.AttackerCharacter:FindFirstChild("Data");
                    local v5 = p3.TargetPlayer and p3.TargetPlayer:FindFirstChild("Data") or p3.TargetCharacter and p3.TargetCharacter:FindFirstChild("Data");

                    if not v4 then
                        return true;
                    end;

                    if v4.Ability.Value ~= 3701 then
                        return true;
                    end;

                    local v6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
                    local StandsModule = require(PathShortcuts.StandsModule);
                    local WhitelistHandler = require(game.ReplicatedStorage.ReplicatedModules.Handlers.WhitelistHandler);
                    local v7 = Knit.GetService("MoveService");

                    if p3.AttackerPlayer and not v7.IsMoveEquipped(p3.AttackerPlayer, "Mimicry") then
                        return true;
                    end;

                    if not Attacker:GetAttribute("MimicryDamage") then
                        Attacker:SetAttribute("MimicryDamage", 0);
                        Attacker:SetAttribute("MaxMimicryDamage", 30);
                    end;

                    if v5 then
                        v5 = v5.Ability.Value;
                    end;

                    if v5 ~= Attacker:GetAttribute("MimicryAbilityId") and (v5 ~= Attacker:GetAttribute("MimicryStoredId") and Attacker:GetAttribute("MimicryAbilityId") ~= nil) then
                        return true;
                    end;

                    if not (WhitelistHandler.IsAbilityIdCR(v5) or p3.AttackerPlayer and WhitelistHandler.IsUserWhitelistedForAbilityId(p3.AttackerPlayer.UserId, v5)) then
                        return true;
                    end;

                    if Attacker:GetAttribute("MimicryActive") then
                        return true;
                    end;

                    local v8 = Attacker:GetAttribute("MimicryDamage") + p3.Damage;
                    Attacker:SetAttribute("MimicryDamage", (math.clamp(v8, 0, Attacker:GetAttribute("MaxMimicryDamage"))));

                    if Attacker:GetAttribute("MimicryDamage") >= Attacker:GetAttribute("MaxMimicryDamage") and (v5 and u1:CanCopy(Attacker, Target)) then
                        Attacker:SetAttribute("MimicryDamage", 0);

                        if Attacker:GetAttribute("MimicryAbilityId") == nil and Attacker:GetAttribute("MimicryStoredId") ~= v5 then
                            u1:SetMimicryAbility(Attacker, v5);
                        end;

                        local v9;

                        if Attacker:GetAttribute("MimicryStoredId") == v5 and Attacker:GetAttribute("MimicryStoredAmount") < Attacker:GetAttribute("MimicryMax") then
                            u1:AddStoredMimicry(Attacker, 1);
                            v9 = true;
                        else
                            v9 = false;
                        end;

                        if Attacker:GetAttribute("MimicryAbilityId") == v5 and Attacker:GetAttribute("MimicryAmount") < Attacker:GetAttribute("MimicryMax") then
                            u1:AddMimicry(Attacker, 1);
                            v9 = true;
                        end;

                        if v9 and p3.AttackerPlayer then
                            Knit.Remotes.UIOutput:FireClient(p3.AttackerPlayer, "CreateMiddleNotification", {
                                NumericalContent = 1,
                                NumericalSuffix = "Mimicry Stack",
                                Verb = "Copied",
                                NumericalContentColor = Color3.fromRGB(255, 0, 200),
                                Subject = StandsModule[v5],
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
                            v6.FetchSound(Attacker, "MimicryCopy"):Play();
                        end;
                    end;

                    return true;
                end
            }
        },

        PostRig = function(p10) -- Line: 174, Name: PostRig
            local PrimaryPart = p10.Character:FindFirstChild("_Rika").PrimaryPart;

            for _, descendant in pairs(p10.Character.Stand:GetDescendants()) do
                if descendant:IsA("Sound") and string.sub(descendant.Name, 1, 4) == "Rika" then
                    descendant:Clone().Parent = PrimaryPart;
                end;
            end;
        end
    }
};
local v12 = { "Rush Attack", "Rush Attack Endlag", "Bladework Rush", "Pummel", "Feint Slash", "Execution", "Batter", "Smash", "Cursed Blast", "Thin Ice Breaker", "Cursed Speech", "Grapple", "Mimicry" };
local v13 = { "Rika", "Cleave", "Strike", "Slam", "Rampage" };
local v14 = table.clone(v13);
table.insert(v14, "Rush Attack Endlag");
v11.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false,
        Active = {
            Ignore = v14
        }
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ActiveEndlag = 0.2,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 11, function(p15, p16, p17, p18) -- Line: 245
                    -- upvalues: u1 (ref)
                    u1:SlashEffect({
                        MoveData = p17,
                        Offset = CFrame.new(0, 0, 0) * CFrame.Angles(-0.17453292519943295, 0, -3.0543261909900767)
                    });
                end },
            { 13, 20, "Attack" },
            { 24, "End" }
        },
        Stun = {
            Time = 0.6
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 8, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitRemotes = { v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_Katana_LMB_1 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 8, function(p19, p20, p21, p22) -- Line: 282
                    -- upvalues: u1 (ref)
                    u1:SlashEffect({
                        MoveData = p21,
                        Offset = CFrame.new(-0, 0, 0) * CFrame.Angles(-0.08587019919812101, 0.015184364492350668, -0.2611012560983517)
                    });
                end },
            { 8, 12, "Attack" },
            { 15, "End" }
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(11, 8, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitSounds = { v11.Resources.SFX_Katana_LMB_2 }
    },
    ["LMB-3"] = {
        Speed = 1.35,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 18, function(p23, p24, p25, p26) -- Line: 311
                    -- upvalues: u1 (ref)
                    u1:SlashEffect({
                        MoveData = p25,
                        Offset = CFrame.new(-0, -0, 0) * CFrame.Angles(-0.08726646259971647, 0, 0.6108652381980153)
                    });
                end },
            { 20, 24, "Attack" },
            { 30, "End" }
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(9, 10, 9),
            Debug = false,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitSounds = { v11.Resources.SFX_Katana_LMB_3 }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.25,
        ActiveEndlag = 0.2,
        Sequence = {
            { 0, "Start" },
            { 16, 20, "Attack" },
            { 19, function(p27, p28, p29, p30) -- Line: 341
                    -- upvalues: Knit (copy)
                    local Character = p29.Character;
                    Knit.GetService("EffectService").FireAllClients("Emit Particle V3", {
                        Path = "Particles/RushAttack/Kick",
                        AutoSerialize = true,
                        AttachTo = {
                            Part = Character:FindFirstChild("Left Leg"),
                            Offset = CFrame.identity
                        },
                        Player = p29.Player,
                        Character = p29.Character,
                        AbilityName = p29.AbilityName,
                        SkinName = p29.SkinName
                    });
                end },
            { 24, "End" }
        },
        HitRemotes = { v11.Resources.HeavyHit },
        HitSounds = { v11.Resources.SFX_Katana_LMB_4 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    ["SteelArm-LMB-1"] = TableUtil.Reconcile({
        Speed = 1,
        ActiveEndlag = 0.2,
        Sequence = { { 0, "Start" }, { 11, 15, "Attack" }, { 22, "End" } },
        Stun = {
            Time = 0.6
        },
        HitRemotes = { v11.Resources.LightHit },
        HitSounds = { v11.Resources.SFX_SteelArm_LMB_1 }
    }, BaseStatsModule.Rush_Attack),
    ["SteelArm-LMB-2"] = {
        Speed = 1,
        ActiveEndlag = 0.2,
        Sequence = { { 0, "Start" }, { 11, 15, "Attack" }, { 22, "End" } },
        HitSounds = { v11.Resources.SFX_SteelArm_LMB_2 }
    },
    ["SteelArm-LMB-3"] = {
        Speed = 1,
        ActiveEndlag = 0.2,
        Sequence = { { 0, "Start" }, { 11, 15, "Attack" }, { 22, "End" } },
        HitSounds = { v11.Resources.SFX_SteelArm_LMB_3 }
    },
    ["SteelArm-LMB-4"] = TableUtil.Reconcile({
        Speed = 1.15,
        ActiveEndlag = 0.2,
        Sequence = { { 0, "Start" }, { 14, 19, "Attack" }, { 28, "End" } },
        HitRemotes = { v11.Resources.HeavyHit },
        HitSounds = { v11.Resources.SFX_SteelArm_LMB_4 }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p31, p32) -- Line: 447, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Stats = p31.Stats;

            if p31.Character:GetAttribute("Weapon") == "SteelArm" then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "SteelArm-LMB";
            end;

            return Stats;
        end
    }
};
v11.Stats.Block = {
    From = "Combat.Block",
    Callbacks = {
        OnBlock = function(p33, p34) -- Line: 463, Name: OnBlock
            -- upvalues: PathShortcuts (copy), Knit (copy), u1 (ref)
            local v35 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
            local InputListener = require(PathShortcuts.ReplicatedModules.Independent.InputListener);
            local v36 = Knit.GetService("MoveService");
            local Player = p33.Player;
            local Character = p33.Character;
            local _ = p33.Input;
            local Block = v35.GetCharacterState(Character).Block;
            local CustomKeybindMap = require(game.ReplicatedStorage.ReplicatedModules.CustomKeybindMap);
            local v37 = v36.GetPlayerMovesInfo(Player);
            local v38 = v37 and v37.EquippedMoves.Mimicry and v37.EquippedMoves.Mimicry.k;
            local u39 = v38 and CustomKeybindMap.InversedKeybindsMap[v38] or "V";
            Block.Trove:Construct(InputListener, Player, u39).ListenToInput:Connect(function(p40) -- Line: 485
                -- upvalues: u39 (copy), u1 (ref), Character (copy)
                if p40:upper() == u39 then
                    u1:SwapMimicryAbility(Character);

                    return;
                end;

                if p40 == "Z" then
                    u1:SetMimicryAbility(Character, nil);
                    Character:SetAttribute("MimicryAmount", 0);
                end;
            end);
        end
    }
};
v11.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v11.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p41) -- Line: 504, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v42 = TableUtil.Copy(p41.Stats, true);

            if p41.Character:GetAttribute("Weapon") == "SteelArm" then
                v42.PoseMusic = "SteelArmPoseMusic";
                v42.StartAnim = "SteelArmPoseTransition";
                v42.LoopAnim = "SteelArmPose";
            end;

            return v42;
        end
    }
};
v11.Stats.Grab = {
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
v11.Stats.Switch = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    }
};
v11.Stats["Queen of Curses"] = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false
    }
};
v11.Stats["Bladework Rush"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "E",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Slash1 = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_BladeworkRush_1 }
    },
    Slash2 = {
        Damage = 10,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_BladeworkRush_2 }
    },
    Finisher = {
        Damage = 15,
        Stun = {
            Time = 1.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -6)
        },
        HitRemotes = { v11.Resources.HeavyHit, v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_BladeworkRush_3 },
        HitAnimations = { 10046328617 }
    }
};
v11.Stats["Feint Slash"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "R",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Slash = {
        Damage = 25,
        HitAnimations = "Default",
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_FeintSlash_1 }
    },
    Kick = {
        Damage = 20,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1.25
        },
        Stun = {
            Time = 0.1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = true,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v11.Resources.HeavyHit },
        HitSounds = { v11.Resources.SFX_FeintSlash_2 }
    }
};
v11.Stats.Execution = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "R",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Startup = {
        Grab = true,
        Damage = 15,
        MinHealth = 1,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 10),
            Predict = false,
            Offset = CFrame.new(0, 0, -5)
        },
        HitRemotes = { v11.Resources.BloodHit }
    },
    Withdraw = {
        Damage = 15,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Kick = {
        Damage = 10,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 120,
        TrueDamage = true,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    FinisherRelease = {
        Damage = 10,
        TrueDamage = true,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 150,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats["Cursed Blast"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "T",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Blast = {
        Damage = 35,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 12, 12),
            EndSize = Vector3.new(16, 48, 12),
            Predict = false,
            Offset = CFrame.new(0, -3, -6),
            EndOffset = CFrame.new(0, 21, -48)
        },
        HitRemotes = { v11.Resources.LightHit }
    }
};
v11.Stats["Cursed Speech"] = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "Y",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Speech = {
        CheckPVPSafe = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 16, 24),
            Offset = CFrame.new(0, 0, -12)
        },
        HitSounds = { v11.Resources.SFX_CursedSpeech }
    },
    Effect = {
        Damage = 40,
        TrueDamage = true,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            Speed = 20,
            Velocity = Vector3.new(0, -48, 0),
            Time = 0.1,
            MaxForce = Vector3.new(1000000, 1000000, 1000000)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            Unblockable = true,
            BypassCounter = true
        },
        HitRemotes = { v11.Resources.HeavyHit }
    }
};
v11.Stats.Extermination = {
    Active = true,
    Indicators = { {
            Group = "Katana",
            Input = "G",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 4
    },
    Startup = {
        Grab = true,
        CheckPVPSafe = true,
        MinHealth = 1,
        Meter = false,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.BloodHit }
    },
    Kick = {
        Damage = 20,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slash = {
        Damage = 30,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slam = {
        Damage = 25,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 36,
            Velocity = Vector3.new(0, -64, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    FinisherRelease = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats["Domain Expansion"] = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Input = "H",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = true
    }
};
v11.Stats.Batter = {
    Active = true,
    Indicators = { {
            Group = "SteelArm",
            Input = "R",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Kick = {
        Damage = 2.413793103448276,
        HitAnimations = "Default",
        Stun = {
            Time = 0.85
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.LightHit },
        HitSounds = { v11.Resources.SFX_Batter_1 }
    },
    Finisher = {
        Damage = 10,
        HitAnimations = "Default",
        Ragdoll = {
            Time = 1.25
        },
        Stun = {
            Time = 0.1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Predict = false,
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.HeavyHit },
        HitSounds = { v11.Resources.SFX_Batter_2 }
    }
};
v11.Stats.Smash = {
    Active = true,
    Indicators = { {
            Group = "SteelArm",
            Input = "R",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
        MinHealth = 1,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.LightHit }
    },
    Smash = {
        Damage = 20,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 5,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Velocity = Vector3.new(0, 32, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats["Thin Ice Breaker"] = {
    Active = true,
    Indicators = { {
            Group = "SteelArm",
            Input = "T",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 16,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Break = {
        Damage = 45,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Velocity = Vector3.new(0, 32, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            EndSize = Vector3.new(5, 5, 8),
            Offset = CFrame.new(0, 0, -5),
            EndOffset = CFrame.new(0, 0, -14)
        },
        HitRemotes = { v11.Resources.LightHit },
        HitSounds = { v11.Resources.SFX_ThinIceBreaker }
    }
};
v11.Stats.Grapple = {
    Active = true,
    Indicators = { {
            Group = "SteelArm",
            Input = "Y",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Countered = {
        Grab = true,
        MinHealth = 1,
        Stun = {
            Time = 1.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.LightHit }
    },
    Kick = {
        Damage = 20,
        MinHealth = 1,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.LightHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 15,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -72,
            Velocity = Vector3.new(0, 0, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats["Black Flash"] = {
    Active = true,
    Indicators = { {
            Group = "SteelArm",
            Input = "R",
            InputText = "%s+",
            Priority = 1,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },
    Cooldown = {
        Time = 30,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 3
    },
    Startup = {
        Grab = true,
        CheckPVPSafe = true,
        MinHealth = 1,
        Meter = false,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { v11.Resources.LightHit }
    },
    SlowPunch = {
        Damage = 0.6666666666666666,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Drag = {
        Damage = 1,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finisher = {
        Damage = 30,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Release = {
        Damage = 10,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 2.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -96,
            Velocity = Vector3.new(0, 8, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats.Cleave = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "E",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v12
        }
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Cleave1 = {
        Damage = 25,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.25
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 32,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 12, 24),
            Offset = CFrame.new(0, 0, -12)
        },
        HitRemotes = { v11.Resources.HeavyHit, v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_Cleave_1 }
    },
    Cleave2 = {
        Damage = 25,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 12, 24),
            Offset = CFrame.new(0, 0, -12)
        },
        HitRemotes = { v11.Resources.HeavyHit, v11.Resources.BloodHit },
        HitSounds = { v11.Resources.SFX_Cleave_2 }
    }
};
v11.Stats.Strike = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "R",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Strike = {
        Damage = 60,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 96,
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockBreak = false,
            PerfectBlockBreak = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 12, 32),
            Offset = CFrame.new(0, 0, -16)
        },
        HitRemotes = { v11.Resources.HeavyHit },
        HitSounds = { v11.Resources.SFX_Strike }
    }
};
v11.Stats.Slam = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "T",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v12
        }
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Slam = {
        Damage = 45,
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Ragdoll = {
            Time = 2.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 72,
            Velocity = Vector3.new(0, 48, 0),
            Time = 0.1
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(16, 12, 12),
            EndSize = Vector3.new(28, 22, 12),
            Predict = false,
            Offset = CFrame.new(0, 0, -12),
            EndOffset = CFrame.new(0, 0, -64)
        },
        HitRemotes = { v11.Resources.LightHit }
    }
};
v11.Stats.Grab = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "Y",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v12
        }
    }
};
v11.Stats.Rampage = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "G",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v12
        }
    },
    Cooldown = {
        Time = 24,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 2
    },
    Startup = {
        CheckPVPSafe = true,
        Grab = true,
        MinHealth = 1,
        Meter = false,
        Stun = {
            Time = 0.75
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockCancel = false
        },
        Hitbox = {
            RelativePart = "RootPart",
            Size = Vector3.new(12, 12, 16),
            Predict = false,
            Offset = CFrame.new(0, 0, -8)
        }
    },
    Slam = {
        Damage = 10,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Slash = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.LightHit, v11.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v11.Resources.SFX_Rampage_1 }
    },
    Finisher = {
        Damage = 20,
        MinHealth = 1,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        HitRemotes = { v11.Resources.HeavyHit, v11.Resources.BloodHit },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitSounds = { v11.Resources.SFX_Rampage_2 }
    },
    Release = {
        Damage = 5,
        Meter = false,
        Priority = EnumsModule.Intangible.Move,
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Velocity = Vector3.new(0, -52, 0),
            Time = 0.1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    }
};
v11.Stats["Sacrificial Love"] = {
    Active = true,
    Indicators = { {
            Group = "Rika",
            Input = "H",
            InputText = "%s",
            Priority = 0,
            Visible = true
        } },
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredLevel = 4,
        RemoveMeter = true
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Beam = {
        Damage = 0.4444444444444444,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1.5
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(32, 32, 128),
            Predict = false,
            Offset = CFrame.new(0, 0, -64)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 24,
            Time = 0.1
        }
    },
    End = {
        Damage = 30,
        HitAnimations = "Default",
        Meter = false,
        Priority = EnumsModule.Intangible.Ragdoll,
        Stun = {
            Time = 1.5
        },
        Ragdoll = {
            Time = 2.5
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(32, 32, 128),
            Predict = false,
            Offset = CFrame.new(0, 0, -64)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BypassCounter = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 100,
            Velocity = Vector3.new(0, 24, 0),
            Time = 0.1
        }
    }
};
v11.Stats.Mimicry = {
    Active = true,
    Indicators = { {
            Group = "Universal",
            Input = "V",
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v13
        }
    },

    Invoke = function(p43) -- Line: 192, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p43.Input;
        local v44 = Knit.GetController("MoveInputController");
        local v45 = Knit.GetService("MoveInputService");
        local v46 = os.clock();
        local v47 = false;

        while v44.Inputs[Input] do
            if os.clock() - v46 >= 0.2 then
                v47 = true;
                break;
            end;

            task.wait();
        end;

        v45:FireInput(p43.RawInput, v47);
    end,

    Cooldown = {
        Time = 12,
        Name = "Mimicry",
        AfterMove = true,
        Manual = true
    }
};
v11.Stats["Reverse Cursed Technique"] = {
    Indicators = { {
            Group = "Universal",
            Input = "B",
            Visible = true
        } },
    Actionable = {
        Active = {
            Ignore = v12
        }
    }
};

for i, v in pairs({
    ["Execution / Smash"] = {}
}) do
    local v48 = string.split(i, " / ");
    local v49 = v11.Stats[v[1] or v48[1]];
    local v50 = v11.Stats[v[2] or v48[2]];

    if v49 then
        if v49.Cooldown then
            v49.Cooldown.Name = i;
        end;

        if v49.Actionable then
            v49.Actionable.Active = false;
        end;

        v49.Active = false;
    end;

    if v50 then
        if v50.Cooldown then
            v50.Cooldown.Name = i;
        end;

        if v50.Actionable then
            v50.Actionable.Active = false;
        end;

        v50.Active = false;
    end;

    v11.Stats[i] = {
        Active = true,
        Actionable = {
            Active = true
        }
    };
end;

return v11;
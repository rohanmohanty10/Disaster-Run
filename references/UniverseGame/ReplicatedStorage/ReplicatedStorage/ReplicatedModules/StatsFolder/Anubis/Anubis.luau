  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
game:GetService("CollectionService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 25
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Light",
            LookAt = "Attacker"
        } }
};
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Heavy",
            LookAt = "Attacker"
        } }
};
local v4 = {
    SoundId = 14291752644,
    Volume = 1
};
local v5 = {
    SoundId = 14291752920,
    Volume = 1.5
};
local v6 = {
    SoundId = 14291752793,
    Volume = 0.5
};

local function CreateIndicator(p7) -- Line: 76
    local v8 = p7 or {};

    return {
        Group = v8.Group or "Universal",
        Name = v8.Name,
        DisplayName = v8.DisplayName or v8.Name,
        CooldownName = v8.CooldownName or v8.Name,
        ActiveName = v8.ActiveName or v8.Name,
        InputText = v8.InputText or "%s",
        Visible = v8.Visible or true
    };
end;

local function CreateMultiIndicator(p9) -- Line: 90
    local v10 = {};

    for i, v in pairs(p9) do
        if i ~= "Overrides" then
            table.insert(v10, {
                InputText = "%s",
                Visible = true,
                Group = i,
                Name = v,
                DisplayName = v,
                CooldownName = v,
                ActiveName = v
            });
        end;
    end;

    if p9.Overrides then
        for _, v in ipairs(v10) do
            for i, v7 in pairs(p9.Overrides) do
                v[i] = v7;
            end;
        end;
    end;

    return v10;
end;

return {
    Moveset = {
        DefaultMoveState = "Universal",
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
            Quickstep = {
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
            ["Achilles Strike"] = {
                DefaultKeybind = "Q",
                Unlocked = true,
                Description = "Perform a quick slash, slicing anyone in front of you and send out a projectile which pierces multiple foes."
            },
            ["Cursed Descent"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Slam your blade onto the ground and create a powerful impact."
            },
            ["Accursed Laceration"] = {
                DefaultKeybind = "R",
                LevelRequirement = 75,
                Description = "Wind up a powerful slash, sending you forwards and slicing any foes in your way."
            },
            ["Soul Severance"] = {
                DefaultKeybind = "T",
                LevelRequirement = 25,
                Description = "Powerful slash that cripples any foes around you."
            },
            Shadowstrike = {
                DefaultKeybind = "Y",
                LevelRequirement = 50,
                Description = "Perform a barrage of slashes followed by a powerful slice."
            },
            ["Phantom Finisher"] = {
                DefaultKeybind = "G",
                LevelRequirement = 110,
                Description = "Initiate a powerful beatdown where you violently slash through your opponent if hit."
            },
            Flash = {
                DefaultKeybind = "V",
                LevelRequirement = 10,
                Description = "Quickly teleport forwards in the direction you\'re moving."
            },
            ["Hexed Strength"] = {
                DefaultKeybind = "H",
                LevelRequirement = 85,
                Description = "Awaken, increasing your attack speed slightly and making you inflict a curse after every sword strike which will lower defense and attack of your target. Stacking the curse resets its timer (3 seconds)"
            },
            ["Cursed Command"] = {
                DefaultKeybind = "Z",
                LevelRequirement = 60,
                Description = "Strike a target, inflicting a hex that drives your foe into slashing themselves."
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 14014247149,
            ["LMB-2"] = 14014248368,
            ["LMB-3"] = 14014249420,
            ["LMB-4"] = 14014250618,
            ["Cursed Descent"] = 14319771787,
            ["Accursed Laceration"] = 14303492824,
            ["Accursed Laceration Finish"] = 14303691248,
            ["Soul Severance"] = 14317715334,
            ["Achilles Strike"] = 14320231468,
            Shadowstrike = 14336566731,
            ["Phantom Finisher"] = 14489110680,
            ["Phantom Finisher Target"] = 14489112363,
            ["Phantom Finisher Success"] = 14489116040,
            ["Phantom Finisher Camera"] = 14489118608,
            Flash = 16988129175,
            CommandAttempt = 16988133193,
            CommandUser = 16988135366,
            CommandVictim = 16988137492,
            PoseIdle = 16975731682,
            PoseTransition = 16975735124,
            Awakening = 16975728007
        },
        Movement = {
            Walk = 14012944935,
            Run = 14012943311
        },
        Idle = {
            Idle = 14012942262
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 14337980164,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 14337980432,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 14337980271,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 14337979999,
            Volume = 1
        },
        ["Cursed Descent"] = {
            SoundId = 14338021613,
            Volume = 1
        },
        ["Accursed Laceration"] = {
            SoundId = 14307244370,
            Volume = 1
        },
        Slam = {
            SoundId = 14338029133,
            Volume = 1
        },
        ["Soul Severance"] = {
            SoundId = 14329966634,
            Volume = 1
        },
        Shadowstrike = {
            SoundId = 14338021822,
            Volume = 1
        },
        ["Phantom Finisher"] = {
            SoundId = 14512881493,
            Volume = 1
        },
        ["Phantom Finisher Success"] = {
            SoundId = 14512881720,
            Volume = 1
        },
        ["Achilles Strike"] = {
            SoundId = 15105832612,
            Volume = 1
        },
        Flash = {
            SoundId = 16752732518,
            Volume = 1
        },
        Awakening = {
            SoundId = 17014214701,
            Volume = 1
        },
        AwakeningVoice = {
            SoundId = 17014208461,
            Volume = 1
        },
        AwakeningAmbience = {
            SoundId = 17014209631,
            Volume = 1
        },
        Command = {
            SoundId = 17014215059,
            Volume = 1
        },
        CommandSuccess = {
            SoundId = 17014210078,
            Volume = 1
        },
        CommandSuccessVoice = {
            SoundId = 17014216074,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 17014342069,
            Volume = 1.3,
            Looped = true
        }
    },
    Stats = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {},
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 8, function(p11, p12, p13, p14) -- Line: 140
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Anubis_Slash", {
                                Time = 0.25,
                                Size = Vector3.new(6.5, 20, 6.5),
                                SurfaceDirection = "Bottom",
                                Origin = p13.RootPart,
                                Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                                EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                                Color = Color3.fromRGB(182, 139, 255),
                                Character = p13.Character
                            });
                        end },
                    { 14, function(p15, p16, p17, p18) -- Line: 152
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Slash",
                                Origin = p17.RootPart,
                                Offset = CFrame.new(0, 0, -6.5),
                                Player = p17.Player,
                                Character = p17.Character
                            });
                        end },
                    { 14, 19, "Attack" }
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v4
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 8, function(p19, p20, p21, p22) -- Line: 177
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Anubis_Slash", {
                                Time = 0.25,
                                Size = Vector3.new(6.5, 20, 6.5),
                                SurfaceDirection = "Bottom",
                                Origin = p21.RootPart,
                                Offset = CFrame.Angles(0, -1.5707963267948966, 3.141592653589793),
                                EndCFrame = CFrame.Angles(0, -2.443460952792061, 0),
                                Color = Color3.fromRGB(182, 139, 255),
                                Character = p21.Character
                            });
                        end },
                    { 14, function(p23, p24, p25, p26) -- Line: 189
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Slash",
                                Origin = p25.RootPart,
                                Offset = CFrame.new(0, 0, -6.5),
                                Player = p25.Player,
                                Character = p25.Character
                            });
                        end },
                    { 14, 19, "Attack" }
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v4
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Sequence = {
                    { 0, "Start" },
                    { 2, function(p27, p28, p29, p30) -- Line: 214
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Anubis_Slashes", p29.Player, {
                                Duration = 0.4 / p27:GetSpeed()
                            });
                        end },
                    { 4, "Attack", {
                            Multiple = true
                        } },
                    { 6, "Attack", {
                            Multiple = true
                        } },
                    { 8, "Attack", {
                            Multiple = true
                        } },
                    { 10, "Attack", {
                            Multiple = true
                        } },
                    { 12, "Attack", {
                            Multiple = true
                        } },
                    { 14, "Attack", {
                            Multiple = true
                        } },
                    { 16, "Attack", {
                            Multiple = true
                        } },
                    { 18, "Attack", {
                            Multiple = true
                        } },
                    { 24, "End" }
                },
                Damage = BaseStatsModule.Rush_Attack.Damage / 8,
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v6
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.5,
                Sequence = {
                    { 0, "Start" },
                    { 8, function(p31, p32, p33, p34) -- Line: 264
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Anubis_Slash", {
                                Time = 0.25,
                                Size = Vector3.new(6.5, 20, 6.5),
                                SurfaceDirection = "Bottom",
                                Origin = p33.RootPart,
                                Offset = CFrame.Angles(0, 1.5707963267948966, 0),
                                EndCFrame = CFrame.Angles(0, -2.9670597283903604, 0),
                                Color = Color3.fromRGB(182, 139, 255),
                                Character = p33.Character
                            });
                        end },
                    { 18, function(p35, p36, p37, p38) -- Line: 276
                            -- upvalues: u1 (ref)
                            u1.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Slash",
                                Origin = p37.RootPart,
                                Offset = CFrame.new(0, 0, -6.5),
                                Player = p37.Player,
                                Character = p37.Character
                            });
                        end },
                    { 18, 22, "Attack" },
                    { 26, "End" }
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = v5
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p39, p40) -- Line: 301, Name: PreAnim
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Aura", {
                        Value = true,
                        AbilityModel = p39.AbilityModel
                    });
                    local v41 = p39.Character:FindFirstChild("LMB-" .. p39.CharacterState["Rush Attack"].Count .. " Voiceline", true);

                    if v41 then
                        v41:Play();
                    end;
                end,

                PostAnim = function(p42, p43) -- Line: 315, Name: PostAnim
                    -- upvalues: u1 (ref)
                    u1.FireAllClients("Anubis_Aura", {
                        Value = false,
                        AbilityModel = p42.AbilityModel
                    });
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
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
        ["Cursed Descent"] = {
            Active = true,
            Damage = 25,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Cooldown = {
                Time = 8
            },
            Hitbox = {
                Size = 12.5,
                Type = "Magnitude",
                Offset = CFrame.new(0, 0, -7)
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false
            },
            Ragdoll = {
                Time = 1.5
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 45,
                Time = 0.15,
                Velocity = Vector3.new(0, 25, 0)
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = v5
            }
        },
        ["Accursed Laceration"] = {
            Active = true,
            Damage = 35,
            HitAnimations = "Default",
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Cooldown = {
                Time = 20
            },
            Hitbox = {
                Size = Vector3.new(15, 15, 50),
                Offset = CFrame.new(0, 0, -25)
            },
            Ragdoll = {
                Time = 1.5
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 75,
                Time = 0.15,
                Velocity = Vector3.new(0, 35, 0)
            },
            HitSounds = {
                Hit = {
                    SoundId = 14307244612,
                    Volume = 1
                }
            }
        },
        ["Soul Severance"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Cooldown = {
                Time = 15
            },
            Hitbox = {
                Size = 12
            },
            Block = {
                PerfectBlockable = true
            },
            Stun = {
                Time = 0.6
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 60,
                Time = 0.15
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = v5
            }
        },
        ["Achilles Strike"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Meter = {
                RequiredLevel = 1
            },
            Cooldown = {
                Time = 8
            },
            Hitbox = {
                Size = Vector3.new(15, 15, 15),
                Offset = CFrame.new(0, 0, -7.5)
            },
            Block = {
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 10,
                Time = 0.15
            },
            HitRemotes = { v3 },
            Stun = {
                Time = 0.5
            },
            HitSounds = {
                Hit = {
                    SoundId = 15105832421,
                    Volume = 1
                }
            },
            Projectile = {
                Damage = 20,
                HitAnimations = "Default",
                Hitbox = {
                    Size = Vector3.new(10, 10, 10),
                    Offset = CFrame.new(0, 0, 0)
                },
                Block = {
                    PerfectBlockable = false
                },
                Stun = {
                    Time = 0.4
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 10,
                    Time = 0.15
                },
                HitRemotes = { v3 },
                HitSounds = {
                    Hit = v6
                }
            }
        },
        Shadowstrike = {
            Frequency = 2,
            Actionable = {
                Active = true
            },
            Active = true,
            Indicators = { (CreateIndicator()) },
            Cooldown = {
                Time = 10
            },
            Hitbox = {
                Size = Vector3.new(15, 15, 15),
                Offset = CFrame.new(0, 0, -7.5)
            },
            Damage = 10,
            Stun = {
                Time = 1
            },
            HitRemotes = { v3 },
            HitSounds = {
                Hit = v5
            },
            HitAnimations = "Default",
            Hit = {
                Damage = 2.5,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.5
                },
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = v6
                }
            }
        },
        ["Phantom Finisher"] = {
            Frequency = 2,
            Actionable = {
                Active = true
            },
            Active = true,
            CheckPVPSafe = true,
            Indicators = { (CreateIndicator()) },
            Meter = {
                RequiredLevel = 3
            },
            Cooldown = {
                Time = 60
            },
            Hitbox = {
                Size = Vector3.new(15, 15, 15),
                Offset = CFrame.new(0, 0, -7.5)
            },
            Damage = 15,
            MinHealth = 1,
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Stun = {
                Time = 1
            },
            HitRemotes = { v3 },
            First = {
                MinHealth = 1,
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v3 }
            },
            Second = {
                Damage = 65,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v3 }
            },
            Last = {
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                Ragdoll = {
                    Time = 2
                }
            }
        },
        Flash = {
            Distance = 25,
            Active = true,
            Actionable = {
                Active = true
            },
            ClientActionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Cooldown = {
                Time = 8
            },

            Invoke = function(p44) -- Line: 779, Name: Invoke
                -- upvalues: Knit (copy)
                local _ = p44.Input;
                local Character = game.Players.LocalPlayer.Character;
                local Stats = p44.Stats;
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                Knit.GetController("CombatController");
                Knit.GetController("MoveInputController");
                local v45 = Knit.GetService("MoveInputService");

                if Knit.CollectionService:HasTag(Character, "Timestopped") then
                    return;
                end;

                local v46 = RaycastParams.new();
                v46.FilterType = Enum.RaycastFilterType.Exclude;
                v46.FilterDescendantsInstances = { Character, workspace.Effects };
                local v47 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
                local Distance = Stats.Distance;
                local v48 = workspace:Raycast(HumanoidRootPart.Position, v47 * Distance, v46);

                if v48 then
                    Distance = (HumanoidRootPart.Position - v48.Position).Magnitude;
                end;

                local _ = HumanoidRootPart.CFrame;
                local u49 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v47).LookVector.Unit * Distance;
                task.delay(0.2, function() -- Line: 811
                    -- upvalues: HumanoidRootPart (copy), u49 (copy)
                    HumanoidRootPart.CFrame = u49;
                end);
                v45:FireInput(p44.RawInput, HumanoidRootPart.CFrame, u49);
                task.wait(0.25);
            end
        },
        ["Hexed Strength"] = {
            Duration = 25,
            Active = true,
            Actionable = {
                Active = true,

                Check = function(p50) -- Line: 826, Name: Check
                    return not p50:GetAttribute("Awakened");
                end
            },
            Indicators = { (CreateIndicator()) },
            Meter = {
                RequiredLevel = 1
            },
            Cooldown = {
                Time = 30,
                Manual = true
            }
        },
        ["Cursed Command"] = {
            Active = true,
            Actionable = {
                Active = true
            },
            Indicators = { (CreateIndicator()) },
            Properties = {
                Armor = true
            },
            Meter = {
                RequiredLevel = 2
            },
            Cooldown = {
                Time = 24
            },
            Attempt = {
                Damage = 20,
                Hitbox = {
                    Size = Vector3.new(9, 9, 11),
                    Offset = CFrame.new(0, 0, -6)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/BloodBlowStab",
                                LookAt = "Target"
                            } }
                    } },
                HitSounds = {
                    Hit = v5
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = true
                }
            },
            Kick = {
                Damage = 10,
                Priority = Enums.Intangible.Move,
                HitRemotes = { v2 },
                HitSounds = {
                    Hit = {
                        SoundId = 17014215713,
                        Volume = 1
                    }
                }
            },
            Slash = {
                Damage = 35,
                Priority = Enums.Intangible.Move,
                Ragdoll = {
                    Time = 1.2
                }
            }
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseEnd = function(p51, p52) -- Line: 927, Name: PoseEnd
                    local _ = p51.Stats;
                    local _ = p51.Player;
                    local _ = p51.Character;

                    for _, descendant in p51.AbilityModel.Sheath:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            descendant.Transparency = 0;
                        end;
                    end;
                end,

                PoseTransition = function(p53, p54) -- Line: 940, Name: PoseTransition
                    local _ = p53.Stats;
                    local _ = p53.Player;
                    local _ = p53.Character;

                    for _, descendant in p53.AbilityModel.Sheath:GetDescendants() do
                        if descendant:IsA("BasePart") then
                            descendant.Transparency = 1;
                        end;
                    end;
                end
            }
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
                    SoundId = "rbxassetid://16863401278",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I will take your life."
                        } }
                }, {
                    SoundId = "rbxassetid://16863401502",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "My name is Anubis."
                        } }
                }, {
                    SoundId = "rbxassetid://16863401652",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m stronger than anyone else! I can cut through anything!"
                        } }
                } }
        }
    }
};
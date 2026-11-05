  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local _ = workspace.CurrentCamera;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
require(ReplicatedModules.Animations);
require(ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);

return {
    GOKU_R = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Sequence = { { 0, "Start" }, { 0, "PlaySound", "SwingLMB 1-3" }, { 20, "Attack" }, { 24, "End" } },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "LightHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 6706979361,
                        Volume = 3
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        EMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Kiai",
                    CooldownName = "Kiai",
                    ActiveName = "EMoves",
                    Visible = true
                } },
            Kiai = {
                Damage = 25,
                Active = true,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        RMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Meteor Strike",
                    CooldownName = "Meteor Strike",
                    ActiveName = "RMoves",
                    Visible = true
                } },
            ["Meteor Strike"] = {
                Damage = 25,
                Active = true,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        TMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Ki Blast",
                    CooldownName = "Ki Blast",
                    ActiveName = "TMoves",
                    Visible = true
                } },
            ["Ki Blast"] = {
                Damage = 25,
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Active = true,
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                },
                Projectile = {
                    Damage = 15,
                    Distance = 5,
                    HitAnimations = "Default",
                    HitRemotes = { {
                            Name = "Output",
                            Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                        } },
                    HitData = {
                        Type = "HeavyHit"
                    }
                }
            }
        },
        YMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Solar Flare",
                    CooldownName = "Solar Flare",
                    ActiveName = "YMoves",
                    Visible = true
                } },
            ["Solar Flare"] = {
                Damage = 25,
                Active = true,
                HitAnimations = "Default",
                Stun = {
                    Time = 0.65
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(25, 25, 25),
                    Debug = true,
                    Offset = CFrame.new()
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        GMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Destructo Disc",
                    CooldownName = "Destructo Disc",
                    ActiveName = "GMoves",
                    Visible = true
                } },
            ["Destructo Disc"] = {
                Damage = 25,
                Stun = {
                    Time = 0.4
                },
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Active = true,
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 75,
                    Time = 0.15
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                },
                Projectile = {
                    Damage = 15,
                    Distance = 5,
                    HitAnimations = "Default",
                    HitRemotes = { {
                            Name = "Output",
                            Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                        } },
                    HitData = {
                        Type = "HeavyHit"
                    }
                }
            }
        },
        BMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Base",
                    Name = "Senzu Bean",
                    CooldownName = "Senzu Bean",
                    ActiveName = "BMoves",
                    Visible = true
                } },
            ["Senzu Bean"] = {
                Heal = 35,
                Active = true,
                Actionable = {
                    Stunned = true,
                    Active = true,
                    Disabled = true
                },
                Cooldown = {
                    Time = 1,
                    AfterMove = true
                },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(7.5, 7.5, 15),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -8)
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "GokuHitEffect", "__Legacy" }
                    } },
                HitData = {
                    Type = "HeavyHit"
                },
                HitSounds = {
                    Hit = {
                        SoundId = 7509595032,
                        Volume = 0.8
                    }
                }
            }
        },
        ["Instant Transmission"] = {
            Active = true,
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
            ClientActionable = {
                Stunned = true,
                Active = true,
                Disabled = true,
                Summoned = false
            },
            Cooldown = {
                Time = 8,
                AfterMove = true
            },

            Invoke = function(p1) -- Line: 566, Name: Invoke
                -- upvalues: Players (copy), Knit (copy)
                local Input = p1.Input;
                local Character = Players.LocalPlayer.Character;
                local Humanoid = Character:WaitForChild("Humanoid");
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
                local v2 = Knit.GetController("CombatController");
                Knit.GetController("MoveInputController");
                local v3 = Knit.GetService("MoveInputService");

                if Knit.CollectionService:HasTag(Character, "Timestopped") then
                    return;
                end;

                v3:FireInput(Input);
                v2.SetActive(Character, "Timeskip_Client", {
                    Priority = v2.Enums.Active.Main
                });
                local v4 = RaycastParams.new();
                v4.FilterType = Enum.RaycastFilterType.Blacklist;
                v4.FilterDescendantsInstances = { Character, workspace.Effects };
                local v5 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
                local v6 = 18;
                local v7 = workspace:Raycast(HumanoidRootPart.Position, v5 * v6, v4);

                if v7 then
                    v6 = (HumanoidRootPart.Position - v7.Position).Magnitude;
                end;

                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v5).LookVector.Unit * v6;
                task.wait(0.25);
                v2.SetActive(Character, "Timeskip_Client", nil);
            end
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Grab = {
            From = "Combat.Grab",
            Actionable = {
                Summoned = true
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
        }
    }
};
  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
Knit.OnStart():andThen(function() -- Line: 15
    -- upvalues: u2 (ref), PathShortcuts (copy), u3 (ref), Knit (copy), u4 (ref), u5 (ref), u6 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u3 = Knit.GetController("CombatController");
    u4 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = Knit.GetService("MoveInputService");
    u6 = Knit.GetService("EffectService");
end);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
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
    From = "Combat.Pose",
    AlternativeThemes = { "PoseMusic Layer" }
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
        Speed = 1,
        Sequence = {
            { 0, "Start" },
            { 13, function(p7, p8, p9) -- Line: 119
                    -- upvalues: u6 (ref), Knit (copy), ParticleHandler (copy)
                    if not u6 then
                        u6 = Knit.GetService("EffectService");
                    end;

                    u6.FireAllClients("Trainee LMB Slash", p9);
                    local Stand = p9.Character:FindFirstChild("Stand");

                    if Stand then
                        ParticleHandler.EnableVFX(Stand, true, { "Trail" });
                        p9.Trove:Add(function() -- Line: 129
                            -- upvalues: Stand (copy), ParticleHandler (ref)
                            if Stand and Stand:IsDescendantOf(game) then
                                ParticleHandler.EnableVFX(Stand, false, { "Trail" });
                            end;
                        end);
                    end;
                end },
            { 17, 26, "Attack" },
            { 36, "End" }
        },
        HitSounds = {
            Hit = {
                SoundId = 111517347225903,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        HitSounds = {
            Hit = {
                SoundId = 111517347225903,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        HitSounds = {
            Hit = {
                SoundId = 111517347225903,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1,
        HitSounds = {
            Hit = {
                SoundId = 126206085753212,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p10, p11) -- Line: 182, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Count = p10.CharacterState["Rush Attack"].Count;
            local v12 = TableUtil.Copy(p10.Stats, true);
            local v13 = v12["LMB-" .. Count];
            v13.Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            };
            v13.Stun = {
                Time = 0.6
            };

            return v12;
        end
    }
};
v1["Slice n Dice"] = {
    Active = true,
    Damage = 4,
    Stun = 0.5,
    Ticks = 10,
    Interval = 0.1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(7, 14, 14)
    },
    HitSounds = {
        Hit = {
            SoundId = 74364376454520,
            Volume = 0.5
        }
    }
};
v1["Perilous Thrust"] = {
    Active = true,
    Armor = true,
    Damage = 35,
    TravelDistance = 40,
    Priority = EnumsModule.Intangible.Move,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(8, 8, 11),
        Offset = CFrame.new(0, 0, -3)
    },
    HitSounds = {
        Hit = {
            SoundId = 109424874143651,
            Volume = 1
        }
    }
};
v1["Overhead Strike"] = {
    Active = true,
    Armor = true,
    Damage = 40,
    Stun = 0.75,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(13, 10, 13),
        Offset = CFrame.new(0, 0, -5)
    },
    HitSounds = {
        Hit = {
            SoundId = 119338829072286,
            Volume = 1
        }
    }
};
v1["Whirlwind Slash"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = 15
    },
    First = {
        Damage = 15,
        Stun = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Attacker",
            Speed = 15,
            Time = 0.03
        },
        HitSounds = {
            Hit = {
                SoundId = 85179667596550,
                Volume = 1
            }
        }
    },
    Last = {
        Damage = 25,
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 40,
            Time = 0.1,
            Velocity = Vector3.new(0, 25, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 96436426043339,
                Volume = 1
            }
        }
    }
};
v1.Prance = {
    Active = true,
    Damage = 25,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Ragdolled = true,
        Summoned = false
    },
    ClientActionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Hitbox = {
        Size = 15
    },
    Ragdoll = {
        Time = 1
    },
    Cooldown = {
        Time = 25,
        Manual = true
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.1,
        Velocity = Vector3.new(0, 40, 0)
    },

    Invoke = function(u14) -- Line: 390, Name: Invoke
        -- upvalues: Knit (copy), u2 (ref), u4 (ref), Trove (copy)
        local v15 = Knit.GetController("CombatController");
        local v16 = Knit.GetController("PilotController");
        local u17 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        u2:GetContainer(LocalPlayer);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u18 = u4.Get(Humanoid.Animator);
        local ActivePilot = v16.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        LocalPlayer.Data.Ability:GetAttribute("AbilityName");

        if Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) or not HumanoidRootPart.CFrame.LookVector then
            local _ = Humanoid.MoveDirection;
        end;

        u17:FireInput(u14.RawInput, "Release");

        local function Lerp(p19, p20, p21) -- Line: 422
            return p19 + (p20 - p19) * p21;
        end;

        local v22 = Trove.new();
        local v23 = v22:Construct(Instance.new, "BodyVelocity");
        v23.Velocity = HumanoidRootPart.CFrame.LookVector * 37 + Vector3.new(0, 105, 0);
        v23.MaxForce = Vector3.new(1000000, 1000000, 1000000);
        v23.Parent = HumanoidRootPart;
        local u24 = u18:PlayAnimation("Prance", 1.4);
        local u25 = false;
        task.delay(0.30952380952380953, function() -- Line: 442
            -- upvalues: u25 (ref), u24 (copy)
            if not u25 then
                u24:AdjustSpeed(0);
            end;
        end);
        v22:Add(v15.QuickstepInterrupted:Connect(function() -- Line: 448
            -- upvalues: u17 (copy), u14 (copy), u25 (ref), u18 (copy)
            u17:FireInput(u14.RawInput, "Cancel", nil);
            u25 = true;
            u18:StopAnimation("Prance", 0.9);
        end));
        local v26 = RaycastParams.new();
        v26.FilterType = Enum.RaycastFilterType.Include;
        v26.FilterDescendantsInstances = { workspace.Map };
        local v27 = os.clock();
        local v28 = nil;

        while not u25 and os.clock() - v27 <= 10 do
            task.wait();
            local v29 = os.clock() - v27;
            local v30 = v29 >= 0.30952380952380953 and workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -5, 0), v26);

            if v30 then
                v28 = {
                    Normal = v30.Normal,
                    Position = v30.Position,
                    RootLookVector = HumanoidRootPart.CFrame.LookVector
                };
                break;
            end;

            v23.Velocity = HumanoidRootPart.CFrame.LookVector * 37 + Vector3.new(0, (1 - v29 / 0.30952380952380953) * 105, 0);
        end;

        if not u25 then
            u24:AdjustSpeed(1);
        end;

        v22:Destroy();
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);

        if not u25 then
            u17:FireInput(u14.RawInput, "Slam", v28);
        end;
    end
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
            ["Slice n Dice"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            ["Overhead Strike"] = {
                DefaultKeybind = "R",
                Equipped = true
            },
            Prance = {
                DefaultKeybind = "G",
                Equipped = true
            },
            ["Perilous Thrust"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            ["Whirlwind Slash"] = {
                DefaultKeybind = "Y",
                Equipped = true
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 128752825955709,
            PoseIdle = 105828347026261,
            ["LMB-1"] = 113628418535397,
            ["LMB-2"] = 71684140283320,
            ["LMB-3"] = 116890897058312,
            ["LMB-4"] = 132057726996559,
            Prance = 111221072587008,
            ["Slice n Dice"] = 131490150187800,
            ["Whirlwind Slash"] = 123141492984628,
            ["Overhead Strike"] = 106774129555044,
            ["Perilous Thrust"] = 137707942291613,
            ["Thunderclap Startup"] = 85147454430964,
            ["Thunderclap Loop"] = 79500825059107,
            ["Thunderclap Release"] = 115235210465128,
            ["Thunderclap Idle"] = 111225218005107
        },
        Movement = {
            Walk = 78276466255662,
            Run = 101376791323914
        },
        Idle = {
            Idle = 136586359961069
        }
    },
    Stats = v1,
    Sounds = {
        ["LMB-1"] = {
            SoundId = 110899283222961,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 121409800255300,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 99078180373971,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 84280039297772,
            Volume = 1
        },
        MeterUp1 = {
            SoundId = 124713546664999,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 101118535570528,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 122860124513842,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 125541297890903,
            Volume = 1
        },
        ["Slice n Dice SFX"] = {
            SoundId = 73137154011359,
            Volume = 1
        },
        ["Slice n Dice Slashes"] = {
            SoundId = 134441077781946,
            Volume = 1
        },
        ["Whirlwind Slash SFX"] = {
            SoundId = 105371873922390,
            Volume = 1
        },
        ["Prance Startup SFX"] = {
            SoundId = 81547955516840,
            Volume = 1
        },
        ["Prance End SFX"] = {
            SoundId = 76693113347353,
            Volume = 1
        },
        ["Overhead Strike SFX"] = {
            SoundId = 98980054606409,
            Volume = 1
        },
        ["Perilous Thrust SFX"] = {
            SoundId = 87218332888704,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 133651759887861,
            Volume = 1,
            Looped = true
        },
        ["PoseMusic Layer"] = {
            SoundId = 123070853406742,
            Volume = 0,
            Looped = true,
            PlaybackSpeed = 1.8018018018018016
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
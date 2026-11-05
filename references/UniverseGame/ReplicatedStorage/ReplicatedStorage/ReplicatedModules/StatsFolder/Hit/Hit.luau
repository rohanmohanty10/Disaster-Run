  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v4 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    }
};
local v5 = {
    SoundId = 13620822318,
    Volume = 1
};
v1.Block = {
    From = "Combat.Block"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitRemotes = { v4["Light Hit"] },
        HitSounds = {
            Hit = v5
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 13, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = v5
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = v5
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 23, 27, "Attack" }, { 60, "End" } },
        HitRemotes = { v4["Heavy Hit"] },
        HitSounds = {
            Hit = {
                SoundId = 13620821774,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Breaker = {
    From = "Combat.Breaker"
};

local function DeadlyIntentCheck(p6, p7) -- Line: 158
    -- upvalues: u3 (ref)
    local v8 = u3.IsActive(p6, u3.Enums.Active.Main);

    return (p6:GetAttribute("DeadlyIntentActive") or not v8) and true or false;
end;

v1["Time-Skip"] = {
    Active = true,
    OmitMovestackCheck = true,
    Accumulate = 0.25,
    Actionable = {
        Active = false,
        Stunned = true
    },
    ClientActionable = {
        Active = false,
        Stunned = true
    },
    Cooldown = {
        Name = "Time-Skip",
        AfterMove = true,
        Time = 2
    },

    Invoke = function(p9) -- Line: 189, Name: Invoke
        -- upvalues: PathShortcuts (copy), Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");

        if Character:GetAttribute("Mount") then
            return;
        end;

        local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
        local v10 = TagService:GetContainer(LocalPlayer);

        if v10 and TagService:Get(v10, "DisableInputs") then
            return;
        end;

        local v11 = Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v12 = Knit.GetService("MoveInputService");

        if v11.GetCooldown(Character, "Time-Skip") then
            return;
        end;

        if v11.GetActive(Character, "Timeskip_Client") then
            return;
        end;

        v12:FireInput(p9.RawInput);
        require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler).Get(Humanoid.Animator);

        if Knit.CollectionService:HasTag(Character, "Stunned") then
            return;
        end;

        task.wait();
        local v13 = 0;
        local v14 = true;

        for _, _ in v11.GetActiveTable(Character) do
            v13 = v13 + 1;
        end;

        if v13 > 0 then
            v14 = false;
        end;

        v11.SetActive(Character, "Timeskip_Client", {
            Priority = v11.Enums.Active.Main
        });
        print(v14);

        if v14 then
            local v15 = RaycastParams.new();
            v15.FilterType = Enum.RaycastFilterType.Exclude;
            v15.FilterDescendantsInstances = { Character, workspace.Effects };
            local v16 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
            local v17 = workspace:Raycast(HumanoidRootPart.Position, v16 * 20, v15);
            local v18 = not (v17 and v17.Position) and 20 or (HumanoidRootPart.Position - v17.Position).Magnitude;
            local v19 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v16).LookVector.Unit * v18;
            game:GetService("TweenService"):Create(HumanoidRootPart, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
                CFrame = v19
            }):Play();
            local v20 = HumanoidRootPart.CFrame:VectorToObjectSpace(v16);
            local v21 = math.atan2(v20.X, -v20.Z);
            local v22 = math.deg(v21) - 0.5;
            local v23 = math.ceil(v22);

            if (v23 <= 45 or v23 >= 135) and (v23 >= -45 or v23 <= -135) then
                local _ = v23 <= -135 or v23 >= 135;
            end;
        end;

        task.wait(0.25);
        v11.SetActive(Character, "Timeskip_Client", nil);
    end
};
v1["Deadly Intent"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Scan = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 80
        }
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Flash Fist Crush"] = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Actionable = {
        Check = DeadlyIntentCheck
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Stun = {
        Time = 0.6
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Tremor Pulse"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Check = DeadlyIntentCheck
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 8),
        Offset = CFrame.new(0, 0, -4)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Time = 0.1
    },
    Stun = {
        Time = 0.7
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    HitAnimations = { 128620459306738 }
};
v1["Tides Of Time"] = {
    Active = true,
    MaxDuration = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Death Blow"] = {
    Active = true,
    Damage = 50,
    TrueDamage = true,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 30),
        Offset = CFrame.new(0, 0, -15)
    },
    Meter = {
        RequiredAmount = 25,
        RemoveMeter = false,
        MeterGain = 0
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 0.7,
        Intangible = false
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Icy Glare"] = {
    Active = true,
    Damage = 65,
    Actionable = {
        Active = true
    },
    Initial = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Second = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 35,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Last = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 50,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    Priority = EnumsModule.Intangible.Quickstep,
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Stun = {
        Time = 1
    },
    Ragdoll = {
        Time = 0.3,
        Intangible = false
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Time-Skip: Foresee"] = {
    Active = true,
    Damage = 40,
    Actionable = {
        Active = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7.5, 7.5, 7.5),
        Offset = CFrame.new(0, 0, -3.75)
    },
    Priority = EnumsModule.Intangible.Move + 1,
    Knockback = {
        RelativePart = "Attacker",
        Speed = 35,
        Time = 0.1
    },
    Stun = {
        Time = 0.65
    },
    Ragdoll = {
        Time = 0.3,
        Intangible = false
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Realized Power"] = {
    Active = true,
    Actionable = {
        Check = DeadlyIntentCheck
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(12, 12, 40),
        HitboxType = nil,
        Offset = CFrame.new(0, 0, -20)
    },
    Initial = {
        Damage = 25,
        Knockback = {
            RelativePart = "Attacker",
            Speed = -5,
            Time = 0.1
        },
        Stun = {
            Time = 0.35
        }
    },
    AfterHit = {
        Damage = 2.142857142857143,
        Stun = {
            Time = 0.075
        }
    },
    Final = {
        Damage = 10,
        Knockback = {
            RelativePart = "Attacker",
            Speed = -35,
            Time = 0.1
        },
        Stun = {
            Time = 0.5
        },
        Ragdoll = {
            Time = 0.5,
            Intangible = false
        }
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1["Timeskip: Molotov"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Startup = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = nil,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    Final = {
        Damage = 50,
        Ragdoll = {
            Time = 2
        },
        KnockbackData = { {
                Type = "Velocity",
                Velocity = Vector3.new(0, 6, 0),
                Speed = 80,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } }
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            ["Deadly Intent"] = {
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
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Time-Skip"] = {
                DefaultKeybind = "C",
                Equipped = true
            },
            ["Deadly Intent"] = {
                DefaultKeybind = "Q"
            },
            ["Flash Fist Crush"] = {
                State = "Deadly Intent",
                DefaultKeybind = "MouseButton1",
                Equipped = true
            },
            ["Vital Point Strikes"] = {
                DefaultKeybind = "E",
                Equipped = true
            },
            ["Tremor Pulse"] = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Realized Power"] = {
                DefaultKeybind = "R+"
            },
            ["Tides Of Time"] = {
                DefaultKeybind = "Y"
            },
            ["Time Release"] = {
                DefaultKeybind = "T"
            },
            ["Time Retribution"] = {
                DefaultKeybind = "T+"
            },
            ["Time-Skip: Foresee"] = {
                DefaultKeybind = "V"
            },
            ["Icy Glare"] = {
                DefaultKeybind = "G"
            },
            ["Timeskip: Molotov"] = {
                DefaultKeybind = "B",
                IndicatorInfo = {
                    DisplayName = "\"I Keep Improving!\""
                }
            },
            ["Death Blow"] = {
                DefaultKeybind = "Z"
            },
            ["Time-Stop"] = {
                DefaultKeybind = "H",
                IndicatorInfo = {
                    DisplayName = "Time-Skip: Maximum"
                }
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 112207048015177,
            ["LMB-2"] = 140118606881852,
            ["LMB-3"] = 91590555995325,
            ["LMB-4"] = 93355931391585,
            ["Flash Fist Crush"] = 91590555995325,
            ["Deadly Intent"] = 75054248682437,
            ["Tremor Pulse"] = 89595183222520,
            ["Realized Power"] = 109067960260918,
            ["Tides Of Time"] = 87121222947574,
            ["Time Release"] = 72814253475535,
            ["Death Blow"] = 77216598015742,
            ["Icy Glare"] = 105785342308104,
            ["Icy Glare Loop"] = 133451891889626,
            ["Icy Glare End"] = 77318927168046,
            Foresee = 82712408364558,
            ["Foresee Followup"] = 86960818042086,
            ["Timeskip Molotov Startup"] = 135935189303259,
            ["Timeskip Molotov"] = 76470162454237,
            ["Timeskip Molotov Victim"] = 98669334492076,
            ["Timeskip Molotov Camera"] = 81483467972050
        },
        Movement = {
            Run = 106079263013122,
            Walk = 104489340415361,
            ["TidesOfTime-Walk"] = 73223369106448,
            ["TidesOfTime-Run"] = 73991118622009
        },
        Idle = {
            Idle = 130747233186906,
            ["TidesOfTime-Idle"] = 108577002336126
        }
    },
    Stats = v1,
    Sounds = {
        MeterUp1 = {
            SoundId = 0
        },
        MeterUp2 = {
            SoundId = 0
        },
        MeterUp3 = {
            SoundId = 0
        },
        MeterUp4 = {
            SoundId = 0
        }
    },
    Metadata = {
        PostRig = function(p24) -- Line: 806, Name: PostRig
        end
    }
};
  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 15
    -- upvalues: u2 (ref), PathShortcuts (copy), u3 (ref), Knit (copy), u4 (ref), u5 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u3 = Knit.GetController("CombatController");
    u4 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = Knit.GetService("MoveInputService");
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
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab",
    AnimOffset = 3,
    CustomPrefix = "Water",
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
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 80750249566425,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1,
        Sequence = { { 0, "Start" }, { 8, 11, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 84037692729644,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p6, p7) -- Line: 168, Name: StateChecker
            -- upvalues: TableUtil (copy)
            local Count = p6.CharacterState["Rush Attack"].Count;
            local v8 = TableUtil.Copy(p6.Stats, true);
            local v9 = v8["LMB-" .. Count];
            v9.Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(9, 8, 10),
                Offset = CFrame.new(0, 0, -5)
            };
            v9.Stun = {
                Time = 0.6
            };

            return v8;
        end,

        PreAnim = function(p10) -- Line: 187, Name: PreAnim
            -- upvalues: ParticleHandler (copy)
            if p10.CharacterState["Rush Attack"].Count == 4 then
                return;
            end;

            ParticleHandler.EnableAllParticles(p10.Character.Stand, true);
        end,

        PostAnim = function(p11) -- Line: 195, Name: PostAnim
            -- upvalues: ParticleHandler (copy)
            if p11.CharacterState["Rush Attack"].Count == 4 then
                return;
            end;

            ParticleHandler.EnableAllParticles(p11.Character.Stand, false);
        end
    }
};
v1["Slice n Dice"] = {
    From = "Slayer Trainee.Slice n Dice"
};
v1["Overhead Strike"] = {
    From = "Slayer Trainee.Overhead Strike"
};
v1["Perilous Thrust"] = {
    From = "Slayer Trainee.Perilous Thrust"
};
v1["Whirlwind Slash"] = {
    From = "Slayer Trainee.Whirlwind Slash"
};
v1["Water Surface Slash"] = {
    Active = true,
    Damage = 25,
    Priority = EnumsModule.Intangible.Ragdoll,
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
    Ragdoll = {
        Time = 1.4
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 48,
        Time = 0.1,
        Velocity = Vector3.new(0, 25, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 77286765164364,
            Volume = 1.5
        }
    }
};
v1["Water Wheel"] = {
    Active = true,
    Duration = 5,
    Speed = 50,
    Damage = 0.5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(5, 13, 13.5),
        HitboxType = "ClientHitbox",
        Tolerance = 30,
        Offset = CFrame.identity
    },
    Ragdoll = {
        Time = 1
    },
    Priority = EnumsModule.Intangible.Ragdoll
};
v1["Dead Calm"] = {
    Active = true,
    Duration = 4,
    RangeGrowthRate = 50,
    StartRange = 10,
    MaxRange = 45,
    Speed = 125,
    Damage = 75,
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
    Stun = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 84485851996320,
            Volume = 1.5
        }
    }
};
v1["Constant Flux"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 22,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 50
    },
    Swing = {
        Damage = 10,
        Hitbox = {
            Size = 11,
            Offset = CFrame.new(0, 0, -2.5)
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        },
        Stun = {
            Time = 1.25
        }
    },
    Slam = {
        Damage = 15,
        Hitbox = {
            Size = 11,
            Offset = CFrame.new(0, -2.5, -5)
        },
        Ragdoll = {
            Time = 0.8
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 64,
            Time = 0.1
        }
    },
    HitSounds = {
        Hit = {
            SoundId = 130837409821489,
            Volume = 1.5
        }
    }
};
v1.Whirlpool = {
    Active = true,
    Damage = 33,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 20, 15),
        Offset = CFrame.new(0, 7.5, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 2,
        Velocity = Vector3.new(0, 30, 0),
        Time = 0.1
    },
    Stun = {
        Time = 1.25
    },
    HitSounds = {
        Hit = {
            SoundId = 85481652544357,
            Volume = 1.5
        }
    }
};
v1["Waterfall Basin"] = {
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
    Priority = EnumsModule.Intangible.Ragdoll,
    Hitbox = {
        Size = 14
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

    Invoke = function(u12) -- Line: 458, Name: Invoke
        -- upvalues: Knit (copy), u2 (ref), u4 (ref), Trove (copy)
        local v13 = Knit.GetController("CombatController");
        Knit.GetController("PilotController");
        local u14 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        u2:GetContainer(LocalPlayer);
        local _ = u12.Input;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u15 = u4.Get(Humanoid.Animator);
        LocalPlayer.Data.Ability:GetAttribute("AbilityName");

        if Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) or not HumanoidRootPart.CFrame.LookVector then
            local _ = Humanoid.MoveDirection;
        end;

        u14:FireInput(u12.RawInput, "Release");

        local function Lerp(p16, p17, p18) -- Line: 480
            return p16 + (p17 - p16) * p18;
        end;

        local v19 = Trove.new();
        local v20 = v19:Construct(Instance.new, "BodyVelocity");
        v20.Velocity = HumanoidRootPart.CFrame.LookVector * 56 + Vector3.new(0, 105, 0);
        v20.MaxForce = Vector3.new(1000000, 1000000, 1000000);
        v20.Parent = HumanoidRootPart;
        local u21 = u15:PlayAnimation("Waterfall Basin", 1.4);
        local u22 = false;
        local u23 = false;
        task.delay(0.30952380952380953, function() -- Line: 501
            -- upvalues: u22 (ref), u23 (ref), u21 (copy)
            if not (u22 or u23) then
                u21:AdjustSpeed(0);
            end;
        end);
        v19:Add(v13.QuickstepInterrupted:Connect(function() -- Line: 507
            -- upvalues: u14 (copy), u12 (copy), u22 (ref), u15 (copy)
            u14:FireInput(u12.RawInput, "Cancel", nil);
            u22 = true;
            u15:StopAnimation("Waterfall Basin", 0.9);
        end));
        local v24 = RaycastParams.new();
        v24.FilterType = Enum.RaycastFilterType.Include;
        v24.FilterDescendantsInstances = { workspace.Map };
        local v25 = os.clock();
        local v26 = nil;

        while not u22 and os.clock() - v25 <= 10 do
            task.wait();
            local v27 = os.clock() - v25;
            local v28 = v27 >= 0.30952380952380953 and workspace:Raycast(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 5, Vector3.new(0, -5, 0), v24);

            if v28 then
                v26 = {
                    RootLookVector = HumanoidRootPart.CFrame.LookVector,
                    Normal = v28.Normal,
                    Position = v28.Position
                };
                u23 = true;
                break;
            end;

            v20.Velocity = HumanoidRootPart.CFrame.LookVector * 56 + Vector3.new(0, (1 - v27 / 0.30952380952380953) * 105, 0);
        end;

        if not u22 then
            u21:AdjustSpeed(1);
        end;

        v19:Destroy();
        HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0);

        if not u22 then
            u14:FireInput(u12.RawInput, "Slam", v26);
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
            ["Water Surface Slash"] = {
                DefaultKeybind = "Y+",
                Equipped = true,
                Description = "Charge forward while spinning once performing a powerful strike."
            },
            ["Slice n Dice"] = {
                DefaultKeybind = "T",
                Equipped = true,
                Description = "Strike your katana forwards rapidly, creating a wind afterimage effect that slices enemies on front of you."
            },
            ["Overhead Strike"] = {
                DefaultKeybind = "R",
                Equipped = true,
                Description = "Raise your sword and hold it there, before quickly slashing your enemy."
            },
            ["Perilous Thrust"] = {
                DefaultKeybind = "Y",
                Equipped = true,
                Description = "Dash forwards with your sword in the direction you\'re facing, dragging anyone along with you."
            },
            ["Whirlwind Slash"] = {
                DefaultKeybind = "G",
                Equipped = true,
                Description = "Perform two spins forward, hitting once with each spin."
            },
            Whirlpool = {
                DefaultKeybind = "R+",
                Equipped = true,
                Description = "Jump and spin to create a whirlpool effect, taking anyone close enough with you."
            },
            ["Water Wheel"] = {
                DefaultKeybind = "E",
                Equipped = true,
                Description = "Hold your sword back before performing a flip to release a flowing, vertical slashes that resemble a water wheel."
            },
            ["Dead Calm"] = {
                DefaultKeybind = "H",
                Equipped = true,
                Description = "Cease all body movements to enter a state of complete tranquility. Manifest a massive body of water, striking all enemies caught within."
            },
            ["Constant Flux"] = {
                DefaultKeybind = "Z",
                Equipped = true,
                Description = "With the help of a blue water dragon, perform three strikes before quickly finishing up with an overhead slash."
            },
            ["Waterfall Basin"] = {
                DefaultKeybind = "G+",
                Equipped = true,
                Description = "Leap into the air with your sword above your head to hit your enemy with a powerful strike. You can change direction during this move and cancel it into another move."
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 124319515056552,
            PoseIdle = 134571774399673,
            ["Water-Grab"] = 70411388448025,
            ["Water-Throw"] = 95968889064124,
            ["Water-ThrowVictim"] = 75529732598527,
            ["LMB-1"] = 98608730447700,
            ["LMB-2"] = 97128938363388,
            ["LMB-3"] = 138998241382705,
            ["LMB-4"] = 101017386768440,
            ["Water Surface Slash"] = 77616903415949,
            ["Water Wheel Start"] = 79943857484174,
            ["Water Wheel Loop"] = 113712593117964,
            ["Water Wheel End"] = 133382372777943,
            ["Dead Calm Loop"] = 71044778742603,
            ["Dead Calm Hit"] = 121889632028408,
            ["Dead Calm Puddle"] = 81020283520938,
            ["Dead Calm Puddle Release"] = 98875038312714,
            ["Constant Flux"] = 114795166838966,
            ["Constant Flux Dragon"] = 132327718388867,
            Whirlpool = 122025312434392,
            ["Waterfall Basin"] = 111221072587008,
            ["Slice n Dice"] = 131490150187800,
            ["Whirlwind Slash"] = 123141492984628,
            ["Overhead Strike"] = 106774129555044,
            ["Perilous Thrust"] = 137707942291613
        },
        Movement = {
            Walk = 75478335853194,
            Run = 79084425315176
        },
        Idle = {
            Idle = 131297763497039
        }
    },
    Stats = v1,
    Sounds = {
        Grab = {
            SoundId = 140651867461725,
            Volume = 1.5
        },
        Grabbed = {
            SoundId = 74653433101704,
            Volume = 1.5
        },
        ["LMB-1"] = {
            SoundId = 72869067807297,
            Volume = 1.5
        },
        ["LMB-2"] = {
            SoundId = 102447613586541,
            Volume = 1.5
        },
        ["LMB-3"] = {
            SoundId = 98645163741937,
            Volume = 1.5
        },
        ["LMB-4"] = {
            SoundId = 130698849755744,
            Volume = 1.5
        },
        ["Water Surface SFX"] = {
            SoundId = 127706218661409,
            Volume = 1.5
        },
        ["Whirlpool SFX"] = {
            SoundId = 117899028246982,
            Volume = 1.5
        },
        ["Water Wheel Startup SFX"] = {
            SoundId = 130330906275119,
            Volume = 1.5
        },
        ["Water Wheel Finish SFX"] = {
            SoundId = 107350287827129,
            Volume = 1.5
        },
        ["Water Wheel SFX"] = {
            SoundId = 99791620585544,
            Volume = 1.5
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
        ["Waterfall Basin SFX"] = {
            SoundId = 89020698484080,
            Volume = 1.5
        },
        ["Waterfall Basin Slam SFX"] = {
            SoundId = 89479835567399,
            Volume = 1.5
        },
        ["Dead Calm Startup SFX"] = {
            SoundId = 83012580275187,
            Volume = 1.5
        },
        ["Dead Calm Water SFX"] = {
            SoundId = 93323500119626,
            Volume = 1.5
        },
        ["Dead Calm SFX"] = {
            SoundId = 133461843545013,
            Volume = 1.5
        },
        ["Constant Flux SFX"] = {
            SoundId = 132072848542165,
            Volume = 1.5
        },
        ["Constant Flux Slam SFX"] = {
            SoundId = 123155120391669,
            Volume = 1.5
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
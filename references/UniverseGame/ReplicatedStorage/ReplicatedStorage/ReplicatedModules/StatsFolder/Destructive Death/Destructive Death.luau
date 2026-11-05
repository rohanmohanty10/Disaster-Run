  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
Knit.OnStart():andThen(function() -- Line: 18
    -- upvalues: PathShortcuts (copy), u2 (ref), u6 (ref), Knit (copy), u8 (ref), u3 (ref), u4 (ref), u7 (ref), u5 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u6 = Knit.GetController("CombatController");
    u8 = Knit.GetService("MoveInputService");
    u3 = require(PathShortcuts.ReplicatedModules.Independent.TagService);
    u4 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
    u7 = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
    u5 = require(PathShortcuts.ReplicatedModules.StatsHandler);
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local v9 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/Light",
            LookAt = "Attacker"
        } }
};
local CurrentCamera = workspace.CurrentCamera;

local function GetFacing(p10, p11) -- Line: 68
    -- upvalues: CurrentCamera (copy)
    local v12 = nil;
    local v13 = nil;
    local v14 = p11 or 10;
    local HumanoidRootPart = p10:FindFirstChild("HumanoidRootPart");
    local Humanoid = p10:FindFirstChild("Humanoid");

    if HumanoidRootPart and Humanoid then
        for _, child in ipairs(workspace.Living:GetChildren()) do
            if child ~= p10 then
                local Humanoid2 = child:FindFirstChild("Humanoid");
                local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart");

                if Humanoid2 and (HumanoidRootPart2 and (Humanoid.Health > 0 and (Humanoid2.Health > 0 and CFrame.new(HumanoidRootPart.Position, HumanoidRootPart2.Position).LookVector:Dot(CurrentCamera.CFrame.LookVector) > 0))) then
                    local _, v15 = CurrentCamera:WorldToScreenPoint(HumanoidRootPart2.Position);

                    if v15 then
                        local Magnitude = (HumanoidRootPart.Position - HumanoidRootPart2.Position).Magnitude;

                        if v14 >= Magnitude then
                            if v12 then
                                if Magnitude < v13 then
                                    v12 = child;
                                end;
                            else
                                v12 = child;
                                v13 = Magnitude;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        return v12;
    end;
end;

v1.Block = {
    From = "Combat.Block",
    CustomPrefix = "Akaza-"
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

    Invoke = function(p16) -- Line: 143, Name: Invoke
        -- upvalues: Knit (copy)
        local v17 = Knit.GetService("MoveInputService");
        local Character = game.Players.LocalPlayer.Character;
        local Humanoid = Character:WaitForChild("Humanoid");
        Character:WaitForChild("HumanoidRootPart");
        local v18 = Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall;
        v17:FireInput(p16.RawInput, v18);
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
                SoundId = 15665760078,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 0, "PlaySound", "LMB2-Voiceline" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759862,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 0, "PlaySound", "LMB3-Voiceline" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759570,
                Volume = 1.5
            }
        },
        HitRemotes = { v9 }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 0, "PlaySound", "LMB4-Voiceline" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665759370,
                Volume = 1.5
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Path = "Particles/Misc/Heavy",
                        LookAt = "Attacker"
                    } }
            } }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p19, p20) -- Line: 255, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local v21 = Knit.GetService("EffectService");
            local Count = p19.CharacterState["Rush Attack"].Count;
            local Character = p19.Character;
            local v22 = TableUtil.Copy(p19.Stats, true);
            v21.FireAllClients("Rokushiki LMB", {
                Player = p19.Player,
                Character = Character,
                Count = Count,
                Speed = v22["LMB-" .. Count].Speed or (v22["LMB-1"].Speed or 1)
            });

            return v22;
        end
    }
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1["Annihilation Type"] = {
    Active = true,
    RunDuration = 2.5,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        HitboxType = "ClientHitbox",
        Tolerance = 25,
        Offset = CFrame.new(0, 0, -3)
    },
    Explosion = {
        Damage = 50,
        Ragdoll = {
            Time = 0.8
        },
        Hitbox = {
            Size = 25
        }
    }
};
v1["Crown Splitter"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = true
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 5,
        Velocity = Vector3.new(0, 77, 0),
        Time = 0.17
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    }
};
v1["Compass Needle"] = {
    Active = true,
    Actionable = {
        Active = true,
        Stunned = false,

        Check = function(p23) -- Line: 355, Name: Check
            -- upvalues: u2 (ref), EnumsModule (copy)
            local v24 = u2.GetActiveTable(p23);
            local v25 = v24.Stunned == nil and true or v24.Stunned;
            local v26 = nil;

            if v25 == true then
                v26 = EnumsModule.Stun.Light;
            elseif typeof(v25) == "table" then
                v26 = v25.MaxPriority;
            end;

            return v26 == nil and true or v26 <= EnumsModule.Stun.Heavy;
        end
    },
    Cooldown = {
        Manual = true,
        Time = 1
    },
    Indicators = { {
            Group = "Universal",
            InputText = "%s",
            Visible = true
        } },
    Stun = {
        Time = 0.8,
        Priority = EnumsModule.Stun.Heavy
    },
    Hitbox = {
        Size = 21
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 75,
        Time = 0.18
    }
};
v1.Disorder = {
    Active = true,
    Frequency = 5,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hit = {
        Damage = 1.5,
        Stun = {
            Time = 0.5
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 5,
            Time = 0.2
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = false
        },
        Hitbox = {
            Size = Vector3.new(12, 12, 12),
            Offset = CFrame.new(0, 0, -6)
        }
    },
    Finisher = {
        Damage = 25,
        Ragdoll = {
            Time = 0.75
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.17
        },
        Block = {
            Blockable = true,
            PerfectBlockable = false,
            BlockBreak = true
        },
        Hitbox = {
            Size = Vector3.new(13.5, 13.5, 13.5),
            Offset = CFrame.new(0, 0, -6.75)
        }
    }
};
v1["Air Type"] = {
    Active = true,
    Damage = 25,
    JumpHeight = 15,
    Armor = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Stun = {
        Time = 1
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.15
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true
    },

    Invoke = function(p27) -- Line: 507, Name: Invoke
        -- upvalues: Knit (copy), GetFacing (copy)
        local Character = p27.Character;
        local Humanoid = Character.Humanoid;
        local v28 = Humanoid:GetState() == Enum.HumanoidStateType.Jumping and true or Humanoid:GetState() == Enum.HumanoidStateType.Freefall;
        Knit.GetController("MoveInputController");
        local v29 = Knit.GetService("MoveInputService");
        local v30 = GetFacing(Character, 250);

        if v28 and not v30 then
            return;
        end;

        v29:FireInput(p27.RawInput, v28 and v30);
    end
};
v1["Flying Planet Thousand Wheels"] = {
    Active = true,
    Damage = 25,
    Speed = 150,
    FallTime = 7,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = 20
    },
    Ragdoll = {
        Time = 1
    },

    Invoke = function(p31) -- Line: 546, Name: Invoke
        -- upvalues: Knit (copy)
        local Character = p31.Character;
        local HumanoidRootPart = Character.HumanoidRootPart;
        local Humanoid = Character.Humanoid;
        local v32 = RaycastParams.new();
        v32.FilterType = Enum.RaycastFilterType.Include;
        v32.FilterDescendantsInstances = { workspace.Map };
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 100, 0);
        task.wait(0.2);

        if workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -15, 0), v32) then
            return;
        end;

        if Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
            return;
        end;

        Knit.GetController("MoveInputController");
        Knit.GetService("MoveInputService"):FireInput(p31.RawInput);
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
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Annihilation Type"] = {
                DefaultKeybind = "G",
                Equipped = true
            },
            ["Crown Splitter"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            ["Air Type"] = {
                DefaultKeybind = "Y",
                Equipped = true
            },
            Disorder = {
                DefaultKeybind = "E",
                Equipped = true
            },
            ["Compass Needle"] = {
                DefaultKeybind = "Q",
                Equipped = true
            },
            ["Flying Planet Thousand Wheels"] = {
                DefaultKeybind = "B",
                Equipped = true
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
            ["Akaza-Block"] = 115379077231478,
            ["Akaza-BlockHit1"] = 115379077231478,
            ["Akaza-BlockBreak"] = 12499357071,
            ["LMB-1"] = 130829313529863,
            ["LMB-2"] = 73688242165228,
            ["LMB-3"] = 118957323788001,
            ["LMB-4"] = 99298706423013,
            ["Annihilation Type Start"] = 107994990731077,
            ["Annihilation Type Loop"] = 107609744699310,
            ["Annihilation Type End"] = 90876502015332,
            ["Compass Needle"] = 80059258458011,
            ["Crown Splitter"] = 100636747112200,
            ["Air Type: Air"] = 72973317170105,
            ["Air Type: Ground"] = 84744181041168,
            Disorder = 121363858748100,
            ["Slam Start"] = 90021969923222,
            ["Slam Loop"] = 111716840762732,
            ["Slam End"] = 98872385217474
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
    Sounds = {}
};
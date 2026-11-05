  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Trove = require(Knit.Util.Trove);
Knit.OnStart():await();
local _ = ReplicatedStorage.Remotes;
local ReplicatedModules = ReplicatedStorage.ReplicatedModules;
local _ = ReplicatedStorage["Client Assets"];
game:GetService("CollectionService");
game:GetService("RunService");
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local u2 = Knit.GetService("EffectService");
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(ReplicatedModules.Animations);
local Enums = require(ReplicatedModules.Enums);
local u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");

local function Lerp(p4, p5, p6) -- Line: 29
    return p4 + (p5 - p4) * p6;
end;

local function _(p7, p8, p9) -- Line: 32
    if p9 then
        return Random.new():NextInteger(p7, p8);
    end;

    return Random.new():NextNumber(p7, p8);
end;

local function CreateClockspeedIncrement(u10, u11) -- Line: 36
    -- upvalues: Trove (copy)
    local v12 = u10:GetAttribute("ChronoClockSpeed");

    if v12 then
        u10:SetAttribute("ChronoClockSpeed", v12 + u11);
        local v13 = Trove.new();
        v13:Add(function() -- Line: 43
            -- upvalues: u10 (copy), u11 (copy)
            u10:SetAttribute("ChronoClockSpeed", u10:GetAttribute("ChronoClockSpeed") - u11);
        end);

        return v13;
    end;
end;

local function CreateIndicator(p14) -- Line: 50
    return {
        Group = p14.Group or "Universal",
        Name = p14.Name,
        DisplayName = p14.DisplayName or p14.Name,
        CooldownName = p14.CooldownName or p14.Name,
        ActiveName = p14.ActiveName or p14.Name,
        InputText = p14.InputText or "%s",
        Visible = p14.Visible or true
    };
end;

local v15 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Hit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v16 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/HeavyHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v17 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/SpikePierce",
            AutoSerialize = true,
            LookAt = "Attacker",
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        }
    }
};
v1.Aura = {
    HueShift = 0
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep",
    Indicators = { {
            Group = "Universal",
            Name = "Quickstep",
            DisplayName = "Blink",
            Visible = true
        } },
    Cooldown = {
        Time = 1.5,
        Manual = false,
        AfterMove = true
    },

    Invoke = function(p18) -- Line: 132, Name: Invoke
        -- upvalues: TagService (copy), Knit (copy), EffectsHandler (copy), Trove (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v19 = TagService:GetContainer(LocalPlayer);

        if v19 and TagService:Get(v19, "DisableInputs") then
            return;
        end;

        local _ = p18.Input;
        local v20 = Knit.GetController("CombatController");
        local AnimationHandler = require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        AnimationHandler.Get(Humanoid.Animator);
        local v21 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Position = HumanoidRootPart.Position;
        Knit.GetService("MoveInputService"):FireInput(p18.RawInput, Position, v21);
        task.wait(0.075);
        v20.SetActive(Character, "Quickstep_Client", {
            Priority = v20.Enums.Active.Main
        });
        local u22 = EffectsHandler.GetEffect("ChronoWarden_Blink");
        task.spawn(u22, Character, {
            Duration = 18,
            Origin = HumanoidRootPart.Position,
            Destination = Position + v21 * 20,
            PartAmount = { 6, 8 }
        });
        local v23 = Trove.new();
        local u24 = v23:Add(Instance.new("BodyVelocity"));
        u24.Velocity = v21 * 60 * Vector3.new(1, 0.1, 1);
        u24.MaxForce = Vector3.new(100000, 10000, 100000);
        u24.Parent = HumanoidRootPart;
        v23:Add(v20.QuickstepInterrupted:Connect(function() -- Line: 177
            -- upvalues: u24 (copy), u22 (copy), Character (copy)
            u24:Destroy();
            task.spawn(u22, Character, {
                Cancel = true
            });
        end));
        task.delay(0.235, u24.Destroy, u24);
        u24.AncestryChanged:Wait();
        v20.SetActive(Character, "Quickstep_Client", nil);
    end
};
v1.Grab = {
    From = "Combat.Grab",
    Actionable = {
        Summoned = false
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
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Endlag = 0.3,
    ActiveEndlag = 0.25,
    ["LMB-1"] = TableUtil.Reconcile({
        Endlag = 0.2,
        Speed = 1.3,
        Damage = 8,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 19, 20, "Attack" }, { 25, "End" } },
        Stun = {
            Time = 0.55,
            Priority = Enums.Stun.Medium
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 8,
            Time = 0.1
        },
        Block = {
            PerfectBlockable = false
        },
        HitRemotes = { v15 },
        HitSounds = {
            Hit = {
                SoundId = 11751789825,
                Volume = 1.75
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Damage = 3,
        Speed = 1.3,
        Sequence = {
            { 0, "Start" },
            { 5, "Attack", {
                    Multiple = true
                } },
            { 7, function(p25, p26, p27) -- Line: 285
                    -- upvalues: u2 (copy)
                    local _ = p27.Character;
                    local Player = p27.Player;
                    local FireAllClients = u2.FireAllClients;
                    local v28 = {
                        Path = "Particles/LightKick",
                        AutoSerialize = true,
                        HueShift = p27.Stats.HueShift or 0
                    };
                    local v29 = p27.RootPart.CFrame * CFrame.new(0.4, 0, -3.5);
                    local Angles = CFrame.Angles;
                    local v30 = Random.new():NextNumber(-4, 4);
                    v28.CFrame = v29 * Angles(1.5707963267948966 + math.rad(v30), 0, 0);
                    v28.Player = Player;
                    FireAllClients("Emit Particle V3", v28);
                end },
            { 24, "Attack", {
                    Multiple = true
                } },
            { 25, function(p31, p32, p33) -- Line: 299
                    -- upvalues: u2 (copy)
                    local _ = p33.Character;
                    local Player = p33.Player;
                    local FireAllClients = u2.FireAllClients;
                    local v34 = {
                        Path = "Particles/LightKick",
                        AutoSerialize = true,
                        Scale = 1.2,
                        HueShift = p33.Stats.HueShift or 0
                    };
                    local v35 = p33.RootPart.CFrame * CFrame.new(0.4, 0, -3.7);
                    local Angles = CFrame.Angles;
                    local v36 = Random.new():NextNumber(-4, 4);
                    v34.CFrame = v35 * Angles(1.5707963267948966 + math.rad(v36), 0, 0);
                    v34.Player = Player;
                    FireAllClients("Emit Particle V3", v34);
                end },
            { 39, "Attack", {
                    Multiple = true
                } },
            { 40, function(p37, p38, p39) -- Line: 314
                    -- upvalues: u2 (copy)
                    local _ = p39.Character;
                    local Player = p39.Player;
                    local FireAllClients = u2.FireAllClients;
                    local v40 = {
                        Path = "Particles/LightKick",
                        AutoSerialize = true,
                        Scale = 1.4,
                        HueShift = p39.Stats.HueShift or 0
                    };
                    local v41 = p39.RootPart.CFrame * CFrame.new(0.4, 0, -3.9);
                    local Angles = CFrame.Angles;
                    local v42 = Random.new():NextNumber(-4, 4);
                    v40.CFrame = v41 * Angles(1.5707963267948966 + math.rad(v42), 0, 0);
                    v40.Player = Player;
                    FireAllClients("Emit Particle V3", v40);
                end },
            { 41, "End" }
        },
        HitRemotes = { v15 },
        HitSounds = {
            Hit = {
                SoundId = 11751790648,
                Volume = 1.75
            }
        }
    },
    ["LMB-3"] = {
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 15, 17, "Attack" }, { 18, "End" } },
        HitRemotes = { v15 },
        Stun = {
            Time = 0.6,
            Priority = Enums.Stun.Medium
        },
        HitSounds = {
            Hit = {
                SoundId = 11751790989,
                Volume = 1.75
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.3,
        Cooldown = 0.75,
        Damage = 25,
        HitAnimations = "Default",
        Sequence = { { 0, "Start" }, { 20, 22, "Attack" }, { 30, "End" } },
        HitRemotes = { v16 },
        HitSounds = {
            Hit = {
                SoundId = 11751791686,
                Volume = 2
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1["Punch Barrage"] = {
    Active = true,
    Cooldown = {
        Time = 10.5,
        AfterMove = true
    },
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Callbacks = {
        BarrageEffect = function(p43, p44, p45, p46) -- Line: 418, Name: BarrageEffect
            -- upvalues: Knit (copy)
            local Character = p44.Character;

            if p46 then
                Knit.CollectionService:AddTag(Character, "Barraging");
                Knit.Remotes.Output:FireAllClients("FX", "ChronoWarden_Barrage", Character, {
                    Offset = CFrame.new(0, 0, -3)
                });
                p45.SequenceTrove:Add(function() -- Line: 426
                    -- upvalues: Knit (ref), Character (copy)
                    Knit.CollectionService:RemoveTag(Character, "Barraging");
                end);
            else
                Knit.CollectionService:RemoveTag(Character, "Barraging");
            end;

            return true;
        end
    },
    Hit = TableUtil.Reconcile({
        HitRemotes = { v15 },
        HitSounds = {
            Hit = {
                SoundId = 11752221494,
                Volume = 1.5
            }
        }
    }, BaseStatsModule.Stand_Barrage.Hit),
    Finisher = TableUtil.Reconcile({
        Damage = 29,
        Speed = 1.35,
        HitRemotes = { v16 },
        HitData = {
            Offset = CFrame.Angles(-1.5707963267948966, 0, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 11752222019,
                Volume = 1.75
            }
        }
    }, BaseStatsModule.Stand_Barrage.Finisher),
    Sequence = {
        { 0, "BarrageStart" },
        { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } },
        { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } },
        { 23, "Cancelable", true },
        { 24, "Clashable", true },
        { 24, "Barrage", true },
        { 24, 144, "BarrageAttack", "Hit" },
        { 24, 170, function(p47, p48, p49) -- Line: 478
                -- upvalues: u2 (copy), CreateClockspeedIncrement (copy)
                if p48 % 8 ~= 0 then
                    return;
                end;

                local Character = p49.Character;
                local Trove2 = p49.Trove;
                u2.FireAllClients("ChronoWarden_Afterimage", Character, {
                    Lifetime = 0.075,
                    TransitionTime = 0.1,
                    Offset = CFrame.new(Random.new():NextNumber(-2, 2), 0, (Random.new():NextNumber(-0.75, 0.1)))
                });

                if not p47.SpedUp then
                    p47.SpedUp = true;
                    Trove2:Add(CreateClockspeedIncrement(Character, 1.5));
                end;
            end },
        { 144, "Cancelable", false },
        { 144, "Clashable", false },
        { 144, "BarrageFinisher" },
        { 163, "BarrageAttack", "Finisher" },
        { 193, "End" }
    },
    ClashSequence = BaseStatsModule.Stand_Barrage.ClashSequence,
    ClashHit = BaseStatsModule.Stand_Barrage.ClashHit,
    ClashFinisher = BaseStatsModule.Stand_Barrage.ClashFinisher
};
v1["Temporal Temper"] = {
    AllowClientStacking = true,
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Cooldown = {
        Time = 15,
        AfterMove = true
    },
    Meter = {
        RequiredLevel = 1
    },
    Block = {
        BypassCounter = true,
        Blockable = false,
        PerfectBlockable = false
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 10,
        Debug = false,
        Offset = CFrame.new(0, 0, -12),
        Block = {
            BypassCounter = true,
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Trigger = {
        Damage = 30,
        Priority = 100,
        Block = {
            BypassCounter = true,
            Unblockable = true
        },
        Stun = {
            Time = 0.8,
            Priority = Enums.Stun.Medium
        }
    }
};
v1.Halt = {
    AllowClientStacking = true,
    Active = true,
    CheckPVPSafe = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(9, 9, 8.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -5.5)
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    }
};
v1["Fast Forward"] = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Time Anchor" }
        },

        Check = function(p50) -- Line: 601, Name: Check
            return p50:GetAttribute("FastForward") == false;
        end
    },
    Meter = {
        RequiredAmount = 65
    },
    Cooldown = {
        Manual = true,
        Time = 25,
        Name = "Fast Forward"
    }
};
v1["Time Anchor / Displaced Time Anchor"] = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,

        Check = function(p51) -- Line: 623, Name: Check
            -- upvalues: u3 (copy)
            if u3.GetActive(p51, "Playtime\'s Over") then
                return false;
            end;

            if u3.GetActive(p51, "Temporal Riposte") then
                return false;
            end;

            return not u3.GetActive(p51, "Time Anchor");
        end
    },

    Invoke = function(p52) -- Line: 639, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p52.Input;
        local v53 = Knit.GetController("MoveInputController");
        local v54 = Knit.GetService("MoveInputService");
        local v55 = os.clock();
        local v56 = false;

        while v53.Inputs[Input] do
            if os.clock() - v55 >= 0.35 then
                v56 = true;
                break;
            end;

            task.wait();
        end;

        v54:FireInput(p52.RawInput, v56);
    end
};
v1["Time Anchor"] = {
    AllowClientStacking = true,
    Active = true,
    MaxDuration = 12.5,
    MaxRange = 150,
    Cooldown = {
        Time = 2.5,
        Name = "Time Anchor",
        Manual = true
    },
    SecondaryCooldown = {
        Name = "Time Anchor",
        Time = 12
    },
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,

        Check = function(p57) -- Line: 676, Name: Check
            -- upvalues: u3 (copy)
            if u3.GetActive(p57, "Playtime\'s Over") then
                return false;
            end;

            if u3.GetActive(p57, "Temporal Riposte") then
                return false;
            end;

            return not u3.GetActive(p57, "Time Anchor");
        end
    },

    Invoke = function(p58) -- Line: 694, Name: Invoke
        -- upvalues: Knit (copy)
        local Input = p58.Input;
        local v59 = Knit.GetController("MoveInputController");
        local v60 = Knit.GetService("MoveInputService");
        local v61 = os.clock();
        local v62 = false;

        while v59.Inputs[Input] do
            if os.clock() - v61 >= 0.25 then
                v62 = true;
                break;
            end;

            task.wait();
        end;

        v60:FireInput(p58.RawInput, v62);
    end
};
v1["Displaced Time Anchor"] = {
    MaxDuration = 12.5,
    MaxRange = 150,
    Cooldown = {
        Time = 2.5,
        Name = "Time Anchor",
        Manual = true
    },
    SecondaryCooldown = {
        Name = "Time Anchor",
        Time = 12
    }
};
v1["Playtime\'s Over"] = {
    Active = true,
    Remotes = { { "FX", "HeavyEffect" } },
    Impact = {
        Damage = 80,
        HitAnimations = "Default",
        Hitbox = {
            Type = "Magnitude",
            Size = 80,
            Debug = false,
            Offset = CFrame.new(0, 0, 0)
        },
        HitRemotes = { v15 },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            PerfectBlockCancel = true,
            BypassCounter = true
        },
        Knockback = {
            Speed = 32,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        },
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Medium
        },
        Meter = {
            MeterGain = 0
        }
    },
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p63) -- Line: 774, Name: Check
            local v64 = p63:FindFirstChildOfClass("Humanoid");

            if v64 then
                return v64.FloorMaterial ~= Enum.Material.Air;
            end;

            return false;
        end
    },
    Indicators = { (CreateIndicator({
            Name = "Playtime\'s Over"
        })) },
    Meter = {
        MeterGain = 0,
        RequiredLevel = 4
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    }
};
v1.Pummel = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Light = {
        HitAnimations = "Default",
        Damage = 7,
        HitRemotes = { v15 },
        HitSounds = {
            Hit = {
                SoundId = 13083324495,
                Volume = 1.75
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.25,
            Priority = Enums.Stun.Medium
        },
        Block = {
            Blockable = true,
            PerfectBlockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 2,
            Time = 0.2
        }
    },
    Heavy = {
        HitAnimations = "Default",
        Damage = 15,
        HitRemotes = { v15, v16 },
        HitSounds = {
            Hit = {
                SoundId = 13083320966,
                Volume = 1.75
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stun = {
            Time = 0.5,
            Priority = Enums.Stun.Medium
        },
        Block = {
            BlockBreak = true,
            PerfectBlockable = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 65,
            Time = 0.2
        }
    }
};
v1["Chronal Infusion"] = {
    AllowClientStacking = true,
    Active = true,
    HitAnimations = "Default",
    Damage = 35,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Properties = {
        Armor = true
    },
    HitRemotes = { v16 },
    Cooldown = {
        Time = 15.5,
        AfterMove = true
    },
    HitSounds = {
        Hit = {
            SoundId = 13083320100,
            Volume = 2.5
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 6, 6.5),
        Debug = false,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Stun = {
        Time = 0.8,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.2
    }
};
v1.Fracture = {
    AllowClientStacking = true,
    Active = true,
    Damage = 15,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    HitRemotes = { v17 },
    HitSounds = {
        Hit = {
            SoundId = 13218931782,
            Volume = 1.75
        }
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 6, 25),
        Debug = false,
        Offset = CFrame.new(0, 0, -12.5)
    },
    Stun = {
        Time = 0.25,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Cooldown = {
        Time = 14.5,
        AfterMove = true
    }
};
v1.Tremor = {
    AllowClientStacking = true,
    Active = true,
    Damage = 40,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    HitRemotes = { v15 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 17.5,
        Debug = false,
        Offset = CFrame.new(0, -3, 0)
    },
    Ragdoll = {
        Time = 0.65
    },
    Block = {
        Unblockable = true
    },
    KnockbackData = { {
            Type = "Velocity",
            Speed = 32,
            Velocity = Vector3.new(0, 64, 0),
            Time = 0.1
        }, {
            Type = "AngularVelocity",
            RelativePart = "Attacker",
            RelativeVelocity = Vector3.new(2, 2, 8),
            Time = 0.35
        } },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Cooldown = {
        Time = 18,
        AfterMove = true
    }
};
v1["Chrono Cannon"] = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        }
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Level1 = {
        Damage = 40,
        Hitbox = {
            Type = "Magnitude",
            Size = 12,
            Debug = false
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.2,
            Override = true,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 0.5
        },
        Block = {
            BlockBreak = true
        },
        HitRemotes = { v15 }
    },
    Vortex = {
        Hitbox = {
            Type = "Magnitude",
            Size = 15.5,
            Debug = false
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false
        }
    },
    Level2 = {
        Damage = 30,
        Hitbox = {
            Type = "Magnitude",
            Size = 12,
            Debug = false
        },
        Priority = Enums.Intangible.Ragdoll,
        Knockback = {
            RelativePart = "Attacker",
            Speed = 25,
            Time = 0.2,
            Override = true,
            Velocity = Vector3.new(0, 25, 0)
        },
        Ragdoll = {
            Time = 0.5
        },
        Block = {
            BypassCounter = true,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v15 }
    },
    Level3 = {
        Damage = 25,
        Hitbox = {
            Type = "Magnitude",
            Size = 12,
            Debug = false
        },
        Block = {
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v1["Temporal Onslaught"] = {
    AllowClientStacking = true,
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Time Anchor" }
        },

        Check = function(p65) -- Line: 1145, Name: Check
            return p65:GetAttribute("FastForward") == true;
        end
    },
    Indicators = { (CreateIndicator({
            Group = "FastForward",
            Name = "Temporal Onslaught"
        })) },
    Meter = {
        RequiredLevel = 1
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Startup = {
        CheckPVPSafe = true,
        Meter = false,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(12, 10, 35),
            Offset = CFrame.new(0, 0, -17.5)
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            BlockCancel = true,
            PerfectBlockCancel = true
        },
        Stun = {
            Time = 0.65
        }
    },
    HeavyBlow = {
        Damage = 25,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v15 }
    },
    HeadGrab = {
        Damage = 3.5,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = {}
    },
    Blow = {
        Damage = 6.5,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v15 }
    },
    BarrageBlow = {
        Damage = 5,
        MinHealth = 1,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v15 }
    },
    Uppercut = {
        Damage = 25,
        Meter = false,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Velocity = Vector3.new(0, 40, 0),
            Time = 0.2
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { v16 }
    }
};
v1["Temporal Riposte"] = {
    Active = true,
    Damage = 35,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 8,
        Velocity = Vector3.new(0, 50, 0),
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.3
    },
    HitSounds = {
        Hit = {
            SoundId = 13083318659,
            Volume = 2
        }
    },
    Stun = {
        Time = 1.1,
        Priority = Enums.Stun.Medium
    },
    HitRemotes = { v15 },
    Cooldown = {
        Time = 15,
        AfterMove = true
    }
};
v1["Collapse Time Anchor"] = {
    Active = true,
    Damage = 40,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,

        Check = function(p66) -- Line: 1308, Name: Check
            return p66:GetAttribute("TimeAnchor") and true or false;
        end
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Hitbox = {
        Type = "Magnitude",
        Size = 13,
        Debug = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = true
    },
    Knockback = {
        Speed = 25,
        Time = 0.2,
        Override = true,
        Velocity = Vector3.new(0, 25, 0)
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 0.25
    },
    HitRemotes = { v15 }
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseEnd = function(p67, p68) -- Line: 1354, Name: PoseEnd
            local _ = p67.Stats;
            local _ = p67.Player;
            local Character = p67.Character;

            if Character:FindFirstChild("PoseObj") then
                Character:FindFirstChild("PoseObj"):Destroy();
            end;
        end,

        PoseTransition = function(p69, p70) -- Line: 1363, Name: PoseTransition
            -- upvalues: u2 (copy)
            local Stats = p69.Stats;
            local Player = p69.Player;
            local Character = p69.Character;
            local v71 = p69.Character:GetAttribute("ChronoResurrection");
            local Folder = Instance.new("Folder");
            Folder.Name = "PoseObj";
            Folder.Parent = Character;

            if v71 then
                u2.FireAllClients("ChronoWarden_IcospherePartial", {
                    Scale = 10,
                    Player = Player,
                    Reference = Folder,
                    OriginPart = Character.HumanoidRootPart,
                    HueShift = Stats.HueShift
                });

                return;
            end;

            u2.FireAllClients("ChronoWarden_PoseEffect", {
                Reference = Folder,
                Character = Character,
                HueShift = Stats.HueShift
            });
        end,

        Transformer = function(p72) -- Line: 1393, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v73 = p72.Character:GetAttribute("ChronoResurrection");
            local v74 = TableUtil.Copy(p72.Stats, true);

            if not v73 then
                v74.Resurrected = false;
                v74.PoseMusic = "PoseMusic";

                return v74;
            end;

            v74.Resurrected = true;
            v74.PoseMusic = "ResurrectedPoseMusic";
            v74.StartAnim = "ResurrectedPoseTransition";
            v74.LoopAnim = "ResurrectedPoseIdle";

            return v74;
        end
    }
};

return {
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://11751732372",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://11751732915",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://11751733319",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://11751733974",
            Volume = 1
        },
        Barrage = {
            SoundId = 11752220903,
            Volume = 1
        },
        GroundSlam = {
            SoundId = 12072319825,
            Volume = 1.5
        },
        AnchorPlace = {
            SoundId = 13083327832,
            Volume = 1
        },
        Snap = {
            SoundId = 13083328720,
            Volume = 1
        },
        AnchorUse = {
            SoundId = 13083329412,
            Volume = 1
        },
        AnchorUseStack = {
            SoundId = 18457870034,
            Volume = 3
        },
        InfusionSwoosh = {
            SoundId = 13083326572,
            Volume = 1
        },
        KicksSwoosh = {
            SoundId = 13083325427,
            Volume = 1
        },
        ChronalInfusion = {
            SoundId = 13083327239,
            Volume = 1.5
        },
        CounterStance = {
            SoundId = 13083319307,
            Volume = 1
        },
        CounterActivation = {
            SoundId = 13083315809,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 14661361823,
            Volume = 2.5
        },
        ResurrectedPoseMusic = {
            SoundId = 14661365114,
            Volume = 2.5
        },
        SpikeSummon = {
            SoundId = 13218930180,
            Volume = 1.75
        },
        Dash1 = {
            SoundId = 13218924436,
            Volume = 0.8
        },
        Dash2 = {
            SoundId = 13218924436,
            Volume = 0.8
        },
        MeterUp1 = {
            SoundId = 13218925692,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 13218925692,
            Volume = 2,
            PlaybackSpeed = 1.1
        },
        MeterUp3 = {
            SoundId = 13218925692,
            Volume = 2,
            PlaybackSpeed = 1.2
        },
        MeterUp4 = {
            SoundId = 13218927224,
            Volume = 2
        },
        Resurrect = {
            SoundId = 13218928716,
            Volume = 3
        },
        Chronostasis = {
            SoundId = 13366836279,
            Volume = 2.5
        },
        Halt = {
            SoundId = 13366833788,
            Volume = 3
        },
        HaltProjectile = {
            SoundId = 13366837445,
            Volume = 3
        },
        FastForwardAffected = {
            SoundId = 13366838623,
            Volume = 2.5
        },
        FastForwardAmbience = {
            SoundId = 13366840400,
            Volume = 0.9
        },
        FastForwardBegin = {
            SoundId = 13366842020,
            Volume = 2.5
        },
        Level1Shot = {
            SoundId = 13432926559,
            Volume = 4.5
        },
        Level1Hit = {
            SoundId = 13432928243,
            Volume = 2.5
        },
        Level2Shot = {
            SoundId = 13432930160,
            Volume = 2.5
        },
        Level2Hit = {
            SoundId = 13432931428,
            Volume = 4.5
        },
        Level3Shot = {
            SoundId = 13432932788,
            Volume = 2.5
        },
        Level3Hit = {
            SoundId = 13432933847,
            Volume = 4.5
        },
        CannonCharge = {
            SoundId = 13432925067,
            Volume = 2.5
        },
        TemporalOnslaughtAttempt = {
            SoundId = 13869665657,
            Volume = 2
        },
        TemporalOnslaught = {
            SoundId = 13869666469,
            Volume = 4
        },
        CollapseSnap = {
            SoundId = 14190764496,
            Volume = 2
        },
        CollapseExplosion = {
            SoundId = 14190766588,
            Volume = 4
        },
        CollapseStart = {
            SoundId = 14190762274,
            Volume = 2
        },
        GrandfatherTimeStart = {
            SoundId = 14353056569,
            Volume = 2.5,
            RollOffMaxDistance = 400
        },
        GrandfatherTimeEnd = {
            SoundId = 14353059702,
            Volume = 2.5,
            RollOffMaxDistance = 250
        },
        GrandfatherTimeResume = {
            SoundId = 14353057980,
            Volume = 2,
            RollOffMaxDistance = 250
        },
        TemperPlacement = {
            SoundId = 14508930510,
            Volume = 1.2
        },
        TemperActivation = {
            SoundId = 14508935562,
            Volume = 1.2
        },
        TemperAmbience = {
            SoundId = 14508933539,
            Volume = 0.65
        },
        TemperBreak = {
            SoundId = 14508928587,
            Volume = 1.8
        }
    },
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 3
            },
            FastForward = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = {
            ["Temporal Resurrection"] = {
                State = "Passive",
                Description = "If you take lethal damage whilst near a placed time anchor, revive instead of dying and enter an awakened state with increased damage, but reduced damage reduction. This only works once.",
                Equipped = true
            },
            ["Continuum Rapture"] = {
                State = "Passive",
                Description = "When <b>Chronosyntax</b> is applied to a target which has <b>Decay</b> or vice versa, the effects will cancel out and instead cause a powerful implosion on the target, dealing very high damage.",
                Equipped = true
            },
            ["Time Reversal"] = {
                State = "Passive",
                Description = "When reverting back to a time anchor, you may gain (or lose) up to 25 health, depending on the change of HP during the time of placing the anchor and reverting to it.",
                Equipped = true
            },
            ["Temporal Overlap"] = {
                State = "Passive",
                Description = "<b>Time Anchor</b> may be teleported to whilst another move is active, cancelling into it at the cost of <b>30 meter</b>. This does not work against <b>Playtime\'s Over</b> or <b>Temporal Riposte</b>."
            },
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                DisplayName = "Blink",
                Description = "Phase in the direction of your movement, briefly ignoring attacks.",
                IndicatorInfo = {
                    DisplayName = "Blink"
                }
            },
            ["Fast Forward"] = {
                DefaultKeybind = "Q",
                Equipped = true,
                Description = "Accelerate your own time, increasing your attack speed and movement speed. Discards after using <font color=\"#a1caff\">5</font> attacks or after 12 seconds. <b>While this effect is active, you will negate any incoming timestop, at the cost of canceling the effect.</b>"
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true
            },
            ["Punch Barrage"] = {
                DefaultKeybind = "E",
                State = "Universal",
                Description = "Accelerate time for yourself and perform a barrage of punches.",
                Unlocked = true
            },
            Halt = {
                DefaultKeybind = "G",
                State = "Universal",
                Description = "Quickly summon a clock to temporarily stop foes and projectiles ahead of you.",
                Unlocked = false,
                LevelRequirement = 25
            },
            ["Temporal Temper"] = {
                DefaultKeybind = "G+",
                State = "Universal",
                Description = "Plant a pulsing trap on the ground in front of you. If any foes are hit by a pulse, manifest a temporary barrier to prevent the target from leaving by teleporting them back to the center of the zone.",
                Unlocked = false,
                LevelRequirement = 65
            },
            ["Time Anchor"] = {
                DefaultKeybind = "V",
                State = "Universal",
                Description = "Manifest a temporal anchor that will save the position it was placed at. Hold the key to place the anchor with an offset depending on your movement direction. Teleport back to the saved position by using the move again.",
                Unlocked = true
            },
            Pummel = {
                DefaultKeybind = "R",
                State = "Universal",
                Description = "Perform kicks in quick succession, dealing medium damage.",
                Unlocked = true
            },
            ["Chronal Infusion"] = {
                DefaultKeybind = "R+",
                State = "Universal",
                Description = "Wind up a punch infused with temporal energy, inflicting Chronosyntax on any foes hit. Chronosyntax will teleport a target back to where the effect was inflicted after a brief delay.",
                Unlocked = false,
                LevelRequirement = 75
            },
            Fracture = {
                DefaultKeybind = "Y",
                State = "Universal",
                Description = "Cast temporal spikes in front of you, impaling any foes in your way. When hit, inflict Decay. Decay will drain 10% of the target maximum Health over 3 seconds.",
                Unlocked = false,
                LevelRequirement = 90
            },
            Tremor = {
                DefaultKeybind = "Y+",
                State = "Universal",
                Description = "Wind up a powerful strike to the ground, causing a rippling shockwave which sends foes flying into the air.",
                Unlocked = false,
                LevelRequirement = 60
            },
            ["Chrono Cannon"] = {
                DefaultKeybind = "T",
                State = "Universal",
                Description = "Charge a projectile move which changes effect depending on charge level.<br /><b>Level 1</b>: Projectile causing an explosion upon impact.<br /><b>Level 2</b>: Projectile causing a vortex on impact, pulling foes towards the impact position before detonating.<br /><b>Level 3</b>: Projectile which manifests a temporal field on impact, stopping projectiles and foes that enter it in time.",
                Unlocked = true
            },
            ["Temporal Riposte"] = {
                DefaultKeybind = "B",
                State = "Universal",
                Description = "Perform a counter. When triggered, blink to the attacker and knock them into the air with a powerful uppercut.",
                Unlocked = false,
                LevelRequirement = 50
            },
            ["Collapse Time Anchor"] = {
                DefaultKeybind = "Z",
                State = "Universal",
                Description = "Utility move. If a time anchor is placed down, detonate it after a short delay, knocking foes away with a powerful explosion.",
                Unlocked = false,
                LevelRequirement = 10
            },
            ["Playtime\'s Over"] = {
                DefaultKeybind = "H",
                State = "Universal",
                Description = "Ultimate move. Blink high into the air and summon a grandfather clock, thereafter sending it downwards with crashing force, causing a powerful shockwave that deals damage to surrounding targets and finally stopping time in an immense radius.",
                Unlocked = false,
                LevelRequirement = 120
            },
            ["Temporal Onslaught"] = {
                DefaultKeybind = "U",
                State = "FastForward",
                Description = "Beatdown move. Quickly dash forwards, knocking one target far away before unleashing a very powerful series of punches on them, ending with a destructive uppercut.",
                Unlocked = false,
                LevelRequirement = 110
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 11531351065,
            ["LMB-2"] = 11531353349,
            ["LMB-3"] = 11531355531,
            ["LMB-4"] = 11531357004,
            FastForward = 13202239849,
            Grab = 11110729280,
            Throw = 11110730939,
            ThrowVictim = 11110732132,
            Barrage = 11495782122,
            BarrageStartup = 11532429157,
            BarrageFinisher = 11532430783,
            CollapseSnap = 13607550172,
            Pummel = 11495784032,
            Kicks = 12991193431,
            Tremor = 11495874205,
            TemporalTemper = 13378939053,
            TimeAnchor = 11554345351,
            TimeAnchorHeld = 11554348452,
            Halt = 12685910874,
            RiposteStartup = 12778624155,
            RiposteAttack = 12779277284,
            FractureCast = 13084443326,
            ChronoResurrection = 13129303173,
            PoseIdle = 13277898975,
            PoseTransition = 13277897914,
            ResurrectedPoseIdle = 13167253468,
            ResurrectedPoseTransition = 13167255718,
            CannonCharge = 13326112234,
            Stage1Shot = 13326114152,
            Stage2Shot = 13326115127,
            Stage3Shot = 13326116041,
            OnslaughtAttempt = 13830918692,
            Onslaught = 13830920349,
            OnslaughtCamera = 13830921419,
            OnslaughtVictim = 13830922530,
            GrandfatherTimePunch = 14181211867,
            GrandfatherTimeStartup = 14181213845
        },
        Movement = {
            Walk = 11554463940,
            Run = 10982240350,
            ForwardDash = 10838677738,
            BackwardDash = 10838687030,
            LeftDash = 10838688196,
            RightDash = 10838689289,
            AwakenedRun = 13811919323,
            AwakenedIdle = 13129307898,
            AwakenedWalk = 13129304781
        },
        Idle = {
            Idle = 10660237915
        }
    },
    Stats = v1
};
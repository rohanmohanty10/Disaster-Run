  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("UserInputService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 25
    -- upvalues: u1 (ref), Knit (copy), u3 (ref), u4 (ref), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u3 = Knit.GetService("MoveInputService");
    u4 = Knit.GetService("PingService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local u5 = nil;
local u6 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 4
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Resources = require(script.Resources)
};
u6.Stats["Thunder Punches"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    Search = {
        Hitbox = {
            Size = 50,
            HitboxType = "ClientHitbox"
        }
    },
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Damage = 10,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 21, 25, "Attack" } },
        HitRemotes = { u6.Resources.Hit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = { u6.Resources.RushAttack1SFX }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Damage = 10,
        Speed = 1.5,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 16, 19, "Attack" } },
        HitRemotes = { u6.Resources.Hit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = { u6.Resources.RushAttack2SFX }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Damage = 10,
        Speed = 1.5,
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 19, 23, "Attack" } },
        HitRemotes = { u6.Resources.Hit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = { u6.Resources.RushAttack3SFX }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Damage = 10,
        Speed = 1.5,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Sequence = { { 0, "Start" }, { 20, 23, "Attack" } },
        HitRemotes = { u6.Resources.HeavyHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitSounds = { u6.Resources.RushAttack4SFX }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        PreAnim = function(p7, p8) -- Line: 184, Name: PreAnim
            -- upvalues: TableUtil (copy), u2 (ref), u1 (ref)
            local v9 = TableUtil.Copy(p7.Stats, true);
            local Player = p7.Player;
            local Character = p7.Character;
            local RootPart = p7.RootPart;

            if p8.MoveState.Count == 1 then
                local v10 = u2.Hitbox({
                    Caster = Character,
                    Stats = v9.Search
                });
                local v11 = {};

                for _, v in pairs(v10) do
                    local HumanoidRootPart = v.Character:FindFirstChild("HumanoidRootPart");

                    if HumanoidRootPart then
                        table.insert(v11, {
                            Character = v.Character,
                            Part = HumanoidRootPart,
                            Distance = (RootPart.Position - HumanoidRootPart.Position).Magnitude
                        });
                    end;
                end;

                table.sort(v11, function(p12, p13) -- Line: 211
                    return p12.Distance < p13.Distance;
                end);
                local v14 = v11[1];

                if v14 then
                    u2.PlaySound(Character, "Dash2");
                    u2.PlaySound(Character, "TeleportSFX");
                    local HumanoidRootPart = v14.Character:FindFirstChild("HumanoidRootPart");
                    local v15 = Vector3.new(RootPart.CFrame.Position.X, HumanoidRootPart.Position.Y, RootPart.CFrame.Position.Z);
                    local v16 = CFrame.lookAt(v15, HumanoidRootPart.Position);
                    local v17 = RaycastParams.new();
                    v17.FilterType = Enum.RaycastFilterType.Include;
                    v17.FilterDescendantsInstances = { workspace.Map };
                    local v18 = 6;
                    local v19 = u2.RaycastMap(HumanoidRootPart.Position, -v16.LookVector * v18);

                    if v19 then
                        v18 = (HumanoidRootPart.Position - v19.Position).Magnitude;
                    end;

                    local v20 = u2.GetMetadata(Character);
                    local v21 = HumanoidRootPart.Position + -v16.LookVector * (v18 - 2);
                    u1.FireAllClients("DS_LIGHTNING", {
                        Size = 2,
                        AnimationSpeed = 12,
                        Player = Player,
                        Character = Character,
                        Attach = v20.Position,
                        Attach2 = v21
                    });
                    u1.FireAllClients("Emit Particle V3", {
                        Path = "Particles/General/Teleport",
                        AutoSerialize = true,
                        Origin = RootPart,
                        Player = Player,
                        AbilityName = p7.AbilityName,
                        SkinName = p7.SkinName
                    });
                    RootPart.CFrame = CFrame.lookAt(v21, HumanoidRootPart.Position);
                end;
            end;
        end
    }
};
u6.Stats["Monk Shield"] = {
    From = "Combat.Block",
    Callbacks = {
        OnBlock = function(p22, p23) -- Line: 266, Name: OnBlock
            -- upvalues: AssetHandler (copy), ParticleHandler (copy)
            if p22.ActualPlayer and not p22.ActualPlayer:FindFirstChild("PersonalUnlocker") then
                return;
            end;

            local RootPart = p22.RootPart;
            local MonkShield = RootPart:FindFirstChild("MonkShield");

            if not MonkShield then
                MonkShield = AssetHandler.CloneAsset("Particles/General/MonkShield", p22);
                MonkShield.Parent = RootPart;
                ParticleHandler.AttachTo(MonkShield, {
                    Part = RootPart
                });
            end;

            ParticleHandler.EnableParticle(MonkShield, true);
        end,

        Unblock = function(p24, p25) -- Line: 286, Name: Unblock
            local MonkShield = p24.RootPart:FindFirstChild("MonkShield");

            if MonkShield then
                MonkShield:Destroy();
            end;
        end,

        Blocked = function(p26, p27) -- Line: 296, Name: Blocked
            -- upvalues: u2 (ref), u6 (copy)
            if p26.ActualPlayer and not p26.ActualPlayer:FindFirstChild("PersonalUnlocker") then
                return;
            end;

            for _ = 1, 10 do
                u2.Attack({
                    Attacker = p26.Character,
                    Target = p27.Attacker,
                    Stats = {
                        Damage = 2,
                        Ragdoll = {
                            Time = 1,
                            Intangible = false
                        },
                        HitRemotes = { u6.Resources.Hit }
                    }
                });
                task.wait(0.35);
            end;
        end
    }
};
u6.Stats["Thunderous Stride"] = {
    Distance = 20,
    Active = false,
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
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 1
    },

    Invoke = function(p28) -- Line: 358, Name: Invoke
        -- upvalues: Knit (copy)
        local Character = game.Players.LocalPlayer.Character;
        local Stats = p28.Stats;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        Knit.GetController("CombatController");
        Knit.GetController("MoveInputController");
        local v29 = Knit.GetService("MoveInputService");

        if Knit.CollectionService:HasTag(Character, "Timestopped") then
            return;
        end;

        local v30 = RaycastParams.new();
        v30.FilterType = Enum.RaycastFilterType.Exclude;
        v30.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
        local v31 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;
        local v32 = workspace:Raycast(HumanoidRootPart.Position, v31 * Distance, v30);

        if v32 then
            Distance = (HumanoidRootPart.Position - v32.Position).Magnitude;
        end;

        local Position = HumanoidRootPart.Position;
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v31).LookVector.Unit * Distance;
        v29:FireInput(p28.RawInput, Position, HumanoidRootPart.Position);
        task.wait(0.25);
    end
};
u6.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseLoop = function(u33, p34) -- Line: 404, Name: PoseLoop
            -- upvalues: u5 (ref), u2 (ref)
            if u5 then
                u5:Disconnect();
            end;

            u5 = p34.AnimLoop:GetMarkerReachedSignal("Zap"):Connect(function() -- Line: 409
                -- upvalues: u2 (ref), u33 (copy)
                u2.PlaySound(u33.Character, "ZapSFX");
            end);
        end,

        Transformer = function(p35) -- Line: 414, Name: Transformer
            -- upvalues: TableUtil (copy), u2 (ref)
            local v36 = Random.new():NextInteger(1, 2) == 1;
            local v37 = TableUtil.Copy(p35.Stats, true);
            v37.PoseMusic = "PoseMusic" .. (v36 and "Meditate" .. Random.new():NextInteger(1, 2) or "");
            v37.StartAnim = "PoseTransition" .. (v36 and "Meditate" or "");
            v37.LoopAnim = "PoseIdle" .. (v36 and "Meditate" or "");

            if not v36 then
                u2.PlaySound(p35.Character, "RapidSwings");
            end;

            return v37;
        end,

        PoseEnd = function(p38) -- Line: 428, Name: PoseEnd
            -- upvalues: u5 (ref)
            if u5 then
                u5:Disconnect();
            end;
        end
    }
};
u6.Stats.Breaker = {
    From = "Combat.Breaker"
};
u6.Stats.Grab = {
    From = "Combat.Grab",
    Grab = {
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        Ragdoll = {
            Time = 1.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
u6.Stats["Lightning Drop (Ground)"] = {
    Lightning = {
        Damage = 35,
        HitAnimations = "Default",
        Priority = Enums.Intangible.Ragdoll,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Predict = false,
            HitboxType = "ClientHitbox",
            Offset = CFrame.identity
        },
        Block = {
            Blockable = true,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = -25,
            Time = 0.3,
            Velocity = Vector3.new(0, 20, 0)
        },
        HitSounds = { u6.Resources.LightningGroundSFX }
    },
    Detect = {
        Priority = Enums.Intangible.Ragdoll,
        Block = {
            Blockable = false,
            BlockBreak = false,
            PerfectBlockable = false
        },
        Hitbox = {
            HitboxType = "ClientHitbox",
            Size = 75
        }
    }
};
u6.Stats["Lightning Drop (Air)"] = {
    Damage = 30,
    Priority = Enums.Intangible.Ragdoll,
    Ragdoll = {
        Time = 2,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    KnockbackData = { {
            RelativePart = "Attacker",
            Speed = 0,
            Velocity = Vector3.new(0, 60, 0),
            Time = 0.5
        }, {
            Type = "Force",
            Force = Vector3.new(0, 250, 0),
            Time = 0.85
        } },
    Hitbox = {
        RelativePart = "Attacker",
        Size = 25,
        HitboxType = "ClientHitbox"
    },
    HitRemotes = { u6.Resources.HeavyHit }
};
u6.Stats["Seismic Toss"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true,
        Client = false
    },
    Meter = {
        RequiredAmount = 25
    },
    Startup = {
        Grab = true,
        Damage = 15,
        MinHealth = 1,
        Priority = Enums.Intangible.Ragdoll,
        Stun = {
            Time = 0.75
        },
        Block = {
            BlockBreak = false,
            Blockable = false,
            PerfectBlockable = false
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8, 8, 8),
            HitboxType = "ClientHitbox",
            Offset = CFrame.new(0, 0, -4)
        },
        HitRemotes = { u6.Resources.HeavyHit }
    },
    Release = {
        Damage = 5,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 48,
                Velocity = Vector3.new(0, 48, 0),
                Time = 0.5
            }, {
                Type = "Force",
                Force = Vector3.new(0, 250, 0),
                Time = 0.85
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        }
    },
    Finish = {
        Damage = 30,
        Priority = Enums.Intangible.Move,
        Ragdoll = {
            Time = 2.5,
            Intangible = Enums.Intangible.SoftRagdoll
        },
        KnockbackData = { {
                RelativePart = "Attacker",
                Speed = 48,
                Velocity = Vector3.new(0, 48, 0),
                Time = 0.5
            } },
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        HitRemotes = { u6.Resources.HeavyHit }
    }
};
u6.Stats["Thundering Leap"] = {
    Active = true,
    Damage = 30,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Priority = Enums.Intangible.Move,
    Ragdoll = {
        Time = 2,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Hitbox = {
        RelativePart = "Attacker",
        Size = 25,
        HitboxType = "ClientHitbox"
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Velocity = Vector3.new(0, 20, 0),
        Time = 0.5
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false
    }
};
u6.Stats["Lightning Elbow"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 8
    },
    Hitbox = {
        Size = Vector3.new(8.5, 8.5, 30),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -15)
    },
    Block = {
        Blockable = false,
        BlockBreak = true,
        PerfectBlockable = false
    },
    Priority = Enums.Intangible.Ragdoll,
    Ragdoll = {
        Time = 1.5,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.3,
        Velocity = Vector3.new(0, 30, 0)
    }
};
u6.Stats["Lightning Drop"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Invoke = u6.Resources.AirInvoke
};
u6.Stats["Electric Smite"] = {
    Active = true,
    Damage = 35,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 10
    },
    Meter = {
        RequiredAmount = 25
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 20,
        HitboxType = "ClientHitbox",
        Offset = CFrame.identity
    },
    Block = {
        Blockable = true,
        BlockBreak = false,
        PerfectBlockable = false
    },
    Priority = Enums.Intangible.Ragdoll,
    Ragdoll = {
        Time = 1.5,
        Intangible = Enums.Intangible.SoftRagdoll
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 0,
        Time = 0.3,
        Velocity = Vector3.new(0, -300, 0)
    },
    Search = {
        Hitbox = {
            Size = 50,
            HitboxType = "ClientHitbox"
        }
    }
};
u6.Stats["Shoulder Throw"] = {
    From = "Uber Oni.Shoulder Throw"
};

return u6;
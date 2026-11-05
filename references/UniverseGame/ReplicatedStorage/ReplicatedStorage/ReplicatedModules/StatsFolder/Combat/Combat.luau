  

 

local v1 = {};
({}).Combat = v1;
local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local AnimationHandler = require(PathShortcuts.ReplicatedModules.AnimationHandler);
local Trove = require(Knit.Util.Trove);
require(Knit.Util.Promise);
local EnumsModule = require(PathShortcuts.EnumsModule);
local CollectionService = game:GetService("CollectionService");
game:GetService("UserInputService");
local u2 = game.ReplicatedStorage:WaitForChild("Client Assets");
require(PathShortcuts.AnimsModule);
v1.Summon = {
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        InterruptQuickstep = false,
        Active = {},

        Check = function(p3) -- Line: 99, Name: Check
            return not p3:GetAttribute("SummonDisabled");
        end
    },
    Cooldown = {
        Time = 1
    }
};
v1["Rush Attack"] = {
    Active = true,
    AttackPriority = "Light",
    Actionable = {
        Stunned = true,
        Disabled = true,
        InterruptQuickstep = false,
        Active = {
            Ignore = { "Rush Attack Endlag" }
        },

        Check = function(p4) -- Line: 121, Name: Check
            return not p4:GetAttribute("LMBDisabled");
        end
    }
};
v1.Barrage = {
    Active = true,
    AttackPriority = "Light",
    Actionable = {
        Active = true
    },
    Sequence = { { 0, "BarrageStart" }, { 0, "PlaySound", "Barrage", {
                Cancelable = true
            } }, { 0, "PlaySound", "BarrageVoiceline", {
                Cancelable = true
            } }, { 23, "Cancelable", true }, { 24, "Clashable", true }, { 24, "Barrage", true }, { 24, 144, "BarrageAttack", "Hit" }, { 144, "Cancelable", false }, { 144, "Clashable", false }, { 144, "BarrageFinisher" }, { 163, "BarrageAttack", "Finisher" }, { 193, "End" } },
    ClashSequence = { { 0, "BarrageStart" }, { 0, "StopSound", "BarrageVoiceline" }, { 0, "PlaySound", "ClashVoiceline" }, { 0, "Clashable", false }, { 0, "Clash" }, { 0, "Barrage", true }, { 0, 60, "ClashAttack", "ClashHit" }, { 0, 60, "ClashRotate", true }, { 61, "ClashEnd" }, { 61, "ClashAttack", "ClashFinisher" }, { 64, "End" } },
    ClashFinisher = {
        Knockback = {
            RelativePart = "Attacker",
            Speed = 48,
            Time = 0.25
        }
    }
};
v1.Grab = {
    Active = true,
    AttackPriority = "Medium",
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 10,
        Manual = false,
        AfterMove = true
    },
    Grab = {
        CheckPVPSafe = true,
        Stun = {
            Time = 1,
            Priority = EnumsModule.Stun.Heavy
        },
        Hitbox = {
            Size = Vector3.new(6, 5.5, 7),
            Debug = false,
            Offset = CFrame.new(0, 0, -4),
            PilotData = {
                Size = Vector3.new(6, 5.5, 6),
                RelativePart = "Stand.StandHumanoidRootPart"
            }
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    },
    Throw = {
        Damage = 30,
        Priority = EnumsModule.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = EnumsModule.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativePart = "Attacker",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.2
            }, {
                Type = "AngularVelocity",
                RelativePart = "Attacker",
                RelativeVelocity = Vector3.new(12, 0, 0),
                Time = 0.2
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v1.Breaker = {
    Active = false,
    Actionable = {
        Active = false,
        Summoned = false,
        Stunned = false,
        Disabled = false,
        Ragdolled = false
    },
    ClientActionable = {
        Active = false,
        Summoned = false,
        Stunned = false,
        Disabled = false,
        Ragdolled = false
    },
    Check = {
        Stunned = false,
        Disabled = true,
        Ragdolled = true,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Name = "Breaker",
        Time = 5
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
        Size = 21,
        Debug = false
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 48,
        Time = 0.3
    }
};
v1.Block = {
    AllowClientStacking = true,
    Active = false,
    BlockTime = 0.3,
    Resistance = 0.2,
    PerfectResistance = 0.2,
    PerfectBlockWindow = 0.2,
    Actionable = {
        Active = false,
        Summoned = false,
        Stunned = false,
        Disabled = false,
        Ragdolled = false
    },
    Check = {
        Stunned = true,
        Disabled = true,
        Ragdolled = true,
        Active = {
            Ignore = { "Block", "Block_Client" }
        }
    },
    Cooldown = {
        Name = "Block",
        Time = 0.25,
        AfterMove = true,
        Manual = true
    },
    Indicators = { {
            Group = "Universal",
            InputText = "%s",
            Visible = true
        } },
    Offset = CFrame.new(0, 0.75, -2),
    SummonedOffset = CFrame.new(0, 0.75, -4.25)
};
v1.Quickstep = {
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
        Time = 1.5,
        Force = true,
        CooldownReduction = false
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },

    Invoke = function(p5) -- Line: 594, Name: Invoke
        -- upvalues: Knit (copy), TagService (copy), AnimationHandler (copy), CollectionService (copy), Trove (copy)
        local v6 = Knit.GetController("CombatController");
        local v7 = Knit.GetController("PilotController");
        local v8 = Knit.GetService("MoveInputService");
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        TagService:GetContainer(LocalPlayer);
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local u9 = AnimationHandler.Get(Humanoid.Animator);
        local ActivePilot = v7.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v10 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        v8:FireInput(p5.RawInput);

        local function Lerp(p11, p12, p13) -- Line: 622
            return p11 + (p12 - p11) * p13;
        end;

        local v14 = 120;
        local v15 = 20;

        if Character:GetAttribute("KenHaki") then
            v14 = v14 * 1.25;
            v15 = v15 * 1.25;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = v10 * v14;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = HumanoidRootPart;
        local AlignOrientation = Instance.new("AlignOrientation");
        AlignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment;
        AlignOrientation.Attachment0 = HumanoidRootPart.RootAttachment;
        AlignOrientation.RigidityEnabled = true;
        AlignOrientation.CFrame = HumanoidRootPart.CFrame;
        AlignOrientation.Parent = HumanoidRootPart;
        local v16 = HumanoidRootPart.CFrame:VectorToObjectSpace(v10);
        local v17 = math.atan2(v16.X, -v16.Z);
        local v18 = math.deg(v17) - 0.5;
        local v19 = math.ceil(v18);
        local v20 = p5.Stats.CustomPrefix or (ActivePilot and "Pilot" or "");
        local v21;

        if v19 > 45 then
            v21 = v19 < 135;
        else
            v21 = false;
        end;

        local v22;

        if v19 < -45 then
            v22 = v19 > -135;
        else
            v22 = false;
        end;

        local v23 = v21 and "Right" or (v22 and "Left" or ((v19 <= -135 and true or v19 >= 135) and "Backward" or "Forward"));
        local u24 = (CollectionService:HasTag(Character, "Summoned") and u9:GetAnimation("Summoned" .. v20 .. v23 .. "Dash") and "Summoned" or "") .. v20 .. v23 .. "Dash";
        u9:PlayAnimation(u24, 0.9);
        local u25 = false;
        local v26 = Trove.new();
        v26:Add(v6.QuickstepInterrupted:Connect(function() -- Line: 681
            -- upvalues: u25 (ref), u9 (copy), u24 (copy)
            u25 = true;
            u9:StopAnimation(u24, 0.9);
        end));
        local v27 = os.clock();

        while not u25 and os.clock() - v27 <= 0.25 do
            local v28 = os.clock() - v27;
            local v29 = math.abs(v28) / 0.25;
            local v30 = math.clamp(v29, 0, 1);
            BodyVelocity.Velocity = v10 * math.clamp(v14 + (v15 - v14) * v30, v15, v14);
            task.wait();
        end;

        BodyVelocity:Destroy();
        AlignOrientation:Destroy();

        if u25 then
            local v31 = os.clock() - v27;
            local v32 = math.abs(v31) / 0.25;
            local v33 = math.clamp(v32, 0, 1);
            local v34 = math.lerp(v33, 1, 0.5);
            local v35 = math.min(v34, 1);
            local v36 = math.lerp(v14, v15, v35);
            HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v10.X * v36, HumanoidRootPart.AssemblyLinearVelocity.Y, v10.Z * v36);
        end;

        v26:Destroy();
    end
};
v1.Pose = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Indicators = { {
            Group = "Universal",
            InputText = "%s",
            Visible = true
        } },
    Cooldown = {
        Name = "Pose",
        Time = 2,
        Manual = true
    }
};
v1.Quote = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    }
};
v1["Timestop Movement"] = {
    Time = 5,
    Actionable = {
        Timestopped = false
    },
    Meter = {
        RequiredLevel = 1,
        RemoveMeter = false
    }
};
v1["Remote Control"] = {
    Active = true,
    Startup = 0.3,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    StartCooldown = {
        Name = "Remote Control",
        Time = 0.4
    },
    EndCooldown = {
        Name = "Remote Control",
        Time = 1.5
    },

    Invoke = function(p37) -- Line: 769, Name: Invoke
        -- upvalues: Knit (copy), PathShortcuts (copy), u2 (copy)
        local _ = p37.Input;
        local Stats = p37.Stats;
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v38 = LocalPlayer:GetMouse();
        local v39 = Character:GetAttribute("CurrentAbility");

        if v39 and Stats[v39] then
            Stats = Stats[v39];
        end;

        Knit.GetService("MoveInputService"):FireInput(p37.RawInput, v38.Hit.Position):await();

        if Knit.CollectionService:HasTag(Character, "Piloting") then
            local AnimationHandler2 = require(PathShortcuts.ReplicatedModules.AnimationHandler);
            local v40 = Knit.GetController("PilotController");
            local v41 = v40:GetPilot(Character);

            if v41 then
                local v42 = AnimationHandler2.Get(Character.Humanoid.Animator);
                local v43 = v42:GetAnimation("SummonedIdle") or v42:GetAnimation("StandIdle");

                if v43 then
                    v43:Stop();
                end;

                v40:Control(v41, {
                    HookWalkSpeed = true,
                    HookJumpPower = true,
                    HookJump = true,
                    HookAutoRotate = true,
                    Animations = Stats.Animations,
                    Radius = Stats.Radius or u2.Whitesnake.PilotRadius,

                    Check = function() -- Line: 802, Name: Check
                        -- upvalues: Knit (ref), Character (copy)
                        return Knit.CollectionService:HasTag(Character, "Piloting");
                    end
                });
            end;
        end;
    end
};
v1.Teleport = {
    Distance = 20,
    Active = true,
    Actionable = {
        Active = true
    },
    ClientActionable = {
        Active = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    Cooldown = {
        Time = 8
    },

    Invoke = function(p44) -- Line: 835, Name: Invoke
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
        v46.FilterDescendantsInstances = { Character, workspace.Effects, workspace.ItemSpawns };
        local v47 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        local Distance = Stats.Distance;
        local v48 = workspace:Raycast(HumanoidRootPart.Position, v47 * Distance, v46);

        if v48 then
            Distance = (HumanoidRootPart.Position - v48.Position).Magnitude;
        end;

        local v49 = HumanoidRootPart.CFrame + CFrame.lookAt(HumanoidRootPart.Position, HumanoidRootPart.Position + v47).LookVector.Unit * Distance;
        v45:FireInput(p44.RawInput, v49);
        task.wait(0.25);
    end
};
v1["Haoshoku Haki"] = {
    Active = true,
    CheckPVPSafe = true,
    Time = 2.5,
    Lock = 10,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 100
    },
    Cooldown = {
        Time = 50,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 15,
        Offset = CFrame.identity
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 10,
        Time = 0.1
    },
    Stun = {
        Time = 2
    },
    Block = {
        Unblockable = true,
        BypassCounter = true,
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    }
};
v1[" 2154 Busoshoku Haki"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 120,
        Manual = true
    }
};
v1["Kenbunshoku Haki"] = {
    Active = true,
    MinDodge = 6,
    MaxDodge = 100,
    MinSpeed = 18,
    MaxSpeed = 32,
    Increment = 3,
    Timescale = 1.05,
    Duration = 25,
    Knockdown = 2,
    Distance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 52,
        Manual = true
    }
};

return {
    Name = "Combat",
    Stats = v1
};
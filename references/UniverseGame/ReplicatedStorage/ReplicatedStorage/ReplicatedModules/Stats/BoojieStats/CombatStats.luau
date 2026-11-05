  

 

local v1 = {};
local v2 = {};
v1.Combat = v2;
local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local EnumsModule = require(PathShortcuts.EnumsModule);
local u3 = game.ReplicatedStorage:WaitForChild("Client Assets");
local AnimsModule = require(PathShortcuts.AnimsModule);
v2.Summon = {
    Actionable = {
        Stunned = true,
        Disabled = true,
        Summoned = false,
        Active = {
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 1,
        Manual = false,
        AfterMove = false
    }
};
v2["Rush Attack"] = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
        Active = {
            Ignore = { "Rush Attack Endlag", "Quickstep" }
        }
    }
};
v2.Barrage = {
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
v2.Grab = {
    Active = true,
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
        Stun = {
            Time = 0.7,
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
            Time = 0.3
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
v2.Block = {
    Active = false,
    BlockTime = 0.3,
    Resistance = 0.2,
    PerfectResistance = 0.2,
    PerfectBlockWindow = 0.2,
    Actionable = {
        Active = false,
        Summoned = false,
        Stunned = false,
        Disabled = false
    },
    Check = {
        Active = true,
        Stunned = true,
        Disabled = true,
        Ragdolled = true
    },
    Cooldown = {
        Name = "Block",
        Time = 0.3,
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
v2.Quickstep = {
    Active = true,
    Actionable = {
        Stunned = true,
        Disabled = true,
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
            Ignore = { "Block" }
        }
    },
    Cooldown = {
        Time = 1.5,
        Manual = false,
        AfterMove = true
    },
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },

    Invoke = function(p4) -- Line: 408, Name: Invoke
        -- upvalues: TagService (copy), Knit (copy), AnimsModule (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v5 = TagService:GetContainer(LocalPlayer);

        if v5 and TagService:Get(v5, "DisableInputs") then
            return;
        end;

        local _ = p4.Input;
        local v6 = Knit.GetController("CombatController");
        local v7 = Knit.GetController("PilotController");
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local ActivePilot = v7.ActivePilot;

        if ActivePilot then
            Humanoid = ActivePilot:FindFirstChild("Humanoid") or Humanoid;
            HumanoidRootPart = ActivePilot:FindFirstChild("HumanoidRootPart") or HumanoidRootPart;
        end;

        local v8 = LocalPlayer.Data.Ability:GetAttribute("AbilityName");
        local v9 = Humanoid.MoveDirection == Vector3.new(0, 0, 0) and -HumanoidRootPart.CFrame.LookVector or Humanoid.MoveDirection;
        Knit.GetService("MoveInputService"):FireInput(p4.RawInput, v9);

        local function Lerp(p10, p11, p12) -- Line: 434
            return p10 + (p11 - p10) * p12;
        end;

        v6.SetActive(Character, "Quickstep_Client", {
            Priority = v6.Enums.Active.Main
        });
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Velocity = v9 * 75;
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Parent = HumanoidRootPart;
        local v13 = HumanoidRootPart.CFrame:VectorToObjectSpace(v9);
        local v14 = math.atan2(v13.X, -v13.Z);
        local v15 = math.deg(v14) - 0.5;
        local v16 = math.ceil(v15);
        AnimsModule.playClient(v8, (ActivePilot and "Pilot" or "") .. (v16 > 45 and v16 < 135 and "Right" or (v16 < -45 and v16 > -135 and "Left" or ((v16 <= -135 or v16 >= 135) and "Backward" or "Forward"))) .. "Dash", nil, 0.9);
        local v17 = os.clock();

        while os.clock() - v17 <= 0.25 do
            local v18 = os.clock() - v17;
            local v19 = math.abs(v18) / 0.25;
            local v20 = 75 + -62.5 * math.clamp(v19, 0, 1);
            BodyVelocity.Velocity = v9 * math.clamp(v20, 12.5, 75);
            task.wait();
        end;

        BodyVelocity:Destroy();
        v6.SetActive(Character, "Quickstep_Client", nil);
    end
};
v2.Pose = {
    Active = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true,
        Summoned = false
    },
    Cooldown = {
        Name = "Pose",
        Time = 2,
        Manual = true
    }
};
v2.Quote = {
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    }
};
v2["Timestop Movement"] = {
    Active = false,
    Time = 6,
    Actionable = {
        Stunned = false,
        Active = false,
        Disabled = true,
        Timestopped = false
    }
};
v2["Remote Control"] = {
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

    Invoke = function(p21) -- Line: 537, Name: Invoke
        -- upvalues: Knit (copy), u3 (copy)
        local _ = p21.Input;
        local Stats = p21.Stats;
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local v22 = LocalPlayer:GetMouse();
        Knit.GetService("MoveInputService"):FireInput(p21.RawInput, v22.Hit.Position):await();

        if Knit.CollectionService:HasTag(Character, "Piloting") then
            local v23 = Knit.GetController("AnimationController");
            local v24 = Knit.GetController("PilotController");
            local v25 = v24:GetPilot(Character);

            if v25 then
                local v26 = v23.Get(Character.Humanoid.Animator):GetAnimation("StandIdle");

                if v26 then
                    v26:Stop();
                end;

                v24:Control(v25, {
                    HookWalkSpeed = true,
                    HookJumpPower = true,
                    HookJump = true,
                    HookAutoRotate = true,
                    Animations = Stats.Animations,
                    Radius = Stats.Radius or u3.Whitesnake.PilotRadius,

                    Check = function() -- Line: 565, Name: Check
                        -- upvalues: Knit (ref), Character (copy)
                        return Knit.CollectionService:HasTag(Character, "Piloting");
                    end
                });
            end;
        end;
    end
};

return v1;
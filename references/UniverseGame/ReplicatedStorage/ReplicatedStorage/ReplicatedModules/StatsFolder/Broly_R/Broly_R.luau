  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
local v1 = ReplicatedStorage["Client Assets"];
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = Color3.fromRGB(255, 255, 255)
        }
    }
};
local v4 = {
    Breaker = {
        From = "Combat.Breaker"
    },
    Headbutt = {
        Active = true,
        AttackPriority = "Medium",
        Distance = 30,
        CheckPVPSafe = true,
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
        Stun = {
            Time = 1,
            Priority = Enums.Stun.Heavy
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            HitboxType = "ClientHitbox",
            Tolerance = 15,
            Size = Vector3.new(7, 6, 7),
            Offset = CFrame.new(0, 0, -7)
        },
        HeadHit = {
            Damage = 10,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 0.5,
                Priority = Enums.Stun.Heavy
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                Unblockable = true
            },
            HitRemotes = { v2 }
        },
        Throw = {
            Damage = 20,
            Priority = Enums.Intangible.Move,
            Stun = {
                Time = 0.3,
                Priority = Enums.Stun.Heavy
            },
            KnockbackData = { {
                    Type = "Velocity",
                    RelativePart = "Attacker",
                    Velocity = Vector3.new(-20, 30, 0),
                    Speed = 65,
                    Time = 0.15
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
    }
};
local v5 = {
    Active = true,
    AttackPriority = "Medium",
    Damage = 5,
    CheckPVPSafe = true,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 13,
        AfterMove = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    },
    Stun = {
        Time = 1.5,
        Priority = Enums.Stun.Medium
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 7),
        Offset = CFrame.new(0, 0, -5)
    },
    HitRemotes = { v2 },
    Hit = {
        Damage = 8,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 1.5,
            Priority = Enums.Stun.Medium
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        },
        HitRemotes = { v3 }
    }
};
local v6 = {
    Damage = 8,
    Priority = Enums.Intangible.SoftRagdoll,
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(22, 0.5, 22),
        Offset = CFrame.new(0, -2.5, 0)
    },
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true
    }
};
local v7 = {
    Speed = 50,
    Time = 0.2,
    Override = true
};
local v8 = math.random(25, 45);
v7.Velocity = Vector3.new(0, v8, 0);
v6.Knockback = v7;
v6.HitRemotes = { v2 };
v6.Ragdoll = {
    Time = 1.75,
    Intangible = false
};
v5.AoE = v6;
v5.Throw = {
    Priority = Enums.Intangible.Move,
    Stun = {
        Time = 0.5,
        Priority = Enums.Stun.Heavy
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 50,
        Time = 0.1,
        Override = true,
        Velocity = Vector3.new(5, 5, 0)
    },
    Ragdoll = {
        Time = 1
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        BypassCounter = true,
        Unblockable = true
    }
};
v4["Gigantic Fury"] = v5;
v4["Wrathful Uppercut"] = {
    Active = true,
    AttackPriority = "Medium",
    Damage = 35,
    Actionable = {
        Stunned = true,
        Active = true,
        Disabled = true
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Block = {
        PerfectBlockable = true,
        Unblockable = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Time = 0.3,
        Speed = 70,
        Override = true,
        Velocity = Vector3.new(0, 60, 0)
    },
    HitRemotes = { v3 },
    Stun = {
        Time = 1.5,
        Priority = Enums.Stun.Medium
    },
    Ragdoll = {
        Time = 3
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(7, 7, 7),
        Offset = CFrame.new(0, 0, -5)
    }
};
v4.Block = {
    From = "Combat.Block"
};
v4.Quickstep = {
    From = "Combat.Quickstep"
};
v4.Breaker = {
    From = "Combat.Breaker"
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            Passives = {
                Visible = false,
                Priority = 4
            }
        },
        MovesInfo = {
            ["GO BROLY GO GO"] = {
                State = "Passives",
                Description = "As the Legendary Super Saiyan, your imposing stature towers over others, and your monstrous power grants you greater vitality than most."
            },
            Block = {
                DefaultKeybind = "F",
                DefaultConsoleKeybind = "ButtonR1",
                DefaultDPadDirection = 0,
                Equipped = true
            },
            Quickstep = {
                DefaultKeybind = "C",
                DefaultConsoleKeybind = "ButtonL1",
                DefaultDPadDirection = 0,
                Equipped = true
            },
            Headbutt = {
                DefaultKeybind = "X",
                Equipped = true
            },
            ["Wrathful Uppercut"] = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Gigantic Fury"] = {
                DefaultKeybind = "G+",
                Equipped = true
            }
        }
    },
    Animations = {
        Action = {
            ForwardDash = 10451361960,
            BackwardDash = 10451359576,
            LeftDash = 10451363828,
            RightDash = 10451365211,
            ["Headbutt Attempt"] = 81801633551563,
            ["Headbutt Player"] = 106931114436647,
            ["Headbutt Enemy"] = 112547451940359,
            ["Gigantic Fury Attempt"] = 80513765903738,
            ["Gigantic Fury Player"] = 138302988106123,
            ["Gigantic Fury Enemy"] = 111681266832225,
            ["Wrathful Uppercut"] = 108046345521236
        },
        Movement = {
            Walk = 76511688218436,
            Run = 139710033477461
        },
        Idle = {
            Idle = 131521179501063
        }
    },
    Metadata = {
        PostRig = function(p9) -- Line: 416, Name: PostRig
            local _ = p9.Player;
            local Character = p9.Character;
            local Trove = p9.Trove;
            local u10 = Trove:Extend();
            local v11 = os.time();

            while not Character:IsDescendantOf(workspace) and os.time() - v11 < 3 do
                task.wait(0.1);
            end;

            local u12 = Character:FindFirstChildOfClass("Humanoid");

            if u12 then
                local function ApplyHealthBonus() -- Line: 432
                    -- upvalues: u12 (copy)
                    local v13 = u12:GetAttribute("BaseHealth");

                    if not v13 then
                        return;
                    end;

                    local v14 = v13 + 50;
                    u12:SetAttribute("BaseHealth", v14);
                    u12.MaxHealth = v14;
                    u12.Health = u12.Health + 50;
                end;

                if u12:GetAttribute("BaseHealth") then
                    local v15 = u12:GetAttribute("BaseHealth");

                    if v15 then
                        local v16 = v15 + 50;
                        u12:SetAttribute("BaseHealth", v16);
                        u12.MaxHealth = v16;
                        u12.Health = u12.Health + 50;
                    end;
                else
                    u10:Connect(u12:GetAttributeChangedSignal("BaseHealth"), function() -- Line: 444
                        -- upvalues: u10 (copy), u12 (copy)
                        u10:Destroy();
                        local v17 = u12:GetAttribute("BaseHealth");

                        if not v17 then
                            return;
                        end;

                        local v18 = v17 + 50;
                        u12:SetAttribute("BaseHealth", v18);
                        u12.MaxHealth = v18;
                        u12.Health = u12.Health + 50;
                    end);
                end;
            end;

            local v19 = Character:GetAttribute("OriginalScale");

            if not v19 then
                v19 = Character:GetScale();
                Character:SetAttribute("OriginalScale", v19);
            end;

            local v20 = v19 * 1.15;
            Character:ScaleTo(v20);
            local u21 = v20 / v19;
            Trove:Connect(Character.ChildAdded, function(p22) -- Line: 463
                -- upvalues: u21 (copy)
                local u23 = p22:IsA("Accessory") and p22:FindFirstChild("Handle");

                if u23 then
                    task.defer(function() -- Line: 467
                        -- upvalues: u23 (copy), u21 (ref)
                        local v24 = u23:GetAttribute("OriginalSize");

                        if not v24 then
                            v24 = u23.Size;
                            u23:SetAttribute("OriginalSize", v24);
                        end;

                        u23.Size = v24 * u21;
                    end);
                end;
            end);
        end
    },
    Stats = v4,
    Sounds = {}
};
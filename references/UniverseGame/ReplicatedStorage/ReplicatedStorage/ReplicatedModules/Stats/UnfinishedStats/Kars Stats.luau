  

 

game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Enums = require(game.ReplicatedStorage.ReplicatedModules.Enums);
require(game.ReplicatedStorage.ClientModules.InputTracker);
local _ = ReplicatedStorage.Remotes.InputFunc;
local _ = ReplicatedStorage.Remotes.Output;
local _ = ReplicatedStorage["Client Assets"];
local _ = CFrame.Angles;
local _ = math.rad;

({
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
}).ExtraCheck = function(p1) -- Line: 21, Name: ExtraCheck
    -- upvalues: CollectionService (copy)
    return not CollectionService:HasTag(p1.Character, "Tandeming");
end;

local function customWait(p2) -- Line: 29
    -- upvalues: RunService (copy)
    local v3 = 0;

    repeat
        v3 = v3 + RunService.RenderStepped:Wait();
    until (p2 or 0) <= v3;

    return v3;
end;

local function rayCast(p4, p5, p6) -- Line: 36
    local v7 = RaycastParams.new();
    local v8 = {};

    for _, descendant in pairs(workspace.Living:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide == true then
            table.insert(v8, 1, descendant);
        end;
    end;

    v7.FilterDescendantsInstances = v8;
    v7.FilterType = Enum.RaycastFilterType.Whitelist;
    local v9 = workspace:Raycast(p4, p5, v7);

    if p6 then
        return v9;
    end;

    if v9 then
        return v9.Position, v9.Instance;
    end;

    return p4;
end;

local function raycastMap(p10, p11, p12) -- Line: 56
    local v13 = RaycastParams.new();
    local v14 = {};

    for _, descendant in ipairs(workspace.Map:GetDescendants()) do
        if descendant:IsA("BasePart") and descendant.CanCollide then
            table.insert(v14, descendant);
        end;
    end;

    v13.FilterDescendantsInstances = v14;
    v13.FilterType = Enum.RaycastFilterType.Whitelist;
    local v15 = workspace:Raycast(p10, p11, v13);

    if p12 then
        return v15;
    end;

    if v15 then
        return v15.Position, v15.Instance;
    end;

    return p10;
end;

local function CheckSummoner(p16) -- Line: 77
    local v17 = game.Players:GetPlayerFromCharacter(p16) or p16;

    return not (v17:FindFirstChild("Values") and v17.Values:FindFirstChild("Summoner")) and "" or v17.Values.Summoner.Value;
end;

local function findNearest(p18, p19, p20, p21, p22) -- Line: 86
    -- upvalues: CollectionService (copy)
    local v23 = p21 or {};

    if p20 then
        local v24 = {};

        for _, v in ipairs(p22 or workspace.Living:GetChildren()) do
            if v:IsA("Player") then
                local v = v.Character or v;
            end;

            if CollectionService:HasTag(v, "Hitable") and not table.find(v23, v) then
                local v25 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

                if v25 and (v25.Position - p18.Position).Magnitude <= p19 then
                    table.insert(v24, v);
                end;
            end;
        end;

        return v24;
    end;

    local v26 = nil;

    for _, v in ipairs(p22 or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if CollectionService:HasTag(v, "Hitable") and not table.find(v23, v) then
            local v27 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v27 then
                local Magnitude = (v27.Position - p18.Position).Magnitude;

                if Magnitude < p19 then
                    v26 = v;
                    p19 = Magnitude;
                end;
            end;
        end;
    end;

    return v26, p19;
end;

return {
    Kars = {
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Universal = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = {
                Endlag = 0.2,
                Speed = 1,
                Damage = 8,
                HitAnimations = "Default",
                Sequence = {},
                Stun = {
                    Time = 0.4,
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
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 6),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                }
            },
            ["LMB-4"] = {
                Cooldown = 0.75,
                Damage = 25,
                HitAnimations = "Default",
                Sequence = {},
                Stun = {
                    Time = 0.3
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 64,
                    Time = 0.2
                }
            }
        },
        EMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Name = "Ricochet Storm",
                    CooldownName = "E-RicochetStorm",
                    ActiveName = "EMoves",
                    Visible = true
                }, {
                    Group = "LightDancer",
                    Name = "Singularity Slice",
                    CooldownName = "E-SingularitySlice",
                    ActiveName = "EMoves",
                    Visible = true
                } },
            Active = true,
            ["Ricochet Storm"] = {
                Cooldown = {
                    Name = "E-RicochetStorm",
                    DisplayName = "Ricochet Storm",
                    Time = 1
                },
                Length = 4,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 5.3),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -1.5)
                },
                Block = {
                    PerfectBlockable = false,
                    BlockBreak = true
                },
                Damage = 1,
                Stun = {
                    Time = 0.7,
                    Priority = Enums.Stun.Medium
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 1,
                    Time = 0.1
                },
                HitAnimations = "Default",
                Finisher = {
                    Damage = 16,
                    HitAnimations = "Default",
                    Hitbox = {
                        Type = "Region3",
                        RelativePart = "HumanoidRootPart",
                        Size = Vector3.new(5.3, 5.3, 5.3),
                        Debug = false,
                        Offset = CFrame.new(0, 0, -1.5)
                    },
                    Block = {
                        BlockBreak = true
                    },
                    Stun = {
                        Time = 0.35,
                        Priority = Enums.Stun.Medium
                    },
                    Knockback = {
                        RelativePart = "Attacker",
                        Speed = 64,
                        Time = 0.2
                    }
                }
            },
            ["Singularity Slice"] = {
                Cooldown = {
                    Name = "E-RicochetStorm",
                    DisplayName = "Ricochet Storm",
                    Time = 1
                }
            }
        },
        ["Bug Crusher"] = {
            Active = true,
            Damage = 30,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = false,
                Offset = CFrame.new(0, 0, -1.5)
            },
            Block = {
                BlockBreak = true
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 20,
                Time = 0.2
            },
            Ragdoll = {
                Time = 1.5
            }
        },
        ["Guttural Implant"] = {
            Active = true,
            Damage = 16,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = false,
                Offset = CFrame.new(0, 0, -1.5)
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false,
                BlockBreak = true
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Time = 0.2
            }
        },
        YMoves = {
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Name = "Cruel Ambitions",
                    CooldownName = "Y-CruelAmbitions",
                    ActiveName = "YMoves",
                    Visible = true
                }, {
                    Group = "LightDancer",
                    Name = "Visceral Animosity",
                    CooldownName = "Y-VisceralAnimosity",
                    ActiveName = "YMoves",
                    Visible = true
                } },
            Active = true,
            ["Cruel Ambitions"] = {
                Cooldown = {
                    Name = "Y-CruelAmbitions",
                    DisplayName = "Cruel Ambitions",
                    Time = 1
                }
            },
            ["Visceral Animosity"] = {
                Cooldown = {
                    Name = "Y-VisceralAnimosity",
                    DisplayName = "Visceral Animosity",
                    Time = 1
                }
            }
        },
        Absorption = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        ["Blade Technique"] = {
            Active = true,
            Damage = 25,
            HitAnimations = "Default",
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = false,
                Offset = CFrame.new(0, 0, -1.5)
            },
            Block = {
                PerfectBlockable = false
            },
            Stun = {
                Time = 1,
                Priority = Enums.Stun.Medium
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 15,
                Time = 0.2,
                Velocity = Vector3.new(0, 30, 0)
            },
            Ragdoll = {
                Time = 1.5
            }
        },
        ["Heart and Saber"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        ["Flash of Light"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        ["Assassin\'s Blade"] = {
            Active = true,
            Actionable = {
                Stunned = true,
                Active = true,
                Disabled = true
            },
            Indicators = { {
                    Group = "Universal",
                    Visible = true
                } },
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        }
    }
};
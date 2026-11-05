  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;

local function MouseInvoke(p2) -- Line: 23
    -- upvalues: Knit (copy)
    local LocalPlayer = game.Players.LocalPlayer;
    local v3 = LocalPlayer:GetMouse();
    LocalPlayer.Character:WaitForChild("Humanoid");
    Knit.GetController("MoveInputController");
    Knit.GetService("MoveInputService"):FireInput(p2.RawInput, v3.Hit.Position):expect();
end;

if game:GetService("RunService"):IsServer() then
    local v4 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Name, true);
    require(v4.Common);
end;

Knit.OnStart():andThen(function() -- Line: 40
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v5 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 3
            },
            StandOff = {
                Visible = true,
                Priority = 1
            },
            StandOn = {
                Visible = false,
                Priority = 2
            }
        },
        MovesInfo = require(script.Moves)
    },
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    Metadata = require(script.Metadata),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v5.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 15, 20, "Attack" }, { 30, "End" } },
        HitRemotes = { v5.Resources.LightHit },
        HitSounds = {
            Hit = {
                SoundId = 17874176065,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 15, 25, "Attack" }, { 30, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 17874176899,
                Volume = 1
            }
        }
    },
    ["LMB-3"] = {
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 15, 30, "Attack" }, { 35, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 17874176433,
                Volume = 1
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 15, 25, "Attack" }, { 40, "End" } },
        HitRemotes = { v5.Resources.HeavyHit },
        HitSounds = {
            Hit = {
                SoundId = 17874175765,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v5.Stats["Lightning Burst"] = {
    Active = true,
    Damage = 6,
    Properties = {
        Restrain = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Size = 15,
        Offset = CFrame.identity
    },
    HitRemotes = { v5.Resources.LightHit },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 3,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};
v5.Stats["Iron Sand / Blade"] = {
    Active = true,
    Properties = {
        Armor = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Hit = {
        Damage = 5,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 10,
            Time = 0.1
        },
        HitRemotes = { v5.Resources.Blood }
    },
    Finisher = {
        Damage = 20,
        HitAnimations = "Default",
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(10, 10, 10),
            Offset = CFrame.new(0, 0, -5)
        },
        Block = {
            PerfectBlockable = false,
            BlockBreak = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 40,
            Time = 0.1
        },
        Ragdoll = {
            Time = 1.5
        },
        HitRemotes = { v5.Resources.Blood }
    }
};
v5.Stats["Iron Sand / Thrust"] = {
    Active = true,
    Damage = 25,
    Actionable = {
        Active = true
    },
    Properties = {
        Restrain = {
            AutoRotate = false
        }
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    HitRemotes = { v5.Resources.Blood },
    Hitbox = {
        Size = Vector3.new(12, 12, 36),
        Offset = CFrame.new(0, 0, 0)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 55,
        Velocity = Vector3.new(0, 27, 0),
        Time = 0.12
    },
    Stun = {
        Time = 1.2
    },
    Ragdoll = {
        Time = 1.2
    },
    Block = {
        BlockBreak = true,
        PerfectBlockable = true
    }
};
v5.Stats["Iron Sand / Double"] = {
    Active = true,
    Damage = 10,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    HitRemotes = { v5.Resources.Blood },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Offset = CFrame.new(0, 0, -4)
    }
};
v5.Stats.Railgun = {
    Active = true,
    Damage = 30,
    HitAnimations = "Default",
    Properties = {
        Armor = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 10, 18),
        Offset = CFrame.new(0, 0, -9)
    },
    Block = {
        BlockBreak = true
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 60,
        Time = 0.1
    },
    Ragdoll = {
        Time = 0.75
    },
    HitSounds = {
        Hit = {
            SoundId = 10626951281,
            Volme = 5
        }
    },
    HitRemotes = { v5.Resources.HeavyHit }
};
v5.Stats["Electric Enhancement"] = {
    Damage = 20,
    Actionable = {
        Active = true,

        Check = function(p6) -- Line: 415, Name: Check
            return not p6:GetAttribute("Enhancement");
        end
    },
    Cooldown = {
        Time = 20,
        AfterMove = true
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    }
};
v5.Stats.Block = {
    From = "Combat.Block"
};
v5.Stats["Shining Spear"] = {
    Active = true,
    Damage = 35,
    Stun = 0.8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Priority = Enums.Intangible.Move,
    Cooldown = {
        Time = 14,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(2.5, 2.5, 2.5)
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    StatusEffects = { {
            ApplyTo = "Target",
            Name = "Burn",
            Damage = 2.5,
            Overrides = {
                Lifetime = 5,
                Rate = 0.5
            }
        } },
    HitRemotes = { v5.Resources.Blood }
};
v5.Stats["Plasma Sphere"] = {
    Active = true,
    Damage = 1.25,
    Properties = {
        Restrain = true
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 7,
        AfterMove = true
    },
    HitRemotes = { v5.Resources.LightHit },
    Priority = Enums.Intangible.Ragdoll,
    Hitbox = {
        Size = 15,
        Offset = CFrame.new(0, 0, -13)
    },
    Knockback = {
        RelativePart = "Attacker",
        Speed = 3,
        Time = 0.1
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.5
    }
};
v5.Stats["Kuroko Needles"] = {
    Active = true,
    Damage = 25,
    Distance = 50,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 5,
        AfterMove = true,
        Manual = true
    },
    HitRemotes = { v5.Resources.LightHit },
    Stun = {
        Time = 1
    }
};
v5.Stats["Kuroko Teleport"] = {
    Active = true,
    Distance = 50,
    IntangibleLength = 1,
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 5,
        AfterMove = true
    },
    Invoke = MouseInvoke
};
v5.Stats.Grab = {
    From = "Combat.Grab",
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
v5.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v5.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v5;
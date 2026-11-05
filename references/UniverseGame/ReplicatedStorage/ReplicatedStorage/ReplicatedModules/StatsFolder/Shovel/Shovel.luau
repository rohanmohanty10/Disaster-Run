  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local EnumsModule = require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local v1 = {
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
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v1.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {
        Summoned = false
    },
    AnimationTimed = true,
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 12, 15, "Attack" }, { 18, "End" } },
        Stun = {
            Time = 0.75
        },
        HitSounds = {},
        HitRemotes = { v1.Resources.LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 23, 25, "Attack" }, { 30, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 22, 25, "Attack" }, { 28, "End" } }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.2,
        Sequence = { { 0, "Start" }, { 15, 18, "Attack" }, { 25, "End" } },
        HitRemotes = { v1.Resources.HeavyHit },
        HitSounds = {}
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v1.Stats.Block = {
    From = "Combat.Block"
};
v1.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Stats.Pose = {
    From = "Combat.Pose"
};
v1.Stats.Breaker = {
    From = "Combat.Breaker"
};
v1.Stats.Grab = {
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
v1.Stats["Spiraling Spade"] = {
    Active = true,
    Damage = 1.5,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 15, 15)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 1,
        Time = 0.1
    },
    HitSounds = {
        Hit = {}
    },
    HitRemotes = { v1.Resources.LightHit }
};
v1.Stats["Home Run"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        Offset = CFrame.new(0, 0, -5)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 1,
        Priority = EnumsModule.Stun.Medium
    },
    Ragdoll = {
        Time = 3
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 500,
        Time = 0.5,
        Velocity = Vector3.new(0, 100, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 7759891108,
            Volume = 1
        }
    },
    HitRemotes = { v1.Resources.HeavyHit }
};
v1.Stats["Bullet Hell"] = {
    Active = true,
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v1.Stats["Hopu Hopu Hamma"] = {
    Active = true,
    Actionable = {
        Active = true,
        Disabled = true,
        Stunned = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};

return v1;
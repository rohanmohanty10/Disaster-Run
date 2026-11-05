  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 19
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);
local v2 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
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
local LightHit = v2.Resources.LightHit;
v2.Stats["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Actionable = {},
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.25,
        Sequence = { { 0, "Start" }, { 22, 27, "Attack" }, { 28, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 18908998491,
                Volume = 1
            }
        },
        HitRemotes = { LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 15, 20, "Attack" }, { 22, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 18908998491,
                Volume = 1
            }
        },
        HitRemotes = { LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-3"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 20, 25, "Attack" }, { 26, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 18908998491,
                Volume = 1
            }
        },
        HitRemotes = { LightHit }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-4"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 30, 36, "Attack" }, { 37, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 18908998898,
                Volume = 1
            }
        },
        HitRemotes = { LightHit },
        Ragdoll = {
            Time = 2,
            Intangible = false
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v2.Stats.Block = {
    From = "Combat.Block"
};
v2.Stats.Quickstep = {
    From = "Combat.Quickstep"
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};
v2.Stats.Grab = {
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
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};
v2.Stats.Pose = {
    From = "Combat.Pose"
};
v2.Stats.Festival = {
    Active = true,
    Frequency = 4,
    Damage = 1.5,
    Priority = Enums.Intangible.Move - 1,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Properties = {
        Armor = true
    },
    Hitbox = {
        Size = Vector3.new(25, 10, 25),
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.identity
    },
    Ragdoll = {
        Time = 1,
        Intangible = false
    },
    Stun = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 18909001436,
            Volume = 0.6
        }
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    }
};
v2.Stats["Kinkyu Dasshutsu"] = {
    Priority = Enums.Intangible.Move,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    }
};
v2.Stats.Senbei = {
    Active = true,
    Frequency = 2,
    Damage = 0.6,
    HitAnimations = "Default",
    Priority = Enums.Intangible.Move,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(10, 10, 10),
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.new(0, 0, -4)
    },
    Ragdoll = {
        Time = 2,
        Intangible = false
    },
    Stun = {
        Time = 1
    },
    HitSounds = {
        Hit = {
            SoundId = 18909298894,
            Volume = 1
        }
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    }
};

return v2;
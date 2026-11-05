  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
local Enums = require(PathShortcuts.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ClientModulesPath.TweenModule);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 20
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
    Resources = require(script.Resources)
};
v2.Stats.Summon = {
    Active = true,
    Actionable = {
        Active = true
    }
};
v2.Stats.Barrage = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 5,
        HitRemotes = { v2.Resources.BloodHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        HitSounds = {
            Hit = v2.Resources.BarrageHit
        },
        Stun = {
            Time = 2
        }
    },
    Barrage = {
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        HitSounds = {
            Hit = v2.Resources.BarrageHit
        },
        HitRemotes = { v2.Resources.LightHit },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Stun = {
            Time = 2
        }
    },
    Uppercut = {
        Damage = 25,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 4,
            Intangible = false
        },
        HitSounds = {
            Hit = v2.Resources.BarrageFinisher
        },
        HitRemotes = { v2.Resources.HeavyHit },
        Knockback = {
            Velocity = Vector3.new(0, 80, 0),
            Speed = 40,
            Time = 0.1,
            RelativePart = "Attacker"
        }
    }
};
v2.Stats["Sword of Extermination"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Slash = {
        Damage = 10,
        HitRemotes = { v2.Resources.BloodHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Knockback = {
            Speed = 10,
            Time = 0.1,
            RelativePart = "Attacker"
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Stun = {
            Time = 2
        }
    },
    Upperslash = {
        Damage = 15,
        HitRemotes = { v2.Resources.BloodHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Knockback = {
            Speed = 10,
            Time = 0.1,
            RelativePart = "Attacker"
        },
        Stun = {
            Time = 2
        }
    },
    Slam = {
        Damage = 50,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 28,
            Offset = CFrame.new(0, -3, -4)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 4,
            Intangible = false
        },
        Knockback = {
            Velocity = Vector3.new(0, 60, 0),
            Speed = 40,
            Time = 0.2,
            RelativePart = "Attacker"
        }
    }
};
v2.Stats.Crush = {
    Active = true,
    Actionable = {
        Active = true
    },
    Projectile = {
        Damage = 30,
        Stun = 0.75,
        HitAnimations = "Default",
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        HitSounds = {
            Hit = {
                SoundId = 17487881331,
                Volume = 2
            }
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Offset = CFrame.identity
        },
        HitRemotes = { v2.Resources.LightHit }
    },
    Search = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(48, 48, 64),
            Offset = CFrame.new(0, 0, -32)
        }
    },
    Slam = {
        Damage = 50,
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.new(0, -3, -3)
        },
        Ragdoll = {
            Time = 1,
            Intangible = false
        },
        Knockback = {
            Velocity = Vector3.new(0, 20, 0),
            Speed = 25,
            Time = 0.2,
            RelativePart = "Attacker"
        }
    }
};
v2.Stats.Ravage = {
    Active = true,
    Actionable = {
        Active = true
    },
    Kick = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.LightHit },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Startup = {
        Damage = 10,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.LightHit },
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Release = {
        Damage = 15,
        Ragdoll = {
            Time = 4,
            Intangible = false
        },
        Knockback = {
            Velocity = Vector3.new(0, 20, 0),
            Speed = 50,
            Time = 0.5,
            RelativePart = "Attacker"
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Priority = Enums.Intangible.Move
    },
    Stab = {
        Damage = 1,
        Priority = Enums.Intangible.Move,
        HitRemotes = { v2.Resources.BloodHit },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Slam = {
        Damage = 10,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 20,
            Offset = CFrame.new(0, -3, 0)
        },
        Ragdoll = {
            Time = 1,
            Intangible = false
        },
        Knockback = {
            Velocity = Vector3.new(0, 20, 0),
            Speed = 10,
            Time = 0.1,
            RelativePart = "Attacker"
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Priority = Enums.Intangible.Move
    },
    Run = {
        Damage = 1,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(15, 20, 15),
            Offset = CFrame.new(0, 0, -7.5)
        },
        Priority = Enums.Intangible.Move,
        Block = {
            Unblockable = true,
            BypassCounter = true
        },
        Ragdoll = {
            Time = 2,
            Intangible = false
        }
    }
};
v2.Stats.Rush = {
    Active = true,
    Damage = 5,
    Actionable = {
        Active = true
    },
    Hitbox = {
        HitboxType = "ClientHitbox",
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(15, 23, 15),
        Offset = CFrame.new(0, 0, -7.5)
    },
    Priority = Enums.Intangible.Move,
    HitSounds = {
        Hit = v2.Resources.RushHit
    },
    Knockback = {
        Velocity = Vector3.new(0, 30, 0),
        Speed = 20,
        Time = 0.2,
        RelativePart = "Attacker"
    },
    Block = {
        Unblockable = true,
        BypassCounter = true
    },
    Ragdoll = {
        Time = 2,
        Intangible = false
    }
};
v2.Stats.Regeneration = {
    Active = true,
    Frequency = 2,
    Actionable = {
        Active = true,

        Check = function(p3) -- Line: 443, Name: Check
            local Humanoid = p3.Humanoid;
            local v4;

            if Humanoid.Health == Humanoid.MaxHealth then
                v4 = false;
            else
                v4 = Humanoid.Health < Humanoid.MaxHealth;
            end;

            return v4;
        end
    }
};
v2.Stats.Breaker = {
    From = "Combat.Breaker"
};

return v2;
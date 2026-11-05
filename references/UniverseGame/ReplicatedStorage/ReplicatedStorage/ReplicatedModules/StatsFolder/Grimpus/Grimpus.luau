  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TagService = require(PathShortcuts.ReplicatedModules.Independent.TagService);
local _ = PathShortcuts.CollectionService;
require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
local ReplicatedModules = PathShortcuts.ReplicatedModules;
local _ = PathShortcuts.ClientAssets;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Enums = require(ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 27
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v6 = {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 6
            }
        },
        MovesInfo = require(script.Moves)
    },
    Stats = {},
    Animations = require(script.Animations),
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources),

    PostRig = function(p4) -- Line: 50, Name: PostRig
        -- upvalues: TagService (copy)
        local Character = p4.Character;
        local Player = p4.Player;

        repeat
            task.wait(0.25);
        until Character:WaitForChild("Head");

        if Player and Player:IsA("Player") then
            Player:HasAppearanceLoaded();
        end;

        task.defer(function() -- Line: 58
            -- upvalues: Character (copy), TagService (ref)
            Character:ScaleTo(1.76);
            local v5 = TagService:GetContainer(Character);
            TagService:Add(v5, "NoRun");
            TagService:Add(v5, "WalkSpeedMultiplier", 0.75);
            TagService:Add(v5, "NoRagdoll", true);
            TagService:Add(v5, "NoHitAnimations");
        end);
    end
};
v6.Stats["Frostbite Whirlwinds"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 45),
        Offset = CFrame.new(0, 0, -22.5)
    },
    Damage = 1,
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = false
    },
    Stun = {
        Time = 2,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 0,
        Time = 0.1,
        Velocity = Vector3.new(0, 2.5, 0)
    },
    HitSounds = {
        Hit = {
            SoundId = 138067872428845,
            Volume = 1
        }
    },
    HitAnimations = "Default",
    HitRemotes = { v6.Resources.LightHit },
    Finisher = {
        Damage = 30,
        HitAnimations = "Default",
        Block = {
            PerfectBlockable = false,
            Blockable = true,
            BlockBreak = true
        },
        Stun = {
            Time = 0.75,
            Priority = Enums.Stun.Medium
        },
        Ragdoll = {
            Time = 1.5
        },
        Knockback = {
            RelativeTowards = "Target",
            Speed = 60,
            Time = 0.3,
            Velocity = Vector3.new(0, 15, 0)
        },
        HitSounds = {
            Hit = {
                SoundId = 135640260748317,
                Volume = 1
            }
        },
        HitRemotes = { v6.Resources.HeavyHit }
    }
};
v6.Stats["Cold-Seeking Icicles"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = Vector3.new(15, 25, 15)
    },
    Damage = 35,
    Knockback = {
        RelativeTowards = "Target",
        Speed = 10,
        Time = 0.3,
        Velocity = Vector3.new(0, 25, 0)
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Stun = {
        Time = 0.75
    },
    HitRemotes = { v6.Resources.HeavyHit },
    HitSounds = {
        Hit = {
            SoundId = 90080439218011,
            Volume = 1
        }
    },
    Detection = {
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 90
        }
    }
};
v6.Stats["Ice Spike Formation"] = {
    Active = true,
    Damage = 45,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(20, 20, 55),
        Offset = CFrame.new(0, 0, -27.5)
    },
    Block = {
        PerfectBlockable = true,
        Blockable = true,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 2
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 90,
        Time = 0.3,
        Velocity = Vector3.new(0, 30, 0)
    },
    HitSounds = {},
    HitRemotes = { v6.Resources.HeavyHit }
};
v6.Stats["Seismic Stomp"] = {
    Active = true,
    Damage = 50,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 45
    },
    Block = {
        PerfectBlockable = false,
        Blockable = true,
        BlockBreak = true
    },
    Ragdoll = {
        Time = 1.5
    },
    Stun = {
        Time = 0.75,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 60,
        Time = 0.3,
        Velocity = Vector3.new(0, 25, 0)
    },
    HitSounds = {},
    HitRemotes = { v6.Resources.HeavyHit }
};
v6.Stats["Wintry Blizzard"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = 77
    },
    Damage = 1,
    Block = {
        PerfectBlockable = false,
        Blockable = false,
        BlockBreak = false
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 1,
        Time = 0.1
    },
    HitSounds = {},
    HitAnimations = "Default",
    HitRemotes = { v6.Resources.HeavyHit },
    Freeze = {
        StatusEffects = { {
                ApplyTo = "Target",
                Name = "Freeze"
            } }
    }
};
v6.Stats["Snowfall Pit"] = {
    Actionable = {
        Active = true
    },
    Active = true,
    Cooldown = {
        Time = 1,
        AfterMove = true
    },
    Hitbox = {
        Size = 30
    },
    Damage = 30,
    Ragdoll = {
        Time = 1.5
    },
    Knockback = {
        RelativeTowards = "Target",
        Speed = 30,
        Time = 0.3,
        Velocity = Vector3.new(0, 25, 0)
    },
    Stun = {
        Time = 0.75
    },
    HitSounds = {},
    HitAnimations = "Default",
    HitRemotes = { v6.Resources.HeavyHit },
    Detection = {
        Hitbox = {
            Size = 90
        }
    },
    Popup = {
        Damage = 50,
        HitAnimations = "Default",
        Stun = {
            Time = 1.25
        },
        HitSounds = {},
        HitRemotes = { v6.Resources.HeavyHit }
    },
    Slam = {
        Damage = 50,
        HitAnimations = "Default",
        Knockback = {
            RelativeTowards = "Target",
            Speed = 60,
            Time = 0.3,
            Velocity = Vector3.new(0, 40, 0)
        },
        Ragdoll = {
            Time = 1.5
        },
        Stun = {
            Time = 0.75
        },
        HitSounds = {},
        HitRemotes = { v6.Resources.HeavyHit }
    }
};

return v6;
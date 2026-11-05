  

 

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v6 = {
    Stats = {},
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            Passive = {
                Visible = true,
                Priority = 4
            }
        },
        MovesInfo = require(script.Moves)
    },
    Sounds = require(script.Sounds),
    Animations = require(script.Animations),
    Metadata = {
        PostRig = function(p5) -- Line: 91, Name: PostRig
            -- upvalues: CollectionService (copy)
            local Character = p5.Character;
            local Player = p5.Player;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player then
                Player:HasAppearanceLoaded();
            end;

            CollectionService:AddTag(Character, "Summoned");
        end
    }
};
local v7 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    },
    ["Blood Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit",
                AutoSerialize = true
            } }
    }
};

for _, v in { "Spin Charge", "Dark Determination", "Nail Barrage", "Lesson 3", "Lesson 4", "Nail Glide", "Herbal Tea" } do
    v6.Stats[v] = {
        From = "Tusk ACT1." .. v
    };
end;

v6.Stats["Rush Attack"] = {
    From = "Tusk ACT1.Rush Attack"
};
v6.Stats["Wormhole Trap"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 12,
        AfterMove = true
    },
    Properties = {
        Restrain = true
    },
    Meter = {
        RequiredAmount = 35
    },
    Startup = {
        CheckPVPSafe = true,
        Hitbox = {
            RelativePart = "HumanoidRootPart",
            Size = 50,
            Offset = CFrame.identity
        },
        Block = {
            Unblockable = true,
            BypassCounter = true
        }
    },
    Finish = {
        Damage = 40,
        Priority = Enums.Intangible.Move,
        Stun = {
            Time = 0.3,
            Priority = Enums.Stun.Heavy
        },
        KnockbackData = { {
                Type = "Velocity",
                RelativeTowards = "Target",
                Velocity = Vector3.new(0, 8, 0),
                Speed = 50,
                Time = 0.1
            } },
        HitRemotes = { v7["Heavy Hit"] },
        Ragdoll = {
            Time = 3
        },
        Block = {
            Blockable = false,
            PerfectBlockable = false,
            Unblockable = true
        }
    }
};
v6.Stats["Lesson 2"] = {
    From = "Tusk ACT4.Final Point"
};
v6.Stats["Point of Infinity"] = {
    Active = true,
    Duration = 4,
    Damage = 8,
    HitAnimations = "Default",
    Actionable = {
        Active = true
    },
    Meter = {
        RequiredAmount = 25
    },
    Cooldown = {
        Time = 10,
        AfterMove = true
    },
    Properties = {
        Restrain = true
    },
    Priority = Enums.Intangible.Ragdoll,
    Stun = {
        Time = 0.75
    },
    Hitbox = {
        Size = 25,
        RelativePart = "HumanoidRootPart",
        Offset = CFrame.identity
    },
    KnockbackData = { {
            Type = "Velocity",
            Speed = 8,
            Time = 0.1,
            RelativeTowards = "Target"
        } },
    HitRemotes = { v7["Blood Hit"] },
    Block = {
        Blockable = true,
        BlockBreak = false,
        BypassCounter = true,
        PerfectBlockable = false
    }
};
v6.Stats.Pose = {
    From = "Combat.Pose"
};
v6.Stats.Block = {
    From = "Combat.Block"
};
v6.Stats.Quickstep = {
    From = "Combat.Quickstep"
};

return v6;
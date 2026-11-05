  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("RunService");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local TableUtil = require(Knit.Util.TableUtil);
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function CreateLegTrail(u4, p5, p6) -- Line: 64
    -- upvalues: Players (copy), AssetHandler (copy), ParticleHandler (copy)
    local v7 = p6 or 0.5;
    local v8 = Players:GetPlayerFromCharacter(u4);
    local v9 = 0;

    if v8 and v8.Data.Skin:GetAttribute("UnusualHueId") then
        v9 = v9 + v8.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local v10 = AssetHandler.GetAbilityData(v8 or u4);

    if v10.SkinName == "Sanji" then
        task.delay(0.25, function() -- Line: 77
            -- upvalues: u4 (copy), ParticleHandler (ref)
            local LMBEmit = u4:FindFirstChild("LMBEmit", true);

            if LMBEmit then
                ParticleHandler.Emit(LMBEmit, ParticleHandler.GenerateEmitInfo(LMBEmit));
            end;
        end);
        p5 = "Right Leg";
    end;

    local u11 = AssetHandler.CloneAsset("Particles/Misc/LegTrail", v10);
    u11.Parent = u4;

    if v9 > 0 then
        ParticleHandler.HSVShiftParticles(u11, {
            HueShift = v9
        });
    end;

    task.delay(v7 + 1.5, u11.Destroy, u11);
    ParticleHandler.AttachTo(u11, {
        Part = u4[p5],
        Offset = CFrame.identity
    });
    task.delay(v7, function() -- Line: 102
        -- upvalues: u11 (copy)
        for _, descendant in u11:GetDescendants() do
            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false;
            end;
        end;
    end);
end;

local v12 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/LightHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};
local v13 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/Misc/HeavyHit",
            AutoSerialize = true,
            LookAt = "Attacker"
        } }
};

return {
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Perfume Fever"] = {
                DefaultKeybind = "E",
                Unlocked = true,
                Description = "Perform a barrage of kicks."
            },
            ["Perfume Femur Magna"] = {
                DefaultKeybind = "R",
                Unlocked = true,
                Description = "Unleash a forward spinning kick followed by an extremely powerful lunging finisher kick."
            },
            ["Lovely Legwork"] = {
                DefaultKeybind = "G",
                Unlocked = false,
                LevelRequirement = 15,
                Description = "Execute numerous small kicks around your character while twirling forward and finishing it off with a 360 degree kick."
            },
            ["Pistol Kiss"] = {
                DefaultKeybind = "T",
                Unlocked = false,
                LevelRequirement = 20,
                Description = "Kiss your finger forming a heart bullet and project it forward like a handgun. If charged, the heart petrifies opponents on contact."
            },
            ["Mero Mero Mellow"] = {
                DefaultKeybind = "G+",
                Unlocked = false,
                LevelRequirement = 25,
                Description = "Form a heart with your hand and fire out heart-shaped rays from it, petrifying opponents on contact."
            },
            ["Petrifying Burst"] = {
                DefaultKeybind = "Y+",
                Unlocked = false,
                LevelRequirement = 50,
                Description = "Leap into the air, kissing and expanding a heart before releasing a flurry of petrifying arrows in beneath you."
            },
            ["Queen\'s Stomp"] = {
                DefaultKeybind = "Y",
                Unlocked = false,
                LevelRequirement = 40,
                Description = "Grab the enemy before penetrating your heel into their chest."
            },
            Infatuation = {
                DefaultKeybind = "Q",
                Unlocked = false,
                LevelRequirement = 55,
                Description = "Conjure a colossal heart above your character, irresistibly dragging enemies into its confines before detonating with explosive force."
            },
            Heartless = {
                DefaultKeybind = "H",
                Unlocked = false,
                LevelRequirement = 75,
                Description = "Slide forward, gripping and performing a series of spinning kicks on the opponent."
            },
            ["Cupid\'s Yumi"] = {
                DefaultKeybind = "Z",
                Unlocked = false,
                LevelRequirement = 45,
                Description = "Form a pink bow and shoot a singularly high charged arrow in front of your character, raining a barrage of arrows down."
            }
        }
    },
    Animations = {
        Action = {
            PoseTransition = 10405294780,
            PoseIdle = 10405298544,
            ["LMB-1"] = 16828093793,
            ["LMB-2"] = 16828099979,
            ["LMB-3"] = 16828102157,
            ["LMB-4"] = 16828104305,
            ["Lovely Legwork"] = 16332298919,
            ["Pistol Kiss Start"] = 8573835767,
            ["Pistol Kiss Loop"] = 16132016807,
            ["Pistol Kiss End"] = 8573839521,
            ["Femur Magna"] = 16345757821,
            ["Petrifying Burst"] = 16412481595,
            ["Mero Mero Mellow"] = 16610703409,
            ["Queen Stomp Input"] = 16611024539,
            ["Queen Stomp User"] = 16611031438,
            ["Queen Stomp Victim"] = 16611033707,
            ["Perfume Fever"] = 16613986197,
            ["Infatuation Start"] = 16682187262,
            ["Infatuation Loop"] = 16682194055,
            ["Infatuation End"] = 16682196967,
            ["Heartless Attempt"] = 16845516582,
            ["Heartless Camera"] = 16845476524,
            ["Heartless User"] = 16845519203,
            ["Heartless Victim"] = 16845521611,
            ["Cupid\'s Yumi"] = 16864006651
        },
        Movement = {
            Walk = 16128783409,
            Run = 16829030002
        },
        Idle = {
            Idle = 16128787827
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 16835047786,
            Volume = 1
        },
        ["Lovely Legwork Voiceline"] = {
            SoundId = 16835047927,
            Volume = 1
        },
        ["Lovely Legwork SFX"] = {
            SoundId = 16835042649,
            Volume = 1
        },
        ["Magna Voiceline"] = {
            SoundId = 16835047271,
            Volume = 1
        },
        ["Magna SFX"] = {
            SoundId = 16835043092,
            Volume = 1
        },
        ["Mellow Voiceline"] = {
            SoundId = 16835046272,
            Volume = 1
        },
        ["Mellow SFX"] = {
            SoundId = 16835045346,
            Volume = 1
        },
        ["Perfume Fever Voiceline"] = {
            SoundId = 16841223934,
            Volume = 1
        },
        ["Perfume Fever SFX"] = {
            SoundId = 16835043848,
            Volume = 1
        },
        ["Pistol Kiss Startup Voiceline"] = {
            SoundId = 16835045177,
            Volume = 1
        },
        ["Pistol Kiss Voiceline"] = {
            SoundId = 16835045820,
            Volume = 1
        },
        ["Pistol Kiss SFX"] = {
            SoundId = 16835045033,
            Volume = 1
        },
        ["Pistol Kiss Charging"] = {
            SoundId = 16835043507,
            Volume = 1
        },
        ["Pistol Kiss Charged Shot"] = {
            SoundId = 16835043212,
            Volume = 1
        },
        ["Pistol Kiss Uncharged Shot"] = {
            SoundId = 16835044082,
            Volume = 1
        },
        ["Pistol Kiss Wall Impact"] = {
            SoundId = 16841223259,
            Volume = 1
        },
        ["Pistol Kiss Charge Indicator"] = {
            SoundId = 16843849529,
            Volume = 1
        },
        ["Queen Stomp Startup Voiceline"] = {
            SoundId = 16835046959,
            Volume = 1
        },
        ["Queen Stomp Startup SFX"] = {
            SoundId = 16835046831,
            Volume = 1
        },
        ["Queen Stomp Voiceline"] = {
            SoundId = 16835046411,
            Volume = 1
        },
        ["Queen Stomp SFX"] = {
            SoundId = 16835046609,
            Volume = 1
        },
        Petrify = {
            SoundId = 16835043337,
            Volume = 1
        },
        Unpetrify = {
            SoundId = 16835044897,
            Volume = 1
        },
        ["Infatuation Voiceline"] = {
            SoundId = 16835044575,
            Volume = 1
        },
        ["Infatuation SFX"] = {
            SoundId = 16835047114,
            Volume = 0.85,
            RollOffMaxDistance = 200
        },
        ["Infatuation Release SFX"] = {
            SoundId = 16841224230,
            Volume = 1,
            RollOffMaxDistance = 200
        },
        ["Petrifying Burst SFX"] = {
            SoundId = 16841225953,
            Volume = 1
        },
        ["Petrifying Burst Shoot SFX"] = {
            SoundId = 16841223458,
            Volume = 1
        },
        ["Petrifying Burst Voiceline"] = {
            SoundId = 16841223665,
            Volume = 1
        },
        ["Petrifying Burst Land"] = {
            SoundId = 16844370526,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 16841225495,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 16841225123,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 16841226462,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 16841362382,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 16841224891,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 16841225709,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 16841226191,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 16841224636,
            Volume = 1
        },
        ["LMB-4Slam"] = {
            SoundId = 16841224463,
            Volume = 1
        },
        ["Heartless Startup Voiceline"] = {
            SoundId = 16846806676,
            Volume = 1
        },
        ["Heartless Startup SFX"] = {
            SoundId = 16846806925,
            Volume = 1
        },
        ["Heartless Voiceline"] = {
            SoundId = 16846807180,
            Volume = 1
        },
        ["Heartless SFX"] = {
            SoundId = 16846807436,
            Volume = 1
        },
        ["Cupid\'s Yumi Shoot SFX"] = {
            SoundId = 16901353377,
            Volume = 1
        },
        ["Cupid\'s Yumi SFX"] = {
            SoundId = 16901353574,
            Volume = 1
        },
        ["Cupid\'s Yumi Voiceline"] = {
            SoundId = 16901353486,
            Volume = 1
        },
        ["Cupid\'s Yumi Explode"] = {
            SoundId = 16901353666,
            Volume = 1
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://17655159510",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hah! That\'s it?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://17655169699",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Funny. I\'m going to make you regret that.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://17655164834",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Are you trying to test me? Insolent fool!",
                            ScaleTime = 1
                        } }
                } }
        }
    },
    Stats = {
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Pose = {
            From = "Combat.Pose"
        },
        Breaker = {
            From = "Combat.Breaker"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            Indicators = (function(p14) -- Line: 38, Name: CreateMultiIndicator
                local v15 = {};

                for i, v in pairs(p14) do
                    if i ~= "Overrides" then
                        table.insert(v15, {
                            InputText = "%s",
                            Visible = true,
                            Group = i,
                            Name = v,
                            DisplayName = v,
                            CooldownName = v,
                            ActiveName = v
                        });
                    end;
                end;

                if p14.Overrides then
                    for _, v in ipairs(v15) do
                        for i, v2 in pairs(p14.Overrides) do
                            v[i] = v2;
                        end;
                    end;
                end;

                return v15;
            end)({
                Universal = "Rush Attack"
            }),
            AnimationTimed = true,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.73,
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p16, p17, p18) -- Line: 168
                            -- upvalues: CreateLegTrail (copy)
                            CreateLegTrail(p18.Character, "Right Leg");
                        end },
                    { 0, "PlaySound", "LMB-1SFX" },
                    { 16, 25, "Attack" },
                    { 36, "End" }
                },
                Stun = {
                    Time = 0.75,
                    Priority = Enums.Stun.Medium
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(8, 8, 8.5),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -4)
                },
                HitRemotes = { v12 },
                HitSounds = {
                    Hit = {
                        SoundId = 16835044242,
                        Volume = 0.5
                    }
                }
            }, BaseStatsModule.Stand_Rush_Attack),
            ["LMB-2"] = {
                Speed = 2.5,
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p19, p20, p21) -- Line: 203
                            -- upvalues: CreateLegTrail (copy)
                            CreateLegTrail(p21.Character, "Left Leg");
                        end },
                    { 0, "PlaySound", "LMB-2SFX" },
                    { 16, 25, "Attack" },
                    { 36, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 16835044242,
                        Volume = 0.5
                    }
                }
            },
            ["LMB-3"] = {
                Speed = 2.3,
                Sequence = {
                    { 0, "Start" },
                    { 0, function(p22, p23, p24) -- Line: 222
                            -- upvalues: CreateLegTrail (copy)
                            CreateLegTrail(p24.Character, "Right Leg");
                        end },
                    { 0, "PlaySound", "LMB-3SFX" },
                    { 16, 25, "Attack" },
                    { 36, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 16835044242,
                        Volume = 0.5
                    }
                }
            },
            ["LMB-4"] = {
                Speed = 1.6,
                Cooldown = 1,
                Damage = 16,
                Sequence = {
                    { 0, "PlayAnim", "LMB-4" },
                    { 0, "CreateTag", "MaxWalkSpeed", 6 },
                    { 0, "CreateTag", "MaxJumpPower", 0 },
                    { 0, "PlaySound", "LMB-4" },
                    { 0, "PlaySound", "LMB-4SFX" },
                    { 0, function(p25, p26, p27) -- Line: 247
                            -- upvalues: CreateLegTrail (copy)
                            CreateLegTrail(p27.Character, "Right Leg");
                        end },
                    { 31, "PlaySound", "LMB-4Slam" },
                    { 31, function(p28, p29, p30, p31) -- Line: 252
                            -- upvalues: u3 (ref), u2 (ref)
                            local AttackStats = p31.AttackStats;
                            local Player = p30.Player;
                            local Character = p30.Character;
                            local RootPart = p30.RootPart;
                            local v32 = u3.Hitbox({
                                Caster = Character,
                                Stats = AttackStats
                            });

                            for _, v in ipairs(v32) do
                                u3.Attack({
                                    Attacker = Character,
                                    Target = v.Character,
                                    Stats = AttackStats
                                });
                            end;

                            u3.PlaySound(Character, "Ground Slam");
                            u2.FireAllClients("Rock Debris", {
                                Lifetime = 1.5,
                                Size = Vector3.new(2.3, 2.3, 2.3),
                                Amount = 17,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                                Radius = AttackStats.Hitbox.Size * 1.35
                            });
                            u2.FireAllClients("Flying Debris", {
                                Lifetime = 1.5,
                                Collision = true,
                                Size = 1.8,
                                Force = Vector3.new(20, 20, 20),
                                TweenDelay = 0.9,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset,
                                Tween = {
                                    Transparency = 1,
                                    Size = Vector3.new(0, 0, 0)
                                }
                            });
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Misc/Slam",
                                AutoSerialize = true,
                                Origin = RootPart.CFrame * AttackStats.Hitbox.Offset * CFrame.new(0, -2.5, 0),
                                Player = Player
                            });
                            u2.FireClient(Player, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                        end },
                    { 42, function(p33, p34, p35) -- Line: 280
                        end }
                },
                HitRemotes = { v13 },
                HitSounds = {
                    Hit = {
                        SoundId = 16835043670,
                        Volume = 1
                    }
                },
                Block = {
                    Blockable = false,
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                Hitbox = {
                    Type = "Magnitude",
                    RelativePart = "HumanoidRootPart",
                    Size = 8,
                    Debug = false,
                    Offset = CFrame.new(0, 0, -3)
                },
                Ragdoll = {
                    Time = 0.6
                },
                Stun = {
                    Time = 0.35,
                    Priority = Enums.Stun.Heavy
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 45,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 25, 0)
                }
            }
        },
        Grab = {
            From = "Combat.Grab"
        },
        ["Perfume Fever"] = {
            Active = true,
            Frequency = 6,
            Damage = 1.5,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 9,
                AfterMove = true
            },
            Stun = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 7,
                Time = 0.1
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7.5, 7.5, 7.5),
                Offset = CFrame.new(0, 0, -3.75)
            },
            HitRemotes = { v12 },
            HitSounds = {
                Hit = {
                    SoundId = 16835044242,
                    Volume = 0.5
                }
            },
            Finisher = {
                Damage = 15.5,
                Stun = {
                    Time = 0.85
                },
                Ragdoll = {
                    Time = 0.85
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 42,
                    Time = 0.13,
                    Velocity = Vector3.new(0, 24, 0)
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Hitbox = {
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(10, 10, 10),
                    Offset = CFrame.new(0, 0, -5)
                },
                HitSounds = {
                    Hit = {
                        SoundId = 16835043670,
                        Volume = 1
                    }
                }
            }
        },
        ["Lovely Legwork"] = {
            Active = true,
            Distance = 25,
            Damage = 4.5,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            KickTimings = { 34, 42, 50, 57, 63, 70, 79, 90, 100, 110, 118, 133, 144 },
            Meter = {
                RequiredAmount = 30
            },
            Hitbox = {
                Size = 13,
                Debug = false
            },
            Stun = {
                Time = 0.75
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Override = true,
                Speed = 33,
                Time = 0.13
            },
            HitSounds = {
                Hit = {
                    SoundId = 16835042465,
                    Volume = 1
                }
            },
            Finisher = {
                Damage = 12,
                Stun = {
                    Time = 1.25
                },
                Ragdoll = {
                    Time = 1.25
                },
                Block = {
                    PerfectBlockable = false,
                    BlockBreak = true
                },
                Knockback = {
                    RelativeTowards = "Target",
                    Speed = 35,
                    Time = 0.1,
                    Velocity = Vector3.new(0, 25, 0)
                },
                Hitbox = {
                    Size = 16,
                    Debug = false
                },
                HitRemotes = { v13 }
            }
        },
        ["Perfume Femur Magna"] = {
            Active = true,
            Damage = 10,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15.5,
                AfterMove = true
            },
            Stun = {
                Time = 0.75
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 25,
                Time = 0.12
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(10, 8, 12),
                Offset = CFrame.new(0, 0, -6)
            },
            HitRemotes = { v12 },
            HitSounds = {
                Hit = {
                    SoundId = 16835042813,
                    Volume = 1
                }
            },
            Finisher = {
                Damage = 28,
                Distance = 30,
                Hitbox = {
                    Size = Vector3.new(14, 14, 32),
                    Debug = false,
                    Offset = CFrame.new(0, 0, 0)
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
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
                },
                HitSounds = {
                    Hit = {
                        SoundId = 16835042957,
                        Volume = 1
                    }
                }
            }
        },
        ["Pistol Kiss"] = {
            Active = true,
            Damage = 30,
            Speed = 200,
            Charged = 40,
            MaxDuration = 60,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 7,
                AfterMove = true
            },
            Stun = {
                Time = 0.5
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            }
        },
        ["Mero Mero Mellow"] = {
            Active = true,
            Damage = 6,
            Frequency = 10,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 14,
                AfterMove = true
            },
            Stun = {
                Time = 0.5
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Knockback = {
                RelativePart = "Attacker",
                Speed = 13,
                Time = 0.2
            },
            Hitbox = {
                Size = Vector3.new(17, 17, 42),
                Debug = false,
                Offset = CFrame.new(0, 0, -21)
            },
            StatusEffects = { {
                    ApplyTo = "Target",
                    Name = "Petrification",
                    Anchor = false
                } },
            Meter = {
                RequiredAmount = 25
            }
        },
        ["Petrifying Burst"] = {
            Active = true,
            ArrowAmount = 12,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 10
            },
            Arrow = {
                Damage = 8,
                Distance = 8,
                HitAnimations = "Default",
                Meter = false,
                Stun = {
                    Time = 1.15
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 5,
                    Time = 0.1
                },
                StatusEffects = { {
                        ApplyTo = "Target",
                        Name = "Petrification",
                        Anchor = true
                    } },
                HitRemotes = { v12 }
            }
        },
        ["Queen\'s Stomp"] = {
            Active = true,
            Damage = 7.5,
            Actionable = {
                Active = true
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Cooldown = {
                Time = 12,
                AfterMove = true
            },
            Meter = {
                RequiredAmount = 25
            },
            Hitbox = {
                Size = Vector3.new(8, 8, 8),
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            Slam = {
                Damage = 15,
                Priority = Enums.Intangible.Move,
                Block = {
                    Unblockable = true
                },
                HitRemotes = { v12 }
            },
            Finisher = {
                Damage = 20,
                Priority = Enums.Intangible.Move,
                Stun = {
                    Time = 1
                },
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    Speed = 50,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 22, 0),
                    RelativeTowards = "Target"
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                }
            },
            HitRemotes = { v13 }
        },
        Infatuation = {
            Meter = false,
            Active = true,
            Damage = 2,
            Duration = 250,
            Frequency = 8,
            Priority = Enums.Intangible.Ragdoll,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 22,
                AfterMove = true
            },
            Block = {
                Blockable = true,
                PerfectBlockable = false
            },
            Stun = {
                Time = 0.75
            },
            Ragdoll = {
                Time = 0.7
            },
            Hitbox = {
                Size = 35,
                Debug = false,
                Offset = CFrame.new(0, 15, 0)
            },
            Explosion = {
                Meter = false,
                Damage = 22,
                Priority = Enums.Intangible.Ragdoll,
                Ragdoll = {
                    Time = 1
                },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                },
                Knockback = {
                    Override = true,
                    Speed = 55,
                    Time = 0.2
                }
            }
        },
        ["Cupid\'s Yumi"] = {
            Active = true,
            Damage = 30,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            HitRemotes = { v13 },
            HitSounds = {
                Hit = {
                    SoundId = 16835043670,
                    Volume = 1
                }
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            Hitbox = {
                Size = 18.5,
                Debug = false
            },
            Ragdoll = {
                Time = 0.6
            },
            Stun = {
                Time = 0.6,
                Priority = Enums.Stun.Heavy
            },
            Knockback = {
                RelativeTowards = "Target",
                Speed = 45,
                Time = 0.13,
                Velocity = Vector3.new(0, 25, 0)
            }
        },
        Heartless = {
            Active = true,
            Frequency = 1,
            Damage = 10,
            MinHealth = 1,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 27,
                AfterMove = true
            },
            Hitbox = {
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -8)
            },
            Meter = {
                RequiredAmount = 75
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            HeavyKick = {
                Damage = 12,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Heartless/FirstHeavy",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            },
            LightKick = {
                Damage = 1.25,
                MinHealth = 1,
                Priority = Enums.Intangible.Move,
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Heartless/BarrageHit",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            },
            Finisher = {
                Damage = 30,
                Stun = {
                    Time = 1.5
                },
                Ragdoll = {
                    Time = 1.5
                },
                Knockback = {
                    Speed = 50,
                    Time = 0.15,
                    Velocity = Vector3.new(0, 43, 0),
                    RelativeTowards = "Target"
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    Unblockable = true
                },
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Heartless/Finisher",
                                AutoSerialize = true,
                                LookAt = "Attacker"
                            } }
                    } }
            }
        }
    },
    MasteryData = {
        MaxMasteryRank = 4,

        PointCap = function(p36) -- Line: 1582, Name: PointCap
            return p36 == 3 and 25 or (p36 == 2 and 15 or (p36 == 1 and 10 or 5));
        end
    }
};
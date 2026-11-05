  

 

game:GetService("PhysicsService");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local ClientAssets = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local _ = game.ReplicatedStorage.Remotes.InputFunc;
local _ = game.ReplicatedStorage.Remotes.Output;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local _ = game.ReplicatedStorage["Client Assets"];
local Umbra = ClientAssets.Assets.Abilities.Umbra;
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
Knit.OnStart():andThen(function() -- Line: 28
    -- upvalues: u1 (ref), Knit (copy), u3 (ref), u4 (ref), u6 (ref), PathShortcuts (copy), u5 (ref), u2 (ref)
    u1 = Knit.GetService("MoveInputService");
    u3 = Knit.GetService("LevelService");
    u4 = Knit.GetService("StatService");
    u6 = Knit.GetService("EffectService");
    u5 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("TagService");
end);

local function FindNearest(p7) -- Line: 38
    -- upvalues: CollectionService (copy)
    local Distance = p7.Distance;
    local Origin = p7.Origin;
    local v8 = p7.Ignore or {};
    local v9 = {};

    for _, v in ipairs(p7.Objects or workspace.Living:GetChildren()) do
        if v:IsA("Player") then
            local v = v.Character or v;
        end;

        if not (CollectionService:HasTag(v, "Intangible") or table.find(v8, v)) then
            local v10 = v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart");

            if v10 and (v10.Position - Origin.Position).Magnitude <= Distance then
                table.insert(v9, v);
            end;
        end;
    end;

    table.sort(v9, function(p11, p12) -- Line: 56
        -- upvalues: Origin (copy)
        local v13 = p11:IsA("Model") and p11.PrimaryPart or p11:FindFirstChild("HumanoidRootPart");
        local v14 = p12:IsA("Model") and p12.PrimaryPart or p12:FindFirstChild("HumanoidRootPart");

        return (v13.Position - Origin.Position).Magnitude < (v14.Position - Origin.Position).Magnitude;
    end);

    for _, v in ipairs(v9) do
        local _ = ((v:IsA("Model") and v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")).Position - Origin.Position).Magnitude;
    end;

    return p7.Multiple and v9 and v9 or v9[1];
end;

local function CreateMultiIndicator(p15) -- Line: 70
    local v16 = {};

    for i, v in pairs(p15) do
        if i ~= "Overrides" then
            table.insert(v16, {
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

    if p15.Overrides then
        for _, v in ipairs(v16) do
            for i, v2 in pairs(p15.Overrides) do
                v[i] = v2;
            end;
        end;
    end;

    return v16;
end;

local u17 = {
    {
        Frame = 20,
        ParticleData = {
            Path = "Effects/m1_Thrust",
            AttachTo = {
                Offset = (CFrame.new(0, 0, -1) * CFrame.Angles(0, 0.17453292519943295, 0)):Inverse()
            }
        }
    },
    {
        Frame = 24,
        ParticleData = {
            Path = "Effects/m2_Slash",
            AttachTo = {
                Offset = CFrame.Angles(0, 3.141592653589793, 0)
            }
        }
    },
    {
        Frame = 30,
        ParticleData = {
            Path = "Effects/m2_Slash",
            AttachTo = {
                Offset = CFrame.Angles(3.141592653589793, 0, 3.141592653589793)
            }
        }
    }
};

local function M1DirectHandler(p18, p19, p20) -- Line: 125
    -- upvalues: u5 (ref), u17 (copy), u6 (ref), TableUtil (copy)
    local u21 = p20.Player or p20.Character;
    local Animator = p20.Animator;
    local Character = p20.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Count = u5.GetCharacterState(Character)[p20.Stats.MoveName].Count;
    local v22 = Character:GetAttribute("GlitcherForm");
    local v23 = Character:GetAttribute("Sovereign");
    local v24 = false;
    local v25 = `LMB-{Count}`;

    if p20.SkinName == "MAYHEM" then
        local v26 = v22 == "Rainbow" and "Rainbow-" or v23 and "Sovereign-";

        if v26 then
            u5.StopSound(Character, (`LMB-{Count}`));
        end;

        u5.StopSound(Character, (`LMB-{Count}-Voiceline`));
        u5.PlaySound(Character, (`{v26 or ""}LMB-{Count}`));
        u5.PlaySound(Character, u5.AdjustVoicelineName(Character, `LMB-{Count}-Voiceline`, p20.Stats));

        if v22 == "Mayhem" then
            v24 = true;
            v25 = `MayhemLMB-{Count}`;

            if Count < 4 then
                local u27 = u17[Count];
                p18:AddFrame(u27.Frame, function(p28) -- Line: 154
                    -- upvalues: u6 (ref), TableUtil (ref), u27 (copy), u21 (copy), Character (copy), HumanoidRootPart (copy)
                    local FireAllClients = u6.FireAllClients;
                    local Reconcile = TableUtil.Reconcile;
                    local ParticleData = u27.ParticleData;
                    local v29 = {
                        AbilityName = "Umbra",
                        SkinName = "MAYHEM_Assets",
                        IgnoreSkinShift = true,
                        Player = u21,
                        Character = Character,
                        Origin = HumanoidRootPart.CFrame
                    };
                    local v30 = {
                        Part = HumanoidRootPart
                    };
                    v30.Offset = u27.ParticleData.AttachTo and u27.ParticleData.AttachTo.Offset;
                    v29.AttachTo = v30;
                    FireAllClients("Emit Particle V3", Reconcile(ParticleData, v29));
                end);
            else
                p18:AddFrame(15, function(p31) -- Line: 170
                    -- upvalues: u6 (ref), u21 (copy), Character (copy), HumanoidRootPart (copy)
                    u6.FireAllClients("Emit Particle V3", {
                        Path = "Effects/m4_Slash",
                        AbilityName = "Umbra",
                        SkinName = "MAYHEM_Assets",
                        IgnoreSkinShift = true,
                        Player = u21,
                        Character = Character,
                        Origin = HumanoidRootPart.CFrame,
                        AttachTo = {
                            Part = HumanoidRootPart,
                            Offset = CFrame.Angles(0, 0, -1.2217304763960306)
                        }
                    });
                end);
                p18:AddFrame(22, function(p32) -- Line: 186
                    -- upvalues: u6 (ref), u21 (copy), Character (copy), HumanoidRootPart (copy)
                    u6.FireAllClients("Emit Particle V3", {
                        Path = "Effects/m4_Impact",
                        AbilityName = "Umbra",
                        SkinName = "MAYHEM_Assets",
                        IgnoreSkinShift = true,
                        Player = u21,
                        Character = Character,
                        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -2.85, -11.5)
                    });
                end);
            end;
        end;
    else
        u5.PlaySound(Character, (`LMB-{Count}`));
        u5.PlaySound(Character, (`LMB-{Count}-Voiceline`));
    end;

    if v24 then
        local MayhemHandle = Character.HumanoidRootPart:FindFirstChild("MayhemHandle");

        if MayhemHandle then
            MayhemHandle.Enabled = true;
            p20.Trove:Add(function() -- Line: 209
                -- upvalues: MayhemHandle (copy)
                if not MayhemHandle then
                    return;
                end;

                MayhemHandle.Enabled = false;
            end);
        end;

        Animator:StopAnimation((`LMB-{Count}`));
    end;

    Animator:PlayAnimation(v25, p18:GetSpeed());
end;

local v33 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AbilityName = "Umbra",
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.Universal_HitVFX,
            Color = Color3.fromRGB(255, 135, 255)
        }
    }
};
local v34 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AbilityName = "Umbra",
            LookAt = "Attacker",
            Particle = ClientAssets.Universal.UniversalHeavyVFX,
            Color = Color3.fromRGB(255, 135, 255)
        }
    }
};
local v35 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "UltimateEffects/Ult_TargetHit",
            AbilityName = "Umbra",
            LookAt = "Attacker"
        } }
};
local v36 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "SwordImpale/SI_Uprise",
            AbilityName = "Umbra",
            Offset = CFrame.new(0, -2.5, 0)
        }
    }
};
local v37 = {
    SoundId = 139241679966578,
    Volume = 1
};

return {
    Moveset = {
        Groups = {
            Passive = {
                Visible = true,
                Priority = 4
            },
            Universal = {
                Visible = true,
                Priority = 1
            },
            BaseState = {
                Visible = true,
                Priority = 2
            },
            Sovereign = {
                Visible = false,
                Priority = 3
            }
        },
        MovesInfo = {
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
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
            ["Umbral Dash"] = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false,
                Description = "Teleport and pierce the target"
            },
            ["Umbra Bar"] = {
                State = "Passive",
                Description = "You have a secondary bar. Dealing damage with certain moves will fill up the bar. Upon reaching max bar, gain bonus movement speed, bonus true damage, and reduced stun. However you take increased damage during this state",
                Equipped = true
            },
            ["Sovereign Regeneration"] = {
                State = "Passive",
                Description = "During the sovereign state, you regenerate up to 25 heat.",
                Equipped = true
            },
            ["Piercing Void"] = {
                DefaultKeybind = "E",
                State = "BaseState",
                Unlocked = true,
                Description = "Send out a clone striking all targets. Can be recasted to teleport to the clone and perform a sweep"
            },
            ["Sky Shatter"] = {
                DefaultKeybind = "R",
                State = "BaseState",
                Unlocked = true,
                Description = "Send out a slash"
            },
            ["Empty Mist"] = {
                DefaultKeybind = "T",
                State = "BaseState",
                LevelRequirement = 25,
                Description = "Continuously slash the area while key is held before releasing a finishing slash."
            },
            ["Snowstorm Helix"] = {
                DefaultKeybind = "Y",
                State = "BaseState",
                LevelRequirement = 50,
                Description = "3 hit combo"
            },
            ["Clear Clouds"] = {
                DefaultKeybind = "V",
                State = "BaseState",
                LevelRequirement = 75,
                Description = "Disappear and strike through each target"
            },
            Ultimate = {
                DefaultKeybind = "G",
                State = "BaseState",
                LevelRequirement = 100,
                Description = "Throw your sword at the target before proceeding with lightspeed strikes"
            },
            Sovereign = {
                DefaultKeybind = "H",
                State = "BaseState",
                Unlocked = true,
                Description = "Awaken your true power granting new moves"
            },
            ["Wind Shower"] = {
                DefaultKeybind = "Z",
                LevelRequirement = 75,
                Description = "Phase through all enemies"
            },
            ["Swallowing Void"] = {
                DefaultKeybind = "E",
                State = "Sovereign",
                Unlocked = true,
                Description = "Pull all users in. Can be recasted to summon swords from the ground"
            },
            Devastation = {
                DefaultKeybind = "R",
                State = "Sovereign",
                Unlocked = true,
                Description = "Shoot out 4 slashes then rain down a big sword"
            },
            ["Fallen Leaves"] = {
                DefaultKeybind = "T",
                State = "Sovereign",
                Unlocked = true,
                Description = "Disappear and strike the area with several clones"
            },
            Whirlwind = {
                DefaultKeybind = "Y",
                State = "Sovereign",
                Unlocked = true,
                Description = "Impale the wind sending out a powerful shockwave"
            },
            ["Sword Impalement"] = {
                DefaultKeybind = "V",
                State = "Sovereign",
                Unlocked = true,
                Description = "Impale all nearby targets with your sword"
            },
            ["Ascended Punishment"] = {
                DefaultKeybind = "G",
                State = "Sovereign",
                Unlocked = true,
                Description = "Rain down swords from the sky"
            },
            ["Threefold Slice"] = {
                DefaultKeybind = "H",
                State = "Sovereign",
                Unlocked = true,
                Description = "Summon 2 clones and perform a dash strike"
            }
        }
    },
    Animations = {
        Action2 = {
            BlockHit1 = 18880552679,
            BlockHit2 = 18880553982,
            BlockHit3 = 18880555805
        },
        Action = {
            ["LMB-1"] = 18995076835,
            ["LMB-2"] = 18995084576,
            ["LMB-3"] = 18995086236,
            ["LMB-4"] = 18995089825,
            ["Piercing Void"] = 18835649286,
            ["Speed Blitz Startup"] = 18973380721,
            ["Speed Blitz Camera"] = 18986636204,
            ["Speed Blitz Victim"] = 18986640519,
            ["Speed Blitz User"] = 18986642836,
            Helix = 17877368124,
            ["Sky Shatter"] = 17877369423,
            ["Empty Mist Startup"] = 17877396146,
            ["Empty Mist Barrage"] = 17877394283,
            ["Empty Mist Finisher"] = 17877392935,
            ["Clear Clouds Startup"] = 17877382405,
            ["Clear Clouds Loop"] = 17877380885,
            ["Clear Clouds Finisher"] = 17877379228,
            Grab = 17877363283,
            ["Grab Victim"] = 17877359717,
            ["Grab Camera"] = 17877358423,
            Ult = 17877399168,
            ["Ult Startup"] = 17877397558,
            ["Ult Victim"] = 17877401082,
            ["Ult Camera"] = 17877405199,
            Sovereign = 18837264287,
            ["Sovereign Camera"] = 18837267302,
            ["Swallowing Void Pull"] = 18841126961,
            ["Swallowing Void Swords"] = 18841128407,
            ["Wind Shower Startup"] = 137929321303604,
            ["Wind Shower"] = 123726650128171,
            Devastation = 18878315860,
            Whirlwind = 18879768184,
            ["Fallen Leaves Finisher"] = 139781952818461,
            ["Threefold Slice"] = 94940812552820,
            ["Sword Impale Startup"] = 18880310794,
            ["Sword Impale Loop"] = 18880312205,
            ["Sword Impale End"] = 18880313995,
            ["Ascended Punishment Startup"] = 18880563138,
            ["Ascended Punishment Loop"] = 18880561620,
            PoseTransition = 18837467920,
            PoseIdle = 18837464239,
            Obtainment = 126965734605860,
            ["Obtainment Camera"] = 130894642902946,
            Block = 18880547724
        },
        Movement = {
            Run = 17877335827,
            Walk = 17877337355,
            ["Sovereign-Run"] = 18880535738,
            ["Sovereign-Walk"] = 18880537421
        },
        Idle = {
            Idle = 17877333382,
            ["Sovereign-Idle"] = 18880533978
        }
    },
    Stats = {
        Block = {
            From = "Combat.Block"
        },
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p38, p39) -- Line: 308, Name: PoseTransition
                    -- upvalues: Knit (copy)
                    Knit.GetService("EffectService").FireAllClients("UmbraPoseAfterimage", {
                        Player = p38.Player,
                        Attacker = p38.Character,
                        HSVShift = p39.ParticleHandler.GetHSVShift(p38)
                    });
                end
            }
        },
        ["Umbral Dash"] = {
            Active = true,
            Actionable = {
                Active = {
                    Ignore = { "Block" }
                }
            },
            ClientActionable = {
                Active = {
                    Ignore = { "Block", "Block_Client" }
                }
            },
            Cooldown = {
                Time = 1.5,
                Force = true,
                CooldownReduction = false
            },
            Tweens = {
                End = { 0.5, Enum.EasingStyle.Sine }
            },
            Props = {
                Start = {
                    Transparency = 0,
                    Color = Color3.new(1, 0, 1)
                },
                End = {
                    Transparency = 1
                }
            },

            Invoke = function(p40) -- Line: 350, Name: Invoke
                -- upvalues: RunService (copy), u1 (ref)
                local _ = p40.Input;
                local _ = p40.Stats;
                local _ = p40.Player;
                local Humanoid = p40.Character.Humanoid;

                if RunService:IsServer() then
                    return;
                end;

                u1:FireInput(p40.RawInput, Humanoid.MoveDirection);
            end
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {},
            Damage = 4,
            MaxCombo = 4,
            ComboTick = 1.5,
            UmbraBar = 5,
            NoEndlag = true,
            HitRemotes = { v33 },
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.15,
                Stun = {
                    Time = 0.75
                },
                Sequence = {
                    { 0, "Start" },
                    { 0, M1DirectHandler },
                    { 18, function(p41, p42, p43, p44) -- Line: 392
                            -- upvalues: Knit (copy)
                            local v45 = Knit.GetService("EffectService");
                            local _ = p44.AttackStats;
                            local _ = p43.Input;
                            v45.FireAllClients("Emit Particle V3", {
                                Path = "m1 effects/fx1",
                                AbilityName = "Umbra",
                                Player = p43.Player,
                                Origin = p43.Character.HumanoidRootPart,
                                SkinName = p43.SkinName
                            });
                        end },
                    { 18, 25, "Attack" },
                    { 30, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 93439447579591,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.15,
                Stun = {
                    Time = 0.75
                },
                Hitbox = {
                    Size = 10,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Sequence = {
                    { 0, "Start" },
                    { 0, M1DirectHandler },
                    { 23, function(p46, p47, p48, p49) -- Line: 434
                            -- upvalues: Knit (copy)
                            local v50 = Knit.GetService("EffectService");
                            local _ = p49.AttackStats;
                            local _ = p48.Input;
                            v50.FireAllClients("Emit Particle V3", {
                                Path = "m1 effects/fx2",
                                AbilityName = "Umbra",
                                Player = p48.Player,
                                Origin = p48.Character.HumanoidRootPart,
                                SkinName = p48.SkinName
                            });
                        end },
                    { 23, 30, "Attack" },
                    { 35, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 123070955525325,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.15,
                Stun = {
                    Time = 0.65
                },
                Hitbox = {
                    Size = 10,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Sequence = {
                    { 0, "Start" },
                    { 0, M1DirectHandler },
                    { 25, function(p51, p52, p53, p54) -- Line: 475
                            -- upvalues: Knit (copy)
                            local v55 = Knit.GetService("EffectService");
                            local _ = p54.AttackStats;
                            local _ = p53.Input;
                            v55.FireAllClients("Emit Particle V3", {
                                Path = "m1 effects/fx3",
                                AbilityName = "Umbra",
                                Player = p53.Player,
                                Origin = p53.Character.HumanoidRootPart,
                                SkinName = p53.SkinName
                            });
                        end },
                    { 25, 30, "Attack" },
                    { 35, "End" }
                },
                HitSounds = {
                    Hit = {
                        SoundId = 123070955525325,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.15,
                Stun = {
                    Time = 0.35
                },
                Hitbox = {
                    Size = Vector3.new(8, 8, 12),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                Sequence = {
                    { 0, "Start" },
                    { 0, M1DirectHandler },
                    { 21, function(p56, p57, p58, p59) -- Line: 516
                            -- upvalues: Knit (copy)
                            local v60 = Knit.GetService("EffectService");
                            local _ = p59.AttackStats;
                            local _ = p58.Input;
                            v60.FireAllClients("Emit Particle V3", {
                                Path = "m1 effects/fx4",
                                AbilityName = "Umbra",
                                Player = p58.Player,
                                Origin = p58.Character.HumanoidRootPart,
                                SkinName = p58.SkinName
                            });
                        end },
                    { 21, 30, "Attack" },
                    { 35, "End" }
                },
                HitRemotes = { v34 },
                HitSounds = {
                    Hit = {
                        SoundId = 91754943070221,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher)
        },
        ["Piercing Void"] = {
            Actionable = {
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 12,
                Manual = true,
                Name = "Piercing Void"
            },
            ["PiercingVoid-1"] = {
                UmbraBar = 5,
                Damage = 10,
                Hitbox = {
                    Size = Vector3.new(8, 8, 8),
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1
                },
                HitSounds = {
                    Hit = {
                        SoundId = 134562688167820,
                        Volume = 1
                    }
                }
            },
            ["PiercingVoid-2"] = {
                UmbraBar = 5,
                Damage = 10,
                Hitbox = {
                    Size = 25,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1
                },
                Block = {
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = {
                        SoundId = 134562688167820,
                        Volume = 1
                    }
                }
            }
        },
        ["Sky Shatter"] = {
            Active = true,
            UmbraBar = 5,
            Damage = 20,
            Distance = 5,
            Piercing = true,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                Size = 12,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 0.4
            },
            Block = {
                PerfectBlockable = false
            },
            HitSounds = {
                Hit = v37
            }
        },
        ["Empty Mist"] = {
            Active = true,
            UmbraBar = 0.5,
            Damage = 2.25,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Meter = {
                MeterGain = 0
            },
            Hitbox = {
                Size = 25,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 0.75
            },
            Block = {
                PerfectBlockable = false
            },
            HitSounds = {
                Hit = v37
            },
            Finisher = {
                UmbraBar = 5,
                Damage = 10,
                Stun = {
                    Time = 0.875
                },
                Block = {
                    BlockBreak = true,
                    PerfectBlockable = false
                },
                Meter = {
                    MeterGain = 0
                },
                HitSounds = {
                    Hit = v37
                }
            }
        },
        ["Snowstorm Helix"] = {
            Active = true,
            UmbraBar = 2.5,
            Damage = 8,
            Actionable = {
                Active = true
            },
            Cooldown = {
                Time = 10,
                AfterMove = true
            },
            Hitbox = {
                Size = 12,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 1.25
            },
            HitSounds = {
                Hit = v37
            },
            Finisher = {
                UmbraBar = 2,
                Damage = 3,
                Stun = {
                    Time = 0.8
                },
                Block = {
                    PerfectBlockable = false
                },
                HitSounds = {
                    Hit = v37
                }
            }
        },
        ["Clear Clouds"] = {
            Active = true,
            Damage = 25,
            Actionable = {
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                Size = 100,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 1
            },
            Block = {
                Blockable = false,
                PerfectBlockable = false
            },
            HitRemotes = {
                {
                    Name = "Output",
                    Arguments = {
                        "FX",
                        "HitEffect V3",
                        {
                            Attacker = "__Attacker",
                            Target = "__Target",
                            AbilityName = "Umbra",
                            LookAt = "Attacker",
                            Particle = Umbra.ClearClouds.Hit
                        }
                    }
                }
            },
            HitSounds = {
                Hit = v37
            }
        },
        Grab = {
            Active = true,
            Actionable = {
                Active = true
            },
            Hitbox = {
                Size = 25,
                Debug = false,
                Offset = CFrame.identity
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 15
            },
            Hit = {
                Damage = 15,
                Priority = EnumsModule.Intangible.Move + 1,
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                }
            },
            HitSecond = {
                Damage = 15,
                Priority = EnumsModule.Intangible.Move + 1,
                Ragdoll = {
                    Time = 1
                },
                Knockback = {
                    RelativePart = "Attacker",
                    Speed = 50,
                    Velocity = Vector3.new(0, 27, 0),
                    Time = 0.25
                },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false
                }
            }
        },
        Ultimate = {
            Active = true,
            CheckPVPSafe = true,
            Actionable = {
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 75
            },
            Cooldown = {
                Time = 60,
                AfterMove = true
            },
            Hitbox = {
                Size = 8,
                Debug = false,
                Offset = CFrame.new(0, 0, -4)
            },
            StartHit = {
                Damage = 10,
                MinHealth = 1,
                DamagePartName = "Torso",
                HitRemotes = { v35 },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            },
            SwordHit = {
                Damage = 8,
                MinHealth = 1,
                DamagePartName = "Torso",
                HitRemotes = { v35 },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            },
            SlashHit = {
                Damage = 1.5,
                MinHealth = 1,
                DamagePartName = "Torso",
                HitRemotes = { v35 },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            },
            FinalHit = {
                Damage = 20,
                DamagePartName = "Torso",
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "UltimateEffects/Ult_TargetFinalHit",
                                AbilityName = "Umbra",
                                LookAt = "Attacker"
                            } }
                    } },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            }
        },
        Sovereign = {
            Active = true,
            Actionable = {
                MasteryRank = 1,
                Active = true
            },
            Meter = {
                RequiredAmount = 100
            },
            VFX = Umbra.AwakenEffects.SwordAwakenAura,
            Cooldown = {
                Time = 1,
                AfterMove = true
            }
        },
        ["Wind Shower"] = {
            Active = true,
            CheckPVPSafe = true,
            Actionable = {
                MasteryRank = 9,
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 30
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(25, 25, 50),
                Debug = false,
                Offset = CFrame.new(0, 0, -25)
            },
            WindHit = {
                UmbraBar = 5,
                Damage = 10,
                Meter = {
                    MeterGain = 0
                },
                Stun = {
                    Time = 2.5
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            },
            Slashes = {
                UmbraBar = 2.5,
                Damage = 2,
                Stun = {
                    Time = 1.25
                },
                Meter = {
                    MeterGain = 0
                },
                HitSounds = {
                    Hit = {
                        SoundId = 82750044561397,
                        Volume = 1
                    }
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            },
            FinalSlash = {
                UmbraBar = 5,
                Damage = 12,
                Stun = {
                    Time = 1.65
                },
                Block = {
                    Blockable = false,
                    Unblockable = true,
                    PerfectBlockable = false
                }
            }
        },
        ["Swallowing Void"] = {
            Actionable = {
                MasteryRank = 3,
                Active = true
            },
            Active = true,
            Cooldown = {
                Time = 17.5,
                Manual = true,
                Name = "Swallowing Void"
            },
            Meter = {
                MeterGain = 0
            },
            _Meter = {
                RequiredAmount = 0
            },
            ["SwallowingVoid-1"] = {
                UmbraBar = 5,
                Damage = 10,
                Hitbox = {
                    Size = 20,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = true
                }
            },
            ["SwallowingVoid-2"] = {
                UmbraBar = 5,
                Damage = 17.5,
                Hitbox = {
                    Size = 25,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Stun = {
                    Time = 1
                },
                HitSounds = {
                    Hit = v37
                },
                Block = {
                    Blockable = true,
                    PerfectBlockable = false
                }
            }
        },
        Devastation = {
            Active = true,
            Actionable = {
                MasteryRank = 6,
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 30
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Sword = {
                UmbraBar = 2.5,
                Damage = 4,
                Hitbox = {
                    Size = 42.5,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Priority = EnumsModule.Intangible.Quickstep,
                Stun = {
                    Time = 1
                },
                Block = {
                    BlockBreak = true,
                    PerfectBlockable = false,
                    BypassCounter = true
                },
                Meter = {
                    MeterGain = 0
                }
            },
            MoveProjectile = {
                UmbraBar = 5,
                Damage = 5.5,
                Piercing = true,
                Hitbox = {
                    Size = 12,
                    Debug = false,
                    Offset = CFrame.identity
                },
                Block = {
                    PerfectBlockable = false
                },
                Meter = {
                    MeterGain = 0
                },
                Stun = {
                    Time = 0.2
                },
                HitSounds = {
                    Hit = {
                        SoundId = 129398040600405,
                        Volume = 1
                    }
                }
            }
        },
        ["Fallen Leaves"] = {
            Active = true,
            Damage = 2,
            Actionable = {
                MasteryRank = 5,
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                Size = 25,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 0.75
            },
            HitSounds = {
                Hit = {
                    SoundId = 108239250619227,
                    Volume = 0.5
                }
            },
            Finisher = {
                Damage = 4,
                Stun = {
                    Time = 1
                },
                Meter = {
                    MeterGain = 0
                }
            }
        },
        Whirlwind = {
            Active = true,
            UmbraBar = 5,
            Damage = 8,
            Piercing = true,
            Actionable = {
                MasteryRank = 4,
                Active = true
            },
            Cooldown = {
                Time = 15,
                AfterMove = true
            },
            Hitbox = {
                Size = 12,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 1
            },
            Block = {
                Unblockable = true,
                BypassCounter = true
            },
            HitSounds = {
                Hit = v37
            }
        },
        ["Sword Impalement"] = {
            Active = true,
            Damage = 25,
            HitboxGrowth = 10,
            Actionable = {
                MasteryRank = 2,
                Active = true
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 25
            },
            Cooldown = {
                Time = 20,
                AfterMove = true
            },
            Hitbox = {
                Size = 50,
                Debug = false,
                Offset = CFrame.identity
            },
            Stun = {
                Time = 0.5
            },
            Block = {
                Unblockable = true
            },
            HitRemotes = { v36 },
            HitSounds = {
                Hit = v37
            }
        },
        ["Ascended Punishment"] = {
            Active = true,
            Damage = 5,
            Actionable = {
                MasteryRank = 7,
                Active = true
            },
            LastHit = {
                Damage = 5,
                Hitbox = {
                    Size = 70,
                    Debug = false,
                    Offset = CFrame.new(0, 0, -30)
                },
                Block = {
                    Blockable = false,
                    PerfectBlockable = false,
                    BypassCounter = true
                },
                Stun = {
                    Time = 1
                },
                HitSounds = {
                    Hit = {
                        SoundId = 108239250619227,
                        Volume = 0.5
                    }
                },
                Ragdoll = {
                    Time = 0.4
                }
            },
            Meter = {
                MeterGain = 0,
                RequiredAmount = 50
            },
            Cooldown = {
                Time = 45,
                AfterMove = true
            },
            Hitbox = {
                Size = 70,
                Debug = false,
                Offset = CFrame.new(0, 0, -30)
            },
            Block = {
                Unblockable = true,
                BypassCounter = true
            },
            Stun = {
                Time = 1
            },
            HitSounds = {
                Hit = {
                    SoundId = 108239250619227,
                    Volume = 0.5
                }
            }
        },
        ["Threefold Slice"] = {
            Active = true,
            UmbraBar = 10,
            Damage = 25,
            Actionable = {
                MasteryRank = 8,
                Active = true
            },
            Cooldown = {
                Time = 16,
                AfterMove = true
            },
            Hitbox = {
                Size = Vector3.new(25, 25, 50),
                Debug = false,
                Offset = CFrame.new(0, 0, -25)
            },
            Stun = {
                Time = 1.5
            },
            Block = {
                BlockBreak = true,
                PerfectBlockable = false,
                BypassCounter = true
            },
            HitSounds = {
                Hit = v37
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 110631052430335,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 78415191851741,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 79426093394273,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 104445796427449,
            Volume = 1
        },
        ["Grab-Startup"] = {
            SoundId = 99854589280833,
            Volume = 1.5
        },
        ["Grab-Hit"] = {
            SoundId = 124153111684773,
            Volume = 1.5
        },
        ["PiercingVoid-First"] = {
            SoundId = 100972283340790,
            Volume = 1.5
        },
        ["PiercingVoid-Second"] = {
            SoundId = 117903892572411,
            Volume = 1.5
        },
        SkyShatter = {
            SoundId = 137902271758741,
            Volume = 1.5
        },
        SnowstormHelix = {
            SoundId = 131759475339280,
            Volume = 1.5
        },
        ["EmptyMist-Startup"] = {
            SoundId = 110744272786987,
            Volume = 1.5
        },
        ["EmptyMist-Loop"] = {
            SoundId = 127488152422532,
            Volume = 1.5,
            Looped = true
        },
        ["EmptyMist-Finisher"] = {
            SoundId = 72431362033100,
            Volume = 1.5
        },
        UmbralDash = {
            SoundId = 107689590620520,
            Volume = 1.5
        },
        WindShower = {
            SoundId = 74354095576602,
            Volume = 1.5
        },
        ["WindShower-Final"] = {
            SoundId = 105110585700596,
            Volume = 1.5
        },
        ClearClouds = {
            SoundId = 123027113716735,
            Volume = 1.5
        },
        ["ClearClouds-Teleport"] = {
            SoundId = 96912171921806,
            Volume = 1.5
        },
        ["ClearClouds-Final"] = {
            SoundId = 125205903173587,
            Volume = 1.5
        },
        ["Ultimate-Startup"] = {
            SoundId = 77916472518015,
            Volume = 1.5
        },
        Ultimate = {
            SoundId = 74975714714099,
            Volume = 1.5
        },
        SovereignAwaken = {
            SoundId = 90804769315160,
            Volume = 1
        },
        Whirlwind = {
            SoundId = 112850879801156,
            Volume = 1
        },
        ["SwallowingVoid-First"] = {
            SoundId = 73961760967213,
            Volume = 1
        },
        ["SwallowingVoid-Second"] = {
            SoundId = 134823621808019,
            Volume = 1
        },
        Devastation = {
            SoundId = 113399591072045,
            Volume = 1.5
        },
        ["Devastation-Sword"] = {
            SoundId = 100629091841041,
            Volume = 1.5
        },
        FallenLeaves = {
            SoundId = 136408853300539,
            Volume = 1.5
        },
        ["FallenLeaves-Teleport"] = {
            SoundId = 90672493984771,
            Volume = 1.5
        },
        ["FallenLeaves-Tornado"] = {
            SoundId = 72863343222609,
            Volume = 1.5
        },
        ["SwordImpalement-Startup"] = {
            SoundId = 71548309112210,
            Volume = 1
        },
        ["SwordImpalement-Spawn"] = {
            SoundId = 139784057235473,
            Volume = 1
        },
        AscendedPunishment = {
            SoundId = 134306679676060,
            Volume = 1
        },
        ["AscendedPunishment-Sword"] = {
            SoundId = 125873008200154,
            Volume = 1
        },
        ThreefoldSlice = {
            SoundId = 83266328273304,
            Volume = 1
        },
        PoseMusic = {
            Looped = true,
            SoundId = 12365907238,
            Volume = 2.5
        },
        SovereignEasterEgg = {
            SoundId = 106871432079873,
            Volume = 2.5
        }
    },
    Metadata = {
        Hooks = {
            UmbraBar = {
                CombatHook = "Attack",
                HookType = "Event",
                HookName = "UmbraBarHook",
                Priority = 99,

                HookFunction = function(p61) -- Line: 1888, Name: HookFunction
                    -- upvalues: u4 (ref), Trove (copy), u2 (ref)
                    if p61.State.Success ~= true then
                        return true;
                    end;

                    local Attacker = p61.Attacker;
                    local v62 = p61.Stats or {};

                    if typeof(Attacker) ~= "Instance" then
                        return true;
                    end;

                    if not (p61.Damage and p61.Damage > 0) then
                        return true;
                    end;

                    local v63 = Attacker:GetAttribute("MasteryRank") or 0;
                    local v64 = u4.GetStatsInfo(p61.Attacker);
                    local u65 = (not v64 or v63 < 10) and 0 or v64:GetStats():GetSpecial();

                    if v62.UmbraBar then
                        local u66 = (Attacker:GetAttribute("UmbraBar") or 0) + v62.UmbraBar;
                        local v67 = Attacker:GetAttribute("UmbraBarMax") or 100;

                        if v67 < u66 then
                            u66 = v67;
                        end;

                        Attacker:SetAttribute("UmbraBar", u66);

                        if v67 <= u66 and not Attacker:GetAttribute("UmbraBarDrain") then
                            task.spawn(function() -- Line: 1919
                                -- upvalues: Attacker (copy), Trove (ref), u2 (ref), u65 (copy), u66 (ref)
                                Attacker:SetAttribute("UmbraBarDrain", true);
                                local v68 = Trove.new();
                                local v69 = u2:GetContainer(Attacker);
                                v68:Add(u2:Add(v69, "BonusTrueDamage", 0.15 + u65 * 0.15 / 100));
                                v68:Add(u2:Add(v69, "DamageReceivalMultiplier", 1.25));
                                v68:Add(u2:Add(v69, "MinWalkSpeed", 36));
                                local v70 = 1;

                                while u66 > 0 do
                                    local v71 = task.wait(0.1);
                                    u66 = Attacker:GetAttribute("UmbraBar") - 5 ^ v70 * v71;
                                    v70 = v70 + 0.05 * v71;
                                    Attacker:SetAttribute("UmbraBar", u66);
                                end;

                                Attacker:SetAttribute("UmbraBar", 0);
                                Attacker:SetAttribute("UmbraBarDrain", nil);
                                v68:Destroy();
                            end);
                        end;
                    end;

                    return true;
                end
            }
        },

        CustomAddon = function(p72) -- Line: 1952, Name: CustomAddon
            local Character = p72.Character;
            Character:SetAttribute("UmbraBar", 0);
            Character:SetAttribute("UmbraBarMax", 100);
        end
    },
    MasteryData = {
        MaxMasteryRank = 12,

        PointCap = function(p73) -- Line: 1961, Name: PointCap
            return p73 >= 5 and 200 or (p73 >= 1 and 100 or 1);
        end
    }
};
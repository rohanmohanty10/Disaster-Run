  

 

game:GetService("Players");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Sequence_V2 = require(PathShortcuts.ReplicatedModules.Classes.Sequence_V2);
local Knit = require(PathShortcuts.KnitPath.Knit);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5;

if game:GetService("RunService"):IsServer() then
    local v6 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Dragon Knight", true);
    require(v6.Common);
    u5 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u5 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 26
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);

return {
    Inherit = {
        AbilityName = "Dragon Knight"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684251807,
                        Volume = 1
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684251807,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684251807,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684251632,
                        Volume = 1
                    }
                }
            }
        },
        Grab = {
            AttackFrame = 120,
            GrabOffset = CFrame.new(0, 0, -2.8),
            ExtraFrames = {
                { 0, function(p7, p8, p9, p10) -- Line: 82
                        -- upvalues: u5 (ref)
                        local Character = p10.Character;
                        u5.GetMiddleware("CombatService").PlaySound(Character, "Grab SFX");
                    end }
            }
        },
        ["Scorching Lunge"] = {
            Lunge = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684250621,
                        Volume = 1
                    }
                }
            },
            Explosion = {
                HitSounds = {
                    Hit = {
                        SoundId = 17684251056,
                        Volume = 1
                    }
                }
            }
        },
        ["Dragon\'s Fury"] = {
            HitSounds = {
                Hit = {
                    SoundId = 17684251334,
                    Volume = 1
                }
            }
        },
        Pose = {
            Callbacks = {
                PoseTransition = function(p11, p12) -- Line: 122, Name: PoseTransition
                    -- upvalues: u5 (ref), u3 (ref), AssetHandler (copy), ParticleHandler (copy), u2 (ref)
                    local _ = p11.Stats;
                    local Player = p11.Player;
                    local Character = p11.Character;
                    local RootPart = p11.RootPart;
                    local u13 = p12.Trove or p11.Trove;
                    local Tags = p11.Tags;
                    local Animator = p11.Animator;
                    local v14 = u5.GetMiddleware("CombatService");
                    local v15 = Player.UserId == 110231579 and "Models/NubDummy" or "Models/Dummy";
                    local u16 = {
                        AbilityName = "Dragon Knight",
                        SkinName = "Reinhardt"
                    };
                    u13:Add(u3:Add(Tags, "NoRotate"));
                    local u17 = u13:Add(AssetHandler.CloneAsset(v15, u16));
                    u17.Parent = workspace.Effects;
                    local v18 = next;
                    local v19, v20 = u17:GetDescendants();
                    local u21 = {};

                    for _, v in v18, v19, v20 do
                        if v:GetAttribute("RecolorablePart") then
                            table.insert(u21, v);
                        end;
                    end;

                    local function Recolor(p22, p23) -- Line: 154
                        -- upvalues: u21 (copy)
                        for _, v in u21 do
                            if v:GetAttribute("RecolorablePart") then
                                if v:IsA("Decal") then
                                    v.Color3 = p22;
                                elseif v:IsA("ParticleEmitter") then
                                    v.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p23), ColorSequenceKeypoint.new(1, p22) });
                                else
                                    v.Color = p22;
                                end;
                            end;
                        end;
                    end;

                    v14.PlaySound(Character, "Pose SFX");
                    v14.PlaySound(Character, "Pose Voiceline");
                    v14.ChangeCollision(u17, "NoCollision");
                    local v24 = u13:Construct(Instance, "Weld");
                    v24.Part0 = RootPart;
                    v24.Part1 = u17.HumanoidRootPart;
                    v24.Parent = RootPart;
                    local v25 = Animator:GetAnimation("Dummy Pose Transition");
                    local v26 = Animator:GetAnimation("Dummy Pose Loop");
                    local Animation = v25.Animation;
                    local Animation2 = v26.Animation;

                    if Animation and Animation2 then
                        local v27 = u17.Humanoid:LoadAnimation(Animation);
                        v27:Play();
                        Character:FindFirstChild("ArmorMesh", true);
                        task.delay(3.25, function() -- Line: 191
                            -- upvalues: ParticleHandler (ref), u17 (copy)
                            ParticleHandler.Emit(u17.Torso.HitFX, ParticleHandler.GenerateEmitInfo(u17.Torso.HitFX));
                        end);
                        task.delay(0.8, function() -- Line: 195
                            -- upvalues: Character (copy), ParticleHandler (ref), u13 (copy)
                            local Cube = Character["Dragon Knight Skin"].Pivot.Cube;
                            ParticleHandler.EnableParticle(Cube, true);
                            u13:Add(function() -- Line: 198
                                -- upvalues: ParticleHandler (ref), Cube (copy)
                                ParticleHandler.EnableParticle(Cube, false);
                            end);
                        end);
                        task.delay(4.783333333333333, function() -- Line: 203
                            -- upvalues: Character (copy), ParticleHandler (ref)
                            ParticleHandler.EnableParticle(Character["Dragon Knight Skin"].Pivot.Cube, false);
                        end);
                        task.delay(5.533333333333333, function() -- Line: 208
                            -- upvalues: Character (copy), ParticleHandler (ref), u13 (copy)
                            local Cube = Character["Dragon Knight Skin"].Pivot.Cube;
                            ParticleHandler.EnableParticle(Cube, true);
                            u13:Add(function() -- Line: 211
                                -- upvalues: ParticleHandler (ref), Cube (copy)
                                ParticleHandler.EnableParticle(Cube, false);
                            end);
                        end);
                        task.delay(5.783333333333333, function() -- Line: 216
                            -- upvalues: Character (copy), ParticleHandler (ref)
                            ParticleHandler.EnableParticle(Character["Dragon Knight Skin"].Pivot.Cube, false);
                        end);
                        task.delay(8.666666666666666, Recolor, Color3.new(0, 0, 0), Color3.new(0, 0, 0));
                        task.delay(9, Recolor, Color3.new(1, 0, 0), Color3.fromRGB(172, 0, 0));
                        task.delay(9.05, Recolor, Color3.new(0, 0, 0), Color3.new(0, 0, 0));
                        task.delay(9.166666666666666, Recolor, Color3.new(1, 0, 0), Color3.fromRGB(172, 0, 0));
                        task.delay(9.216666666666667, Recolor, Color3.new(0, 0, 0), Color3.new(0, 0, 0));
                        task.delay(9.45, Recolor, Color3.new(1, 0, 0), Color3.fromRGB(172, 0, 0));
                        task.delay(9.5, Recolor, Color3.new(0, 0, 0), Color3.new(0, 0, 0));
                        u13:Connect(v27:GetMarkerReachedSignal("Exclaim"), function() -- Line: 229
                            -- upvalues: ParticleHandler (ref), u17 (copy)
                            ParticleHandler.Emit(u17.Meshes.Face.EyesIndication, ParticleHandler.GenerateEmitInfo(u17.Meshes.Face.NoticeEmitFX));
                            ParticleHandler.Emit(u17.Meshes.Face.NoticeEmitFX, ParticleHandler.GenerateEmitInfo(u17.Meshes.Face.NoticeEmitFX));
                        end);
                        u13:Connect(v27:GetMarkerReachedSignal("Slam"), function() -- Line: 234
                            -- upvalues: RootPart (copy), Recolor (copy), u2 (ref), Player (copy), ParticleHandler (ref), u17 (copy)
                            local v28 = RootPart.CFrame * CFrame.new(1, 0, -5);
                            Recolor(Color3.new(1, 0, 0), Color3.fromRGB(172, 0, 0));
                            u2.FireAllClients("Emit Particle V3", {
                                RawPath = true,
                                Path = "Universal/Combat/Particles/Slam",
                                AutoSerialize = true,
                                Scale = 0.4,
                                Origin = v28 * CFrame.new(0, -3, 0)
                            });
                            u2.FireAllClients("Flying Debris", {
                                Lifetime = 2.5,
                                Collision = true,
                                Size = 1.5,
                                Force = Vector3.new(32, 44.8, 32),
                                TweenDelay = 0.9,
                                Origin = v28,
                                Tween = {
                                    Transparency = 1,
                                    Size = Vector3.new(0, 0, 0)
                                }
                            });
                            u2.FireAllClients("Rock Debris", {
                                Lifetime = 1.5,
                                Size = Vector3.new(1.5, 1.5, 1.5),
                                Radius = 8,
                                Amount = 17,
                                Origin = v28
                            });

                            if Player then
                                u2.FireClient(Player, "CameraShake", 5.5, 13, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                            end;

                            task.wait(0.05);
                            ParticleHandler.Emit(u17.Torso.SmashedEffect, ParticleHandler.GenerateEmitInfo(u17.Torso.SmashedEffect));
                        end);
                        u13:Connect(v27:GetMarkerReachedSignal("Blood"), function() -- Line: 274
                            -- upvalues: u2 (ref), u17 (copy), u16 (copy), Player (copy), ParticleHandler (ref)
                            u2.FireAllClients("Blood Rays", {
                                DirectionOffset = Vector3.new(0, 15, 0),
                                Trail = "Particles/OilTrail",
                                Slam = "Particles/GroundOil",
                                Part = u17.Torso,
                                TrailRange = NumberRange.new(5, 10),
                                Path = u16
                            });

                            if Player then
                                u2.FireClient(Player, "CameraShake", 3.5, 10, 0, 0.45, Vector3.new(0.25, 0.25, 0.25), Vector3.new(4, 1, 1), true);
                            end;

                            ParticleHandler.EnableAllParticles(u17.Torso.BleedEffect, true);
                        end);
                        v27.Stopped:Wait();
                        u17.Humanoid:LoadAnimation(Animation2):Play();
                    end;
                end
            }
        }
    },
    Animations = {
        Action = {
            ["Dragon\'s Fury"] = 17478664813,
            ["Flame Pillar"] = 17466752329,
            ["LMB-1"] = 17478677819,
            ["LMB-2"] = 17478679920,
            ["LMB-3"] = 17478681673,
            ["LMB-4"] = 17506187228,
            Roar = 17460184110,
            Lunge = 17412583672,
            Fireball = 17412666278,
            Slam = 17422397987,
            Leap = 17466740363,
            Rebirth = 17478965189,
            ["StandOff-Grab"] = 17592818046,
            ["StandOff-Throw"] = 17640996350,
            ["StandOff-ThrowVictim"] = 17640999474,
            ["Inferno Beam Startup"] = 17410371730,
            ["Inferno Beam Loop"] = 17410370135,
            PoseIdle = 17583320689,
            PoseTransition = 17754415343,
            ["Dummy Pose Loop"] = 17583608454,
            ["Dummy Pose Transition"] = 17754607067,
            ["Quote-1"] = 17536721903,
            ["Quote-2"] = 17536815195,
            ["Quote-3"] = 17536819668,
            ["Quote-4"] = 17536824695,
            ["Quote-4-Idle"] = 17536837079,
            ["Quote-5"] = 17561942189,
            ["Quote-5-Idle"] = 17561693834
        },
        Movement = {
            Walk = 17562349889,
            Run = 17562351766
        },
        Idle = {
            Idle = 17410050554
        }
    },
    Sounds = {
        Leap = {
            SoundId = 17621473833,
            Volume = 3
        },
        ["Leap 1"] = {
            SoundId = "rbxassetid://17686025729",
            Volume = 3
        },
        ["Leap 2"] = {
            SoundId = "rbxassetid://17686025504",
            Volume = 3
        },
        Land = {
            SoundId = 17621472422,
            Volume = 3
        },
        ["Land 1"] = {
            SoundId = "rbxassetid://17686024563",
            Volume = 3
        },
        ["Land 2"] = {
            SoundId = "rbxassetid://17686025092",
            Volume = 3
        },
        Grabbed = {
            SoundId = 17684311043,
            Volume = 2
        },
        Throw = {
            SoundId = 17686026313,
            Volume = 2
        },
        ["Grab SFX"] = {
            SoundId = 17686026087,
            Volume = 2
        },
        Rebirth = {
            SoundId = 17684324585,
            Volume = 3
        },
        ["Rebirth Ambience"] = {
            SoundId = 17723574061,
            Looped = true,
            Volume = 0.8
        },
        ["Rebirth 1"] = {
            SoundId = 17694595412,
            Volume = 3
        },
        ["Rebirth 2"] = {
            SoundId = 17694595953,
            Volume = 3
        },
        ["Rebirth 3"] = {
            SoundId = 17694594739,
            Volume = 3
        },
        ["Wyrm\'s Roar"] = {
            SoundId = 17621472974,
            Volume = 3
        },
        ["Wyrm\'s Roar Voiceline"] = {
            SoundId = 17684300981,
            Volume = 3
        },
        Absorption = {
            SoundId = 17621554532,
            Volume = 3
        },
        ["Shield Activation"] = {
            SoundId = 17621473351,
            Volume = 3
        },
        ["Shield Activation Voiceline 1"] = {
            SoundId = 17683892806,
            Volume = 3
        },
        ["Shield Activation Voiceline 2"] = {
            SoundId = 17683891701,
            Volume = 3
        },
        ["Shield Deactivate Voiceline 1"] = {
            SoundId = 17683891458,
            Volume = 3
        },
        ["Shield Deactivate Voiceline 2"] = {
            SoundId = 17683892000,
            Volume = 3
        },
        ["Shield Deactivate"] = {
            SoundId = 17621472655,
            Volume = 3
        },
        ["Flame Pillar"] = {
            SoundId = 17621517036,
            Volume = 2
        },
        ["Flame Pillar Voiceline"] = {
            SoundId = 17683894118,
            Volume = 2
        },
        ["Searing Devastation Voiceline"] = {
            SoundId = 17561812170,
            Volume = 3
        },
        ["Searing Devastation Slam Voiceline"] = {
            SoundId = 17561811677,
            Volume = 3
        },
        ["Searing Devastation Slam"] = {
            SoundId = 17561812016,
            Volume = 3
        },
        ["Searing Devastation SFX"] = {
            SoundId = 17561811858,
            Volume = 3
        },
        PoseMusic = {
            Looped = true,
            SoundId = 17683895415,
            Volume = 3
        },
        ["Pose Voiceline"] = {
            SoundId = 17685644021,
            Volume = 3
        },
        ["Pose SFX"] = {
            SoundId = 17683894517,
            Volume = 3
        },
        MeterUp3 = {
            SoundId = 17671541481,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 17671541204,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 17671541656,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 17671540872,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 17671540343,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 17671540604,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 17671615214,
            Volume = 2
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 17671615515,
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 17671614338,
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 17671614727,
            Volume = 2
        },
        ["Dragon\'s Fury"] = {
            SoundId = 17671615703,
            Volume = 2
        },
        ["Dragon\'s Fury Voiceline"] = {
            SoundId = 17683890215,
            Volume = 2
        },
        ["Dragon\'s Fury Fail 1"] = {
            SoundId = 17683893510,
            Volume = 2
        },
        ["Dragon\'s Fury Fail 2"] = {
            SoundId = 17683893827,
            Volume = 2
        },
        ["Inferno Beam Voiceline 1"] = {
            SoundId = 17683891238,
            Volume = 2
        },
        ["Inferno Beam Voiceline 2"] = {
            SoundId = 17683893168,
            Volume = 2
        },
        ["Inferno Beam Startup"] = {
            SoundId = 17684211112,
            Volume = 2
        },
        ["Inferno Beam Attacks"] = {
            SoundId = 17684210822,
            Volume = 2
        },
        ["Scorching Lunge Voiceline"] = {
            SoundId = 17683890784,
            Volume = 2
        },
        ["Scorching Lunge"] = {
            SoundId = 17684210491,
            Volume = 2
        },
        ["Fireball Voiceline 1"] = {
            SoundId = 17671655521,
            Volume = 2
        },
        ["Fireball Voiceline 2"] = {
            SoundId = 17671655207,
            Volume = 2
        },
        ["Fireball Startup"] = {
            SoundId = 17671614532,
            Volume = 2
        },
        ["Fireball Throw"] = {
            SoundId = 17671614960,
            Volume = 2
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://17553288876",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "ARGH.. ",
                            ScaleTime = 0.1
                        }, {
                            Quote = "HONOR! ",
                            ScaleTime = 0.2
                        }, {
                            Quote = "JUSTICE! ",
                            ScaleTime = 0.2
                        }, {
                            Quote = "REINHARDT.. REINHARDT.. REINHARDT!!!",
                            ScaleTime = 0.75
                        } },

                    Callback = function(p29) -- Line: 675, Name: Callback
                        -- upvalues: Sequence_V2 (copy), u2 (ref), ParticleHandler (copy)
                        local Metadata = p29.Metadata;
                        local _ = p29.Quote;
                        local Character = Metadata.Character;
                        local u30 = Metadata.Player or game.Players:GetPlayerFromCharacter(Character);
                        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
                        local u31 = Sequence_V2.new();

                        local function Clap() -- Line: 686
                            -- upvalues: u2 (ref), HumanoidRootPart (copy), u30 (copy)
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/Clap",
                                AutoSerialize = true,
                                Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.8),
                                Player = u30
                            });
                        end;

                        u31:SetValidate(function(p32) -- Line: 695
                            -- upvalues: Character (copy)
                            return Character.Parent ~= nil;
                        end);
                        u31:SetSpeed(1);
                        u31:AddFrame(190, Clap);
                        u31:AddFrame(213, Clap);
                        local ArmorMesh = Character:FindFirstChild("ArmorMesh", true);
                        u31:AddFrame(240, function() -- Line: 706
                            -- upvalues: ArmorMesh (copy), ParticleHandler (ref)
                            if not ArmorMesh then
                                return;
                            end;

                            ParticleHandler.EnableParticle(ArmorMesh.Cube.Emit, true);
                        end);
                        u31:AddFrame(290, function() -- Line: 711
                            -- upvalues: ArmorMesh (copy), ParticleHandler (ref)
                            if not ArmorMesh then
                                return;
                            end;

                            ParticleHandler.EnableParticle(ArmorMesh.Cube.Emit, false);
                        end);
                        u31:BindCallback("Ended", function() -- Line: 716
                            -- upvalues: u31 (copy)
                            u31:Destroy();
                        end);
                        u31:Play();
                    end
                },
                {
                    SoundId = "rbxassetid://17553281885",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*laughs*"
                        } }
                },
                {
                    SoundId = "rbxassetid://17553564492",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No guts, no glory!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17551722730",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*kneels*"
                        } }
                },
                {
                    SoundId = "rbxassetid://1",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "*begins dancing*"
                        } }
                },
                {
                    SoundId = "rbxassetid://17685642947",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Stand strong, we will not fall!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17685644323",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I have been called.. I must answer!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17685643415",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'ll protect you, friends!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17685643220",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Reinhardt, at your service!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17685643683",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Come here!"
                        } }
                },
                {
                    SoundId = "rbxassetid://17683888861",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Would you like to see my muscles?"
                        } }
                }
            }
        }
    }
};
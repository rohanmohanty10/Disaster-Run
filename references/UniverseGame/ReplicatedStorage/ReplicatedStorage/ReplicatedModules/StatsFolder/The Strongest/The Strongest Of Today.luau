  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local ParticleHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EffectService");
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local v9 = {
    Inherit = {
        AbilityName = "The Strongest"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p2) -- Line: 21, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v3 = TableUtil.Copy(p2.Stats, true);

                    if not p2.Character:GetAttribute("SixEyesMastery") then
                        if p2.Character:GetAttribute("SixEyes") then
                            v3.PoseMusic = "SixEyesPoseMusic";
                        end;

                        return v3;
                    end;

                    v3.PoseMusic = "SixEyesMasteryPoseMusic";
                    v3.StartAnim = "MasteryTransition";
                    v3.LoopAnim = "MasteryIdle";

                    return v3;
                end,

                PoseTransition = function(p4, p5) -- Line: 34, Name: PoseTransition
                    -- upvalues: AssetHandler (copy), u1 (copy), ParticleHandler (copy)
                    local _ = p4.Stats;
                    local _ = p4.Player;
                    local Character = p4.Character;
                    local _ = p4.RootPart;
                    local Trove = p5.Trove;

                    if Character:GetAttribute("SixEyesMastery") then
                        local v6 = AssetHandler.GetAsset("Particles/CursedEnergy/Arm", {
                            AbilityName = "The Vessel"
                        });
                        local _, _ = (Character:GetAttribute("MeterColor") or Color3.fromRGB(117, 184, 255)):ToHSV();

                        for _, v in { "Right Arm", "Left Arm" } do
                            local v7 = Character:FindFirstChild(v);

                            if v7 then
                                u1.FireAllClients({
                                    {
                                        Name = "Emit Particle V3",
                                        Data = {
                                            {
                                                Path = "Particles/CursedEnergy/Summon",
                                                AutoSerialize = true,
                                                AbilityName = "The Vessel",
                                                SkinName = nil,
                                                AttachTo = {
                                                    Part = v7
                                                }
                                            }
                                        }
                                    }
                                });
                                local v8 = Trove:Clone(v6);
                                v8.Parent = v7;
                                ParticleHandler.AttachTo(v8, {
                                    Part = v7
                                });
                                ParticleHandler.EnableAllParticles(v8, true);
                            end;
                        end;
                    end;
                end
            }
        }
    },
    Animations = {
        Idle = {
            Idle = 119315340839003
        },
        Action2 = {
            MasteryIdle = 83009915195071,
            MasteryTransition = 130504156976727
        }
    },
    Resources = {
        RushAttackSFX = {
            SoundId = "rbxassetid://121408236461496",
            Volume = 1.2
        },
        RushAttack2SFX = {
            SoundId = "rbxassetid://133713177244519",
            Volume = 1.2
        },
        RushAttack3SFX = {
            SoundId = "rbxassetid://101069135717402",
            Volume = 1.2
        },
        RushFinisherSFX = {
            SoundId = "rbxassetid://89715784214862",
            Volume = 1.2
        },
        FlashComboSFX = {
            SoundId = "rbxassetid://119837368431230",
            Volume = 1.2
        },
        FlashCombo2SFX = {
            SoundId = "rbxassetid://72413831691136",
            Volume = 1.2
        },
        FlashComboFinisherSFX = {
            SoundId = "rbxassetid://84914034396878",
            Volume = 1.2
        },
        TwofoldKickSFX1 = {
            SoundId = "rbxassetid://104134063055897",
            Volume = 1.2
        },
        TwofoldKickSFX2 = {
            SoundId = "rbxassetid://76499922627251",
            Volume = 1.2
        },
        GleamingStrikeHit = {
            SoundId = "rbxassetid://130419304880846",
            Volume = 1.2
        },
        LapseCollapseSFX = {
            SoundId = "rbxassetid://108698639441271",
            Volume = 1.2
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://112406991740963",
            Volume = 1.2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://112155217817611",
            Volume = 1.2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://73068366616294",
            Volume = 1.2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://79983038134769",
            Volume = 1.2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://137955259854886",
            Volume = 1.4
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://0",
            Volume = 1.4
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://115698117619642",
            Volume = 1.4
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://140097220261975",
            Volume = 1.4
        },
        FlashCombo = {
            SoundId = "rbxassetid://92803800437148",
            Volume = 1.2
        },
        FlashComboVoiceline = {
            SoundId = "rbxassetid://82256273213807",
            Volume = 1.4
        },
        LapseAttract = {
            SoundId = "rbxassetid://98066038037797",
            Volume = 1.2
        },
        LapseAttractVoiceline = {
            SoundId = "rbxassetid://76646548244694",
            Volume = 1.4
        },
        LapsePull = {
            SoundId = "rbxassetid://115199792279177",
            Volume = 1.2
        },
        LapsePulled = {
            SoundId = "rbxassetid://115697880405592",
            Volume = 1.2
        },
        ReversalPushShoot = {
            SoundId = "rbxassetid://112385913058775",
            Volume = 1.2
        },
        ReversalPushExplode = {
            SoundId = "rbxassetid://107535122841204",
            Volume = 1.2
        },
        ReversalPush = {
            SoundId = "rbxassetid://124284060726097",
            Volume = 1.2
        },
        RuthlessBarrageStartup = {
            SoundId = "rbxassetid://84283953155522",
            Volume = 1.2
        },
        RuthlessBarrage = {
            SoundId = "rbxassetid://125968330906282",
            Volume = 1.2
        },
        RuthlessBarrageStartupVoiceline = {
            SoundId = 15609023170,
            Volume = 1.4
        },
        RuthlessBarrageVoiceline = {
            SoundId = 15609023417,
            Volume = 1.4
        },
        LimitlessTechnique = {
            SoundId = "rbxassetid://122863961880105",
            Volume = 1.2
        },
        LimitlessTechniqueStartup = {
            SoundId = "rbxassetid://96564570711646",
            Volume = 1.2
        },
        ReversalRepel = {
            SoundId = "rbxassetid://71155496269059",
            Volume = 1.2
        },
        BeatdownStartup = {
            SoundId = 15105163795,
            Volume = 1.2
        },
        Beatdown = {
            SoundId = "rbxassetid://74643353962664",
            Volume = 1.2
        },
        BeatdownVoiceline = {
            SoundId = "rbxassetid://76270708607041",
            Volume = 1.4
        },
        InfinityHit = {
            SoundId = "rbxassetid://74841896232231",
            Volume = 1.2
        },
        InfinityStartup = {
            SoundId = "rbxassetid://80842446328239",
            Volume = 1.2
        },
        InfinityEnd = {
            SoundId = "rbxassetid://112613300034915",
            Volume = 1.2
        },
        InfinityVoiceline = {
            SoundId = "rbxassetid://134761472876929",
            Volume = 1.4
        },
        GleamingStrike = {
            SoundId = "rbxassetid://71446282833683",
            Volume = 1.2
        },
        GleamingStrikeVoiceline = {
            SoundId = 15169521100,
            Volume = 1.4
        },
        LapseCollapse = {
            SoundId = "rbxassetid://134278574827217",
            Volume = 1.2
        },
        LapseCollapseVoiceline = {
            SoundId = "rbxassetid://70675477475171",
            Volume = 1.4
        },
        LapseMaximum = {
            SoundId = "rbxassetid://97003082295797",
            Volume = 1.2
        },
        LapseMaximumLoop = {
            SoundId = "rbxassetid://126714371730889",
            Volume = 1.2
        },
        LapseMaximumEnd = {
            SoundId = "rbxassetid://94289492953807",
            Volume = 1.2
        },
        LapseMaximumVoiceline = {
            SoundId = "rbxassetid://101155250580011",
            Volume = 1.4
        },
        ReversalForce = {
            SoundId = "rbxassetid://132125016721080",
            Volume = 1.2
        },
        ReversalForceShoot = {
            SoundId = "rbxassetid://112385913058775",
            Volume = 1.2
        },
        ReversalForceExplode = {
            SoundId = 15169522606,
            Volume = 1.2
        },
        ReversalBlast = {
            SoundId = "rbxassetid://119761487459464",
            Volume = 1.2
        },
        ReversalBlastShoot = {
            SoundId = "rbxassetid://76421647487732",
            Volume = 1.2
        },
        ViceGrip = {
            SoundId = "rbxassetid://133537034403719",
            Volume = 1.2
        },
        ViceGripFinisher = {
            SoundId = "rbxassetid://80310963944501",
            Volume = 1.2
        },
        ViceGripFinisherVoiceline = {
            SoundId = "rbxassetid://134263861372449",
            Volume = 1.4
        },
        ViceGripStartupVoiceline = {
            SoundId = 15169523016,
            Volume = 1.4
        },
        HollowPurpleStartup = {
            SoundId = "rbxassetid://110826186785884",
            Volume = 1.2
        },
        HollowPurpleShoot = {
            SoundId = "rbxassetid://130557755199358",
            Volume = 1.2
        },
        HollowPurpleVoiceline = {
            SoundId = "rbxassetid://77485039245347",
            Volume = 1.4
        },
        TwofoldKick = {
            SoundId = "rbxassetid://100563206210789",
            Volume = 1.2
        },
        Teleport = {
            SoundId = "rbxassetid://90311585995968",
            Volume = 1.2
        },
        RedImpactStartup = {
            SoundId = "rbxassetid://136556887837058",
            Volume = 2
        },
        RedImpact = {
            SoundId = "rbxassetid://97161240540432",
            Volume = 1.2
        },
        RedImpactShoot = {
            SoundId = "rbxassetid://112385913058775",
            Volume = 1.2
        },
        UnlimitedHollow = {
            SoundId = "rbxassetid://81280460089893",
            Volume = 1.2
        },
        UnlimitedHollowVoiceline = {
            SoundId = "rbxassetid://96119058055047",
            Volume = 1.7
        },
        InstantStrike = {
            SoundId = "rbxassetid://90130294704051",
            Volume = 1.3
        },
        ThreefoldKickMastery = {
            SoundId = "rbxassetid://82930472814206",
            Volume = 1.3
        },
        MeterUp2 = {
            SoundId = "rbxassetid://75337508240707",
            Volume = 1.7
        },
        MeterUp4 = {
            SoundId = "rbxassetid://108998121200086",
            Volume = 2
        },
        DomainExpansionStartupVoiceline = {
            SoundId = "rbxassetid://100453400824742",
            Volume = 1.8
        },
        DomainExpansionStartup = {
            SoundId = "rbxassetid://140243434507641",
            Volume = 1.55
        },
        DomainExpansionAmbience = {
            SoundId = "rbxassetid://95346788481479",
            Volume = 1.7
        },
        BlindfoldOn = {
            SoundId = "rbxassetid://92562958617769",
            Volume = 1.3
        },
        BlindfoldOff = {
            SoundId = "rbxassetid://116746552718912",
            Volume = 1.3
        },
        PoseMusic = {
            SoundId = "rbxassetid://127020137610755",
            Looped = true,
            Volume = 1.3
        },
        SixEyesPoseMusic = {
            SoundId = 127894010875624,
            Volume = 1.1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.575
                }
            }
        },
        SixEyesMasteryPoseMusic = {
            SoundId = 120952124784673,
            Looped = true,
            Volume = 3,
            PlaybackSpeed = 0.53
        }
    },
    QuoteInfo = {}
};
v9.Stats["Rush Attack"] = {
    ["LMB-1"] = {
        HitSounds = { v9.Resources.RushAttackSFX }
    },
    ["LMB-2"] = {
        HitSounds = { v9.Resources.RushAttack2SFX }
    },
    ["LMB-3"] = {
        HitSounds = { v9.Resources.RushAttack3SFX }
    },
    ["LMB-4"] = {
        HitSounds = { v9.Resources.RushFinisherSFX }
    }
};
v9.Stats["Flash Combo"] = {
    Hook = {
        HitSounds = { v9.Resources.FlashComboSFX }
    },
    SweepKick = {
        HitSounds = { v9.Resources.FlashCombo2SFX }
    },
    Kick = {
        HitSounds = { v9.Resources.FlashComboSFX }
    },
    Jab1 = {
        HitSounds = { v9.Resources.FlashComboSFX }
    },
    Jab2 = {
        HitSounds = { v9.Resources.FlashCombo2SFX }
    },
    Jab3 = {
        HitSounds = { v9.Resources.FlashComboSFX }
    },
    FlyingKick = {
        HitSounds = { v9.Resources.FlashComboFinisherSFX }
    }
};
v9.Stats["Twofold Kick (Base)"] = {
    DoubleKick = {
        HitSounds = { v9.Resources.TwofoldKickSFX1 }
    },
    Kick = {
        HitSounds = { v9.Resources.TwofoldKickSFX2 }
    }
};
v9.Stats["Gleaming Strike (Base)"] = {
    Kick = {
        HitSounds = { v9.Resources.GleamingStrikeHit }
    }
};
v9.QuoteInfo = {
    Groups = {
        Universal = {
            Visible = true
        }
    },
    Quotes = {
        Universal = { {
                SoundId = "rbxassetid://119592890508634",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Y\'know what, I\'m pretty irritated right now."
                    } }
            }, {
                SoundId = "rbxassetid://119811930076505",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Who\'re you talking to? I don\'t even need to do that consciously. After all, I\'m the strongest!"
                    } }
            }, {
                SoundId = "rbxassetid://75675724625844",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Seems you got the wrong idea here, so let me just set things straight. You\'re the challenger here."
                    } }
            }, {
                SoundId = "rbxassetid://117315667854637",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Seriously, what a bad timing."
                    } }
            }, {
                SoundId = "rbxassetid://130748022265574",
                SoundVolume = 2,
                YieldSound = true,
                Visible = true,
                FullQuote = { {
                        Quote = "Nah, I\'d win."
                    } }
            } }
    }
};

return v9;
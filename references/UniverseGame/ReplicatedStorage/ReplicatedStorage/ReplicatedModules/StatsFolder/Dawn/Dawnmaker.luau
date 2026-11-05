  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 10
    -- upvalues: u1 (ref), Knit (copy), PathShortcuts (copy), u2 (ref)
    u1 = Knit.GetService("EffectService");
    u2 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v3 = {
    SoundId = 134457979539904,
    Volume = 3
};

local function GetMusic(p4) -- Line: 26
    return p4:GetAttribute("DawnEnchant") and 106182497043719 or 97525358199210;
end;

return {
    Inherit = {
        AbilityName = "Dawn"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                PoseTransition = function(p5) -- Line: 42, Name: PoseTransition
                    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
                    local _ = p5.Stats;
                    local _ = p5.Player;
                    local Character = p5.Character;
                    local HumanoidRootPart = Character.HumanoidRootPart;
                    local _ = p5.AbilityModel;

                    if p5._Ended then
                        return;
                    end;

                    if Character.Parent and Character:FindFirstChild("HumanoidRootPart") then
                        os.clock();
                        local u6 = { AssetHandler.CloneAsset("DawnMaker", {
                                AbilityName = "Dawn",
                                SkinName = p5.SkinName
                            }), AssetHandler.CloneAsset("DawnMakerAura", {
                                AbilityName = "Dawn",
                                SkinName = p5.SkinName
                            }) };

                        for _, v in u6 do
                            ParticleHandler.EnableAllParticles(v, false);
                        end;

                        u6[1].CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.4, 0);
                        u6[2].CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 3, 10);
                        local v7 = ParticleHandler.GetSkinInfo(p5.SkinName);
                        local v8 = type(v7) == "table" and (v7.Metadata or {}).HSVShift;

                        if v8 then
                            ParticleHandler.HSVShiftParticles(u6[1], v8);
                        end;

                        if p5.Metadata.UnusualHueShift then
                            ParticleHandler.HSVShiftParticles(u6[1], {
                                HueShift = p5.Metadata.UnusualHueShift
                            });
                        end;

                        for _, v in u6 do
                            v.Parent = workspace.Effects;
                            ParticleHandler.EnableAllParticles(v, true);
                        end;

                        p5.Trove:AttachToInstance(Character);
                        p5.Trove:Add(function() -- Line: 86
                            -- upvalues: u6 (copy), ParticleHandler (ref)
                            for _, v in u6 do
                                for _, descendant in v:GetDescendants() do
                                    if descendant:IsA("Beam") then
                                        descendant.Enabled = false;
                                    end;
                                end;

                                ParticleHandler.EnableParticle(v, false);
                                ParticleHandler.DestroyParticle(v);
                            end;
                        end);
                    end;
                end,

                PoseEnd = function(p9) -- Line: 99, Name: PoseEnd
                    local _ = p9.Stats;
                    local _ = p9.Player;
                    local _ = p9.Character;
                    local _ = p9.AbilityModel;
                    p9._Ended = true;
                end
            }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = v3
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 109350456015365,
                        Volume = 3
                    }
                }
            }
        },
        Sweep = {
            HitSounds = {
                Hit = v3
            }
        },
        ["Whirling Inferno"] = {
            HitSounds = {
                Hit = v3
            }
        },
        ["Flame Strikes"] = {
            ["Strike-1"] = {
                HitSounds = {
                    Hit = v3
                }
            },
            ["Strike-2"] = {
                HitSounds = {
                    Hit = v3
                }
            },
            ["Strike-3"] = {
                HitSounds = {
                    Hit = v3
                }
            }
        },
        ["Flames Blessing"] = {
            FlameHeal = {
                HitSounds = {
                    Hit = {
                        SoundId = 126909140206099,
                        Volume = 1
                    }
                }
            }
        }
    },
    Sounds = {
        RadianceStartup = {
            SoundId = 70665603559141,
            Volume = 2.5
        },
        Radiance = {
            SoundId = 97525358199210,
            Volume = 1,
            Looped = true
        },
        EnchantRadiance = {
            SoundId = 106182497043719,
            Volume = 1,
            Looped = true
        },
        Enchant = {
            SoundId = 84987579897090,
            Volume = 2.5
        },
        Phoenix = {
            SoundId = 116952060051844,
            Volume = 2.5
        },
        ["SwingLMB 1-4"] = {
            SoundId = 85649971139941,
            Volume = 2
        },
        FlameStrikes1 = {
            SoundId = 85649971139941,
            Volume = 2.5
        },
        FlameStrikes2 = {
            SoundId = 85649971139941,
            Volume = 2.5
        },
        FlameStrikes3 = {
            SoundId = 85649971139941,
            Volume = 2.5
        },
        PhoenixStartup = {
            SoundId = 83081046206209,
            Volume = 2.5
        },
        EnchantLoop = {
            SoundId = 110809919848927,
            Volume = 2.5
        },
        FlamesBlessing = {
            SoundId = 80882765397162,
            Volume = 3.5
        },
        ["LMB Slam"] = {
            SoundId = 113506820299109,
            Volume = 2.5
        },
        Sweep = {
            SoundId = 106291450422173,
            Volume = 2.5
        },
        GrandDescension = {
            SoundId = 83952946855128,
            Volume = 2.5
        },
        RadiancePose1 = {
            SoundId = 97525358199210,
            Volume = 4,
            Looped = true
        },
        RadiancePose2 = {
            SoundId = 106182497043719,
            Volume = 4,
            Looped = true
        }
    },
    Animations = {
        Action = {
            PoseStart = 82301714436795,
            PoseLoop = 96714861295061
        },
        Idle = {
            Idle = 100517545171295
        }
    }
};
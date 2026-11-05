  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage:FindFirstChild("ReplicatedModules"):FindFirstChild("Types"));
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local WeightManager = require(ReplicatedStorage.ReplicatedModules.WeightManager);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Middleware = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local Trove = require(Knit.Util.Trove);
Knit.OnStart():await();
local u1 = Knit.GetService("EffectService");
local _ = PathShortcuts.ClientAssets;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local u2;

if game:GetService("RunService"):IsServer() then
    local Killua = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Killua", true);
    u2 = require(Killua.Common);
    CombatService = Middleware.GetMiddleware("CombatService");
else
    u2 = nil;
end;

local v3 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 253, 220)),
    ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 253, 194)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 214, 142)),
    ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 214, 111)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 196, 93))
});
local v4 = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(207, 179, 123)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(214, 175, 121)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(218, 188, 117)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 172, 123))
});
local v5 = {
    TextStrokeTransparency = 0.65,
    UnusualRecolor = true,
    FontFace = Font.fromName("Jura", Enum.FontWeight.SemiBold),
    TextColor3 = Color3.fromRGB(255, 244, 160),
    TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
};
({
    Name = "Output"
}).Arguments = { "FX", "HitEffect V3", {
        Attacker = "__Attacker",
        Target = "__Target",
        Path = "Particles/Universal/LightHit",
        AutoSerialize = true,
        LookAt = "Attacker"
    } };

return {
    Inherit = {
        AbilityName = "Killua"
    },
    Animations = {
        Action = {
            PoseIdle = 126945479642831,
            PoseTransition = 91101864285535,
            RingOfDeath = 99548806268710,
            Godspeed = 115426081581980,
            ["Yo-Yo"] = 86869470473458
        },
        Movement = {},
        Idle = {
            GodspeedIdle = 132130198544716,
            Idle = 107619171257291
        }
    },
    Sounds = {
        ["LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://90970862180886",
            Volume = 1.4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://95225069206497",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://76158337488507",
            Volume = 1.4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://72833289409086",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://132169614673079",
            Volume = 1.4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://100824642840525",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://73302679448589",
            Volume = 1.4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://136404525141965",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://104487632152531",
            Volume = 3,
            PlaybackSpeed = 1.53846153846,
            Looped = true,
            TimePosition = 0
        },
        GodspeedLoop = {
            SoundId = "rbxassetid://98496937996291",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        GodspeedVL = {
            SoundId = "rbxassetid://125813086448535",
            Volume = 1.6,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GodspeedMovement = {
            SoundId = "rbxassetid://105405954505890",
            Volume = 2.1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Godspeed = {
            SoundId = "rbxassetid://100643645643029",
            Volume = 2.1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GodspeedTheme = {
            SoundId = "rbxassetid://137765754023476",
            Volume = 1.75,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinctVL = {
            SoundId = "rbxassetid://107865025096891",
            Volume = 1.6,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinct = {
            SoundId = "rbxassetid://114598331684598",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinctTheme = {
            SoundId = "rbxassetid://78902155874665",
            Volume = 1.85,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        KillersInstinctLoop = {
            SoundId = "rbxassetid://115760939859524",
            Volume = 0.75,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://72797293734649",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TheSnakeAwakensVL = {
            SoundId = "rbxassetid://0",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TheSnakeAwakens_Swoosh = {
            SoundId = "rbxassetid://98110462218719",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEyeVL = {
            SoundId = "rbxassetid://132617640612798",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverVL_Awakened = {
            SoundId = "rbxassetid://75808105593941",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverWindup = {
            SoundId = "rbxassetid://116812941357309",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOver = {
            SoundId = "rbxassetid://134959521379026",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverWindupVL = {
            SoundId = "rbxassetid://130454475150577",
            Volume = 1.8,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOverVL = {
            SoundId = "rbxassetid://0",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEyeWindup = {
            SoundId = "rbxassetid://116948023006278",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlinkOfAnEye = {
            SoundId = "rbxassetid://139892096262495",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ItsOver_Awakened = {
            SoundId = "rbxassetid://130072586740941",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderboltVL = {
            SoundId = "rbxassetid://73122998321573",
            Volume = 1.7,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderboltWindup = {
            SoundId = "rbxassetid://102978256035478",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thunderbolt = {
            SoundId = "rbxassetid://77795635260180",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderstrikeVL = {
            SoundId = "rbxassetid://98912547666924",
            Volume = 1.7,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThunderstrikeWindup = {
            SoundId = "rbxassetid://124760390109388",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thunderstrike = {
            SoundId = "rbxassetid://76597661924078",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalmVL = {
            SoundId = "rbxassetid://126787251318762",
            Volume = 1.6,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningPalm = {
            SoundId = "rbxassetid://78572401317234",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageVLStart = {
            SoundId = "rbxassetid://101534039156686",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageWindup = {
            SoundId = "rbxassetid://103993487352230",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRageVLEnd = {
            SoundId = "rbxassetid://71375401954962",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FitOfRage = {
            SoundId = "rbxassetid://123744747974514",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeathVL = {
            SoundId = "rbxassetid://134979063736404",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeath = {
            SoundId = "rbxassetid://139364985966789",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        RingOfDeathLoop = {
            SoundId = "rbxassetid://104223545889608",
            Volume = 1,
            PlaybackSpeed = 1.2,
            Looped = false,
            TimePosition = 0
        },
        LightningStormAttempt = {
            SoundId = "rbxassetid://123392107027682",
            Volume = 2.15,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        LightningStormAttemptVL = {
            SoundId = "rbxassetid://135832238403088",
            Volume = 1.8,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningStormVL = {
            SoundId = "rbxassetid://135492384928968",
            Volume = 2.15,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningStorm = {
            SoundId = "rbxassetid://77504647266418",
            Volume = 2.85,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningFlashVL = {
            SoundId = "rbxassetid://134680294282391",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LightningFlash = {
            SoundId = "rbxassetid://84479114813518",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        AbyssRunner = {
            SoundId = "rbxassetid://94496301831038",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Absorber = {
            SoundId = "rbxassetid://106163760382561",
            Volume = 0.7,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MeterUp2 = {
            SoundId = "rbxassetid://92743987573983",
            Volume = 3
        },
        MeterUp4 = {
            SoundId = "rbxassetid://95488071170639",
            Volume = 3
        }
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 102215628056763,
                        Volume = 1.7
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 102215628056763,
                        Volume = 1.7
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 102215628056763,
                        Volume = 1.7
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 84907216672535,
                        Volume = 2
                    }
                }
            }
        },
        Electrocute = {
            LightningColor = v4,
            Sound = {
                SoundId = 109237577769769,
                Volume = 0.5
            }
        },
        Thunderbolt_Ground = {
            LightningColor = v3
        },
        Thunderbolt_Airborne = {
            LightningColor = v3
        },
        FitOfRage = {
            LightningColor = v4,
            HighlightColor = {
                Fill = Color3.fromRGB(255, 196, 93),
                Outline = Color3.fromRGB(221, 185, 101)
            }
        },
        Godspeed = {
            LightningColor = v4
        },
        ["Speed Of Lightning"] = {
            LightningColor = v3
        },
        ["It\'s Over"] = {
            LightningColor = v3,
            HighlightColor = {
                Fill = Color3.fromRGB(255, 196, 93),
                Outline = Color3.fromRGB(221, 185, 101)
            }
        },
        ["Ring of Death"] = {
            LightningColor = v3
        },
        ["Lightning Flash"] = {
            LightningColor = v4
        },
        ["The Snake Awakens"] = {
            HitSounds = {
                Hit = {
                    SoundId = 91343852563858,
                    Volume = 0.4
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 108182022156603,
                        Volume = 2
                    }
                }
            }
        },
        ["Yo-Yo Barrage"] = {
            Hit = {
                HitSounds = {
                    Hit = {
                        SoundId = 76294630581220,
                        Volume = 0.6
                    }
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 123868926099045,
                        Volume = 2.35
                    }
                }
            },
            Hit2 = TableUtil.Reconcile({
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "HitEffect V3", {
                                Attacker = "__Attacker",
                                Target = "__Target",
                                Path = "Particles/Universal/ElectricHitVFX",
                                LookAt = "Attacker"
                            } }
                    } },
                HitSounds = {
                    Hit = {
                        SoundId = 77466614975951,
                        Volume = 0.8
                    }
                }
            }, BaseStatsModule.Stand_Barrage.Hit),
            Sequence = {
                { 0, function(p6, p7, p8) -- Line: 700
                        -- upvalues: ParticleHandler (copy), u1 (copy), AssetHandler (copy)
                        local Character = p8.Character;
                        local _ = p8.Trove;
                        local v9 = ParticleHandler.GetUnusualHSVData(p8);
                        local v10 = os.clock();
                        local u11 = p6:GetCache();
                        u11.DisableData = {};
                        u1.FireAllClients({
                            {
                                Name = "Enable Particles",
                                Data = {
                                    {
                                        Enabled = true,
                                        Parent = Character:FindFirstChild("Right Arm"),
                                        Offset = CFrame.new(0, 0, 0),
                                        ReferencePart = AssetHandler.GetAsset("Particles/Lightning Palm/PalmAura", p8),
                                        Id = v10,
                                        HSVShift = v9
                                    }
                                }
                            }
                        });
                        table.insert(u11.DisableData, {
                            Id = v10
                        });

                        function u11.RemoveAuraEffects() -- Line: 727
                            -- upvalues: u11 (copy), u1 (ref)
                            local v12 = {};

                            for i = 1, #u11.DisableData + (u11.DisableData2 and #u11.DisableData2 or 0) do
                                if u11.DisableData and u11.DisableData[i] then
                                    table.insert(v12, {
                                        Name = "Enable Particles",
                                        Data = { u11.DisableData[i] }
                                    });
                                end;

                                if u11.DisableData2 and u11.DisableData2[i] then
                                    table.insert(v12, {
                                        Name = "Enable Particles",
                                        Data = { u11.DisableData2[i] }
                                    });
                                end;
                            end;

                            u1.FireAllClients(v12);
                        end;

                        p6:BindCallback("Ended", u11.RemoveAuraEffects);
                    end },
                { 0, "Barrage", true },
                { 0, "PlaySound", "Barrage", {
                        Cancelable = true
                    } },
                { 1, function(p13) -- Line: 749
                    end },
                { 15, "Cancelable", true },
                { 15, "CreateTag", "MaxWalkSpeed", 8 },
                { 27, function(p14, p15, u16) -- Line: 755
                        -- upvalues: Knit (copy), u1 (copy), AssetHandler (copy), u2 (ref)
                        local Character = u16.Character;
                        local Trove2 = u16.Trove;
                        Knit.CollectionService:AddTag(Character, "Barraging");
                        u1.FireAllClients("Powerplex_Barrage", Character, {
                            Offset = CFrame.new(0.025, 0, -1.5)
                        });
                        local u17 = os.clock();
                        u1.FireAllClients("Enable Particles", {
                            Scale = 0.8,
                            Enabled = true,
                            Parent = u16.RootPart,
                            Offset = CFrame.new(0, -0.5, 1.5),
                            ReferencePart = AssetHandler.GetAsset("Particles/Barrage/Barrage", u16),
                            Id = u17
                        });
                        p14:AddFrame(70, function() -- Line: 774
                            -- upvalues: u1 (ref), u17 (copy)
                            u1.FireAllClients("Enable Particles", {
                                Id = u17
                            });
                        end);
                        Trove2:Add(function() -- Line: 780
                            -- upvalues: u1 (ref), u17 (copy), Knit (ref), Character (copy)
                            u1.FireAllClients("Enable Particles", {
                                Id = u17
                            });
                            Knit.CollectionService:RemoveTag(Character, "Barraging");
                        end);

                        if u2 and u2.ToggleAbsorbers then
                            u2.ToggleAbsorbers(u16, 0, (90 - p15) / 60 / p14:GetSpeed());
                            Trove2:Add(function() -- Line: 790
                                -- upvalues: u2 (ref), u16 (copy)
                                u2.ToggleAbsorbers(u16, 1, 0.3);
                            end);
                        end;
                    end },
                { 29, "Clashable", true },
                { 29, 70, "BarrageAttack", "Hit" },
                { 71, 138, "BarrageAttack", "Hit2" },
                { 70, function(p18, p19, p20) -- Line: 801
                        -- upvalues: ParticleHandler (copy), u1 (copy), AssetHandler (copy), Knit (copy)
                        local Character = p20.Character;
                        local _ = p20.Trove;
                        local v21 = ParticleHandler.GetUnusualHSVData(p20);
                        local v22 = p18:GetCache();
                        v22.DisableData2 = {};

                        if v22.DisableData2 then
                            local v23 = os.clock();
                            u1.FireAllClients({
                                {
                                    Name = "Enable Particles",
                                    Data = {
                                        {
                                            Enabled = true,
                                            Parent = Character:FindFirstChild("Left Arm"),
                                            Offset = CFrame.new(0, 0, 0),
                                            ReferencePart = AssetHandler.GetAsset("Particles/Lightning Palm/PalmAura", p20),
                                            Id = v23,
                                            HSVShift = v21
                                        }
                                    }
                                },
                                {
                                    Name = "Enable Particles",
                                    Data = {
                                        {
                                            Enabled = true,
                                            Parent = p20.RootPart,
                                            Offset = CFrame.new(0, 0, 4.7),
                                            ReferencePart = AssetHandler.GetAsset("Particles/Barrage/BarrageLightning", p20),
                                            Id = v23 + 3.3,
                                            HSVShift = v21
                                        }
                                    }
                                }
                            });
                            table.insert(v22.DisableData2, {
                                Id = v23
                            });
                            table.insert(v22.DisableData2, {
                                Unlock = true,
                                Id = v23 + 3.3
                            });
                        end;

                        Knit.CollectionService:RemoveTag(Character, "Barraging");
                    end },
                { 132, function(p24, p25, p26) -- Line: 848
                        -- upvalues: ParticleHandler (copy), u2 (ref)
                        local _ = p26.Character;
                        local _ = p26.Trove;
                        ParticleHandler.GetUnusualHSVData(p26);
                        local v27 = p24:GetCache();

                        if u2 and u2.ToggleAbsorbers then
                            u2.ToggleAbsorbers(p26, 1, 0.3);
                        end;

                        if v27.RemoveAuraEffects then
                            v27.RemoveAuraEffects();
                        end;
                    end },
                { 148, "Cancelable", false },
                { 148, "Clashable", false },
                { 148, "BarrageAttack", "Finisher" },
                { 163, function(p28) -- Line: 867
                    end },
                { 180, "End" }
            }
        },
        Pose = {
            LightningColor = v4,
            Callbacks = {
                PoseTransition = function(p29) -- Line: 876, Name: PoseTransition
                    -- upvalues: AssetHandler (copy), u2 (ref), ParticleHandler (copy), u1 (copy)
                    local _ = p29.Stats;
                    local Player = p29.Player;
                    local Character = p29.Character;
                    local _ = p29.AbilityModel;

                    if Player and Player:FindFirstChild("Data") then
                        local Skin = Player:FindFirstChild("Data"):FindFirstChild("Skin");

                        if Skin and Skin:GetAttribute("TempUnusual") then
                            Skin:SetAttribute("UnusualHueId", nil);
                        end;
                    end;

                    if not Character:GetAttribute("Godspeed") then
                        local v30 = AssetHandler.GetAsset("Particles/Godspeed/Aura", p29);
                        p29._Aura = u2.GodspeedFX(Character, true, v30, p29);
                        local v31 = ParticleHandler.GetUnusualHSVData(p29);
                        local v32 = os.clock();
                        p29._DisableData = {};
                        CombatService.PlaySound(Character, "Godspeed");
                        CombatService.PlaySound(Character, "GodspeedLoop");
                        u1.FireClient(Player, "CameraShake", "ViolentShake");
                        u1.FireClient(Player, "TemporalEffect", Color3.fromRGB(61, 220, 255), Color3.fromRGB(250, 255, 138), 0.25);
                        u1.FireAllClients({
                            {
                                Name = "Enable Particles",
                                Data = {
                                    {
                                        Enabled = true,
                                        Parent = Character:FindFirstChild("Head"),
                                        Offset = CFrame.new(0, 0, 0),
                                        ReferencePart = AssetHandler.GetAsset("Particles/Godspeed/EyeAura", p29),
                                        Id = v32,
                                        HSVShift = v31
                                    }
                                }
                            },
                            {
                                Name = "Emit Particle V3",
                                Data = {
                                    {
                                        Path = "Particles/Godspeed/GodspeedActivation",
                                        AutoSerialize = true,
                                        AttachTo = {
                                            Part = p29.RootPart
                                        },
                                        Player = Player,
                                        AbilityName = p29.AbilityName,
                                        SkinName = p29.SkinName
                                    }
                                }
                            }
                        });
                        table.insert(p29._DisableData, {
                            Id = v32
                        });
                    end;
                end,

                PoseEnd = function(p33) -- Line: 936, Name: PoseEnd
                    -- upvalues: u2 (ref), u1 (copy)
                    local _ = p33.Stats;
                    local Player = p33.Player;
                    local Character = p33.Character;
                    local _ = p33.AbilityModel;

                    if Player and Player:FindFirstChild("Data") then
                        local Skin = Player:FindFirstChild("Data"):FindFirstChild("Skin");

                        if Skin and (Skin:GetAttribute("TempUnusual") and Character:GetAttribute("KillersInstinct")) then
                            Skin:SetAttribute("UnusualHueId", 23);
                        end;
                    end;

                    if not Character:GetAttribute("Godspeed") and p33._Aura then
                        u2.GodspeedFX(Character, false, p33._Aura, p33);
                        CombatService.SoftStopSound(Character, "GodspeedLoop");

                        if p33._DisableData then
                            for i = 1, #p33._DisableData do
                                u1.FireAllClients({
                                    {
                                        Name = "Enable Particles",
                                        Data = { p33._DisableData[i] }
                                    }
                                });
                            end;

                            table.clear(p33._DisableData);
                        end;
                    end;
                end
            }
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
                    SoundId = "rbxassetid://88143541722038",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.065,
                            EndLag = 0.95,
                            Quote = "HE CANT KEEP GETTING AWAY WITH THIS!! "
                        }, {
                            Timing = 0.06,
                            EndLag = 0.9,
                            Quote = "HE CANT KEEP GETTING AWAY WITH IT! "
                        }, {
                            Timing = 0.05,
                            EndLag = 0.9,
                            Quote = ""
                        } }
                },
                {
                    SoundId = "rbxassetid://139108652560364",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.05,
                            EndLag = 2,
                            Quote = "You\'re not listening! "
                        }, {
                            Timing = 0.05,
                            EndLag = 2,
                            Quote = "This isn\'t about me! "
                        }, {
                            Timing = 0.05,
                            EndLag = 0.7,
                            Quote = "This is about the thousands of people Invincible MURDERED! "
                        }, {
                            Timing = 0.0515,
                            EndLag = 1,
                            Quote = "And the countless other lives Invincible DESTROYED! "
                        }, {
                            Timing = 0.05,
                            EndLag = 0.4,
                            Quote = "WHY "
                        }, {
                            Timing = 0.05,
                            EndLag = 2.5,
                            Quote = "is Invincible above the law?! "
                        }, {
                            Timing = 0.06,
                            EndLag = 0.35,
                            Quote = "WHY does Invincible never pay "
                        }, {
                            Timing = 0.06,
                            EndLag = 2.15,
                            Quote = "for his crimes?! "
                        }, {
                            Timing = 0.06,
                            EndLag = 0.2,
                            Quote = "WHERE is Invincible when people are trying to put their world "
                        }, {
                            Timing = 0.05,
                            EndLag = 0.4,
                            Quote = "BACK "
                        }, {
                            Timing = 0.05,
                            EndLag = 1,
                            Quote = "TOGETHER!"
                        } },

                    ClientCallback = function(u34, p35) -- Line: 1071, Name: ClientCallback
                        -- upvalues: Trove (copy), Sequence_V3 (copy), EffectsHandler (copy)
                        local LocalPlayer = game:GetService("Players").LocalPlayer;

                        if game:GetService("Players"):GetPlayerFromCharacter(u34) ~= LocalPlayer then
                            local Settings = LocalPlayer:FindFirstChild("Settings");

                            if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
                                return;
                            end;
                        end;

                        local v36 = Trove.new();
                        v36:AttachToInstance(u34);
                        local u47 = Sequence_V3.new({
                            Name = "Powerplex_Quote1",
                            Frames = {
                                { 471.6, function(p37, p38) -- Line: 1092
                                        -- upvalues: EffectsHandler (ref), u34 (copy)
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u34, nil, 0.6, 1);
                                    end },
                                { 654, function(p39, p40) -- Line: 1095
                                        -- upvalues: EffectsHandler (ref), u34 (copy)
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u34, nil, 0.6, 1);
                                    end },
                                { 864, function(p41, p42) -- Line: 1098
                                        -- upvalues: EffectsHandler (ref), u34 (copy)
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u34, nil, 0.6, 1);
                                    end },
                                { 1119, function(p43, p44) -- Line: 1101
                                        -- upvalues: EffectsHandler (ref), u34 (copy)
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u34, nil, 0.6, 1);
                                    end },
                                { 1452, function(p45, p46) -- Line: 1104
                                        -- upvalues: EffectsHandler (ref), u34 (copy)
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u34, nil, 0.6, 1);
                                    end }
                            }
                        });
                        v36:Add(u47);
                        u47:Play();
                        u47.Failed:Connect(function() -- Line: 1114
                            warn("Failed");
                        end);
                        u47.Completed:Once(function() -- Line: 1118
                            -- upvalues: u47 (copy)
                            u47:Destroy();
                        end);
                    end
                },
                {
                    SoundId = "rbxassetid://139290438422451",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    IgnoreMovementCheck = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.055,
                            EndLag = 1.1,
                            Quote = "What do I want..?  "
                        }, {
                            Timing = 0.05,
                            EndLag = 1.8,
                            Quote = "I wa- ... "
                        }, {
                            Timing = 0.05,
                            EndLag = 1.8,
                            Quote = "I want the TRUTH! "
                        }, {
                            Timing = 0.065,
                            EndLag = 2,
                            Quote = "I want JUSTICE! "
                        }, {
                            Timing = 0.175,
                            EndLag = 0.15,
                            Quote = "I. "
                        }, {
                            Timing = 0.1,
                            EndLag = 0.2,
                            Quote = "WANT. "
                        }, {
                            Timing = 0.08,
                            EndLag = 2,
                            Quote = "INVINCIBLE!"
                        }, {
                            Timing = 0.1,
                            EndLag = 1,
                            Quote = ""
                        } },

                    Callback = function(p48) -- Line: 1185, Name: Callback
                        if not (p48.Metadata or p48.Metadata.Character) then
                            return;
                        end;

                        local v49 = math.random(1, 536870912);
                        p48.Metadata.Character:SetAttribute("PowerplexQuoteSeed", v49);
                    end,

                    ClientCallback = function(u50, p51) -- Line: 1192, Name: ClientCallback
                        -- upvalues: Trove (copy), Sequence_V3 (copy), WeightManager (copy), EffectsHandler (copy)
                        local LocalPlayer = game:GetService("Players").LocalPlayer;

                        if game:GetService("Players"):GetPlayerFromCharacter(u50) ~= LocalPlayer then
                            local Settings = LocalPlayer:FindFirstChild("Settings");

                            if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
                                return;
                            end;
                        end;

                        local v52 = Trove.new();
                        v52:AttachToInstance(u50);
                        local u57 = Sequence_V3.new({
                            Name = "Powerplex_Quote2",
                            Frames = {
                                { 681, function(p53, p54) -- Line: 1212
                                        -- upvalues: u50 (copy), WeightManager (ref), EffectsHandler (ref)
                                        local v55 = Random.new(u50:GetAttribute("PowerplexQuoteSeed"));
                                        local v56 = WeightManager.GetRandomItemFromTable({
                                            Powerplex = 45,
                                            InvincibleWar = 20,
                                            Conquest = 30,
                                            Invincible = 30
                                        }, v55) or "Powerplex";
                                        EffectsHandler.CallEffect("Powerplex_TitleCard", u50, v56, 1, 1);
                                    end }
                            }
                        });
                        v52:Add(u57);
                        u57:Play();
                        u57.Failed:Connect(function() -- Line: 1233
                            warn("Failed");
                        end);
                        u57.Completed:Once(function() -- Line: 1237
                            -- upvalues: u57 (copy)
                            u57:Destroy();
                        end);
                    end
                },
                {
                    SoundId = "rbxassetid://101349118841175",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.06,
                            EndLag = 0.7,
                            Quote = "Come... "
                        }, {
                            Timing = 0.06,
                            EndLag = 0.7,
                            Quote = "and face... "
                        }, {
                            Timing = 0.085,
                            EndLag = 0.6,
                            Quote = "POWERPLEX! "
                        } }
                },
                {
                    SoundId = "rbxassetid://128361540226068",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.06,
                            EndLag = 0.7,
                            Quote = "Come and face.. "
                        }, {
                            Timing = 0.06,
                            EndLag = 0.85,
                            Quote = "justice! "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.9,
                            Quote = "For the lives you\'ve taken! "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.6,
                            Quote = ""
                        } }
                },
                {
                    SoundId = "rbxassetid://104340033110952",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = v5,
                    FullQuote = { {
                            Timing = 0.06,
                            EndLag = 0.75,
                            Quote = "NO! "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.85,
                            Quote = "I am not going anywhere... "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.6,
                            Quote = "until I... "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.485,
                            Quote = "get... "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.9,
                            Quote = "justice! "
                        }, {
                            Timing = 0.055,
                            EndLag = 0.6,
                            Quote = ""
                        } }
                }
            }
        }
    }
};
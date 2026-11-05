  

 

game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ClientModulesPath.TweenModule);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.StatsFolder["Jonathan Hamon"]["Jonathan Hamon"].EnableBirthmark);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5;

if game:GetService("RunService"):IsServer() then
    local v6 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Crazy Diamond", true);
    u5 = require(v6.Common);
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u5 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 35
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
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
    ["Blood Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Blood",
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
    Heal = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heal",
                AutoSerialize = true
            } }
    }
};

return {
    Inherit = {
        AbilityName = "Crazy Diamond"
    },
    Stats = {
        Summon = {
            SummonV2 = true,
            VoicelineRange = 2
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            Actionable = {
                Summoned = false
            },
            AnimationTimed = false,
            MaxCombo = 4,
            ComboTick = 1.5,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.44,
                Endlag = 0.35,
                ActiveEndlag = 0.308,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p8, p9, p10) -- Line: 118
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p10.Character, true);
                        end },
                    { 15, function(p11, p12, p13) -- Line: 122
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p13, BaseStatsModule.Rush_Attack);
                        end },
                    { 15, 18, "Attack" },
                    { 35, function(p14, p15, p16) -- Line: 128
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p16.Character, false);
                        end },
                    { 35, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17487793700,
                        Volume = 2
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.44,
                Endlag = 0.35,
                ActiveEndlag = 0.308,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p17, p18, p19) -- Line: 159
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p19.Character, true);
                        end },
                    { 12, function(p20, p21, p22) -- Line: 163
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p22, BaseStatsModule.Rush_Attack);
                        end },
                    { 12, 15, "Attack" },
                    { 22, function(p23, p24, p25) -- Line: 169
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p25.Character, false);
                        end },
                    { 22, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.44,
                Endlag = 0.35,
                ActiveEndlag = 0.308,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p26, p27, p28) -- Line: 187
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p28.Character, true);
                        end },
                    { 16, function(p29, p30, p31) -- Line: 191
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p31, BaseStatsModule.Rush_Attack);
                        end },
                    { 16, 19, "Attack" },
                    { 23, function(p32, p33, p34) -- Line: 197
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p34.Character, false);
                        end },
                    { 23, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.44,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 4" },
                    { 17, function(p35, p36, p37) -- Line: 214
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p37, BaseStatsModule.Rush_Attack_Finisher);
                        end },
                    { 17, 20, "Attack" },
                    { 36, "End" }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            ["StandOff-LMB-1"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.308,
                Speed = 1.41,
                HitAnimations = "Default",
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p38, p39, p40) -- Line: 229
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p40.Character, true);
                        end },
                    { 15, function(p41, p42, p43) -- Line: 233
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p43, BaseStatsModule.Rush_Attack);
                        end },
                    { 15, 18, "Attack" },
                    { 35, function(p44, p45, p46) -- Line: 239
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p46.Character, false);
                        end },
                    { 35, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17487793700,
                        Volume = 2
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["StandOff-LMB-2"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.308,
                Speed = 1.41,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p47, p48, p49) -- Line: 268
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p49.Character, true);
                        end },
                    { 12, function(p50, p51, p52) -- Line: 272
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p52, BaseStatsModule.Rush_Attack);
                        end },
                    { 12, 15, "Attack" },
                    { 22, function(p53, p54, p55) -- Line: 278
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p55.Character, false);
                        end },
                    { 22, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["StandOff-LMB-3"] = TableUtil.Reconcile({
                Endlag = 0.2,
                ActiveEndlag = 0.308,
                Speed = 1.41,
                Sequence = {
                    { 0, "Start" },
                    { 0, "PlaySound", "SwingLMB 1-3" },
                    { 0, function(p56, p57, p58) -- Line: 295
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p58.Character, true);
                        end },
                    { 16, function(p59, p60, p61) -- Line: 299
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p61, BaseStatsModule.Rush_Attack);
                        end },
                    { 16, 19, "Attack" },
                    { 23, function(p62, p63, p64) -- Line: 305
                            -- upvalues: u5 (ref)
                            u5:MaterializeGuitar(p64.Character, false);
                        end },
                    { 23, "End" }
                }
            }, BaseStatsModule.Rush_Attack),
            ["StandOff-LMB-4"] = TableUtil.Reconcile({
                Speed = 2.115,
                ActiveEndlag = 0.508,
                Cooldown = 1,
                HitAnimations = "Default",
                Sequence = {
                    { 0, "Start" },
                    { 36, function(p65, p66, p67) -- Line: 321
                            -- upvalues: u5 (ref), BaseStatsModule (copy)
                            u5:TryRestoration(p67, BaseStatsModule.Rush_Attack_Finisher);
                        end },
                    { 36, 42, "Attack" },
                    { 48, "End" }
                },
                HitRemotes = { v7["Heavy Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17487793820,
                        Volume = 2
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                StateChecker = function(p68, p69) -- Line: 347, Name: StateChecker
                    -- upvalues: Knit (copy), TableUtil (copy)
                    local Stats = p68.Stats;

                    if not Knit.CollectionService:HasTag(p68.Character, "Summoned") then
                        Stats = TableUtil.Copy(Stats, true);
                        Stats.CustomPrefix = "StandOff-LMB";
                    end;

                    return Stats;
                end
            }
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 135320046745798,
            Volume = 2
        },
        ["Summon-Voiceline-1"] = {
            SoundId = 85977811836380,
            Volume = 2
        },
        ["Summon-Voiceline-2"] = {
            SoundId = 76903094393482,
            Volume = 2
        },
        ["Desummon-SFX"] = {
            SoundId = 99809774352156,
            Volume = 2
        },
        ["Rampage Music"] = {
            SoundId = 118549571092038,
            Volume = 2
        },
        ["Rampage Ambience"] = {
            SoundId = 118549571092038,
            Volume = 1,
            Looped = true
        },
        ["Rampage SFX"] = {
            SoundId = 87476448357284,
            Volume = 2
        },
        ["Rampage Voiceline"] = {
            SoundId = 135284494947593,
            Volume = 2
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 73402382456824,
            ["LMB-2"] = 102711930084625,
            ["LMB-3"] = 110187494336779,
            ["LMB-4"] = 107154093534929,
            ["StandOff-LMB-1"] = 73402382456824,
            ["StandOff-LMB-2"] = 102711930084625,
            ["StandOff-LMB-3"] = 110187494336779,
            ["StandOff-LMB-4"] = 11371983463,
            ["Duplex Combination"] = 118808612959248,
            Rampage = 76602246176717
        },
        Idle = {
            SummonedIdle = 90773175473404,
            RampageSummonedIdle = 17497579168,
            Idle = 90773175473404,
            RampageIdle = 17497579168
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
                    SoundId = "rbxassetid://13481333429",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "N-N-Not happening!"
                        } }
                },
                {
                    SoundId = "rbxassetid://13481333649",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "Are ya winning, diners?"
                        } }
                },
                {
                    SoundId = "rbxassetid://13481333810",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "Y-YEAHHHHHHHHHHH... W-W-WELCOOOOOOMEE!!!"
                        } }
                },
                {
                    SoundId = "rbxassetid://13481333507",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "And thus, Hitori Gotoh turned to dust, and never picked up a guitar again."
                        } }
                },
                {
                    SoundId = "rbxassetid://13481333344",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "Tropical Love Forever."
                        } }
                },
                {
                    SoundId = "rbxassetid://13481333271",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.IndieFlower,
                        TextColor3 = Color3.fromRGB(255, 170, 255)
                    },
                    FullQuote = { {
                            Quote = "It\'s over."
                        } }
                }
            }
        }
    },
    Metadata = {
        PostRig = function(p70) -- Line: 547, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Player = p70.Player;
            local Character = p70.Character;
            local _ = p70.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local v71 = Character:FindFirstChild("Left Arm");
            local v72 = AssetHandler.CloneAsset("Models/Guitar", {
                AbilityName = "Crazy Diamond",
                SkinName = "Bocchi"
            });
            local Handle = v72.Handle;

            if Handle then
                v72.Parent = Character;
                local Motor6D = Instance.new("Motor6D");
                Motor6D.Name = "GuitarWeld";
                Motor6D.Part0 = v71;
                Motor6D.Part1 = Handle;
                Motor6D.C0 = CFrame.new(0, -0.7, -0.4) * CFrame.Angles(0, 1.5707963267948966, 0.5235987755982988);
                Motor6D.Parent = v71;
            end;
        end
    }
};
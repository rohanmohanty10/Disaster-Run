  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = nil;
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local u2 = nil;
local u3 = nil;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u4 = Random.new();
local u5 = nil;
local u6 = nil;
local u7 = nil;
Knit.OnStart():andThen(function() -- Line: 27
    -- upvalues: RunService (copy), u2 (ref), u3 (ref), u1 (ref), u5 (ref), PathShortcuts (copy), u6 (ref), u7 (ref), Knit (copy)
    if RunService:IsServer() then
        u2 = game:GetService("ServerScriptService");
        u3 = game:GetService("ServerStorage");
        u1 = require(u2.ServerLibrary.PathShortcuts);
        u5 = require(u1.ServerLibrary:FindFirstChild("Umbra", true).MAYHEM);
        u6 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
        u7 = Knit.GetService("EffectService");
    end;
end);
local Common = require(script.Common);
local Sounds = require(script.Sounds);
local Quotes = require(script.Quotes);

local function QuoteCallback(u8, p9) -- Line: 46
    -- upvalues: Players (copy), ParticleHandler (copy), EffectsHandler (copy)
    local v10 = u8:GetAttribute("GlitcherForm");
    local u11 = Players:GetPlayerFromCharacter(u8);
    local u12 = p9.FullQuote[1];

    if v10 and v10 ~= "None" then
        return;
    end;

    local LocalPlayer = Players.LocalPlayer;

    if Players:GetPlayerFromCharacter(u8) ~= LocalPlayer then
        local Settings = LocalPlayer:FindFirstChild("Settings");

        if Settings and (Settings:FindFirstChild("QuoteScreenEffects") and not Settings:FindFirstChild("QuoteScreenEffects").Value) then
            return;
        end;
    end;

    local v13 = ParticleHandler.GetUnusualHSVData({
        UseSkinData = false,
        Player = u11,
        Character = u8
    });
    local u14 = v13 and ParticleHandler.HSVShift(Color3.new(1, 0, 0), v13) or Color3.new(1, 0, 0);
    local v15, v16, v17 = u14:ToHSV();
    local u18 = Color3.fromHSV(v15, v16, v17 - 0.5);
    task.spawn(function() -- Line: 74
        -- upvalues: EffectsHandler (ref), u8 (copy), u11 (copy), u12 (copy), u14 (copy), u18 (copy)
        EffectsHandler.CallEffect("Q_RADIAL", {
            Origin = u8.HumanoidRootPart.CFrame,
            Distance = u8:GetAttribute("InCombat") and 20 or 55,
            Effect = {
                {
                    Effect = "Glitcher Message",
                    Arguments = {
                        {
                            TextAppear = true,
                            Speaker = u11.Name,
                            Message = u12.Quote,
                            TextColor = u14,
                            StrokeColor = u18,
                            Time = u12.ScaleTime + 0.15,
                            AppearWait = u12.ScaleTime / 50
                        }
                    }
                }
            }
        });
    end);
end;

if not Quotes.Mayhem[1].TextStyle then
    for i, v in Quotes do
        local v19 = Common.FormData[i];

        for _, v2 in v do
            if v19 then
                v2.TextStyle = {
                    TextStrokeTransparency = 0,
                    Font = v19.Font,
                    TextColor3 = v19.PrimaryColor,
                    TextStrokeColor3 = v19.SecondaryColor
                };
            end;

            v2.ClientCallback = QuoteCallback;
        end;
    end;
end;

return {
    Inherit = {
        AbilityName = "Umbra"
    },
    Animations = {
        Action = {
            Grab = 79270925019287,
            ["Grab Victim"] = 89561390156472,
            ["Grab Camera"] = 84424295629410,
            Whirlwind = 127987093956453,
            ["Swallowing Void Pull"] = 73672891114751,
            ["Swallowing Void Swords"] = 116481472401835,
            ["Sword Impale Startup"] = 96791971175724,
            ["Sword Impale Loop"] = 77734066885983,
            ["Sword Impale End"] = 99908504645699,
            ["Empty Mist Startup"] = 88684722100948,
            ["Empty Mist Barrage"] = 78532402957237,
            ["Empty Mist Finisher"] = 82545522658059,
            ["Piercing Void Finisher"] = 17877392935,
            ["Clear Clouds Startup"] = 81360828662080,
            ["Clear Clouds Loop"] = 130464400476195,
            ["Clear Clouds Finisher"] = 140706110528060,
            ["Ult Startup"] = 74570339000995,
            Ult = 73324661767981,
            ["Ult Victim"] = 75948238772146,
            ["Ult Camera"] = 106944526099200,
            Sovereign = 85824525162088,
            ["Sovereign Camera"] = 92229513648474,
            ["Mayhem Sovereign"] = 132926276518441,
            ["Mayhem Sovereign Camera"] = 140215485515747,
            ["Chaos Sovereign"] = 97660996161533,
            ["Chaos Sovereign Camera"] = 126006473181416,
            ["Rainbow Sovereign"] = 92458055377436,
            ["Rainbow Sovereign Camera"] = 79861341517044,
            ["Catastrophe Sovereign"] = 89869188791329,
            ["Catastrophe Sovereign Camera"] = 122745887324466,
            ["MayhemLMB-1"] = 71230349297446,
            ["MayhemLMB-2"] = 111069060567421,
            ["MayhemLMB-3"] = 74384911079115,
            ["MayhemLMB-4"] = 136485288379990,
            ["Neptunian Equip"] = 80663150465147,
            ["Base Pose"] = 109401226095050,
            ["Base Pose Wings"] = 117591114807456,
            ["Mayhem Pose"] = 135087545851350,
            ["Purity Pose"] = 107017594140184,
            ["Corruption Pose"] = 133837768408004,
            ["Equinox Pose"] = 89453175113147,
            ["Divinity Pose"] = 93222426571840,
            ["Destiny Pose"] = 110264482555313,
            ["Rainbow Pose"] = 75982409573240,
            ["Omega Pose"] = 82841521856825,
            ["Pandora Pose"] = 119732566185982,
            ["Chaos Pose"] = 74911353062027,
            ["SHD Pose"] = 100902400942089,
            ["Crazed Pose"] = 98881437030620,
            ["FallenX Pose"] = 73396100539359,
            ["Calamity Pose"] = 131683661285617,
            ["Catastrophe Pose"] = 103980312348481,
            ["Boing Pose"] = 77308039012896,
            ["Love Pose"] = 83263306700013,
            ["Neptunian Pose"] = 91708544454581,
            ["Violence Pose"] = 94185126971500
        },
        Movement = {
            ["Neptunian Walk"] = 13170934020,
            ["Neptunian Run"] = 10914799131,
            ["Neptunian Run Equipped"] = 10421345302,
            ["Neptunian Walk Equipped"] = 10421341888,
            ["Chaos Walk"] = 138274973564443,
            ["Boing Walk"] = 93420288615379,
            ["Boing Run"] = 138039753472101,
            ["Love Walk"] = 119078958681704,
            ["Love Run"] = 125299572059026
        },
        Idle = {
            Idle = 94185126971500,
            ["Wings Idle"] = 79695556314678,
            ["Wings Razor Idle"] = 92182924117555,
            ["Mayhem Idle"] = 134791655189536,
            ["Purity Idle"] = 95465428055839,
            ["Corruption Idle"] = 96833380786508,
            ["Equinox Idle"] = 122568058603042,
            ["Divinity Idle"] = 81336289535499,
            ["Destiny Idle"] = 110231147799404,
            ["Rainbow Idle"] = 120540894651126,
            ["Omega Idle"] = 81292084310038,
            ["Pandora Idle"] = 78252350457029,
            ["Chaos Idle"] = 88950014509554,
            ["SHD Idle"] = 135146609643353,
            ["Crazed Idle"] = 114760809962084,
            ["FallenX Idle"] = 110988285662959,
            ["Calamity Idle"] = 139689406363112,
            ["Catastrophe Idle"] = 88716131838174,
            ["Boing Idle"] = 96137285835509,
            ["Love Idle"] = 71636714929026,
            ["Neptunian Idle"] = 82669337979094,
            ["Neptunian Idle Equipped"] = 132448620174661,
            ["Violence Idle"] = 103980312348481
        }
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 77255765562675,
                        Volume = 2
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 110521518376517,
                        Volume = 2
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 110521518376517,
                        Volume = 2
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 127505939012052,
                        Volume = 2
                    }
                }
            }
        },
        ["Clear Clouds"] = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 73191918066632,
                    Volume = 2
                }
            }
        },
        ["Snowstorm Helix"] = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 100093118402529,
                    Volume = 2
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 120866857942280,
                        Volume = 2
                    }
                }
            }
        },
        ["Wind Shower"] = {
            Slashes = {
                HitSounds = {
                    Hit = {
                        SoundId = 115770465663061,
                        Volume = 2
                    }
                }
            },
            FinalSlash = {
                HitSounds = {
                    Hit = {
                        SoundId = 139749420889977,
                        Volume = 2
                    }
                }
            }
        },
        Whirlwind = {
            HitSounds = {
                Hit = {
                    SoundId = 122223973891300,
                    Volume = 2
                }
            }
        },
        ["Threefold Slice"] = {
            HitSounds = {
                Hit = {
                    SoundId = 117457973564240,
                    Volume = 2
                }
            }
        },
        ["Sword Impalement"] = {
            HitSounds = {
                Hit = {
                    SoundId = 97662681266120,
                    Volume = 2
                }
            }
        },
        ["Swallowing Void"] = {
            ["SwallowingVoid-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 83803985958416,
                        Volume = 2
                    }
                }
            }
        },
        ["Sky Shatter"] = {
            VoicelineRange = 2,
            HitSounds = {
                Hit = {
                    SoundId = 103460046351553,
                    Volume = 2
                }
            }
        },
        ["Piercing Void"] = {
            VoicelineRange = 2,
            ["PiercingVoid-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 70443839195257,
                        Volume = 2
                    }
                }
            },
            ["PiercingVoid-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 100339065596022,
                        Volume = 2
                    }
                }
            }
        },
        ["Fallen Leaves"] = {
            HitSounds = {
                Hit = {
                    SoundId = 138845405602837,
                    Volume = 2
                }
            }
        },
        Devastation = {
            Sword = {
                HitSounds = {
                    Hit = {
                        SoundId = 137252610798022,
                        Volume = 2
                    }
                }
            },
            MoveProjectile = {
                HitSounds = {
                    Hit = {
                        SoundId = 137252610798022,
                        Volume = 0.075
                    }
                }
            }
        },
        ["Ascended Punishment"] = {
            HitSounds = {
                Hit = {
                    SoundId = 132166455475975,
                    Volume = 0.75
                }
            }
        },
        ["Empty Mist"] = {
            HitSounds = {
                Hit = {
                    SoundId = 138845405602837,
                    Volume = 2
                }
            },
            Finisher = {
                HitSounds = {
                    Hit = {
                        SoundId = 86662105736765,
                        Volume = 2
                    }
                }
            }
        },
        Ultimate = {
            RootOffset = CFrame.identity
        },
        Pose = {
            SkipTransition = true,
            Callbacks = {
                PoseTransition = function(p20, p21) -- Line: 443, Name: PoseTransition
                    -- upvalues: u7 (ref)
                    local Player = p20.Player;
                    local Character = p20.Character;
                    local v22 = Character:GetAttribute("GlitcherForm");

                    if Character:GetAttribute("Sovereign") and v22 == "None" then
                        u7.FireAllClients("UmbraPoseAfterimage", {
                            Player = Player,
                            Attacker = Character,
                            HSVShift = p21.ParticleHandler.GetHSVShift(p20)
                        });

                        return;
                    end;

                    if v22 ~= "None" then
                        u7.FireAllClients("MAYHEM_Pose", {
                            Character = Character,
                            Form = v22
                        });
                    end;
                end,

                PoseLoop = function(p23, p24) -- Line: 462, Name: PoseLoop
                    -- upvalues: Common (copy), u7 (ref)
                    local v25 = p23.Character:GetAttribute("GlitcherForm");
                    local v26 = Common.FormData[v25];

                    if not v26 then
                        return;
                    end;

                    local v27 = v26[`{v26.CoreColor}Color`];
                    u7.FireAllClients("MAYHEM_FormSwitch", p23.Character, v27);
                end,

                Transformer = function(p28) -- Line: 472, Name: Transformer
                    -- upvalues: TableUtil (copy), u4 (copy), u6 (ref), Common (copy), u7 (ref)
                    local Player = p28.Player;
                    local Character = p28.Character;
                    local v29 = TableUtil.Copy(p28.Stats, true);
                    local v30 = Character:GetAttribute("GlitcherForm");
                    v29.PoseMusic = "";
                    local v31;

                    if v30 and v30 ~= "None" then
                        v31 = false;
                    else
                        v31 = not Character:GetAttribute("Sovereign");
                    end;

                    if v30 and v30 ~= "None" or v31 then
                        local v32 = v31 and "Base" or v30;
                        v29.LoopAnim = `{v32} Pose`;

                        if u4:NextInteger(1, 3) == 1 and not v31 then
                            v29.NoPoseAudio = true;

                            return v29;
                        end;

                        Character:SetAttribute("PoseAudioRemove", true);
                        local u33 = u6.GetSound(Character, (`{v32}_PoseMusic{Common.FormData[v32] and typeof(Common.FormData[v32].PoseMusicName) == "table" and (`-{u4:NextInteger(1, #Common.FormData[v32].PoseMusicName)}` or "") or ""}`));

                        if u33 then
                            u7.FireAllClients("PlaySoundGlobal", u33, { Player }, (1 / 0), nil, nil, true);
                            p28.Trove:Add(function() -- Line: 491
                                -- upvalues: Character (copy), u33 (copy), u7 (ref), Player (copy)
                                if Character and u33 then
                                    u7.FireAllClientsExcept({ Player }, "StopSoundGlobal", u33, {}, (1 / 0), nil, nil, true);
                                end;
                            end);

                            return v29;
                        end;
                    elseif v30 == "None" and Character:GetAttribute("Sovereign") then
                        v29.SkipTransition = false;
                    end;

                    return v29;
                end,

                PoseEnd = function(p34) -- Line: 505, Name: PoseEnd
                    -- upvalues: u7 (ref)
                    p34.Character:SetAttribute("PoseAudioRemove", nil);
                    u7.FireAllClients("MAYHEM_Pose", {
                        Remove = true,
                        Character = p34.Character
                    });
                end
            }
        }
    },
    Sounds = Sounds.Sounds,
    QuoteInfo = {
        Groups = {
            Base = {
                Visible = true
            },
            Mayhem = {
                Visible = false
            },
            Purity = {
                Visible = false
            },
            Corruption = {
                Visible = false
            },
            Equinox = {
                Visible = false
            },
            Divinity = {
                Visible = false
            },
            Destiny = {
                Visible = false
            },
            Rainbow = {
                Visible = false
            },
            Omega = {
                Visible = false
            },
            Catastrophe = {
                Visible = false
            },
            Pandora = {
                Visible = false
            },
            SHD = {
                Visible = false
            },
            Crazed = {
                Visible = false
            },
            FallenX = {
                Visible = false
            },
            Calamity = {
                Visible = false
            },
            Neptunian = {
                Visible = false
            }
        },
        Quotes = Quotes
    },
    Metadata = {
        PostRig = function(p35) -- Line: 573, Name: PostRig
            -- upvalues: RunService (copy), u5 (ref)
            if not RunService:IsServer() then
                return;
            end;

            u5.PostRig(p35);
        end
    }
};
  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local v1 = {};
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            HueShift = -10
        } }
};
local v3 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            HueShift = -10
        } }
};

local function CreateSound(p4, p5) -- Line: 26
    return {
        SoundId = p4,
        Volume = p5
    };
end;

v1["Rush Attack"] = {
    HitRemotes = { v2 },
    ["LMB-1"] = {
        HitSounds = {
            Hit = {
                SoundId = 15224375970,
                Volume = 1
            }
        }
    },
    ["LMB-4"] = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 15224378207,
                Volume = 1
            }
        }
    },
    ["StandOff-LMB-1"] = {
        HitSounds = {
            Hit = {
                SoundId = 15224375970,
                Volume = 1
            }
        }
    },
    ["StandOff-LMB-4"] = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 15224378207,
                Volume = 1
            }
        }
    },
    Callbacks = {
        StateChecker = function(p6, p7) -- Line: 66, Name: StateChecker
            -- upvalues: Knit (copy), TableUtil (copy)
            local Stats = p6.Stats;

            if not Knit.CollectionService:HasTag(p6.Character, "Summoned") then
                Stats = TableUtil.Copy(Stats, true);
                Stats.CustomPrefix = "StandOff-LMB";
            end;

            return Stats;
        end
    }
};
v1["Rush Attack"]["LMB-2"] = v1["Rush Attack"]["LMB-1"];
v1["Rush Attack"]["LMB-3"] = v1["Rush Attack"]["LMB-1"];
v1["Rush Attack"]["StandOff-LMB-2"] = v1["Rush Attack"]["StandOff-LMB-1"];
v1["Rush Attack"]["StandOff-LMB-3"] = v1["Rush Attack"]["StandOff-LMB-1"];
v1.Summon = {
    SummonV2 = true,

    OnSummon = function(p8, p9) -- Line: 83, Name: OnSummon
        p8.Character.Stand["Stand Head"].Fire.Enabled = p9;
    end
};
v1["Kinetic Charge"] = {
    HitRemotes = { v3 },
    ["Hit-1"] = {
        Hit = {
            SoundId = 13955897771,
            Volume = 1
        }
    },
    ["Hit-2"] = {
        Hit = {
            SoundId = 13955897771,
            Volume = 1
        }
    },
    ["Hit-3"] = {
        Hit = {
            SoundId = 13955897771,
            Volume = 1
        }
    }
};
v1["Electric Strike"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 15224568640,
            Volume = 1
        }
    }
};
v1["Kinetic Orb"] = {
    HitRemotes = { v2 }
};
v1["Kinetic Blast"] = {
    HitSounds = {
        Hit = {
            SoundId = 15238439310,
            Volume = 1
        }
    }
};
v1["Dual Shocker"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 15224375970,
            Volume = 1
        }
    }
};
v1["Shock Stab"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 15237175393,
            Volume = 1
        }
    }
};
v1["Energy Overflow"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 13955898327,
            Volme = 1
        }
    }
};
v1.Discharge = {
    HitSounds = {
        Hit = {
            SoundId = 15224374984,
            Volume = 1
        }
    }
};
v1.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        Transformer = function(p10) -- Line: 185, Name: Transformer
            -- upvalues: TableUtil (copy), Knit (copy)
            local v11 = TableUtil.Copy(p10.Stats, true);
            v11.PoseMusic = "Stand" .. (Knit.CollectionService:HasTag(p10.Character, "Summoned") and "On" or "Off") .. "PoseMusic";

            if not Knit.CollectionService:HasTag(p10.Character, "Summoned") then
                v11.LoopAnim = "StandOffPoseIdle";
                v11.StartAnim = "EmptyAnimation";
            end;

            return v11;
        end
    }
};

return {
    Inherit = {
        AbilityName = "Locke"
    },
    Stats = v1,
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 15224375426,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13955900958,
            Volume = 0
        },
        ["Desummon-SFX"] = {
            SoundId = 15224375048,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 13955901157,
            Volume = 0
        },
        SummonSound = {
            SoundId = 15224375426,
            Volume = 1
        },
        Desummon = {
            SoundId = 15224375048,
            Volume = 1
        },
        ["Kingslayer-Dash"] = {
            SoundId = 15224375596,
            Volume = 1
        },
        ["Kingslayer-Dash-Voiceline"] = {
            SoundId = 13955899112,
            Volume = 0
        },
        ["Kingslayer-Grab"] = {
            SoundId = 15224375532,
            Volume = 1
        },
        ["Kingslayer-Grab-Voiceline"] = {
            SoundId = 13955898792,
            Volume = 0
        },
        ["Static-Buster-Startup"] = {
            SoundId = 15224375724,
            Volume = 1
        },
        ["Static-Buster-Startup-Voiceline"] = {
            SoundId = 13955895386,
            Volume = 0
        },
        ["Static-Buster-Hit"] = {
            SoundId = 15224375137,
            Volume = 1
        },
        ["Static-Buster-Hit-Voiceline"] = {
            SoundId = 15224375865,
            Volume = 6.5
        },
        ["Electric-Strike"] = {
            SoundId = 15224378624,
            Volume = 1
        },
        ["Electric-Strike-Voiceline"] = {
            SoundId = 13955899903,
            Volume = 0
        },
        ["Kinetic-Blast-Voiceline"] = {
            SoundId = 15238439088,
            Volume = 5
        },
        ["Kinetic-Blast"] = {
            SoundId = 15238439208,
            Volume = 1
        },
        ["Shock-Stab"] = {
            SoundId = 15237175223,
            Volume = 1
        },
        ["Shock-Stab-Voiceline"] = {
            SoundId = 15237175312,
            Volume = 5
        },
        Discharge = {
            SoundId = 15224375306,
            Volume = 1
        },
        ["Discharge-Voiceline"] = {
            SoundId = 13955898185,
            Volume = 0
        },
        KineticCharge = {
            SoundId = 15224374897,
            Volume = 1
        },
        ["KineticCharge-Voiceline"] = {
            SoundId = 15224374785,
            Volume = 6
        },
        ["Overvolt-Startup"] = {
            SoundId = 15224375787,
            Volume = 1
        },
        ["Overvolt-Startup-Voiceline"] = {
            SoundId = 13955895814,
            Volume = 0
        },
        ["Overvolt-Hit"] = {
            SoundId = 15224378314,
            Volume = 1
        },
        ["Overvolt-Hit-Voiceline"] = {
            SoundId = 15224376081,
            Volume = 5.5
        },
        ["LMB-1"] = {
            SoundId = 15224568143,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 15224568143,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 15224568143,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 15224568299,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13955902588,
            Volume = 0
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13955902194,
            Volume = 0
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13955900014,
            Volume = 0
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13955901615,
            Volume = 0
        },
        SwingLMB = {
            SoundId = 15224568143,
            Volume = 1
        },
        KineticOrb = {
            SoundId = 13142593170,
            Volume = 1
        },
        ["KineticOrb-Voiceline"] = {
            SoundId = 15224374583,
            Volume = 5.5
        },
        OrbSFX = {
            SoundId = 15224568505,
            Volume = 1
        },
        OrbExplode = {
            SoundId = 15224568389,
            Volume = 1
        },
        OrbStartup = {
            SoundId = 15224568569,
            Volume = 1
        },
        ["DualShocker-SFX"] = {
            SoundId = 15224568705,
            Volume = 1
        },
        ["DualShocker-Voiceline"] = {
            SoundId = 13955903519,
            Volume = 0
        },
        ["DualShocker-1"] = {
            SoundId = 15224375970,
            Volume = 1
        },
        ["DualShocker-2"] = {
            SoundId = 15224375970,
            Volume = 1
        },
        ["Energy-Overflow"] = {
            SoundId = 15224374534,
            Volume = 1
        },
        ["Energy-Overflow-Voiceline"] = {
            SoundId = 13955897475,
            Volume = 0
        },
        StandOnPoseMusic = {
            Looped = true,
            SoundId = 15224378087,
            Volume = 1.2
        },
        StandOffPoseMusic = {
            Looped = true,
            SoundId = 15224378532,
            Volume = 1.75
        },
        Takedown = {
            SoundId = 15224568034,
            Volume = 1
        },
        ["Takedown-Voiceline"] = {
            SoundId = 13955896455,
            Volume = 0
        },
        TakedownAttempt = {
            SoundId = 15224568224,
            Volume = 1
        },
        ["TakedownAttempt-Voiceline"] = {
            SoundId = 13955897106,
            Volume = 0
        }
    },
    Animations = {
        Action = {
            StandOffPoseIdle = 15237024207,
            EmptyAnimation = 15237064929
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
                    SoundId = "rbxassetid://13955902715",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Is it already over?"
                        } }
                }, {
                    SoundId = "rbxassetid://13955903117",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now, come at me!"
                        } }
                }, {
                    SoundId = "rbxassetid://13955902817",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hmph. You\'re a loser."
                        } }
                }, {
                    SoundId = "rbxassetid://13143048203",
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Your life is nothing, YOU SERVE ZERO PURPOSE"
                        } }
                } }
        }
    }
};
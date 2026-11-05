  

 

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
                SoundId = 13955902335,
                Volume = 3
            }
        }
    },
    ["LMB-4"] = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13955902966,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-1"] = {
        HitSounds = {
            Hit = {
                SoundId = 13955902335,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-4"] = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13955902966,
                Volume = 3
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
    SummonV2 = true
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
            SoundId = 13955899706,
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
            SoundId = 13140596337,
            Volume = 1
        }
    }
};
v1["Dual Shocker"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 13955903679,
            Volume = 1
        }
    }
};
v1["Shock Stab"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 13955900643,
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
            SoundId = 13955898327,
            Volme = 1
        }
    }
};

return {
    Inherit = {
        AbilityName = "Locke"
    },
    Stats = v1,
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = 13955901885,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13955900958,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 13955901393,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 13955901157,
            Volume = 1
        },
        SummonSound = {
            SoundId = 13955901885,
            Volume = 1
        },
        Desummon = {
            SoundId = 13955901393,
            Volume = 1
        },
        ["Kingslayer-Dash"] = {
            SoundId = 13955899412,
            Volume = 1
        },
        ["Kingslayer-Dash-Voiceline"] = {
            SoundId = 13955899112,
            Volume = 1
        },
        ["Kingslayer-Grab"] = {
            SoundId = 13955899244,
            Volume = 1
        },
        ["Kingslayer-Grab-Voiceline"] = {
            SoundId = 13955898792,
            Volume = 1
        },
        ["Static-Buster-Startup"] = {
            SoundId = 13955896276,
            Volume = 1
        },
        ["Static-Buster-Startup-Voiceline"] = {
            SoundId = 13955895386,
            Volume = 1
        },
        ["Static-Buster-Hit"] = {
            SoundId = 13955896644,
            Volume = 1
        },
        ["Static-Buster-Hit-Voiceline"] = {
            SoundId = 13957751525,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13955902588,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13955902194,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13955900014,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13955901615,
            Volume = 1
        },
        ["Electric-Strike"] = {
            SoundId = 13955899543,
            Volume = 1
        },
        ["Electric-Strike-Voiceline"] = {
            SoundId = 13955899903,
            Volume = 1
        },
        ["Kinetic-Blast-Voiceline"] = {
            SoundId = 13955900123,
            Volume = 1
        },
        ["Kinetic-Blast"] = {
            SoundId = 13955900264,
            Volume = 1
        },
        ["Shock-Stab"] = {
            SoundId = 13955900793,
            Volume = 1
        },
        ["Shock-Stab-Voiceline"] = {
            SoundId = 13955900408,
            Volume = 1
        },
        Discharge = {
            SoundId = 13955898462,
            Volume = 1
        },
        ["Discharge-Voiceline"] = {
            SoundId = 13955898185,
            Volume = 1
        },
        KineticCharge = {
            SoundId = 13955897637,
            Volume = 1
        },
        ["KineticCharge-Voiceline"] = {
            SoundId = 13955897311,
            Volume = 1
        },
        ["Overvolt-Startup"] = {
            SoundId = 13955896046,
            Volume = 1
        },
        ["Overvolt-Startup-Voiceline"] = {
            SoundId = 13955895814,
            Volume = 1
        },
        ["Overvolt-Hit"] = {
            SoundId = 13955895553,
            Volume = 1
        },
        ["Overvolt-Hit-Voiceline"] = {
            SoundId = 13955895660,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13955902011,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13955902011,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13955902011,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13955902482,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 13955902588,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 13955902194,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 13955900014,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 13955901615,
            Volume = 1
        },
        SwingLMB = {
            SoundId = 13955902011,
            Volume = 1
        },
        KineticOrb = {
            SoundId = 13142593170,
            Volume = 1
        },
        ["KineticOrb-Voiceline"] = {
            SoundId = 7146792142,
            Volume = 1
        },
        OrbSFX = {
            SoundId = 13956851438,
            Volume = 1
        },
        OrbExplode = {
            SoundId = 13956851737,
            Volume = 1
        },
        OrbStartup = {
            SoundId = 7146792142,
            Volume = 1
        },
        ["DualShocker-SFX"] = {
            SoundId = 13955904021,
            Volume = 1
        },
        ["DualShocker-Voiceline"] = {
            SoundId = 13955903519,
            Volume = 1
        },
        ["DualShocker-1"] = {
            SoundId = 13955903679,
            Volume = 1
        },
        ["DualShocker-2"] = {
            SoundId = 13142714594,
            Volume = 1
        },
        ["Energy-Overflow"] = {
            SoundId = 13955898604,
            Volume = 1
        },
        ["Energy-Overflow-Voiceline"] = {
            SoundId = 13955897475,
            Volume = 1
        },
        ["Energy-Overflow-Hit"] = {
            SoundId = 13142700549,
            Volume = 1
        },
        Takedown = {
            SoundId = 13955896812,
            Volume = 1
        },
        ["Takedown-Voiceline"] = {
            SoundId = 13955896455,
            Volume = 1
        },
        TakedownAttempt = {
            SoundId = 13955896940,
            Volume = 1
        },
        ["TakedownAttempt-Voiceline"] = {
            SoundId = 13955897106,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 7146792142,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 13955903840,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 13955903352,
            Volume = 1
        },
        ["Death-SFX"] = {
            SoundId = 13142931291,
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
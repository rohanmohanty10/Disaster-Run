  

 

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
                SoundId = 13142392874,
                Volume = 3
            }
        }
    },
    ["LMB-4"] = {
        HitRemotes = { v3 },
        Hit = {
            SoundId = 13142392874,
            Volume = 3
        }
    },
    ["StandOff-LMB-1"] = {
        HitSounds = {
            Hit = {
                SoundId = 13142392884,
                Volume = 3
            }
        }
    },
    ["StandOff-LMB-4"] = {
        HitRemotes = { v3 },
        HitSounds = {
            Hit = {
                SoundId = 13140446211,
                Volume = 3
            }
        }
    },
    Callbacks = {
        StateChecker = function(p6, p7) -- Line: 64, Name: StateChecker
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
    IgnoreParts = { "RootPart", "StandHumanoidRootPart", "Stand Head", "Stand Torso" }
};
v1["Kinetic Charge"] = {
    HitRemotes = { v3 },
    ["Hit-1"] = {
        Hit = {
            SoundId = 13140685360,
            Volume = 1
        }
    },
    ["Hit-2"] = {
        Hit = {
            SoundId = 13140687419,
            Volume = 1
        }
    },
    ["Hit-3"] = {
        Hit = {
            SoundId = 13140688365,
            Volume = 1
        }
    }
};
v1["Electric Strike"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 13140518739,
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
    HitRemotes = { v2 }
};
v1["Shock Stab"] = {
    HitRemotes = { v2 },
    HitSounds = {
        Hit = {
            SoundId = 13140616096,
            Volume = 1
        }
    }
};
v1["Energy Overflow"] = {
    HitRemotes = { v2 }
};
v1.Discharge = {
    HitSounds = {
        Hit = {
            SoundId = 13140648086,
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
            SoundId = 13140285774,
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = 13140287358,
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = 13140288468,
            Volume = 1
        },
        ["Desummon-Voiceline"] = {
            SoundId = 13140289825,
            Volume = 1
        },
        ["Kingslayer-Dash"] = {
            SoundId = 13140357641,
            Volume = 1
        },
        ["Kingslayer-Dash-Voiceline"] = {
            SoundId = 13140356264,
            Volume = 1
        },
        ["Kingslayer-Grab"] = {
            SoundId = 13140359258,
            Volume = 1
        },
        ["Kingslayer-Grab-Voiceline"] = {
            SoundId = 13140354889,
            Volume = 1
        },
        ["Static-Buster-Startup"] = {
            SoundId = 13140393164,
            Volume = 1
        },
        ["Static-Buster-Startup-Voiceline"] = {
            SoundId = 13140392113,
            Volume = 1
        },
        ["Static-Buster-Hit"] = {
            SoundId = 13140394868,
            Volume = 1
        },
        ["Static-Buster-Hit-Voiceline"] = {
            SoundId = 13140390771,
            Volume = 1
        },
        ["StandOff-LMB-1"] = {
            SoundId = 13140436431,
            Volume = 1
        },
        ["StandOff-LMB-2"] = {
            SoundId = 13140438014,
            Volume = 1
        },
        ["StandOff-LMB-3"] = {
            SoundId = 13140439182,
            Volume = 1
        },
        ["StandOff-LMB-4"] = {
            SoundId = 13140440415,
            Volume = 1
        },
        ["Electric-Strike"] = {
            SoundId = 13140516593,
            Volume = 1
        },
        ["Electric-Strike-Voiceline"] = {
            SoundId = 13140517608,
            Volume = 1
        },
        ["Kinetic-Blast-Voiceline"] = {
            SoundId = 13140595069,
            Volume = 1
        },
        ["Kinetic-Blast"] = {
            SoundId = 13140597464,
            Volume = 1
        },
        ["Shock-Stab"] = {
            SoundId = 13140617193,
            Volume = 1
        },
        ["Shock-Stab-Voiceline"] = {
            SoundId = 13140618234,
            Volume = 1
        },
        Discharge = {
            SoundId = 13140649307,
            Volume = 1
        },
        ["Discharge-Voiceline"] = {
            SoundId = 13140647080,
            Volume = 1
        },
        KineticCharge = {
            SoundId = 13140684074,
            Volume = 1
        },
        ["KineticCharge-Voiceline"] = {
            SoundId = 13140682630,
            Volume = 1
        },
        ["Overvolt-Startup"] = {
            SoundId = 13140799421,
            Volume = 1
        },
        ["Overvolt-Startup-Voiceline"] = {
            SoundId = 13140797563,
            Volume = 1
        },
        ["Overvolt-Hit"] = {
            SoundId = 13140800885,
            Volume = 1
        },
        ["Overvolt-Hit-Voiceline"] = {
            SoundId = 13140802360,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13142392867,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13142392871,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13142392862,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13142392973,
            Volume = 1
        },
        SwingLMB = {
            SoundId = 13142559052,
            Volume = 1
        },
        KineticOrb = {
            SoundId = 13142593170,
            Volume = 1
        },
        ["KineticOrb-Voiceline"] = {
            SoundId = 13142593167,
            Volume = 1
        },
        OrbSFX = {
            SoundId = 13142593194,
            Volume = 1
        },
        OrbExplode = {
            SoundId = 13142593204,
            Volume = 1
        },
        ["DualShocker-SFX"] = {
            SoundId = 13142700513,
            Volume = 1
        },
        ["DualShocker-Voiceline"] = {
            SoundId = 13142700530,
            Volume = 1
        },
        ["DualShocker-1"] = {
            SoundId = 13142713363,
            Volume = 1
        },
        ["DualShocker-2"] = {
            SoundId = 13142714594,
            Volume = 1
        },
        ["Energy-Overflow"] = {
            SoundId = 13142700548,
            Volume = 1
        },
        ["Energy-Overflow-Voiceline"] = {
            SoundId = 13142700526,
            Volume = 1
        },
        ["Energy-Overflow-Hit"] = {
            SoundId = 13142700549,
            Volume = 1
        },
        Takedown = {
            SoundId = 13142700565,
            Volume = 1
        },
        ["Takedown-Voiceline"] = {
            SoundId = 13142700520,
            Volume = 1
        },
        TakedownAttempt = {
            SoundId = 13142700572,
            Volume = 1
        },
        ["TakedownAttempt-Voiceline"] = {
            SoundId = 13142700518,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 13142923634,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 13142924541,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 13142925649,
            Volume = 1
        },
        ["Death-SFX"] = {
            SoundId = 13142931291,
            Volume = 1
        },
        PoseMusic = {
            Looped = true,
            SoundId = 10382635496,
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
            Universal = { {
                    SoundId = "rbxassetid://13142945320",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m satisfied enough, now there\'s no need to play with you toys anymore"
                        } }
                }, {
                    SoundId = "rbxassetid://13142946237",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Foolish human! I will rule over you! Bow before my might and intelligence!"
                        } }
                }, {
                    SoundId = "rbxassetid://13142947120",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That\'s all?"
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
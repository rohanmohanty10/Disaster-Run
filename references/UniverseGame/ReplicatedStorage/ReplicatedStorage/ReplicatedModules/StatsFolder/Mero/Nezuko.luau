  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("TweenService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u4 (ref), u5 (ref), PathShortcuts (copy), u3 (ref)
    u1 = Knit.GetService("MoveInputService");
    u2 = Knit.GetService("EffectService");
    u4 = Knit.GetService("RigService");
    u5 = Knit.GetService("TagService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(Knit.Util.TableUtil);
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
require(PathShortcuts.BaseStatsModule);
require(ReplicatedStorage.ReplicatedModules.Enums);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.AnimationHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
({}).Hit = {
    SoundId = 79047795971199,
    Volume = 0.8
};
local v6 = {
    Hit = {
        SoundId = 108617721732471,
        Volume = 0.75
    }
};
local v7 = {
    Hit = {
        SoundId = 127593524077070,
        Volume = 0.75
    }
};
local v8 = {
    Hit = {
        SoundId = 104361329243570,
        Volume = 0.5
    }
};
({}).Hit = {
    SoundId = 95674436846696,
    Volume = 0.75
};

return {
    Inherit = {
        AbilityName = "Mero"
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 115203602535362,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 1.8281535648994514
        },
        ["PoseMusic-2"] = {
            SoundId = 98131762524148,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 2.2675736961451247
        },
        ["PoseMusic-3"] = {
            SoundId = 74532635329763,
            Volume = 1,
            Looped = true
        },
        ["Lovely Legwork Voiceline"] = {
            SoundId = 131426879374964,
            Volume = 1
        },
        ["Lovely Legwork SFX"] = {
            SoundId = 75390607028559,
            Volume = 1
        },
        ["Magna Voiceline"] = {
            SoundId = 85832365227344,
            Volume = 1
        },
        ["Magna SFX"] = {
            SoundId = 140075945616139,
            Volume = 1
        },
        ["Mellow Voiceline"] = {
            SoundId = 93261233327501,
            Volume = 1
        },
        ["Mellow SFX"] = {
            SoundId = 132659053042597,
            Volume = 1
        },
        ["Perfume Fever Voiceline"] = {
            SoundId = 74707095985413,
            Volume = 1.3
        },
        ["Perfume Fever SFX"] = {
            SoundId = 122493093807631,
            Volume = 1
        },
        ["Pistol Kiss Startup Voiceline"] = {
            SoundId = 17210344439,
            Volume = 0
        },
        ["Pistol Kiss Voiceline"] = {
            SoundId = 101864635003773,
            Volume = 1
        },
        ["Pistol Kiss SFX"] = {
            SoundId = 138365884809183,
            Volume = 1
        },
        ["Pistol Kiss Charging"] = {
            SoundId = 78746815402490,
            Volume = 1
        },
        ["Pistol Kiss Charged Shot"] = {
            SoundId = 135751885999134,
            Volume = 1
        },
        ["Pistol Kiss Uncharged Shot"] = {
            SoundId = 135751885999134,
            Volume = 1
        },
        ["Pistol Kiss Wall Impact"] = {
            SoundId = 117216227478969,
            Volume = 1
        },
        ["Pistol Kiss Charge Indicator"] = {
            SoundId = 16843849529,
            Volume = 0
        },
        ["Queen Stomp Startup Voiceline"] = {
            SoundId = 74534890108018,
            Volume = 1
        },
        ["Queen Stomp Startup SFX"] = {
            SoundId = 98023260509252,
            Volume = 1
        },
        ["Queen Stomp Voiceline"] = {
            SoundId = 17478853322,
            Volume = 0
        },
        ["Queen Stomp SFX"] = {
            SoundId = 129594115152390,
            Volume = 1
        },
        Petrify = {
            SoundId = 71648884131757,
            Volume = 1
        },
        Unpetrify = {
            SoundId = 97773576256636,
            Volume = 1
        },
        ["Infatuation Voiceline"] = {
            SoundId = 127229082835421,
            Volume = 1
        },
        ["Infatuation SFX"] = {
            SoundId = 85170893696371,
            Volume = 0.85,
            RollOffMaxDistance = 200
        },
        ["Infatuation Release SFX"] = {
            SoundId = 94616781833969,
            Volume = 1,
            RollOffMaxDistance = 200
        },
        ["Petrifying Burst SFX"] = {
            SoundId = 138077206047788,
            Volume = 1
        },
        ["Petrifying Burst Shoot SFX"] = {
            SoundId = 17488668712,
            Volume = 0
        },
        ["Petrifying Burst Voiceline"] = {
            SoundId = 122424529051033,
            Volume = 1
        },
        ["Petrifying Burst Land"] = {
            SoundId = 96880038723092,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 91134827733683,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 99031884897722,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 114774776275971,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 84483106734414,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 137776536671003,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 75465406065306,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 108558852737461,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 119774797779550,
            Volume = 1
        },
        ["LMB-4Slam"] = {
            SoundId = 134566718965457,
            Volume = 1
        },
        ["Heartless Startup Voiceline"] = {
            SoundId = 17210342420,
            Volume = 0
        },
        ["Heartless Startup SFX"] = {
            SoundId = 106684176175878,
            Volume = 1
        },
        ["Heartless Voiceline"] = {
            SoundId = 138305729298537,
            Volume = 1
        },
        ["Heartless SFX"] = {
            SoundId = 94133527785640,
            Volume = 1
        },
        ["Heartless Music"] = {
            SoundId = 92095195841619,
            Volume = 1,
            PlaybackSpeed = 4
        },
        ["Cupid\'s Yumi Shoot SFX"] = {
            SoundId = 16901353377,
            Volume = 0
        },
        ["Cupid\'s Yumi SFX"] = {
            SoundId = 130931746053105,
            Volume = 1
        },
        ["Cupid\'s Yumi Voiceline"] = {
            SoundId = 119718039970861,
            Volume = 1
        },
        ["Cupid\'s Yumi Explode"] = {
            SoundId = 79401472501095,
            Volume = 1
        },
        MeterUp1 = {
            SoundId = 100082114524973,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 122929562881294,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 130276347719681,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 92501826309391,
            Volume = 1
        }
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v6
            },
            ["LMB-2"] = {
                HitSounds = v6
            },
            ["LMB-3"] = {
                HitSounds = v6
            },
            ["LMB-4"] = {
                HitSounds = v7
            }
        },
        ["Lovely Legwork"] = {
            HitSounds = v8
        },
        ["Perfume Femur Magna"] = {
            HitSounds = v6,
            Finisher = {
                HitSounds = v7
            }
        },
        ["Perfume Fever"] = {
            HitSounds = v8,
            Finisher = {
                HitSounds = v7
            }
        },
        Pose = {
            MusicAmount = 3
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
                    SoundId = "rbxassetid://94822625419090",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Thank goodness!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://124863022371751",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good morning!",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://77159525282128",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "W-Welcome back!",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};
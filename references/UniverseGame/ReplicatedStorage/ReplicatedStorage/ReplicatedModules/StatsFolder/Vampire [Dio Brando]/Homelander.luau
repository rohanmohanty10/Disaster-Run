  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.EnumsModule);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 20
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.StatsFolder["The Mercenaries"]["The Mercenaries"].Common);
end);
local v4 = {
    Hit = {
        SoundId = 84423837703651,
        Volume = 1
    }
};
local v5 = {
    Hit = {
        SoundId = 86862215859045,
        Volume = 1
    }
};
local v6 = {
    Hit = {
        SoundId = 84591632635837,
        Volume = 1
    }
};
local v7 = {
    Hit = {
        SoundId = 131306887475595,
        Volume = 1
    }
};

return {
    Inherit = {
        AbilityName = "Vampire [Dio Brando]"
    },
    Animations = {
        Action = {
            ["LMB-1"] = 127614825601137,
            ["LMB-2"] = 73042829395943,
            ["LMB-3"] = 126362418904917,
            ["LMB-4"] = 104630255056786,
            ["Phantom Mirage Zombie"] = 89729202457052,
            Regeneration = 128270483507345,
            ["Regeneration Loop"] = 85995119527199,
            ["Life Drain Startup"] = 81398208404834,
            ["Freezing Technique Followup"] = 83600304705223,
            ["Freezing Technique Victim"] = 138670264945088
        },
        Movement = {
            Walk = 93567354974947,
            Run = 13455572588
        },
        Idle = {
            Idle = 129782774403470
        }
    },
    Stats = {
        Pose = {
            Callbacks = {
                PoseLoop = function(p8, p9) -- Line: 102, Name: PoseLoop
                    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u2 (ref), u1 (ref)
                    local Player = p8.Player;
                    local Character = p8.Character;
                    local _ = Character.HumanoidRootPart;
                    local _ = Character.Humanoid;
                    local v10 = p9.Trove:Add(AssetHandler.CloneAsset("Particles/PoseEyes", p8));
                    ParticleHandler.Unusualify(v10, p8);
                    v10.Parent = Character;
                    ParticleHandler.AttachTo(v10, {
                        Part = Character.Head
                    });
                    local v11 = AssetHandler.CloneAsset("Particles/PoseUI", p8);
                    v11.Enabled = true;
                    v11.Handler.Enabled = true;
                    v11.Parent = Player.PlayerGui;
                    Character:SetAttribute("HomelanderRise", true);
                    u2.FireAllClients("HomelanderRise", Character);
                    u1.ChangeCollision(Character, "FX");
                    p8.Trove:Add(function() -- Line: 139
                        -- upvalues: u1 (ref), Character (copy)
                        u1.ChangeCollision(Character, "Default");
                        Character:SetAttribute("HomelanderRise", nil);
                    end);
                end
            },
            AlternativeThemes = { "PoseMusic Layer" }
        },
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v4
            },
            ["LMB-2"] = {
                HitSounds = v4
            },
            ["LMB-3"] = {
                HitSounds = v4
            },
            ["LMB-4"] = {
                HitSounds = v5
            }
        },
        ["Relentless Barrage"] = {
            HitSounds = {
                Hit = {
                    SoundId = 128749431377793,
                    Volume = 0.55
                }
            },
            Finisher = {
                HitSounds = v5
            }
        },
        ["Driving Force"] = {
            Strike = {
                HitSounds = v6
            },
            Finisher = {
                HitSounds = v7
            }
        },
        ["Phantom Mirage"] = {
            ATrainVoicelines = 4,
            Strike = {
                HitSounds = v7
            }
        },
        ["Life Drain"] = {
            Drain = {
                HitSounds = v6
            }
        }
    },
    Sounds = {
        MeterUp2 = {
            SoundId = 136489077704891,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 138175058745699,
            Volume = 1
        },
        PoseMusic = {
            SoundId = 75061742264306,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 4.329004329004329
        },
        ["PoseMusic Layer"] = {
            SoundId = 79375223934741,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 4.329004329004329
        },
        ["LMB-1"] = {
            SoundId = 77752667540457,
            Volume = 1
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 79375300518544,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 78440962433417,
            Volume = 1
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 105471334575209,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 108851748506526,
            Volume = 1
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 73030766644950,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 135537236369391,
            Volume = 1
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 96406240406314,
            Volume = 1
        },
        ["Shadow Step"] = {
            SoundId = 14255541295,
            Volume = 1
        },
        ["Regeneration Voiceline"] = {
            SoundId = 97883994914702,
            Volume = 3
        },
        Regeneration = {
            SoundId = 84149704917009,
            Looped = true,
            Volume = 1
        },
        ["Surprise Impact Voiceline"] = {
            SoundId = 80013066306847,
            Volume = 1
        },
        ["Surprise Impact Formation"] = {
            SoundId = 132601666759271,
            Volume = 1
        },
        ["Surprise Impact"] = {
            SoundId = 140432513011599,
            Volume = 1
        },
        ["Zombie Explosion"] = {
            SoundId = 73626459458393,
            Volume = 1
        },
        ["Surprise Impact Zombie Spawn"] = {
            SoundId = 81877545247845,
            Volume = 1
        },
        ["Relentless Barrage"] = {
            SoundId = 92927012839712,
            Volume = 1
        },
        ["Relentless Barrage Voiceline 1"] = {
            SoundId = 93910555057385,
            Volume = 1
        },
        ["Relentless Barrage Voiceline 2"] = {
            SoundId = 121620663075877,
            Volume = 1
        },
        ["Corpse Hurl"] = {
            SoundId = 128802707846202,
            Volume = 1
        },
        ["Corpse Hurl Voiceline"] = {
            SoundId = 134381201739184,
            Volume = 1
        },
        ["Driving Force"] = {
            SoundId = 71554526101552,
            Volume = 1
        },
        ["Driving Force Voiceline"] = {
            SoundId = 72592459868559,
            Volume = 1
        },
        ["Phantom Mirage Voiceline"] = {
            SoundId = 93708254737498,
            Volume = 1
        },
        ["Phantom Mirage"] = {
            SoundId = 114867325897795,
            Volume = 1
        },
        ["Phantom Mirage Impale"] = {
            SoundId = 129371452930136,
            Volume = 1
        },
        ["Vaporization Freezing Counter Voiceline"] = {
            SoundId = 130407826665550,
            Volume = 1
        },
        ["Vaporization Freezing Counter"] = {
            SoundId = 104171150887285,
            Volume = 1
        },
        ["Vaporization Freezing Technique Voiceline"] = {
            SoundId = 136541903704091,
            Volume = 1
        },
        ["Vaporization Freezing Technique"] = {
            SoundId = 135989703371828,
            Volume = 1
        },
        ["Life Drain Startup Voiceline"] = {
            SoundId = 71147005614735,
            Volume = 1
        },
        ["Life Drain Startup"] = {
            SoundId = 119145018751595,
            Volume = 1
        },
        ["Life Drain Voiceline 1"] = {
            SoundId = 86582429662571,
            Volume = 1
        },
        ["Life Drain Voiceline 2"] = {
            SoundId = 86582429662571,
            Volume = 1
        },
        ["Life Drain Steal"] = {
            SoundId = 103569690960081,
            Volume = 1
        },
        ["Life Drain"] = {
            SoundId = 129659706953925,
            Volume = 1
        },
        ["Inhumane Perception Voiceline"] = {
            SoundId = 119108069456912,
            Volume = 1
        },
        ["Inhumane Perception"] = {
            SoundId = 84778469694154,
            Volume = 1
        },
        ["Space Ripper Stingy Eyes Voiceline"] = {
            SoundId = 72750070170484,
            Volume = 1
        },
        ["Space Ripper Stingy Eyes"] = {
            SoundId = 122924597703931,
            Volume = 1
        },
        ["Deep Summon Voiceline"] = {
            SoundId = 118966122035013,
            Volume = 1.5
        },
        ["Dolphin Laugh"] = {
            SoundId = 138317476357317,
            Volume = 1.35
        },
        ["Deep Voiceline"] = {
            SoundId = 103857363086702,
            Volume = 1.75
        },
        ["A-Train Voiceline-1"] = {
            SoundId = 18441084757,
            Volume = 3.25
        },
        ["A-Train Voiceline-2"] = {
            SoundId = 18441088902,
            Volume = 1.5
        },
        ["A-Train Voiceline-3"] = {
            SoundId = 18441082210,
            Volume = 3.25
        },
        ["A-Train Voiceline-4"] = {
            SoundId = 18441083687,
            Volume = 3.25
        },
        ["A-Train Enter SFX"] = {
            SoundId = 18420460625,
            Volume = 1
        },
        ["A-Train Leave SFX"] = {
            SoundId = 18420460151,
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
            Universal = {
                {
                    SoundId = 97883994914702,
                    SoundVolume = 4,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Yummers",
                            ScaleTime = 0.425
                        } }
                },
                {
                    SoundId = 97429845065267,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "The only man in the sky...is me.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 138891028984881,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I don\'t make mistakes; I\'m not just like the rest of you. I\'m stronger, I\'m smarter...I\'m better. I AM BETTER!!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 120349840647736,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Ahahaha....aaaah...",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 128222346907043,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It was perfect. PERFECT. Everything; down to the last minute details.",
                            ScaleTime = 0.75
                        } }
                },
                {
                    SoundId = 123029761602438,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "LOOK. AT. ME.",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 71776726300588,
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = " Homelander: \"I heard that YOU are some of my biggest fans supporting me! When others turn their backs...I just wanted to personally say thank you; for your devtion, and your sacrifice.\" Fan - \"R-Really it\'s you who gives so much to-\" Homelander - \"You people are more than just fans. You\'re martyrs. To the greatest cause on earth. Open it. I want you to take these bats and beat these gentlemen to death.\" Fan - \"Guhuhuh! You\'re funny..!\" The Deep - \"Oh it\'s like one of your tests: you want us to say no!\" Homelander - \"No, deep. This is not a test. I want you to beat these gentlemen to death. Now.\"",
                            ScaleTime = 1
                        } }
                }
            }
        }
    }
};
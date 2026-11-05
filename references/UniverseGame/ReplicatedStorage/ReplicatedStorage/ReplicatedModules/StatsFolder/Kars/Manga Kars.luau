  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 5
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);

return {
    Inherit = {
        AbilityName = "Kars"
    },
    Sounds = {
        ["Supernatural Regeneration Voiceline"] = {
            SoundId = 14255013395,
            Volume = 0
        },
        ["Supernatural Regeneration SFX"] = {
            SoundId = 14255013487,
            Looped = true,
            Volume = 1
        },
        ["Sonic Blink"] = {
            SoundId = 18256644046,
            Volume = 1
        },
        ["Superhuman Agility"] = {
            SoundId = 18256645198,
            Volume = 1
        },
        ["Visceral Animosity SFX"] = {
            SoundId = 18303447799,
            Volume = 1
        },
        ["Visceral Animosity Voice"] = {
            SoundId = 18362865016,
            Volume = 1
        },
        ["Ground Slam"] = {
            SoundId = 18303447374,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 18362869131,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 18362868788,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 18362868457,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 18362867917,
            Volume = 1
        },
        ["LMB-1SFX"] = {
            SoundId = 18303446879,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 18303448853,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 18303446673,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 18303447576,
            Volume = 1
        },
        ["Dropkick Voiceline"] = {
            SoundId = 18362867222,
            Volume = 1
        },
        ["Dropkick SFX"] = {
            SoundId = 14187497626,
            Volume = 1
        },
        ["Arm Bash SFX"] = {
            SoundId = 14187497177,
            Volume = 1
        },
        ["Arm Bash Voiceline"] = {
            SoundId = 14187497286,
            Volume = 0
        },
        ["Arm Bash Hit SFX"] = {
            SoundId = 14187497792,
            Volume = 1
        },
        ["Arm Bash Hit Voiceline"] = {
            SoundId = 18362867532,
            Volume = 1
        },
        ["Cross Slice SFX"] = {
            SoundId = 18303450373,
            Volume = 1
        },
        ["Cross Slice Voiceline"] = {
            SoundId = 18362866625,
            Volume = 1
        },
        ["Ricochet Storm Voiceline"] = {
            SoundId = 18362868245,
            Volume = 1
        },
        ["Ricochet Storm SFX"] = {
            SoundId = 18303452240,
            Volume = 1
        },
        ["Wamuu User Summon Voiceline"] = {
            SoundId = 18362950050,
            Volume = 1
        },
        ["Tornado SFX"] = {
            SoundId = 14321229264,
            Volume = 1
        },
        ["Wamuu SFX"] = {
            SoundId = 14321229636,
            Volume = 1
        },
        ["Wamuu Voiceline"] = {
            SoundId = 18362864611,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 14321230160,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.68
                }
            }
        },
        PoseMusic2 = {
            SoundId = 14321824412,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 0.74
                }
            }
        },
        ["Lotus Grip Startup SFX"] = {
            SoundId = 18256643510,
            Volume = 1.25
        },
        ["Lotus Grip Startup Voiceline"] = {
            SoundId = 18362866954,
            Volume = 1.25
        },
        ["Lotus Grip SFX"] = {
            SoundId = 18256643788,
            Volume = 1.25
        },
        ["Lotus Grip Voiceline"] = {
            SoundId = 18362865969,
            Volume = 1.25
        },
        ["Lotus Grip Slam"] = {
            SoundId = 18256643024,
            Volume = 1.25
        },
        ["Bone Blade Equip"] = {
            SoundId = 18256645420,
            Volume = 1
        },
        ["Light Dancer Voiceline"] = {
            SoundId = 18362861442,
            Volume = 1
        },
        ["Light Dancer SFX"] = {
            SoundId = 18256644977,
            Volume = 1.25
        },
        ["Light Dancer Ambience"] = {
            SoundId = 18256645756,
            Volume = 1
        },
        ["Light Dancer Music"] = {
            SoundId = 18256645420,
            Volume = 0
        },
        ["Light Dancer End"] = {
            SoundId = 18256645951,
            Volume = 1
        },
        MeterUp2 = {
            SoundId = 18256646190,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 18256644769,
            Volume = 1
        },
        ["Counter Attempt SFX"] = {
            SoundId = 18303450743,
            Volume = 1
        },
        ["Counter Attempt Voiceline"] = {
            SoundId = 18362863810,
            Volume = 1
        },
        ["Counter SFX"] = {
            SoundId = 18304360236,
            Volume = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 18362865272,
            Volume = 1
        },
        ["Blind SFX"] = {
            SoundId = 18303451914,
            Volume = 1
        },
        ["Blind Voiceline"] = {
            SoundId = 18362865712,
            Volume = 1
        },
        ["Eisidisi Summon Voiceline"] = {
            SoundId = 18362864412,
            Volume = 1
        },
        ["Eisidisi Leap Voiceline"] = {
            SoundId = 18362865497,
            Volume = 1
        },
        ["Eisidisi Leap SFX"] = {
            SoundId = 18304358585,
            Volume = 1
        },
        ["Eisidisi Leap Slam"] = {
            SoundId = 18304358300,
            Volume = 1
        },
        ["Eisidisi Dash Voiceline"] = {
            SoundId = 18362864182,
            Volume = 1
        },
        ["Eisidisi Dash SFX"] = {
            SoundId = 18304359967,
            Volume = 1
        },
        ["Pose Pillarmen Reveal"] = {
            SoundId = 18363001156,
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
                    SoundId = "rbxassetid://18362949605",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Slicing your neck is as easy as plucking a flower..",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = "rbxassetid://18362861801",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You Idiot!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://18362862181",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Think my blades are sharp? Wait until your body feels them!",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = "rbxassetid://18362862541",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Go on then, keep mocking me... You are incapable of anything else.",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = "rbxassetid://18362863554",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "* Psychotic laughter *",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = "rbxassetid://18362862942",
                    SoundVolume = 1,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You are the only one who is miserable... Celebrate the new birth of this Kars!",
                            ScaleTime = 2.5
                        } }
                }
            }
        }
    }
};
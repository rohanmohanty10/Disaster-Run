  

 

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
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382383931,
                        Volume = 1
                    }
                }
            },
            ["LMB-2"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382385443,
                        Volume = 1
                    }
                }
            },
            ["LMB-3"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382386059,
                        Volume = 1
                    }
                }
            },
            ["LMB-4"] = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382386059,
                        Volume = 0
                    }
                }
            }
        },
        ["Visceral Animosity"] = {
            Slash = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382384997,
                        Volume = 1
                    }
                }
            },
            FinalSlash = {
                HitSounds = {
                    Hit = {
                        SoundId = 18382386391,
                        Volume = 1
                    }
                }
            }
        },
        ["Ricochet Storm"] = {
            HitSounds = {
                Hit = {
                    SoundId = 18382387802,
                    Volume = 0.85
                }
            }
        },
        ["Supersonic Kick"] = {
            HitSounds = {
                Hit = {
                    SoundId = 18382392543,
                    Volume = 1
                }
            }
        }
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
            SoundId = 18382386983,
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
            SoundId = 13610546480,
            Volume = 1.5
        },
        ["Ground Slam"] = {
            SoundId = 18382384645,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 13610545312,
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = 13610545239,
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = 13610545165,
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = 13610545055,
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
            SoundId = 14187497484,
            Volume = 1
        },
        ["Dropkick SFX"] = {
            SoundId = 14187497626,
            Volume = 1
        },
        ["Arm Bash SFX"] = {
            SoundId = 18382393671,
            Volume = 1
        },
        ["Arm Bash Voiceline"] = {
            SoundId = 14187497286,
            Volume = 1
        },
        ["Arm Bash Hit SFX"] = {
            SoundId = 18382392820,
            Volume = 1
        },
        ["Arm Bash Hit Voiceline"] = {
            SoundId = 14187497394,
            Volume = 1
        },
        ["Cross Slice SFX"] = {
            SoundId = 18303450373,
            Volume = 1
        },
        ["Cross Slice Voiceline"] = {
            SoundId = 14187497286,
            Volume = 1
        },
        ["Ricochet Storm Voiceline"] = {
            SoundId = 14321229524,
            Volume = 1
        },
        ["Ricochet Storm SFX"] = {
            SoundId = 18303452240,
            Volume = 1
        },
        ["Wamuu User Summon Voiceline"] = {
            SoundId = 14321229091,
            Volume = 1
        },
        ["Tornado SFX"] = {
            SoundId = 18382393140,
            Volume = 1
        },
        ["Wamuu SFX"] = {
            SoundId = 14321229636,
            Volume = 1
        },
        ["Wamuu Voiceline"] = {
            SoundId = 18382394018,
            Volume = 1
        },
        PoseMusic1 = {
            SoundId = 18382388967,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.355
                }
            }
        },
        PoseMusic2 = {
            SoundId = 18382390946,
            Volume = 1,
            Looped = true,
            SoundEffects = {
                PitchShiftSoundEffect = {
                    Octave = 1.385
                }
            }
        },
        ["Lotus Grip Startup SFX"] = {
            SoundId = 18256643510,
            Volume = 1.25
        },
        ["Lotus Grip Startup Voiceline"] = {
            SoundId = 18256643252,
            Volume = 1.25
        },
        ["Lotus Grip SFX"] = {
            SoundId = 18256643788,
            Volume = 1.25
        },
        ["Lotus Grip Voiceline"] = {
            SoundId = 18256644249,
            Volume = 1.25
        },
        ["Lotus Grip Slam"] = {
            SoundId = 18382392145,
            Volume = 1.25
        },
        ["Light Dancer Voiceline"] = {
            SoundId = 18256644555,
            Volume = 1.25
        },
        ["Light Dancer SFX"] = {
            SoundId = 18382387454,
            Volume = 1
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
            SoundId = 18382391237,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 18382388024,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 18382391459,
            Volume = 1
        },
        ["Counter Attempt SFX"] = {
            SoundId = 18303450743,
            Volume = 1
        },
        ["Counter Attempt Voiceline"] = {
            SoundId = 18304359277,
            Volume = 1
        },
        ["Counter SFX"] = {
            SoundId = 18304360236,
            Volume = 1
        },
        ["Counter Voiceline"] = {
            SoundId = 18304360957,
            Volume = 1
        },
        ["Counter Failed"] = {
            SoundId = 18384471502,
            Volume = 1
        },
        ["Blind SFX"] = {
            SoundId = 18382394999,
            Volume = 1
        },
        ["Blind Voiceline"] = {
            SoundId = 18303451034,
            Volume = 1
        },
        ["Eisidisi Summon Voiceline"] = {
            SoundId = 18303449452,
            Volume = 1
        },
        ["Eisidisi Leap Voiceline"] = {
            SoundId = 18382587871,
            Volume = 1
        },
        ["Eisidisi Leap SFX"] = {
            SoundId = 18382394653,
            Volume = 1
        },
        ["Eisidisi Leap Slam"] = {
            SoundId = 18382394305,
            Volume = 1
        },
        ["Eisidisi Dash Voiceline"] = {
            SoundId = 18382587871,
            Volume = 1
        },
        ["Eisidisi Dash SFX"] = {
            SoundId = 18382395316,
            Volume = 1
        },
        ["Pose Pillarmen Reveal"] = {
            SoundId = 18382391737,
            Volume = 1
        },
        ["Beatdown Attempt Voiceline"] = {
            SoundId = 18363001483,
            Volume = 1
        },
        ["Beatdown Attempt SFX"] = {
            SoundId = 18382386736,
            Volume = 1
        },
        ["Beatdown Voiceline"] = {
            SoundId = 18363000882,
            Volume = 1
        },
        ["Beatdown SFX"] = {
            SoundId = 18363002029,
            Volume = 1
        }
    }
};
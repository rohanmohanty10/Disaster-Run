  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(Knit.Util.TableUtil);
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 16
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
end);

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Stats = {
        Timestop = {
            Timestop = {
                ResumeSounds = { "Timestop End SFX" },
                Callbacks = {
                    Stop = function(p3, p4) -- Line: 35, Name: Stop
                        -- upvalues: u2 (ref), u1 (ref)
                        local v5 = p3.Character.Humanoid.Health <= p3.Character.Humanoid.MaxHealth / 3;
                        p3.Character:SetAttribute("StoppedWithLow", v5);
                        u2.FireAllClients("PlaySoundGlobal", u1.GetSound(p3.Character, "Timestop Ambience" .. (v5 and " (Low)" or "")), { p3.Player }, p4.Time * 3);
                    end,

                    Resume = function(p6, p7) -- Line: 40, Name: Resume
                        -- upvalues: u1 (ref)
                        u1.PlaySound(p6.Character, "Timestop End Voiceline" .. (p6.Character:GetAttribute("StoppedWithLow") and " (Low)" or "(Base)"));
                        p6.Character:SetAttribute("StoppedWithLow", nil);
                    end
                }
            }
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 120627367730129,
            Volume = 3
        },
        ["Desummon-Voiceline"] = {
            SoundId = 138969138855112,
            Volume = 3
        },
        ThrowVoiceline = {
            SoundId = "",
            Volume = 0
        },
        BarrageVoiceline = {
            SoundId = 133532362759426,
            Volume = 3
        },
        ["Star Finger Voiceline"] = {
            SoundId = 101471411004394,
            Volume = 3
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 125113674600523,
            Volume = 3
        },
        ["Inhale Voiceline"] = {
            SoundId = 96882276837953,
            Volume = 3
        },
        ["Ora Slam Voiceline"] = {
            SoundId = 90786658038434,
            Volume = 3
        },
        LockKickVoice = {
            SoundId = 82250524677956,
            Volume = 3
        },
        ClashVoiceline = {
            SoundId = "",
            Volume = 0
        },
        BeatdownAttempt = {
            SoundId = 13394932725,
            Volume = 2
        },
        ["BeatdownAttempt-Voiceline"] = {
            SoundId = 91633630113396,
            Volume = 3
        },
        Beatdown = {
            SoundId = 119146938431511,
            Volume = 4.25
        },
        ["Beatdown-Voiceline"] = {
            SoundId = 94280111740549,
            Volume = 3.25
        },
        ["Beatdown-Music"] = {
            SoundId = 75503964175890,
            Volume = 2
        },
        ["Brute Force Voiceline"] = {
            SoundId = 136596371886728,
            Volume = 3
        },
        ["Brute Force Grab Voiceline"] = {
            SoundId = 130716726917599,
            Volume = 3
        },
        GramSlamVoice = {
            SoundId = 138128414748946,
            Volume = 3
        },
        GrabSlamVoicelineHit = {
            SoundId = 135027150202869,
            Volume = 3
        },
        MeterUp2 = {
            SoundId = 82624429099414,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = "",
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 116888055349869,
            Volume = 2
        },
        ["Death-Voiceline"] = {
            SoundId = "",
            Volume = 0
        },
        ["Timestop Voiceline"] = {
            SoundId = 114540435651638,
            Volume = 3
        },
        ["Timestop Voiceline (Low)"] = {
            SoundId = 106261108905025,
            Volume = 3
        },
        ["Timestop End Voiceline"] = {
            SoundId = "",
            Volume = 0
        },
        ["Timestop End Voiceline (Base)"] = {
            SoundId = 136817415371701,
            Volume = 3
        },
        ["Timestop End Voiceline (Low)"] = {
            SoundId = 109498803680854,
            Volume = 3
        },
        ["Timestop Ambience"] = {
            SoundId = 106617541850577,
            Volume = 2
        },
        ["Timestop Ambience (Low)"] = {
            SoundId = 130075467778535,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = "",
            Volume = 0
        },
        ["LMB-2"] = {
            SoundId = "",
            Volume = 0
        },
        ["LMB-3"] = {
            SoundId = "",
            Volume = 0
        },
        ["LMB-4"] = {
            SoundId = "",
            Volume = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "",
            Volume = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "",
            Volume = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "",
            Volume = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "",
            Volume = 0
        },
        ["Evil Spirit Voiceline"] = {
            SoundId = 117483071601265,
            Volume = 3
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
                    SoundId = 120727356494962,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Answer this: will I hit you with my right fist or decide to deck you with my left? I\'d love to know...",
                            ScaleTime = 3.85
                        } }
                },
                {
                    SoundId = 99988177057299,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No! No! No! No! No!",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = 71972775472990,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Yes! Yes! Yes! Yes! YES!!!",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = 113008698964725,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You have got to be kidding!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 138306231417085,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I have a question for you: who\'s the leading actress in tarzan the ape man?",
                            ScaleTime = 2.5
                        } }
                },
                {
                    SoundId = 119083810067032,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    YieldTime = 20,
                    FullQuote = { {
                            Quote = "Look, no one ever said Jotaro Kujo was a nice guy. I\'ve had idiot teachers that like to talk big, so I taught them a lesson, and they never came back to class. If I go to a resturant a the food\'s bad, I make it a policy to stiff em\' with the bill.",
                            ScaleTime = 8
                        } }
                },
                {
                    SoundId = 74004082354747,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t say I didn\'t warn you!",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 78491784684540,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "We\'ve got unfinished business...",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 89395571915986,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Good freakin\' grief kid.",
                            ScaleTime = 0.9
                        } }
                },
                {
                    SoundId = 94151887517713,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "That was a close call...",
                            ScaleTime = 1
                        } }
                },
                {
                    SoundId = 73404057830601,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What you owe me... could never be paid back with money!",
                            ScaleTime = 2
                        } }
                },
                {
                    SoundId = 130761863824034,
                    SoundVolume = 3,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "And where do you think you\'re going?",
                            ScaleTime = 1
                        } }
                }
            }
        }
    }
};
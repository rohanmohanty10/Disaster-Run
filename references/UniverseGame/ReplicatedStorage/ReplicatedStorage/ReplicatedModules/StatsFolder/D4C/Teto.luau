  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local u1;

if game:GetService("RunService"):IsServer() then
    AbilityModule = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild(script.Parent.Name, true);
    u1 = require(AbilityModule.Common);
else
    u1 = nil;
end;

return {
    Inherit = {
        AbilityName = "D4C"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p2) -- Line: 20, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy), u1 (ref)
                    local v3 = TableUtil.Copy(p2.Stats, true);
                    v3.PoseMusic = "PoseMusic-" .. math.random(1, 11);

                    if Knit.CollectionService:HasTag(p2.Character, "Summoned") then
                        p2.Trove:Add(u1.CreateFlag(p2.Character, {
                            MakePartP0 = true,
                            UseMotor6D = true,
                            Part = p2.Character["Left Arm"],
                            Offset = CFrame.new(0, -3.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
                        }));
                        v3.StartAnim = "StandPoseTransition";
                        v3.LoopAnim = "StandPoseIdle";
                    end;

                    return v3;
                end
            }
        }
    },
    Sounds = {
        ["Summon-Voiceline"] = {
            SoundId = 134057222963655,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 118732828328597,
            Volume = 1
        },
        MeterUp4 = {
            SoundId = 90687226535428,
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = 138188632779358,
            Volume = 2
        },
        ["StandOff-LMB-1-Voiceline"] = {
            SoundId = 131240242362907,
            Volume = 2
        },
        ["StandOff-LMB-2-Voiceline"] = {
            SoundId = 139897098013241,
            Volume = 2
        },
        ["StandOff-LMB-3-Voiceline"] = {
            SoundId = 113600599641017,
            Volume = 2
        },
        ["StandOff-LMB-4-Voiceline"] = {
            SoundId = 99056356650560,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 131240242362907,
            Volume = 2
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 139897098013241,
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 113600599641017,
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 99056356650560,
            Volume = 2
        },
        ["Powered Slice Voiceline"] = {
            SoundId = 75745804613528,
            Volume = 2
        },
        ["Violent Storm Voiceline"] = {
            SoundId = 113510213385662,
            Volume = 2
        },
        ["Capital Punishment Voiceline"] = {
            SoundId = 114221661721076,
            Volume = 2
        },
        ["Capital Punishment Startup Voiceline"] = {
            SoundId = 132375750962684,
            Volume = 2
        },
        ["Swift Puncture Startup Voiceline"] = {
            SoundId = 110420376635276,
            Volume = 2
        },
        ["Killer\'s Hand Startup Voiceline"] = {
            SoundId = 117825873596429,
            Volume = 2
        },
        ["Killer\'s Hand Disappear Voiceline"] = {
            SoundId = 117831828027968,
            Volume = 2
        },
        ["Killer\'s Hand Appear"] = {
            SoundId = 106031197673925,
            Volume = 0
        },
        ["Brutal Scotch Voiceline"] = {
            SoundId = 123612099452751,
            Volume = 2
        },
        ["Brutal Scotch Startup Voiceline"] = {
            SoundId = 91878896670958,
            Volume = 2
        },
        ["Menger Sponge Voiceline"] = {
            SoundId = 121615379625668,
            Volume = 2
        },
        ["Menger Sponge Startup Voiceline"] = {
            SoundId = 93366373665702,
            Volume = 2
        },
        ["Adverse Force Voiceline"] = {
            SoundId = 89009453242790,
            Volume = 2
        },
        ["Adverse Force Startup Voiceline"] = {
            SoundId = 127148607770562,
            Volume = 2
        },
        ["Precision Disposal Voiceline"] = {
            SoundId = 106692531557769,
            Volume = 2
        },
        ["Fanfire Disposal Voiceline"] = {
            SoundId = 87319316021105,
            Volume = 2
        },
        ["Dimensional Clone Voiceline"] = {
            SoundId = 120624773264446,
            Volume = 2
        },
        ["Dimensional Shift Voiceline"] = {
            SoundId = 82211496961832,
            Volume = 2
        },
        ["Dimensional Shift End Voiceline"] = {
            SoundId = 115366170905415,
            Volume = 2
        },
        ["PoseMusic-1"] = {
            SoundId = 72343779002230,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 138435713274259,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-3"] = {
            SoundId = 131826529420214,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-4"] = {
            SoundId = 73118221520296,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-5"] = {
            SoundId = 114292611481243,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-6"] = {
            SoundId = 128181191730054,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-7"] = {
            SoundId = 102833371130056,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-8"] = {
            SoundId = 114520777986356,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-9"] = {
            SoundId = 134755193460166,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-10"] = {
            SoundId = 98945629410211,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-11"] = {
            SoundId = 130573857807778,
            Volume = 2,
            Looped = true
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
                    SoundId = "rbxassetid://121995509418106",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "CJ is the best animator on the Universe Game dev team"
                        } }
                },
                {
                    SoundId = "rbxassetid://132386040645063",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Hi sera"
                        } }
                },
                {
                    SoundId = "rbxassetid://136185655327301",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Answer me, Jia Baoyu."
                        } }
                },
                {
                    SoundId = "rbxassetid://123074514021490",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Lets combo BRUH"
                        } }
                },
                {
                    SoundId = "rbxassetid://82146448678321",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Daddy daddy do the Saiyan walk~"
                        } }
                },
                {
                    SoundId = "rbxassetid://98449173528376",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "me am nub: uhifa style, form 203: feel my Epic Flow!"
                        } }
                },
                {
                    SoundId = "rbxassetid://133986733187865",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "DYULAHAN! 🏇🏿 JUG-EUM-EULO DALLYEOGAL SHIGANIDA! ⛈️  ⛓️ ⛓️ HMMMMM! 💢 ❗ ⛓️‍💥 ⚰️ 💥 POPGUNG-GWA ⬛ ⬜ HAMKKE ⬛ ⬜ SALAJIDA!!! ⬛ ⬜ ⚡"
                        } }
                },
                {
                    SoundId = "rbxassetid://124793843917774",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "RABBIT! TANK! BEST MATCH! THE FULLMETAL MOONSAULT! RABBITTANK!"
                        } }
                },
                {
                    SoundId = "rbxassetid://84526087234345",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "A loaf of bread, a container of milk, and a stick of butter. A loaf of milk, a container of bread, and a Hatsune Miku CD. A Hatsune Miku CD, Akita Neru, and treasure from a fish tank."
                        } }
                },
                {
                    SoundId = "rbxassetid://97284538220376",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "why donhezi no roll ayabe admire vega she is best uma"
                        } }
                },
                {
                    SoundId = "rbxassetid://136307568125957",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s north; It\'s here; It\'s done!"
                        } }
                },
                {
                    SoundId = "rbxassetid://116736233361743",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Teto word of the day: chud"
                        } }
                }
            }
        }
    }
};
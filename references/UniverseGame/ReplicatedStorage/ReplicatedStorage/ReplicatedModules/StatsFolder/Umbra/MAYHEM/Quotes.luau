  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.EnumsModule);
require(Knit.Util.TableUtil);
local Players = game:GetService("Players");
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
Knit.OnStart():andThen(function() -- Line: 14
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref), u4 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);

return {
    Base = {
        {
            SoundId = "rbxassetid://134797031236710",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "WHAT... THE HELL?",
                    ScaleTime = 0.55
                } }
        },
        {
            SoundId = "rbxassetid://71383797080590",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Huh?",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://116624324533081",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Annoying...",
                    ScaleTime = 0.435
                } }
        },
        {
            SoundId = "rbxassetid://118311303290788",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You better stay down... or you won\'t get up again.",
                    ScaleTime = 1.55
                } }
        },
        {
            SoundId = "rbxassetid://82409051279880",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Whatever",
                    ScaleTime = 0.475
                } }
        },
        {
            SoundId = "rbxassetid://137321354121291",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hey.",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://113559739781428",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Tah-ha! Shut up.",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://129729544420111",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Later",
                    ScaleTime = 0.475
                } }
        },
        {
            SoundId = "rbxassetid://128592235010558",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You scared?",
                    ScaleTime = 0.6
                } }
        },
        {
            SoundId = "rbxassetid://133891288885933",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Nice try!",
                    ScaleTime = 0.6
                } }
        },
        {
            SoundId = "rbxassetid://78861680781767",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Weak!",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://123489650051629",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Seriously!?",
                    ScaleTime = 0.6
                } }
        },
        {
            SoundId = "rbxassetid://129334400650160",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Come on!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://132784330082690",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Bring it!",
                    ScaleTime = 0.625
                } }
        },
        {
            SoundId = "rbxassetid://117486844014285",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Not quite",
                    ScaleTime = 0.625
                } }
        },
        {
            SoundId = "rbxassetid://105797597897836",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You dead yet?",
                    ScaleTime = 0.725
                } }
        },
        {
            SoundId = "rbxassetid://93698068753774",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What\'s the matter?",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://88575548679377",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I ain\'t got all day",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://77966366915040",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Teh. Is that the best you got?",
                    ScaleTime = 1.05
                } }
        },
        {
            SoundId = "rbxassetid://119823005547286",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hmph. You done wasting my time yet?",
                    ScaleTime = 1.15
                } }
        },
        {
            SoundId = "rbxassetid://137160765945333",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Get lost!",
                    ScaleTime = 0.625
                } }
        }
    },
    Mayhem = {
        {
            SoundId = "rbxassetid://108017297456052",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You should\'ve stayed in bed...",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://110876854273313",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Stop crying you little punk",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://99926182670803",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Who cares?",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://139417668128580",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Go home kid.",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://108160656301187",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What a drag",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://73854580366169",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "N-No thanks!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://135276286098965",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Yah-hah! No.",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://97296802365906",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Ughhhh shut up... just- STOP TALKING",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://89668713594985",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No holding back!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://122107882078427",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Move!",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://128457974782859",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "That was easy!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://134826554268009",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Jeez...",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://118542290088851",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Not so fast!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://120935496012519",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I can handle this myself.",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://78449074274662",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Lets finish this!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://101236430651960",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Try and keep up",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://115294850896167",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Beat it.",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://77126491962372",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll devour you!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://118901103695652",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll show you fear!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://97442604564689",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "There\'s no hell; only the void.",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://82232620915121",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Sure",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://138416517523574",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Huh",
                    ScaleTime = 0.25
                } }
        },
        {
            SoundId = "rbxassetid://79491556678482",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Ugh, do whatever you want.",
                    ScaleTime = 0.75
                } }
        }
    },
    Purity = {
        {
            SoundId = "rbxassetid://121902266846904",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Is that all you have to offer?",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://109351528982041",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "How long will you keepe this up?",
                    ScaleTime = 0.9
                } }
        },
        {
            SoundId = "rbxassetid://77181466837500",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I was waiting for your confidence to curtle into hubris...",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = "rbxassetid://80709658090143",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I recommend you don\'t anger me",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://80307573005899",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Stand proud",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://100704670657961",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re no match for me",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://75262229107500",
            SoundVolume = 5.25,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You give me no choice...!",
                    ScaleTime = 0.85
                } }
        }
    },
    Corruption = {
        {
            SoundId = "rbxassetid://138247865854532",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "We are eternal",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://121623125482232",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "The AUDACITY",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://82869262724031",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "The nerve...",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://75392387514205",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Squirm...",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://83071293851694",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Scream!",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://76221842615494",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hush now",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://135962962651364",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Pitiful...",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://73692657277692",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Know true fear",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://98905266906109",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You are trying my patience!",
                    ScaleTime = 0.75
                } }
        }
    },
    Calamity = {
        {
            SoundId = "rbxassetid://91010498159961",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Slow learner...",
                    ScaleTime = 0.9
                } }
        },
        {
            SoundId = "rbxassetid://88320381223490",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What?!",
                    ScaleTime = 0.425
                } }
        },
        {
            SoundId = "rbxassetid://88948381379351",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re an odd one",
                    ScaleTime = 0.675
                } }
        },
        {
            SoundId = "rbxassetid://108820070730637",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "All power, no skill.",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://121930450702767",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Well... That was anticlimactic.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://106870309560477",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Dance. Like the clown you are.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://140514151447711",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Get lost.",
                    ScaleTime = 0.675
                } }
        },
        {
            SoundId = "rbxassetid://115157896233715",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I don\'t play nice with clowns.",
                    ScaleTime = 1
                } }
        }
    },
    Divinity = {
        {
            SoundId = "rbxassetid://72042150089249",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Gone talkin\' to a wall",
                    ScaleTime = 0.925
                } }
        },
        {
            SoundId = "rbxassetid://78663604622107",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Go talk to a wall",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://78889112733004",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Bye",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://95798013086848",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hey there",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://119200071683665",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "That was fun...",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://87578133873481",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll take you on again",
                    ScaleTime = 0.9
                } }
        },
        {
            SoundId = "rbxassetid://71333974246570",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Should I have taken it easier?",
                    ScaleTime = 0.9
                } }
        },
        {
            SoundId = "rbxassetid://74873891871567",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I don\'t care",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://112086039757440",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I need help",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://126421645318182",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No.",
                    ScaleTime = 0.35
                } }
        }
    },
    Destiny = {
        {
            SoundId = "rbxassetid://114703355615298",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Is that all?",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://74150828700999",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "gyuaha",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://81080703623718",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What?!",
                    ScaleTime = 0.425
                } }
        },
        {
            SoundId = "rbxassetid://95476444009650",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "GUYUYUUYHUHUH",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://92287185699153",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Is that all?",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://132514629148839",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I expect nothing from the likes of you",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://111823508522365",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Just stay out of my way... you obstacle.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://103504549849764",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Brother!",
                    ScaleTime = 0.5
                } }
        }
    },
    Rainbow = {
        {
            SoundId = "rbxassetid://121215212202619",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What?",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://136239580492087",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No!",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://102265288543779",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Bizzare...",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://86264991758368",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Silence",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://123853752721287",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Weakling.",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://139603903768399",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Idiocy...",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://85595551145549",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Your continued existence is a blight upon this world!",
                    ScaleTime = 1.825
                } }
        },
        {
            SoundId = "rbxassetid://101834811171423",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "This body is now more than a blade...even if a god chooses to hinder my righteous path, I shall cut him down!",
                    ScaleTime = 3.25
                } }
        },
        {
            SoundId = 127373857921756,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I tire of this pointless chatter...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 75944283800715,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You wish to justify your existence? Then show me your strength!",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = 110731748080438,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Atone for your sins!",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 86702031513202,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You lost the moment you gave into fear.",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = 87788517291731,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Words no longer carry meaning. If you wish to converse, then do so with your weapon!",
                    ScaleTime = 2.25
                } }
        },
        {
            SoundId = 122919504821923,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Your body will not soon forget the price of standing in my way!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 132172513333172,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hmph. Inept.",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 77458242253258,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll sever your thread of fate!",
                    ScaleTime = 1.35
                } }
        },
        {
            SoundId = 79771762123072,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll have your head!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 119468045503767,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Know your limits...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 126239907141278,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Your destruction at my hand is merely a matter of time...",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 124359410626352,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Very well...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 102016647504735,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Your powers are insufficient...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 73602711052405,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "The will to fight is nothing without a strong sense of self...",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = 93682423229328,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Silence, or I\'ll cut you down with the rest!",
                    ScaleTime = 1.35
                } }
        },
        {
            SoundId = 93392514920775,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Do as you will... but know if you stand in the way of justice, you will be punished!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 108841043746639,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My justice will not falter...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 138439990106689,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Withdraw at once.",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 91667894512800,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Do not mock me!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 95766907538153,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Amateur",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 123889580156368,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I am the blade that severs evil; there is no power great enough to shatter it!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 140104997848664,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You are the very essence of evil: the heart of darkness!",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 104718448687679,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Satisfied?",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 131690363290673,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "There is no meaning to justice without power...",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 114519419301677,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Foolishness!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 72013785256081,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I shall cut through any evil that stands in the path of righteousness!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 119584995047272,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "If you have something to protect, words are useless.",
                    ScaleTime = 1.75
                } }
        },
        {
            SoundId = 86320936893286,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "It is one thing to claim determination... it is another to prove it with your blade!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = 109173915541831,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I cannot ignore the evil that courses through your veins...",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = 94329241364791,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I do not wield my blade to keep people safe... I dedicate all my strength to ridding the world of evil!",
                    ScaleTime = 2.15
                } }
        },
        {
            SoundId = 109306657401007,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Should you fall to savagery, you do so at your own peril.",
                    ScaleTime = 1.65
                } }
        },
        {
            SoundId = 76666784328315,
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "This is the sword that destroys evil!",
                    ScaleTime = 1.35
                } }
        }
    },
    Omega = {
        {
            SoundId = "rbxassetid://135199582388448",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*maniacle laugh*",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://106190534412563",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Taking a nap... don\'t bother me.",
                    ScaleTime = 1.35
                } }
        },
        {
            SoundId = "rbxassetid://131662512334244",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Cook me all you want! But you can\'t eat me...",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://70901727396363",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Right to sit: DENIED!!!",
                    ScaleTime = 1.1
                } }
        },
        {
            SoundId = "rbxassetid://106462315402683",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Was that meant to hurt?",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://82884580388106",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I never knew I was so generous",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://102946450128036",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "uraghh you\'re SOFT",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://86228465361231",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "THE CLIMAX!!!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://76524403548715",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What?",
                    ScaleTime = 0.325
                } }
        }
    },
    Catastrophe = {
        {
            SoundId = "rbxassetid://73539507601647",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll cut you apart",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://112814850585087",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll skewer you",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://72849706739942",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Limb from limb...",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://94649285028596",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll tear ya to pieces",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://82689028884476",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*laughter*",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://127610956492860",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Heh, scared?",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://98989797507158",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You cannot win...",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://74781028100659",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ve barely gotten started...",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://137950638234964",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You stubborn brat!",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://96896352650888",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hah! Coward!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://128417832661261",
            SoundVolume = 9,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You insolent fool!",
                    ScaleTime = 0.85
                } }
        }
    },
    Pandora = {
        {
            SoundId = "rbxassetid://125259762518249",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "\"Wait\" you say? Do I LOOK LIKE A WAITER?",
                    ScaleTime = 1.35
                } }
        },
        {
            SoundId = "rbxassetid://136445327546288",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hello (:",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://139162072961923",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Take a hike!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://130592610964610",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Come now, kiss my boots!",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://122625078933188",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Choo-Choo~ coming through!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://125353456642749",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Don\'t hate me just because I\'m better!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://130256414703199",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*Crazed Laughter*",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://140303845326787",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Ahem...there\'s sand..on my BOOTS",
                    ScaleTime = 3.15
                } }
        }
    },
    Chaos = {
        {
            SoundId = "rbxassetid://80799500830443",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I must admit it never ceases to amaze me how brainless you can be...",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = "rbxassetid://73188526200030",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'ve lost your weapon! Why are you just standing there?",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = "rbxassetid://104355042930532",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "This thirst for power is not an unnatural desire! In fact, it forms the very essence of our being!",
                    ScaleTime = 3
                } }
        },
        {
            SoundId = "rbxassetid://139016188722003",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Deep within our body lies the whole instinct to DOMINATE and SLAUGHTER our enemies!",
                    ScaleTime = 2
                } }
        },
        {
            SoundId = "rbxassetid://77252167189530",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My friend, you don\'t have that!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://107936512790259",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "The simple matter is, it doesn\'t work! You\'re weak!",
                    ScaleTime = 1.175
                } }
        },
        {
            SoundId = "rbxassetid://86607592830879",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I won\'t put up with that.",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://80680006279011",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Am I clear?",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://73010762942177",
            SoundVolume = 6.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I refuse to play horse to a king who\'s weaker than me.",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://123744032178550",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Dammit!",
                    ScaleTime = 0.425
                } }
        },
        {
            SoundId = "rbxassetid://126147695293582",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "That\'s more like it!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://123543235159912",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Haaaaaaaaaaaahhhhh...",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = "rbxassetid://77742058982211",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re really hopeless, aren\'t you?",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://104662387429494",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What\'s wrong?",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://120491851150467",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You scared?",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://71403812063640",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Okay, you ready!?",
                    ScaleTime = 0.825
                } }
        },
        {
            SoundId = "rbxassetid://94975237261587",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What do you know...",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://130400152304493",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Let\'s get this over with.",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://123236449894300",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What\'s the matter?",
                    ScaleTime = 0.85
                } }
        }
    },
    SHD = {
        {
            SoundId = "rbxassetid://94894873554652",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Help me!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://114536840376745",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "N-No way!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = "rbxassetid://128247619993524",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Don\'t look at it!",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://107516638977965",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Phew... is that it?",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://133471215279246",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What happened?",
                    ScaleTime = 0.725
                } }
        },
        {
            SoundId = "rbxassetid://132621160950729",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Uhm...thank you very much...",
                    ScaleTime = 1.325
                } }
        }
    },
    Crazed = {
        {
            SoundId = "rbxassetid://103287157129319",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Bed time already? WAKE UP!!!",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://127517561607487",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*whistles*",
                    ScaleTime = 0.45
                } }
        },
        {
            SoundId = "rbxassetid://126134260959780",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Shut up, just shut up!",
                    ScaleTime = 0.725
                } }
        },
        {
            SoundId = "rbxassetid://115671979999014",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "The hell\'s wrong with you?",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://123916085515520",
            SoundVolume = 5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Like I care!",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = "rbxassetid://131738860731969",
            SoundVolume = 5.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Maybe YOU should be my next play-thing...",
                    ScaleTime = 0.925
                } }
        },
        {
            SoundId = "rbxassetid://100454361101377",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "As long as I\'m wreaking havoc, I don\'t care how much blood I lose",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = "rbxassetid://139705514430684",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "woAhahoah!!",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = "rbxassetid://122045450496479",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*condescending laughter*",
                    ScaleTime = 0.5
                } }
        }
    },
    FallenX = {
        {
            SoundId = "rbxassetid://131010472867416",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You have much to learn",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://133719604749416",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No wall is too high",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = "rbxassetid://122405407739317",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Forgive me, I was mistaken...",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://87450474094161",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Hey it\'s free! What an offer!",
                    ScaleTime = 0.925
                } }
        },
        {
            SoundId = "rbxassetid://76199617222931",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I shall put them in a corner!",
                    ScaleTime = 0.85
                } }
        },
        {
            SoundId = "rbxassetid://113478791357724",
            SoundVolume = 3,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Drink DEEP from the cup of defeat...",
                    ScaleTime = 1
                } }
        }
    },
    Equinox = {
        {
            SoundId = "rbxassetid://95433518483071",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "For those that live too long, the friends of days gone by and scenes from their adventures live on in their memories. As such I have no regrets in meeting you, friend. Should the day ever come that we are not together, you will continue to shine like gold in my memories.",
                    ScaleTime = 20
                } }
        },
        {
            SoundId = "rbxassetid://95059042608523",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Why is it that once you finally get a break, rather than taking a rest, you instead come to me?",
                    ScaleTime = 5
                } }
        },
        {
            SoundId = "rbxassetid://108230187665833",
            SoundVolume = 3.5,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Ahem",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = "rbxassetid://88053095313946",
            SoundVolume = 4,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Every journey has its final day. Don\'t rush.",
                    ScaleTime = 1.5
                } }
        },
        {
            SoundId = "rbxassetid://122495813736336",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Not unlike the ocean tides, so too shall the movement of people ebb and flow. From turmoil to peace, enlightenment to apsiration - human society possesses limitless potential.",
                    ScaleTime = 10
                } }
        },
        {
            SoundId = "rbxassetid://91921584676959",
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Agh-",
                    ScaleTime = 0.325
                } }
        },
        {
            SoundId = "rbxassetid://86123154457410",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'ve brought a smile to my face",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = "rbxassetid://138253305939992",
            SoundVolume = 7,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "When all is said and done, a reunion between friends is an aspicious occasion.",
                    ScaleTime = 4
                } }
        },
        {
            SoundId = "rbxassetid://107557449756897",
            SoundVolume = 8,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re leaving..?",
                    ScaleTime = 0.75
                } }
        }
    },
    Love = {
        {
            SoundId = 79521520527106,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Everything that I am... is yours to take!",
                    ScaleTime = 1.25
                } }
        },
        {
            SoundId = 121593556269779,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You shall see... my undying devotion!",
                    ScaleTime = 1.15
                } }
        },
        {
            SoundId = 123354877350063,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Oh how my heart yearns!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 121649918091325,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*giggle*",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 139134220334349,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*giggle* my, what a lovely opponent.",
                    ScaleTime = 0.9
                } }
        },
        {
            SoundId = 105688455068461,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I am yours forever more!",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 107014308529834,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My darling!",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 111006291533148,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I dream... only of you!",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 73401220955502,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll get you...",
                    ScaleTime = 0.8
                } }
        },
        {
            SoundId = 77794218459034,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Do you feel my love?",
                    ScaleTime = 0.825
                } }
        },
        {
            SoundId = 107635067930106,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "*crazed laughter*",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 94960006382692,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My heart stirs",
                    ScaleTime = 0.65
                } }
        },
        {
            SoundId = 99846999926714,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My hear stutters, RACES, at even the mere sound of your breathing... I can\'t think of anything happier than the moments we share... ugh! If this is a dream, I wish never to wake!",
                    ScaleTime = 5
                } }
        },
        {
            SoundId = 106286877848090,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Your love burns me through",
                    ScaleTime = 0.75
                } }
        },
        {
            SoundId = 72821862670668,
            SoundVolume = 6,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "My heart, how it throbs!",
                    ScaleTime = 0.75
                } }
        }
    },
    Boing = { {
            SoundId = 87979341111099,
            SoundVolume = 10,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I need a brave man to come and help me...",
                    ScaleTime = 1.275
                } }
        }, {
            SoundId = 106771237761623,
            SoundVolume = 10,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Take me out to dinner first.. boy...",
                    ScaleTime = 1.325
                } }
        } },
    Neptunian = {
        {
            SoundId = "",
            SoundVolume = 0,
            YieldSound = false,
            Visible = true,
            HideQuote = true,
            FullQuote = { {
                    Quote = "*Holster*",
                    ScaleTime = 0
                } },

            Callback = function(p5) -- Line: 2714, Name: Callback
                -- upvalues: Players (copy), u3 (ref), u4 (ref), Trove (copy), u1 (ref), u2 (ref)
                local Metadata = p5.Metadata;
                local _ = p5.Quote;
                local Character = Metadata.Character;
                local u6 = Metadata.Player or Players:GetPlayerFromCharacter(Character);
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                if Character:GetAttribute("MoveActive") or Character:GetAttribute("EquippingNep") then
                    return;
                end;

                local u7 = u3:GetContainer(Character);
                local u8 = u4.Get(Character.Humanoid.Animator);

                if Character:GetAttribute("NeptunianEquipped") then
                    Character:SetAttribute("NeptunianEquipped", nil);

                    return;
                end;

                Character:SetAttribute("EquippingNep", true);
                local u9 = Trove.new();
                u9:AttachToInstance(Character);
                u1.SetActive(Character, "Neptunian Equip", {
                    Priority = u1.Enums.Active.Main
                });
                u9:Add(function() -- Line: 2737
                    -- upvalues: Character (copy), u1 (ref)
                    if not Character then
                        return;
                    end;

                    Character:SetAttribute("EquippingNep", nil);
                    u1.SetActive(Character, "Neptunian Equip", nil);
                end);
                local v13 = u9:Construct(u1.CreateSequence, Character, {
                    Name = "Neptunian Equip",
                    Speed = 1,
                    SequenceV3 = true,
                    Frames = {
                        { 0, function(p10) -- Line: 2748
                                -- upvalues: u2 (ref), u6 (copy), Character (copy), HumanoidRootPart (copy), u8 (copy), u9 (copy), u3 (ref), u7 (copy)
                                u2.FireAllClients("Emit Particle V3", {
                                    Path = "Effects/Neptunian_Equip",
                                    AbilityName = "Umbra",
                                    SkinName = "MAYHEM_Assets",
                                    IgnoreUnusuals = true,
                                    IgnoreSkinShift = true,
                                    Player = u6,
                                    Character = Character,
                                    Origin = HumanoidRootPart.CFrame,
                                    AttachTo = {
                                        Part = HumanoidRootPart
                                    }
                                });
                                u8:PlayAnimation("Neptunian Equip", p10:GetSpeed());
                                u9:Add(u3:Add(u7, "MaxWalkSpeed", 6));
                                u9:Add(u3:Add(u7, "MaxJumpPower", 0));
                            end },
                        { 14, function(p11) -- Line: 2769
                                -- upvalues: Character (copy)
                                Character:SetAttribute("NeptunianEquipped", true);
                            end },
                        { 58, function(p12) -- Line: 2772
                                -- upvalues: u2 (ref), u6 (copy), Character (copy), HumanoidRootPart (copy)
                                u2.FireAllClients("Emit Particle V3", {
                                    Path = "Effects/Neptunian_Equip_Slash",
                                    AbilityName = "Umbra",
                                    SkinName = "MAYHEM_Assets",
                                    IgnoreUnusuals = true,
                                    IgnoreSkinShift = true,
                                    Player = u6,
                                    Character = Character,
                                    Origin = HumanoidRootPart.CFrame,
                                    AttachTo = {
                                        Part = HumanoidRootPart,
                                        Offset = CFrame.Angles(0, 0, -0.2617993877991494):Inverse()
                                    }
                                });
                            end },
                        { 110, "End" }
                    }
                });

                function v13.GetSpeed(p14) -- Line: 2793
                    return 1;
                end;

                v13:Play();
                task.delay(1.85, function() -- Line: 2805
                    -- upvalues: Character (copy), u9 (copy)
                    if not Character then
                        return;
                    end;

                    u9:Destroy();
                end);
            end
        },
        {
            SoundId = 113513380711214,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Vanish.",
                    ScaleTime = 0.5
                } }
        },
        {
            SoundId = 133738049141328,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "What is life? But a fleeting glimmer.",
                    ScaleTime = 1.1
                } }
        },
        {
            SoundId = 134416688810679,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No spear can\'t strike me down.",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 135007595935568,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "You\'re strong, but not strong enough.",
                    ScaleTime = 1
                } }
        },
        {
            SoundId = 119809157463601,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "If it\'s a duel that you want, you\'ll have it, brace yourself! ",
                    ScaleTime = 1.2
                } }
        },
        {
            SoundId = 81681148659145,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "Fall to my blade.",
                    ScaleTime = 1.275
                } }
        },
        {
            SoundId = 82705205470741,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "No.",
                    ScaleTime = 0.35
                } }
        },
        {
            SoundId = 82202405273564,
            SoundVolume = 4.55,
            YieldSound = true,
            Visible = true,
            FullQuote = { {
                    Quote = "I\'ll reach the top, I swear!",
                    ScaleTime = 1.275
                } }
        }
    }
};
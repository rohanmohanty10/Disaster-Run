 
 

return {
    Phantom = {
        {
            Name = "Phantom",
            BallName = "Phantom Drive",
            RequiresBall = "Both",
            Ability = script.Phantom.Misdirection
        },
        {
            Name = "Bullet Pass",
            RequiresBall = true,
            Ability = script.Phantom.IgnitePass
        },
        {
            Name = "Phantom Oop",
            RequiresBall = true,
            Ability = script.Phantom.PhantomOop
        }
    },
    Star = {
        {
            Name = "Sky Leap",
            BallName = "Super Dunk",
            RequiresBall = "Both",
            Ability = script.Star.SkyLeap
        },
        {
            Name = "Sprint",
            BallName = "Drive",
            AwakeningName = "Star Drive",
            RequiresBall = "Both",
            Ability = script.Star.Sprint
        },
        {
            Name = "Self-oop",
            RequiresBall = true,
            Ability = script.Star.Selfoop
        },
        {
            Name = "Meteor Strike",
            RequiresBall = true,
            Ability = script.Star.MeteorStrike
        }
    },
    Sniper = {
        {
            Name = "Perfect Arc",
            RequiresBall = true,
            Ability = script.Sniper.PerfectArc
        },
        {
            Name = "Quick Release",
            RequiresBall = "Both",
            Jump = "Both",
            Ability = script.Sniper.QuickRelease
        },
        {
            Name = "Full Court",
            RequiresBall = true,
            Ability = script.Sniper.FullCourt
        }
    },
    Clutch = {
        {
            Name = "Jump Stop",
            RequiresBall = true,
            Ability = script.Clutch.JumpStop
        },
        {
            Name = "Pressure Defense",
            RequiresBall = false,
            Jump = true,
            Steal = true,
            Ability = script.Clutch.PressureDefense
        },
        {
            Name = "Clutch 3",
            RequiresBall = "Both",
            Ability = script.Clutch.Clutch
        }
    },
    Ace = {
        {
            Name = "Instinct Dash",
            BallName = "Athletic Drive",
            RequiresBall = "Both",
            Ability = script.Ace.FormlessDrive
        },
        {
            Name = "Athletic Fade",
            AwakeningName = "Too Easy",
            RequiresBall = true,
            Ability = script.Ace.FormlessFade
        },
        {
            Name = "Missile",
            RequiresBall = true,
            Ability = script.Ace.Missile
        },
        {
            Name = "100% Drive",
            RequiresBall = true,
            Ability = script.Ace.Drive100
        }
    },
    Giant = {
        {
            Name = "Post-Form",
            RequiresBall = true,
            Multi = true,
            Ability = script.Giant.PostForm
        },
        {
            Name = "Snatch Block",
            BallName = "Charge",
            RequiresBall = "Both",
            Jump = true,
            Ability = script.Giant.SnatchBlock
        },
        {
            Name = "Nothing Against Me.",
            RequiresBall = true,
            Ability = script.Giant.Nothing
        },
        {
            Name = "Contact Dunk",
            RequiresBall = true,
            Ability = script.Giant.ContactDunk
        }
    },
    Flash = {
        {
            Name = "Dash",
            RequiresBall = "Both",
            Ability = script.Flash.DashFlash
        },
        {
            Name = "Quickstep Drive",
            RequiresBall = true,
            Ability = script.Flash.Quickstep
        },
        {
            Name = "I\'ve Already Won.",
            RequiresBall = false,
            Ability = script.Flash.AlreadyWon
        }
    },
    Playmaker = {
        {
            Name = "Nutmeg",
            RequiresBall = true,
            Ability = script.Playmaker.Nutmeg
        },
        {
            Name = "Alley Oop",
            RequiresBall = true,
            Ability = script.Playmaker.AlleyOop
        },
        {
            Name = "Push Off",
            RequiresBall = true,
            Ability = script.Playmaker.Pushoff
        }
    },
    Jackpot = {
        {
            Name = "Lucky Bounce",
            RequiresBall = true,
            Multi = true,
            Ability = script.Jackpot.LuckyBounce
        },
        {
            Name = "Jackpot Steal",
            RequiresBall = "Both",
            Multi = true,
            Steal = true,
            Ability = script.Jackpot.JackpotSteal
        },
        {
            Name = "Jackpot",
            RequiresBall = false,
            Ability = script.Jackpot.Jackpot
        },
        {
            Name = "Loaded Dice",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Jackpot.LoadedDice
        }
    },
    Chuck = {
        {
            Name = "Heat Check",
            RequiresBall = true,
            Ability = script.Chuck.HeatCheck
        },
        {
            Name = "Dribble King",
            RequiresBall = true,
            Ability = script.Chuck.DribbleKing
        },
        {
            Name = "Let Me Cook",
            RequiresBall = true,
            Ability = script.Chuck.LetMeCook
        }
    },
    Lock = {
        {
            Name = "Intercept",
            RequiresBall = false,
            Multi = true,
            Ability = script.Lock.Intercept
        },
        {
            Name = "Hands Up",
            RequiresBall = false,
            Ability = script.Lock.HandsUp
        },
        {
            Name = "Clamps",
            RequiresBall = false,
            Ability = script.Lock.Clamps
        }
    },
    Copycat = {
        {
            Name = "Copy",
            RequiresBall = "Both",
            Ability = script.Copycat.Copy
        },
        {
            Name = "Flowstep",
            RequiresBall = true,
            Ability = script.Copycat.Flowstep
        },
        {
            Name = "Copy Chain",
            RequiresBall = true,
            Ability = script.Copycat.CopyChain
        },
        {
            Name = "100% Copy",
            RequiresBall = "Both",
            Ability = script.Copycat.FullCopy
        }
    },
    Perfection = {
        {
            Name = "Perfect Dribbling",
            RequiresBall = true,
            Multi = true,
            Ability = script.Perfection.PerfectDribbling
        },
        {
            Name = "Blink",
            BallName = "Perfect Dunk",
            RequiresBall = "Both",
            Ability = script.Perfection.Blink
        },
        {
            Name = "Perfect Play",
            RequiresBall = true,
            Ability = script.Perfection.PerfectPlay
        },
        {
            Name = "Evolution",
            RequiresBall = true,
            Ability = script.Perfection.Evolution
        }
    },
    Emperor = {
        {
            Name = "Emperor\'s Dribble",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Emperor.EmperorDribble
        },
        {
            Name = "Emperor\'s Reach",
            BallName = "Ultimate Pass",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Emperor.UltimatePass
        },
        {
            Name = "Emperor.",
            RequiresBall = true,
            Ability = script.Emperor.Emperor
        },
        {
            Name = "Emperor\'s Defense",
            RequiresBall = "Both",
            Ability = script.Emperor.EmperorsDefense
        }
    },
    BasketballGod = {
        {
            Name = "Reverse Dunk",
            RequiresBall = true,
            Ability = script.BasketballGod.ReverseDunk
        },
        {
            Name = "Shammgod",
            RequiresBall = true,
            Ability = script.BasketballGod.Shammgod
        },
        {
            Name = "Gods\'s 3",
            RequiresBall = true,
            Ability = script.BasketballGod.Gods3
        },
        {
            Name = "Dunk Over Heaven",
            RequiresBall = true,
            Ability = script.BasketballGod.DunkOverHeaven
        }
    },
    Quick = {
        {
            Name = "Dash",
            RequiresBall = false,
            Jump = true,
            Ability = script.Quick.Dash
        },
        {
            Name = "Boost",
            RequiresBall = "Both",
            Jump = "Both",
            Shooting = true,
            Ability = script.Quick.Boost
        },
        {
            Name = "SPEED.",
            RequiresBall = false,
            Ability = script.Quick.Speed
        }
    },
    Fetch = {
        {
            Name = "Dive",
            RequiresBall = false,
            Multi = true,
            Ability = script.Fetch.Dive
        },
        {
            Name = "Floater",
            RequiresBall = true,
            Jump = "Ball",
            Ability = script.Fetch.Floater
        },
        {
            Name = "Catch.",
            RequiresBall = false,
            Ability = script.Fetch.Catch
        }
    },
    Gold = {
        {
            Name = "Street Dribble",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Gold.StreetDribble
        },
        {
            Name = "Pressure",
            BallName = "Needle Pass",
            AwakeningName = "Golden Eye",
            RequiresBall = "Both",
            Multi = true,
            Steal = true,
            Ability = script.Gold.NeedlePass
        },
        {
            Name = "I\'m Better.",
            RequiresBall = true,
            Ability = script.Gold.ImBetter
        },
        {
            Name = "Chain Handles",
            RequiresBall = true,
            Ability = script.Gold.ChainHandles
        }
    },
    Tatlis = {
        {
            Name = "Snap.",
            RequiresBall = true,
            Ability = script.Tatlis.Snap
        },
        {
            Name = "Colored Strike",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Tatlis["Colored Strike"]
        },
        {
            Name = "YOU\'RE MINE.",
            RequiresBall = "Both",
            Ability = script.Tatlis.YoureMine
        },
        {
            Name = "NO WHERE TO GO",
            RequiresBall = "Both",
            Ability = script.Tatlis["NO WHERE TO GO"]
        }
    },
    Chrollo = {
        {
            Name = "Creator\'s Dribble",
            RequiresBall = true,
            Multi = true,
            Ability = script.Chrollo.CreatorsDribble
        },
        {
            BallName = "GREEN!",
            Name = "Pass!",
            RequiresBall = "Both",
            Ability = script.Chrollo.Green
        },
        {
            Name = "Chaos.",
            RequiresBall = false,
            Ability = script.Chrollo.Chaos
        },
        {
            Name = "Not my reality.",
            RequiresBall = false,
            Ability = script.Chrollo.NotMyReality
        }
    },
    LazyWorker = {
        {
            Name = "Trap",
            RequiresBall = false,
            Jump = true,
            Ability = script.LazyWorker.Trap
        },
        {
            Name = "Catch me",
            RequiresBall = true,
            Ability = script.LazyWorker.Ability2
        },
        {
            Name = "I\'ll be in the next game.",
            RequiresBall = false,
            Ability = script.LazyWorker.AwakenAbility1
        },
        {
            Name = "Cook",
            RequiresBall = false,
            Ability = script.LazyWorker.Cook
        }
    },
    UncleSam = {
        {
            Name = "Declaration",
            RequiresBall = true,
            Ability = script.UncleSam.Declaration
        },
        {
            Name = "Cannon Pass",
            RequiresBall = true,
            Ability = script.UncleSam.CannonPass
        },
        {
            Name = "Freedom!",
            RequiresBall = false,
            Ability = script.UncleSam.Freedom
        }
    },
    Switcher = {
        {
            Name = "Cursed Dash",
            RequiresBall = "Both",
            Ability = script.Switcher.CursedDash
        },
        {
            Name = "Switch",
            RequiresBall = "Both",
            Jump = true,
            Ability = script.Switcher.Switch
        },
        {
            Name = "Imagination",
            RequiresBall = true,
            Ability = script.Switcher.Imagination
        },
        {
            Name = "Brothers",
            RequiresBall = true,
            Ability = script.Switcher.Brothers
        }
    },
    Cyber = {
        {
            Name = "Implant",
            RequiresBall = "Both",
            Ability = script.Cyber.Implant
        },
        {
            Name = "Mine",
            BallName = "Try Me",
            RequiresBall = "Both",
            Ability = script.Cyber.TryMe
        },
        {
            Name = "Hyperthought",
            RequiresBall = "Both",
            Ability = script.Cyber.Hyperthought
        },
        {
            Name = "The Moon.",
            RequiresBall = false,
            Ability = script.Cyber.TheMoon
        }
    },
    OGCyber = {
        {
            Name = "Implant",
            RequiresBall = "Both",
            Ability = script.OGCyber.Implant
        },
        {
            Name = "Mine",
            BallName = "Try Me",
            RequiresBall = "Both",
            Ability = script.OGCyber.TryMe
        },
        {
            Name = "Hyperthought",
            RequiresBall = "Both",
            Ability = script.OGCyber.Hyperthought
        },
        {
            Name = "The Moon.",
            RequiresBall = false,
            Ability = script.OGCyber.TheMoon
        }
    },
    Psychic = {
        {
            Name = "Teleport",
            BallName = "Ordinary Shot",
            RequiresBall = "Both",
            Ability = script.Psychic.OrdinaryShot
        },
        {
            Name = "Confusion",
            BallName = "Teleport Pass",
            RequiresBall = "Both",
            Ability = script.Psychic.Confusion
        },
        {
            Name = "True Power",
            RequiresBall = false,
            Ability = script.Psychic.TruePower
        },
        {
            Name = "Psychic Blitz",
            BallName = "Self Pass",
            RequiresBall = "Both",
            Ability = script.Psychic.SelfPass
        }
    },
    Rubberman = {
        {
            Name = "Gear Switch",
            RequiresBall = "Both",
            Ability = script.Rubberman.GearSwitch
        },
        {
            Name = "Gum Block",
            RequiresBall = "Both",
            Ability = script.Rubberman.Ability2
        },
        {
            Name = "Gum Slap",
            AwakeningName = "DRUMS OF BASKETBALL",
            RequiresBall = "Both",
            Ability = script.Rubberman.Ability3
        },
        {
            Name = "Liberation Dribble",
            RequiresBall = true,
            Ability = script.Rubberman.LiberationDribble
        }
    },
    Spider = {
        {
            Name = "Shot Sense",
            BallName = "Roll Away",
            RequiresBall = "Both",
            Ability = script.Spider.Leap
        },
        {
            Name = "Teamwork",
            BallName = "Say Hi",
            RequiresBall = "Both",
            Ability = script.Spider.SayHi
        },
        {
            Name = "Catch",
            RequiresBall = false,
            Ability = script.Spider.Catch
        },
        {
            Name = "Senses",
            RequiresBall = "Both",
            Ability = script.Spider.Senses
        }
    },
    Symbiote = {
        {
            Name = "Tendril Snatch",
            BallName = "Tendril Dribble",
            RequiresBall = "Both",
            Ability = script.Symbiote.TendrilSnatch
        },
        {
            Name = "Tendril Pull",
            BallName = "Tendril Evade",
            RequiresBall = "Both",
            Ability = script.Symbiote.TendrilEvade
        },
        {
            Name = "RAHHHHH",
            RequiresBall = true,
            Ability = script.Symbiote.RAHHHHH
        },
        {
            Name = "Tendril Swing",
            BallName = "Parasite",
            RequiresBall = "Both",
            Ability = script.Symbiote.Parasite
        }
    },
    Vampire = {
        {
            Name = "Time Skip Dash",
            BallName = "Time Skip Dribble",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Vampire.TimeSkipDribble
        },
        {
            Name = "Freeze",
            BallName = "Freeze",
            RequiresBall = true,
            Ability = script.Vampire.Freeze
        },
        {
            Name = "Time Stop",
            RequiresBall = true,
            Ability = script.Vampire.TimeStop
        },
        {
            Name = "Steam Roller",
            RequiresBall = false,
            Ability = script.Vampire.SteamRoller
        }
    },
    Referee = {
        {
            Name = "Foul",
            BallName = "Book Dunk",
            RequiresBall = "Both",
            Ability = script.Referee.Foul
        },
        {
            Name = "Bench",
            RequiresBall = true,
            Ability = script.Referee.Bench
        },
        {
            Name = "3-Step Shot",
            RequiresBall = true,
            Ability = script.Referee.ThreeStepShot
        },
        {
            Name = "You Ladies Alright?",
            RequiresBall = true,
            Ability = script.Referee.YouLadiesAlright
        }
    },
    BasketballUnc = {
        {
            Name = "Cane Effect",
            RequiresBall = "Both",
            Ability = script.BasketballUnc.CaneEffect
        },
        {
            Name = "Wheelchair Dash",
            BallName = "Unc Relay",
            RequiresBall = "Both",
            Ability = script.BasketballUnc.WheelchairDash
        },
        {
            Name = "Still Got It In Me",
            RequiresBall = true,
            Ability = script.BasketballUnc.StillGotItInMe
        },
        {
            Name = "Unc Block",
            RequiresBall = false,
            Ability = script.BasketballUnc.UncBlock
        }
    },
    Joker = {
        {
            Name = "Wild Card",
            BallName = "Smoke Trick",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Joker.WildCard
        },
        {
            Name = "Laugh Breaker",
            RequiresBall = true,
            Ability = script.Joker.LaughBreaker
        },
        {
            Name = "DUCKY",
            RequiresBall = true,
            Ability = script.Joker.DUCKY
        },
        {
            Name = "Trick Mirror",
            RequiresBall = true,
            Ability = script.Joker.TrickMirror
        }
    },
    Ghost = {
        {
            Name = "From the Dead",
            BallName = "Fear Aura",
            RequiresBall = "Both",
            Jump = "Both",
            Shooting = true,
            Ability = script.Ghost.CutTheLights
        },
        {
            Name = "Out Of Body",
            RequiresBall = true,
            Multi = true,
            Ability = script.Ghost.OutOfBody
        },
        {
            Name = "Incoming Call",
            RequiresBall = false,
            Ability = script.Ghost.IncomingCall
        },
        {
            Name = "Phantom Twin",
            RequiresBall = true,
            Ability = script.Ghost.PhantomTwin
        }
    },
    Silver = {
        {
            Name = "Skyhand",
            BallName = "Silver Push",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Silver.Skyhand
        },
        {
            Name = "Dirty Shove",
            BallName = "Titan Smash",
            RequiresBall = "Both",
            Ability = script.Silver.DirtyShove
        },
        {
            Name = "Silver Posterizer",
            RequiresBall = true,
            Ability = script.Silver.SilverPosterizer
        },
        {
            Name = "Earthshaker",
            BallName = "Monster Ascend",
            RequiresBall = "Both",
            Holdable = "NoBall",
            Ability = script.Silver.Earthshaker
        }
    },
    Popstar = {
        {
            Name = "Flip Dunk",
            RequiresBall = true,
            Ability = script.Popstar.FlipDunk
        },
        {
            Name = "Soul Strings",
            BallName = "Music Fling",
            RequiresBall = "Both",
            Ability = script.Popstar.SoulStrings
        },
        {
            Name = "Beam",
            RequiresBall = false,
            Ability = script.Popstar.Beam
        },
        {
            Name = "Guitar Slam",
            RequiresBall = "Both",
            Ability = script.Popstar.GuitarSlam
        }
    },
    King = {
        {
            Name = "Flop",
            BallName = "No Look Pass",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.King.Flop
        },
        {
            Name = "Self Alley",
            RequiresBall = true,
            Ability = script.King.SelfAlley
        },
        {
            Name = "King\'s Block",
            RequiresBall = false,
            Ability = script.King.KingBlock
        },
        {
            Name = "Turnover",
            RequiresBall = false,
            Ability = script.King.Turnover
        }
    },
    Air = {
        {
            Name = "Fadeaway",
            RequiresBall = true,
            Ability = script.Air.Fadeaway
        },
        {
            Name = "Air Freeze",
            BallName = "Air Dribble",
            RequiresBall = "Both",
            Ability = script.Air.AirFreeze
        },
        {
            Name = "Trophy",
            RequiresBall = false,
            Ability = script.Air.Trophy
        },
        {
            Name = "Flying Dunk",
            RequiresBall = true,
            Ability = script.Air.FlyingDunk
        }
    },
    Eclipse = {
        {
            Name = "Sky Katana",
            RequiresBall = true,
            Ability = script.Eclipse.SkyKatana
        },
        {
            Name = "Blade Dash",
            BallName = "Tri-Slash",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Eclipse.BladeDash
        },
        {
            Name = "Clone Steal",
            RequiresBall = false,
            Ability = script.Eclipse.CloneSteal
        },
        {
            Name = "Spirit Shot",
            RequiresBall = true,
            Ability = script.Eclipse.SpiritShot
        }
    },
    LukaDoncic = {
        {
            Name = "Isolation",
            RequiresBall = true,
            Multi = true,
            Ability = script.LukaDoncic.Isolation
        },
        {
            Name = "Luka Illusion",
            RequiresBall = true,
            Multi = true,
            Ability = script.LukaDoncic.LukaIllusion
        },
        {
            Name = "Luka Vision",
            RequiresBall = false,
            Ability = script.LukaDoncic.LukaVision
        },
        {
            Name = "Luka Trick",
            RequiresBall = "Both",
            Ability = script.LukaDoncic.LukaTrick
        }
    },
    Dealer = {
        {
            Name = "False Deal",
            RequiresBall = true,
            Multi = true,
            Ability = script.Dealer.FalseDeal
        },
        {
            Name = "Blink Deal",
            BallName = "Deck Break",
            RequiresBall = "Both",
            Ability = script.Dealer.BlinkDeal
        },
        {
            Name = "Card Flick",
            RequiresBall = false,
            Ability = script.Dealer.CardFlick
        },
        {
            Name = "Final Cut",
            RequiresBall = true,
            Ability = script.Dealer.FinalCut
        }
    },
    Genius = {
        {
            Name = "Lockdown Target",
            BallName = "Target Pass",
            RequiresBall = "Both",
            Holdable = "Ball",
            Ability = script.Genius.LockdownTarget
        },
        {
            Name = "Screen",
            BallName = "Slow IQ",
            RequiresBall = "Both",
            Ability = script.Genius.Screen
        },
        {
            Name = "Decline",
            RequiresBall = false,
            Ability = script.Genius.Decline
        },
        {
            Name = "Disable",
            RequiresBall = true,
            Ability = script.Genius.Disable
        }
    },
    HonoredOne = {
        {
            Name = "Lapse Pull",
            BallName = "Lapse Dribble",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.HonoredOne.Lapse
        },
        {
            Name = "Hollow Dash",
            BallName = "Reversal Dribble",
            AwakeningName = "Hollow Steal",
            AwakeningBallName = "Hollow Shot",
            RequiresBall = "Both",
            Ability = script.HonoredOne.Reversal
        },
        {
            Name = "Infinity Dunk",
            RequiresBall = true,
            Ability = script.HonoredOne.Infinity
        },
        {
            Name = "Maximum Dribble",
            RequiresBall = true,
            Ability = script.HonoredOne.Maximum
        }
    },
    CurseKing = {
        {
            Name = "Rebound",
            BallName = "World Red Slash",
            Multi = true,
            Ability = script.CurseKing.Slash
        },
        {
            Name = "Dismantle",
            BallName = "Red Line Dribble",
            AwakeningBallName = "Cleave Throw",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.CurseKing.RedLine
        },
        {
            Name = "Malevolent Dunk",
            RequiresBall = true,
            Ability = script.CurseKing.Malevolent
        },
        {
            Name = "The King Of Curses",
            RequiresBall = true,
            Ability = script.CurseKing.TheKingOfCurses
        }
    },
    Judgement = {
        {
            Name = "Judgement Swap",
            BallName = "Judgement Dribble",
            RequiresBall = "Both",
            Steal = true,
            Multi = true,
            Ability = script.Judgement.JudgementSwap
        },
        {
            Name = "Gavel Slam",
            BallName = "Gavel Strike",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Judgement.GavelSlam
        },
        {
            Name = "Guilty",
            RequiresBall = false,
            Ability = script.Judgement.Guilty
        },
        {
            Name = "Thunder Call",
            RequiresBall = false,
            Ability = script.Judgement.ThunderCall
        }
    },
    Johnny = {
        {
            Name = "Underground Wormhole",
            BallName = "Wormhole Dribble",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Johnny.UndergroundWormhole
        },
        {
            Name = "Horse Launch",
            BallName = "Wormhole Shot",
            RequiresBall = "Both",
            Ability = script.Johnny.HorseLaunch
        },
        {
            Name = "Golden Rotation",
            RequiresBall = true,
            Ability = script.Johnny.GoldenRotation
        },
        {
            Name = "CHIMIMIN!",
            BallName = "Tusk Dribble",
            RequiresBall = "Both",
            Ability = script.Johnny.Chimimin
        }
    },
    Goat = {
        {
            Name = "Goat Charge",
            BallName = "Goat Dribble",
            RequiresBall = "Both",
            Ability = script.Goat.GoatCharge
        },
        {
            Name = "Sleep Shot",
            RequiresBall = true,
            Ability = script.Goat.SleepShot
        },
        {
            Name = "Moon Shot",
            RequiresBall = true,
            Ability = script.Goat.MoonShot
        },
        {
            Name = "Full Court Green",
            RequiresBall = true,
            Ability = script.Goat.FullCourtGreen
        }
    },
    Valentine = {
        {
            Name = "Flag Slam",
            BallName = "Flag Breaker",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Valentine.FlagSlam
        },
        {
            Name = "Sky Block",
            BallName = "Inverted World",
            RequiresBall = "Both",
            Ability = script.Valentine.SkyBlock
        },
        {
            Name = "Dirty Dunks Done Dirt Cheap",
            RequiresBall = true,
            Ability = script.Valentine.DirtyDunksDoneDirtCheap
        },
        {
            Name = "Duplication",
            RequiresBall = true,
            Ability = script.Valentine.Duplication
        }
    },
    Thief = {
        {
            Name = "Pillage",
            AwakeningName = "Total Theft",
            RequiresBall = "Both",
            Ability = script.Thief.Pillage
        },
        {
            Name = "Rough Play",
            BallName = "Stolen Dribble",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Thief.RoughPlay
        },
        {
            Name = "It\'s Mine",
            RequiresBall = false,
            Ability = script.Thief.ItsMine
        }
    },
    Alien = {
        {
            Name = "Alien Dribble",
            RequiresBall = true,
            Ability = script.Alien.AlienDribble
        },
        {
            Name = "The Reach",
            BallName = "Dominance",
            RequiresBall = "Both",
            Ability = script.Alien.TheReach
        },
        {
            Name = "Poster",
            RequiresBall = true,
            Ability = script.Alien.Poster
        },
        {
            Name = "Alley",
            RequiresBall = "Both",
            Ability = script.Alien.Alley
        }
    },
    KingOfNYC = {
        {
            Name = "Redline",
            RequiresBall = true,
            Ability = script.KingOfNYC.Redline
        },
        {
            Name = "Clash",
            BallName = "Counter Step",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.KingOfNYC.Clash
        },
        {
            Name = "Clutch",
            RequiresBall = true,
            Ability = script.KingOfNYC.NYCClutch
        },
        {
            Name = "Liberty Crown",
            BallName = "Liberty Drive",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.KingOfNYC.Liberty
        }
    },
    ChrolloV2 = {
        {
            Name = "Creator\'s Cut",
            BallName = "Creator\'s Dribble",
            RequiresBall = "Both",
            Jump = true,
            Multi = true,
            Ability = script.ChrolloV2.BanditDribble
        },
        {
            Name = "Creator Intercept",
            BallName = "Creator Cloak",
            AwakeningName = "Creator Counter",
            RequiresBall = "Both",
            Jump = true,
            Ability = script.ChrolloV2.BanditCloak
        },
        {
            Name = "Revert Abilities",
            AwakeningName = "Creator\'s Secret",
            RequiresBall = "Both",
            Ability = script.ChrolloV2.CreatorSecret
        },
        {
            Name = "Time Erasure",
            RequiresBall = true,
            Ability = script.ChrolloV2.TimeErasure
        }
    },
    TatlisV2 = {
        {
            Name = "Phantom Step",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.TatlisV2.PhantomStep
        },
        {
            Name = "Soul Catch",
            BallName = "Soul Walk",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.TatlisV2.SoulCatch
        },
        {
            Name = "Scream",
            BallName = "Deadly Distance",
            RequiresBall = "Both",
            Ability = script.TatlisV2.Scream
        },
        {
            Name = "Death Painting",
            RequiresBall = false,
            Ability = script.TatlisV2.DeathPainting
        }
    },
    Izure = {
        {
            Name = "Fast Step",
            BallName = "Instinct I",
            RequiresBall = "Both",
            Ability = script.Izure.FastStep
        },
        {
            Name = "Last Push",
            RequiresBall = true,
            Multi = true,
            Ability = script.Izure.LastPush
        },
        {
            Name = "Try Harder",
            RequiresBall = true,
            Ability = script.Izure.TryHarder
        },
        {
            Name = "Fakeout",
            RequiresBall = true,
            Ability = script.Izure.Fakeout
        }
    },
    ScaryMonster = {
        {
            Name = "Time Skip Crossover",
            RequiresBall = true,
            Multi = true,
            Ability = script.ScaryMonster.TimeSkipCrossover
        },
        {
            Name = "Bullet Pressure",
            BallName = "Leg Shot",
            RequiresBall = "Both",
            Jump = "Both",
            Ability = script.ScaryMonster.BulletPressure
        },
        {
            Name = "World",
            RequiresBall = true,
            Ability = script.ScaryMonster.World
        },
        {
            Name = "Dinosaur Form",
            BallName = "Tail Form",
            RequiresBall = "Both",
            Ability = script.ScaryMonster.DinosaurForm
        }
    },
    Kira = {
        {
            Name = "Heart Attack",
            BallName = "Written Fate",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Kira.HeartAttack
        },
        {
            Name = "Cause of Death",
            BallName = "Death Drive",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.Kira.CauseDeath
        },
        {
            Name = "Final Judgement",
            RequiresBall = true,
            Ability = script.Kira.FinalJudgement
        },
        {
            Name = "New World",
            RequiresBall = "Both",
            Ability = script.Kira.NewWorld
        }
    },
    PerfectionV2 = {
        {
            Name = "Instant Grab",
            BallName = "Perfect Dribble",
            RequiresBall = "Both",
            Multi = true,
            Steal = true,
            Ability = script.PerfectionV2.PerfectDribble
        },
        {
            Name = "Perfect Defense",
            BallName = "The Perfect Shot",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.PerfectionV2.ThePerfectShot
        },
        {
            Name = "Perfect Self Alley",
            RequiresBall = true,
            Ability = script.PerfectionV2.PerfectSelfAlley
        },
        {
            Name = "Unwilling Run",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.PerfectionV2.Unwilling
        }
    },
    Ninja = {
        {
            BallName = "Clone Blitz",
            Name = "Shadow Block",
            RequiresBall = "Both",
            Ability = script.Ninja.CloneBlitz
        },
        {
            Name = "NINJA RUN",
            BallName = "Shadow Relay",
            RequiresBall = "Both",
            Multi = true,
            Ability = script.Ninja.ShadowRelay
        },
        {
            Name = "Nine Tails",
            RequiresBall = false,
            Multi = true,
            Ability = script.Ninja.Transform
        },
        {
            BallName = "Tail Dribble",
            Name = "Copy Eye Steal",
            RequiresBall = "Both",
            Ability = script.Ninja.Ability4
        }
    },
    AMG = {
        {
            Name = "Collision",
            BallName = "Slipstream",
            RequiresBall = "Both",
            Ability = script.AMG.Collision
        },
        {
            Name = "Overtake",
            BallName = "Weave",
            RequiresBall = "Both",
            Steal = true,
            Ability = script.AMG.Overtake
        },
        {
            Name = "I\'ve Already Won.",
            RequiresBall = false,
            Ability = script.Skarp.AlreadyWon
        },
        {
            Name = "Blitz",
            BallName = "Self Pass",
            RequiresBall = "Both",
            Ability = script.Skarp.Blitz
        }
    },
    Skarp = {
        {
            Name = "Lightning Slap",
            BallName = "Thunder Swarm",
            RequiresBall = "Both",
            Ability = script.Skarp.Slap
        },
        {
            Name = "Thunderclap and Flash",
            BallName = "Dash",
            RequiresBall = "Both",
            Ability = script.Skarp.Thunder
        },
        {
            Name = "I\'ve Already Won.",
            RequiresBall = false,
            Ability = script.Skarp.AlreadyWon
        },
        {
            Name = "Blitz",
            BallName = "Self Pass",
            RequiresBall = "Both",
            Ability = script.Skarp.Blitz
        }
    }
};
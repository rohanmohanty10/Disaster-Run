  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local KnitPath = PathShortcuts.KnitPath;
local TableUtil = require(KnitPath.TableUtil);
local Trove = require(KnitPath.Trove);
local _ = game.ReplicatedStorage.Remotes.Output;
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local v1 = {
    SummonedRun = 7037969480,
    SummonedWalk = 6707573199
};
local u2 = {
    anims = {
        DefaultAnims = {
            Action = {
                Dash = 6630347677,
                ForwardDash = 10451361960,
                BackwardDash = 10451359576,
                LeftDash = 10451363828,
                RightDash = 10451365211,
                DeathAnimation = 7070248368,
                KnockbackLoop = 9528670485,
                KnockbackEnd = 9528673913,
                Grab = 10906128504,
                Throw = 10906131878,
                ThrowVictim = 10906132668
            },
            Movement = {
                Run = 7037969480,
                Walk = 6707573199,
                TimeAccel = 6630347677,
                Jump = 6869804977,
                Fall = 6869825077,
                Land = 7748987343,
                Glide = 8725053000,
                SummonedRun = 9253103011,
                SummonedWalk = 9253105582,
                LowHPRun = 6939421746,
                LowHPWalk = 6939421746
            },
            Idle = {
                Idle = 6630333014,
                LowHPIdle = 6826152951
            }
        },
        ["Attacking Dummy"] = {
            Action = {
                ["LMB-1"] = 7118119983,
                ["LMB-2"] = 7118134818,
                ["LMB-3"] = 7118155115,
                ["LMB-4"] = 7118194438
            },
            Idle = {
                Idle = 7473308966
            }
        },
        GER = {
            Action = {
                ["LMB-1"] = 8479407906,
                ["LMB-2"] = 8479409142,
                ["LMB-3"] = 8479410619,
                ["LMB-4"] = 8479412145,
                Barrage = 9582592923,
                ["Barrage Finisher"] = 10315501556,
                ["Heavy Attack"] = 10315506602,
                ["Return To Zero"] = 10315504361,
                ["Debris Projectile"] = 10315510337,
                ["Life Giver"] = 10315514494,
                ["Unreachable Truth"] = 10315516416,
                ["Pursuit Rush"] = 10315523095,
                ["Berserk Senses V2 Windup"] = 10620214430,
                ["Berserk Senses V2 User"] = 10620217492,
                ["Berserk Senses V2 Victim"] = 10620219985,
                ["Berserk Senses V2 Camera"] = 10620231495,
                ["Berserk Senses V2 Knockback"] = 10620235578,
                WhaStartup = 10620237604,
                WhaIdle = 10620238972
            },
            Idle = {
                Idle = 7193377883
            }
        },
        Clown = {
            Action = {
                ["LMB-1"] = 5143367853,
                ["LMB-2"] = 5143376290,
                ["LMB-3"] = 5143367853,
                ["LMB-4"] = 5143376290,
                Barrage = 10548807775,
                TimeStop = 5146277255,
                StrongPunch = 5965700661,
                StandJump = 5889373753,
                Block = 5922378153,
                ["Time Erase"] = 6789950709,
                PilotUserIdle = 10035919728,
                PilotUserTransition = 10035917372,
                PilotForwardDash = 10128375083,
                PilotBackwardDash = 10128373129,
                PilotLeftDash = 10128376957,
                PilotRightDash = 10128378333
            },
            Movement = {
                Walk = 10158780189,
                SummonedWalk = 10158780189,
                SummonedRun = 7037969480
            },
            Idle = {
                StandIdle = 5778922246,
                Idle = 5778922246
            }
        },
        A_Sans = {
            Action = {
                ["Bone Field"] = 7272561672
            },
            Movement = {
                Run = 7272215238,
                Walk = 7272215843
            },
            Idle = {
                Idle = 7272213387
            }
        },
        Ruined = {
            Action = {
                ["LMB-1"] = 9914915906,
                ["LMB-2"] = 9914916923,
                ["LMB-3"] = 9914918056,
                Equip = 9914912617,
                Thrust = 9944762298
            },
            Movement = {
                SummonedWalk = 9914920142,
                SummonedRun = 9924817196,
                Run = 7272215238,
                Walk = 7339784680
            },
            Idle = {
                SummonedIdle = 9944492483,
                Idle = 9944508260
            }
        },
        Vampire = {
            Action = {},
            Movement = {
                Walk = 10653285141,
                Run = 10653283636
            },
            Idle = {
                Idle = 10653317287
            }
        },
        Fightsabre = {
            Action = {
                Shoot = 5862021910,
                Reload = 5862022700,
                Kick = 5838698998,
                PoseTransition = 5862209023,
                PoseIdle = 5862227840,
                Dash = 5841978909
            },
            Movement = {
                Jump = 5838597419
            },
            Idle = {
                Idle = 5862045131
            }
        },
        Gun = {
            Action = {
                Shoot = 5838363810,
                Reload = 5838362834,
                Kick = 5838698998,
                PoseIdle = 5841873122,
                PoseTransition = 5841947922,
                Dash = 5841978909,
                Whip = 5838608797
            },
            Movement = {
                Jump = 5838597419
            },
            Idle = {
                Idle = 5838374728
            }
        },
        Hornet = {
            Action = {
                Hegale = 6079529359,
                Garama = 6079583891,
                PoseTransition = 6079465430,
                PoseIdle = 6079518530,
                Edino = 6079526759,
                AirDash = 6079473609,
                ["Dash Strike"] = 6079477125,
                m1 = 6124409935
            }
        },
        EP_R = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                ["StandOff-LMB-1"] = 11127865908,
                ["StandOff-LMB-2"] = 11127868260,
                ["StandOff-LMB-3"] = 11127869614,
                ["StandOff-LMB-4"] = 11127870798,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                Grab = 11159544716,
                Throw = 11159545307,
                ThrowVictim = 11159546054,
                ["Quote-1"] = 10976760361,
                ["Quote-2"] = 10976761195,
                ["Quote-3"] = 10976763020
            },
            Movement = {
                Walk = 10856503017,
                Run = 10856500879,
                ForwardDash = 10838677738,
                BackwardDash = 10838687030,
                LeftDash = 10838688196,
                RightDash = 10838689289
            },
            Idle = {
                Idle = 10842851957
            }
        },
        ["STEEL SPIN_R"] = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                ["StandOff-LMB-1"] = 10688396131,
                ["StandOff-LMB-2"] = 10688401326,
                ["StandOff-LMB-3"] = 10688403836,
                ["StandOff-LMB-4"] = 10688406327,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                Grab = 11159544716,
                Throw = 11159545307,
                ThrowVictim = 11159546054,
                IronSpurs = 11904600628,
                IronFist = 11904689765,
                SteelBallThrowWindup = 11904779163,
                SteelBallThrowHold = 11904781751,
                SteelBallThrow = 11904783238,
                ["Quote-1"] = 10976760361,
                ["Quote-2"] = 10976761195,
                ["Quote-3"] = 10976763020
            },
            Movement = {
                Walk = 10856503017,
                Run = 10856500879,
                ForwardDash = 10838677738,
                BackwardDash = 10838687030,
                LeftDash = 10838688196,
                RightDash = 10838689289
            },
            Idle = {
                Idle = 10842851957
            }
        },
        ["Slayer Armor II"] = {
            Action = {
                ["LMB-1"] = 9489091712,
                ["LMB-2"] = 9489093677,
                ["LMB-3"] = 9489095046,
                Equip = 9488041296
            },
            Movement = {
                SummonedWalk = 9488046140,
                SummonedRun = 9488047574,
                Walk = 8577083049,
                Run = 8577096811
            },
            Idle = {
                SummonedIdle = 9488042741,
                Idle = 6943911515
            }
        },
        ["Planet Shaper"] = {
            Action = {
                ["Chicxulub Asteroid"] = 8243744661,
                ["LMB-1"] = 8833858741,
                ["LMB-2"] = 8833863225,
                ["LMB-3"] = 8833858741,
                ["LMB-4"] = 8688528286,
                Earthquake = 8688518639,
                ["Portal Pass"] = 8688528286,
                Roar = 8689723794,
                Grab = 8697691350,
                PoseTransition = 8702974469,
                PoseIdle = 8702976463,
                SelfHeal = 8027965306,
                TeamworkStart = 8765125585,
                TeamworkUser = 8765233284,
                TeamworkVictim = 8765130959,
                Starstruck = 8769459761,
                GateWarp = 8829306780
            },
            Idle = {
                StandIdle = 8273533330
            }
        },
        ["PLANET // SHAPER"] = {
            Action = {
                ["Chicxulub Asteroid"] = 8243744661,
                ["LMB-1"] = 8833858741,
                ["LMB-2"] = 8833863225,
                ["LMB-3"] = 8833858741,
                ["LMB-4"] = 8688528286,
                Earthquake = 8688518639,
                ["Portal Pass"] = 8688528286,
                Roar = 8689723794,
                Grab = 8697691350,
                PoseTransition = 8702974469,
                PoseIdle = 8702976463,
                SelfHeal = 8027965306,
                TeamworkStart = 8765125585,
                TeamworkUser = 8765233284,
                TeamworkVictim = 8765130959,
                Starstruck = 8769459761,
                GateWarp = 8829306780
            },
            Movement = v1,
            Idle = {
                StandIdle = 8273533330
            }
        },
        CR_R = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                ["StandOff-LMB-1"] = 11127865908,
                ["StandOff-LMB-2"] = 11127868260,
                ["StandOff-LMB-3"] = 11127869614,
                ["StandOff-LMB-4"] = 11127870798,
                BarrageStartup = 10838298509,
                Barrage = 10838301380,
                BarrageFinisher = 10603516376,
                BarrageClashEnd = 10839831781,
                HeavyStrike = 11428065691,
                PoseTransition = 11589775854,
                PoseIdle = 11589085863,
                AmmoliteSwipe = 11733147971,
                CovalentBond = 11733262528,
                RawPower = 11745671274,
                GeodeDefenseStartup = 11774097158,
                GeodeDefenseIdle = 11774199389,
                GeodeDefenseExecute = 11774106103
            },
            Movement = {
                Walk = 11462153436,
                Run = 11499895679,
                SummonedWalk = 11462153436,
                SummonedRun = 11499895679,
                ForwardDash = 10838677738,
                BackwardDash = 10838687030,
                LeftDash = 10838688196,
                RightDash = 10838689289
            },
            Idle = {
                SummonedIdle = 11732898346,
                Idle = 11732898346
            }
        },
        Gaster = {
            Action = {
                Summon = 7125583123,
                Core = 7125643137,
                OLDCore = 5630216399,
                DeSummon = 7125689200,
                SelfHeal = 5629226076,
                AllyHeal = 5629228404,
                Slash = 5641408651,
                Bullets = 5630120742,
                Bombs = 5630323630,
                Block = 7126320310,
                Laser = 5641461493,
                Saw = 5630087705,
                Pully = 5629647334
            },
            Movement = {
                Walk = 5627215440
            },
            Idle = {
                Idle = 7125645251
            }
        },
        ["Dragon Sage"] = {
            Action = {
                LElbow = 7086070490,
                ThunderingLeap = 7086960243,
                ["LMB-1"] = 7087806959,
                ["LMB-2"] = 7087808284,
                ["LMB-3"] = 7087811086,
                ["LMB-4"] = 7087813864,
                ["LMB-5"] = 7087816245,
                ElectricSmite = 7090411176,
                GrabAttempt = 7092246633
            }
        },
        Ardoth = {
            Action = {
                LElbow = 7088221452,
                ThunderingLeap = 7086960243,
                ["LMB-1"] = 7087806959,
                ["LMB-2"] = 7087808284,
                ["LMB-3"] = 7087811086,
                ["LMB-4"] = 7087813864,
                ["LMB-5"] = 7087816245
            }
        },
        Sol = {
            Action = {
                ["LMB-1"] = 6579514138,
                ["LMB-2"] = 6579516941,
                ["LMB-3"] = 6579518209,
                ["LMB-4"] = 6579519666,
                Barrage = 6925550526,
                SolStarCombo = 6937462921,
                BlackHole = 6925551881,
                IntangiblePunch = 6925552789,
                Forcefield = 6925553631,
                ["Pose Transition Stand"] = 7772889380,
                ["Pose Transition root"] = 7772891068,
                ["Pose Idle Stand"] = 7772892453,
                ["Pose Idle root"] = 7772893941
            },
            Movement = v1,
            Idle = {
                StandIdle = 6924591468,
                Idle = 6930660376
            }
        },
        SOL_R = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                ["StandOff-LMB-1"] = 11127865908,
                ["StandOff-LMB-2"] = 11127868260,
                ["StandOff-LMB-3"] = 11127869614,
                ["StandOff-LMB-4"] = 11127870798,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                BarrageStartup = 10838298509,
                Barrage = 10838301380,
                BarrageFinisher = 10603516376,
                BarrageClashEnd = 10839831781,
                Grab = 10906128504,
                Throw = 10906131878,
                ThrowVictim = 10906132668
            },
            Movement = {
                SummonedWalk = 11753653350,
                SummonedRun = 11753648615,
                Walk = 11753653350,
                Run = 11753648615
            },
            Idle = {
                SummonedIdle = 11753645505,
                Idle = 11753645505
            }
        },
        NOC_R = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                ["StandOff-LMB-1"] = 11127865908,
                ["StandOff-LMB-2"] = 11127868260,
                ["StandOff-LMB-3"] = 11127869614,
                ["StandOff-LMB-4"] = 11127870798,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                BarrageStartup = 10838298509,
                Barrage = 10838301380,
                BarrageFinisher = 10603516376,
                BarrageClashEnd = 10839831781,
                Grab = 10906128504,
                Throw = 10906131878,
                ThrowVictim = 10906132668
            },
            Movement = {
                SummonedWalk = 11753671123,
                SummonedRun = 11753670017,
                Walk = 11753671123,
                Run = 11753670017
            },
            Idle = {
                SummonedIdle = 11753669050,
                Idle = 11753669050
            }
        },
        ["Demon Lord"] = {
            Action = {
                DevilEyes = 6948655414
            }
        },
        ["Made In Heaven"] = {
            Action = {
                Pose = 8055168044,
                PoseIdle = 8055170863,
                EStandOff = 6746357635,
                QuickJab = 6742538911,
                ["LMB-1"] = 6750197876,
                ["LMB-2"] = 6750195977,
                ["LMB-3"] = 6750197100,
                ["LMB-4"] = 6750197520,
                ["StandOff-LMB-1"] = 6749658606,
                ["StandOff-LMB-2"] = 6749660428,
                ["StandOff-LMB-3"] = 6749662623,
                ["StandOff-LMB-4"] = 6749663398,
                MiHChop = 6769082841,
                Conuter = 7045210066,
                BackDashKnives = 6758894361,
                DownKnives = 6758927514,
                PunchBarrage = 6750252452,
                BurstBarrage = 6751298313,
                RightPunch = 6754448913,
                Roll = 5191300871,
                SF = 5164214146
            },
            Movement = {
                TimeAccel = 6630347677,
                Run = 7037969480,
                Walk = 6877996750,
                SummonedRun = 7037969480,
                SummonedWalk = 6877996750
            },
            Idle = {
                StandIdle = 7367667043,
                Idle = 7367593771
            }
        },
        T_MIH = {
            Action = {
                ["StandOff-LMB-1"] = 9543697950,
                ["StandOff-LMB-2"] = 9543700963,
                ["StandOff-LMB-3"] = 9543702537,
                ["StandOff-LMB-4"] = 9543704330,
                ["Behind You!"] = 9536216452
            },
            Movement = {
                TimeAccel = 6630347677,
                Run = 7037969480,
                Walk = 6877996750,
                SummonedRun = 7037969480,
                SummonedWalk = 6877996750
            },
            Idle = {
                StandIdle = 7367667043,
                Idle = 7367593771
            }
        },
        DOG = {
            Action = {
                Summon = 6774704354,
                StrongPunch = 6774704354
            }
        },
        Shinigami = {
            Action = {
                AttackPose = 5922281900,
                BlashFire = 4554563880,
                HealBarrage = 5146177853,
                Chop = 5340465483,
                HealOverwrite = 5150190585,
                Kick = 5340460049,
                StrongerStrongPunch = 5340532395,
                Idle = 5340484318,
                LeftPunch = 5143376290,
                Overwrite = 5150170356,
                Pose = 5269135562,
                PunchBarrage = 5790894843,
                RightPunch = 5143367853,
                Roll = 5191300871,
                SF = 5164214146,
                Slam = 5150294247,
                StandJump = 5889373753,
                StrongPunch = 6663831578,
                Timestop = 5915276164,
                AttackPoseLooped = 6568461661,
                AttackPoseTransition = 6568465045
            }
        },
        CakePlatinum = {
            Action = {
                AttackPose = 5922281900,
                BlashFire = 4554563880,
                SelfHeal = 5146177853,
                Idle = 5778922246,
                LeftPunch = 5143376290,
                Overwrite = 5150170356,
                Pose = 5303113036,
                PunchBarrage = 5790894843,
                RightPunch = 5143367853,
                Roll = 5191300871,
                SF = 5164214146,
                Slam = 5150294247,
                StandJump = 5889373753,
                StrongPunch = 5965700661,
                Timestop = 5915276164,
                AttackPoseLooped = 6568461661,
                AttackPoseTransition = 6568465045
            }
        },
        AngelicPlatinum = {
            Action = {
                AttackPose = 5922281900,
                BlashFire = 4554563880,
                Drill = 5263173421,
                SelfHeal = 5146177853,
                Idle = 5778922246,
                LeftPunch = 5143376290,
                Overwrite = 5150170356,
                Pose = 5143357677,
                PunchBarrage = 5790894843,
                RightPunch = 5143367853,
                Roll = 5191300871,
                SF = 5164214146,
                Slam = 5150294247,
                StandJump = 5889373753,
                StrongPunch = 5965700661,
                Timestop = 5146277255,
                animfly = 5508281814,
                AttackPoseLooped = 6568461661,
                AttackPoseTransition = 6568465045
            }
        },
        ["The World"] = {
            Action = {
                Barrage = 6307582703,
                Donut = 6700246793,
                TS = 7070692651,
                GrabThrow = 6466281270,
                ThrowGrab = 6466283071,
                Checkmate = 6746021275,
                GroundSlam = 6754411814,
                SignSlam = 6449239412,
                WRY = 6733919900,
                Kick = 6238231437,
                TeleportPose = 6313231576,
                ["LMB-1"] = 6579514138,
                ["LMB-2"] = 6579516941,
                ["LMB-3"] = 6579518209,
                ["LMB-4"] = 6579519666,
                AttackPose = 6307839827,
                Tandem = 6313729731,
                DashAttackPose = 6316519347,
                RoundhouseKick = 6328384081,
                SlamPunch = 6516569709,
                BloodSuckAttempt = 6753687790,
                AerialChop = 6745673036,
                JosephKnife = 6316893120,
                Lunge = 6313729731,
                KickBarrage = 10140174898,
                RoadRoller = 7097331918,
                RoadRollerAnim = 7097331918,
                PoseTransition = 10528708480,
                PoseIdle = 10528723562
            },
            Movement = v1,
            Idle = {
                Idle = 10548864046,
                StandIdle = 10548855334
            }
        },
        ["Senator Armstrong"] = {
            Action = {},
            Movement = {},
            Idle = {}
        },
        ["Creeper Queen"] = {
            Action = {
                Barrage = 6420707857,
                HeavyPunch = 6330983021,
                ["Primary Bomb"] = 6421362019,
                ["Yen Throw"] = 6567517933,
                Detonate = 6421361576,
                LMB = 6577748776,
                ["LMB-1"] = 6761487530,
                ["LMB-2"] = 6761488706,
                ["LMB-3"] = 6761489488,
                ["LMB-4"] = 6761490353,
                ["Bubble Bomb"] = 6590183065,
                ["Punch Bomb"] = 6594526758,
                Uppercut = 6594543037,
                ["Face Grab"] = 6700676341,
                ["Third Bomb"] = 6690947113,
                ["BTD Pose"] = 6694883914,
                ["BTD Activate"] = 6693526640,
                ["BTD Loop"] = 6693530588,
                VPIdle = 6682523681,
                VPDetonate = 6685427570,
                ["Secondary Bomb"] = 6738925318,
                PoseIdle = 7508212350,
                PoseTransition = 7508188405
            },
            Idle = {
                SummonedIdle = 6820065461
            }
        },
        ["Uber Oni"] = {
            Action = {
                Rampage = 6792665091,
                DemonStep = 6981841742,
                ConsumingFlames = 6793391689,
                Misogi = 6793551810,
                Flip1 = 6794016801,
                Flip2 = 6800964305,
                RisingDragon = 6801013416,
                LegBreaker = 6801228703
            }
        },
        Omnitrix = {
            Action = {
                Select = 6755594110,
                Pyrokinesis = 6768194987,
                ["Fireball Generation"] = 6771876128,
                ["Fire Punch"] = 6771876128,
                ["Quick Swing"] = 6796338854,
                ["Vortex Attempt"] = 6806219463,
                ["Vortex Start"] = 6811937143,
                ["Vortex End"] = 6812069893,
                Vortex = 6806224461,
                ["DiamondHead Punch"] = 7123660390,
                ["DiamondHead Jab"] = 7123666255,
                Crystallokinesis = 7065705093,
                PoseIdle = 7772848382,
                PoseTransition = 7772884995
            },
            Idle = {
                Idle = 6630333014,
                HeatBlastIdle = 7062472761,
                DiamondHeadIdle = 7065699280,
                XLR8Idle = 7062736137
            }
        },
        ["Omnitrix Rewrite"] = {
            Action = {
                Select = 6755594110,
                Pyrokinesis = 6768194987,
                ["Fireball Generation"] = 6771876128,
                ["Fire Punch"] = 6771876128,
                ["Quick Swing"] = 6796338854,
                ["Vortex Attempt"] = 6806219463,
                ["Vortex Start"] = 6811937143,
                ["Vortex End"] = 6812069893,
                Vortex = 6806224461,
                HeatBlastIdle = 7062472761,
                XLR8Idle = 7062736137,
                DiamondHeadIdle = 7065699280,
                ["DiamondHead Punch"] = 7123660390,
                ["DiamondHead Jab"] = 7123666255,
                Crystallokinesis = 7065705093,
                PoseIdle = 7772848382,
                PoseTransition = 7772884995
            }
        },
        SP_CR = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                Block = 10808688837,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                BarrageStartup = 10002462639,
                Barrage = 10603510761,
                BarrageFinisher = 10603516376,
                StarBreaker = 10603603515,
                Grab = 9955779856,
                Grabbed = 9955782521,
                GrabbedVictim = 9955786162
            },
            Movement = {
                Walk = 10629833287,
                Run = 7331835388,
                SummonedWalk = 10629833287,
                SummonedRun = 7331835388
            },
            Idle = {
                StandIdle = 10636699829,
                Idle = 10636697572
            }
        },
        Inker = {
            Action = {
                AttackPose = 6600255288,
                AttackPoseTransition = 6568465045,
                AttackPoseLooped = 6568461661,
                Barrage = 6421231197,
                HeavyPunch = 6330983021,
                ["LMB-1"] = 6579514138,
                ["LMB-2"] = 6579516941,
                ["LMB-3"] = 6579518209,
                ["LMB-4"] = 6579519666,
                Pose = 6742642203,
                glide = 7045700729,
                Timestop = 6933820161,
                PoseTransition = 6742642896,
                RMove = 7040077713,
                Ultimate = 7040449256,
                ["S-Summon"] = 8961582641,
                ["S-Idle"] = 8961586691,
                ["S-Move"] = 8961596846,
                ["S-Roar"] = 9054635954,
                ["S-Slash"] = 8961608372,
                ["S-Desummon"] = 8961612022
            },
            Idle = {
                StandIdle = 6421260216
            }
        },
        ["δ:for the DELTA"] = {
            Action = {
                FreezePlayer = 6333146548,
                OnKnees = 6334076639,
                Shockwave = 6290528162,
                StandSummon = 6333716743,
                TurnBackTime = 6333151996,
                PoseStart = 6414190677,
                PoseEnd = 6414193632,
                PoseLoop = 6414352667
            },
            Movement = v1,
            Idle = {
                StandIdle = 6333137550
            }
        },
        TWHV = {
            Action = {
                AttackPose = 6600255288,
                Barrage = 6331004626,
                Cutscene = 7037887987,
                Gasoline = 5697356924,
                Kick = 5224441129,
                KnifeAnim = 7195050558,
                UrgentTS = 6612929603,
                Pose1 = 5730215005,
                GunFire = 6501360764,
                Pose2 = 5730215005,
                PunchBarrage = 5704092469,
                StandJump = 5889373753,
                HeavyPunch = 6663831578,
                Timestop = 7060238054,
                Sit = 5718959564,
                WireThrow = 6649402629,
                HeavyMuda = 6768306270,
                ["LMB-1"] = 6579514138,
                ["LMB-2"] = 6579516941,
                ["LMB-3"] = 6579518209,
                ["LMB-4"] = 6579519666,
                PoseTransition = 8062693425,
                PoseIdle = 8062689014
            },
            Movement = v1,
            Idle = {
                StandIdle = 6606063246,
                Idle = 6645559257
            }
        },
        Crystallized = {
            Action = {
                Ability = 5484256995,
                Barrage = 5483406546,
                Block = 5495710819,
                Dash = 5561572402,
                Summon = 5487400100,
                Pose = 5484111490,
                Slam = 5487446782,
                StrongPunch = 5482915300,
                Punch1 = 6647874978,
                Punch2 = 6647876817,
                RaiseCrystals = 6648048241,
                CrystalDash = 6673365250,
                StandJump = 6673515754
            },
            Movement = v1,
            Idle = {
                StandIdle = 5561569807
            }
        },
        ["Nuclear Star"] = {
            Action = {
                Ability = 5484256995,
                Barrage = 5483406546,
                Block = 5495710819,
                Dash = 5561572402,
                Summon = 5487400100,
                Pose = 5484111490,
                Slam = 5487446782,
                StrongPunch = 5482915300,
                Punch1 = 6647874978,
                Punch2 = 6647876817,
                RaiseCrystals = 6648048241,
                CrystalDash = 6673365250,
                StandJump = 6673515754
            },
            Movement = v1,
            Idle = {
                StandIdle = 5561569807
            }
        },
        SINKING = {
            Idle = {
                StandIdle = 6774740934
            }
        },
        ["S/TW"] = {
            Action = {
                ["LMB-1"] = 6579514138,
                ["LMB-2"] = 6579516941,
                ["LMB-3"] = 6579518209,
                ["LMB-4"] = 6579519666
            },
            Movement = {
                Walk = 5743812382,
                Run = 7037969480,
                SummonedWalk = 5743812382,
                SummonedRun = 7037969480
            },
            Idle = {
                Idle = 10115525271,
                StandIdle = 10115522627
            }
        },
        Reaper = {
            Action = {
                PoseTransition = 7782353441,
                PoseIdle = 7782352049,
                ["Dimension Rift"] = 6893035303,
                Wither = 6901716358,
                Point = 6901643537,
                ["Soul Consumption"] = 6904737035,
                Block = 6896881487,
                Frenzy = 6910492396
            },
            Movement = {
                Run = 7324808743,
                Walk = 7324807629
            },
            Idle = {
                Idle = 7324806225
            }
        },
        GOKU_R = {
            Action = {
                ["LMB-1"] = 10447330139,
                ["LMB-2"] = 10447335715,
                ["LMB-3"] = 10447337080,
                ["LMB-4"] = 10447338237,
                Kiai = 8995536447,
                ["Meteor Strike"] = 11468346868,
                ["Kamehameha Start"] = 9000242051,
                ["Kamehameha Loop"] = 9000243142,
                ["Kamehameha Fire"] = 9000243952,
                ["Kamehameha Max"] = 9000245195,
                Kamehameha = 8995538852,
                Transform = 10446762289,
                Jajanken = 8995545277,
                ["Instant Transmission"] = 8995547401,
                ["Explosive Wave"] = 8995549434,
                ["Senzu Bean"] = 8995553609,
                ["Destructo Disc"] = 8995557234,
                ["Solar Flare"] = 8995559419,
                ["Dragon Throw Attempt"] = 9000247100,
                ["Dragon Throw"] = 9000248965,
                ["Meteor Smash Attempt"] = 9000250472,
                ["Meteor Smash"] = 9000253195,
                ["Gut Punch"] = 9000272839,
                Transcendence = 9000274037,
                Barrage = 10455636567,
                ["Meteor Combination Attempt"] = 9083907352,
                ["Meteor Combination"] = 9083910504,
                ["Spirit Bomb Start"] = 9083935295,
                ["Spirit Bomb Loop"] = 9083929820,
                ["Spirit Bomb"] = 9083937924,
                Godbind = 9083940979,
                ["Grudgeless Strike"] = 9083945838,
                ["Super God Fist"] = 9083952828,
                ["Super God Shock Flash"] = 9083956238,
                ["Celestial Whirlwind Pose"] = 9083969948,
                ["Celestial Whirlwind"] = 9083973324,
                ["Instinct Pose"] = 9083978473,
                Instinct = 9083984834,
                ["Autonomous Fist"] = 9083993691,
                ["Unpolished Instinct"] = 9083996482
            },
            Movement = {
                Run = 10455589469,
                Walk = 10455591976
            },
            Idle = {
                Idle = 10455579066
            }
        },
        UBER_R = {
            Action = {
                ["LMB-1"] = 10447330139,
                ["LMB-2"] = 10447335715,
                ["LMB-3"] = 10447337080,
                ["LMB-4"] = 10447338237
            },
            Movement = {
                Run = 11499256258,
                Walk = 11499257052
            },
            Idle = {
                Idle = 11499255171
            }
        },
        zaihop = {
            Action = {
                ["LMB-1"] = 7756678348,
                ["LMB-2"] = 7756680481,
                ["LMB-3"] = 7756686359,
                ["LMB-4"] = 7758466340,
                ["Home Run"] = 7759029193,
                ["Ban Hammer"] = 7764660173,
                ["Shovel Slam"] = 7764964415,
                ["Shovel Spin"] = 7767935194,
                ["Shovel Gun"] = 7769165261,
                ["Shovel Sinkhole"] = 7777096891,
                ["SS Startup"] = 7807883818,
                ["SS Leap"] = 7807889469,
                ["SS Spin Idle"] = 7807891660,
                ["SS Finish"] = 7807886164,
                ForwardDash = 5601361906
            },
            Movement = {
                Run = 7756147590,
                Walk = 7756149708
            },
            Idle = {
                Idle = 7756145559
            }
        },
        Guts = {
            Action = {
                ["LMB-1"] = 10640223644,
                ["LMB-2"] = 10640224663,
                ["LMB-3"] = 10640225897,
                ["LMB-4"] = 10640227078,
                ["Blood & Guts"] = 10676333442,
                ["Loose Cannon"] = 10618519393
            },
            Movement = {
                Walk = 10640189679,
                Run = 10640191645
            },
            Idle = {
                Idle = 10608986830
            }
        },
        Banisher = {
            Action = {
                PoseIdle = 9882291671
            },
            Idle = {
                Idle = 9839675543
            },
            Movement = {
                Walk = 6877996750,
                Run = 7037969480,
                SummonedWalk = 6877996750
            }
        },
        ["Stone Free"] = {
            Action = {
                ["Ora Kicks"] = 9554010452,
                Barrage = 6331004626,
                ["Spider Tack"] = 9554023294,
                ["Pitcher Fly Throw"] = 9554012774,
                ["Pitcher Fly Camera"] = 9554027739,
                ["Pitcher Fly Hit"] = 9554028664,
                ["Pitcher Fly Victim"] = 9554029803,
                ["Cuff Bash"] = 9574861170,
                ["Chin Crusher"] = 9575094870,
                ["Meteor Strike"] = 9605034134,
                ["Meteor Strike 2"] = 9605040105
            },
            Idle = {
                Idle = 10640153820,
                StandIdle = 10640152257
            },
            Movement = {
                Walk = 10640156530,
                SummonedRun = 9557545534,
                SummonedWalk = 10640156530
            }
        },
        ["Mortal Man"] = {
            Action = {},
            Idle = {
                Idle = 7294684954
            }
        },
        STWR_R = {
            Action = {
                ["LMB-1"] = 10618698480,
                ["LMB-2"] = 10618701589,
                ["LMB-3"] = 10618705069,
                ["LMB-4"] = 10618709770,
                StandBlock = 10808688837,
                StandBlockHit1 = 10808692075,
                StandBlockHit2 = 10808695355,
                StandBlockHit3 = 10808697696,
                StandBlockBreak = 10808701329,
                BarrageStartup = 10838298509,
                Barrage = 10838301380,
                BarrageFinisher = 10603516376,
                BarrageClashEnd = 10839831781,
                Grab = 10906128504,
                Throw = 10906131878,
                ThrowVictim = 10906132668
            },
            Movement = {
                Walk = 10856503017,
                Run = 10856500879,
                SummonedWalk = 10856503017,
                SummonedRun = 10856500879,
                ForwardDash = 10838677738,
                BackwardDash = 10838687030,
                LeftDash = 10838688196,
                RightDash = 10838689289
            },
            Idle = {
                StandIdle = 11001154516,
                Idle = 11001148965
            }
        }
    }
};
local anims = u2.anims;

local function loadCode(p3) -- Line: 1407
    -- upvalues: anims (copy)
    local v4 = require(p3);

    for i, v in pairs(v4) do
        anims[i] = v;
    end;
end;

for _, child in ipairs(script:GetChildren()) do
    local success, result = pcall(loadCode, child);

    if not success then
        warn(result, child);
    end;
end;

u2.anims.Urzan = u2.anims.Reaper;
u2.anims.DTWHV = u2.anims.TWHV;
u2.anims.Dio = u2.anims["The World"];
u2.anims.Johnny = u2.anims.Tusk;

for _, v in pairs(u2.anims) do
    local v5 = {
        ForwardDash = 10451361960,
        BackwardDash = 10451359576,
        LeftDash = 10451363828,
        RightDash = 10451365211
    };

    if v.Movement then
        v.Movement = TableUtil.Reconcile(v.Movement, v5);
    else
        v.Movement = TableUtil.Copy(v5);
    end;

    if v.Action then
        if not v.Action.Block then
            v.Action.Block = 7037951229;
        end;

        if not v.Action.ComboBreaker then
            v.Action.ComboBreaker = 9967760592;
        end;

        if not v.Action.DeathAnim then
            v.Action.DeathAnim = 7070248368;
        end;
    end;
end;

local Animation = Instance.new("Animation");

local function modifyStats(p6, p7) -- Line: 1486
    for i, v in pairs(p7) do
        for i2, v2 in pairs(v) do
            p6[i][i2] = v2;
        end;
    end;

    return p6;
end;

local Animation2 = Instance.new("Animation");

local function CreateAnimationById(p8, p9) -- Line: 1497
    -- upvalues: Animation2 (copy)
    local v10 = Animation2:Clone();
    v10.Name = p8;
    v10.AnimationId = "rbxassetid://" .. tostring(p9);

    return v10;
end;

local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Skins = require(game.ReplicatedStorage.ReplicatedModules.Skins);
local u11 = game:GetService("RunService"):IsStudio();

local function AddAnims(p12, p13) -- Line: 1508
    if type(p12) ~= "table" or type(p13) ~= "table" then
        return;
    end;

    local v14 = {};

    for _, v in pairs(p12) do
        for i, _ in pairs(v) do
            v14[i] = true;
        end;
    end;

    for i, v in pairs(p13) do
        for i2, v2 in pairs(v) do
            if not v14[i2] then
                if not p12[i] then
                    p12[i] = {};
                end;

                p12[i][i2] = v2;
                v14[i2] = true;
            end;
        end;
    end;
end;

local function CreateAnims(p15) -- Line: 1460
    -- upvalues: Animation (copy)
    local v16 = {};

    for i, v in pairs(p15) do
        for i2, v2 in pairs(v) do
            for i3, v3 in pairs(v2) do
                if type(v3) ~= "table" and type(v3) ~= "userdata" then
                    local v17 = "rbxassetid://" .. v3;

                    if v16[v17] then
                        p15[i][i2][i3] = v16[v17];
                    else
                        local v18 = Animation:Clone();
                        v18.Name = i3;
                        v18.AnimationId = v17;
                        v16[v17] = v18;
                        p15[i][i2][i3] = v18;
                    end;
                end;
            end;
        end;
    end;
end;

for i, v in pairs(Skins.Funcs.GetSkins()) do
    local v19 = Stands[tonumber(i)];

    for _, v2 in pairs(v) do
        if anims[v2] and anims[v2] ~= anims[v19] then
            AddAnims(anims[v2], anims[v19]);
        else
            anims[v2] = anims[v19];
        end;
    end;
end;

function u2.SearchAnim(p20, p21) -- Line: 1548
    -- upvalues: u2 (copy), StatsHandler (copy), Animation2 (copy)
    local v22 = u2.anims[p20];

    if v22 then
        for i, v in pairs(v22) do
            for i2, v2 in pairs(v) do
                if i2 == p21 then
                    return v2, i;
                end;
            end;
        end;

        return;
    end;

    local v23 = StatsHandler.GetStats(p20);

    if not v23 then
        return;
    end;

    if v23 then
        v23 = v23.Animations;
    end;

    for i, v in pairs(v23) do
        for i2, v2 in pairs(v) do
            if p21 == i2 then
                local v24 = Animation2:Clone();
                v24.Name = p21;
                v24.AnimationId = "rbxassetid://" .. tostring(v2);

                return v24, i;
            end;
        end;
    end;
end;

function u2.GetAnim(p25, p26) -- Line: 1577
    -- upvalues: u2 (copy)
    local v27, v28 = u2.SearchAnim(p25, p26);

    if v27 and v28 then
        return {
            Animation = v27,
            Priority = v28
        };
    end;
end;

function u2.GetAnims(p29) -- Line: 1587
    -- upvalues: u2 (copy)
    if u2.anims[p29] then
        local v30 = {};

        for i, v in pairs(u2.anims[p29]) do
            for i2, v2 in pairs(v) do
                v30[i2] = {
                    Animation = v2,
                    Priority = i
                };
            end;
        end;

        return v30;
    end;
end;

CreateAnims(u2.anims);
local u31 = {};
local u32 = { "ForwardDash", "BackwardDash", "LeftDash", "RightDash" };

function u2.loadAnims(p33, p34) -- Line: 1613
    -- upvalues: u31 (copy), u2 (copy), StatsHandler (copy), Animation2 (copy)
    local Parent = p34.Parent;
    u31[Parent] = {};
    u31[Parent][p33] = {};

    if u2.anims[p33] and p34:IsDescendantOf(workspace) then
        for i, v in pairs(u2.anims[p33]) do
            for i2, v2 in pairs(v) do
                local v35 = p34:LoadAnimation(v2);
                v35.Priority = Enum.AnimationPriority[i];
                u31[Parent][p33][i2] = v35;
            end;
        end;

        return;
    end;

    if u2.anims[p33] then
        warn(p33, "not found in anims table");

        return;
    end;

    local v36 = StatsHandler.GetStats(p33);

    if v36 then
        v36 = v36.Animations;
    end;

    if v36 then
        for i, v in pairs(v36) do
            for i2, v2 in pairs(v) do
                local v37 = Animation2:Clone();
                v37.Name = i2;
                v37.AnimationId = "rbxassetid://" .. tostring(v2);
                local v38 = p34:LoadAnimation(v37);
                v38.Priority = Enum.AnimationPriority[i];

                if not u31[Parent][p33][i2] then
                    u31[Parent][p33][i2] = v38;
                end;
            end;
        end;

        return;
    end;

    warn(p33, "not found in stat anim table");
end;

function u2.playClient(u39, u40, p41, p42, p43, p44) -- Line: 1646
    -- upvalues: u31 (copy), u11 (copy), u2 (copy), u32 (copy), Trove (copy)
    if not u39 then
        return;
    end;

    local u45 = p43 and (p43.Parent or p43:FindFirstAncestorOfClass("Model")) or (game:GetService("Players").LocalPlayer.Character or nil);
    local v46 = nil;
    local v47 = false;
    local v48 = nil;

    if p44 then
        if u45 and (u45:FindFirstChild("Data") and u45.Data:FindFirstChild("Skin")) then
            v48 = u45.Data.Skin:GetAttribute("SkinName");
        end;
    else
        local v49 = game:GetService("Players"):GetPlayerFromCharacter(u45);

        if v49 then
            v48 = v49.Data.Skin:GetAttribute("SkinName");

            if v49.Character then
                local Stand = v49.Character:FindFirstChild("Stand");

                if Stand and Stand:GetAttribute("SkinName") then
                    v48 = Stand:GetAttribute("SkinName");
                end;
            end;
        end;
    end;

    if not u31[u45] then
        u31[u45] = {};
    end;

    if v48 then
        if not u31[u45][v48] then
            u31[u45][v48] = {};
        end;

        if u31[u45][v48][u40] then
            v46 = u31[u45][v48][u40];
            v47 = true;
        end;
    else
        if not u31[u45][u39] then
            u31[u45][u39] = {};
        end;

        if u31[u45][u39][u40] then
            v46 = u31[u45][u39][u40];
            v47 = true;
        end;
    end;

    if not v47 then
        local v50 = p43 or (u45.Humanoid or nil);

        if not v50 then
            if u11 then
                warn("No Animation Humanoid found");
            end;

            return;
        end;

        if not v50:IsDescendantOf(workspace) then
            warn("humanoid not descendant of workspace");

            return;
        end;

        local v51, v52;

        if v48 then
            v51, v52 = u2.SearchAnim(v48, u40);
        else
            v51 = nil;
            v52 = nil;
        end;

        if not (v51 or v52) then
            v51, v52 = u2.SearchAnim(u39, u40);
        end;

        local v53 = p41 or v52;

        if v51 then
            v46 = v50:LoadAnimation(v51);

            if v48 then
                u31[u45][v48][u40] = v46;
            else
                u31[u45][u39][u40] = v46;
            end;

            if v53 then
                v46.Priority = v53;
                v47 = true;
            else
                v47 = true;
            end;
        end;
    end;

    if v46 and v47 then
        if table.find(u32, u40) then
            u45:SetAttribute("Dashing", true);
        end;

        local u54 = Trove.new();
        u54:Add(v46.Stopped:Connect(function() -- Line: 1730
            -- upvalues: u32 (ref), u40 (copy), u45 (copy), u31 (ref), u39 (copy), u54 (copy)
            if table.find(u32, u40) then
                u45:SetAttribute("Dashing", false);
            end;

            if u31[u45][u39] then
                u31[u45][u39][u40] = nil;
            end;

            u54:Destroy();
        end));
        v46:Play(nil, nil, p42 or 1);

        return v46;
    end;
end;

function u2.adjustAnimSpeed(p55, p56, p57, p58) -- Line: 1744
    -- upvalues: u31 (copy)
    local v59 = p58 and p58.Parent or game.Players.LocalPlayer.Character;
    local v60 = nil;
    local v61 = false;
    local v62 = game:GetService("Players"):GetPlayerFromCharacter(v59);
    local v63;

    if v62 then
        v63 = v62.Data.Skin:GetAttribute("SkinName");

        if v62.Character then
            local Stand = v62.Character:FindFirstChild("Stand");

            if Stand and Stand:GetAttribute("SkinName") then
                v63 = Stand:GetAttribute("SkinName");
            end;
        end;
    else
        v63 = nil;
    end;

    if v63 and (u31[v59] and (u31[v59][v63] and u31[v59][v63][p56])) then
        v60 = u31[v59][v63][p56];
        v61 = true;
    end;

    if not v61 and (u31[v59] and (u31[v59][p55] and u31[v59][p55][p56])) then
        v60 = u31[v59][p55][p56];
    end;

    v60:AdjustSpeed(p57 or 1);

    return v60;
end;

function u2.stopClient(p64, p65, p66, p67) -- Line: 1775
    -- upvalues: u31 (copy), u11 (copy)
    local v68 = p66 or (game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait());
    local v69 = nil;

    if not p67 then
        local v70 = game:GetService("Players"):GetPlayerFromCharacter(v68);

        if v70 then
            v69 = v70.Data.Skin:GetAttribute("SkinName");

            if v70.Character then
                local Stand = v70.Character:FindFirstChild("Stand");

                if Stand and Stand:GetAttribute("SkinName") then
                    v69 = Stand:GetAttribute("SkinName");
                end;
            end;
        end;
    end;

    local v71;

    if v69 then
        v71 = u31[v68] and u31[v68][v69] and u31[v68][v69][p65];
    else
        v71 = nil;
    end;

    if not v71 then
        v71 = u31[v68] and u31[v68][p64] and u31[v68][p64][p65];
    end;

    if v71 then
        if v71.IsPlaying then
            v71:Stop();
        end;
    else
        if p67 then
            for _, v in ipairs(v68:FindFirstChildWhichIsA("Humanoid"):GetPlayingAnimationTracks()) do
                if v.Name == p64 .. "-" .. p65 then
                    v:Stop();
                end;
            end;

            return;
        end;

        if u11 then
            warn(p64, p65, debug.traceback("anim not found for stand"));
        end;
    end;
end;

function u2.FindAnim(p72, p73, p74, p75) -- Line: 1815
    -- upvalues: u2 (copy)
    local v76 = p74 and (p74.Parent or p74:FindFirstAncestorOfClass("Model")) or (game:GetService("Players").LocalPlayer.Character or nil);
    local v77 = nil;

    if p75 then
        if v76 and (v76:FindFirstChild("Data") and v76.Data:FindFirstChild("Skin")) then
            v77 = v76.Data.Skin:GetAttribute("SkinName");
        end;
    else
        local v78 = game:GetService("Players"):GetPlayerFromCharacter(v76);

        if v78 then
            v77 = v78.Data.Skin:GetAttribute("SkinName");

            if v78.Character then
                local Stand = v78.Character:FindFirstChild("Stand");

                if Stand and Stand:GetAttribute("SkinName") then
                    v77 = Stand:GetAttribute("SkinName");
                end;
            end;
        end;
    end;

    local v79, v80;

    if v77 then
        v79, v80 = u2.SearchAnim(v77, p73);
    else
        v79 = nil;
        v80 = nil;
    end;

    if not (v79 or v80) then
        v79, v80 = u2.SearchAnim(p72, p73);
    end;

    return v79, v80;
end;

return u2;
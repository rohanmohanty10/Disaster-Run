  

 

return {
    Inherit = {
        AbilityName = "Killer Queen"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(209, 152, 52)), ColorSequenceKeypoint.new(1, Color3.fromRGB(211, 155, 43)) })
        }
    },
    Animations = {
        Action = {
            PoseIdle = 14732726758,
            PoseTransition = 14732724714
        },
        Idle = {
            Idle = 14732721593,
            SummonedIdle = 14732721593
        }
    },
    Sounds = {
        SummonEffects = {
            SoundId = 14722961770,
            Volume = 2
        },
        SummonSound = {
            SoundId = 14722961653,
            Volume = 4
        },
        Desummon = {
            SoundId = 14722962423,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 10927467009,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 10927937748,
            Volume = 2
        },
        ["LMB-1"] = {
            SoundId = 10842905304,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 10842905185,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 10842905241,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 10842905370,
            Volume = 2
        },
        ["SwingLMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingLMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        ["StandOff-LMB-1"] = {
            SoundId = 10842905304,
            Volume = 2
        },
        ["StandOff-LMB-2"] = {
            SoundId = 10842905185,
            Volume = 2
        },
        ["StandOff-LMB-3"] = {
            SoundId = 10842905241,
            Volume = 2
        },
        ["StandOff-LMB-4"] = {
            SoundId = 10842905370,
            Volume = 2
        },
        ["SwingStandOff-LMB 1-3"] = {
            SoundId = 10626699259,
            Volume = 2
        },
        ["SwingStandOff-LMB 4"] = {
            SoundId = 10626764953,
            Volume = 2
        },
        BarrageVoiceline = {
            SoundId = 14722962542,
            Volume = 3
        },
        Barrage = {
            SoundId = 10835571201,
            Volume = 3
        },
        Grab = {
            SoundId = 10906275061,
            Volume = 2
        },
        Grabbed = {
            SoundId = 10906275262,
            Volume = 2
        },
        Throw = {
            SoundId = 10906746801,
            Volume = 3
        },
        ThrowVoiceline = {
            SoundId = 10919755744,
            Volume = 2
        },
        PowerSFX = {
            SoundId = 10920809881,
            Volume = 2
        },
        PowerVoice = {
            SoundId = 10920810178,
            Volume = 2
        },
        PrimaryV1 = {
            SoundId = 10842751862,
            Volume = 3
        },
        PrimaryV2 = {
            SoundId = 10842751768,
            Volume = 3
        },
        PrimaryV3 = {
            SoundId = 10842751660,
            Volume = 3
        },
        PrimaryV4 = {
            SoundId = 10842751526,
            Volume = 3
        },
        ClickSwitch = {
            SoundId = 10842752271,
            Volume = 3
        },
        Planted = {
            SoundId = 6425414680,
            Volume = 1
        },
        BombPlace = {
            SoundId = 7167739366,
            Volume = 2
        },
        UppercutVoice = {
            SoundId = 14722963082,
            Volume = 2
        },
        UppercutSFX = {
            SoundId = 10847606454,
            Volume = 2
        },
        RestrainVoice = {
            SoundId = 14723059604,
            Volume = 2
        },
        RestrainBeginning = {
            SoundId = 14722961909,
            Volume = 2
        },
        RestrainConnect = {
            SoundId = 10855818191,
            Volume = 2
        },
        BombPlantVLAttempt = {
            SoundId = 14722962323,
            Volume = 2
        },
        BombPlantSuccessVL = {
            SoundId = 10897845160,
            Volume = 2
        },
        BombPlantKicksWoosh = {
            SoundId = 10897845160,
            Volume = 2
        },
        BombPlantSFX = {
            SoundId = 10897845423,
            Volume = 2
        },
        ArmChopVoice = {
            SoundId = 14722962248,
            Volume = 2
        },
        ArmChopSwing = {
            SoundId = 14722963210,
            Volume = 2
        },
        ["Face Slam Startup SFX"] = {
            SoundId = 10913283245,
            Volume = 2
        },
        ["Face Slam Startup Voiceline"] = {
            SoundId = 10913301852,
            Volume = 2
        },
        ["Face Slam"] = {
            SoundId = 10920548335,
            Volume = 2
        },
        ["Power Display Voice"] = {
            SoundId = 10920810178,
            Volume = 2
        },
        ["Power Display Swing"] = {
            SoundId = 14722962960,
            Volume = 2
        },
        ["Quadruple Bomb Finish Startup Woosh"] = {
            SoundId = 10944295541,
            Volume = 2
        },
        ["Quadruple Bomb Finish Startup Voice"] = {
            SoundId = 10944295608,
            Volume = 2
        },
        ["Quadruple Bomb Finish SFX"] = {
            SoundId = 14730521243,
            Volume = 2
        },
        ["Quadruple Bomb Finish Voice"] = {
            SoundId = 14730520173,
            Volume = 2
        },
        ["Yen Throw Voice"] = {
            SoundId = 14722962062,
            Volume = 2
        },
        ["Yen Throw SFX"] = {
            SoundId = 10969901566,
            Volume = 2
        },
        ["SHA Voice"] = {
            SoundId = 11118195383,
            Volume = 2
        },
        ["SHA SFX"] = {
            SoundId = 11118195236,
            Volume = 2
        },
        QuickPlantWoosh = {
            SoundId = 11159624051,
            Volume = 2
        },
        QuickPlantVoice = {
            SoundId = 14722962767,
            Volume = 2
        },
        QuickPlantSuccededVoice = {
            SoundId = 14722962667,
            Volume = 2
        },
        QuickPlantSucceededSFX = {
            SoundId = 11159624170,
            Volume = 2
        }
    }
};
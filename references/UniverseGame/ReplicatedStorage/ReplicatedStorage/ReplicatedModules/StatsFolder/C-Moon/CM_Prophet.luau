  

 

return {
    Inherit = {
        AbilityName = "C-Moon"
    },
    Stats = {
        Summon = {
            LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) })
        }
    },
    Sounds = {
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://14076384811",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://13138398499",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://14076351826",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Desummon-Voiceline"] = {
            SoundId = "rbxassetid://13140811156",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Remote-Summon-SFX"] = {
            SoundId = "rbxassetid://13140811987",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["Remote-Summon-Voiceline"] = {
            SoundId = "rbxassetid://13140812166",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-1"] = {
            SoundId = "rbxassetid://13138396672",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://13138397155",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://13138395129",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://13138397447",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1"] = {
            SoundId = "rbxassetid://11038125106",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-1-Voiceline"] = {
            SoundId = "rbxassetid://13138398947",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2"] = {
            SoundId = "rbxassetid://11038124864",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-2-Voiceline"] = {
            SoundId = "rbxassetid://13138399064",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3"] = {
            SoundId = "rbxassetid://11038212735",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-3-Voiceline"] = {
            SoundId = "rbxassetid://13138398815",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4"] = {
            SoundId = "rbxassetid://11038125897",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ["StandOff-LMB-4-Voiceline"] = {
            SoundId = "rbxassetid://13138398667",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageVoiceline = {
            SoundId = 13138398177,
            Volume = 2
        },
        BarrageRemoteVoiceline = {
            SoundId = 11247047593,
            Volume = 2
        },
        Barrage = {
            SoundId = 11033137843,
            Volume = 2
        },
        CenterOfGravity = {
            SoundId = "rbxassetid://14076351189",
            Volume = 2
        },
        CenterOfGravityVoiceline = {
            SoundId = 13138397000,
            Volume = 2
        },
        InversionStrike = {
            SoundId = "rbxassetid://14076352557",
            Volume = 2
        },
        InversionStrikeVoiceline = {
            SoundId = 13138397566,
            Volume = 2
        },
        InversionStrikeRemoteVoiceline = {
            SoundId = 11247048144,
            Volume = 2
        },
        HeartInversion = {
            SoundId = "rbxassetid://14076352036",
            Volume = 2
        },
        HeartInversionVoiceline = {
            SoundId = 13138397974,
            Volume = 2
        },
        HeartInversionRemoteVoiceline = {
            SoundId = 13140811271,
            Volume = 2
        },
        ArmCrusher = {
            SoundId = "rbxassetid://14076351701",
            Volume = 2
        },
        ArmCrusherVoiceline = {
            SoundId = "rbxassetid://14076351281",
            Volume = 2
        },
        SingularityPoint = {
            SoundId = "rbxassetid://14076351376",
            Volume = 2
        },
        SingularityPointVoiceline = {
            SoundId = 13138396832,
            Volume = 2
        },
        SingularityPointRemoteVoiceline = {
            SoundId = 13140811428,
            Volume = 2
        },
        SingularityPointPull = {
            SoundId = 11062790870,
            Volume = 2
        },
        BodyInversion = {
            SoundId = "rbxassetid://14076352194",
            Volume = 2
        },
        BodyInversionVoiceline = {
            SoundId = 13138397684,
            Volume = 2
        },
        BodyInversionHit = {
            SoundId = "rbxassetid://14076352367",
            Volume = 2
        },
        BodyInversionHitVoiceline = {
            SoundId = 13138397321,
            Volume = 2
        },
        DebrisShotgun = {
            SoundId = "rbxassetid://14076351905",
            Volume = 2
        },
        DebrisShotgunVoiceline = {
            SoundId = 13140811840,
            Volume = 2
        },
        DebrisShotgunRemoteVoiceline = {
            SoundId = 13140811840,
            Volume = 2
        },
        DebrisHit = {
            SoundId = 11038432217,
            Volume = 2
        },
        PalmKinesis = {
            SoundId = "rbxassetid://14076352724",
            Volume = 2
        },
        PalmKinesisVoiceline = {
            SoundId = "rbxassetid://14076352837",
            Volume = 2
        },
        PalmKinesisRemoteVoiceline = {
            SoundId = 13140810414,
            Volume = 2
        },
        Elimination = {
            SoundId = 13138396268,
            Volume = 2
        },
        EliminationVoiceline = {
            SoundId = 13138395833,
            Volume = 2
        },
        EliminationStartup = {
            SoundId = 13138396043,
            Volume = 2
        },
        EliminationStartupVoiceline = {
            SoundId = 13138398350,
            Volume = 2
        },
        GravityFieldReflect = {
            SoundId = 11247015936,
            Volume = 2
        },
        GravityField = {
            SoundId = 13140811657,
            Looped = true,
            Volume = 2
        },
        GravityFieldVoiceline = {
            SoundId = 13138396502,
            Volume = 2
        },
        Count = {
            SoundId = "rbxassetid://10083836299",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Grab = {
            SoundId = 11038643123,
            Volume = 2
        },
        Grabbed = {
            SoundId = 11038640046,
            Volume = 2
        },
        GrabbedVoiceline = {
            SoundId = 13140810868,
            Volume = 2
        },
        MeterUp3 = {
            SoundId = 13140811020,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 13140810545,
            Volume = 2
        },
        LesserInversion = {
            SoundId = 11038852708,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 10455940821,
            Volume = 2,
            Looped = true,
            PlaybackSpeed = 1,
            TimePosition = 0
        }
    }
};
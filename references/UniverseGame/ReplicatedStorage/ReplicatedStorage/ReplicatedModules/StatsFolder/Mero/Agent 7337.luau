  

 

local v1 = {
    Hit = {
        SoundId = 122935768049018,
        Volume = 0.75
    }
};
local v2 = {
    Hit = {
        SoundId = 128400778217644,
        Volume = 0.5
    }
};
local v3 = {
    Hit = {
        SoundId = 75875407941555,
        Volume = 0.75
    }
};

return {
    Inherit = {
        AbilityName = "Mero"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitSounds = v1
            },
            ["LMB-2"] = {
                HitSounds = v1
            },
            ["LMB-3"] = {
                HitSounds = v1
            },
            ["LMB-4"] = {
                HitSounds = v2
            }
        },
        Pose = {
            MusicAmount = 2
        },
        ["Lovely Legwork"] = {
            HitSounds = v3
        },
        ["Perfume Femur Magna"] = {
            HitSounds = v1,
            Finisher = {
                HitSounds = v2
            }
        },
        ["Perfume Fever"] = {
            HitSounds = v3,
            Finisher = {
                HitSounds = v2
            }
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 113730704318664,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 2.2123893805309733
        },
        ["PoseMusic-2"] = {
            SoundId = 118253375226481,
            Volume = 1,
            Looped = true,
            PlaybackSpeed = 3.058103975535168
        },
        ["Lovely Legwork Voiceline"] = {
            SoundId = 16835047927,
            Volume = 0
        },
        ["Lovely Legwork SFX"] = {
            SoundId = 131399367317785,
            Volume = 1
        },
        ["Magna Voiceline"] = {
            SoundId = 16835047271,
            Volume = 0
        },
        ["Magna SFX"] = {
            SoundId = 75523991995912,
            Volume = 1
        },
        ["Mellow Voiceline"] = {
            SoundId = 16835046272,
            Volume = 0
        },
        ["Mellow SFX"] = {
            SoundId = 16835045346,
            Volume = 1
        },
        ["Perfume Fever Voiceline"] = {
            SoundId = 16841223934,
            Volume = 0
        },
        ["Perfume Fever SFX"] = {
            SoundId = 116144861497987,
            Volume = 1
        },
        ["Pistol Kiss Startup Voiceline"] = {
            SoundId = 16835045177,
            Volume = 0
        },
        ["Pistol Kiss Voiceline"] = {
            SoundId = 16835045820,
            Volume = 0
        },
        ["Pistol Kiss SFX"] = {
            SoundId = 140513708944478,
            Volume = 1
        },
        ["Pistol Kiss Charging"] = {
            SoundId = 118918731541957,
            Volume = 1
        },
        ["Pistol Kiss Charged Shot"] = {
            SoundId = 122821210431580,
            Volume = 1
        },
        ["Pistol Kiss Uncharged Shot"] = {
            SoundId = 122821210431580,
            Volume = 1
        },
        ["Pistol Kiss Wall Impact"] = {
            SoundId = 75354892653758,
            Volume = 1
        },
        ["Pistol Kiss Charge Indicator"] = {
            SoundId = 100627607439952,
            Volume = 1
        },
        ["Queen Stomp Startup Voiceline"] = {
            SoundId = 16835046959,
            Volume = 0
        },
        ["Queen Stomp Startup SFX"] = {
            SoundId = 133420338160498,
            Volume = 1
        },
        ["Queen Stomp Voiceline"] = {
            SoundId = 16835046411,
            Volume = 0
        },
        ["Queen Stomp SFX"] = {
            SoundId = 113263784926313,
            Volume = 1
        },
        Petrify = {
            SoundId = 107933101967519,
            Volume = 1
        },
        Unpetrify = {
            SoundId = 107933101967519,
            Volume = 1
        },
        ["Infatuation Voiceline"] = {
            SoundId = 16835044575,
            Volume = 0
        },
        ["Infatuation SFX"] = {
            SoundId = 102844236332040,
            Volume = 0.85,
            RollOffMaxDistance = 200
        },
        ["Infatuation Release SFX"] = {
            SoundId = 92904052633966,
            Volume = 1,
            RollOffMaxDistance = 200
        },
        ["Infatuation Music 1"] = {
            SoundId = 116109009142758,
            Volume = 0.75,
            RollOffMaxDistance = 200
        },
        ["Infatuation Music 2"] = {
            SoundId = 87895429776383,
            Volume = 0.75,
            RollOffMaxDistance = 200
        },
        ["Infatuation Music 3"] = {
            SoundId = 129622219220297,
            Volume = 0.75,
            RollOffMaxDistance = 200
        },
        ["Petrifying Burst SFX"] = {
            SoundId = 112977254198776,
            Volume = 1
        },
        ["Petrifying Burst Shoot SFX"] = {
            SoundId = 16841223458,
            Volume = 0
        },
        ["Petrifying Burst Voiceline"] = {
            SoundId = 16841223665,
            Volume = 0
        },
        ["Petrifying Burst Land"] = {
            SoundId = 75354892653758,
            Volume = 1
        },
        ["LMB-1"] = {
            SoundId = 16841225495,
            Volume = 0
        },
        ["LMB-2"] = {
            SoundId = 16841225123,
            Volume = 0
        },
        ["LMB-3"] = {
            SoundId = 16841226462,
            Volume = 0
        },
        ["LMB-4"] = {
            SoundId = 16841362382,
            Volume = 0
        },
        ["LMB-1SFX"] = {
            SoundId = 112646403457638,
            Volume = 1
        },
        ["LMB-2SFX"] = {
            SoundId = 93971815468767,
            Volume = 1
        },
        ["LMB-3SFX"] = {
            SoundId = 90233795897840,
            Volume = 1
        },
        ["LMB-4SFX"] = {
            SoundId = 100020451749073,
            Volume = 1
        },
        ["LMB-4Slam"] = {
            SoundId = 101666723819363,
            Volume = 1
        },
        ["Heartless Startup Voiceline"] = {
            SoundId = 16846806676,
            Volume = 0
        },
        ["Heartless Startup SFX"] = {
            SoundId = 138145518200561,
            Volume = 1
        },
        ["Heartless Voiceline"] = {
            SoundId = 16846807180,
            Volume = 0
        },
        ["Heartless SFX"] = {
            SoundId = 138538702170207,
            Volume = 1
        },
        ["Heartless Music"] = {
            SoundId = 97097289969318,
            Volume = 1,
            PlaybackSpeed = 1
        },
        ["Cupid\'s Yumi Shoot SFX"] = {
            SoundId = 16901353377,
            Volume = 0
        },
        ["Cupid\'s Yumi SFX"] = {
            SoundId = 109922111085884,
            Volume = 1
        },
        ["Cupid\'s Yumi Voiceline"] = {
            SoundId = 16901353486,
            Volume = 0
        },
        ["Cupid\'s Yumi Explode"] = {
            SoundId = 71699611149407,
            Volume = 1
        },
        MeterUp1 = {
            SoundId = 100082114524973,
            Volume = 0
        },
        MeterUp2 = {
            SoundId = 92812574858806,
            Volume = 1,
            PlaybackSpeed = 2
        },
        MeterUp3 = {
            SoundId = 130276347719681,
            Volume = 0
        },
        MeterUp4 = {
            SoundId = 96718172895555,
            Volume = 1,
            PlaybackSpeed = 2
        }
    }
};
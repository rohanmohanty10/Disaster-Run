  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local v1 = {
    SFX = {
        ["Form Switch SFX"] = {
            SoundId = 124034020525428,
            Volume = 2.75,
            PlaybackSpeed = 1
        },
        ["Pandora Clock SFX"] = {
            SoundId = 743521450,
            Volume = 1,
            PlaybackSpeed = 1.2
        },
        SovereignAwaken = {
            SoundId = 78883445222058,
            Volume = 1
        },
        ["Mayhem-SovereignAwaken"] = {
            SoundId = 90804769315160,
            Volume = 1
        },
        ["Rainbow-SovereignAwaken"] = {
            SoundId = 90804769315160,
            Volume = 1
        },
        ["Chaos-SovereignAwaken"] = {
            SoundId = 90804769315160,
            Volume = 1
        },
        ["Catastrophe-SovereignAwaken"] = {
            SoundId = 90804769315160,
            Volume = 1
        },
        ["Mayhem-Sovereign-Voiceline"] = {
            SoundId = 84130279026228,
            Volume = 4.5
        },
        ["Purity-Sovereign-Voiceline"] = {
            SoundId = 79361642359798,
            Volume = 4.5
        },
        ["Divinity-Sovereign-Voiceline"] = {
            SoundId = 105460080369487,
            Volume = 4.5
        },
        ["Love-Sovereign-Voiceline"] = {
            SoundId = 82823360661468,
            Volume = 4.5
        },
        ["Rainbow-Sovereign-Voiceline"] = {
            SoundId = 78057085545986,
            Volume = 4.5
        },
        ["FallenX-Sovereign-Voiceline"] = {
            SoundId = 130856529368307,
            Volume = 4.5
        },
        ["Crazed-Sovereign-Voiceline"] = {
            SoundId = 128850273879685,
            Volume = 4.5
        },
        ["Omega-Sovereign-Voiceline"] = {
            SoundId = 76332154485668,
            Volume = 4.5
        },
        ["Equinox-Sovereign-Voiceline"] = {
            SoundId = 80170832062042,
            Volume = 4.5
        },
        ["SHD-Sovereign-Voiceline"] = {
            SoundId = 78533591132860,
            Volume = 4.5
        },
        ["Pandora-Sovereign-Voiceline"] = {
            SoundId = 76856321371935,
            Volume = 4.5
        },
        ["Calamity-Sovereign-Voiceline"] = {
            SoundId = 125532997386196,
            Volume = 4.5
        },
        ["Destiny-Sovereign-Voiceline"] = {
            SoundId = "",
            Volume = 0
        },
        ["Catastrophe-Sovereign-Voiceline"] = {
            SoundId = "",
            Volume = 0
        },
        ["Corruption-Sovereign-Voiceline"] = {
            SoundId = 140585264735914,
            Volume = 4.5
        },
        ["Boing-Sovereign-Voiceline"] = {
            SoundId = 107508312606832,
            Volume = 6
        },
        ["PiercingVoid-First"] = {
            SoundId = 136929343879606,
            Volume = 3
        },
        ["PiercingVoid-Second"] = {
            SoundId = 89741389271416,
            Volume = 3
        }
    },
    ["Sovereign SFX"] = {
        ["Sovereign-LMB-1"] = {
            SoundId = 85115307447729,
            Volume = 1.25
        },
        ["Sovereign-LMB-2"] = {
            SoundId = 138911154572122,
            Volume = 1.25
        },
        ["Sovereign-LMB-3"] = {
            SoundId = 113068114723435,
            Volume = 1.25
        },
        ["Sovereign-LMB-4"] = {
            SoundId = 109720411518272,
            Volume = 1.25
        },
        ["SwallowingVoid-First"] = {
            SoundId = 102370254461578,
            Volume = 3
        },
        ["SwallowingVoid-Second"] = {
            SoundId = 103452390616931,
            Volume = 3
        },
        Whirlwind = {
            SoundId = 80710529329683,
            Volume = 3
        },
        ThreefoldSlice = {
            SoundId = 122754459163433,
            Volume = 2
        },
        ["SwordImpalement-Startup"] = {
            SoundId = 122889910629383,
            Volume = 1.5
        },
        ["SwordImpalement-Loop"] = {
            SoundId = 90829068690218,
            Volume = 1.5
        },
        ["SwordImpalement-Final"] = {
            SoundId = 88151502681676,
            Volume = 1.5
        },
        ["SwordImpalement-Spawn"] = {
            SoundId = 89782324373919,
            Volume = 1.5
        },
        Devastation = {
            SoundId = 75504952463103,
            Volume = 3
        },
        ["Devastation-Sword"] = {
            SoundId = ""
        },
        ["Devastation-Impact"] = {
            SoundId = 108091664735470,
            Volume = 2.5,
            RollOffMaxDistance = 350
        },
        AscendedPunishment = {
            SoundId = 122726917579187,
            Volume = 2
        },
        FallenLeaves = {
            SoundId = 74883005449812,
            Volume = 2
        },
        ["FallenLeaves-Teleport"] = {
            SoundId = 108544101023096,
            Volume = 1.5
        },
        ["FallenLeaves-Jump"] = {
            SoundId = 96618983966778,
            Volume = 2.5
        },
        ["Universal-Aura"] = {
            SoundId = 85992169391254,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    ["MAYHEM Sovereign SFX"] = {
        ["Mayhem-SwallowingVoid-First"] = {
            SoundId = 90128434250963,
            Volume = 2.5
        },
        ["Mayhem-SwallowingVoid-Second"] = {
            SoundId = 79970809196175,
            Volume = 2.5
        },
        ["Mayhem-Whirlwind"] = {
            SoundId = 101048629925200,
            Volume = 1.5
        },
        ["Mayhem-ThreefoldSlice"] = {
            SoundId = 83323444702317,
            Volume = 2
        },
        ["Mayhem-SwordImpalement-Startup"] = {
            SoundId = 117596030130137,
            Volume = 1.5
        },
        ["Mayhem-SwordImpalement-Loop"] = {
            SoundId = 131096172938639,
            Volume = 1.5
        },
        ["Mayhem-SwordImpalement-Final"] = {
            SoundId = 73466106755930,
            Volume = 1.5
        },
        ["Mayhem-SwordImpalement-Spawn"] = {
            SoundId = 111857261238971,
            Volume = 1.5
        },
        ["Mayhem-Devastation"] = {
            SoundId = 89226974582615,
            Volume = 3
        },
        ["Mayhem-Devastation-Sword"] = {
            SoundId = ""
        },
        ["Mayhem-Devastation-Impact"] = {
            SoundId = 118327952962402,
            Volume = 2,
            RollOffMaxDistance = 350
        },
        ["Mayhem-AscendedPunishment"] = {
            SoundId = 128360988324854,
            Volume = 1.5
        },
        ["Mayhem-FallenLeaves"] = {
            SoundId = 95874542969694,
            Volume = 1.5
        },
        ["Mayhem-FallenLeaves-Teleport"] = {
            SoundId = 104805500100253,
            Volume = 1.5
        },
        ["Mayhem-FallenLeaves-Jump"] = {
            SoundId = 112477642851222,
            Volume = 2.5
        },
        ["Mayhem-Grab-Startup"] = {
            SoundId = 98320527302611,
            Volume = 4
        }
    },
    Music = {
        Mayhem_Music = {
            SoundId = 86134682395953,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Purity_Music = {
            SoundId = 114014428992370,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 169.132),
            LoopRegion = NumberRange.new(6.188, 169.132)
        },
        Purity_Music_OLD = {
            SoundId = 119204454472722,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 258.947),
            LoopRegion = NumberRange.new(22.737, 258.947)
        },
        Corruption_Music = {
            SoundId = 127791888382477,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(10.577, 600000)
        },
        Divinity_Music = {
            SoundId = 139103447372584,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(20.212, 600000)
        },
        Equinox_Music = {
            SoundId = 98826225479266,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Destiny_Music = {
            SoundId = 98993529238030,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Rainbow_Music = {
            SoundId = 79498306907194,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Omega_Music = {
            SoundId = 140547936431848,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Pandora_Music = {
            SoundId = 98374330991909,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Chaos_Music = {
            SoundId = 111453049679498,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(24.828, 600000)
        },
        Love_Music = {
            SoundId = 121745358813651,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        SHD_Music = {
            SoundId = 101112221546873,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Crazed_Music = {
            SoundId = 71129604568992,
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        FallenX_Music = {
            SoundId = 116327010388191,
            Volume = 2.75,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Calamity_Music = {
            SoundId = 104230140792705,
            Volume = 2.65,
            PlaybackSpeed = 0.957,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Catastrophe_Music = {
            SoundId = 78997016065087,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Boing_Music = {
            SoundId = 76712636434200,
            Volume = 3,
            PlaybackSpeed = 1.6,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(22.3072, 600000)
        },
        Neptunian_Music = {
            SoundId = 132883618654609,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Violence_Music = {
            SoundId = 90034092279609,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        RainbowEasterEgg = {
            SoundId = 121890728751707,
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(19.518, 600000)
        }
    },
    PoseMusics = {
        Base_PoseMusic = {
            SoundId = 90628476237391,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Mayhem_PoseMusic = {
            SoundId = 133292243253295,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(24.159, 600000)
        },
        ["Purity_PoseMusic-1"] = {
            SoundId = 89063117364138,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Purity_PoseMusic-2"] = {
            SoundId = 76317517866392,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Corruption_PoseMusic-1"] = {
            SoundId = 99657513876405,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(6.399, 600000)
        },
        ["Corruption_PoseMusic-2"] = {
            SoundId = 71035677310850,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0.364, 600000)
        },
        ["Divinity_PoseMusic-1"] = {
            SoundId = 131501210140813,
            Volume = 3,
            PlaybackSpeed = 1.1111111111111112,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Divinity_PoseMusic-2"] = {
            SoundId = 77345901835595,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(34.486, 600000)
        },
        ["Rainbow_PoseMusic-1"] = {
            SoundId = 104866877059771,
            Volume = 2.75,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Rainbow_PoseMusic-2"] = {
            SoundId = 18429109143,
            Volume = 2.75,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Chaos_PoseMusic-1"] = {
            SoundId = 74589901940110,
            Volume = 3,
            PlaybackSpeed = 1.25,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Chaos_PoseMusic-2"] = {
            SoundId = 98956229210492,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Equinox_PoseMusic-1"] = {
            SoundId = 87781404200217,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Equinox_PoseMusic-2"] = {
            SoundId = 137066246202824,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(110.014, 600000)
        },
        ["Crazed_PoseMusic-1"] = {
            SoundId = 130383050872101,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Crazed_PoseMusic-2"] = {
            SoundId = 96293805687293,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Omega_PoseMusic-1"] = {
            SoundId = 112534532745326,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Omega_PoseMusic-2"] = {
            SoundId = 90441897035451,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(1.244, 600000)
        },
        ["Calamity_PoseMusic-1"] = {
            SoundId = 131641688570221,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Calamity_PoseMusic-2"] = {
            SoundId = 120363168589000,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["SHD_PoseMusic-1"] = {
            SoundId = 140099807815560,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["SHD_PoseMusic-2"] = {
            SoundId = 134630364218327,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["FallenX_PoseMusic-1"] = {
            SoundId = 108339274670356,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["FallenX_PoseMusic-2"] = {
            SoundId = 121181558699650,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        Pandora_PoseMusic = {
            SoundId = 101972514973652,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Love_PoseMusic-1"] = {
            SoundId = 120892999950515,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Love_PoseMusic-2"] = {
            SoundId = 131756431977484,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Love_PoseMusic-3"] = {
            SoundId = 137070071766682,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Destiny_PoseMusic-1"] = {
            SoundId = 72339792160108,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Destiny_PoseMusic-2"] = {
            SoundId = 87895958631120,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Catastrophe_PoseMusic-1"] = {
            SoundId = 82790411640661,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Catastrophe_PoseMusic-2"] = {
            SoundId = 138970681087892,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Neptunian_PoseMusic-1"] = {
            SoundId = 104172398743396,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(11.952, 600000)
        },
        ["Neptunian_PoseMusic-2"] = {
            SoundId = 95398395942456,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Neptunian_PoseMusic-3"] = {
            SoundId = 74852554539172,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = true,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(6.226, 600000)
        },
        ["Boing_PoseMusic-1"] = {
            SoundId = 134415674464497,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        },
        ["Boing_PoseMusic-2"] = {
            SoundId = 106002560519032,
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = true,
            PlaybackRegionsEnabled = false,
            IsEmote = true,
            PlaybackRegion = NumberRange.new(0, 600000),
            LoopRegion = NumberRange.new(0, 600000)
        }
    },
    Base = {
        ["LMB-1"] = {
            SoundId = 116367488770851,
            Volume = 1.25
        },
        ["LMB-2"] = {
            SoundId = 78130669115349,
            Volume = 1.25
        },
        ["LMB-3"] = {
            SoundId = 97957854373516,
            Volume = 1.25
        },
        ["LMB-4"] = {
            SoundId = 92641156862301,
            Volume = 1.25
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 106855010642935,
            Volume = 1.25
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 90857760298412,
            Volume = 1.25
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 108560634125327,
            Volume = 1.25
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 108641272195311,
            Volume = 1.25
        },
        MeterUp1 = {
            SoundId = 95836895776317,
            Volume = 3.75
        },
        MeterUp2 = {
            SoundId = 112534711443341,
            Volume = 3.75
        },
        MeterUp3 = {
            SoundId = 120592096661481,
            Volume = 3.75
        },
        MeterUp4 = {
            SoundId = 90668692960416,
            Volume = 3.75
        },
        ["MeterUp4-Sovereign"] = {
            SoundId = 114098161865708,
            Volume = 4
        },
        UmbralDash = {
            SoundId = 137111984410303,
            Volume = 1.25
        },
        ["Grab-Startup"] = {
            SoundId = 75883117249587,
            Volume = 2.25
        },
        ["Grab-Voiceline"] = {
            SoundId = 116373268387639,
            Volume = 2
        },
        ["Grab-Hit"] = {
            SoundId = ""
        },
        SnowstormHelix = {
            SoundId = 99977981737253,
            Volume = 3
        },
        ["SnowstormHelix-Voiceline-1"] = {
            SoundId = 124375850022934,
            Volume = 1.5
        },
        ["SnowstormHelix-Voiceline-2"] = {
            SoundId = 81009158078771,
            Volume = 1.5
        },
        WindShower = {
            SoundId = 78102819121741,
            Volume = 3.25
        },
        ["WindShower-Final"] = {
            SoundId = ""
        },
        ["ClearClouds-Startup"] = {
            SoundId = 108141414138506,
            Volume = 2.5
        },
        ["ClearClouds-Startup-Voiceline-1"] = {
            SoundId = 86124553457848,
            Volume = 1.5
        },
        ["ClearClouds-Startup-Voiceline-2"] = {
            SoundId = 101901098020560,
            Volume = 1.5
        },
        ["ClearClouds-Teleport"] = {
            SoundId = 102685286117977,
            Volume = 2
        },
        ["ClearClouds-Final"] = {
            SoundId = 103710058123458,
            Volume = 2.5
        },
        ["ClearClouds-Final-Voiceline-1"] = {
            SoundId = 105699397169007,
            Volume = 1.5
        },
        ["ClearClouds-Final-Voiceline-2"] = {
            SoundId = 85784938659054,
            Volume = 1.5
        },
        SkyShatter = {
            SoundId = 101451796167131,
            Volume = 3
        },
        ["SkyShatter-Voiceline-1"] = {
            SoundId = 110698593455477,
            Volume = 1.5
        },
        ["SkyShatter-Voiceline-2"] = {
            SoundId = 90334464044780,
            Volume = 1.5
        },
        ["EmptyMist-Startup"] = {
            SoundId = 76475173366780,
            Volume = 1.5
        },
        ["EmptyMist-Startup-Voiceline"] = {
            SoundId = ""
        },
        ["EmptyMist-Loop"] = {
            SoundId = 100676185668125,
            Volume = 1.5,
            Looped = true
        },
        ["EmptyMist-Finisher"] = {
            SoundId = 78551439226849,
            Volume = 1.5
        },
        ["EmptyMist-Finisher-Voiceline"] = {
            SoundId = ""
        },
        ["PiercingVoid-First-Voiceline-1"] = {
            SoundId = 108359850208488,
            Volume = 3
        },
        ["PiercingVoid-Second-Voiceline-1"] = {
            SoundId = 135925125749586,
            Volume = 3
        },
        ["PiercingVoid-First-Voiceline-2"] = {
            SoundId = 117035818256979,
            Volume = 3
        },
        ["PiercingVoid-Second-Voiceline-2"] = {
            SoundId = 134186554858227,
            Volume = 3
        },
        ["Ultimate-Startup"] = {
            SoundId = 76510650686970,
            Volume = 1.5
        },
        Ultimate = {
            SoundId = 114118934095605,
            Volume = 1.5
        },
        ["Ultimate-Voiceline"] = {
            SoundId = 73764256220769,
            Volume = 2
        },
        SovereignEasterEgg = {
            SoundId = ""
        },
        PoseMusic = {
            SoundId = ""
        }
    },
    Divinity = {
        ["Divinity-SwallowingVoid-First-Voiceline"] = {
            SoundId = 135692519178617,
            Volume = 2
        },
        ["Divinity-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 121159925561843,
            Volume = 2
        },
        ["Divinity-Whirlwind-Voiceline"] = {
            SoundId = 126437352122963,
            Volume = 2
        },
        ["Divinity-ThreefoldSlice-Voiceline"] = {
            SoundId = 82176124981192,
            Volume = 2
        },
        ["Divinity-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 119396277053300,
            Volume = 2
        },
        ["Divinity-SwordImpalement-Final-Voiceline"] = {
            SoundId = 106837404749587,
            Volume = 2
        },
        ["Divinity-Devastation-Voiceline"] = {
            SoundId = 81563428248370,
            Volume = 2
        },
        ["Divinity-AscendedPunishment-Voiceline"] = {
            SoundId = 107970805410637,
            Volume = 2
        },
        ["Divinity-FallenLeaves-Voiceline"] = {
            SoundId = 137786439706174,
            Volume = 2
        },
        ["Divinity-Grab-Voiceline"] = {
            SoundId = 128241580158501,
            Volume = 2
        }
    },
    Crazed = {
        ["Crazed-SwallowingVoid-First-Voiceline"] = {
            SoundId = 121009783560955,
            Volume = 2
        },
        ["Crazed-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 131044331267900,
            Volume = 2
        },
        ["Crazed-Whirlwind-Voiceline"] = {
            SoundId = 101064941383506,
            Volume = 2
        },
        ["Crazed-ThreefoldSlice-Voiceline"] = {
            SoundId = 86408268803209,
            Volume = 2
        },
        ["Crazed-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 93859869392335,
            Volume = 2
        },
        ["Crazed-SwordImpalement-Final-Voiceline"] = {
            SoundId = 120180598647278,
            Volume = 2
        },
        ["Crazed-Devastation-Voiceline"] = {
            SoundId = 78028426560127,
            Volume = 2
        },
        ["Crazed-AscendedPunishment-Voiceline"] = {
            SoundId = 76497121219258,
            Volume = 2
        },
        ["Crazed-FallenLeaves-Voiceline"] = {
            SoundId = 139967025874349,
            Volume = 2
        },
        ["Crazed-Grab-Voiceline"] = {
            SoundId = 95862840265858,
            Volume = 2
        },
        ["Crazed-WindShower-Voiceline"] = {
            SoundId = 91571125276312,
            Volume = 2
        },
        ["Crazed-LMB-1-Voiceline"] = {
            SoundId = 117562336461351,
            Volume = 2
        },
        ["Crazed-LMB-2-Voiceline"] = {
            SoundId = 132934736905755,
            Volume = 2
        },
        ["Crazed-LMB-3-Voiceline"] = {
            SoundId = 118670288705092,
            Volume = 2
        },
        ["Crazed-LMB-4-Voiceline"] = {
            SoundId = 93704533618083,
            Volume = 2.5
        },
        ["Crazed-Death-Voiceline"] = {
            SoundId = 88324048484262,
            Volume = 3
        },
        ["Crazed-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Chaos = {
        ["Chaos-SwallowingVoid-First-Voiceline"] = {
            SoundId = 131248353224077,
            Volume = 7
        },
        ["Chaos-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 78799851520470,
            Volume = 7
        },
        ["Chaos-Whirlwind-Voiceline"] = {
            SoundId = 127658737582333,
            Volume = 7
        },
        ["Chaos-ThreefoldSlice-Voiceline"] = {
            SoundId = 121840181317906,
            Volume = 7
        },
        ["Chaos-SwordImpalement-Startup-Voiceline"] = {
            SoundId = "",
            Volume = 7
        },
        ["Chaos-SwordImpalement-Final-Voiceline"] = {
            SoundId = 120253261796665,
            Volume = 7
        },
        ["Chaos-Devastation-Voiceline"] = {
            SoundId = 120477761536479,
            Volume = 7
        },
        ["Chaos-AscendedPunishment-Voiceline"] = {
            SoundId = 123068874580628,
            Volume = 7
        },
        ["Chaos-FallenLeaves-Voiceline"] = {
            SoundId = 75699805294372,
            Volume = 7
        },
        ["Chaos-Grab-Voiceline"] = {
            SoundId = 104134975503906,
            Volume = 7
        },
        ["Chaos-WindShower-Voiceline"] = {
            SoundId = 131512097152888,
            Volume = 2
        },
        ["Chaos-LMB-1-Voiceline"] = {
            SoundId = 77400666681764,
            Volume = 2
        },
        ["Chaos-LMB-2-Voiceline"] = {
            SoundId = 123260030323239,
            Volume = 2
        },
        ["Chaos-LMB-3-Voiceline"] = {
            SoundId = 135742318150511,
            Volume = 2
        },
        ["Chaos-LMB-4-Voiceline"] = {
            SoundId = 71021087741761,
            Volume = 2.5
        },
        ["Chaos-Death-Voiceline"] = {
            SoundId = "",
            Volume = 3
        },
        ["Chaos-Aura"] = {
            SoundId = 124799643662746,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        },
        ["Chaos-MeterUp4"] = {
            SoundId = 90268083401790,
            Volume = 2
        },
        ["Chaos-MeterUp2"] = {
            SoundId = 93955109257288,
            Volume = 2
        }
    },
    Purity = {
        ["Purity-SwallowingVoid-First-Voiceline"] = {
            SoundId = 80440013779913,
            Volume = 2
        },
        ["Purity-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 126409292975651,
            Volume = 2
        },
        ["Purity-Whirlwind-Voiceline"] = {
            SoundId = 134192568328948,
            Volume = 2
        },
        ["Purity-ThreefoldSlice-Voiceline"] = {
            SoundId = 82124302764945,
            Volume = 2
        },
        ["Purity-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 136879025200155,
            Volume = 2
        },
        ["Purity-SwordImpalement-Final-Voiceline"] = {
            SoundId = 136686400698778,
            Volume = 2
        },
        ["Purity-Devastation-Voiceline"] = {
            SoundId = 94468027604728,
            Volume = 2
        },
        ["Purity-AscendedPunishment-Voiceline"] = {
            SoundId = 83418173399054,
            Volume = 2
        },
        ["Purity-FallenLeaves-Voiceline"] = {
            SoundId = 100967674892804,
            Volume = 2
        },
        ["Purity-Grab-Voiceline"] = {
            SoundId = 132403337305521,
            Volume = 2
        },
        ["Purity-WindShower-Voiceline"] = {
            SoundId = 89029025114500,
            Volume = 2
        },
        ["Purity-LMB-1-Voiceline"] = {
            SoundId = 97414160772261,
            Volume = 2
        },
        ["Purity-LMB-2-Voiceline"] = {
            SoundId = 119720466408460,
            Volume = 2
        },
        ["Purity-LMB-3-Voiceline"] = {
            SoundId = 128246759182088,
            Volume = 2
        },
        ["Purity-LMB-4-Voiceline"] = {
            SoundId = 140067534227451,
            Volume = 2.5
        },
        ["Purity-Death-Voiceline"] = {
            SoundId = 91277553617544,
            Volume = 3
        },
        ["Purity-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Pandora = {
        ["Pandora-SwallowingVoid-First-Voiceline"] = {
            SoundId = 119079710840503,
            Volume = 2
        },
        ["Pandora-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 119928032013267,
            Volume = 2
        },
        ["Pandora-Whirlwind-Voiceline"] = {
            SoundId = 138894129633755,
            Volume = 2
        },
        ["Pandora-ThreefoldSlice-Voiceline"] = {
            SoundId = 113109466678093,
            Volume = 2
        },
        ["Pandora-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 89451813980247,
            Volume = 2
        },
        ["Pandora-SwordImpalement-Final-Voiceline"] = {
            SoundId = 83511601670111,
            Volume = 2
        },
        ["Pandora-Devastation-Voiceline"] = {
            SoundId = 132027344987914,
            Volume = 2
        },
        ["Pandora-AscendedPunishment-Voiceline"] = {
            SoundId = 132935401211906,
            Volume = 2
        },
        ["Pandora-FallenLeaves-Voiceline"] = {
            SoundId = 119096648885151,
            Volume = 2
        },
        ["Pandora-Grab-Voiceline"] = {
            SoundId = 94119798153380,
            Volume = 2
        },
        ["Pandora-WindShower-Voiceline"] = {
            SoundId = 121882868911903,
            Volume = 2
        },
        ["Pandora-LMB-1-Voiceline"] = {
            SoundId = 115187470336259,
            Volume = 2
        },
        ["Pandora-LMB-2-Voiceline"] = {
            SoundId = 118162817773100,
            Volume = 2
        },
        ["Pandora-LMB-3-Voiceline"] = {
            SoundId = 130365666965668,
            Volume = 2
        },
        ["Pandora-LMB-4-Voiceline"] = {
            SoundId = 136417923238043,
            Volume = 2.5
        },
        ["Pandora-Death-Voiceline"] = {
            SoundId = 90609657209774,
            Volume = 3
        },
        ["Pandora-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    FallenX = {
        ["FallenX-SwallowingVoid-First-Voiceline"] = {
            SoundId = 91904660039168,
            Volume = 2
        },
        ["FallenX-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 132672491399843,
            Volume = 2
        },
        ["FallenX-Whirlwind-Voiceline"] = {
            SoundId = 116945866141240,
            Volume = 2
        },
        ["FallenX-ThreefoldSlice-Voiceline"] = {
            SoundId = 78287914894790,
            Volume = 2
        },
        ["FallenX-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 118295583271060,
            Volume = 2
        },
        ["FallenX-SwordImpalement-Final-Voiceline"] = {
            SoundId = 99489786588722,
            Volume = 2
        },
        ["FallenX-Devastation-Voiceline"] = {
            SoundId = 73929309655545,
            Volume = 2
        },
        ["FallenX-AscendedPunishment-Voiceline"] = {
            SoundId = 114867011605770,
            Volume = 2
        },
        ["FallenX-FallenLeaves-Voiceline"] = {
            SoundId = 105248274825981,
            Volume = 2
        },
        ["FallenX-Grab-Voiceline"] = {
            SoundId = 93716641473234,
            Volume = 2
        },
        ["FallenX-WindShower-Voiceline"] = {
            SoundId = 100536569641857,
            Volume = 2
        },
        ["FallenX-LMB-1-Voiceline"] = {
            SoundId = 82658211419808,
            Volume = 2
        },
        ["FallenX-LMB-2-Voiceline"] = {
            SoundId = 99997169702073,
            Volume = 2
        },
        ["FallenX-LMB-3-Voiceline"] = {
            SoundId = 79006375568341,
            Volume = 2
        },
        ["FallenX-LMB-4-Voiceline"] = {
            SoundId = 95510615019395,
            Volume = 2.5
        },
        ["FallenX-Death-Voiceline"] = {
            SoundId = 94226619209605,
            Volume = 3
        },
        ["FallenX-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    SHD = {
        ["SHD-SwallowingVoid-First-Voiceline"] = {
            SoundId = 122998933992493,
            Volume = 2
        },
        ["SHD-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 88804128260279,
            Volume = 2
        },
        ["SHD-Whirlwind-Voiceline"] = {
            SoundId = 129411149591170,
            Volume = 2
        },
        ["SHD-ThreefoldSlice-Voiceline"] = {
            SoundId = 92286477497614,
            Volume = 2
        },
        ["SHD-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 138792694329580,
            Volume = 2
        },
        ["SHD-SwordImpalement-Final-Voiceline"] = {
            SoundId = 140222114793847,
            Volume = 2
        },
        ["SHD-Devastation-Voiceline"] = {
            SoundId = 83343704032551,
            Volume = 2
        },
        ["SHD-AscendedPunishment-Voiceline"] = {
            SoundId = 89073386023052,
            Volume = 2
        },
        ["SHD-FallenLeaves-Voiceline"] = {
            SoundId = 130077484665712,
            Volume = 2
        },
        ["SHD-Grab-Voiceline"] = {
            SoundId = 95600193470291,
            Volume = 2
        },
        ["SHD-WindShower-Voiceline"] = {
            SoundId = 126290371655012,
            Volume = 2
        },
        ["SHD-LMB-1-Voiceline"] = {
            SoundId = 126122115595411,
            Volume = 2
        },
        ["SHD-LMB-2-Voiceline"] = {
            SoundId = 137717198555869,
            Volume = 2
        },
        ["SHD-LMB-3-Voiceline"] = {
            SoundId = 120381969040364,
            Volume = 2
        },
        ["SHD-LMB-4-Voiceline"] = {
            SoundId = 92452256733668,
            Volume = 2.5
        },
        ["SHD-Death-Voiceline"] = {
            SoundId = 114045001677684,
            Volume = 3
        },
        ["SHD-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Rainbow = {
        ["Rainbow-LMB-1"] = {
            SoundId = 108412069790605,
            Volume = 1.25
        },
        ["Rainbow-LMB-2"] = {
            SoundId = 122334360691920,
            Volume = 1.25
        },
        ["Rainbow-LMB-3"] = {
            SoundId = 74775432096653,
            Volume = 1.25
        },
        ["Rainbow-LMB-4"] = {
            SoundId = 83150755472416,
            Volume = 1.25
        },
        ["Rainbow-LMB-1-Voiceline"] = {
            SoundId = 138450858927133,
            Volume = 4
        },
        ["Rainbow-LMB-2-Voiceline"] = {
            SoundId = 113779734704987,
            Volume = 4
        },
        ["Rainbow-LMB-3-Voiceline"] = {
            SoundId = 124094282801957,
            Volume = 4
        },
        ["Rainbow-LMB-4-Voiceline"] = {
            SoundId = 130392436489036,
            Volume = 4
        },
        ["Rainbow-SwallowingVoid-First-Voiceline"] = {
            SoundId = 75954786666198,
            Volume = 2
        },
        ["Rainbow-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 105064353271490,
            Volume = 2
        },
        ["Rainbow-Whirlwind-Voiceline"] = {
            SoundId = 129546367655126,
            Volume = 2
        },
        ["Rainbow-ThreefoldSlice-Voiceline"] = {
            SoundId = 118410604987670,
            Volume = 2
        },
        ["Rainbow-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 100046572583916,
            Volume = 2
        },
        ["Rainbow-SwordImpalement-Final-Voiceline"] = {
            SoundId = 114157537500090,
            Volume = 2
        },
        ["Rainbow-Devastation-Voiceline"] = {
            SoundId = 119274098317597,
            Volume = 2
        },
        ["Rainbow-AscendedPunishment-Voiceline"] = {
            SoundId = 118471182874893,
            Volume = 2
        },
        ["Rainbow-FallenLeaves-Voiceline"] = {
            SoundId = 112591520670117,
            Volume = 2
        },
        ["Rainbow-WindShower-Voiceline"] = {
            SoundId = 134215130402570,
            Volume = 4
        },
        ["Rainbow-Grab-Voiceline"] = {
            SoundId = 77643456406648,
            Volume = 2
        },
        ["Rainbow-Death-Voiceline"] = {
            SoundId = 77110210675078,
            Volume = 4.5
        },
        ["Rainbow-Aura"] = {
            SoundId = 88504125885314,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Calamity = {
        ["Calamity-SwallowingVoid-First-Voiceline"] = {
            SoundId = 89297074546060,
            Volume = 2
        },
        ["Calamity-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 123945637108701,
            Volume = 2
        },
        ["Calamity-Whirlwind-Voiceline"] = {
            SoundId = 92597787651835,
            Volume = 2
        },
        ["Calamity-ThreefoldSlice-Voiceline"] = {
            SoundId = 97350570719272,
            Volume = 2
        },
        ["Calamity-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 98451244704758,
            Volume = 2
        },
        ["Calamity-SwordImpalement-Final-Voiceline"] = {
            SoundId = 110142617587173,
            Volume = 2
        },
        ["Calamity-Devastation-Voiceline"] = {
            SoundId = 130393786784182,
            Volume = 2
        },
        ["Calamity-AscendedPunishment-Voiceline"] = {
            SoundId = 100648529053145,
            Volume = 2
        },
        ["Calamity-FallenLeaves-Voiceline"] = {
            SoundId = 98181235590251,
            Volume = 2
        },
        ["Calamity-Grab-Voiceline"] = {
            SoundId = 110734395554746,
            Volume = 2
        },
        ["Calamity-WindShower-Voiceline"] = {
            SoundId = 89303621726838,
            Volume = 2
        },
        ["Calamity-LMB-1-Voiceline"] = {
            SoundId = 76343696936049,
            Volume = 2
        },
        ["Calamity-LMB-2-Voiceline"] = {
            SoundId = 83092299203801,
            Volume = 2
        },
        ["Calamity-LMB-3-Voiceline"] = {
            SoundId = 77229614297865,
            Volume = 2
        },
        ["Calamity-LMB-4-Voiceline"] = {
            SoundId = 122202320286460,
            Volume = 2.5
        },
        ["Calamity-Death-Voiceline"] = {
            SoundId = 135987253347447,
            Volume = 3
        }
    },
    Omega = {
        ["Omega-SwallowingVoid-First-Voiceline"] = {
            SoundId = 97823114315896,
            Volume = 4.5
        },
        ["Omega-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 98973237464714,
            Volume = 4.5
        },
        ["Omega-Whirlwind-Voiceline"] = {
            SoundId = 89129605273149,
            Volume = 4.5
        },
        ["Omega-ThreefoldSlice-Voiceline"] = {
            SoundId = 103466369922938,
            Volume = 4.5
        },
        ["Omega-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 102299996350997,
            Volume = 4.5
        },
        ["Omega-SwordImpalement-Final-Voiceline"] = {
            SoundId = 72943181615390,
            Volume = 4.5
        },
        ["Omega-Devastation-Voiceline"] = {
            SoundId = 135517791219576,
            Volume = 4.5
        },
        ["Omega-AscendedPunishment-Voiceline"] = {
            SoundId = 140032259579552,
            Volume = 4.5
        },
        ["Omega-FallenLeaves-Voiceline"] = {
            SoundId = 117876786001178,
            Volume = 4.5
        },
        ["Omega-Grab-Voiceline"] = {
            SoundId = 96740423602435,
            Volume = 4.5
        },
        ["Omega-WindShower-Voiceline"] = {
            SoundId = 78572412135110,
            Volume = 4.5
        },
        ["Omega-LMB-1-Voiceline"] = {
            SoundId = 81296384077286,
            Volume = 4.5
        },
        ["Omega-LMB-2-Voiceline"] = {
            SoundId = 71599226944967,
            Volume = 4.5
        },
        ["Omega-LMB-3-Voiceline"] = {
            SoundId = 95952812130327,
            Volume = 4.5
        },
        ["Omega-LMB-4-Voiceline"] = {
            SoundId = 110665247246706,
            Volume = 4.5
        },
        ["Omega-Death-Voiceline"] = {
            SoundId = 116372372812197,
            Volume = 4
        },
        ["Omega-Aura"] = {
            SoundId = 88406016153570,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Equinox = {
        ["Equinox-SwallowingVoid-First-Voiceline"] = {
            SoundId = 78916912076718,
            Volume = 2
        },
        ["Equinox-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 96828851442817,
            Volume = 2
        },
        ["Equinox-Whirlwind-Voiceline"] = {
            SoundId = 103319302668830,
            Volume = 2
        },
        ["Equinox-ThreefoldSlice-Voiceline"] = {
            SoundId = 84043528679986,
            Volume = 2
        },
        ["Equinox-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 72433555991984,
            Volume = 2
        },
        ["Equinox-SwordImpalement-Final-Voiceline"] = {
            SoundId = 104888854100260,
            Volume = 2
        },
        ["Equinox-Devastation-Voiceline"] = {
            SoundId = 80271631793425,
            Volume = 2
        },
        ["Equinox-AscendedPunishment-Voiceline"] = {
            SoundId = 123092640227292,
            Volume = 2
        },
        ["Equinox-FallenLeaves-Voiceline"] = {
            SoundId = 110635371390542,
            Volume = 2
        },
        ["Equinox-Grab-Voiceline"] = {
            SoundId = 89811139052792,
            Volume = 2
        },
        ["Equinox-WindShower-Voiceline"] = {
            SoundId = 108763744237698,
            Volume = 2
        },
        ["Equinox-LMB-1-Voiceline"] = {
            SoundId = 105045618583323,
            Volume = 2
        },
        ["Equinox-LMB-2-Voiceline"] = {
            SoundId = 133796590230931,
            Volume = 2
        },
        ["Equinox-LMB-3-Voiceline"] = {
            SoundId = 81292679007451,
            Volume = 2
        },
        ["Equinox-LMB-4-Voiceline"] = {
            SoundId = 101535291634342,
            Volume = 2
        },
        ["Equinox-Death-Voiceline"] = {
            SoundId = 96256269398942,
            Volume = 3
        },
        ["Equinox-Aura"] = {
            SoundId = 78658707820313,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Corruption = {
        ["Corruption-SwallowingVoid-First-Voiceline"] = {
            SoundId = 124029975404365,
            Volume = 2
        },
        ["Corruption-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 133963837253479,
            Volume = 2
        },
        ["Corruption-Whirlwind-Voiceline"] = {
            SoundId = 130900949728469,
            Volume = 2
        },
        ["Corruption-ThreefoldSlice-Voiceline"] = {
            SoundId = 88253569236363,
            Volume = 2
        },
        ["Corruption-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 125221241946055,
            Volume = 2
        },
        ["Corruption-SwordImpalement-Final-Voiceline"] = {
            SoundId = 94121300091289,
            Volume = 2
        },
        ["Corruption-Devastation-Voiceline"] = {
            SoundId = 115646466527068,
            Volume = 2
        },
        ["Corruption-AscendedPunishment-Voiceline"] = {
            SoundId = 84516731474845,
            Volume = 2
        },
        ["Corruption-FallenLeaves-Voiceline"] = {
            SoundId = 97829615284373,
            Volume = 2
        },
        ["Corruption-Grab-Voiceline"] = {
            SoundId = 75385858456737,
            Volume = 2
        },
        ["Corruption-WindShower-Voiceline"] = {
            SoundId = 84136222774203,
            Volume = 2
        },
        ["Corruption-LMB-1-Voiceline"] = {
            SoundId = 131136390350915,
            Volume = 2
        },
        ["Corruption-LMB-2-Voiceline"] = {
            SoundId = 70781689706848,
            Volume = 2
        },
        ["Corruption-LMB-3-Voiceline"] = {
            SoundId = 86951386134984,
            Volume = 2
        },
        ["Corruption-LMB-4-Voiceline"] = {
            SoundId = 93798821738157,
            Volume = 2.5
        },
        ["Corruption-Death-Voiceline"] = {
            SoundId = 91651916046214,
            Volume = 3
        },
        ["Corruption-Aura"] = {
            SoundId = 85992169391254,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Destiny = {
        ["Destiny-SwallowingVoid-First-Voiceline"] = {
            SoundId = 124601506137629,
            Volume = 2
        },
        ["Destiny-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 128096731256675,
            Volume = 2
        },
        ["Destiny-Whirlwind-Voiceline"] = {
            SoundId = 85589285235113,
            Volume = 2
        },
        ["Destiny-ThreefoldSlice-Voiceline"] = {
            SoundId = 105110357057231,
            Volume = 2
        },
        ["Destiny-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 101368230539580,
            Volume = 2
        },
        ["Destiny-SwordImpalement-Final-Voiceline"] = {
            SoundId = 70427077694937,
            Volume = 2
        },
        ["Destiny-Devastation-Voiceline"] = {
            SoundId = 137547477815204,
            Volume = 2
        },
        ["Destiny-AscendedPunishment-Voiceline"] = {
            SoundId = 125418753919513,
            Volume = 2
        },
        ["Destiny-FallenLeaves-Voiceline"] = {
            SoundId = 112738992686387,
            Volume = 2
        },
        ["Destiny-Grab-Voiceline"] = {
            SoundId = 95698793139769,
            Volume = 2
        },
        ["Destiny-WindShower-Voiceline"] = {
            SoundId = 90009491780817,
            Volume = 2
        },
        ["Destiny-LMB-1-Voiceline"] = {
            SoundId = 94045164517430,
            Volume = 2
        },
        ["Destiny-LMB-2-Voiceline"] = {
            SoundId = 114446229133737,
            Volume = 2
        },
        ["Destiny-LMB-3-Voiceline"] = {
            SoundId = 136456201713479,
            Volume = 2
        },
        ["Destiny-LMB-4-Voiceline"] = {
            SoundId = 115195953879100,
            Volume = 2.5
        },
        ["Destiny-Death-Voiceline"] = {
            SoundId = 105034829815508,
            Volume = 3
        },
        ["Destiny-Aura"] = {
            SoundId = "",
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Catastrophe = {
        ["Catastrophe-SwallowingVoid-First-Voiceline"] = {
            SoundId = 102663290288000,
            Volume = 7.25
        },
        ["Catastrophe-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 112869069789190,
            Volume = 7.25
        },
        ["Catastrophe-Whirlwind-Voiceline"] = {
            SoundId = 95664115024425,
            Volume = 7.25
        },
        ["Catastrophe-ThreefoldSlice-Voiceline"] = {
            SoundId = 133957213159138,
            Volume = 7.25
        },
        ["Catastrophe-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 113122833449314,
            Volume = 7.25
        },
        ["Catastrophe-SwordImpalement-Final-Voiceline"] = {
            SoundId = 88735453782628,
            Volume = 7.25
        },
        ["Catastrophe-Devastation-Voiceline"] = {
            SoundId = 112469419575917,
            Volume = 7.25
        },
        ["Catastrophe-AscendedPunishment-Voiceline"] = {
            SoundId = 76436387014698,
            Volume = 7.25
        },
        ["Catastrophe-FallenLeaves-Voiceline"] = {
            SoundId = 99436599154641,
            Volume = 7.25
        },
        ["Catastrophe-Grab-Voiceline"] = {
            SoundId = 114511132397277,
            Volume = 7.25
        },
        ["Catastrophe-WindShower-Voiceline"] = {
            SoundId = 94011799030524,
            Volume = 3
        },
        ["Catastrophe-LMB-1-Voiceline"] = {
            SoundId = 133115889637934,
            Volume = 3
        },
        ["Catastrophe-LMB-2-Voiceline"] = {
            SoundId = 101696535413945,
            Volume = 3
        },
        ["Catastrophe-LMB-3-Voiceline"] = {
            SoundId = 108993175507287,
            Volume = 3
        },
        ["Catastrophe-LMB-4-Voiceline"] = {
            SoundId = 133725836377188,
            Volume = 3.25
        },
        ["Catastrophe-Death-Voiceline"] = {
            SoundId = 103356835383635,
            Volume = 3
        },
        ["Catastrophe-Aura"] = {
            SoundId = 92126189161871,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    },
    Love = {
        ["Love-SwallowingVoid-First-Voiceline"] = {
            SoundId = 117509578569955,
            Volume = 2
        },
        ["Love-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 85585483069734,
            Volume = 2
        },
        ["Love-Whirlwind-Voiceline"] = {
            SoundId = 106503724718542,
            Volume = 2
        },
        ["Love-ThreefoldSlice-Voiceline"] = {
            SoundId = 79807007977738,
            Volume = 2
        },
        ["Love-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 128315982898435,
            Volume = 2
        },
        ["Love-SwordImpalement-Final-Voiceline"] = {
            SoundId = 131797563916632,
            Volume = 2
        },
        ["Love-Devastation-Voiceline"] = {
            SoundId = 139621561669166,
            Volume = 2
        },
        ["Love-AscendedPunishment-Voiceline"] = {
            SoundId = 77337540550108,
            Volume = 2
        },
        ["Love-FallenLeaves-Voiceline"] = {
            SoundId = 80612967293730,
            Volume = 2
        },
        ["Love-Grab-Voiceline"] = {
            SoundId = 115460919400393,
            Volume = 2
        },
        ["Love-WindShower-Voiceline"] = {
            SoundId = 70796933162485,
            Volume = 2
        },
        ["Love-LMB-1-Voiceline"] = {
            SoundId = 94601408199520,
            Volume = 2
        },
        ["Love-LMB-2-Voiceline"] = {
            SoundId = 77344167945018,
            Volume = 2
        },
        ["Love-LMB-3-Voiceline"] = {
            SoundId = 91300096505974,
            Volume = 2
        },
        ["Love-LMB-4-Voiceline"] = {
            SoundId = 103067429793603,
            Volume = 2
        },
        ["Love-Death-Voiceline"] = {
            SoundId = 105832746219952,
            Volume = 3
        }
    },
    Neptunian = {
        ["Neptunian-SwallowingVoid-First-Voiceline"] = {
            SoundId = 97701256579622,
            Volume = 4
        },
        ["Neptunian-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 108288602379970,
            Volume = 4
        },
        ["Neptunian-Whirlwind-Voiceline"] = {
            SoundId = 80475713657275,
            Volume = 4
        },
        ["Neptunian-ThreefoldSlice-Voiceline"] = {
            SoundId = 96902341903155,
            Volume = 4
        },
        ["Neptunian-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 79223580501126,
            Volume = 4
        },
        ["Neptunian-SwordImpalement-Final-Voiceline"] = {
            SoundId = 123362136874527,
            Volume = 4
        },
        ["Neptunian-Devastation-Voiceline"] = {
            SoundId = 70474740109827,
            Volume = 4
        },
        ["Neptunian-AscendedPunishment-Voiceline"] = {
            SoundId = 100475688316880,
            Volume = 4
        },
        ["Neptunian-FallenLeaves-Voiceline"] = {
            SoundId = 83289994944706,
            Volume = 4
        },
        ["Neptunian-Grab-Voiceline"] = {
            SoundId = "",
            Volume = 4
        },
        ["Neptunian-WindShower-Voiceline"] = {
            SoundId = 109833760504670,
            Volume = 4
        },
        ["Neptunian-LMB-1-Voiceline"] = {
            SoundId = 128856137373964,
            Volume = 4
        },
        ["Neptunian-LMB-2-Voiceline"] = {
            SoundId = 95649502350959,
            Volume = 4
        },
        ["Neptunian-LMB-3-Voiceline"] = {
            SoundId = 131876961463555,
            Volume = 4
        },
        ["Neptunian-LMB-4-Voiceline"] = {
            SoundId = 126928391383755,
            Volume = 4
        }
    },
    Mayhem = {
        ["Mayhem-SwallowingVoid-First-Voiceline"] = {
            SoundId = 80033543148109,
            Volume = 2
        },
        ["Mayhem-SwallowingVoid-Second-Voiceline"] = {
            SoundId = 78713945670340,
            Volume = 2
        },
        ["Mayhem-Whirlwind-Voiceline"] = {
            SoundId = 79744282376133,
            Volume = 2
        },
        ["Mayhem-ThreefoldSlice-Voiceline"] = {
            SoundId = 73646934683421,
            Volume = 2
        },
        ["Mayhem-SwordImpalement-Startup-Voiceline"] = {
            SoundId = 136864296083248,
            Volume = 2
        },
        ["Mayhem-SwordImpalement-Final-Voiceline"] = {
            SoundId = 104980755256674,
            Volume = 2
        },
        ["Mayhem-Devastation-Voiceline"] = {
            SoundId = 137248695123205,
            Volume = 2
        },
        ["Mayhem-AscendedPunishment-Voiceline"] = {
            SoundId = 101329450512996,
            Volume = 2
        },
        ["Mayhem-FallenLeaves-Voiceline"] = {
            SoundId = 83120649853569,
            Volume = 2
        },
        ["Mayhem-Grab-Voiceline"] = {
            SoundId = 106158914306733,
            Volume = 2
        },
        ["Mayhem-WindShower-Voiceline"] = {
            SoundId = 115287130876122,
            Volume = 2
        },
        ["Mayhem-Death-Voiceline"] = {
            SoundId = 76783091330849,
            Volume = 4
        },
        ["Mayhem-Aura"] = {
            SoundId = 85984303749828,
            Volume = 0.85,
            RollOffMaxDistance = 75,
            Looped = true
        }
    }
};
local v2 = { "SFX", "Sovereign SFX", "Base" };
local v3 = {};

for i, v in v1 do
    if table.find(v2, i) then
        v3 = TableUtil.Reconcile(v3, v);
    end;
end;

return {
    Sounds = v3,
    Gallery = v1
};
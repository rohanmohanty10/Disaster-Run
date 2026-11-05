  

 

return {
    Inherit = {
        AbilityName = "The World: Over Heaven"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 170, 0)),
                ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 248, 149)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 183, 110)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
            })
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 9862188066,
            Volume = 4.75,
            Looped = true
        },
        ["LMB-1"] = {
            SoundId = 7951478534,
            Volume = 1,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ["LMB-2"] = {
            SoundId = 7951478463,
            Volume = 1,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ["LMB-3"] = {
            SoundId = 7951478352,
            Volume = 1,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ["LMB-4"] = {
            SoundId = 7951478254,
            Volume = 1,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        Die = {
            SoundId = "",
            Volume = 0
        },
        SummonSound = {
            SoundId = "rbxassetid://9858680159",
            Volume = 2,
            SoundEffects = {
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        BarrageSFX = {
            SoundId = "rbxassetid://1377172167",
            Looped = true,
            Volume = 2,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ThisisOver = {
            SoundId = "rbxassetid://7951478090",
            Volume = 2,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        MudaPunch = {
            SoundId = "rbxassetid://7951478849",
            Volume = 2,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ThunderGodVoice = {
            SoundId = "rbxassetid://1238240873",
            Volume = 2,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        LightningKick = {
            SoundId = "rbxassetid://1238240873",
            Volume = 2,
            SoundEffects = {
                EchoSoundEffect = {
                    DryLevel = 0,
                    Priority = 12,
                    Name = "EchoSoundEffect",
                    WetLevel = 0
                },
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        ROVHitVoice = {
            SoundId = "",
            Volume = 0
        },
        ROVWindUpVoice = {
            SoundId = "rbxassetid://1093380862",
            Volume = 2,
            SoundEffects = {
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        },
        WindUpHeal = {
            SoundId = "",
            Volume = 0
        },
        TSSFX = {
            SoundId = "rbxassetid://9862206108",
            Volume = 3.5
        },
        TimeStopSFX = {
            SoundId = "rbxassetid://7951477284",
            Volume = 1,
            SoundEffects = {
                ReverbSoundEffect = {
                    Density = 1,
                    WetLevel = 0,
                    DryLevel = -6,
                    Diffusion = 1,
                    Priority = 0,
                    DecayTime = 1.5,
                    Name = "ReverbSoundEffect"
                }
            }
        }
    }
};
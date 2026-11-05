  

 

return {
    Inherit = {
        AbilityName = "Umbra"
    },
    Animations = {
        Action = {
            PoseTransition = 120026779103612,
            PoseIdle = 80208217629762
        },
        Movement = {
            Run = 89705484387328,
            Walk = 93935050034927
        },
        Idle = {
            Idle = 84486702244401
        }
    },
    Stats = {
        ["Rush Attack"] = {
            Texture1 = {
                color = Color3.fromRGB(0, 0, 0)
            },
            SlashData = {
                color = Color3.fromRGB(0, 0, 0)
            },
            ["LMB-5"] = {
                Props = {
                    Start = {
                        Transparency = 0,
                        Color = Color3.fromRGB(0, 0, 0)
                    }
                }
            },
            ["Sovereign-LMB-5"] = {
                Props = {
                    Start = {
                        Transparency = 0,
                        Color = Color3.fromRGB(0, 0, 0)
                    }
                }
            }
        },
        Pose = {
            MusicAmount = 2
        },
        ["Last Rites"] = {
            UmbraHitData = {
                Color = Color3.fromRGB(0, 0, 0)
            }
        },
        ["Finis Aeternam"] = {},
        ["Elegant Bladework"] = {
            Texture1 = {
                color = Color3.fromRGB(0, 0, 0)
            },
            Barrage = {
                SlashData = {
                    Color = Color3.fromRGB(0, 0, 0)
                }
            },
            ["AOE Slash"] = {
                SlashData = {
                    Color = Color3.fromRGB(0, 0, 0)
                }
            }
        },
        ["Judgement Cut"] = {
            CustomColor = Color3.fromRGB(0, 0, 0)
        },
        Foresight = {
            Texture1 = {
                color = Color3.fromRGB(0, 0, 0)
            },
            SlashData = {
                Color = Color3.fromRGB(0, 0, 0)
            },
            CustomColor = Color3.fromRGB(0, 0, 0)
        },
        Slashes = {
            Texture1 = {
                color = Color3.fromRGB(0, 0, 0)
            },
            SlashData = {
                Color = Color3.fromRGB(0, 0, 0)
            },
            CustomColor = Color3.fromRGB(0, 0, 0)
        },
        Erasure = {
            Texture1 = {
                color = Color3.fromRGB(0, 0, 0)
            },
            SlashData = {
                Color = Color3.fromRGB(0, 0, 0)
            },
            CustomColor = Color3.fromRGB(0, 0, 0)
        },
        Sovereign = {
            SovereignColor = Color3.fromRGB(0, 0, 0)
        },
        ["Umbral Execution"] = {
            FXData = {
                Color = Color3.fromRGB(0, 0, 0)
            }
        },
        ["Umbral Blades"] = {
            CustomColor = Color3.fromRGB(0, 0, 0)
        },
        ["Umbral Dash"] = {
            Props = {
                Start = {
                    Transparency = 0,
                    Color = Color3.fromRGB(0, 0, 0)
                }
            }
        },
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
        }
    },
    Sounds = {
        ["PoseMusic-1"] = {
            SoundId = 18445928712,
            PlaybackSpeed = 1,
            Volume = 2,
            Looped = true
        },
        ["PoseMusic-2"] = {
            SoundId = 18445943376,
            PlaybackSpeed = 1,
            Volume = 2,
            Looped = true
        },
        SovereignMusic = {
            SoundId = 18445930064,
            PlaybackSpeed = 1,
            Volume = 2,
            Looped = true
        }
    }
};
  

 

local v1 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V2", "__Legacy", "PikaHit" }
};
local v2 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V2", "__Legacy", "PikaHeavy" }
};
local Output = game.ReplicatedStorage.Remotes.Output;

return {
    Inherit = {
        AbilityName = "Umbra"
    },
    Metadata = {
        ReconcileSounds = false
    },
    Animations = {
        Idle = {
            SummonedIdle = 8117886753
        }
    },
    Stats = {
        ["Rush Attack"] = {
            Texture1 = {
                color = Color3.fromRGB(255, 255, 127)
            },
            SlashData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            ["LMB-5"] = {
                Props = {
                    Start = {
                        Transparency = 0,
                        Color = Color3.fromRGB(255, 255, 127)
                    }
                }
            },
            ["Sovereign-LMB-5"] = {
                Props = {
                    Start = {
                        Transparency = 0,
                        Color = Color3.fromRGB(255, 255, 127)
                    }
                }
            },
            HitRemotes = { v1 }
        },
        ["Last Rites"] = {
            UmbraData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            HitRemotes = { v2 }
        },
        ["Finis Aeternam"] = {
            HitRemotes = { v2 }
        },
        ["Elegant Bladework"] = {
            Texture1 = {
                color = Color3.fromRGB(255, 255, 127)
            },
            Barrage = {
                SlashData = {
                    Color = Color3.fromRGB(255, 255, 127)
                },
                HitRemotes = { v1 }
            },
            ["AOE Slash"] = {
                SlashData = {
                    Color = Color3.fromRGB(255, 255, 127)
                },
                HitRemotes = { v2 }
            }
        },
        ["Judgement Cut"] = {
            CustomColor = Color3.fromRGB(255, 255, 127),
            HitRemotes = { v2 }
        },
        Foresight = {
            Texture1 = {
                color = Color3.fromRGB(255, 255, 127)
            },
            SlashData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            CustomColor = Color3.fromRGB(255, 255, 127),
            HitRemotes = { v1 }
        },
        Slashes = {
            Texture1 = {
                color = Color3.fromRGB(255, 255, 127)
            },
            SlashData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            CustomColor = Color3.fromRGB(255, 255, 127),
            HitRemotes = { v1 }
        },
        Erasure = {
            Texture1 = {
                color = Color3.fromRGB(255, 255, 127)
            },
            SlashData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            CustomColor = Color3.fromRGB(255, 255, 127),
            HitRemotes = { v2 }
        },
        Sovereign = {
            SovereignColor = Color3.fromRGB(255, 255, 127)
        },
        ["Umbral Execution"] = {
            FXData = {
                Color = Color3.fromRGB(255, 255, 127)
            },
            HitRemotes = { v2 }
        },
        ["Umbral Blades"] = {
            CustomColor = Color3.fromRGB(255, 255, 127),
            HitRemotes = { v1 }
        },
        ["Umbral Dash"] = {
            Props = {
                Start = {
                    Transparency = 0,
                    Color = Color3.fromRGB(255, 255, 127)
                }
            }
        },
        Summon = {
            SummonParticle = {
                ParticleName = "PikaSummon",
                PartName = "SummonPart"
            },
            CustomAura = {
                AuraName = "Ama No Murakumo"
            },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 0)) })
        },
        Block = {
            Callbacks = {
                Blocked = function(p3, p4) -- Line: 166, Name: Blocked
                    -- upvalues: Output (copy)
                    local HumanoidRootPart = p3.Character.HumanoidRootPart;
                    Output:FireAllClients("FX", "Emit Particle V2", {
                        ParticleName = "PikaThrow",
                        CFrame = CFrame.lookAt(HumanoidRootPart.CFrame.Position, p4.Attacker.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 0, -3),
                        Part = HumanoidRootPart,
                        Player = p3.Player
                    });
                end
            }
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 8110837069,
            Volume = 1.5
        },
        ["LMB-1-3"] = {
            SoundId = 8091561405,
            Volume = 1.5,
            PlaybackSpeed = 1.5
        },
        ["LMB-4"] = {
            SoundId = 8110844634,
            Volume = 1.5
        },
        ["LMB-5"] = {
            SoundId = 8091562185,
            Volume = 1.5
        },
        ["Sovereign-LMB-4"] = {
            SoundId = 8110844634,
            Volume = 1.5
        },
        ["Sovereign-LMB-5"] = {
            SoundId = 8091562185,
            Volume = 1.5
        },
        Slashes = {
            SoundId = 8091562800,
            Volume = 1.5
        },
        ["Last Rites"] = {
            SoundId = 8091563881,
            Volume = 1.5
        },
        ["Elegant Bladework"] = {
            SoundId = 8091564752,
            Volume = 1.5
        },
        ["Judgement Cut 2"] = {
            SoundId = 8091565454,
            Volume = 1.5
        },
        Ult2 = {
            SoundId = 8091566038,
            Volume = 1.5
        },
        ["Umbral Blades"] = {
            SoundId = 8091566776,
            Volume = 1.5
        },
        Sovereign = {
            SoundId = 8091567304,
            Volume = 1.5
        },
        Erasure = {
            SoundId = 8091567919,
            Volume = 1.5
        },
        Counter = {
            SoundId = 8091569919,
            Volume = 1.5
        },
        ["Sovereign Theme"] = {
            SoundId = 10405445591,
            Volume = 1.5,
            Looped = true
        },
        ["Umbral Dash"] = {
            SoundId = 8091560121,
            Volume = 1.5
        },
        Pose = {
            SoundId = 10405445591,
            PlaybackSpeed = 1,
            Volume = 1.5,
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
            Universal = { {
                    SoundId = "rbxassetid://9062233697",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I thought you were supposed to be tough.",
                            ScaleTime = 1.5
                        } }
                }, {
                    SoundId = "rbxassetid://9062236473",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t help it.",
                            ScaleTime = 0.5
                        }, {
                            Quote = " This is what my ability is capable of.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://9062239975",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I should be executed for everything, right?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8093296787",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you stand a chance?",
                            ScaleTime = 1
                        } }
                } },
            Sovereign = { {
                    SoundId = "rbxassetid://9062233697",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I thought you were supposed to be tough.",
                            ScaleTime = 1.5
                        } }
                }, {
                    SoundId = "rbxassetid://9062236473",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t help it.",
                            ScaleTime = 0.5
                        }, {
                            Quote = " This is what my ability is capable of.",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://9062239975",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I should be executed for everything, right?",
                            ScaleTime = 1
                        } }
                }, {
                    SoundId = "rbxassetid://8093296787",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You think you stand a chance?",
                            ScaleTime = 1
                        } }
                } }
        }
    }
};
  

 

return {
    Animations = {
        Character = {
            Idle = {
                AnimationId = "rbxassetid://90414963113321",
                Priority = Enum.AnimationPriority.Core
            },
            Walk = {
                AnimationId = "rbxassetid://10455591976",
                Priority = Enum.AnimationPriority.Movement
            },
            Run = {
                AnimationId = "rbxassetid://18199888373",
                Speed = 0.5,
                Priority = Enum.AnimationPriority.Movement
            },
            Hybrid_Idle = {
                AnimationId = "rbxassetid://93677998586528",
                State = "Idle",
                StatePriority = 10,
                Enabled = false,
                Priority = Enum.AnimationPriority.Core
            },
            Hybrid_Walk = {
                AnimationId = "rbxassetid://95119875154215",
                State = "Walk",
                StatePriority = 10,
                Enabled = false,
                Priority = Enum.AnimationPriority.Movement
            },
            Hybrid_Run = {
                AnimationId = "rbxassetid://131820500609149",
                Speed = 0.5,
                State = "Run",
                StatePriority = 10,
                Enabled = false,
                Priority = Enum.AnimationPriority.Movement
            }
        },
        Moves = {
            Dash = {
                Forward = {
                    Priority = Enum.AnimationPriority.Action
                },
                Left = {
                    Priority = Enum.AnimationPriority.Action
                },
                Back = {
                    Priority = Enum.AnimationPriority.Action
                },
                Right = {
                    Priority = Enum.AnimationPriority.Action
                }
            },
            Ripcord = {
                Transform = {
                    AnimationId = "rbxassetid://118439067789567",
                    Priority = Enum.AnimationPriority.Idle
                },
                Pull = {
                    AnimationId = "rbxassetid://73941894432112",
                    Priority = Enum.AnimationPriority.Action
                },
                Detransform = {
                    ["1"] = {
                        AnimationId = "rbxassetid://7290321324",
                        Priority = Enum.AnimationPriority.Action
                    },
                    ["2"] = {
                        AnimationId = "rbxassetid://7290325561",
                        Priority = Enum.AnimationPriority.Action
                    },
                    ["3"] = {
                        AnimationId = "rbxassetid://7290327465",
                        Priority = Enum.AnimationPriority.Action
                    }
                }
            },
            Rush_Attack = {
                ["1"] = {
                    AnimationId = "rbxassetid://76522684655114",
                    Priority = Enum.AnimationPriority.Action
                },
                ["2"] = {
                    AnimationId = "rbxassetid://125981937964322",
                    Priority = Enum.AnimationPriority.Action
                },
                ["3"] = {
                    AnimationId = "rbxassetid://94695984507846",
                    Priority = Enum.AnimationPriority.Action2
                },
                ["4"] = {
                    AnimationId = "rbxassetid://113022834661303",
                    Priority = Enum.AnimationPriority.Action3
                }
            },
            Thrash_Saw = {
                Startup = {
                    AnimationId = "rbxassetid://87290240850813",
                    Priority = Enum.AnimationPriority.Action
                },
                Grab = {
                    AnimationId = "rbxassetid://119519084255716",
                    Priority = Enum.AnimationPriority.Action2
                },
                Grab_Victim = {
                    AnimationId = "rbxassetid://103463680077914",
                    Priority = Enum.AnimationPriority.Action2
                }
            },
            Devil_Chain = {
                Startup = {
                    Body = {
                        AnimationId = "rbxassetid://78524306087799",
                        Priority = Enum.AnimationPriority.Action
                    },
                    Legs = {
                        AnimationId = "rbxassetid://95829172131378",
                        Priority = Enum.AnimationPriority.Idle
                    }
                },
                Pull = {
                    Body = {
                        AnimationId = "rbxassetid://123873840656359",
                        Priority = Enum.AnimationPriority.Action
                    },
                    Legs = {
                        AnimationId = "rbxassetid://132469982749659",
                        Priority = Enum.AnimationPriority.Idle
                    }
                },
                Reel = {
                    AnimationId = "rbxassetid://112560692096923",
                    Priority = Enum.AnimationPriority.Action
                },
                Slam = {
                    AnimationId = "rbxassetid://123353844433017",
                    Priority = Enum.AnimationPriority.Action
                },
                Launcher = {
                    AnimationId = "rbxassetid://119486796104375",
                    Priority = Enum.AnimationPriority.Action
                }
            },
            Rip_N_Tear = {
                Rip = {
                    AnimationId = "rbxassetid://95528559904061",
                    Priority = Enum.AnimationPriority.Action
                },
                Rip_Aerial = {
                    AnimationId = "rbxassetid://110558278121289",
                    Priority = Enum.AnimationPriority.Action
                },
                Tear = {
                    AnimationId = "rbxassetid://91554242358642",
                    Priority = Enum.AnimationPriority.Action
                }
            },
            Wild_Crash = {
                Grounded = {
                    Startup = {
                        AnimationId = "rbxassetid://80915022168715",
                        Priority = Enum.AnimationPriority.Action
                    },
                    Grab = {
                        AnimationId = "rbxassetid://121697329386361",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Grab_Victim = {
                        AnimationId = "rbxassetid://90078044884497",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Finisher = {
                        AnimationId = "rbxassetid://100754649576313",
                        Priority = Enum.AnimationPriority.Action3
                    },
                    Finisher_Victim = {
                        AnimationId = "rbxassetid://134171598221262",
                        Priority = Enum.AnimationPriority.Action3
                    }
                },
                Aerial = {
                    Startup = {
                        AnimationId = "rbxassetid://131638728225702",
                        Priority = Enum.AnimationPriority.Action
                    },
                    Grab = {
                        AnimationId = "rbxassetid://108879754855003",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Grab_Victim = {
                        AnimationId = "rbxassetid://87311409477474",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Fall = {
                        AnimationId = "rbxassetid://83471813109123",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Fall_Victim = {
                        AnimationId = "rbxassetid://75012284076907",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Slam = {
                        AnimationId = "rbxassetid://127236000465907",
                        Priority = Enum.AnimationPriority.Action2
                    },
                    Slam_Victim = {
                        AnimationId = "rbxassetid://82671792318057",
                        Priority = Enum.AnimationPriority.Action2
                    }
                }
            },
            Violent_Carve = {
                Grounded = {
                    AnimationId = "rbxassetid://91736194847200",
                    Priority = Enum.AnimationPriority.Action
                },
                Aerial = {
                    AnimationId = "rbxassetid://117477659043648",
                    Priority = Enum.AnimationPriority.Action
                },
                Stomp_Victim = {
                    AnimationId = "rbxassetid://87306516593073",
                    Priority = Enum.AnimationPriority.Action2
                },
                Hit_Victim = {
                    AnimationId = "rbxassetid://82511323590190",
                    Priority = Enum.AnimationPriority.Action3
                }
            },
            Cheap_Shot = {
                Startup = {
                    AnimationId = "rbxassetid://80105160682836",
                    Priority = Enum.AnimationPriority.Action
                },
                Counter = {
                    AnimationId = "rbxassetid://132949449402428",
                    Priority = Enum.AnimationPriority.Action2
                },
                Counter_Victim = {
                    AnimationId = "rbxassetid://86324731770780",
                    Priority = Enum.AnimationPriority.Action2
                }
            },
            Rampage = {
                User = {
                    AnimationId = "rbxassetid://87060464524124",
                    Priority = Enum.AnimationPriority.Action
                },
                Victim = {
                    AnimationId = "rbxassetid://133651865613891",
                    Priority = Enum.AnimationPriority.Action2
                }
            },
            Cull = {
                AnimationId = "rbxassetid://94512320359542",
                Priority = Enum.AnimationPriority.Action
            },
            Pose = {
                Startup = {
                    AnimationId = "rbxassetid://77823663864997",
                    Priority = Enum.AnimationPriority.Idle
                },
                Loop = {
                    AnimationId = "rbxassetid://113061098001578",
                    Priority = Enum.AnimationPriority.Action
                },
                Body_Startup = {
                    AnimationId = "rbxassetid://77591240585955",
                    Priority = Enum.AnimationPriority.Action
                },
                Body_Loop = {
                    AnimationId = "rbxassetid://100394619575478",
                    Priority = Enum.AnimationPriority.Action
                }
            }
        }
    },
    Sounds = {
        Rush_Attack_1 = {
            SoundId = "rbxassetid://115253247598273",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rush_Attack_Hit = {
            SoundId = "rbxassetid://92241966435239",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0,
            Transformer = script.PlaybackSpeedRandomizer,
            Attributes = {
                PlaybackSpeedRange = NumberRange.new(0.85, 1.15)
            }
        },
        Rush_Attack_2 = {
            SoundId = "rbxassetid://132899371338924",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rush_Attack_3 = {
            SoundId = "rbxassetid://82549282414000",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rush_Attack_4 = {
            SoundId = "rbxassetid://84784679816584",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rush_Attack_4_Hit = {
            SoundId = "rbxassetid://124557568423489",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0,
            Transformer = script.PlaybackSpeedRandomizer,
            Attributes = {
                PlaybackSpeedRange = NumberRange.new(0.85, 1.15)
            }
        },
        Ripcord = {
            SoundId = "rbxassetid://123019098985954",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thrash_Saw_Startup = {
            SoundId = "rbxassetid://120084948463844",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Thrash_Saw_Grab = {
            SoundId = "rbxassetid://74260306319276",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rip = {
            SoundId = "rbxassetid://120084948463844",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rip_Hit = {
            SoundId = "rbxassetid://81986715261825",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rip_Aerial = {
            SoundId = "rbxassetid://102442437129164",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rip_Aerial_Hit = {
            SoundId = "rbxassetid://128183679977976",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Tear = {
            SoundId = "rbxassetid://134388033719934",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Tear_Hit = {
            SoundId = "rbxassetid://92241966435239",
            Volume = 0.45,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0,
            Transformer = script.PlaybackSpeedRandomizer,
            Attributes = {
                PlaybackSpeedRange = NumberRange.new(1.45, 1.75)
            }
        },
        Wild_Crash_Startup = {
            SoundId = "rbxassetid://120084948463844",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Grab = {
            SoundId = "rbxassetid://139967676216288",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Finisher = {
            SoundId = "rbxassetid://70621463307308",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial = {
            SoundId = "rbxassetid://102442437129164",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial_Startup = {
            SoundId = "rbxassetid://120400575322426",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial_Chain_Hit = {
            SoundId = "rbxassetid://78506651701493",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial_Grab = {
            SoundId = "rbxassetid://117793761531771",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial_Grab_Hit = {
            SoundId = "rbxassetid://128183679977976",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Wild_Crash_Aerial_Slam = {
            SoundId = "rbxassetid://73853831409385",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Violent_Carve = {
            SoundId = "rbxassetid://103237481837182",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Violent_Carve_Aerial = {
            SoundId = "rbxassetid://126819955659524",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Cheap_Shot_Startup = {
            SoundId = "rbxassetid://87837042344273",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Cheap_Shot_Counter = {
            SoundId = "rbxassetid://118544028664359",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Devil_Chain = {
            SoundId = "rbxassetid://116247702670162",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Devil_Chain_Hit = {
            SoundId = "rbxassetid://106839180719904",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Devil_Chain_Slam = {
            SoundId = "rbxassetid://112155058539713",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Rampage = {
            SoundId = "rbxassetid://124420832535716",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Cull = {
            SoundId = "rbxassetid://91248348069168",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Cull_Break = {
            SoundId = "rbxassetid://137305888728426",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    },
    Quotes = {}
};
 
 

return {
    Information = {
        FPS = 60
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "Lighting", "DepthOfField" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "Bloom" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "StarterGui", "Vignette", "Frame", "Main" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "Blur" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "ColorCorrection" }
            }
        } },
    Data = {
        {
            Enabled = {
                default = {
                    Value = true
                },
                [0] = {
                    Value = true,
                    Style = "Constant"
                }
            },
            FarIntensity = {
                [327] = {
                    Value = 0.7,
                    Style = "Constant"
                },
                [0] = {
                    Value = 1,
                    Style = "Constant"
                },
                [867] = {
                    Value = 1,
                    Style = "Constant"
                },
                [326] = {
                    Value = 1
                },
                default = {
                    Value = 0.10000000149011612
                },
                [803] = {
                    Value = 0.699999988079071
                },
                [278] = {
                    Value = 0.39999999999999997
                },
                [714] = {
                    Value = 0.39999999999999997,
                    Style = "Constant"
                },
                [561] = {
                    Value = 1,
                    Style = "Constant"
                }
            },
            FocusDistance = {
                default = {
                    Value = 0.05000000074505806
                },
                [0] = {
                    Value = 0.05000000074505806,
                    Style = "Constant"
                }
            },
            InFocusRadius = {
                [0] = {
                    Value = 30,
                    Style = "Constant"
                },
                default = {
                    Value = 30
                },
                [705] = {
                    Value = 0,
                    Style = "Constant"
                },
                [714] = {
                    Value = 30
                },
                [629] = {
                    Value = 30
                }
            },
            NearIntensity = {
                default = {
                    Value = 0.75
                },
                [0] = {
                    Value = 0.75,
                    Style = "Constant"
                }
            }
        },
        {
            Enabled = {
                default = {
                    Value = true
                },
                [0] = {
                    Value = true,
                    Style = "Constant"
                }
            },
            Threshold = {
                [327] = {
                    Value = 0.7999999999999999
                },
                [0] = {
                    Value = 1.8559999465942383,
                    Style = "Constant"
                },
                default = {
                    Value = 1.8559999465942383
                },
                [935] = {
                    Value = 1
                },
                [628] = {
                    Value = 1.3,
                    Style = "Constant"
                },
                [223] = {
                    Value = 1,
                    Style = "Constant"
                },
                [386] = {
                    Value = 1.4,
                    Style = "Constant"
                },
                [561] = {
                    Value = 0.7999999999999999,
                    Style = "Expo",
                    Direction = "In"
                }
            }
        },
        {
            Ambient = {
                [937] = {
                    Value = Color3.new(0.6117647, 0.6117647, 0.6117647)
                },
                [0] = {
                    Style = "Constant",
                    Value = Color3.new(1, 1, 1)
                },
                [629] = {
                    Value = Color3.new(1, 1, 1)
                },
                [223] = {
                    Style = "Sine",
                    Direction = "Out",
                    Value = Color3.new(0, 0, 0)
                },
                [557] = {
                    Style = "Constant",
                    Value = Color3.new(0.7882353, 0.7882353, 0.7882353)
                },
                [657] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                default = {
                    Value = Color3.new(1, 1, 1)
                },
                [248] = {
                    Style = "Constant",
                    Value = Color3.new(0.78039217, 0.78039217, 0.78039217)
                },
                [548] = {
                    Style = "Expo",
                    Direction = "In",
                    Value = Color3.new(1, 1, 1)
                },
                [278] = {
                    Style = "Constant",
                    Value = Color3.new(1, 1, 1)
                },
                [714] = {
                    Style = "Constant",
                    Value = Color3.new(0.91764706, 0.91764706, 0.91764706)
                },
                [120] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                }
            },
            OutdoorAmbient = {
                [0] = {
                    Style = "Constant",
                    Value = Color3.new(0.18431373, 0.18431373, 0.18431373)
                },
                default = {
                    Value = Color3.new(0.18431373, 0.18431373, 0.18431373)
                },
                [248] = {
                    Style = "Constant",
                    Value = Color3.new(0.18431373, 0.18431373, 0.18431373)
                },
                [223] = {
                    Style = "Sine",
                    Direction = "Out",
                    Value = Color3.new(0, 0, 0)
                },
                [714] = {
                    Style = "Constant",
                    Value = Color3.new(0.18431373, 0.18431373, 0.18431373)
                },
                [120] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                }
            },
            Brightness = {
                [937] = {
                    Value = 2
                },
                [0] = {
                    Value = 3,
                    Style = "Constant"
                },
                [629] = {
                    Value = 0.6789999999999999
                },
                [223] = {
                    Value = 0,
                    Style = "Sine",
                    Direction = "Out"
                },
                [557] = {
                    Value = 1,
                    Style = "Constant"
                },
                [529] = {
                    Value = 0,
                    Style = "Cubic",
                    Direction = "In"
                },
                [657] = {
                    Value = 0,
                    Style = "Constant"
                },
                default = {
                    Value = 3
                },
                [248] = {
                    Value = 1,
                    Style = "Constant"
                },
                [548] = {
                    Value = 1.5,
                    Style = "Expo",
                    Direction = "In"
                },
                [278] = {
                    Value = 2,
                    Style = "Constant"
                },
                [714] = {
                    Value = 3,
                    Style = "Constant"
                },
                [120] = {
                    Value = 0,
                    Style = "Constant"
                }
            },
            EnvironmentDiffuseScale = {
                [0] = {
                    Value = 1,
                    Style = "Constant"
                },
                [629] = {
                    Value = 0.33944955468177795
                },
                [223] = {
                    Value = 0,
                    Style = "Sine",
                    Direction = "Out"
                },
                [557] = {
                    Value = 1,
                    Style = "Constant"
                },
                [529] = {
                    Value = 0,
                    Style = "Cubic",
                    Direction = "In"
                },
                default = {
                    Value = 1
                },
                [248] = {
                    Value = 1,
                    Style = "Constant"
                },
                [548] = {
                    Value = 0.5,
                    Style = "Expo",
                    Direction = "In"
                },
                [657] = {
                    Value = 0,
                    Style = "Constant"
                },
                [714] = {
                    Value = 1,
                    Style = "Constant"
                },
                [120] = {
                    Value = 0,
                    Style = "Constant"
                }
            },
            EnvironmentSpecularScale = {
                [0] = {
                    Value = 1,
                    Style = "Constant"
                },
                [629] = {
                    Value = 0.33944955468177795
                },
                [223] = {
                    Value = 0,
                    Style = "Sine",
                    Direction = "Out"
                },
                [557] = {
                    Value = 1,
                    Style = "Constant"
                },
                [529] = {
                    Value = 0,
                    Style = "Cubic",
                    Direction = "In"
                },
                default = {
                    Value = 1
                },
                [248] = {
                    Value = 1,
                    Style = "Constant"
                },
                [548] = {
                    Value = 0.5,
                    Style = "Expo",
                    Direction = "In"
                },
                [657] = {
                    Value = 0,
                    Style = "Constant"
                },
                [714] = {
                    Value = 1,
                    Style = "Constant"
                },
                [120] = {
                    Value = 0,
                    Style = "Constant"
                }
            }
        },
        {
            ImageColor3 = {
                [717] = {
                    Value = Color3.new(1, 0.41568625, 0.41568625)
                },
                [557] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [387] = {
                    Value = Color3.new(0, 0, 0)
                },
                [487] = {
                    Value = Color3.new(0, 0, 0)
                },
                [390] = {
                    Value = Color3.new(1, 0.29019606, 0.29019606)
                },
                [0] = {
                    Style = "Constant",
                    Value = Color3.new(1, 1, 1)
                },
                [418] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [629] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [529] = {
                    Value = Color3.new(1, 1, 1)
                },
                [742] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [936] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                default = {
                    Value = Color3.new(1, 1, 1)
                },
                [471] = {
                    Value = Color3.new(1, 1, 1)
                },
                [608] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [561] = {
                    Value = Color3.new(1, 1, 1)
                },
                [714] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                },
                [120] = {
                    Style = "Constant",
                    Value = Color3.new(0, 0, 0)
                }
            },
            ImageTransparency = {
                [327] = {
                    Value = 0.7
                },
                [223] = {
                    Value = 0.39999999999999997,
                    Style = "Constant"
                },
                [557] = {
                    Value = 0.699999988079071,
                    Style = "Constant"
                },
                [326] = {
                    Value = 0.39999999999999997,
                    Style = "Constant"
                },
                [387] = {
                    Value = 0.699999988079071
                },
                [688] = {
                    Value = 0.39999999999999997,
                    Style = "Constant"
                },
                [487] = {
                    Value = 0.7
                },
                [390] = {
                    Value = 0.5
                },
                [0] = {
                    Value = 1,
                    Style = "Constant"
                },
                [471] = {
                    Value = 0.5
                },
                [418] = {
                    Value = 0.699999988079071,
                    Style = "Sine",
                    Direction = "InOut"
                },
                [629] = {
                    Value = 0.6
                },
                [717] = {
                    Value = 0.7
                },
                [470] = {
                    Value = 0.15
                },
                [529] = {
                    Value = 0.5
                },
                [742] = {
                    Value = 0.5499999999999999,
                    Style = "Constant"
                },
                [936] = {
                    Value = 0.7999999999999999,
                    Style = "Constant"
                },
                default = {
                    Value = 1
                },
                [608] = {
                    Value = 0.699999988079071,
                    Style = "Constant"
                },
                [561] = {
                    Value = 0.6
                },
                [278] = {
                    Value = 0.699999988079071
                },
                [714] = {
                    Value = 0.3,
                    Style = "Constant"
                },
                [120] = {
                    Value = 0.6,
                    Style = "Constant"
                }
            }
        },
        {
            Enabled = {
                default = {
                    Value = true
                },
                [0] = {
                    Value = true,
                    Style = "Constant"
                }
            },
            Size = {
                [841] = {
                    Value = 0,
                    Style = "Constant"
                },
                [0] = {
                    Value = 0,
                    Style = "Constant"
                },
                [935] = {
                    Value = 15
                },
                [945] = {
                    Value = 0,
                    Style = "Constant"
                },
                [717] = {
                    Value = 5
                },
                [615] = {
                    Value = 0,
                    Style = "Constant"
                },
                [529] = {
                    Value = 10
                },
                [742] = {
                    Value = 0
                },
                default = {
                    Value = 0
                },
                [929] = {
                    Value = 0,
                    Style = "Constant"
                },
                [909] = {
                    Value = 7
                },
                [812] = {
                    Value = 10
                },
                [561] = {
                    Value = 5
                },
                [556] = {
                    Value = 0,
                    Style = "Constant"
                }
            }
        },
        {
            Enabled = {
                default = {
                    Value = true
                },
                [0] = {
                    Value = true,
                    Style = "Constant"
                }
            },
            Saturation = {
                [909] = {
                    Value = -1,
                    Style = "Constant"
                },
                [0] = {
                    Value = -0.10000000149011612,
                    Style = "Constant"
                },
                [613] = {
                    Value = -0.19999999999999998,
                    Style = "Constant"
                },
                [418] = {
                    Value = -0.20000000298023224
                },
                [942] = {
                    Value = -0.19999999999999998
                },
                [935] = {
                    Value = -1
                },
                [470] = {
                    Value = -0.39999999999999997
                },
                [529] = {
                    Value = -1,
                    Style = "Cubic",
                    Direction = "In"
                },
                [912] = {
                    Value = -1,
                    Style = "Constant"
                },
                [915] = {
                    Value = 0,
                    Style = "Constant"
                },
                default = {
                    Value = -0.10000000149011612
                },
                [560] = {
                    Value = -0.5,
                    Style = "Quint",
                    Direction = "In"
                },
                [548] = {
                    Value = -1,
                    Style = "Expo",
                    Direction = "In"
                },
                [557] = {
                    Value = -0.19999999999999998
                },
                [471] = {
                    Value = -0.19999999999999998,
                    Style = "Constant"
                },
                [120] = {
                    Value = -0.19999999999999998,
                    Style = "Constant"
                }
            },
            Contrast = {
                [909] = {
                    Value = 10,
                    Style = "Constant"
                },
                [0] = {
                    Value = 0,
                    Style = "Constant"
                },
                [935] = {
                    Value = 2
                },
                [942] = {
                    Value = 0
                },
                [519] = {
                    Value = 0,
                    Style = "Cubic",
                    Direction = "In"
                },
                [557] = {
                    Value = 0,
                    Style = "Constant"
                },
                [529] = {
                    Value = 1,
                    Style = "Cubic",
                    Direction = "In"
                },
                [742] = {
                    Value = 0,
                    Style = "Constant"
                },
                [915] = {
                    Value = 0,
                    Style = "Constant"
                },
                default = {
                    Value = 0
                },
                [912] = {
                    Value = -10,
                    Style = "Constant"
                },
                [548] = {
                    Value = 0.5,
                    Style = "Expo",
                    Direction = "In"
                },
                [717] = {
                    Value = 0.19999999999999998,
                    Style = "Sine",
                    Direction = "Out"
                },
                [528] = {
                    Value = 1
                },
                [120] = {
                    Value = 0,
                    Style = "Constant"
                }
            },
            TintColor = {
                [938] = {
                    Value = Color3.new(0.19607842, 0.4827134, 1)
                },
                [103] = {
                    Value = Color3.new(1, 1, 1)
                },
                [113] = {
                    Value = Color3.new(0, 0, 0)
                },
                [497] = {
                    Value = Color3.new(1, 1, 1)
                },
                [506] = {
                    Value = Color3.new(0, 0, 0)
                },
                [1] = {
                    Value = Color3.new(1, 1, 1)
                },
                [0] = {
                    Value = Color3.new(1, 1, 1)
                },
                [935] = {
                    Value = Color3.new(1, 0.36862743, 0.80126727)
                },
                [134] = {
                    Value = Color3.new(1, 1, 1)
                },
                [519] = {
                    Style = "Constant",
                    Value = Color3.new(1, 1, 1)
                },
                [912] = {
                    Style = "Constant",
                    Value = Color3.new(0.9812447, 0.9812447, 0.9812447)
                },
                default = {
                    Value = Color3.new(1, 1, 1)
                },
                [942] = {
                    Value = Color3.new(1, 1, 1)
                },
                [514] = {
                    Value = Color3.new(0, 0, 0)
                },
                [125] = {
                    Value = Color3.new(0, 0, 0)
                },
                [11] = {
                    Value = Color3.new(1, 1, 1)
                },
                [909] = {
                    Style = "Constant",
                    Value = Color3.new(0.98039216, 0.98039216, 0.98039216)
                }
            },
            Brightness = {
                [327] = {
                    Value = 0.5
                },
                [0] = {
                    Value = 0
                },
                [935] = {
                    Value = 0.5
                },
                [948] = {
                    Value = 0
                },
                [345] = {
                    Value = 0,
                    Style = "Constant"
                },
                default = {
                    Value = 0
                },
                [915] = {
                    Value = 0,
                    Style = "Constant"
                },
                [1] = {
                    Value = 0.5
                },
                [909] = {
                    Value = 0.5,
                    Style = "Constant"
                },
                [11] = {
                    Value = 0
                },
                [120] = {
                    Value = 0,
                    Style = "Constant"
                }
            }
        }
    }
};
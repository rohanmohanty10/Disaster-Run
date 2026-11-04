 

 

return {
    Information = {
        FPS = 60,
        Length = 960
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "Workspace", "CurrentCamera" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "ColorCorrection" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "DepthOfField" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "Bloom" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "Blur" }
            }
        } },
    Data = {
        {
            FieldOfView = {
                default = {
                    Value = 70
                },
                [0] = {
                    Value = 20,
                    Style = "Cubic",
                    Direction = "InOut"
                },
                [128] = {
                    Value = 70,
                    Style = "Back",
                    Direction = "In"
                },
                [169] = {
                    Value = 50,
                    Style = "Sine",
                    Direction = "Out"
                },
                [190] = {
                    Value = 40,
                    Style = "Constant"
                },
                [264] = {
                    Value = 30,
                    Style = "Circ",
                    Direction = "In"
                },
                [335] = {
                    Value = 40,
                    Style = "Circ",
                    Direction = "In"
                },
                [407] = {
                    Value = 30
                },
                [408] = {
                    Value = 40
                },
                [484] = {
                    Value = 30
                },
                [485] = {
                    Value = 38,
                    Style = "Circ",
                    Direction = "Out"
                },
                [587] = {
                    Value = 56,
                    Style = "Cubic",
                    Direction = "Out"
                },
                [645] = {
                    Value = 50,
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
                default = {
                    Value = -0.10000000149011612
                },
                [0] = {
                    Value = -0.10000000149011612
                }
            },
            Contrast = {
                default = {
                    Value = 0
                },
                [0] = {
                    Value = 0,
                    Style = "Constant"
                },
                [586] = {
                    Value = 0.3,
                    Style = "Constant"
                },
                [645] = {
                    Value = 0
                }
            },
            TintColor = {
                default = {
                    Value = Color3.new(1, 1, 1)
                },
                [0] = {
                    Value = Color3.new(0, 0, 0)
                },
                [59] = {
                    Value = Color3.new(1, 1, 1)
                },
                [71] = {
                    Value = Color3.new(1, 1, 1)
                },
                [81] = {
                    Style = "Quad",
                    Direction = "In",
                    Value = Color3.new(0, 0, 0)
                },
                [119] = {
                    Style = "Sine",
                    Direction = "InOut",
                    Value = Color3.new(1, 1, 1)
                },
                [153] = {
                    Style = "Sine",
                    Direction = "Out",
                    Value = Color3.new(0, 0, 0)
                },
                [180] = {
                    Value = Color3.new(1, 1, 1)
                }
            },
            Brightness = {
                default = {
                    Value = 0
                },
                [0] = {
                    Value = 0
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
            FarIntensity = {
                default = {
                    Value = 0.10000000149011612
                },
                [0] = {
                    Value = 1
                }
            },
            InFocusRadius = {
                default = {
                    Value = 30
                },
                [0] = {
                    Value = 5,
                    Style = "Constant"
                },
                [485] = {
                    Value = 1,
                    Style = "Constant"
                },
                [645] = {
                    Value = 5,
                    Style = "Constant"
                }
            }
        },
        {
            Ambient = {
                default = {
                    Value = Color3.new(1, 1, 1)
                },
                [0] = {
                    Value = Color3.new(1, 1, 1)
                }
            },
            Brightness = {
                default = {
                    Value = 3
                },
                [0] = {
                    Value = 3
                }
            }
        },
        {
            Threshold = {
                default = {
                    Value = 1.8559999465942383
                },
                [0] = {
                    Value = 0.7999999999999999
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
                default = {
                    Value = 0
                },
                [0] = {
                    Value = 20
                },
                [59] = {
                    Value = 8
                },
                [71] = {
                    Value = 4
                },
                [81] = {
                    Value = 20,
                    Style = "Quad",
                    Direction = "In"
                },
                [119] = {
                    Value = 5,
                    Style = "Sine",
                    Direction = "InOut"
                },
                [153] = {
                    Value = 20,
                    Style = "Sine",
                    Direction = "Out"
                },
                [180] = {
                    Value = 0,
                    Style = "Constant"
                },
                [586] = {
                    Value = 20
                },
                [609] = {
                    Value = 0,
                    Style = "Constant"
                }
            }
        }
    }
};
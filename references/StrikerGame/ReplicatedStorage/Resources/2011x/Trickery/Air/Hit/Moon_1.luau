 
 

return {
    Information = {
        FPS = 60
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "Lighting", "ColorCorrection" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Workspace", "CurrentCamera" }
            }
        } },
    Data = {
        {
            Brightness = {
                [0] = {
                    Value = 0,
                    Style = "Constant"
                },
                default = {
                    Value = 0
                }
            },
            Contrast = {
                [0] = {
                    Value = 0.7,
                    Style = "Sine",
                    Direction = "Out"
                },
                [14] = {
                    Value = 0,
                    Style = "Constant"
                },
                [38] = {
                    Value = 0.7,
                    Style = "Back",
                    Direction = "In"
                },
                [66] = {
                    Value = 0
                },
                default = {
                    Value = 0
                }
            },
            Enabled = {
                [0] = {
                    Value = true,
                    Style = "Constant"
                },
                default = {
                    Value = true
                }
            },
            Saturation = {
                [0] = {
                    Value = -0.10000000149011612,
                    Style = "Constant"
                },
                default = {
                    Value = -0.10000000149011612
                }
            },
            TintColor = {
                [0] = {
                    Style = "Sine",
                    Direction = "Out",
                    Value = Color3.new(1, 0.45098037, 0.45098037)
                },
                [14] = {
                    Style = "Constant",
                    Value = Color3.new(0.9137255, 0.9137255, 0.9137255)
                },
                [38] = {
                    Style = "Back",
                    Direction = "In",
                    Value = Color3.new(1, 0.54509807, 0.54509807)
                },
                [66] = {
                    Value = Color3.new(0.9137255, 0.9137255, 0.9137255)
                },
                default = {
                    Value = Color3.new(1, 1, 1)
                }
            }
        },
        {
            FieldOfView = {
                [0] = {
                    Value = 70,
                    Style = "Constant"
                },
                [38] = {
                    Value = 60,
                    Style = "Sine",
                    Direction = "Out"
                },
                [58] = {
                    Value = 65,
                    Style = "Linear"
                },
                [59] = {
                    Value = 55,
                    Style = "Sine",
                    Direction = "Out"
                },
                [83] = {
                    Value = 70
                },
                default = {
                    Value = 70
                }
            }
        }
    }
};
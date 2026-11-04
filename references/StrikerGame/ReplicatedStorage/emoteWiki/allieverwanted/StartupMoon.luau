 

 

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
                InstanceNames = { "game", "Lighting", "BlurImpact" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Workspace", "CurrentCamera" }
            }
        } },
    Data = {
        {
            Enabled = {
                default = {
                    Value = true
                }
            },
            Saturation = {
                [101] = {
                    Value = -0.39999999999999997,
                    Style = "Quad",
                    Direction = "Out"
                },
                default = {
                    Value = 0
                },
                [81] = {
                    Value = 0,
                    Style = "Elastic",
                    Direction = "In"
                }
            },
            Contrast = {
                [101] = {
                    Value = 0.3,
                    Style = "Quad",
                    Direction = "Out"
                },
                default = {
                    Value = 0
                },
                [81] = {
                    Value = 0,
                    Style = "Cubic",
                    Direction = "In"
                }
            },
            TintColor = {
                default = {
                    Value = Color3.new(1, 1, 1)
                }
            },
            Brightness = {
                [101] = {
                    Value = 0.39999999999999997,
                    Style = "Quad",
                    Direction = "Out"
                },
                default = {
                    Value = 0
                },
                [81] = {
                    Value = 0,
                    Style = "Back",
                    Direction = "In"
                }
            }
        },
        {
            Enabled = {
                default = {
                    Value = true
                }
            },
            Size = {
                [101] = {
                    Value = 8,
                    Style = "Constant"
                },
                default = {
                    Value = 0
                },
                [66] = {
                    Value = 0,
                    Style = "Elastic",
                    Direction = "In"
                }
            }
        },
        {
            FieldOfView = {
                [101] = {
                    Value = 105,
                    Style = "Quad",
                    Direction = "Out"
                },
                [80] = {
                    Value = 70,
                    Style = "Back",
                    Direction = "In"
                },
                default = {
                    Value = 70
                }
            }
        }
    }
};
 
 

return {
    Information = {
        FPS = 60
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "CoreGui", "MoonAnimatorEffects", "Screen Cover" }
            }
        }, {
            Path = {
                InstanceNames = { "game", "Lighting", "ColorCorrection" }
            }
        } },
    Data = {
        [1] = {
            BackgroundTransparency = {
                [713] = {
                    Value = 1
                },
                default = {
                    Value = 1
                },
                [773] = {
                    Value = 0
                }
            }
        },
        [3] = {
            Brightness = {
                default = {
                    Value = 0
                },
                [0] = {
                    Value = -0.02,
                    Style = "Constant"
                }
            },
            Saturation = {
                default = {
                    Value = 0
                },
                [0] = {
                    Value = 0,
                    Style = "Constant"
                }
            },
            Contrast = {
                default = {
                    Value = 0
                },
                [5] = {
                    Value = 0.15
                }
            }
        }
    }
};
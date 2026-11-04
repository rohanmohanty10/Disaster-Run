 
 

return {
    Information = {
        FPS = 60
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "CoreGui", "MoonAnimatorEffects", "Vignette" }
            }
        } },
    Data = {
        {
            ImageColor3 = {
                [0] = {
                    Style = "Constant",
                    Value = Color3.new(0.73333335, 0, 0)
                },
                default = {
                    Value = Color3.new(0, 0, 0)
                }
            },
            ImageTransparency = {
                [0] = {
                    Value = 1
                },
                [138] = {
                    Value = 1
                },
                [139] = {
                    Value = 0
                },
                [175] = {
                    Value = 1
                },
                default = {
                    Value = 1
                }
            }
        }
    }
};
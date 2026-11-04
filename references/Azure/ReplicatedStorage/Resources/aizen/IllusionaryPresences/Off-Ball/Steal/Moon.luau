 

 

return {
    Information = {
        FPS = 60
    },
    Items = { {
            Path = {
                InstanceNames = { "game", "Workspace", "PurpleZWork", "TempEnemy", "shadowed" }
            }
        } },
    Data = { {
            FillTransparency = {
                [60] = {
                    Value = 0.5,
                    Style = "Sine",
                    Direction = "Out"
                },
                [0] = {
                    Value = 1
                },
                default = {
                    Value = 0
                },
                [30] = {
                    Value = 1
                },
                [160] = {
                    Value = 1,
                    Style = "Sine",
                    Direction = "Out"
                },
                [135] = {
                    Value = 0.5,
                    Style = "Sine",
                    Direction = "Out"
                }
            }
        } }
};
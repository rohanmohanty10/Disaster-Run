 

 

return {
    { 13, function(p1, p2, p3, p4, p5) -- Line: 6
            p5.Speak(p3, {
                {
                    Text = "To bring  about the justice i desired...",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = {
                        Keypoints = {
                            {
                                Time = 0,
                                Value = Color3.new(0, 0, 0)
                            },
                            {
                                Time = 1,
                                Value = Color3.new(1, 1, 1)
                            }
                        }
                    },
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 0.5
                    }
                }
            }, 3);
        end },
    { 197, function(p6, p7, p8, p9) -- Line: 28
            shared.vfx.emit(p9.HumanoidRootPart.BeamStart);
        end },
    { 213, function(p10, p11, p12, p13, p14) -- Line: 34
            p14.Speak(p12, {
                {
                    Text = "I needed the perfect sympathizer as my ally",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = {
                        Keypoints = {
                            {
                                Time = 0,
                                Value = Color3.new(0, 0, 0)
                            },
                            {
                                Time = 1,
                                Value = Color3.new(1, 1, 1)
                            }
                        }
                    },
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 0.5
                    }
                }
            }, 3);
        end },
    { 345, function(p15, p16, p17, p18) -- Line: 56
            shared.vfx.emit(p15.BeamBurst);
        end },
    { 461, function(p19, p20, p21, p22, p23) -- Line: 62
            p23.Speak(p22, {
                {
                    Text = "In this timeline, there is no one who can stop us.",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = {
                        Keypoints = {
                            {
                                Time = 0,
                                Value = Color3.new(0, 0, 0)
                            },
                            {
                                Time = 1,
                                Value = Color3.new(1, 1, 1)
                            }
                        }
                    },
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 0.5
                    }
                }
            }, 4);
        end },
    { 697, function(p24, p25, p26, p27, p28) -- Line: 84
            p28.Speak(p27, {
                {
                    Text = "WE HAVE ALL THE POWER HERE",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = {
                        Keypoints = {
                            {
                                Time = 0,
                                Value = Color3.new(0, 0, 0)
                            },
                            {
                                Time = 1,
                                Value = Color3.new(1, 1, 1)
                            }
                        }
                    },
                    Shake = {
                        Enabled = false,
                        Intensity = 2,
                        Lifetime = 0.5
                    }
                }
            }, 2.5);
        end },
    { 702, function(p29, p30, p31, p32) -- Line: 106
            shared.vfx.emit(p32.Torso.Down);
        end },
    { 757, function(p33, p34, p35, p36) -- Line: 112
            shared.vfx.emit(p33.Drop);
        end },
    { 882, function(p37, p38, p39, p40, p41) -- Line: 118
            p41.Speak("", {
                {
                    Text = "THE TWO OF US ALONE",
                    Bold = false,
                    Italic = false,
                    TypeSpeed = 0.02,
                    HigherUp = true,
                    TextStrokeColor = Color3.new(0, 0, 0),
                    Color = {
                        Keypoints = {
                            {
                                Time = 0,
                                Value = Color3.new(0, 0, 0)
                            },
                            {
                                Time = 1,
                                Value = Color3.new(1, 1, 1)
                            }
                        }
                    },
                    Shake = {
                        Enabled = true,
                        Intensity = 5,
                        Lifetime = 2.5
                    }
                }
            }, 2.5);
        end },
    { 924, function(p42, p43, p44, p45) -- Line: 140
            shared.vfx.emit(p42.ScreenEffect2);
        end }
};
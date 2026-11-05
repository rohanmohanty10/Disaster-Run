  

 

return function(p1, p2) -- Line: 3
    if p1 then
        if typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        elseif typeof(p1) ~= "CFrame" then
            p1 = nil;
        end;
    end;

    local Effects = workspace.Effects;
    local u3 = p1 or CFrame.new(0, 0, 0);
    local v4 = {
        m3 = script.m3,
        m2 = script.m2,
        m1 = script.m1,
        m4 = script.m4,
        m5 = script.m5,
        m6 = script.m6,
        m7 = script.m7
    };
    local v5 = {
        [v4.m1] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0,
                Offset = CFrame.new(
                    1.32139027,
                    -2.99423289,
                    17.91432,
                    0.0126580894,
                    -0.362653673,
                    0.931837201,
                    -0.0136431083,
                    -0.931884229,
                    -0.362487584,
                    0.999826849,
                    -0.00812472217,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(16.051321, 1.8729216, 2.2179415),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.17456698,
                        -2.19620299,
                        -16.0959873,
                        0.0126580894,
                        -0.362653673,
                        0.931837201,
                        -0.0136431083,
                        -0.931884229,
                        -0.362487584,
                        0.999826849,
                        -0.00812472217,
                        -0.0167436525
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(1.0602868, 0.27921993, 0.33309916),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(0.784314, 0.392157, 392.157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0,
                Offset = CFrame.new(
                    1.32642961,
                    -2.99966407,
                    17.6091671,
                    0.0126580894,
                    -0.362653673,
                    0.931837201,
                    -0.0136431083,
                    -0.931884229,
                    -0.362487584,
                    0.999826849,
                    -0.00812472217,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(11.42654, 6.0762844, 6.055971),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.647595048,
                        -2.43950677,
                        -16.3365173,
                        0.0126580894,
                        -0.362653673,
                        0.931837201,
                        -0.0136431083,
                        -0.931884229,
                        -0.362487584,
                        0.999826849,
                        -0.00812472217,
                        -0.0167436525
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.7547921, 0.9058679, 0.90950966),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    -0.701010585,
                    -2.71061182,
                    14.2860279,
                    0.362653673,
                    0.0126580894,
                    0.931837261,
                    0.931884408,
                    -0.0136431083,
                    -0.362487555,
                    0.00812472496,
                    0.999826849,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.467394, 25.209919, 7.467394),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.15492487,
                        -2.22159481,
                        -21.5824146,
                        0.625668049,
                        0.0126580894,
                        -0.779986203,
                        -0.77986598,
                        -0.0136431083,
                        -0.62579149,
                        -0.0185627993,
                        0.999826849,
                        0.00133561145
                    ),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m4] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    1.35931838,
                    -3.03511286,
                    19.7023773,
                    0.0126580894,
                    -0.362653673,
                    0.931837261,
                    -0.0136431083,
                    -0.931884408,
                    -0.362487555,
                    0.999826849,
                    -0.00812472496,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(8.020972, 5.8808546, 5.861195),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.612424791,
                        -2.39608502,
                        -20.2516804,
                        0.0126580894,
                        -0.362653673,
                        0.931837261,
                        -0.0136431083,
                        -0.931884408,
                        -0.362487555,
                        0.999826849,
                        -0.00812472496,
                        -0.0167436525
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.5298337, 0.87673277, 0.8802574),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(0.784314, 0.392157, 3.92157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.m5] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    0.488366067,
                    0.372740597,
                    9.06593323,
                    0.931837082,
                    -0.0126580894,
                    0.362653553,
                    -0.362487614,
                    0.0136431083,
                    0.93188417,
                    -0.0167436488,
                    -0.999826849,
                    0.0081247231
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(28.114561, 20.683477, 28.114561),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.182417214,
                        0.702775717,
                        -15.1063366,
                        -0.931837082,
                        -0.0126580894,
                        -0.362653553,
                        0.362487614,
                        0.0136431083,
                        -0.93188417,
                        0.0167436488,
                        -0.999826849,
                        -0.0081247231
                    ),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m6] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.342573404,
                    -2.71988916,
                    -22.8217087,
                    0.705992877,
                    0.0081081409,
                    0.708171785,
                    0.70820868,
                    -0.0118730571,
                    -0.70589602,
                    0.00268459972,
                    0.999896646,
                    -0.0141245751
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(32.582672, 27.67158, 32.788532),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.902544379,
                        -3.06676459,
                        13.1906128,
                        0.512138188,
                        0.0081081409,
                        -0.85886389,
                        -0.858778596,
                        -0.0118730571,
                        -0.512198031,
                        -0.0143503174,
                        0.999896646,
                        0.000882513996
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m7] = {
            General = {
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.759527802,
                    -2.78192425,
                    -10.8230419,
                    0.0415914059,
                    -0.00810816512,
                    0.999102771,
                    -0.999055266,
                    0.0118730851,
                    0.041682899,
                    -0.0122003434,
                    -0.999898314,
                    -0.00760675501
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(19.165058, 31.649338, 17.12538),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -2.25656319,
                        -3.15447021,
                        7.422719,
                        0.957969308,
                        -0.00810816512,
                        -0.286758661,
                        0.286835462,
                        0.0118730851,
                        0.957900882,
                        -0.00436221762,
                        -0.999898314,
                        0.0136997281
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 279, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), Effects (ref)
                local v6 = i.Start:Clone();
                v6.Name = i.Name;
                v6.Transparency = v.General.Transparency;

                if v6:FindFirstChildOfClass("Decal") then
                    v6:FindFirstChildOfClass("Decal").Transparency = v.General.Transparency;
                    v6.Transparency = 1;
                end;

                v6.Anchored = true;
                v6.CanCollide = false;
                v6.CanQuery = false;
                v6.CanTouch = false;
                v6.Locked = true;
                v6.CFrame = u3 * v.General.Offset;
                v6.Parent = Effects;
                game:GetService("TweenService"):Create(v6, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();

                if v.Decal then
                    game:GetService("TweenService"):Create(v6:FindFirstChildOfClass("Decal"), TweenInfo.new(v.General.Tween_Duration, v.Decal.Tween.Easing_Style, v.Decal.Tween.Easing_Direction), v.Decal.Property):Play();
                end;

                if v.Mesh then
                    game:GetService("TweenService"):Create(v6:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v.General.Tween_Duration, v.Mesh.Tween.Easing_Style, v.Mesh.Tween.Easing_Direction), v.Mesh.Property):Play();
                end;

                task.delay(v.General.Tween_Duration, v6.Destroy, v6);
            end);
        end;
    end;
end;
  

 

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
        m8 = script.m8,
        m4 = script.m4,
        m5 = script.m5,
        m6 = script.m6,
        m7 = script.m7
    };
    local v5 = {
        [v4.m1] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    0.6438061,
                    2.67658496,
                    2.72914243,
                    0.93183732,
                    -0.0126580941,
                    0.362653822,
                    -0.362487644,
                    0.013643112,
                    0.931884885,
                    -0.0167436525,
                    -0.999826849,
                    0.00812472869
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(16.441153, 6.05438, 16.441153),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.571306944,
                        2.7548914,
                        -3.00114894,
                        -0.93183732,
                        -0.0126580941,
                        -0.362653822,
                        0.362487644,
                        0.013643112,
                        -0.931884885,
                        0.0167436525,
                        -0.999826849,
                        -0.00812472869
                    ),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    1.19518948,
                    -0.295375496,
                    24.430727,
                    0.0126580941,
                    -0.362653822,
                    0.93183732,
                    -0.013643112,
                    -0.931884885,
                    -0.362487644,
                    0.999826849,
                    -0.00812472869,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(5.517152, 4.0450916, 4.031569),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.681444049,
                        0.144174874,
                        -3.05130911,
                        0.0126580941,
                        -0.362653822,
                        0.93183732,
                        -0.013643112,
                        -0.931884885,
                        -0.362487644,
                        0.999826849,
                        -0.00812472869,
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
                    Scale = Vector3.new(0.36444122, 0.60305256, 0.6054769),
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
        [v4.m3] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    -0.554311633,
                    -0.0646592379,
                    19.1643372,
                    0.362653822,
                    0.0126580941,
                    0.93183732,
                    0.931884885,
                    -0.013643112,
                    -0.362487644,
                    0.00812472869,
                    0.999826849,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(5.2777696, 17.817747, 5.2777696),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.875124693,
                        0.280965328,
                        -6.18657303,
                        0.625668049,
                        0.0126580941,
                        -0.779986203,
                        -0.779866278,
                        -0.013643112,
                        -0.625791728,
                        -0.0185627993,
                        0.999826849,
                        0.00133560831
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
                Tween_Duration = 1,
                Transparency = 0,
                Offset = CFrame.new(
                    1.16827762,
                    -0.266368121,
                    22.3050327,
                    0.0126580922,
                    -0.362653732,
                    0.931837201,
                    -0.0136431111,
                    -0.931884766,
                    -0.362487674,
                    0.999826849,
                    -0.00812472682,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.6068535, 4.0450916, 4.031569),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.716364264,
                        0.106537417,
                        -0.293216646,
                        0.0126580922,
                        -0.362653732,
                        0.931837201,
                        -0.0136431111,
                        -0.931884766,
                        -0.362487674,
                        0.999826849,
                        -0.00812472682,
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
                    Scale = Vector3.new(0.50247866, 0.60305256, 0.6054769),
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
        [v4.m5] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0,
                Offset = CFrame.new(
                    1.16827762,
                    -0.266368121,
                    22.3050327,
                    0.0126580922,
                    -0.362653732,
                    0.931837201,
                    -0.0136431111,
                    -0.931884766,
                    -0.362487674,
                    0.999826849,
                    -0.00812472682,
                    -0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(10.970757, 1.2801043, 1.5159185),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.06792617,
                        0.279068828,
                        -0.940333486,
                        0.0126580922,
                        -0.362653732,
                        0.931837201,
                        -0.0136431111,
                        -0.931884766,
                        -0.362487674,
                        0.999826849,
                        -0.00812472682,
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
                    Scale = Vector3.new(0.7246848, 0.19084121, 0.22766659),
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
        [v4.m6] = {
            General = {
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.828412831,
                    0.655257344,
                    1.4570471,
                    0.0415912569,
                    -0.00810816512,
                    0.999102712,
                    -0.999055743,
                    0.011873086,
                    0.0416831076,
                    -0.0122003471,
                    -0.999898195,
                    -0.00760674849
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(13.104794, 21.641365, 11.71009),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.195236668,
                        0.400515765,
                        13.9332476,
                        0.957969248,
                        -0.00810816512,
                        -0.286758512,
                        0.28683573,
                        0.011873086,
                        0.957901299,
                        -0.00436221343,
                        -0.999898195,
                        0.013699729
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
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.19589816,
                    -0.720534921,
                    -9.84525967,
                    0.705992997,
                    0.00810814463,
                    0.708171725,
                    0.708209038,
                    -0.011873059,
                    -0.705896318,
                    0.00268460484,
                    0.999896646,
                    -0.014124576
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(24.799715, 21.061726, 24.956404),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.14359963,
                        -0.984554052,
                        17.5648766,
                        0.512138188,
                        0.00810814463,
                        -0.85886395,
                        -0.858779013,
                        -0.011873059,
                        -0.512198389,
                        -0.0143503165,
                        0.999896646,
                        0.000882509165
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m8] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    1.15002656,
                    -0.537842751,
                    4.49865532,
                    0.708171666,
                    0.00810814463,
                    -0.705992997,
                    -0.705896378,
                    -0.011873059,
                    -0.708209157,
                    -0.0141245751,
                    0.999896646,
                    -0.00268460601
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.5973907, 39.385147, 3.3436592),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.72066879,
                        -1.3736999,
                        -14.7168112,
                        -0.85886395,
                        0.00810814463,
                        -0.512138247,
                        -0.512198389,
                        -0.011873059,
                        0.858779132,
                        0.000882509165,
                        0.999896646,
                        0.0143503202
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
            task.spawn(function() -- Line: 306, Name: Emit
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
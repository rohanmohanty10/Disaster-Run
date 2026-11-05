  

 

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
        [v4.m7] = {
            General = {
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    1.55231059,
                    2.74700212,
                    -1.19621944,
                    0.401871473,
                    0.393404871,
                    0.826880932,
                    -0.461806506,
                    0.866834283,
                    -0.187971368,
                    -0.790717483,
                    -0.306318671,
                    0.530032873
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(14.61347, 6.6502104, 13.058204),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -4.51002502,
                        -8.17170525,
                        2.01539683,
                        0.702198803,
                        0.393405288,
                        -0.593421578,
                        -0.0682475269,
                        0.866833627,
                        0.493904531,
                        0.708702505,
                        -0.306319594,
                        0.635538518
                    ),
                    Color = Color3.new(1, 1, 1)
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
                    5.50364161,
                    10.566288,
                    -3.85295439,
                    0.335086256,
                    -0.393405527,
                    0.85612458,
                    0.17507273,
                    -0.866833746,
                    -0.466849864,
                    0.925779045,
                    0.306318998,
                    -0.221589476
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(24.844488, 6.982811, 25.001457),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -2.74442911,
                        -9.02992439,
                        3.43956542,
                        0.747012258,
                        -0.393404484,
                        -0.535915732,
                        -0.495608538,
                        -0.866834164,
                        -0.0545033291,
                        -0.443108231,
                        0.306319058,
                        -0.842510462
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m5] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -5.26342344,
                    -9.78938007,
                    2.0746243,
                    0.920554221,
                    0.388911486,
                    -0.0364407972,
                    -0.353188515,
                    0.86857003,
                    0.347626239,
                    0.166847244,
                    -0.307138294,
                    0.936924875
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(13.555677, 9.972714, 13.555677),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.7297616,
                        0.335742772,
                        -1.5056597,
                        -0.920554221,
                        0.388911486,
                        0.0364407972,
                        0.353188515,
                        0.86857003,
                        -0.347626239,
                        -0.166847244,
                        -0.307138294,
                        -0.936924875
                    ),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
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
                    -4.06921959,
                    -12.4164333,
                    4.8497386,
                    -0.388915151,
                    0.0364543013,
                    0.920552135,
                    -0.868569493,
                    -0.347628981,
                    -0.353187263,
                    0.307135373,
                    -0.936923325,
                    0.166861251
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(3.8382857, 2.8141727, 2.804765),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        3.25477886,
                        4.23847294,
                        -1.04479694,
                        -0.388915151,
                        0.0364543013,
                        0.920552135,
                        -0.868569493,
                        -0.347628981,
                        -0.353187263,
                        0.307135373,
                        -0.936923325,
                        0.166861251
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
                    Scale = Vector3.new(0.25354195, 0.41954407, 0.4212306),
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
                    Color3 = Color3.new(1.96078, 1.96078, 4.70588)
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
                    -3.16678452,
                    -6.97721767,
                    2.46558237,
                    -0.0364513882,
                    -0.388915092,
                    0.920552254,
                    0.347627133,
                    -0.868569672,
                    -0.353188425,
                    0.93692404,
                    0.307134718,
                    0.166858017
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(5.693934, 19.222713, 5.693934),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.875201404,
                        2.04903698,
                        -0.726456702,
                        0.815446854,
                        -0.388914585,
                        -0.428709626,
                        -0.479683459,
                        -0.86856997,
                        -0.12445914,
                        -0.323960304,
                        0.307134718,
                        -0.894828498
                    ),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 1,
                Offset = CFrame.new(
                    -1.98881578,
                    -6.52527285,
                    2.33429575,
                    0.418726325,
                    -0.0501138866,
                    0.906733274,
                    0.869516313,
                    0.310139865,
                    -0.384398252,
                    -0.261950552,
                    0.949372768,
                    0.173437715
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(15.036008, 16.963476, 1.1566993),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.98882222,
                        -6.52528715,
                        2.33430982,
                        -0.418726504,
                        0.050113827,
                        0.906733155,
                        -0.869516075,
                        -0.310140491,
                        -0.384398311,
                        0.261951029,
                        -0.949372709,
                        0.173437864
                    ),
                    Color = Color3.new(1, 0, 0)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Exponential
                }
            }
        },
        [v4.m1] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 1,
                Offset = CFrame.new(
                    3.78337383,
                    6.72564077,
                    -1.34730756,
                    -0.0501146242,
                    -0.919193327,
                    -0.390604883,
                    0.310138553,
                    0.357439548,
                    -0.880937636,
                    0.949369669,
                    -0.165289462,
                    0.26716435
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(10.575094, 12.13005, 0.9331481),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -5.00630808,
                        -10.412075,
                        3.90824652,
                        0.158014059,
                        0.924796402,
                        -0.346097052,
                        -0.520663261,
                        -0.219782278,
                        -0.824988306,
                        -0.839012146,
                        0.31055975,
                        0.446778864
                    ),
                    Color = Color3.new(1, 0, 0)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Exponential
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 229, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), Effects (copy)
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
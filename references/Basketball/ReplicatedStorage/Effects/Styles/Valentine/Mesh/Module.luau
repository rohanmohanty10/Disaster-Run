 
 

return function(p1, u2: userdata?) -- Line: 3
    if p1 then
        if typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        elseif typeof(p1) ~= "CFrame" then
            p1 = nil;
        end;
    end;

    local u3 = p1 or CFrame.new(0, 0, 0);
    local v4 = {
        Main = script.Parent.Main,
        MeshSet5 = script.Parent.MeshSet5,
        Test = script.Parent.Test,
        Hmm = script.Parent.Hmm,
        Floor = script.Parent.Floor,
        Thing4 = script.Parent.Thing4
    };
    local v5 = {
        [v4.Test] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.47027123,
                    -0.325950146,
                    3.80133533,
                    -0.0151836434,
                    -1.37835741e-7,
                    -0.999884546,
                    -6.70552254e-8,
                    0.999999642,
                    1.38767064e-7,
                    0.999884725,
                    -7.07805157e-8,
                    -0.0151839359
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(2.8565097, 10.19, 10.196598),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.311943144,
                        -0.325838268,
                        -6.62495279,
                        -0.0151836434,
                        -1.37835741e-7,
                        -0.999884546,
                        -6.70552254e-8,
                        0.999999642,
                        1.38767064e-7,
                        0.999884725,
                        -7.07805157e-8,
                        -0.0151839359
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.124971546, 0.3387281, 0.32754153),
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
                    Color3 = Color3.new(39.2157, 39.2157, 39.2157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.Thing4] = {
            General = {
                Tween_Duration = 0.25,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.230709016,
                    -0.920570612,
                    -7.8161149,
                    0.0151836434,
                    -0.999884546,
                    -1.37835741e-7,
                    6.70552254e-8,
                    1.38767064e-7,
                    0.999999642,
                    -0.999884725,
                    -0.0151839359,
                    -7.07805157e-8
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(0.001, 22.523172, 22.086535),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.362333447,
                        -0.920571029,
                        0.851745009,
                        0.0151836434,
                        -0.999884546,
                        -1.37835741e-7,
                        6.70552254e-8,
                        1.38767064e-7,
                        0.999999642,
                        -0.999884725,
                        -0.0151839359,
                        -7.07805157e-8
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.Hmm] = {
            General = {
                Tween_Duration = 0.4,
                Transparency = 0.6,
                Offset = CFrame.new(
                    -0.200800896,
                    -0.618555665,
                    -9.78475571,
                    -0.999884605,
                    0.0151798232,
                    0.000339285238,
                    1.09430403e-7,
                    0.022338463,
                    -0.999750257,
                    -0.0151839731,
                    -0.999635518,
                    -0.02233533
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(1.3644344, 0.33037415, 1.3644344),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.276231527,
                        -0.729551136,
                        -4.81802082,
                        0.721300662,
                        0.0151666952,
                        0.692455888,
                        -0.692607045,
                        0.0223693326,
                        0.720967829,
                        -0.00455432199,
                        -0.999634981,
                        0.0266393609
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, -6.043824, 0),
                    Scale = Vector3.new(7.6002274, 9.065736, 7.6002274),
                    VertexColor = Vector3.new(2, 2, 2)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(1.96078, 1.96078, 1.96078)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.Main] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.25889352,
                    0.98450762,
                    3.75461626,
                    -0.997705281,
                    -0.0676228255,
                    -0.00325938687,
                    -0.00482836179,
                    0.0230575111,
                    0.999721944,
                    -0.0675293505,
                    0.99744463,
                    -0.0233313479
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(0.3, 13.861027, 0.3),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.653225899,
                        -0.278551131,
                        -10.7765446,
                        -0.865638077,
                        -0.0676776692,
                        0.496074319,
                        0.495726734,
                        0.023032194,
                        0.868172407,
                        -0.0701820627,
                        0.997441769,
                        0.013612058
                    ),
                    Color = Color3.new(1, 0.580392, 0.298039)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.Floor] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.994114518,
                    2.8740325,
                    -6.09155083,
                    -0.0151836434,
                    -1.37835741e-7,
                    -0.999884546,
                    -6.70552254e-8,
                    0.999999642,
                    1.38767064e-7,
                    0.999884725,
                    -7.07805157e-8,
                    -0.0151839359
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(18.989204, 8.184462, 18.989204),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.994113564,
                        -1.26979637,
                        -6.09155083,
                        0.999884546,
                        -1.37835741e-7,
                        -0.0151836434,
                        -1.38767064e-7,
                        0.999999642,
                        -6.70552254e-8,
                        0.0151839359,
                        -7.07805157e-8,
                        0.999884725
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.02212967, 0.011909286, 0.02212967),
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
        [v4.MeshSet5] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.636489093,
                    -0.0388578512,
                    -3.59855437,
                    -0.00411879085,
                    -0.999991238,
                    1.37835741e-7,
                    -7.26431608e-8,
                    1.38301402e-7,
                    -0.999999642,
                    0.999991536,
                    -0.0041190763,
                    7.07805157e-8
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(2.866208, 10.517776, 10.967907),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.00776295504,
                        -0.555442095,
                        -7.1059866,
                        -0.0123430397,
                        -0.256783247,
                        -0.966389954,
                        -0.0106946044,
                        0.966442108,
                        -0.256660223,
                        0.999866784,
                        0.00716698729,
                        -0.0146752745
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.31406963, 0.47922376, 0.46108034),
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
                    Color3 = Color3.new(1.17647, 1.17647, 1.17647)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 256, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), u2 (copy)
                local v6 = i.Start:Clone();
                v6.Name = i.Name;
                v6.Transparency = v.General.Transparency;

                if v6:FindFirstChildOfClass("Decal") then
                    v6:FindFirstChildOfClass("Decal").Transparency = v.General.Transparency;
                    v6.Transparency = 1;
                end;

                v6.Anchored = true;
                v6.CFrame = u3 * v.General.Offset;
                v6.Parent = u2;
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
 
 

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
        MeshSet5 = script.Parent.MeshSet5,
        Main = script.Parent.Main,
        Model = script.Parent.Model,
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
                    -0.42900148,
                    -3.36555314,
                    6.30399036,
                    0.0312890746,
                    -2.82656401e-7,
                    -0.999509931,
                    -0.423518032,
                    0.905790269,
                    -0.0132574616,
                    0.905347586,
                    0.4237248,
                    0.0283409227
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(3.7382536, 13.335438, 13.344071),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.8559798,
                        2.41400409,
                        -6.05053234,
                        0.0312890746,
                        -2.82656401e-7,
                        -0.999509931,
                        -0.423518032,
                        0.905790269,
                        -0.0132574616,
                        0.905347586,
                        0.4237248,
                        0.0283409227
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
                    Scale = Vector3.new(0.16354764, 0.44328624, 0.4286466),
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
                    -0.822203279,
                    2.37092233,
                    -7.79526949,
                    -0.0312890746,
                    -0.999509931,
                    -2.82656401e-7,
                    0.423518032,
                    -0.0132574616,
                    0.905790269,
                    -0.905347586,
                    0.0283409227,
                    0.4237248
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(0.0013086788, 29.475594, 28.904179),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.4672364,
                        -2.43378663,
                        2.47567558,
                        -0.0312890746,
                        -0.999509931,
                        -2.82656401e-7,
                        0.423518032,
                        -0.0132574616,
                        0.905790269,
                        -0.905347586,
                        0.0283409227,
                        0.4237248
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
                    -0.902811587,
                    3.82016611,
                    -9.96052265,
                    -0.999509931,
                    -0.0312813632,
                    -0.000698678661,
                    -0.0132574476,
                    0.44364658,
                    -0.896104038,
                    0.0283408314,
                    -0.895656526,
                    -0.443842649
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(1.7856063, 0.43235362, 1.7856063),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.699424505,
                        0.935470641,
                        -4.13676071,
                        0.720309913,
                        -0.0312944539,
                        0.692945719,
                        -0.611229241,
                        0.443674058,
                        0.65540266,
                        -0.327951044,
                        -0.895642459,
                        0.30045411
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
                    Offset = Vector3.new(0, -7.9094243, 0),
                    Scale = Vector3.new(9.946256, 11.864136, 9.946256),
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
                    -0.15551497,
                    -1.78083229,
                    6.96370602,
                    -0.999765038,
                    -0.0212067589,
                    -0.00434009172,
                    0.00456806459,
                    -0.402632207,
                    0.915349722,
                    -0.0211595986,
                    0.915116549,
                    0.402633697
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(0.39260364, 18.139631, 0.39260364),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.55455494,
                        4.76092052,
                        -10.9214525,
                        -0.86796385,
                        -0.021261692,
                        0.4961707,
                        0.461688757,
                        -0.402655095,
                        0.790386677,
                        0.182979882,
                        0.91510576,
                        0.35930571
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
                    -1.71533346,
                    5.89405441,
                    -3.60696363,
                    0.0312890746,
                    -2.82656401e-7,
                    -0.999509931,
                    -0.423518032,
                    0.905790269,
                    -0.0132574616,
                    0.905347586,
                    0.4237248,
                    0.0283409227
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(24.850763, 10.71083, 24.850763),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.71533191,
                        0.98200655,
                        -5.9047966,
                        0.999509931,
                        -2.82656401e-7,
                        0.0312890746,
                        0.0132574616,
                        0.905790269,
                        -0.423518032,
                        -0.0283409227,
                        0.4237248,
                        0.905347586
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
                    Scale = Vector3.new(0.028960621, 0.015585428, 0.028960621),
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
                Tween_Duration = 0.7,
                Transparency = 0,
                Offset = CFrame.new(
                    -1.09623969,
                    1.06943786,
                    -2.28994036,
                    0.0423469543,
                    -0.999102533,
                    2.82656401e-7,
                    -0.423345387,
                    -0.0179429613,
                    -0.905790269,
                    0.904978514,
                    0.0383570381,
                    -0.4237248
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(3.7509456, 13.764387, 14.353464),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.870909035,
                        7.60461664,
                        -17.8555603,
                        0.0341257751,
                        -0.256172985,
                        -0.966027796,
                        -0.43314144,
                        0.867305279,
                        -0.245293915,
                        0.900680006,
                        0.426797032,
                        -0.0813618526
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
                    Scale = Vector3.new(0.41101623, 0.6271498, 0.603406),
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
        },
        [v4.Model] = {
            General = {
                Tween_Duration = 0.9,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -1.17255104,
                    3.33664298,
                    -5.22346783,
                    -0.999509931,
                    -0.0312890746,
                    2.82656401e-7,
                    -0.0132574616,
                    0.423518032,
                    -0.905790269,
                    0.0283409227,
                    -0.905347586,
                    -0.4237248
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(18.909573, 22.103569, 19.28187),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.5058229,
                        5.36871338,
                        -12.3837013,
                        0.641363084,
                        -0.0312890746,
                        0.766598582,
                        -0.686211109,
                        0.423518032,
                        0.591393232,
                        -0.343171895,
                        -0.905347586,
                        0.250157833
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
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
            task.spawn(function() -- Line: 279, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), u2 (copy)
                local v6 = i.Start:Clone();
                v6.Name = i.Name;
                v6.Transparency = v.General.Transparency;

                if v6:FindFirstChildOfClass("Decal") then
                    v6:FindFirstChildOfClass("Decal").Transparency = v.General.Transparency;
                    v6.Transparency = 1;
                end;

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
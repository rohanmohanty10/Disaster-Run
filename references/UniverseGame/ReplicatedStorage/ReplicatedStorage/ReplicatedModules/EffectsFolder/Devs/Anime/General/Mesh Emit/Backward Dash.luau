  

 

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
        m5 = script.m5
    };
    local v5 = {
        [v4.m1] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.835876882,
                    -1.88062739,
                    -12.4285612,
                    -0.0126580894,
                    0.362653494,
                    -0.931837082,
                    -0.0136431092,
                    -0.931883812,
                    -0.362487406,
                    -0.999826849,
                    0.00812472031,
                    0.0167436507
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.0963225, 3.7736075, 3.760992),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.414292067,
                        -1.53273821,
                        8.65301418,
                        -0.0126580894,
                        0.362653494,
                        -0.931837082,
                        -0.0136431092,
                        -0.931883812,
                        -0.362487406,
                        -0.999826849,
                        0.00812472031,
                        0.0167436507
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
                    Scale = Vector3.new(0.46875504, 0.5625789, 0.5648406),
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
        [v4.m2] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    0.423250616,
                    -1.70110548,
                    -10.364768,
                    -0.362653583,
                    -0.0126580894,
                    -0.931837201,
                    0.931883931,
                    -0.0136431092,
                    -0.362487495,
                    -0.00812472031,
                    -0.999826849,
                    0.0167436525
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(4.6375403, 15.656333, 4.6375403),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.705155015,
                        -1.39740181,
                        11.910924,
                        -0.625668108,
                        -0.0126580894,
                        0.779986084,
                        -0.779865742,
                        -0.0136431092,
                        -0.625791252,
                        0.0185627993,
                        -0.999826849,
                        -0.0013356139
                    ),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.315385342,
                    0.213776171,
                    -7.1228714,
                    -0.931837082,
                    0.0126580894,
                    -0.362653434,
                    -0.362487406,
                    0.0136431092,
                    0.931883693,
                    0.0167436507,
                    0.999826849,
                    -0.00812471937
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(17.460226, 12.845237, 17.460226),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.125377327,
                        0.418726236,
                        7.88903379,
                        0.931837082,
                        0.0126580894,
                        0.362653434,
                        0.362487406,
                        0.0136431092,
                        -0.931883693,
                        -0.0167436507,
                        0.999826849,
                        0.00812471937
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
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.200646937,
                    -1.70686722,
                    12.6805792,
                    -0.705992877,
                    -0.00810813904,
                    -0.708171844,
                    0.708208263,
                    -0.0118730552,
                    -0.705895662,
                    -0.00268459483,
                    -0.999896646,
                    0.0141245751
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(20.235096, 17.18512, 20.362944),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.572613597,
                        -1.92228961,
                        -9.68446541,
                        -0.512138247,
                        -0.00810813904,
                        0.85886389,
                        -0.858778238,
                        -0.0118730552,
                        -0.512197733,
                        0.0143503137,
                        -0.999896646,
                        -0.000882518769
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
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.459606171,
                    -1.74538946,
                    5.22893953,
                    -0.0415917523,
                    0.00810815208,
                    -0.999101818,
                    -0.999060273,
                    0.0118730702,
                    0.0416863747,
                    0.0122004068,
                    0.999896646,
                    0.00760670984
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(11.902241, 19.65546, 10.635522),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.38932371,
                        -1.97675884,
                        -6.10238552,
                        -0.957969427,
                        0.00810816698,
                        0.28675881,
                        0.286835194,
                        0.0118730878,
                        0.957900405,
                        0.00436222227,
                        0.999898434,
                        -0.0136997253
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
            task.spawn(function() -- Line: 183, Name: Emit
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
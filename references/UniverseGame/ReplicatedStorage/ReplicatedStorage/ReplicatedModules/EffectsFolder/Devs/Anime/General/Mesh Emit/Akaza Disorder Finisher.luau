  

 

return function(p1) -- Line: 3
    if p1 then
        if typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        elseif typeof(p1) ~= "CFrame" then
            p1 = nil;
        end;
    end;

    local Effects = workspace.Effects;
    local u2 = p1 or CFrame.new(0, 0, 0);
    local v3 = {
        m3 = script.m3,
        m2 = script.m2,
        m1 = script.m1,
        m4 = script.m4,
        m5 = script.m5
    };
    local v4 = {
        [v3.m2] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.00823111646,
                    -0.00361677213,
                    1.36094666,
                    -0.984799266,
                    -1.94931744e-12,
                    0.173699468,
                    0.173699468,
                    -5.79711951e-13,
                    0.984799266,
                    1.81898984e-12,
                    1,
                    -9.09494919e-13
                )
            },
            Features = {
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(10.534169, 19.40585, 10.534169),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.00818534475,
                        -0.00362629769,
                        -5.06126785,
                        -0.984799266,
                        -1.94931744e-12,
                        0.173699468,
                        0.173699468,
                        -5.79711951e-13,
                        0.984799266,
                        1.81898984e-12,
                        1,
                        -9.09494919e-13
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m4] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.00818534475,
                    -0.00362629769,
                    1.93873024,
                    -0.984799266,
                    -2.92397617e-12,
                    0.173699468,
                    0.173699468,
                    -8.69568089e-13,
                    0.984799266,
                    2.72848454e-12,
                    1,
                    -1.36424227e-12
                )
            },
            Features = {
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(13.894795, 1.2502948, 13.894795),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.00823111646,
                        -0.00361677213,
                        -1.63905334,
                        -0.984799266,
                        -2.92397617e-12,
                        0.173699468,
                        0.173699468,
                        -8.69568089e-13,
                        0.984799266,
                        2.72848454e-12,
                        1,
                        -1.36424227e-12
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m3] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = -5,
                Offset = CFrame.new(
                    0.000135105409,
                    -0.0000465872654,
                    13.2032213,
                    3.9891429e-6,
                    0,
                    1.00000119,
                    -6.33974787e-6,
                    -1.00000119,
                    0,
                    1,
                    -6.33974651e-6,
                    -3.98914881e-6
                )
            },
            Features = {
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(1.9994149, 13.803838, 13.803838),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        1.02200636e-6,
                        3.03936815e-7,
                        -2.69677353,
                        6.61892318e-6,
                        3.21865082e-6,
                        1.00000143,
                        -4.25564531e-6,
                        -1.00000143,
                        3.21865082e-6,
                        1,
                        -4.25566668e-6,
                        -6.61891181e-6
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.0864391, 0.4368115, 0.42531997),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(1.96078, 3.92157, 10.0196)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m5] = {
            General = {
                Tween_Duration = 0.8,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.00823103357,
                    -0.00361630274,
                    3.11094666,
                    0.984799743,
                    1.94931744e-12,
                    0.173699528,
                    -0.173699528,
                    5.79711951e-13,
                    0.984799743,
                    -1.8189907e-12,
                    -1,
                    -9.09495352e-13
                )
            },
            Features = {
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(7.6486015, 25, 7.6486015),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.00818653312,
                        -0.00362754101,
                        -9.06126785,
                        0.984799743,
                        1.94931744e-12,
                        0.173699528,
                        -0.173699528,
                        5.79711951e-13,
                        0.984799743,
                        -1.8189907e-12,
                        -1,
                        -9.09495352e-13
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m1] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.00818534475,
                    -0.00362629769,
                    1.93873024,
                    -0.984799266,
                    -2.92397617e-12,
                    0.173699468,
                    0.173699468,
                    -8.69568089e-13,
                    0.984799266,
                    2.72848454e-12,
                    1,
                    -1.36424227e-12
                )
            },
            Features = {
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(8.939026, 0.70585024, 8.939026),
                    Transparency = 0,
                    CFrame = u2 * CFrame.new(
                        -0.00822622702,
                        -0.00362199242,
                        -1.91127396,
                        -0.984799743,
                        -1.77296863e-6,
                        0.173696846,
                        0.173696846,
                        2.81682401e-6,
                        0.984799743,
                        -2.23528605e-6,
                        1,
                        -2.4660485e-6
                    ),
                    Color = Color3.new(0.396078, 0.478431, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        }
    };

    for i, v in pairs(v4) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 208, Name: Emit
                -- upvalues: i (copy), v (copy), u2 (copy), Effects (copy)
                local v5 = i.Start:Clone();
                v5.Name = i.Name;
                v5.Transparency = v.General.Transparency;

                if v5:FindFirstChildOfClass("Decal") then
                    v5:FindFirstChildOfClass("Decal").Transparency = v.General.Transparency;
                    v5.Transparency = 1;
                end;

                v5.Anchored = true;
                v5.CanCollide = false;
                v5.CanQuery = false;
                v5.CanTouch = false;
                v5.Locked = true;
                v5.CFrame = u2 * v.General.Offset;
                v5.Parent = Effects;

                if v.Features and v.Features.Random_Angles then
                    local Property = v.BasePart.Property;
                    Property.CFrame = Property.CFrame * CFrame.Angles(math.random(unpack(v.Features.Random_Angles.X)), math.random(unpack(v.Features.Random_Angles.Y)), math.random(unpack(v.Features.Random_Angles.Z)));
                end;

                game:GetService("TweenService"):Create(v5, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();

                if v.Decal then
                    game:GetService("TweenService"):Create(v5:FindFirstChildOfClass("Decal"), TweenInfo.new(v.General.Tween_Duration, v.Decal.Tween.Easing_Style, v.Decal.Tween.Easing_Direction), v.Decal.Property):Play();
                end;

                if v.Mesh then
                    game:GetService("TweenService"):Create(v5:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v.General.Tween_Duration, v.Mesh.Tween.Easing_Style, v.Mesh.Tween.Easing_Direction), v.Mesh.Property):Play();
                end;

                task.delay(v.General.Tween_Duration, v5.Destroy, v5);
            end);
        end;
    end;
end;
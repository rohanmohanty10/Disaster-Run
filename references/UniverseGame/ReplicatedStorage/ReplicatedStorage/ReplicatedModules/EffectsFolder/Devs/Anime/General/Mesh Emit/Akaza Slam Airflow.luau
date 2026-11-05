  

 

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
        m4 = script.m4
    };
    local v4 = {
        [v3.m4] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.00183300802,
                    -5.43116379,
                    -0.00485198153,
                    3.23366839e-6,
                    -1,
                    -3.99718601e-6,
                    1,
                    3.23365612e-6,
                    2.96163898e-6,
                    -2.9616258e-6,
                    -3.99719511e-6,
                    1
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
                    Size = Vector3.new(2.5902529, 23.041363, 23.041363),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.00123445911,
                        1.06848526,
                        -0.00516054034,
                        9.04668184e-7,
                        -1,
                        -1.11013242e-6,
                        1,
                        9.0466699e-7,
                        8.27018539e-7,
                        -8.27017402e-7,
                        -1.11013333e-6,
                        1
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
                    Scale = Vector3.new(0.11198232, 0.7291257, 0.70994407),
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
                    Color3 = Color3.new(1, 1.4902, 10.0196)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m3] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0.7,
                Offset = CFrame.new(
                    0.00116731995,
                    -12.0124569,
                    0.00331510208,
                    3.23366839e-6,
                    -1,
                    -3.99718601e-6,
                    1,
                    3.23365612e-6,
                    2.96163898e-6,
                    -2.9616258e-6,
                    -3.99719511e-6,
                    1
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
                    Size = Vector3.new(8.265883, 26.43559, 26.43559),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.00117226387,
                        -6.24590302,
                        0.00330619002,
                        3.23366839e-6,
                        -1,
                        -3.99718601e-6,
                        1,
                        3.23365612e-6,
                        2.96163898e-6,
                        -2.9616258e-6,
                        -3.99719511e-6,
                        1
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
                    Scale = Vector3.new(0.3573523, 0.8365333, 0.8145261),
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
                    Color3 = Color3.new(100.216, 100.216, 100.216)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.0000463241086,
                    -13.9998283,
                    0.0000401583893,
                    3.17266472e-6,
                    -1,
                    -3.92640595e-6,
                    1,
                    3.17265335e-6,
                    2.86850445e-6,
                    -2.86849195e-6,
                    -3.92641505e-6,
                    1
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
                    Size = Vector3.new(11.475632, 34.120132, 34.120132),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.0000163923032,
                        -5.16672134,
                        0.0000224500927,
                        3.17266472e-6,
                        -1,
                        -3.92640595e-6,
                        1,
                        3.17265335e-6,
                        2.86850445e-6,
                        -2.86849195e-6,
                        -3.92641505e-6,
                        1
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.In,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.49611676, 1.0797046, 1.0513002),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(100.216, 100.216, 100.216)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m1] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    0.0000145879867,
                    5.49982452,
                    7.11197026e-6,
                    9.04668184e-7,
                    -1,
                    -1.11013242e-6,
                    1,
                    9.0466699e-7,
                    8.27018539e-7,
                    -8.27017402e-7,
                    -1.11013333e-6,
                    1
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
                    Size = Vector3.new(3.4756308, 18.882565, 18.882565),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.0000503561459,
                        -13.1665115,
                        0.0000759149698,
                        9.04668184e-7,
                        -1,
                        -1.11013242e-6,
                        1,
                        9.0466699e-7,
                        8.27018539e-7,
                        -8.27017402e-7,
                        -1.11013333e-6,
                        1
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
                    Scale = Vector3.new(0.15025917, 0.5975238, 0.58180434),
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
                    Color3 = Color3.new(1, 1.4902, 10.0196)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        }
    };

    for i, v in pairs(v4) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 240, Name: Emit
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
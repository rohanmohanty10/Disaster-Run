  

 

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
                Tween_Duration = 0.3,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -7.11267148e-7,
                    -9.86694317e-8,
                    -0.540934563,
                    -0.984798074,
                    -1.32968853e-6,
                    0.173703372,
                    0.173703372,
                    2.1143901e-6,
                    0.984798133,
                    -1.67675125e-6,
                    1,
                    -1.85127601e-6
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
                    Size = Vector3.new(4.4661846, 0.4018805, 4.4661846),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -2.22338417e-6,
                        -1.79900564e-6,
                        -1.69093513,
                        -0.984798074,
                        -1.32968853e-6,
                        0.173703372,
                        0.173703372,
                        2.1143901e-6,
                        0.984798133,
                        -1.67675125e-6,
                        1,
                        -1.85127601e-6
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
                Tween_Duration = 0.05,
                Transparency = -2,
                Offset = CFrame.new(
                    0.00291200285,
                    0.00162881403,
                    1.05818748,
                    2.71937324e-6,
                    2.48854599e-6,
                    1,
                    2.47530897e-6,
                    -1,
                    2.48853917e-6,
                    1,
                    2.47530193e-6,
                    -2.71937938e-6
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
                    Size = Vector3.new(1.7616819, 3.8778174, 3.8778174),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.00289745932,
                        0.00161605421,
                        -1.29895401,
                        2.6297771e-6,
                        3.20381469e-6,
                        1,
                        2.08410052e-6,
                        -1,
                        3.20380923e-6,
                        1,
                        2.08409233e-6,
                        -2.62978392e-6
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
                    Scale = Vector3.new(0.07616137, 0.122710444, 0.11948221),
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
        [v3.m2] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0.8,
                Offset = CFrame.new(
                    0.00220028963,
                    0.00136334531,
                    2.30145836,
                    1.31488446e-6,
                    1.57954014e-6,
                    1,
                    1.06391167e-6,
                    -1,
                    1.57953878e-6,
                    1,
                    1.06390962e-6,
                    -1.31488582e-6
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
                    Size = Vector3.new(6.5873246, 3.3866313, 3.3866313),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.00219601626,
                        0.00135988754,
                        -0.948541641,
                        1.31488446e-6,
                        1.57954014e-6,
                        1,
                        1.06391167e-6,
                        -1,
                        1.57953878e-6,
                        1,
                        1.06390962e-6,
                        -1.31488582e-6
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.2847845, 0.10716725, 0.10434792),
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
                    Color3 = Color3.new(10.0196, 10.0196, 10.0196)
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
                    -7.11267148e-7,
                    -9.86694317e-8,
                    -0.540934563,
                    -0.984798074,
                    -1.32968853e-6,
                    0.173703372,
                    0.173703372,
                    2.1143901e-6,
                    0.984798133,
                    -1.67675125e-6,
                    1,
                    -1.85127601e-6
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
                    Size = Vector3.new(2.873258, 0.90188044, 2.873258),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -1.89466334e-6,
                        -1.29460909e-6,
                        -1.44093513,
                        -0.984798074,
                        -1.32968853e-6,
                        0.173703372,
                        0.173703372,
                        2.1143901e-6,
                        0.984798133,
                        -1.67675125e-6,
                        1,
                        -1.85127601e-6
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
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
            task.spawn(function() -- Line: 199, Name: Emit
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
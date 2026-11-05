  

 

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
        m4 = script.m4,
        n1 = script.n1,
        m3 = script.m3,
        n = script.n
    };
    local v4 = {
        [v3.n1] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0,
                Offset = CFrame.new(
                    0.241862535,
                    -22.0275879,
                    -3.53466868,
                    -0.007660117,
                    0.00798553228,
                    0.999938726,
                    0.999938488,
                    0.00811685994,
                    0.00759528205,
                    -0.00805571117,
                    0.999935269,
                    -0.0080473423
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(30.257267, 7.2618294, 8.194427),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        1.13525951,
                        12.0941095,
                        -1.21198273,
                        -0.00765938684,
                        -0.949031591,
                        -0.315093696,
                        0.999935508,
                        -0.00980733708,
                        0.00523189455,
                        -0.00805539638,
                        -0.315034986,
                        0.949049234
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
                    Scale = Vector3.new(1.9986753, 1.0826119, 1.230996),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(0.784314, 1.17647, 3.92157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.n] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0,
                Offset = CFrame.new(
                    2.97791624,
                    3.15696836,
                    -1.88894808,
                    -0.00765985437,
                    0.387507617,
                    -0.921836197,
                    0.999935627,
                    -0.00445917714,
                    -0.0101833101,
                    -0.00805655867,
                    -0.921859443,
                    -0.387450755
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(13.690564, 7.3382215, 7.3649297),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        1.54730678,
                        9.1992197,
                        -1.87096047,
                        -0.00765985809,
                        -0.387507379,
                        0.921835542,
                        0.9999367,
                        0.00445918832,
                        0.0101833232,
                        -0.00805654377,
                        0.921858191,
                        0.387450248
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
                    Scale = Vector3.new(0.9043446, 1.0940006, 1.106386),
                    VertexColor = Vector3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            },
            Decal = {
                Property = {
                    Transparency = 1,
                    Color3 = Color3.new(0.784314, 1.17647, 3.92157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.m4] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.785253346,
                    1.30342162,
                    -0.649208784,
                    -0.94790566,
                    -0.0355084389,
                    -0.316564798,
                    -0.0271152183,
                    0.999154806,
                    -0.0308806412,
                    0.317394495,
                    -0.0206882097,
                    -0.948071718
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(54.28519, 8.493819, 52.97771),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.12203557,
                        3.71658969,
                        -0.0920807719,
                        0.947905898,
                        -0.0355084166,
                        0.31656459,
                        0.0271152481,
                        0.999154627,
                        0.0308805946,
                        -0.317394137,
                        -0.020688232,
                        0.948070645
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.m3] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.0491861403,
                    1.30083907,
                    -0.884735465,
                    -0.553269207,
                    -0.0328070559,
                    -0.832356215,
                    0.00247228611,
                    0.999155283,
                    -0.0410247147,
                    0.832998872,
                    -0.0247555301,
                    -0.552720606
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(65.851746, 5.9297624, 65.851746),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.896727741,
                        3.52649021,
                        -1.01745641,
                        -0.553269207,
                        -0.0328070559,
                        -0.832356215,
                        0.00247228611,
                        0.999155283,
                        -0.0410247147,
                        0.832998872,
                        -0.0247555301,
                        -0.552720606
                    ),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        }
    };

    for i, v in pairs(v4) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 173, Name: Emit
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
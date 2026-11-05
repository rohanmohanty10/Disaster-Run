  

 

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
        [v4.m5] = {
            General = {
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.152355909,
                    -17.7701149,
                    -4.21536922,
                    -0.966444969,
                    0.0206393395,
                    0.25602898,
                    -0.0235084984,
                    -0.999688625,
                    -0.00815829262,
                    0.255779713,
                    -0.0139036067,
                    0.966630459
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(52.402325, 16.416605, 50.401676),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.277710736,
                        -13.4527903,
                        -0.187115982,
                        0.486509413,
                        0.0206371807,
                        0.873427451,
                        -0.00211007148,
                        -0.999688506,
                        0.0247934982,
                        0.873668611,
                        -0.0139054693,
                        -0.486313522
                    ),
                    Color = Color3.new(1, 1, 1)
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
                    -4.66091347,
                    -16.9435482,
                    -4.43524885,
                    0.389400125,
                    -0.0206383206,
                    0.920837641,
                    0.0208439138,
                    0.999690592,
                    0.0135912243,
                    -0.920832932,
                    0.0139014348,
                    0.389709771
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(53.98695, 45.849655, 54.32805),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -3.45264053,
                        -6.94476986,
                        -5.01162052,
                        0.796328783,
                        -0.0206370763,
                        -0.604512155,
                        0.00802709535,
                        0.999690533,
                        -0.0235536695,
                        0.604811072,
                        0.0139039848,
                        0.79624784
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -2.83068514,
                    20.4705067,
                    -5.06616402,
                    -0.0157564636,
                    0.012658447,
                    0.999793291,
                    0.999778748,
                    -0.0136430673,
                    0.015927881,
                    0.0138419867,
                    0.999824047,
                    -0.0124398172
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(8.307234, 6.090738, 6.0703764),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -2.44632292,
                        -20.9162369,
                        -5.63579941,
                        -0.0157564636,
                        0.012658447,
                        0.999793291,
                        0.999778748,
                        -0.0136430673,
                        0.015927881,
                        0.0138419867,
                        0.999824047,
                        -0.0124398172
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
                    Scale = Vector3.new(0.548743, 0.90802264, 0.91167307),
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
        [v4.m2] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    -4.75130939,
                    14.7924519,
                    -4.6130209,
                    -0.012658447,
                    -0.0157564636,
                    0.999793291,
                    0.0136430673,
                    0.999778748,
                    0.0159278773,
                    -0.999824047,
                    0.0138419867,
                    -0.0124398172
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.733899, 26.109638, 7.733899),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -4.16552925,
                        -22.3543129,
                        -5.12696743,
                        0.872176051,
                        -0.0157564636,
                        -0.488934398,
                        0.00697243307,
                        0.999778748,
                        -0.0197791979,
                        0.48913911,
                        0.0138419867,
                        0.872092962
                    ),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m1] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0,
                Offset = CFrame.new(
                    -2.3100214,
                    -13.1229143,
                    -5.53539753,
                    -0.01575833,
                    0.0126599669,
                    0.999791622,
                    0.999777913,
                    -0.0136430701,
                    0.0159289055,
                    0.0138420863,
                    0.999822378,
                    -0.0124407411
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(15.556946, 7.457985, 7.433052),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -2.71176147,
                        -8.4451313,
                        -5.46650887,
                        -0.0157611538,
                        0.993852019,
                        -0.109550655,
                        0.999777913,
                        0.0171796344,
                        0.0120339943,
                        0.0138422549,
                        -0.109335423,
                        -0.993903935
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
                    Scale = Vector3.new(1.0276303, 1.1118553, 1.1163251),
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
                    Color3 = Color3.new(3.92157, 3.92157, 3.92157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 206, Name: Emit
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
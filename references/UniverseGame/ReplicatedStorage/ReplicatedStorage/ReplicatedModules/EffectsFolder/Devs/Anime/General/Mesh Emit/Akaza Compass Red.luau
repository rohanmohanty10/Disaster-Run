  

 

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
        m4 = script.m4,
        n1 = script.n1,
        m3 = script.m3,
        n = script.n
    };
    local v5 = {
        [v4.n1] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0,
                Offset = CFrame.new(
                    -2.73665094,
                    -16.9882965,
                    0.0777398348,
                    -0.00766001316,
                    0.999938786,
                    -0.00798523985,
                    0.999938309,
                    0.00759518519,
                    -0.00811734982,
                    -0.00805620383,
                    -0.00804692507,
                    -0.99993521
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(23.335442, 5.6005716, 6.3198223),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.934837699,
                        9.31284428,
                        -1.02465034,
                        -0.00765972026,
                        -0.315094531,
                        0.949029446,
                        0.99993825,
                        0.00523316721,
                        0.00980811473,
                        -0.00805691257,
                        0.949045897,
                        0.315035015
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
                    Scale = Vector3.new(1.5414469, 0.83494735, 0.94938624),
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
                    Color3 = Color3.new(2.7451, 0.784314, 0.784314)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.n] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.747489333,
                    2.71253729,
                    -1.11985493,
                    -0.00766092166,
                    -0.921835601,
                    -0.387505412,
                    0.99993819,
                    -0.0101841846,
                    0.00445850659,
                    -0.00805643573,
                    -0.387447327,
                    0.921856642
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(15.712031, 8.42174, 8.452392),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.724190116,
                        9.67191792,
                        0.412818134,
                        -0.00766089698,
                        0.921835482,
                        0.387505651,
                        0.99993819,
                        0.0101841632,
                        -0.00445851404,
                        -0.0080564376,
                        0.387447566,
                        -0.921856582
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
                    Scale = Vector3.new(1.0378748, 1.2555342, 1.2697483),
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
                    Color3 = Color3.new(2.7451, 0.784314, 0.784314)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m4] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.647372961,
                    1.42436635,
                    0.761636198,
                    0.317329109,
                    -0.0202944502,
                    -0.948098361,
                    -0.0123404749,
                    0.999598026,
                    -0.0255271867,
                    0.948235154,
                    0.0198005047,
                    0.316951126
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(53.93018, 8.4382715, 52.63125),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.0928909853,
                        3.8108952,
                        0.0651853606,
                        -0.31732887,
                        -0.0202944614,
                        0.948098421,
                        0.0123404991,
                        0.999598026,
                        0.0255271997,
                        -0.948235273,
                        0.0198005252,
                        -0.316950887
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
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.881320477,
                    1.41040027,
                    0.0304890871,
                    0.832967997,
                    -0.0243616514,
                    -0.552784622,
                    0.0108378725,
                    0.999556959,
                    -0.0277201235,
                    0.553215027,
                    0.0170989651,
                    0.832862973
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(65.4211, 5.890984, 65.4211),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.01224089,
                        3.60651708,
                        -0.943893969,
                        0.832967997,
                        -0.0243616514,
                        -0.552784622,
                        0.0108378725,
                        0.999556959,
                        -0.0277201235,
                        0.553215027,
                        0.0170989651,
                        0.832862973
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

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 173, Name: Emit
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
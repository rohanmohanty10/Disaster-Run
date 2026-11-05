  

 

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
        m4 = script.m4
    };
    local v5 = {
        [v4.m1] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    -4.75136185,
                    14.7924185,
                    -4.61299515,
                    -0.0126592219,
                    -0.0157574266,
                    0.999795914,
                    0.0136430506,
                    0.999780059,
                    0.0159299262,
                    -0.999826908,
                    0.0138419233,
                    -0.0124415457
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(7.733899, 26.109638, 7.733899),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -4.16555119,
                        -22.3542633,
                        -5.12693834,
                        0.872177482,
                        -0.0157552902,
                        -0.488936126,
                        0.00697165122,
                        0.999780059,
                        -0.019780321,
                        0.489140093,
                        0.0138432551,
                        0.872095525
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
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -2.83074427,
                    20.4704781,
                    -5.06614923,
                    -0.0157574248,
                    0.0126592219,
                    0.999795914,
                    0.999780059,
                    -0.0136431884,
                    0.0159299262,
                    0.0138420612,
                    0.999826908,
                    -0.0124415457
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(8.307234, 6.090738, 6.0703764),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -2.44634199,
                        -20.9161663,
                        -5.63578415,
                        -0.0157574248,
                        0.0126592219,
                        0.999795914,
                        0.999780059,
                        -0.0136431884,
                        0.0159299262,
                        0.0138420612,
                        0.999826908,
                        -0.0124415457
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
                    Color3 = Color3.new(0.588235, 1.11765, 49.0196)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.85,
                Offset = CFrame.new(
                    -4.66092014,
                    -16.9435291,
                    -4.43522787,
                    0.389399976,
                    -0.0206389427,
                    0.920837641,
                    0.0208434798,
                    0.999690473,
                    0.0135920849,
                    -0.920833111,
                    0.0139007065,
                    0.389709532
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(30.346947, 45.849655, 30.208046),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -3.45266676,
                        -6.94477463,
                        -5.01158714,
                        0.796328783,
                        -0.0206368752,
                        -0.604512095,
                        0.00802637544,
                        0.999690473,
                        -0.0235542934,
                        0.604810953,
                        0.0139049171,
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
        [v4.m4] = {
            General = {
                Tween_Duration = 0.85,
                Transparency = 0.75,
                Offset = CFrame.new(
                    -0.152346134,
                    -17.7700214,
                    -4.21538305,
                    -0.966449261,
                    0.0206367131,
                    0.256027639,
                    -0.0235076547,
                    -0.999690354,
                    -0.00815782696,
                    0.255780041,
                    -0.0139027331,
                    0.966635168
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(52.402325, 16.416605, 50.401676),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.277718425,
                        -13.4527168,
                        -0.187138155,
                        0.486511797,
                        0.0206373706,
                        0.873430252,
                        -0.00211047358,
                        -0.999690294,
                        0.0247961991,
                        0.873671472,
                        -0.0139069939,
                        -0.486317664
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
            task.spawn(function() -- Line: 152, Name: Emit
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
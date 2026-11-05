  

 

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
        Mesh5 = script.Mesh5,
        Mesh2 = script.Mesh2,
        Mesh4 = script.Mesh4,
        Mesh1 = script.Mesh1
    };
    local v4 = {
        [v3.Mesh1] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -2.29829645,
                    2.50888777,
                    1.66763842,
                    0.795974791,
                    0.0470858738,
                    0.603495836,
                    0.0331234336,
                    -0.998864412,
                    0.0342454575,
                    0.604422987,
                    -0.00726866862,
                    -0.796630502
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(23.235218, 2.7958956, 25.911049),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -2.27590156,
                        2.03145409,
                        1.6643101,
                        -0.795974791,
                        0.0470858738,
                        -0.603495836,
                        -0.0331234336,
                        -0.998864412,
                        -0.0342454575,
                        -0.604422987,
                        -0.00726866862,
                        0.796630502
                    ),
                    Color = Color3.new(0.929412, 0.917647, 0.917647)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.Mesh2] = {
            General = {
                Tween_Duration = 0.4,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -2.11635375,
                    -1.35159242,
                    1.63959301,
                    0.795974791,
                    0.0470858738,
                    0.603495836,
                    0.0331234336,
                    -0.998864412,
                    0.0342454575,
                    0.604422987,
                    -0.00726866862,
                    -0.796630502
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(49.579956, 5.9659595, 55.289722),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -2.06857777,
                        -2.37035751,
                        1.6325258,
                        -0.795974791,
                        0.0470858738,
                        -0.603495836,
                        -0.0331234336,
                        -0.998864412,
                        -0.0342454575,
                        -0.604422987,
                        -0.00726866862,
                        0.796630502
                    ),
                    Color = Color3.new(0.929412, 0.917647, 0.917647)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.Mesh4] = {
            General = {
                Tween_Duration = 0.9,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.767037988,
                    1.38542366,
                    1.38133717,
                    -0.605315328,
                    -0.0548200645,
                    0.794095874,
                    0.0500859842,
                    -0.998271823,
                    -0.0307362396,
                    0.7944085,
                    0.0211679544,
                    0.607014954
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(63.437813, 7.948464, 59.509205),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.144987762,
                        -2.63377309,
                        0.0551771075,
                        0.463876367,
                        -0.054818619,
                        0.884202302,
                        -0.0066895769,
                        -0.998271942,
                        -0.0583811626,
                        0.885874689,
                        0.021166699,
                        -0.463441461
                    ),
                    Color = Color3.new(0.819608, 0.819608, 0.819608)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v3.Mesh5] = {
            General = {
                Tween_Duration = 0.9,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -1.61741447,
                    -1.31508493,
                    -0.265263677,
                    -0.605315328,
                    0.0548200645,
                    -0.794095874,
                    0.0500859842,
                    0.998271823,
                    0.0307362396,
                    0.7944085,
                    -0.0211679544,
                    -0.607014954
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(63.437813, 23.436768, 59.509205),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.000855278457,
                        0.000474972156,
                        0.000139555923,
                        -0.676918447,
                        0.054818932,
                        0.734013855,
                        0.0215723682,
                        0.998271942,
                        -0.0546603687,
                        -0.735741854,
                        -0.0211661942,
                        -0.676931262
                    ),
                    Color = Color3.new(0.819608, 0.819608, 0.819608)
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
            task.spawn(function() -- Line: 135, Name: Emit
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
                task.delay(v.General.Tween_Duration, v5.Destroy, v5);
            end);
        end;
    end;
end;
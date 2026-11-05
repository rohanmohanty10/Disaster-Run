  

 

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
                Tween_Duration = 0.4,
                Transparency = 0.9,
                Offset = CFrame.new(
                    1.10235763,
                    -1.09132576,
                    -2.78117895,
                    -0.603495359,
                    0.0470856614,
                    0.79597497,
                    -0.0342451744,
                    -0.998864412,
                    0.0331233814,
                    0.796630859,
                    -0.00726849586,
                    0.604422629
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(39.148666, 4.7107615, 43.657127),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        1.14003396,
                        -1.89574683,
                        -2.7872169,
                        0.603495359,
                        0.0470856614,
                        -0.79597497,
                        0.0342451744,
                        -0.998864412,
                        -0.0331233814,
                        -0.796630859,
                        -0.00726849586,
                        -0.604422629
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
                Tween_Duration = 0.6,
                Transparency = 0.9,
                Offset = CFrame.new(
                    1.08511615,
                    -0.726542592,
                    -2.77864075,
                    -0.603495359,
                    0.0470856614,
                    0.79597497,
                    -0.0342451744,
                    -0.998864412,
                    0.0331233814,
                    0.796630859,
                    -0.00726849586,
                    0.604422629
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(83.536514, 10.051954, 93.15681),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        1.16545606,
                        -2.44303703,
                        -2.7915616,
                        0.603495359,
                        0.0470856614,
                        -0.79597497,
                        0.0342451744,
                        -0.998864412,
                        -0.0331233814,
                        -0.796630859,
                        -0.00726849586,
                        -0.604422629
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
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -1.46232128,
                    4.05027962,
                    0.98294282,
                    -0.797108769,
                    -0.0438567214,
                    -0.602235794,
                    0.0512035191,
                    -0.998675108,
                    0.00495520327,
                    -0.601654887,
                    -0.0268863346,
                    0.798299134
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(77.76119, 9.743117, 72.945564),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.0451697558,
                        -0.94084698,
                        -0.00729372771,
                        -0.882683635,
                        -0.0438567251,
                        0.46791026,
                        0.0261304826,
                        -0.998675525,
                        -0.0443120226,
                        0.46923399,
                        -0.0268863291,
                        0.882660508
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
                Tween_Duration = 1.2,
                Transparency = 0.9,
                Offset = CFrame.new(
                    0.482105374,
                    -1.66240573,
                    -2.07935762,
                    -0.797108769,
                    0.0438567214,
                    0.602235794,
                    0.0512035191,
                    0.998675108,
                    -0.00495520327,
                    -0.601654887,
                    0.0268863346,
                    -0.798299134
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(77.76119, 28.728466, 72.945564),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.206175625,
                        0.0114152338,
                        -0.139427811,
                        0.73150301,
                        0.0438567586,
                        0.680421948,
                        -0.0137712732,
                        0.998675406,
                        -0.0495651737,
                        -0.681694746,
                        0.0268863104,
                        0.731137812
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
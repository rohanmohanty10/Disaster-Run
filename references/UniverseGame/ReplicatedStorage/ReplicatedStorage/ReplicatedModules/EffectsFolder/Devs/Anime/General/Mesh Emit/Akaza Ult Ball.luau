  

 

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
        m1 = script.m1,
        m2 = script.m2
    };
    local v4 = math.random(1, 3) == 1;
    local v5 = {
        [v3.m1] = {
            General = {
                Tween_Duration = 0.1,
                Offset = CFrame.new(
                    -0.00238037296,
                    -0.00312838145,
                    0.00337940827,
                    3.24850771e-6,
                    1,
                    -2.62974436e-6,
                    -1,
                    3.24850362e-6,
                    -2.04890966e-6,
                    -2.0340085e-6,
                    2.62975027e-6,
                    1.00000012
                ),
                Transparency = v4 and 20 or 0.8
            },
            Features = {
                Random_Angles = {
                    X = { -360, 360 },
                    Y = { -360, 360 },
                    Z = { -360, 360 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(35.7307, 0.0388855, 35.7307),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -3.70604849,
                        -3.36987376,
                        -4.00901031,
                        -3.00694023e-6,
                        1,
                        2.90285743e-6,
                        0.996194422,
                        2.7424885e-6,
                        0.0871592015,
                        0.087159209,
                        3.15389252e-6,
                        -0.996194601
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v3.m2] = {
            General = {
                Tween_Duration = 0.1,
                Offset = CFrame.new(
                    -0.00238037296,
                    -0.00312838145,
                    0.00337940827,
                    3.24850771e-6,
                    1,
                    -2.62974436e-6,
                    -1,
                    3.24850362e-6,
                    -2.04890966e-6,
                    -2.0340085e-6,
                    2.62975027e-6,
                    1.00000012
                ),
                Transparency = v4 and 20 or 0.8
            },
            Features = {
                Random_Angles = {
                    X = { -360, 360 },
                    Y = { -360, 360 },
                    Z = { -360, 360 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(40.175144, 8.21432, 40.175144),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0,
                        0,
                        0,
                        -2.95560767e-6,
                        1,
                        2.81576877e-6,
                        0.996194422,
                        2.69894258e-6,
                        0.0871591941,
                        0.0871592015,
                        3.06266111e-6,
                        -0.996194601
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

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 96, Name: Emit
                -- upvalues: i (copy), v (copy), u2 (copy), Effects (copy)
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
                v6.CFrame = u2 * v.General.Offset;
                v6.Parent = Effects;

                if v.Features and v.Features.Random_Angles then
                    local Property = v.BasePart.Property;
                    Property.CFrame = Property.CFrame * CFrame.Angles(math.random(unpack(v.Features.Random_Angles.X)), math.random(unpack(v.Features.Random_Angles.Y)), math.random(unpack(v.Features.Random_Angles.Z)));
                end;

                game:GetService("TweenService"):Create(v6, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();
                task.delay(v.General.Tween_Duration, v6.Destroy, v6);
            end);
        end;
    end;
end;
  

 

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
        m1 = script.m1
    };
    local v4 = {
        [v3.m3] = {
            General = {
                Tween_Duration = 0.8,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.0000358151883,
                    -1.03889251,
                    -0.000216376997,
                    0.984800756,
                    4.07590824e-6,
                    0.173700348,
                    -5.11648068e-6,
                    1,
                    5.54287908e-6,
                    -0.173700392,
                    -6.34733397e-6,
                    0.984800756
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
                    Size = Vector3.new(20.462963, 4.75, 20.462963),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.0000404077146,
                        -2.12499976,
                        -0.000210422295,
                        0.984800756,
                        4.07590824e-6,
                        0.173700348,
                        -5.11648068e-6,
                        1,
                        5.54287908e-6,
                        -0.173700392,
                        -6.34733397e-6,
                        0.984800756
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
                Tween_Duration = 0.3,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.000048926755,
                    2.37136078e-7,
                    -0.000233469225,
                    -0.984800935,
                    -4.07590824e-6,
                    0.173699394,
                    5.11647522e-6,
                    -1,
                    5.54288408e-6,
                    0.173699424,
                    6.34733397e-6,
                    0.984800935
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
                    Size = Vector3.new(17.12556, 5.2029247, 17.12556),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -9.12468386e-6,
                        -1.53889275,
                        -0.000226017655,
                        -0.984800935,
                        -4.07590824e-6,
                        0.173699394,
                        5.11647522e-6,
                        -1,
                        5.54288408e-6,
                        0.173699424,
                        6.34733397e-6,
                        0.984800935
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
                Tween_Duration = 0.6,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.0000139367075,
                    1.21110749,
                    -0.000246457435,
                    -0.984800935,
                    -4.07590824e-6,
                    0.173699394,
                    5.11647522e-6,
                    -1,
                    5.54288408e-6,
                    0.173699424,
                    6.34733397e-6,
                    0.984800935
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
                    Size = Vector3.new(12.504005, 8.125147, 12.504005),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.0000567472525,
                        -1.99999976,
                        -0.00021889621,
                        -0.984800935,
                        -4.07590824e-6,
                        0.173699394,
                        5.11647522e-6,
                        -1,
                        5.54288408e-6,
                        0.173699424,
                        6.34733397e-6,
                        0.984800935
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
            task.spawn(function() -- Line: 124, Name: Emit
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
                task.delay(v.General.Tween_Duration, v5.Destroy, v5);
            end);
        end;
    end;
end;
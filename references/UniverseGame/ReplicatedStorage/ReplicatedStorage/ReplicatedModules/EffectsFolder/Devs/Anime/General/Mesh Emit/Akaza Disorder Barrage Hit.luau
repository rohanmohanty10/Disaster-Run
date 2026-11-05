  

 

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
        m1 = script.m1,
        m4 = script.m4
    };
    local v4 = {
        [v3.m4] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -0.00272290781,
                    -0.00121813023,
                    -1.34493446,
                    -0.984798908,
                    -3.98914472e-6,
                    0.173699409,
                    0.173699409,
                    6.33974287e-6,
                    0.984798908,
                    -5.02971261e-6,
                    1,
                    -5.55046108e-6
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
                    Size = Vector3.new(4.6315985, 0.41676494, 4.6315985),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.00273309462,
                        -0.00122257089,
                        -2.53752899,
                        -0.984798908,
                        -3.98914472e-6,
                        0.173699409,
                        0.173699409,
                        6.33974287e-6,
                        0.984798908,
                        -5.02971261e-6,
                        1,
                        -5.55046108e-6
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
                Tween_Duration = 0.1,
                Transparency = -5,
                Offset = CFrame.new(
                    0.0000359373989,
                    -9.87518433e-7,
                    2.4098959,
                    -4.54747351e-13,
                    0,
                    1.00000083,
                    -1.36424205e-12,
                    -1.00000083,
                    0,
                    1,
                    1.8189894e-12,
                    -1.13686838e-13
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
                    Size = Vector3.new(0.66647166, 4.6012793, 4.6012793),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.0000123853843,
                        -0.0000189577495,
                        -2.89010239,
                        2.62977846e-6,
                        3.21865082e-6,
                        1.00000095,
                        2.08410052e-6,
                        -1.00000095,
                        3.21865082e-6,
                        1,
                        2.08409438e-6,
                        -2.62978347e-6
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
                    Scale = Vector3.new(0.028813034, 0.14560384, 0.14177333),
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
        [v3.m1] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.00272290781,
                    -0.00121813023,
                    -1.34493446,
                    -0.984798908,
                    -3.98914472e-6,
                    0.173699409,
                    0.173699409,
                    6.33974287e-6,
                    0.984798908,
                    -5.02971261e-6,
                    1,
                    -5.55046108e-6
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
                    Size = Vector3.new(2.9796753, 0.23528342, 2.9796753),
                    Transparency = 0,
                    CFrame = u2 * CFrame.new(
                        -0.00273110252,
                        -0.00122488628,
                        -2.6282692,
                        -0.984799385,
                        -5.76211005e-6,
                        0.173696786,
                        0.173696786,
                        9.15656619e-6,
                        0.984799385,
                        -7.26498638e-6,
                        1,
                        -8.01652186e-6
                    ),
                    Color = Color3.new(0.396078, 0.478431, 1)
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
            task.spawn(function() -- Line: 146, Name: Emit
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
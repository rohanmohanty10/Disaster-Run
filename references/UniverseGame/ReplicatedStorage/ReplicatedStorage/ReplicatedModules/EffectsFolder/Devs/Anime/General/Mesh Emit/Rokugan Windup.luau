  

 

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
        [v4.m4] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 0,
                Offset = CFrame.new(
                    3.22841601e-7,
                    1.39777613,
                    0.0000132007062,
                    -2.30968027e-7,
                    -1,
                    -2.18127968e-12,
                    1,
                    -2.30968027e-7,
                    -9.44407566e-6,
                    9.44407839e-6,
                    -4.36256023e-12,
                    1
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.01,
                    Duration = p2
                },
                Random_Angles = {
                    X = { -360, 360 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(0.4964924, 21.66714, 21.66714),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.75587013e-6,
                        -7.60222149,
                        -0.0000641665756,
                        -2.30968027e-7,
                        -1,
                        -2.18127968e-12,
                        1,
                        -2.30968027e-7,
                        -9.44407566e-6,
                        9.44407839e-6,
                        -4.36256023e-12,
                        1
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
                    Scale = Vector3.new(0.021464454, 0.6856392, 0.66760164),
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
        [v4.m3] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -2.21780624e-6,
                    -9.60222149,
                    -0.0000906841233,
                    1,
                    2.30968027e-7,
                    -2.18127946e-12,
                    -2.30968027e-7,
                    1,
                    -9.44407566e-6,
                    0,
                    9.44407839e-6,
                    1
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.01,
                    Duration = p2
                },
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(10.767038, 31.837606, 10.767038),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -8.5768761e-6,
                        -4.10222006,
                        -0.000038741684,
                        1,
                        2.30968027e-7,
                        -2.18127946e-12,
                        -2.30968027e-7,
                        1,
                        -9.44407566e-6,
                        0,
                        9.44407839e-6,
                        1
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0.8,
                Offset = CFrame.new(
                    5.29610452e-6,
                    -10.1022205,
                    -0.0000877767598,
                    -2.30968027e-7,
                    -1,
                    -2.18127968e-12,
                    1,
                    -2.30968027e-7,
                    -9.44407566e-6,
                    9.44407839e-6,
                    -4.36256023e-12,
                    1
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.01,
                    Duration = p2
                },
                Random_Angles = {
                    X = { -360, 360 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(19.837185, 16.227045, 16.227045),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -8.5768761e-6,
                        -4.10222006,
                        -0.000038741684,
                        -2.30968027e-7,
                        -1,
                        -2.18127968e-12,
                        1,
                        -2.30968027e-7,
                        -9.44407566e-6,
                        9.44407839e-6,
                        -4.36256023e-12,
                        1
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
                    Scale = Vector3.new(0.92231375, 0.7284521, 0.7043531),
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
        [v4.m1] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0.8,
                Offset = CFrame.new(
                    -8.5768761e-6,
                    -4.10222006,
                    -0.000038741684,
                    1,
                    2.30968027e-7,
                    -2.18127946e-12,
                    -2.30968027e-7,
                    1,
                    -9.44407566e-6,
                    0,
                    9.44407839e-6,
                    1
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.01,
                    Duration = p2
                },
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { -360, 360 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(24.4807, 24.187607, 24.4807),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -8.5768761e-6,
                        -4.10222006,
                        -0.000038741684,
                        1,
                        2.30968027e-7,
                        -2.18127946e-12,
                        -2.30968027e-7,
                        1,
                        -9.44407566e-6,
                        0,
                        9.44407839e-6,
                        1
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            local function Emit() -- Line: 215
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

                if v.Features and v.Features.Random_Angles then
                    local Property = v.BasePart.Property;
                    Property.CFrame = Property.CFrame * CFrame.Angles(math.random(unpack(v.Features.Random_Angles.X)), math.random(unpack(v.Features.Random_Angles.Y)), math.random(unpack(v.Features.Random_Angles.Z)));
                end;

                game:GetService("TweenService"):Create(v6, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();

                if v.Decal then
                    game:GetService("TweenService"):Create(v6:FindFirstChildOfClass("Decal"), TweenInfo.new(v.General.Tween_Duration, v.Decal.Tween.Easing_Style, v.Decal.Tween.Easing_Direction), v.Decal.Property):Play();
                end;

                if v.Mesh then
                    game:GetService("TweenService"):Create(v6:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v.General.Tween_Duration, v.Mesh.Tween.Easing_Style, v.Mesh.Tween.Easing_Direction), v.Mesh.Property):Play();
                end;

                task.delay(v.General.Tween_Duration, v6.Destroy, v6);
            end;

            if v.Features and v.Features.Emitter then
                local u7 = tick();
                local u8 = 0;
                local u9 = nil;
                u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 251
                    -- upvalues: u7 (copy), v (copy), u9 (ref), u8 (ref), Emit (copy)
                    if tick() - u7 >= v.Features.Emitter.Duration then
                        u9:Disconnect();

                        return;
                    end;

                    u8 = u8 + p10;

                    if u8 >= v.Features.Emitter.Yield_Time then
                        u8 = 0;
                        task.spawn(Emit);
                    end;
                end);
            end;

            task.spawn(Emit);
        end;
    end;
end;
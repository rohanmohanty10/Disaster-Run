  

 

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
        mesh1 = script.mesh1,
        n = script.n
    };
    local v5 = {
        [v4.n] = {
            General = {
                Tween_Duration = 0.35,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.952334285,
                    -26.0249252,
                    2.29076529,
                    -0.525521934,
                    -2.5060249e-12,
                    -0.85078007,
                    -9.63222384e-12,
                    1,
                    3.00420734e-12,
                    0.85078007,
                    9.773681e-12,
                    -0.525521934
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.15,
                    Duration = 2.3
                },
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(63.68, 71.942444, 59.564472),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.952334285,
                        -6.22789764,
                        2.29076529,
                        0.525521934,
                        -2.5060249e-12,
                        0.85078007,
                        9.63222384e-12,
                        1,
                        -3.00420734e-12,
                        -0.85078007,
                        9.773681e-12,
                        0.525521934
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(1.6459031, 1.770925, 1.539512),
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
                    Color3 = Color3.new(1.56863, 1.17647, 4.70588)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.mesh1] = {
            General = {
                Tween_Duration = 0.35,
                Transparency = 0,
                Offset = CFrame.new(
                    8.01877377e-6,
                    -12.3301945,
                    -0.000012981809,
                    1,
                    -4.67724037e-12,
                    -2.12154248e-23,
                    4.6772408e-12,
                    1,
                    4.53588556e-12,
                    0,
                    -4.53588512e-12,
                    1
                )
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.15,
                    Duration = 2.3
                },
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(63.68, 89.62697, 59.564472),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        8.01880469e-6,
                        -1.90734863e-6,
                        -0.0000129818363,
                        -1,
                        -4.67724037e-12,
                        2.12154248e-23,
                        -4.6772408e-12,
                        1,
                        -4.53588556e-12,
                        0,
                        -4.53588512e-12,
                        -1
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(1.6459031, 2.2062447, 1.539512),
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
                    Color3 = Color3.new(1.56863, 1.17647, 4.70588)
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
            local function Emit() -- Line: 146
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
                u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 182
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
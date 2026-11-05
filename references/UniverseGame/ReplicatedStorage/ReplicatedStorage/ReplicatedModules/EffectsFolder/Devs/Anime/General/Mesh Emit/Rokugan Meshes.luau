  

 

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
        distotion2 = script.distotion2,
        m4 = script.m4,
        m1 = script.m1
    };
    local v5 = {
        [v4.distotion2] = {
            General = {
                Tween_Duration = 0.1,
                Transparency = 20,
                Offset = CFrame.new(0.000686787651, -0.0895423889, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.15,
                    Duration = p2
                },
                Random_Angles = {
                    X = { 0, 0 },
                    Y = { 0, 0 },
                    Z = { 0, 0 }
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(20, 20, 45.5),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.000728607178, -0.0893630981, -0.249988556, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v4.m1] = {
            General = {
                Tween_Duration = 0.15,
                Transparency = 0,
                Offset = CFrame.new(0.000272627338, 0.000637054443, 19.0411758, -1, 0, 0, 0, 0, 1, 0, 1, 0)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.1,
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
                    Size = Vector3.new(18.247372, 34.55692, 18.247372),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.000272627338, 0.000637054443, 1.79117584, -1, 0, 0, 0, 0, 1, 0, 1, 0),
                    Color = Color3.new(1, 0, 0.74902)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0.8,
                Offset = CFrame.new(0.000272627338, 0.000637054443, 17.5411758, -0.999999881, 0, 0, 0, 0, 0.999999881, 0, 1, 0)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.15,
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
                    Size = Vector3.new(47.30092, 9.58678, 45.639122),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.000272627338, 0.000637054443, 12.1370001, -0.999999881, 0, 0, 0, 0, 0.999999881, 0, 1, 0),
                    Color = Color3.new(0.929412, 0.917647, 0.917647)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0.5,
                Offset = CFrame.new(0.000272627338, 0.000637054443, 17.5411758, -0.999999881, 0, 0, 0, 0, 0.999999881, 0, 1, 0)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.15,
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
                    Size = Vector3.new(31.30198, 18.58678, 30.202263),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.000272627338, 0.000637054443, 1.63700104, -0.999999881, 0, 0, 0, 0, 0.999999881, 0, 1, 0),
                    Color = Color3.new(0.803922, 0.803922, 0.803922)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        },
        [v4.m4] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(0.000272627338, 0.000637054443, 22.988945, -0.999999881, 0, 0, 0, 0, 0.999999881, 0, 1, 0)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.1,
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
                    Size = Vector3.new(17.356447, 14.586781, 15.678342),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.000272916746, 0.000637054443, 9.13700104, 0, 0, 0.999999642, 0.999999642, 0, 0, 0, 1, 0),
                    Color = Color3.new(0.0156863, 0.686275, 0.92549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.In,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            local function Emit() -- Line: 206
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
                task.delay(v.General.Tween_Duration, v6.Destroy, v6);
            end;

            if v.Features and v.Features.Emitter then
                local u7 = tick();
                local u8 = 0;
                local u9 = nil;
                u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 240
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
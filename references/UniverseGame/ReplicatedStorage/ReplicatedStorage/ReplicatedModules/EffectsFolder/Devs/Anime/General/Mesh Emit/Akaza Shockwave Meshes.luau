  

 

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
        MeshAirtype = script.MeshAirtype,
        e2 = script.e2,
        MeshAirtype2 = script.MeshAirtype2
    };
    local v4 = {
        [v3.MeshAirtype] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0.4,
                Offset = CFrame.new(
                    -0.0974654332,
                    0.953025103,
                    -2.4893074,
                    0.00798506103,
                    -0.0115999794,
                    -0.999904275,
                    0.00811694562,
                    0.999902904,
                    -0.0115356194,
                    0.999937534,
                    -0.00802387949,
                    0.00807879027
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(6.68016, 1.5804337, 1.5719155),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.29246524,
                        0.497956723,
                        2.0747757,
                        0.00798434485,
                        0.950160742,
                        0.311659992,
                        0.00811722223,
                        -0.311721087,
                        0.950138867,
                        0.999935985,
                        -0.00505643059,
                        -0.0102015398
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
                    Scale = Vector3.new(0.44126496, 0.23561504, 0.23613876),
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
                    Color3 = Color3.new(1.17647, 1.96078, 7.84314)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v3.MeshAirtype2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.116195597,
                    0.933986187,
                    -4.83472061,
                    0.00798506197,
                    -0.0115999784,
                    -0.999904394,
                    0.00811694842,
                    0.999902904,
                    -0.0115356212,
                    0.999937773,
                    -0.00802387856,
                    0.0080787912
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(6.68016, 1.5804337, 1.5719155),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.273727447,
                        0.478918761,
                        -0.270637512,
                        0.00798434578,
                        0.950160921,
                        0.311660051,
                        0.00811722502,
                        -0.311721087,
                        0.950138807,
                        0.999936223,
                        -0.00505643245,
                        -0.0102015398
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
                    Scale = Vector3.new(0.44126496, 0.23561504, 0.23613876),
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
                    Color3 = Color3.new(1.17647, 1.96078, 7.84314)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v3.e2] = {
            General = {
                Tween_Duration = 0.4,
                Transparency = 0.9,
                Offset = CFrame.new(-0.0430908166, 0.0506377257, -4.80886841, 1, 0, 0, 0, 0, 1, -0, -1, 0)
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(15.779741, 13.358976, 15.779741),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(0, 0, 0, -1, 0, -8.74227766e-8, 8.74227766e-8, 0, -1, 0, -1, 0),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
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
            task.spawn(function() -- Line: 150, Name: Emit
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
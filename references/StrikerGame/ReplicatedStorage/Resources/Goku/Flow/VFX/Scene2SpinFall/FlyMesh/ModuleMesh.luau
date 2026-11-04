 

 

return function(p1, u2: userdata?) -- Line: 3
    if p1 then
        if typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        elseif typeof(p1) ~= "CFrame" then
            p1 = nil;
        end;
    end;

    if not u2 then
        u2 = workspace:FindFirstChild("MeshCache");

        if not u2 then
            u2 = Instance.new("Folder");
            u2.Name = "MeshCache";
            u2.Parent = workspace;
        end;
    end;

    local u3 = p1 or CFrame.new(0, 0, 0);
    local v4 = {
        Mesh3 = script.Parent.Mesh3,
        Mesh2 = script.Parent.Mesh2,
        Mesh1 = script.Parent.Mesh1
    };
    local v5 = {
        [v4.Mesh1] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.95,
                Offset = CFrame.new(
                    0.647467792,
                    -6.64296198,
                    -0.608197987,
                    -0.92345202,
                    3.89775596e-6,
                    0.38371399,
                    0,
                    -1,
                    0.0000101579717,
                    0.38371399,
                    9.38039921e-6,
                    0.92345202
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(12.459206, 21.59, 13.614382),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.86102277, -0.439066887, -4.55994664e-14, 1, 0, 0, 0, -1, 0, 0, 0, -1),
                    Color = Color3.new(0.988235, 0.980392, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            }
        },
        [v4.Mesh2] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = 0.8,
                Offset = CFrame.new(
                    0.797153771,
                    -7.91118002,
                    0.0707650036,
                    0.0000140000002,
                    0.668186724,
                    -0.74399364,
                    1,
                    0.0000717406947,
                    0.0000832482692,
                    0.000109000001,
                    -0.74399364,
                    -0.668186724
                )
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(7.278281, 12.336209, 12.837779),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.86102277, 3.71950388, -4.55994664e-14, 0, 0, 1, 1, 0, 0, 0, 1, 0),
                    Color = Color3.new(0.988235, 0.980392, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quad
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.7828875, 0.29368132, 0.3397143),
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
                    Color3 = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.Mesh3] = {
            General = {
                Tween_Duration = 1.5,
                Transparency = 0.9,
                Offset = CFrame.new(0.861023068, -2.43907595, 0, 1, 0, 0, 0, -1, 0, 0, 0, -1)
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(20.382866, 10.643362, 19.079437),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0, 5.91238642, 0, -1, 0, 0, 0, -1, 0, 0, 0, 1),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 131, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), u2 (ref)
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
                v6.Parent = u2;
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
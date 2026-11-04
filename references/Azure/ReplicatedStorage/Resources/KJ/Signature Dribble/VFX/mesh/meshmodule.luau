 
 

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
        m1 = script.Parent.m1,
        m2 = script.Parent.m2
    };
    local v5 = {
        [v4.m1] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.5,
                Offset = CFrame.new(0, -0.41035676, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(9, 0.6, 9),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0, -0.760356665, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(0, -2.55000019, -7.39097595e-6, 0, 0, 1, -1, 0, 0, 0, -1, 0)
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(3.5970056, 4.3931413, 4.396217),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0,
                        2.54999995,
                        -7.39097595e-6,
                        0,
                        -0.999390841,
                        0.0348994955,
                        -1,
                        0,
                        0,
                        0,
                        -0.0348994955,
                        -0.999390841
                    ),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            },
            Mesh = {
                Property = {
                    Offset = Vector3.new(0, 0, 0),
                    Scale = Vector3.new(0.15732841, 0.14602628, 0.14120449),
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
                    Color3 = Color3.new(39.2157, 39.2157, 39.2157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Quart
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 114, Name: Emit
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
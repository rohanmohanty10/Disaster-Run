  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
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
        m1 = script.m1,
        m4 = script.m4
    };
    local v4 = {
        [v3.m4] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0.8,
                Offset = CFrame.new(
                    0.0000936277211,
                    0.498898506,
                    0.000903798733,
                    0.939693928,
                    0,
                    0.342020631,
                    -0,
                    -1,
                    0,
                    0.342020631,
                    0,
                    -0.939693928
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(44.328278, 0.09690651, 44.26),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        0.0000936277211,
                        -5.79110527,
                        0.000903798733,
                        -0.81915319,
                        0,
                        -0.573577344,
                        0,
                        -1,
                        0,
                        -0.573577344,
                        0,
                        0.81915319
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
                Tween_Duration = 0.2,
                Transparency = -1,
                Offset = CFrame.new(
                    -0.073714681,
                    -2.6958456,
                    -0.00523297861,
                    0.0223709978,
                    -0.00290712714,
                    0.999746978,
                    0.999745429,
                    0.00300480425,
                    -0.0223622415,
                    -0.0029390147,
                    0.999993026,
                    0.00297361612
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(10.258534, 22.478895, 22.478895),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.110943086,
                        -4.36041927,
                        -0.000322975218,
                        -0.00293902215,
                        0.999992251,
                        0.00297364593,
                        0.999745429,
                        0.00300479215,
                        -0.0223622508,
                        -0.022371009,
                        0.00290703773,
                        -0.999747753
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
                    Scale = Vector3.new(0.4769622, 1.0091056, 0.9757216),
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
                    Color3 = Color3.new(5.2549, 6.35294, 10)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v3.m2] = {
            General = {
                Tween_Duration = 0.6,
                Transparency = -1,
                Offset = CFrame.new(
                    0.0442358851,
                    2.57531071,
                    -0.0207171533,
                    0.0223710425,
                    -0.00290703773,
                    0.999747217,
                    0.999745429,
                    0.00300477049,
                    -0.0223622639,
                    -0.00293899607,
                    0.999993086,
                    0.00297361612
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(15.476645, 36.309002, 36.309002),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.0173042882,
                        -10.612196,
                        0.00792665221,
                        -0.0225418285,
                        0.176510096,
                        -0.984042406,
                        0.999745548,
                        0.00300489785,
                        -0.0223625582,
                        -0.000990270637,
                        -0.984296143,
                        -0.176533014
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
                    Scale = Vector3.new(0.66908956, 1.148931, 1.1187053),
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
        [v3.m1] = {
            General = {
                Tween_Duration = 0.3,
                Transparency = 0.6,
                Offset = CFrame.new(
                    -0.000650040107,
                    -2.63110447,
                    0.000103663479,
                    2.98023224e-8,
                    0,
                    1.00000155,
                    0,
                    -1,
                    -0,
                    1.00000155,
                    0,
                    -2.98023224e-8
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(45.97537, 9.806906, 43.469997),
                    Transparency = 1,
                    CFrame = u2 * CFrame.new(
                        -0.000650040107,
                        -0.936103821,
                        0.000103663479,
                        0.25881952,
                        0,
                        -0.965927184,
                        0,
                        -1,
                        0,
                        -0.965927184,
                        0,
                        -0.25881952
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
            task.spawn(function() -- Line: 188, Name: Emit
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
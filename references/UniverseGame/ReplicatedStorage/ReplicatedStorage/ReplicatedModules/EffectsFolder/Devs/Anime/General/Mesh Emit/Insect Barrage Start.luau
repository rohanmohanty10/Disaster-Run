  

 

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
        m4 = script.m4,
        m5 = script.m5,
        m6 = script.m6
    };
    local v5 = {
        [v4.m6] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.84955442,
                    -0.270953327,
                    -5.83593225,
                    -0.993341804,
                    -0.0137249557,
                    0.114371955,
                    0.114319876,
                    0.00428219885,
                    0.993431151,
                    -0.0141245769,
                    0.999896646,
                    -0.00268460927
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(6.0508294, 31.36772, 2.663008),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.88257051,
                        0.0514650941,
                        -1.9371016,
                        0.355868757,
                        -0.0137249557,
                        0.934433162,
                        0.934533119,
                        0.00428219885,
                        -0.355840147,
                        0.000882505788,
                        0.999896646,
                        0.0143503211
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m5] = {
            General = {
                Tween_Duration = 1,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.362553656,
                    0.32042864,
                    -15.8948088,
                    -0.114372104,
                    -0.0137249557,
                    -0.993341863,
                    -0.993431091,
                    0.00428219885,
                    0.114319816,
                    0.0026846074,
                    0.999896646,
                    -0.014124576
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(19.751371, 16.774303, 19.876163),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -1.08498669,
                        0.0171039701,
                        5.93560791,
                        -0.934433103,
                        -0.0137249557,
                        0.355868787,
                        0.355840117,
                        0.00428219885,
                        0.93453294,
                        -0.0143503174,
                        0.999896646,
                        0.000882505206
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m4] = {
            General = {
                Tween_Duration = 0.7,
                Transparency = 0.9,
                Offset = CFrame.new(
                    -0.0779137164,
                    -0.851478219,
                    -6.89323902,
                    -0.652399421,
                    0.0137249846,
                    -0.757750988,
                    0.75777173,
                    -0.0042822063,
                    -0.652500331,
                    -0.012200349,
                    -0.999898076,
                    -0.00760674663
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(10.4371195, 17.235947, 9.326328),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.43565321,
                        -0.186589137,
                        3.04324102,
                        -0.573405504,
                        0.0137249846,
                        0.819156766,
                        -0.819259167,
                        -0.0042822063,
                        -0.573400736,
                        -0.00436221063,
                        -0.999898076,
                        0.0136997327
                    ),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m3] = {
            General = {
                Tween_Duration = 0.34,
                Transparency = 0.92,
                Offset = CFrame.new(
                    0.43012023,
                    0.281392336,
                    7.20946932,
                    0.293674022,
                    -0.0183916185,
                    -0.955727279,
                    -0.955867767,
                    0.00284784893,
                    -0.293774545,
                    0.00812473148,
                    0.999826849,
                    -0.0167436507
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(4.203402, 14.190683, 4.203402),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        0.723083913,
                        0.236110181,
                        -8.72956848,
                        -0.974521279,
                        -0.0183916185,
                        0.223534703,
                        0.223517865,
                        0.00284784893,
                        0.974693,
                        -0.0185627993,
                        0.999826849,
                        0.0013356061
                    ),
                    Color = Color3.new(0.972549, 0.972549, 0.972549)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        },
        [v4.m2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(
                    -0.776702642,
                    -0.438882768,
                    11.4038124,
                    -0.0183916185,
                    -0.293674022,
                    -0.955727279,
                    0.00284784893,
                    0.955867767,
                    -0.293774545,
                    0.999826849,
                    -0.00812473148,
                    -0.0167436507
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(4.3940544, 3.2216537, 3.2108839),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        -0.323936671,
                        -0.446409523,
                        -5.84567595,
                        -0.0183916185,
                        -0.293674022,
                        -0.955727279,
                        0.00284784893,
                        0.955867767,
                        -0.293774545,
                        0.999826849,
                        -0.00812473148,
                        -0.0167436507
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
                    Scale = Vector3.new(0.29025385, 0.48029235, 0.4822232),
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
                    Color3 = Color3.new(0.784314, 0.392157, 3.92157)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        },
        [v4.m1] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(
                    1.03611124,
                    -2.02290678,
                    -5.88011456,
                    -0.955727279,
                    0.0183916185,
                    0.293674022,
                    -0.293774545,
                    -0.00284784893,
                    -0.955867767,
                    -0.0167436507,
                    -0.999826849,
                    0.00812473148
                )
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(13.094315, 4.821922, 13.094315),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(
                        1.07856202,
                        -2.02956891,
                        -8.18642807,
                        0.955727279,
                        0.0183916185,
                        -0.293674022,
                        0.293774545,
                        -0.00284784893,
                        0.955867767,
                        0.0167436507,
                        -0.999826849,
                        -0.00812473148
                    ),
                    Color = Color3.new(0.635294, 0.635294, 0.635294)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Cubic
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 209, Name: Emit
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
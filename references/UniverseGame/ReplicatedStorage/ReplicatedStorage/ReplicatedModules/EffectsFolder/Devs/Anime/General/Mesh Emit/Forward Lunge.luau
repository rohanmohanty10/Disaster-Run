  

 

return function(p1) -- Line: 3
    if not p1 or typeof(p1) ~= "CFrame" then
        if p1 and typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        else
            p1 = nil;
        end;
    end;

    local v2 = p1 or CFrame.new(0, 0, 0);
    local Effects = workspace:FindFirstChild("Effects");
    Effects.Parent = workspace;
    local v3 = script;
    local v4 = {
        [v3.m4] = {
            0.2,
            CFrame.new(
                0.0015247548,
                -0.0021852979,
                -26.2120514,
                0.939692616,
                0,
                0.342020184,
                -0.342020184,
                0,
                0.939692616,
                0,
                -1,
                0
            ),
            0.8,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0015247548,
                            -0.0021852979,
                            -25.7120514,
                            -0.819152176,
                            0,
                            -0.573576748,
                            0.573576748,
                            0,
                            -0.819152176,
                            0,
                            -1,
                            0
                        ) * CFrame.Angles(0, math.random(-360, 360), 0),
                        Transparency = 1,
                        Size = Vector3.new(18.120121, 30.261902, 17.483515)
                    }
                }
            }
        },
        [v3.m2] = {
            0.6,
            CFrame.new(
                0.161731765,
                0.0211332664,
                -16.4638977,
                -0.0225436836,
                0.176512375,
                -0.984040141,
                0.000996391755,
                0.984293759,
                0.17653504,
                0.99974519,
                0.00299926009,
                -0.0223654862
            ),
            -1,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.163304955,
                            -0.00773752481,
                            -23.9619827,
                            -0.0225414969,
                            0.176509798,
                            -0.984041095,
                            0.000990287401,
                            0.984294653,
                            0.176532596,
                            0.999745309,
                            0.00300482498,
                            -0.0223622657
                        ),
                        Transparency = 1,
                        Size = Vector3.new(23.708324, 11.932276, 11.932276)
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(1, 1, 1),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(1.1022991, 0.5356547, 0.51793385),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [v3.m5] = {
            0.1,
            CFrame.new(
                0.698767543,
                0.0916361213,
                7.53000641,
                0.0223708246,
                -0.0029072077,
                0.999745548,
                0.00293886848,
                -0.999991298,
                -0.00297368388,
                0.999745429,
                0.00300464453,
                -0.0223620851
            ),
            -3,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0437798798,
                            -0.335774213,
                            -38.7082367,
                            -0.00293903146,
                            0.999991417,
                            0.00297367573,
                            0.0223710313,
                            -0.00290721655,
                            0.999745727,
                            0.999745429,
                            0.00300480588,
                            -0.0223622881
                        ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                        Transparency = 1,
                        Size = Vector3.new(0.72576904, 13.677083, 13.677083)
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(5.2549, 6.35294, 10),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(0.033744045, 0.6139813, 0.5936692),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [v3.m1] = {
            0.3,
            CFrame.new(
                -0.000437500363,
                0.000120065713,
                -22.2124481,
                -4.37113847e-8,
                -4.37113918e-8,
                1,
                -1,
                -4.37113883e-8,
                -4.37113883e-8,
                4.37113918e-8,
                -1,
                -4.37113883e-8
            ),
            0.6,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.000442531193,
                            -0.0000999421754,
                            -30.2120514,
                            0.258819222,
                            0,
                            -0.965925932,
                            0.965925932,
                            0,
                            0.258819222,
                            0,
                            -1,
                            0
                        ) * CFrame.Angles(0, math.random(-360, 360), 0),
                        Transparency = 1,
                        Size = Vector3.new(28.733559, 0.26190758, 27.724083)
                    }
                }
            }
        },
        [v3.m3] = {
            0.15,
            CFrame.new(
                0.69870007,
                0.0916461349,
                7.53000641,
                0.0223708246,
                -0.0029072077,
                0.999745548,
                0.00293886848,
                -0.999991298,
                -0.00297368388,
                0.999745429,
                0.00300464453,
                -0.0223620851
            ),
            0,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0179136731,
                            -0.139992967,
                            -29.9604568,
                            -0.00293903146,
                            0.999991417,
                            0.00297367573,
                            0.0223710313,
                            -0.00290721655,
                            0.999745727,
                            0.999745429,
                            0.00300480588,
                            -0.0223622881
                        ) * CFrame.Angles(math.random(-360, 360), 0, 0),
                        Transparency = 1,
                        Size = Vector3.new(0.22576904, 20.642715, 20.642715)
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(5.2549, 6.35294, 10),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(0.010496949, 0.92667717, 0.8960202),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        }
    };

    for i, v in pairs(v4) do
        local v5 = i.Start:Clone();
        v5.Name = i.Name;
        v5.Transparency = v[3];

        if v5:FindFirstChildOfClass("Decal") then
            v5:FindFirstChildOfClass("Decal").Transparency = v[3];
            v5.Transparency = 1;
        end;

        v5.Anchored = true;
        v5.CanCollide = false;
        v5.CanQuery = false;
        v5.CanTouch = false;
        v5.Locked = true;
        v5.CFrame = v2 * v[2];
        v5.Parent = Effects;
        game:GetService("TweenService"):Create(v5, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();

        if v[4][2] then
            game:GetService("TweenService"):Create(v5:FindFirstChildOfClass("Decal"), TweenInfo.new(v[1], v[4][2][1], v[4][2][2]), v[4][2][3]):Play();
        end;

        if v[4][3] then
            game:GetService("TweenService"):Create(v5:FindFirstChildOfClass("SpecialMesh"), TweenInfo.new(v[1], v[4][3][1], v[4][3][2]), v[4][3][3]):Play();
        end;

        task.delay(v[1], v5.Destroy, v5);
    end;
end;
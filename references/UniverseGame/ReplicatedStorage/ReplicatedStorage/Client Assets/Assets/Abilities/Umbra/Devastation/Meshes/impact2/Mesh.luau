  

 

return function(p1) -- Line: 9
    if not p1 or typeof(p1) ~= "CFrame" then
        if p1 and typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        else
            p1 = nil;
        end;
    end;

    local v2 = p1 or CFrame.new(0, 0, 0);
    local v3 = workspace:FindFirstChild("MeshCache") or Instance.new("Folder");
    v3.Name = "MeshCache";
    v3.Parent = workspace;
    local v4 = {
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact2.m2] = {
            1,
            CFrame.new(
                -0.181030184,
                -48.6049004,
                -0.0411170125,
                0.0000357338686,
                0.866018057,
                -0.500012815,
                1,
                -0.0000352952738,
                0.0000103347938,
                -8.69797077e-6,
                -0.500012875,
                -0.866018057
            ),
            0.6,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0557122752,
                            -50.6980362,
                            0.0161155052,
                            0.000046532361,
                            0.866017044,
                            -0.500014544,
                            1,
                            -0.0000381041318,
                            0.0000270662858,
                            4.38724419e-6,
                            -0.500014603,
                            -0.866016984
                        ),
                        Transparency = 1,
                        Size = Vector3.new(36.51395, 123.545494, 123.545494)
                    }
                },
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(1.5785784, 3.9093685, 3.8065224),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact2.m4] = {
            1.9,
            CFrame.new(
                -0.181279689,
                -54.2175865,
                -0.0411365479,
                0.0000372180948,
                0.866017699,
                -0.500013888,
                1,
                -0.0000393704686,
                2.20081071e-12,
                -0.000014279507,
                -0.500013351,
                -0.86601764
            ),
            0.5,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0439195037,
                            -41.5836906,
                            0.0132085811,
                            0.0000302861681,
                            0.866016746,
                            -0.50001508,
                            1,
                            -0.0000349718102,
                            -1.36424205e-11,
                            -0.0000174864417,
                            -0.50001514,
                            -0.866016686
                        ),
                        Transparency = 1,
                        Size = Vector3.new(68.11776, 109.01827, 109.01827)
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
                        Scale = Vector3.new(2.9448802, 3.4496808, 3.3589284),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact2.m3] = {
            1.7,
            CFrame.new(
                -0.178758234,
                16.042717,
                -0.0415677875,
                0.0000358295583,
                0.866019547,
                -0.500010192,
                1,
                -0.0000346023189,
                0.0000117263126,
                -7.14629596e-6,
                -0.500010252,
                -0.866019487
            ),
            0.4,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.00232016691,
                            -58.7945023,
                            0.00036427725,
                            0.0000390127971,
                            0.866018116,
                            -0.500012815,
                            1,
                            -0.0000367539833,
                            0.0000143660118,
                            -5.93623736e-6,
                            -0.500012994,
                            -0.866017878
                        ),
                        Transparency = 1,
                        Size = Vector3.new(52.704845, 154.16983, 154.16983)
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(10.0196, 10.0196, 10.0196),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(2.2785463, 4.878418, 4.750079),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact2.m1] = {
            0.7,
            CFrame.new(
                -0.180662781,
                -23.291687,
                -0.0411206633,
                0.000014416175,
                -0.0000169575214,
                -1,
                1,
                -2.20885865e-9,
                0.0000144235091,
                2.23039964e-9,
                -1,
                0.0000138282776
            ),
            0,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.0653472319,
                            -47.0322838,
                            -0.163067028,
                            0.0000174498236,
                            -0.0000187754631,
                            -1,
                            1,
                            -3.55876182e-8,
                            0.0000174571614,
                            -3.12174961e-8,
                            -1,
                            0.0000158250332
                        ),
                        Transparency = 1,
                        Size = Vector3.new(29.18002, 86.10215, 86.10215)
                    }
                },
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color3 = Color3.new(1, 1, 1),
                        Transparency = 1
                    }
                },
                {
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.Out,
                    {
                        Scale = Vector3.new(1.2615165, 2.7245429, 2.6528666),
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
        v5.Parent = v3;
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
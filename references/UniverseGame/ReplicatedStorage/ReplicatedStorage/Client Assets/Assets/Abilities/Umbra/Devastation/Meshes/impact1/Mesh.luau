  

 

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
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact1.m3] = {
            1.7,
            CFrame.new(
                -0.106606282,
                9.59004021,
                -0.0247657895,
                0.0000358295583,
                0.866018772,
                -0.500011623,
                1,
                -0.0000346022935,
                0.0000117263844,
                -7.14627959e-6,
                -0.500011623,
                -0.866018713
            ),
            0.4,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.0013770574,
                            -35.1445503,
                            0.000564475602,
                            0.0000390107889,
                            0.866018414,
                            -0.50001204,
                            1,
                            -0.0000421079349,
                            5.08895027e-6,
                            -0.000016647351,
                            -0.500011981,
                            -0.866018534
                        ),
                        Transparency = 1,
                        Size = Vector3.new(31.504784, 92.156364, 92.156364)
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
                        Scale = Vector3.new(1.3620211, 2.916117, 2.8394012),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact1.m2] = {
            1,
            CFrame.new(
                -0.107979529,
                -29.0536156,
                -0.0241206065,
                0.0000357336357,
                0.866017878,
                -0.500013053,
                1,
                -0.0000352950738,
                0.0000103346674,
                -8.69799078e-6,
                -0.500013053,
                -0.866017938
            ),
            0.6,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0335125849,
                            -30.3047962,
                            0.0101011675,
                            0.0000465305311,
                            0.866018116,
                            -0.500012696,
                            1,
                            -0.0000434587128,
                            0.0000177885468,
                            -6.32470437e-6,
                            -0.500012696,
                            -0.866018057
                        ),
                        Transparency = 1,
                        Size = Vector3.new(21.826532, 73.8504, 73.8504)
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
                        Scale = Vector3.new(0.943609, 2.3368592, 2.275382),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact1.m4] = {
            1.9,
            CFrame.new(
                -0.108106323,
                -32.4086456,
                -0.0240325741,
                0.0000372180948,
                0.866017699,
                -0.500013769,
                1,
                -0.0000393704686,
                0,
                -0.0000142795034,
                -0.500013351,
                -0.866017401
            ),
            0.5,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            0.0268130898,
                            -24.8566437,
                            0.0083509339,
                            0.0000302845074,
                            0.866017878,
                            -0.500013053,
                            1,
                            -0.0000403259764,
                            -9.27678684e-6,
                            -0.0000281973789,
                            -0.500012994,
                            -0.866017938
                        ),
                        Transparency = 1,
                        Size = Vector3.new(40.717983, 65.16662, 65.16662)
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
                        Scale = Vector3.new(1.7603278, 2.0620768, 2.0078287),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.ReplicatedStorage.Effects.Awak.Devastation.Meshes.impact1.m1] = {
            0.7,
            CFrame.new(
                -0.107749149,
                -13.922431,
                -0.0242845304,
                0.0000144196674,
                -0.0000154674053,
                -1,
                1,
                0,
                0.0000144200167,
                0,
                -1,
                0.0000153183937
            ),
            0,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.0387510881,
                            -28.1135197,
                            -0.096847795,
                            0.0000174514644,
                            -0.0000154082281,
                            -1,
                            1,
                            -0.0000107446131,
                            0.0000174516299,
                            -0.0000107448805,
                            -1,
                            0.0000154080408
                        ),
                        Transparency = 1,
                        Size = Vector3.new(17.442612, 51.468315, 51.468315)
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
                        Scale = Vector3.new(0.7540825, 1.6286194, 1.5857742),
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
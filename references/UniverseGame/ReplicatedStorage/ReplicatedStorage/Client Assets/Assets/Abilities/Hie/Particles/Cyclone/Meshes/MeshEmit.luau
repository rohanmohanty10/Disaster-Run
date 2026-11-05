  

 

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
        [game.StarterPlayer.StarterPlayerScripts.Client.Hie.Assets.Particles.Cyclone.Meshes.m3] = {
            0.2,
            CFrame.new(
                -0.199964583,
                -8.98897362,
                -0.0140759274,
                0.022370968,
                -0.00290708872,
                0.999745548,
                0.999745429,
                0.00300480425,
                -0.0223622415,
                -0.00293901004,
                0.999991655,
                0.00297356723
            ),
            -1,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.300669134,
                            -13.4878292,
                            -0.00082193315,
                            -0.00293901749,
                            0.99999094,
                            0.00297361612,
                            0.999745429,
                            0.00300479215,
                            -0.0223622508,
                            -0.0223709773,
                            0.00290706754,
                            -0.999746501
                        ),
                        Transparency = 1,
                        Size = Vector3.new(27.725769, 60.75377, 60.75377)
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
                        Scale = Vector3.new(1.289087, 2.7273123, 2.6370854),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.StarterPlayer.StarterPlayerScripts.Client.Hie.Assets.Particles.Cyclone.Meshes.m2] = {
            0.6,
            CFrame.new(
                0.118824936,
                5.25738907,
                -0.0559456162,
                0.0223710034,
                -0.00290706242,
                0.999745548,
                0.999745429,
                0.0030047691,
                -0.0223622639,
                -0.00293899584,
                0.999991298,
                0.00297354208
            ),
            -1,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.00250765961,
                            -20.7359848,
                            0.000442167628,
                            -0.0225418024,
                            0.176509857,
                            -0.984040856,
                            0.999745488,
                            0.00300489832,
                            -0.0223625582,
                            -0.000990268774,
                            -0.984294415,
                            -0.176532656
                        ),
                        Transparency = 1,
                        Size = Vector3.new(30.505415, 71.56726, 71.56726)
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
                        Scale = Vector3.new(1.3188163, 2.2646134, 2.2050366),
                        VertexColor = Vector3.new(1, 1, 1),
                        Offset = Vector3.new(0, 0, 0)
                    }
                }
            }
        },
        [game.StarterPlayer.StarterPlayerScripts.Client.Hie.Assets.Particles.Cyclone.Meshes.m4] = {
            0.2,
            CFrame.new(
                -0.000512859435,
                -0.354537964,
                0.00243502343,
                0.939692616,
                0,
                0.342020154,
                0,
                -1,
                0,
                0.342020154,
                0,
                -0.939692616
            ),
            0.8,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.000512859435,
                            -17.354538,
                            0.00243502343,
                            -0.819152117,
                            0,
                            -0.573576629,
                            0,
                            -1,
                            0,
                            -0.573576629,
                            0,
                            0.819152117
                        ),
                        Transparency = 1,
                        Size = Vector3.new(110.37399, 0.17024116, 106.49629)
                    }
                }
            }
        },
        [game.StarterPlayer.StarterPlayerScripts.Client.Hie.Assets.Particles.Cyclone.Meshes.m1] = {
            0.3,
            CFrame.new(-0.00248889765, -11.354538, 0.000362167251, 0, 0, 1, 0, -1, 0, 1, 0, 0),
            0.6,
            {
                {
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.639216, 0.635294, 0.647059),
                        CFrame = v2 * CFrame.new(
                            -0.00248889765,
                            -12.354538,
                            0.000362167251,
                            0.258819163,
                            0,
                            -0.965925813,
                            0,
                            -1,
                            0,
                            -0.965925813,
                            0,
                            -0.258819163
                        ),
                        Transparency = 1,
                        Size = Vector3.new(101.93343, 10.261909, 98.35227)
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
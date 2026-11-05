  

 

return function(p1) -- Line: 3
    local v2 = p1 or CFrame.new(0, 0, 0);
    local Effects = workspace.Effects;
    local v3 = {
        [script.Last3] = {
            0.6,
            CFrame.new(-0.532714844, 0.000189304352, 12.7113457, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
            0.8,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.972549, 0.972549, 0.972549),
                        CFrame = v2 * CFrame.new(-0.533004761, -0.0000243186951, 14.4013329, 1, 0, 0, 0, -4.37113883e-8, -1, 0, 1, -4.37113883e-8),
                        Transparency = 1,
                        Size = Vector3.new(27.386248, 0.22907276, 27.386248)
                    }
                }
            }
        },
        [script.mesh2] = {
            0.8,
            CFrame.new(
                -0.000473022461,
                0.499762058,
                13.2657127,
                -0.173648089,
                0,
                -0.984807849,
                0.984807849,
                0,
                -0.173648089,
                0,
                -1,
                -0
            ),
            0.5,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.972549, 0.972549, 0.972549),
                        CFrame = v2 * CFrame.new(
                            0.000839233398,
                            0.499395847,
                            -0.235668182,
                            -0.422617674,
                            -3.0846132e-15,
                            0.906308055,
                            -0.906308055,
                            -1.87612716e-15,
                            -0.422617674,
                            -4.85886262e-15,
                            -1,
                            6.6316344e-15
                        ),
                        Transparency = 1,
                        Size = Vector3.new(19.782347, 32.233585, 20.014788)
                    }
                }
            }
        },
        [script.SideWind] = {
            0.3,
            CFrame.new(0, -0.844979763, 23.4117851, 1, 0, 0, 0, 1, 0, 0, 0, 1),
            0.5,
            {
                {
                    Enum.EasingStyle.Cubic,
                    Enum.EasingDirection.Out,
                    {
                        Color = Color3.new(0.972549, 0.972549, 0.972549),
                        CFrame = v2 * CFrame.new(0, 1.00167036, -0.781730652, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                        Transparency = 1,
                        Size = Vector3.new(41.863426, 10.682178, 53.327118)
                    }
                }
            }
        }
    };

    for i, v in pairs(v3) do
        local v4 = i.Start:Clone();
        v4.Name = i.Name;
        v4.Transparency = v[3];
        v4.Anchored = true;
        v4.CanCollide = false;
        v4.CanQuery = false;
        v4.CanTouch = false;
        v4.Locked = true;
        v4.CFrame = v2 * v[2];
        v4.Parent = Effects;
        game:GetService("TweenService"):Create(v4, TweenInfo.new(v[1], v[4][1][1], v[4][1][2]), v[4][1][3]):Play();
        task.delay(v[1], v4.Destroy, v4);
    end;
end;
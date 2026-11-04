 
 

return function(p1, u2: userdata?) -- Line: 3
    if p1 then
        if typeof(p1) == "Vector3" then
            p1 = CFrame.new(p1);
        elseif typeof(p1) ~= "CFrame" then
            p1 = nil;
        end;
    end;

    local u3 = p1 or CFrame.new(0, 0, 0);
    local v4 = {
        S1 = script.Parent.S1,
        S2 = script.Parent.S2
    };
    local v5 = {
        [v4.S1] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(0.0805949494, -5.84459019, 0.736820221, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.3,
                    Duration = 1
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(24.365513, 3.9884312, 24.41249),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0.0805911347, -6.40218019, 0.736896515, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                    Color = Color3.new(1, 1, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Sine
                }
            }
        },
        [v4.S2] = {
            General = {
                Tween_Duration = 0.2,
                Transparency = 0,
                Offset = CFrame.new(-7.69651507e-8, 1.41865778, 0.880378723, 0, 0, 1, 0, 1, 0, -1, 0, 0)
            },
            Features = {
                Emitter = {
                    Yield_Time = 0.3,
                    Duration = 1
                }
            },
            BasePart = {
                Property = {
                    Size = Vector3.new(24.904802, 7.16865, 24.904802),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(4.28916671e-8, -3.91250277, -0.490623474, 8.74227766e-8, 0, 1, 0, 1, 0, -1, 0, 8.74227766e-8),
                    Color = Color3.new(0.988235, 0.980392, 1)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.InOut,
                    Easing_Style = Enum.EasingStyle.Linear
                }
            }
        }
    };

    for i, v in pairs(v5) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            local function Emit() -- Line: 90
                -- upvalues: i (copy), v (copy), u3 (copy), u2 (copy)
                local v6 = i.Start:Clone();
                v6.Name = i.Name;
                v6.Transparency = v.General.Transparency;

                if v6:FindFirstChildOfClass("Decal") then
                    v6:FindFirstChildOfClass("Decal").Transparency = v.General.Transparency;
                    v6.Transparency = 1;
                end;

                v6.CFrame = u3 * v.General.Offset;
                v6.Parent = u2;
                game:GetService("TweenService"):Create(v6, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();
                task.delay(v.General.Tween_Duration, v6.Destroy, v6);
            end;

            if v.Features and v.Features.Emitter then
                local u7 = tick();
                local u8 = 0;
                local u9 = nil;
                u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 113
                    -- upvalues: u7 (copy), v (copy), u9 (ref), u8 (ref), Emit (copy)
                    if tick() - u7 >= v.Features.Emitter.Duration then
                        u9:Disconnect();

                        return;
                    end;

                    u8 = u8 + p10;

                    if u8 >= v.Features.Emitter.Yield_Time then
                        u8 = 0;
                        task.spawn(Emit);
                    end;
                end);
            end;

            task.spawn(Emit);
        end;
    end;
end;
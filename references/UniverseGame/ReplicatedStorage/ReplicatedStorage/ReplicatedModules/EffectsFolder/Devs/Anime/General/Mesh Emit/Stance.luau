  

 

return function(p1, p2) -- Line: 3
    local Effects = workspace.Effects;
    local u3 = p1 or CFrame.new(0, 0, 0);
    local v4 = {
        [({
            mesh = script.mesh
        }).mesh] = {
            General = {
                Tween_Duration = 0.25,
                Transparency = 0.6,
                Offset = CFrame.new(0, 4.76837158e-7, 0, 0.642763317, 0, 0.766064823, 0, 1, 0, -0.766064823, 0, 0.642763317)
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(10.102041, 3.5, 10.102041),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0, -2.50499916, 0, -0.716766834, 0, -0.697312951, 0, 1, 0, 0.697312951, 0, -0.716766834),
                    Color = Color3.new(0.65098, 0.65098, 0.65098)
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
            task.spawn(function() -- Line: 50, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), Effects (ref)
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
                v5.CFrame = u3 * v.General.Offset;
                v5.Parent = Effects;
                game:GetService("TweenService"):Create(v5, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();
                task.delay(v.General.Tween_Duration, v5.Destroy, v5);
            end);
        end;
    end;
end;
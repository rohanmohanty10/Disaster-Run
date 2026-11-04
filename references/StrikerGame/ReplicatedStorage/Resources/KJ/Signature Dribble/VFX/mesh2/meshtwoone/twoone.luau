 
 

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
        [({
            m1 = script.Parent.m1
        }).m1] = {
            General = {
                Tween_Duration = 0.5,
                Transparency = 0.8,
                Offset = CFrame.new(0, 1.76249647, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            },
            Features = {},
            BasePart = {
                Property = {
                    Size = Vector3.new(8, 0.2, 8),
                    Transparency = 1,
                    CFrame = u3 * CFrame.new(0, -1.98749661, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
                    Color = Color3.new(0.639216, 0.635294, 0.647059)
                },
                Tween = {
                    Easing_Direction = Enum.EasingDirection.Out,
                    Easing_Style = Enum.EasingStyle.Exponential
                }
            }
        }
    };

    for i, v in pairs(v4) do
        if i and (i:IsDescendantOf(game) and i:FindFirstChild("Start")) then
            task.spawn(function() -- Line: 66, Name: Emit
                -- upvalues: i (copy), v (copy), u3 (copy), u2 (ref)
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
                v5.Parent = u2;
                game:GetService("TweenService"):Create(v5, TweenInfo.new(v.General.Tween_Duration, v.BasePart.Tween.Easing_Style, v.BasePart.Tween.Easing_Direction), v.BasePart.Property):Play();
                task.delay(v.General.Tween_Duration, v5.Destroy, v5);
            end);
        end;
    end;
end;
  

 

local function CreateInstance(p1, p2) -- Line: 1
    local function CheckProperty(p3, p4) -- Line: 3
        local _ = p3[p4];
    end;

    local u5 = Instance.new(p1);

    for i, v in pairs(p2) do
        if pcall(function() -- Line: 10
            -- upvalues: u5 (copy), i (copy)
            local _ = u5[i];
        end) then
            u5[i] = v;
        end;
    end;

    return u5;
end;

return function(p6, p7) -- Line: 19
    -- upvalues: CreateInstance (copy)
    local v8;

    if p6 then
        v8 = p6:FindFirstChild("HumanoidRootPart") or p6.PrimaryPart;
        p6:FindFirstChild("Humanoid");
    else
        v8 = nil;
    end;

    local CFrame2 = v8.CFrame;
    local v9 = RaycastParams.new();
    v9.FilterType = Enum.RaycastFilterType.Blacklist;

    for i = 1, 10 do
        if i % 2 == 0 then
            local v10 = CreateInstance("Part", {
                Anchored = true,
                CanCollide = false,
                Size = Vector3.new(2.5, 2.5, 2.5)
            });
            v10.CFrame = CFrame2;
            v9.FilterDescendantsInstances = { v10, workspace.Effects, p6 };

            for _ = 1, i / 2 do
                local v11 = workspace:Raycast(v10.Position, Vector3.new(0, -3.5, 0), v9);

                if v11 then
                    local Instance2 = v11.Instance;
                    v10.Color = Instance2.Color;
                    v10.Material = Instance2.Material;
                    v10.CFrame = CFrame2 * CFrame.new(-3, -2.5, i * -1.5) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                    v10.Parent = workspace.Effects;
                else
                    v10:Destroy();
                end;
            end;

            local v12 = CreateInstance("Part", {
                Anchored = true,
                CanCollide = false,
                Size = Vector3.new(2.5, 2.5, 2.5)
            });
            v12.CFrame = CFrame2;
            v9.FilterDescendantsInstances = { v12, workspace.Effects, p6 };

            for _ = 1, i / 2 do
                local v13 = workspace:Raycast(v12.Position, Vector3.new(0, -3.5, 0), v9);

                if v13 then
                    local Instance2 = v13.Instance;
                    v12.Color = Instance2.Color;
                    v12.Material = Instance2.Material;
                    v12.CFrame = CFrame2 * CFrame.new(3, -2.5, i * -1.5) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                    v12.Parent = workspace.Effects;
                else
                    v12:Destroy();
                end;
            end;
        end;
    end;
end;
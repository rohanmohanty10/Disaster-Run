  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
ReplicatedStorage:FindFirstChild("Client Assets");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Whitelist;
u1.FilterDescendantsInstances = { workspace.Map };
TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
local u2 = Random.new();

return function(p3, p4, p5, p6) -- Line: 17
    -- upvalues: Trove (copy), u2 (copy), u1 (copy), TweenService (copy)
    local v7 = typeof(p3) == "Vector3" and true or typeof(p3) == "CFrame";
    assert(v7);
    local v8 = Trove.new();
    local v9 = typeof(p4) == "number" and p4 and p4 or u2:NextInteger(7, 10);
    local v10 = typeof(p5) == "number" and p5 and p5 or 8;
    local v11 = typeof(p6) == "Vector3" and p6 and p6 or Vector3.new(1, 1, 1);

    if typeof(p3) == "CFrame" then
        p3 = p3.Position or p3;
    end;

    local v12 = CFrame.new(p3);
    local v13 = 360 / v9;
    local v14 = Vector3.new(v11.X * 1.3, v11.Y / 1.4, v11.Z * 1.3) * u2:NextNumber(1, 1.5);
    local v15 = Vector3.new(v11.X * 1.3, v11.Y * 0.7, v11.Z * 1.3) * u2:NextNumber(1, 1.35);
    local v16 = Vector3.new(v14.X * 1.01, v14.Y * 0.25, v14.Z * 1.01);
    local v17 = Vector3.new(v15.X * 1.01, v15.Y * 0.25, v15.Z * 1.01);
    task.delay(2.5, v8.Destroy, v8);
    local v18 = 30;

    for i = 1, 2 do
        local v19 = i % 2 == 0;
        local u20;

        if v19 then
            u20 = v15;
        else
            u20 = v14;
        end;

        local v21;

        if v19 then
            v21 = v17;
        else
            v21 = v16;
        end;

        for _ = 1, v9 do
            v18 = v18 + v13;
            local v22 = v12 * CFrame.fromEulerAnglesXYZ(0, math.rad(v18), 0) * CFrame.new(v10 / 2 + v10 / (v19 and 10 or 2.7), 10, 0);
            local v23 = workspace:Raycast(v22.Position, Vector3.new(0, -15, 0), u1);

            if v23 and v23.Instance then
                local v24;

                if v23.Instance.Material == Enum.Material.Plastic then
                    v24 = Enum.Material.SmoothPlastic;
                else
                    v24 = v23.Instance.Material;
                end;

                local u25 = v8:Add(Instance.new("Part"));
                u25.BrickColor = BrickColor.new("Dark grey");
                u25.CanCollide = false;
                u25.Anchored = true;
                local v26;

                if v19 then
                    v26 = CFrame.new(v23.Position - Vector3.new(0, v11.Y * 0.4, 0), p3) * CFrame.fromEulerAnglesXYZ(u2:NextNumber(-1, -0.3), u2:NextNumber(-0.15, 0.15), u2:NextNumber(-0.15, 0.15));
                else
                    v26 = CFrame.new(v23.Position - Vector3.new(0, v11.Y * 0.4, 0), p3) * CFrame.fromEulerAnglesXYZ(u2:NextNumber(-1, -0.3), u2:NextNumber(-0.15, 0.15), u2:NextNumber(-0.15, 0.15));
                end;

                u25.CFrame = v26;
                u25.Size = u20;
                u25.Material = v24;
                u25.Parent = workspace.Effects;
                local u27 = v8:Add(Instance.new("Part"));
                u27.Color = v23.Instance.Color;
                u27.CanCollide = false;
                u27.Anchored = true;
                u27.CFrame = u25.CFrame * CFrame.new(0, u20.Y / 2 - v21.Y / 2.1, 0);
                u27.Size = v21;
                u27.Material = v24;
                u27.Parent = workspace.Effects;
                task.delay(2, function() -- Line: 72
                    -- upvalues: TweenService (ref), u25 (copy), u27 (copy), u20 (copy)
                    TweenService:Create(u25, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01)
                    }):Play();
                    TweenService:Create(u27, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01),
                        CFrame = u25.CFrame * CFrame.new(0, u20.Y / 2 - u20.Y / 2.1, 0)
                    }):Play();
                end);
            end;
        end;
    end;
end;
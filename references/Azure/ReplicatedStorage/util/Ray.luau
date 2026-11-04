 

 

game:GetService("ReplicatedStorage");
local u1 = {};
u1.__index = u1;

function cleanup(p2)
    for i, v in p2 do
        if i ~= "_cleared" and i ~= "_destroyed" then
            if typeof(v) == "table" then
                cleanup(v);
            else
                if typeof(v) == "table" and v.Destroy then
                    v:Destroy();
                end;

                if typeof(v) == "thread" and coroutine.status(v) == "suspended" then
                    task.cancel(v);
                end;

                if typeof(v) == "RBXScriptConnection" then
                    v:Disconnect();
                end;

                p2[i] = nil;
            end;
        end;
    end;
end;

function u1.new(p3) -- Line: 44
    -- upvalues: u1 (copy)
    local v4 = setmetatable({}, u1);
    v4.list = p3.Ignore or {};
    v4.params = RaycastParams.new();
    v4.params.FilterType = p3.FilterType or Enum.RaycastFilterType.Exclude;

    if v4.params.FilterType == Enum.RaycastFilterType.Exclude then
        table.insert(v4.list, workspace.Effects);
        table.insert(v4.list, workspace.CurrentCamera);
        table.insert(v4.list, workspace.Terrain);
    end;

    v4.params.FilterDescendantsInstances = v4.list;
    v4.params.IgnoreWater = p3.IgnoreWater or false;

    return v4;
end;

local function debugRay(p5, p6) -- Line: 62
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = Color3.fromRGB(255, 0, 0);
    Part.Size = Vector3.new(0.1, 0.1, p6.Magnitude);
    Part.CFrame = CFrame.new(p5, p5 + p6) * CFrame.new(0, 0, -p6.Magnitude / 2);
    Part.Parent = workspace.Effects;
    task.delay(1, function() -- Line: 75
        -- upvalues: Part (copy)
        Part:Destroy();
    end);
end;

function u1.fire(p7, p8, p9, p10) -- Line: 80
    -- upvalues: debugRay (copy)
    local v11 = workspace:Raycast(p8, p9, p7.params);
    local v12;

    if v11 then
        v12 = v11.Instance;
    else
        v12 = v11;
    end;

    if v11 then
        local _ = v11.Normal;
    end;

    local v13;

    if v11 then
        v13 = v11.Position;
    else
        v13 = v11;
    end;

    if v11 then
        local _ = v11.Material;
    end;

    if v11 then
        local _ = v11.Distance;
    end;

    if not v12 or (v12.CanCollide or (not p7.params or p7.params.FilterType ~= Enum.RaycastFilterType.Exclude)) then
        if p10 then
            debugRay(p8, p9);
        end;

        return v11;
    end;

    print("retrying");
    table.insert(p7.list, v12);
    p7.params.FilterDescendantsInstances = p7.list;

    return p7:fire(v13, p9, p10);
end;

function u1.blockcast(p14, p15, p16, p17) -- Line: 102
    local v18 = workspace:Blockcast(p15, p16, p17, p14.params);
    local v19;

    if v18 then
        v19 = v18.Instance;
    else
        v19 = v18;
    end;

    local v20;

    if v18 then
        v20 = v18.Normal;
    else
        v20 = v18;
    end;

    local v21;

    if v18 then
        v21 = v18.Position;
    else
        v21 = v18;
    end;

    local v22;

    if v18 then
        v22 = v18.Material;
    else
        v22 = v18;
    end;

    if v18 then
        v18 = v18.Distance;
    end;

    if not (v19 and (not v19.CanCollide and p14.params.FilterType == Enum.RaycastFilterType.Exclude)) then
        return {
            Hit = v19,
            Normal = v20,
            Position = v21,
            Distance = v18,
            Material = v22
        };
    end;

    table.insert(p14.list, v19);
    p14.params.FilterDescendantsInstances = p14.list;

    return p14:fire(v21 + v20 * 0.01, p17, p14.params);
end;

function u1.Destroy(p23) -- Line: 125
    cleanup(p23);
end;

return u1;
 

 

local u1 = {};
u1.__index = u1;

local function avatarAncestor(p2) -- Line: 4
    local Parent = p2.Parent;

    while Parent and Parent ~= workspace do
        if Parent:IsA("Model") and Parent:FindFirstChildOfClass("Humanoid") then
            return Parent;
        end;

        Parent = Parent.Parent;
    end;
end;

function u1.new(p3) -- Line: 11
    -- upvalues: u1 (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.IgnoreWater = true;

    return setmetatable({
        world = p3 or workspace,
        params = RaycastParams_new_ret,
        ignored = {}
    }, u1);
end;

function u1.constrain(p4, p5, p6, p7) -- Line: 17
    -- upvalues: avatarAncestor (copy)
    local v8 = p6 - p5;

    if v8.Magnitude < 0.0001 then
        return p5;
    end;

    table.clear(p4.ignored);

    if p7 then
        table.insert(p4.ignored, p7);
    end;

    for i = 1, 8 do
        p4.params.FilterDescendantsInstances = p4.ignored;
        local v9 = p4.world:Raycast(p5, v8, p4.params);

        if not v9 then
            return p6;
        end;

        local Instance = v9.Instance;
        local v10 = avatarAncestor(Instance);

        if v10 or not Instance:IsA("BasePart") then
            Instance = v10;
        elseif Instance.Transparency < 0.99 then
            Instance = v10;
        end;

        if not Instance then
            return p5 + v8.Unit * math.max(0, v9.Distance - 0.1);
        end;

        table.insert(p4.ignored, Instance);
        local _ = i;
    end;

    return p5;
end;

return u1;
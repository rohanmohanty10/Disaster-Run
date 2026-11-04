 

 

local v1 = {};
local CollectionService = game:GetService("CollectionService");
local Part = Instance.new("Part");
Part.Anchored = true;
Part.CanCollide = false;
Part.CanTouch = false;
Part.CanQuery = false;

function v1.new(p2) -- Line: 12
    -- upvalues: CollectionService (copy)
    local HumanoidRootPart = p2.HumanoidRootPart;
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    local v3 = { p2 };

    for _, v in CollectionService:GetTagged("DashDiveIgnore") do
        table.insert(v3, v);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = v3;
    RaycastParams_new_ret.RespectCanCollide = true;
    RaycastParams_new_ret.CollisionGroup = HumanoidRootPart.CollisionGroup;
    RaycastParams_new_ret.IgnoreWater = true;
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    OverlapParams_new_ret.FilterDescendantsInstances = v3;
    OverlapParams_new_ret.RespectCanCollide = true;
    OverlapParams_new_ret.CollisionGroup = HumanoidRootPart.CollisionGroup;
    OverlapParams_new_ret.MaxParts = 1;

    return {
        stopped = false,
        params = RaycastParams_new_ret,
        overlap = OverlapParams_new_ret,
        size = Vector3.new(HumanoidRootPart.Size.X + 0.2, 1.6, HumanoidRootPart.Size.Z + 0.2)
    };
end;

function v1.limit(p4, p5, p6, p7, p8) -- Line: 23
    -- upvalues: Part (copy)
    if p4.stopped or p7 <= 0 then
        return 0;
    end;

    local math_max_ret = math.max(p8, 0.004166666666666667);
    local math_max_ret2 = math.max(0.7, p7 * 0.065);
    local v9 = math.max(math_max_ret2, p7 * math_max_ret) + 0.22;
    local CFrame_lookAt_ret = CFrame.lookAt(p5.Position, p5.Position + p6);
    Part.Size = p4.size - Vector3.new(0.15, 0.2, 0.15);
    Part.CFrame = CFrame_lookAt_ret;

    if #workspace:GetPartsInPart(Part, p4.overlap) > 0 then
        p4.stopped = true;

        return 0;
    end;

    local v10 = workspace:Blockcast(CFrame_lookAt_ret, p4.size, p6 * v9, p4.params);

    if not v10 then
        return p7;
    end;

    if v10.Normal:Dot(p6) >= -0.05 or math.abs(v10.Normal.Y) >= 0.65 then
        return p7;
    end;

    local math_max_ret3 = math.max(0, v10.Distance - 0.22);

    if math_max_ret3 <= 0.08 then
        p4.stopped = true;

        return 0;
    end;

    local v11 = p7 * math.clamp(math_max_ret3 / math_max_ret2, 0, 1);

    return math.min(p7, v11, math_max_ret3 / math_max_ret);
end;

return table.freeze(v1);
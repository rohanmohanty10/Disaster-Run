 

 

local script_Draw = require(script.Draw);

return function(p1, p2, p3, p4) -- Line: 3, Name: Hitbox
    -- upvalues: script_Draw (copy)
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterDescendantsInstances = p3 or { workspace.map };
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    local v5 = nil;

    if typeof(p2) == "Vector3" then
        v5 = workspace:GetPartBoundsInBox(p1, p2, OverlapParams_new_ret);
    elseif typeof(p2) == "number" then
        v5 = workspace:GetPartBoundsInRadius(p1.Position, p2, OverlapParams_new_ret);
    end;

    if v5 then
        script_Draw(p1, p2, #v5 > 0, nil, p4);

        return v5;
    end;
end;
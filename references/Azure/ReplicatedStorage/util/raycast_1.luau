 
 

return function(p1, p2, p3, p4, p5) -- Line: 1, Name: Raycast
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterDescendantsInstances = p4 or { workspace.map };
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    local v6;

    if p5 then
        v6 = workspace:Blockcast(CFrame.new(p1), p5, p2, RaycastParams_new_ret);
    else
        v6 = workspace:Raycast(p1, p2, RaycastParams_new_ret);
    end;

    if v6 then
        return v6;
    end;
end;
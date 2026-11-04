 

return function(p1, p2, p3, p4) --[[ Line: 2 ]]
    local v5 = Enum.RaycastFilterType.Blacklist
    if p4 ~= "Ignore" then
        v5 = Enum.RaycastFilterType.Whitelist
    end
    local v6 = RaycastParams.new()
    v6.FilterType = v5
    v6.FilterDescendantsInstances = p3
    v6.IgnoreWater = true
    local v7 = workspace:Raycast(p1, p2, v6)
    if v7 then
        return v7.Instance, v7.Position, v7.Normal
    else
        return nil, p2 + p1, Vector3.new(0, 1, 0)
    end
end
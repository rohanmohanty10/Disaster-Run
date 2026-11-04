 

return {
    ["Raycast"] = function(p1) --[[ Name: Raycast, Line 10 ]]
        local v2 = RaycastParams.new()
        v2.FilterDescendantsInstances = p1.FilterGroup or { workspace.Effects }
        v2.FilterType = p1.FilterType or Enum.RaycastFilterType.Exclude
        return workspace:Raycast(p1.Position, p1.Direction, v2)
    end
}
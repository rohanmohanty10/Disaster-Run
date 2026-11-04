 

local v1 = {}
local u2 = OverlapParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local u3 = OverlapParams.new()
u3.FilterType = Enum.RaycastFilterType.Include
u3.FilterDescendantsInstances = { workspace.PlayerCharacters }
function v1.new(_, p4, p5) --[[ Line: 13 ]]
    local v6 = p4.Properties or {}
    local u7 = Instance.new("Part")
    u7.Size = Vector3.new(1, 1, 1)
    u7.Transparency = 1
    u7.Anchored = true
    u7.CanCollide = false
    u7.Massless = true
    u7.CastShadow = false
    for v8, v9 in next, v6 do
        u7[v8] = v9
    end
    if p5 then
        task.delay(p5, function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7:Destroy()
        end)
    end
    return u7
end
function v1.HitboxScan(_, p10, p11, p12) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v13 = {}
    for _, v14 in ipairs(workspace:GetPartsInPart(p11, p12 and u2 or u3)) do
        local v15 = v14.Parent
        if (v15:FindFirstChild("Humanoid") and not v14:IsDescendantOf(p10) or (p12 and v14:IsDescendantOf(workspace.Env) or v14:IsDescendantOf(workspace.Islands))) and not table.find(v13, v15) then
            table.insert(v13, v15)
        end
    end
    return v13
end
function v1.Destroy(_, p16) --[[ Line: 53 ]]
    p16:Destroy()
end
return v1
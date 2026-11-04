 

local v1 = {}
local u2 = nil
local u3 = game:GetService("RunService")
function v1.setupWorldModel(_) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if u2 then
        return u2
    end
    local v4 = u3:IsClient() and "ReplicatedStorage" or "ServerStorage"
    u2 = Instance.new("WorldModel")
    u2.Name = "ZonePlusWorldModel"
    u2.Parent = game:GetService(v4)
    return u2
end
function v1._getCombinedResults(_, p5, ...) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = workspace[p5](workspace, ...)
    if u2 then
        local v7 = u2[p5](u2, ...)
        for _, v8 in pairs(v7) do
            table.insert(v6, v8)
        end
    end
    return v6
end
function v1.GetPartBoundsInBox(p9, p10, p11, p12) --[[ Line: 27 ]]
    return p9:_getCombinedResults("GetPartBoundsInBox", p10, p11, p12)
end
function v1.GetPartBoundsInRadius(p13, p14, p15, p16) --[[ Line: 31 ]]
    return p13:_getCombinedResults("GetPartBoundsInRadius", p14, p15, p16)
end
function v1.GetPartsInPart(p17, p18, p19) --[[ Line: 35 ]]
    return p17:_getCombinedResults("GetPartsInPart", p18, p19)
end
return v1
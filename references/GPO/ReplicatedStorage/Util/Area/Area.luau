 

local v1 = {}
function isInsideBrick(p2, p3, p4)
    local v5 = p3:PointToObjectSpace(p2)
    local v6 = v5.X
    local v7
    if math.abs(v6) <= p4.X / 2 then
        local v8 = v5.Y
        if math.abs(v8) <= p4.Y / 2 then
            local v9 = v5.Z
            v7 = math.abs(v9) <= p4.Z / 2
        else
            v7 = false
        end
    else
        v7 = false
    end
    return v7
end
function v1.setup(_, _, p10, p11) --[[ Line: 12 ]]
    local v12 = workspace.CurrentCamera.CFrame.p
    if (v12 - p10.p).magnitude > p11.magnitude then
        return false
    else
        return isInsideBrick(v12, p10, p11) == true
    end
end
return v1
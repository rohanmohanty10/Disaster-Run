 

return {
    ["GetRotationBetween"] = function(p1, p2, p3) --[[ Name: GetRotationBetween, Line 3 ]]
        local v4 = p1:Dot(p2)
        local v5 = p1:Cross(p2)
        if v4 < -0.99999 then
            return CFrame.fromAxisAngle(p3, 3.141592653589793)
        else
            return CFrame.new(0, 0, 0, v5.X, v5.Y, v5.Z, v4 + 1)
        end
    end,
    ["GetHierarchyLength"] = function(p6, p7) --[[ Name: GetHierarchyLength, Line 11 ]]
        if p6 == p7 then
            warn("Child and Root are the same Instance!")
        else
            if p6 ~= nil then
                local v8 = 0
                repeat
                    v8 = v8 + 1
                    p6 = p6.Parent
                until p6 == p7
                return v8
            end
            warn("Child is nil!")
        end
    end,
    ["WaitForChildOfClass"] = function(p9, p10, p11) --[[ Name: WaitForChildOfClass, Line 28 ]]
        local v12 = os.clock()
        local v13 = p11 or 10
        repeat
            task.wait()
        until p9:FindFirstChildOfClass(p10) or v13 < os.clock() - v12
        return p9:FindFirstChildOfClass(p10)
    end,
    ["BoxPointIntersection"] = function(p14, p15, p16) --[[ Name: BoxPointIntersection, Line 37 ]]
        local v17 = p14:PointToObjectSpace(p16)
        local v18 = p15.X
        local v19 = p15.Y
        local v20 = p15.Z
        local v21 = v17.X
        local v22 = v17.Y
        local v23 = v17.Z
        local v24 = -v18 / 2
        local v25 = v18 / 2
        local v26 = math.clamp(v21, v24, v25)
        local v27 = -v19 / 2
        local v28 = v19 / 2
        local v29 = math.clamp(v22, v27, v28)
        local v30 = -v20 / 2
        local v31 = v20 / 2
        local v32 = math.clamp(v23, v30, v31)
        if v26 ~= v21 or (v29 ~= v22 or v32 ~= v23) then
            return false
        end
        local v33 = v21 - v18 / 2
        local v34 = v22 - v19 / 2
        local v35 = v23 - v20 / 2
        local v36 = -v21 - v18 / 2
        local v37 = -v22 - v19 / 2
        local v38 = -v23 - v20 / 2
        local v39 = math.max(v33, v34, v35, v36, v37, v38)
        if v39 == v33 then
            local v40 = v18 / 2
            return true, p14 * Vector3.new(v40, v22, v23), p14.XVector
        end
        if v39 == v34 then
            local v41 = v19 / 2
            return true, p14 * Vector3.new(v21, v41, v23), p14.YVector
        end
        if v39 == v35 then
            local v42 = v20 / 2
            return true, p14 * Vector3.new(v21, v22, v42), p14.ZVector
        end
        if v39 == v36 then
            local v43 = -v18 / 2
            return true, p14 * Vector3.new(v43, v22, v23), -p14.XVector
        end
        if v39 == v37 then
            local v44 = -v19 / 2
            return true, p14 * Vector3.new(v21, v44, v23), -p14.YVector
        end
        if v39 ~= v38 then
            return false
        end
        local v45 = -v20 / 2
        return true, p14 * Vector3.new(v21, v22, v45), -p14.ZVector
    end
}
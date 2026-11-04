 

local v1 = {}
local u2 = nil
local u3 = nil
local u4 = nil
local u5 = nil
local u6 = nil
function v1.getFrustumPlanes(p7, p8) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u6
        [5] = u2
    --]]
    local v9 = p7.CFrame
    if v9 ~= u3 or (p7.FieldOfView ~= u4 or (p7.MaxAxisFieldOfView ~= u5 or p8 ~= u6)) then
        u3 = v9
        u4 = p7.FieldOfView
        u5 = p7.MaxAxisFieldOfView
        u6 = p8
        local v10 = p7.MaxAxisFieldOfView
        local v11 = math.rad(v10) * 0.5
        local v12 = p7.FieldOfView
        local v13 = math.rad(v12) * 0.5
        local v14 = {}
        local v15 = v9.LookVector
        local v16 = v9.Position
        __set_list(v14, 1, {v15, -v9.LookVector:Dot(v16)})
        local v17 = v9 * CFrame.new(0, 0, -p8)
        local v18 = {}
        local v19 = -v17.LookVector
        local v20 = v17.Position
        __set_list(v18, 1, {v19, -(-v17.LookVector):Dot(v20)})
        local v21 = v9 * CFrame.Angles(0, -v11, 0)
        local v22 = {}
        local v23 = -v21.RightVector
        local v24 = v21.Position
        __set_list(v22, 1, {v23, -(-v21.RightVector):Dot(v24)})
        local v25 = v9 * CFrame.Angles(0, v11, 0)
        local v26 = {}
        local v27 = v25.RightVector
        local v28 = v25.Position
        __set_list(v26, 1, {v27, -v25.RightVector:Dot(v28)})
        local v29 = v9 * CFrame.Angles(-v13, 0, 0)
        local v30 = {}
        local v31 = v29.UpVector
        local v32 = v29.Position
        __set_list(v30, 1, {v31, -v29.UpVector:Dot(v32)})
        local v33 = v9 * CFrame.Angles(v13, 0, 0)
        local v34 = {}
        local v35 = -v33.UpVector
        local v36 = v33.Position
        __set_list(v34, 1, {v35, -(-v33.UpVector):Dot(v36)})
        u2 = {
            v14,
            v18,
            v22,
            v26,
            v30,
            v34
        }
    end
    return u2
end
function v1.findInFrustum(p37, p38, p39) --[[ Line: 54 ]]
    for _, v40 in ipairs(p37) do
        local v41 = v40[1]
        local v42 = v40[2]
        if p38:Dot(v41) + v42 + p39 * 0.7 <= 0 then
            return false
        end
    end
    return true
end
return v1
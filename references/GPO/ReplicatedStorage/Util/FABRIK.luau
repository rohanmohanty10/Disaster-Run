 

local u1 = {}
function sum(p2)
    local v3 = 0
    for _, v4 in p2 do
        v3 = v3 + v4
    end
    return v3
end
local u5 = Instance.new("Part")
u5.Material = Enum.Material.Plastic
u5.Anchored = true
u5.CanCollide = false
u5.BrickColor = BrickColor.Blue()
local u6 = {}
local u7 = Instance.new("Model", game.Workspace)
function drawline(p8, p9, p10)
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u7
    --]]
    if not u6[p8] then
        u6[p8] = u5:Clone()
        u6[p8].Parent = u7
    end
    local v11 = u6[p8]
    local v12 = p10.magnitude
    v11.Size = Vector3.new(0.2, 0.2, v12)
    u6[p8].CFrame = CFrame.new(p9 + p10 / 2, p9 + p10)
    return u6[p8]
end
function u1.new(p13, p14) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v15 = {
        ["__index"] = u1
    }
    local v16 = setmetatable({}, v15)
    local v17 = {}
    for v18 = 1, #p13 - 1 do
        v17[v18] = (p13[v18] - p13[v18 + 1]).magnitude
    end
    v16.n = #p13
    v16.tolerance = 0.1
    v16.target = p14
    v16.joints = p13
    v16.lengths = v17
    v16.origin = p13[1]
    v16.totallength = sum(v17)
    v16.constrained = false
    v16.left = 1.5707963267948966
    v16.right = 1.5707963267948966
    v16.up = 1.5707963267948966
    v16.down = 1.5707963267948966
    return v16
end
function u1.constrain(p19, u20, p21, p22) --[[ Line: 59 ]]
    local v23 = u20:Dot(p21) / p21.magnitude
    local v24 = v23 * p21.unit
    local v25 = { p22:vectorToWorldSpace(Vector3.FromNormalId(Enum.NormalId.Top)), p22:vectorToWorldSpace(Vector3.FromNormalId(Enum.NormalId.Bottom)) }
    local v26 = { p22:vectorToWorldSpace(Vector3.FromNormalId(Enum.NormalId.Right)), p22:vectorToWorldSpace(Vector3.FromNormalId(Enum.NormalId.Left)) }
    table.sort(v25, function(p27, p28) --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        return (p27 - u20).magnitude < (p28 - u20).magnitude
    end)
    table.sort(v26, function(p29, p30) --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        return (p29 - u20).magnitude < (p30 - u20).magnitude
    end)
    local v31 = v25[1]
    local v32 = v26[1]
    local v33 = u20 - v24
    if v23 < 0 then
        v24 = -v24
    end
    local v34 = v33:Dot(v32)
    local v35 = v33:Dot(v31)
    local v36 = v24.magnitude
    local v37 = p19.left
    local v38 = -(v36 * math.tan(v37))
    local v39 = v24.magnitude
    local v40 = p19.right
    local v41 = v39 * math.tan(v40)
    local v42 = v24.magnitude
    local v43 = p19.up
    local v44 = v42 * math.tan(v43)
    local v45 = v24.magnitude
    local v46 = p19.down
    local v47 = -(v45 * math.tan(v46))
    if v34 >= 0 then
        v38 = v41 or v38
    end
    if v35 >= 0 then
        v47 = v44 or v47
    end
    local v48
    if v34 ^ 2 / v38 ^ 2 + v35 ^ 2 / v47 ^ 2 <= 1 then
        v48 = v23 >= 0
    else
        v48 = false
    end
    if not v48 then
        local v49 = math.atan2(v35, v34)
        local v50 = v38 * math.cos(v49)
        local v51 = v47 * math.sin(v49)
        u20 = (v24 + v32 * v50 + v31 * v51).unit * u20.magnitude
    end
    return u20
end
function u1.backward(p52) --[[ Line: 112 ]]
    p52.joints[p52.n] = p52.target
    for v53 = p52.n - 1, 1, -1 do
        local v54 = p52.joints[v53 + 1] - p52.joints[v53]
        local v55 = p52.lengths[v53] / v54.magnitude
        local v56 = (1 - v55) * p52.joints[v53 + 1] + v55 * p52.joints[v53]
        p52.joints[v53] = v56
    end
end
function u1.forward(p57) --[[ Line: 124 ]]
    p57.joints[1] = p57.origin
    local v58 = (p57.joints[2] - p57.joints[1]).unit
    for v59 = 1, p57.n - 1 do
        local v60 = p57.joints[v59 + 1] - p57.joints[v59]
        local v61 = p57.lengths[v59] / v60.magnitude
        local v62 = CFrame.new(p57.joints[v59], p57.joints[v59] + v58)
        local v63 = (1 - v61) * p57.joints[v59] + v61 * p57.joints[v59 + 1]
        local v64 = p57:constrain(v63 - p57.joints[v59], v58, v62)
        local v65 = p57.joints
        local v66 = v59 + 1
        if p57.constrained then
            v63 = p57.joints[v59] + v64 or v63
        end
        v65[v66] = v63
        v58 = p57.joints[v59 + 1] - p57.joints[v59]
    end
end
function u1.solve(p67) --[[ Line: 141 ]]
    local v68 = (p67.joints[1] - p67.target).magnitude
    if p67.totallength < v68 then
        for v69 = 1, p67.n - 1 do
            local v70 = (p67.target - p67.joints[v69]).magnitude
            local v71 = p67.lengths[v69] / v70
            p67.joints[v69 + 1] = (1 - v71) * p67.joints[v69] + v71 * p67.target
        end
        p67:backward()
        p67:forward()
    else
        local v72 = 0
        local v73 = (p67.joints[p67.n] - p67.target).magnitude
        if v73 < p67.tolerance then
            if v68 then
                v73 = v68
            end
        end
        while p67.tolerance < v73 do
            p67:backward()
            p67:forward()
            v72 = v72 + 1
            if v72 > 10 then
                break
            end
        end
    end
end
return u1
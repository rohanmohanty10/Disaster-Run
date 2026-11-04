 

local u1 = {}
u1.__index = u1
function u1.new(p2, p3) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = u1
    local v5 = setmetatable({}, v4)
    v5.points = p2
    v5.accuracy = p3 or 20
    v5.point_count = 0
    v5.cumulative_lengths = {}
    v5:_recalculate()
    return v5
end
function u1.setPoints(p6, p7) --[[ Line: 48 ]]
    p6.points = p7
    p6.ease_lut = nil
    p6:_recalculate()
end
function u1.getSegmentPoints(p8, p9) --[[ Line: 55 ]]
    if p9 < 1 or p8.point_count - 1 < p9 then
        if p9 <= 0 then
            return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), Vector3.new(0, 0, 0)
        end
        error("attempt to get a non-existent segment at index " .. p9)
    end
    local v10 = (p9 - 1) * 4
    local v11 = p9 - 2
    local v12 = v10 - math.max(v11, 0)
    local v13 = math.max(v12, 1)
    return p8.points[v13], p8.points[v13 + 1], p8.points[v13 + 2], p8.points[v13 + 3]
end
function u1.forSample(p14, p15, p16) --[[ Line: 75 ]]
    local v17 = p14.length // p15
    if v17 ~= 0 then
        for v18 = 0, v17 do
            p16(p14:getPositionArcSpace(v18 / v17), v18)
        end
    end
end
function u1.getPosition(p19, p20) --[[ Line: 88 ]]
    local v21, v22 = p19:getSegmentIndex(p20)
    local v23, v24, v25, v26 = p19:getSegmentPoints(v21)
    return (1 - v22) ^ 3 * v23 + 3 * (1 - v22) ^ 2 * v22 * v24 + 3 * (1 - v22) * v22 ^ 2 * v25 + v22 ^ 3 * v26
end
function u1.getSegmentIndex(p27, p28) --[[ Line: 95 ]]
    local v29 = math.clamp(p28, 0, 1)
    local v30 = p27.point_count - 1
    local v31 = v29 * v30
    local v32 = math.floor(v31) + 1
    local v33 = math.min(v32, v30)
    local v34 = v31 - math.floor(v31)
    return v33, v29 == 1 and 1 or v34
end
function u1.getEasedSegmentIndex(p35, p36) --[[ Line: 112 ]]
    local v37 = p35.point_count - 1
    local v38 = 1
    for v39 = 1, v37 do
        local v40, _, _, v41 = p35:getSegmentPoints(v39)
        local v42 = v40.x
        local v43 = v41.x
        if v42 <= p36 and p36 < v43 then
            return v39, (p36 - v42) / (v43 - v42)
        end
    end
    return v37, v38
end
function u1._getEaseRaw(p44, p45) --[[ Line: 133 ]]
    local v46, v47 = p44:getEasedSegmentIndex(p45)
    local v48, v49, v50, v51 = p44:getSegmentPoints(v46)
    for _ = 1, 5 do
        local v52 = v48.x
        local v53 = v49.x
        local v54 = v50.x
        local v55 = v51.x
        local v56 = (1 - v47) ^ 3 * v52 + 3 * (1 - v47) ^ 2 * v47 * v53 + 3 * (1 - v47) * v47 ^ 2 * v54 + v47 ^ 3 * v55
        local v57 = v48.x
        local v58 = v49.x
        local v59 = v50.x
        local v60 = v51.x
        local v61 = 3 * (1 - v47) ^ 2 * (v58 - v57) + 6 * (1 - v47) * v47 * (v59 - v58) + 3 * v47 ^ 2 * (v60 - v59)
        if v61 == 0 then
            break
        end
        local v62 = (v56 - p45) / v61
        local v63 = v47 - v62
        v47 = v63 < 0 and 0 or (v63 > 1 and 1 or v63)
        if math.abs(v62) < 0.001 then
            break
        end
    end
    return (1 - v47) ^ 3 * v48 + 3 * (1 - v47) ^ 2 * v47 * v49 + 3 * (1 - v47) * v47 ^ 2 * v50 + v47 ^ 3 * v51
end
function u1._buildEaseLUT(p64) --[[ Line: 162 ]]
    local v65 = table.create(65)
    for v66 = 0, 64 do
        v65[v66] = p64:_getEaseRaw(v66 / 64)
    end
    p64.ease_lut = v65
end
function u1.getEase(p67, p68) --[[ Line: 173 ]]
    local v69 = p67.ease_lut
    if not v69 then
        p67:_buildEaseLUT()
        v69 = p67.ease_lut
    end
    local v70 = math.clamp(p68, 0, 1)
    local v71 = v70 * 64
    local v72 = math.floor(v71)
    local v73 = v72 + 1
    local v74 = math.min(v73, 64)
    local v75 = v71 - v72
    local v76 = v69[v72]
    local v77 = v69[v74]
    if v76 and v77 then
        return v76:Lerp(v77, v75)
    else
        return p67:_getEaseRaw(v70)
    end
end
function u1.getPositionArcSpace(p78, p79) --[[ Line: 200 ]]
    if p78.length <= 0 then
        return p78.points[1] or Vector3.new(0, 0, 0)
    else
        local v80 = math.clamp(p79, 0, 1) * p78.cumulative_lengths[p78.accuracy + 1]
        local v81 = p78.accuracy + 1
        local v82 = 1
        local v83 = nil
        while v82 < v81 do
            v83 = v82 + (v81 - v82) // 2
            if p78.cumulative_lengths[v83] < v80 then
                v82 = v83 + 1
            else
                v81 = v83
            end
        end
        if v80 < p78.cumulative_lengths[v83] and v83 > 1 then
            v83 = v83 - 1
        end
        local v84 = p78.cumulative_lengths[v83]
        if v84 == v80 then
            return p78:getPosition((v83 - 1) / p78.accuracy)
        else
            return p78:getPosition((v83 - 1 + (v80 - v84) / (p78.cumulative_lengths[v83 + 1] - v84)) / p78.accuracy)
        end
    end
end
function u1._recalculate(p85) --[[ Line: 236 ]]
    table.clear(p85.cumulative_lengths)
    local v86 = p85.cumulative_lengths
    table.insert(v86, 0)
    local v87 = #p85.points / 3
    p85.point_count = math.ceil(v87)
    local v88 = nil
    local v89 = 0
    for v90 = 1, p85.accuracy do
        local v91 = p85:getPosition(v90 / p85.accuracy)
        local v92 = v91 - (v88 or p85:getPosition(0))
        v89 = v89 + vector.magnitude(v92)
        local v93 = p85.cumulative_lengths
        table.insert(v93, v89)
        v88 = v91
    end
    p85.length = v89
    for v94, v95 in p85.cumulative_lengths do
        p85.cumulative_lengths[v94] = v95 / v89
    end
end
return u1
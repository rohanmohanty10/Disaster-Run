 

local u70 = {
    ["GenerateSeed"] = function(p1) --[[ Line: 12 ]]
        local v2 = p1.Keypoints
        local v3 = math.random()
        local v4 = math.random() >= 0.5
        local v5 = {}
        for v6 = 1, #v2 do
            if v2[v6].Envelope > 0 then
                if v4 == true then
                    v5[v6] = v3 * v2[v6].Envelope
                else
                    v5[v6] = -v3 * v2[v6].Envelope
                end
            end
        end
        return v5
    end,
    ["GenerateSeeds"] = function(p7, p8) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u70
        --]]
        local v9 = {}
        for v10 = 1, p8 do
            v9[v10] = u70.GenerateSeed(p7)
        end
        return v9
    end,
    ["QueryPointsWithTime"] = function(p11, p12, p13) --[[ Line: 38 ]]
        local v14 = math.clamp(p11, 0, 1)
        local v15 = p12.Keypoints
        if #v15 == 1 then
            return v15[1].Value + (p13[1] or 0)
        end
        for v16 = 1, #v15 - 1 do
            local v17 = v15[v16]
            local v18 = v15[v16 + 1]
            if v17.Time <= v14 and v14 <= v18.Time then
                local v19 = (v14 - v17.Time) / (v18.Time - v17.Time)
                local v20 = v17.Value + (p13[v16] or 0)
                return v20 + (v18.Value + (p13[v16 + 1] or 0) - v20) * v19
            end
        end
        return v15[#v15].Value + (p13[#v15] or 0)
    end,
    ["QueryColorPointWithTime"] = function(p21, p22) --[[ Line: 64 ]]
        local v23 = p22.Keypoints
        if #v23 == 0 then
            return Color3.new(1, 1, 1)
        end
        if #v23 == 1 then
            return v23[1].Value
        end
        if p21 <= v23[1].Time then
            return v23[1].Value
        end
        for v24 = 1, #v23 - 1 do
            local v25 = v23[v24]
            local v26 = v23[v24 + 1]
            if v25.Time <= p21 and p21 <= v26.Time then
                local v27 = (p21 - v25.Time) / (v26.Time - v25.Time)
                return v25.Value:Lerp(v26.Value, v27)
            end
        end
        return v23[#v23].Value
    end,
    ["BlendGraphWithTime"] = function(p28, p29, p30, p31) --[[ Line: 108 ]]
        --[[
        Upvalues:
            [1] = u70
        --]]
        local v32 = p31 or 1
        local v33 = v32 < 0 and 0 or (v32 > 1 and 1 or v32)
        local v34 = {}
        local v35 = {}
        for _, v36 in ipairs({ p28, p29 }) do
            for _, v37 in ipairs(v36.Keypoints) do
                if not v34[v37.Time] then
                    v34[v37.Time] = true
                    local v38 = v37.Time
                    table.insert(v35, v38)
                end
            end
        end
        table.sort(v35)
        local v39 = {}
        local v40 = {}
        for _, v41 in ipairs(v35) do
            local v42 = u70.QueryPointsWithTime(v41, p28, {}) or p28.Keypoints[#p28.Keypoints].Value
            local v43 = u70.QueryPointsWithTime(v41, p29, {}) or p29.Keypoints[#p29.Keypoints].Value
            local v44 = NumberSequenceKeypoint.new
            table.insert(v39, v44(v41, v42))
            local v45 = NumberSequenceKeypoint.new
            table.insert(v40, v45(v41, v43))
        end
        local v46 = u70.QueryPointsWithTime(v33, p30, {}) or 1
        local v47 = {}
        for v48, v49 in ipairs(v39) do
            local v50 = v49.Time
            local v51 = v49.Value
            local v52 = v51 + (v40[v48].Value - v51) * v46
            local v53 = NumberSequenceKeypoint.new
            table.insert(v47, v53(v50, v52))
        end
        return NumberSequence.new(v47)
    end,
    ["BlendColorGraphWithTime"] = function(p54, p55, p56, p57) --[[ Line: 147 ]]
        --[[
        Upvalues:
            [1] = u70
        --]]
        local v58 = p57 or 1
        local v59 = v58 < 0 and 0 or (v58 > 1 and 1 or v58)
        local v60 = {}
        local v61 = {}
        for _, v62 in ipairs({ p54, p55 }) do
            for _, v63 in ipairs(v62.Keypoints) do
                if not v60[v63.Time] then
                    v60[v63.Time] = true
                    local v64 = v63.Time
                    table.insert(v61, v64)
                end
            end
        end
        table.sort(v61)
        local v65 = u70.QueryPointsWithTime(v59, p56, {}) or 1
        local v66 = {}
        for _, v67 in ipairs(v61) do
            local v68 = u70.QueryColorPointWithTime(v67, p54):Lerp(u70.QueryColorPointWithTime(v67, p55), v65)
            local v69 = ColorSequenceKeypoint.new
            table.insert(v66, v69(v67, v68))
        end
        return ColorSequence.new(v66)
    end
}
return u70
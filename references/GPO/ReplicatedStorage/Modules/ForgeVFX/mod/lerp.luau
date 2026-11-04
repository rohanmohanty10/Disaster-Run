 

local u1 = require("./color/Oklab")
local u61 = {
    ["number"] = function(p2, p3, p4) --[[ Name: number, Line 7 ]]
        return p2 + (p3 - p2) * p4
    end,
    ["Vector3"] = function(p5, p6, p7) --[[ Name: Vector3, Line 11 ]]
        return p5:Lerp(p6, p7)
    end,
    ["Vector2"] = function(p8, p9, p10) --[[ Name: Vector2, Line 15 ]]
        return p8:Lerp(p9, p10)
    end,
    ["CFrame"] = function(p11, p12, p13) --[[ Name: CFrame, Line 19 ]]
        return p11:Lerp(p12, p13)
    end,
    ["UDim2"] = function(p14, p15, p16) --[[ Name: UDim2, Line 23 ]]
        return p14:Lerp(p15, p16)
    end,
    ["UDim"] = function(p17, p18, p19) --[[ Name: UDim, Line 27 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        return UDim.new(u61.number(p17.Scale, p18.Scale, p19), u61.number(p17.Offset, p18.Offset, p19))
    end,
    ["NumberRange"] = function(p20, p21, p22) --[[ Name: NumberRange, Line 35 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        return NumberRange.new(u61.number(p20.Min, p21.Min, p22), u61.number(p20.Max, p21.Max, p22))
    end,
    ["Color3"] = function(p23, p24, p25) --[[ Name: Color3, Line 43 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.toSRGB(u1.fromSRGB(p23):Lerp(u1.fromSRGB(p24), p25))
    end,
    ["PhysicalProperties"] = function(p26, p27, p28) --[[ Name: PhysicalProperties, Line 50 ]]
        --[[
        Upvalues:
            [1] = u61
        --]]
        return PhysicalProperties.new(u61.number(p26.Density, p27.Density, p28), u61.number(p26.Friction, p27.Friction, p28), u61.number(p26.Elasticity, p27.Elasticity, p28), u61.number(p26.FrictionWeight, p27.FrictionWeight, p28), u61.number(p26.ElasticityWeight, p27.ElasticityWeight, p28))
    end,
    ["Rect"] = function(p29, p30, p31) --[[ Name: Rect, Line 60 ]]
        return Rect.new(p29.Min:Lerp(p30.Min, p31), p29.Max:Lerp(p30.Max, p31))
    end,
    ["NumberSequence"] = function(p32, p33, p34) --[[ Name: NumberSequence, Line 65 ]]
        local v35 = {}
        local v36 = 0
        local v37 = {}
        for _, v38 in p32.Keypoints do
            local v39 = nil
            local v40 = nil
            for _, v41 in p33.Keypoints do
                if v41.Time == v38.Time then
                    v39 = v41
                    v40 = v39
                    local v42 = v39
                    v39 = v40
                    v42 = v40
                    break
                end
                if v41.Time < v38.Time and (v39 == nil or v41.Time > v39.Time) then
                    v39 = v41
                elseif v41.Time > v38.Time and (v40 == nil or v41.Time < v40.Time) then
                    v40 = v41
                end
            end
            local v43, v44
            if v40 == v39 then
                v43 = v40.Value
                v44 = v40.Envelope
            else
                local v45 = (v38.Time - v39.Time) / (v40.Time - v39.Time)
                v43 = (v40.Value - v39.Value) * v45 + v39.Value
                v44 = (v40.Envelope - v39.Envelope) * v45 + v39.Envelope
            end
            v36 = v36 + 1
            v37[v36] = NumberSequenceKeypoint.new(v38.Time, (v43 - v38.Value) * p34 + v38.Value, (v44 - v38.Envelope) * p34 + v38.Envelope)
            v35[v38.Time] = true
        end
        for _, v46 in p33.Keypoints do
            if not v35[v46.Time] then
                local v47 = nil
                local v48 = nil
                for _, v49 in p32.Keypoints do
                    if v49.Time == v46.Time then
                        v47 = v49
                        v48 = v47
                        local v50 = v47
                        v47 = v48
                        v50 = v48
                        break
                    end
                    if v49.Time < v46.Time and (v47 == nil or v49.Time > v47.Time) then
                        v47 = v49
                    elseif v49.Time > v46.Time and (v48 == nil or v49.Time < v48.Time) then
                        v48 = v49
                    end
                end
                local v51, v52
                if v48 == v47 then
                    v51 = v48.Value
                    v52 = v48.Envelope
                else
                    local v53 = (v46.Time - v47.Time) / (v48.Time - v47.Time)
                    v51 = (v48.Value - v47.Value) * v53 + v47.Value
                    v52 = (v48.Envelope - v47.Envelope) * v53 + v47.Envelope
                end
                v36 = v36 + 1
                v37[v36] = NumberSequenceKeypoint.new(v46.Time, (v46.Value - v51) * p34 + v51, (v46.Envelope - v52) * p34 + v52)
            end
        end
        table.sort(v37, function(p54, p55) --[[ Line: 136 ]]
            return p54.Time < p55.Time
        end)
        local v56
        if #v37 > 20 then
            local v57 = (#v37 - 1) / 19
            v56 = {}
            for v58 = 0, 19 do
                local v59 = v58 * v57 + 1
                local v60 = v37[math.floor(v59)]
                table.insert(v56, v60)
            end
            if v56[#v56].Time < v37[#v37].Time then
                v56[#v56] = v37[#v37]
            end
        else
            v56 = v37
        end
        return NumberSequence.new(v56)
    end
}
local function u70(p62, p63) --[[ Line: 161 ]]
    local v64 = p62.Keypoints
    if p63 <= v64[1].Time then
        return v64[1].Value
    end
    if v64[#v64].Time <= p63 then
        return v64[#v64].Value
    end
    local v65 = nil
    local v66 = nil
    for v67 = 1, #v64 do
        local v68 = v64[v67]
        if v68.Time == p63 then
            return v68.Value
        end
        if v68.Time < p63 then
            v65 = v68
        elseif p63 < v68.Time then
            v66 = v68
            break
        end
    end
    local v69 = (p63 - v65.Time) / (v66.Time - v65.Time)
    return v65.Value:Lerp(v66.Value, v69)
end
function u61.ColorSequence(p71, p72, p73) --[[ Line: 192 ]]
    --[[
    Upvalues:
        [1] = u70
        [2] = u1
    --]]
    local v74 = {}
    for _, v75 in ipairs(p72.Keypoints) do
        local v76 = u70(p71, v75.Time)
        local v77 = u1.toSRGB(u1.fromSRGB(v76:Lerp(v75.Value, p73)))
        local v78 = ColorSequenceKeypoint.new
        local v79 = v75.Time
        table.insert(v74, v78(v79, v77))
    end
    return ColorSequence.new(v74)
end
function u61.Other(p80, p81, p82) --[[ Line: 206 ]]
    if p82 < 0.5 then
        p81 = p80 or p81
    end
    return p81
end
return u61
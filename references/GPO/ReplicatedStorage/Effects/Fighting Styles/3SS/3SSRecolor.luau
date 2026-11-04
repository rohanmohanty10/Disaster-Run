 

local u1 = {}
local function u9(p2, p3, p4, _) --[[ Line: 18 ]]
    local v5 = {}
    for _, v6 in ipairs(p2.Keypoints) do
        if p4(v6.Value) then
            local v7 = ColorSequenceKeypoint.new
            local v8 = v6.Time
            table.insert(v5, v7(v8, p3))
        else
            table.insert(v5, v6)
        end
    end
    return ColorSequence.new(v5)
end
local function u17(p10, u11, u12, u13) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local function v15(p14) --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u11
            [3] = u9
            [4] = u13
        --]]
        if not p14:GetAttribute("bypassRecolor") then
            if p14:IsA("BasePart") or p14:IsA("Light") then
                if u12(p14.Color) then
                    p14.Color = u11
                    return
                end
            else
                if p14:IsA("ParticleEmitter") or (p14:IsA("Beam") or p14:IsA("Trail")) then
                    p14.Color = u9(p14.Color, u11, u12, u13)
                    return
                end
                if p14:IsA("Highlight") then
                    if u12(p14.FillColor) then
                        p14.FillColor = u11
                    end
                    if u12(p14.OutlineColor) then
                        p14.OutlineColor = u11
                    end
                end
            end
        end
    end
    v15(p10)
    for _, v16 in ipairs(p10:GetDescendants()) do
        v15(v16)
    end
end
function u1.start(_, p18, p19, p20, p21) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u17
    --]]
    if p19 == nil then
        return
    else
        local v22 = p21 or Color3.fromRGB(115, 204, 255)
        local v23 = p20 == nil and "isGreen" or p20
        if u1[v23] then
            v23 = u1[v23]
        end
        if typeof(p18) == "Instance" then
            u17(p18, p19, v23, v22)
        elseif typeof(p18) == "table" then
            for v24 = 1, #p18 do
                u17(p18[v24], p19, v23, v22)
            end
        end
    end
end
function u1.isBlue(p25) --[[ Line: 91 ]]
    local v26 = 0.299 * p25.R + 0.587 * p25.G + 0.114 * p25.B
    local v27
    if p25.B > p25.R * 1.3 and p25.B > p25.G * 1.3 then
        v27 = v26 > 0.1
    else
        v27 = false
    end
    return v27
end
function u1.isGreen(p28) --[[ Line: 100 ]]
    local v29 = 0.299 * p28.R + 0.587 * p28.G + 0.114 * p28.B
    local v30
    if p28.G > p28.R * 1.3 and p28.G > p28.B * 1.3 then
        v30 = v29 > 0.1
    else
        v30 = false
    end
    return v30
end
function u1.isRed(p31) --[[ Line: 108 ]]
    local v32 = 0.299 * p31.R + 0.587 * p31.G + 0.114 * p31.B
    local v33
    if p31.R > p31.G * 1.3 and p31.R > p31.B * 1.3 then
        v33 = v32 > 0.1
    else
        v33 = false
    end
    return v33
end
return u1
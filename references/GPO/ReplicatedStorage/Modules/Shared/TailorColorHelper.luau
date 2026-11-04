 

local u1 = {}
local u2 = {
    ["ParticleEmitter"] = true,
    ["Trail"] = true,
    ["Beam"] = true
}
local u3 = {
    ["SurfaceAppearance"] = true,
    ["PointLight"] = true,
    ["SpotLight"] = true,
    ["SurfaceLight"] = true,
    ["Highlight"] = true,
    ["SpecialMesh"] = true
}
local function u13(p4) --[[ Line: 27 ]]
    local v5 = p4.Keypoints
    local v6 = 0
    local v7 = 0
    local v8 = 0
    local v9 = 0
    for v10 = 1, #v5 do
        local v11 = v5[v10]
        local v12
        if v10 == 1 then
            v12 = #v5 <= 1 and 1 or (v5[v10 + 1].Time - v11.Time) / 2
        elseif v10 == #v5 then
            v12 = (v11.Time - v5[v10 - 1].Time) / 2
        else
            v12 = (v11.Time - v5[v10 - 1].Time + (v5[v10 + 1].Time - v11.Time)) / 2
        end
        v6 = v6 + v11.Value.R * v12
        v7 = v7 + v11.Value.G * v12
        v8 = v8 + v11.Value.B * v12
        v9 = v9 + v12
    end
    if v9 > 0 then
        return Color3.new(v6 / v9, v7 / v9, v8 / v9)
    else
        return v5[1].Value
    end
end
function u1.returnColor(p14) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    if typeof(p14) == "Color3" then
        return p14
    else
        return u13(p14)
    end
end
function u1.getColor(p15) --[[ Line: 75 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    if p15:IsA("Decal") or p15:IsA("Texture") then
        local v16 = p15.Color3
        local v17 = p15:GetAttribute("_GlowIntensity")
        if v17 == nil then
            local v18 = p15:GetAttribute("OrgDefaultColor") or v16
            local v19 = v18.R
            local v20 = v18.G
            local v21 = v18.B
            local v22 = math.max(v19, v20, v21)
            v17 = v22 <= 1 and 1 or v22
            p15:SetAttribute("_GlowIntensity", v17)
        end
        if v17 > 1 then
            v16 = Color3.new(v16.R / v17, v16.G / v17, v16.B / v17)
        end
        return v16
    elseif p15:IsA("Highlight") then
        return p15.FillColor
    elseif p15:IsA("SpecialMesh") then
        local v23 = p15.VertexColor
        return Color3.new(v23.X, v23.Y, v23.Z)
    elseif u2[p15.ClassName] then
        return u1.returnColor(p15.Color)
    elseif p15:IsA("SurfaceAppearance") then
        return p15.Color
    else
        return p15.Color
    end
end
function u1.setColor(p24, p25) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p24.ClassName] then
        p24.Color = ColorSequence.new(p25)
        return
    elseif p24:IsA("Decal") or p24:IsA("Texture") then
        local v26 = p24:GetAttribute("_GlowIntensity")
        if v26 == nil then
            local v27 = p24:GetAttribute("OrgDefaultColor") or p24.Color3
            if v27 then
                local v28 = v27.R
                local v29 = v27.G
                local v30 = v27.B
                v26 = math.max(v28, v29, v30)
            else
                v26 = 1
            end
            p24:SetAttribute("_GlowIntensity", v26)
        end
        if v26 > 1 then
            p25 = Color3.new(p25.R * v26, p25.G * v26, p25.B * v26)
        end
        p24.Color3 = p25
        return
    elseif p24:IsA("Highlight") then
        p24.FillColor = p25
        return
    elseif p24:IsA("SpecialMesh") then
        local v31 = p25.R
        local v32 = p25.G
        local v33 = p25.B
        p24.VertexColor = Vector3.new(v31, v32, v33)
    else
        p24.Color = p25
    end
end
function u1.getHighlightColor(p34, p35) --[[ Line: 146 ]]
    if p35 == "OutlineColor" then
        return p34.OutlineColor
    else
        return p34.FillColor
    end
end
function u1.setHighlightColor(p36, p37, p38) --[[ Line: 154 ]]
    if p37 == "OutlineColor" then
        p36.OutlineColor = p38
    else
        p36.FillColor = p38
    end
end
function u1.getSurfaceAppearanceColor(p39, p40) --[[ Line: 163 ]]
    if p40 == "EmissiveTint" then
        return p39.EmissiveTint
    else
        return p39.Color
    end
end
function u1.setSurfaceAppearanceColor(p41, p42, p43) --[[ Line: 171 ]]
    if p42 == "EmissiveTint" then
        p41.EmissiveTint = p43
    else
        p41.Color = p43
    end
end
function u1.hasNoTransparency(p44) --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    return u3[p44] == true
end
return u1
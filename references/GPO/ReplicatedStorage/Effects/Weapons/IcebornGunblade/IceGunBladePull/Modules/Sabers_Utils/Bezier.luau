 

local u1 = {}
u1.__index = u1
function B(p2, p3, p4)
    local function u6(p5) --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u6
        --]]
        return p5 == 0 and 1 or p5 * u6(p5 - 1)
    end
    local v7 = p2 == 0 and 1 or p2 * u6(p2 - 1)
    local v8 = p3 == 0 and 1 or p3 * u6(p3 - 1)
    local v9 = p2 - p3
    return v7 / (v8 * (v9 == 0 and 1 or v9 * u6(v9 - 1))) * p4 ^ p3 * (1 - p4) ^ (p2 - p3)
end
function u1.new(...) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v10 = u1
    local v11 = setmetatable({}, v10)
    v11.Points = {}
    v11.LengthIterations = 1000
    v11.LengthIndeces = {}
    v11.Length = 0
    v11._connections = {}
    for _, v12 in pairs({ ... }) do
        if typeof(v12) == "Vector3" or typeof(v12) == "Instance" and v12:IsA("BasePart") then
            v11:AddBezierPoint(v12)
        else
            error("The Bezier.new() constructor only takes in Vector3s and BaseParts as inputs!")
        end
    end
    return v11
end
function u1.AddBezierPoint(u13, p14, p15) --[[ Line: 70 ]]
    if p14 and (typeof(p14) == "Instance" and p14:IsA("BasePart")) or typeof(p14) == "Vector3" then
        local u16 = {
            ["Type"] = typeof(p14) == "Vector3" and "StaicPoint" or "BasePartPoint",
            ["Point"] = p14
        }
        if u16.Type == "BasePartPoint" then
            local u18 = p14.Changed:Connect(function(p17) --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if p17 == "Position" then
                    u13:UpdateLength()
                end
            end)
            local v21 = p14.AncestryChanged:Connect(function(_, p19) --[[ Line: 91 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                    [3] = u18
                --]]
                if p19 == nil then
                    local v20 = table.find(u13.Points, u16)
                    if v20 then
                        table.remove(u13.Points, v20)
                    end
                    u18:Disconnect()
                    u18:Disconnect()
                end
            end)
            if not u13._connections[p14] then
                u13._connections[p14] = {}
            end
            local v22 = u13._connections[p14]
            local v23 = u18
            table.insert(v22, v23)
            local v24 = u13._connections[p14]
            table.insert(v24, v21)
        end
        if p15 and type(p15) == "number" then
            local v25 = u13.Points
            table.insert(v25, p15, u16)
        elseif p15 then
            if type(p15) ~= "number" then
                error("Bezier:AddBezierPoint() only accepts an integer as the second argument!")
            end
        else
            local v26 = u13.Points
            table.insert(v26, u16)
        end
        u13:UpdateLength()
    else
        error("Bezier:AddBezierPoint() only accepts a Vector3 or BasePart as the first argument!")
    end
end
function u1.ChangeBezierPoint(p27, p28, p29) --[[ Line: 137 ]]
    if type(p28) ~= "number" then
        error("Bezier:ChangeBezierPoint() only accepts a number index as the first argument!")
    end
    if p29 and (typeof(p29) == "Instance" and p29:IsA("BasePart")) or typeof(p29) == "Vector3" then
        local v30 = p27.Points[p28]
        if v30 then
            v30.Type = typeof(p29) == "Vector3" and "StaicPoint" or "BasePartPoint"
            v30.Point = p29
            p27:UpdateLength()
        else
            error("Did not find BezierPoint at index " .. tostring(p28))
        end
    else
        error("Bezier:ChangeBezierPoint() only accepts a Vector3 or BasePart as the second argument!")
        return
    end
end
function u1.GetAllPoints(p31) --[[ Line: 171 ]]
    local v32 = {}
    for v33 = 1, #p31.Points do
        table.insert(v32, p31:GetPoint(v33))
    end
    return v32
end
function u1.GetPoint(p34, p35) --[[ Line: 189 ]]
    local v36 = p34.Points
    if v36[p35] then
        local v37 = v36[p35].Point
        return typeof(v37) == "Vector3" and v36[p35].Point or v36[p35].Point.Position
    end
    error("Did not find a BezierPoint at index " .. tostring(p35) .. "!")
end
function u1.RemoveBezierPoint(p38, p39) --[[ Line: 202 ]]
    if p38.Points[p39] then
        local v40 = table.remove(p38.Points, p39)
        local v41 = v40.Point
        if typeof(v41) == "Instance" and v40.Point:IsA("BasePart") then
            for _, v42 in pairs(p38._connections[v40.Point]) do
                if v42.Connected then
                    v42:Disconnect()
                end
            end
            p38._connections[v40.Point] = nil
        end
        p38:UpdateLength()
    end
end
function u1.UpdateLength(p43) --[[ Line: 225 ]]
    local v44 = p43:GetAllPoints()
    local v45 = p43.LengthIterations
    if #v44 < 2 then
        return 0, {
            { 0, 0, 0 },
            { 0, 0, 0 }
        }
    end
    local v46 = 0
    local v47 = {}
    for v48 = 1, v45 do
        local v49 = p43:CalculateDerivativeAt((v48 - 1) / (v45 - 1))
        v46 = v46 + v49.Magnitude * (1 / v45)
        local v50 = { (v48 - 1) / (v45 - 1), v46, v49 }
        table.insert(v47, v50)
    end
    p43.Length = v46
    p43.LengthIndeces = v47
end
function u1.CalculatePositionAt(p51, p52) --[[ Line: 251 ]]
    if type(p52) ~= "number" then
        error("Bezier:CalculatePositionAt() only accepts a number, got " .. tostring(p52) .. "!")
    end
    if #p51.Points > 0 then
        local v53 = p51:GetAllPoints()
        local v54 = #v53
        local v55 = Vector3.new()
        for v56 = 1, v54 do
            local v57 = v53[v56]
            v55 = v55 + B(v54 - 1, v56 - 1, p52) * v57
        end
        return v55
    end
    error("Bezier:CalculatePositionAt() only works if there is at least 1 BezierPoint!")
end
function u1.CalculatePositionRelativeToLength(p58, p59) --[[ Line: 291 ]]
    if type(p59) ~= "number" then
        error("Bezier:CalculatePositionRelativeToLength() only accepts a number, got " .. tostring(p59) .. "!")
    end
    if #p58.Points <= 0 then
        error("Bezier:CalculatePositionRelativeToLength() only works if there is at least 1 BezierPoint!")
        return
    end
    local v60 = p58.Length
    local v61 = p58.LengthIndeces
    local _ = p58.LengthIterations
    if #p58:GetAllPoints() <= 1 then
        return p58:CalculatePositionAt(0)
    end
    local v62 = v60 * p59
    local v63 = nil
    local v64 = nil
    for v65, v66 in ipairs(v61) do
        if v62 - v66[2] <= 0 or v65 == #v61 then
            v64 = v66
            v63 = v65
            break
        end
    end
    local v67, v68
    if v61[v63 - 1] then
        v67 = p58:CalculatePositionAt(v61[v63 - 1][1])
        v68 = p58:CalculatePositionAt(v64[1])
    else
        v67 = p58:CalculatePositionAt(v64[1])
        v68 = p58:CalculatePositionAt(v61[v63 + 1][1])
    end
    local v69 = (v64[2] - v62) / (v68 - v67).Magnitude
    return v67 + (v68 - v67) * (1 - v69)
end
function u1.CalculateDerivativeAt(p70, p71) --[[ Line: 357 ]]
    if type(p71) ~= "number" then
        error("Bezier:CalculateDerivativeAt() only accepts a number, got " .. tostring(p71) .. "!")
    end
    if #p70.Points > 1 then
        local v72 = p70:GetAllPoints()
        local v73 = #v72
        local _ = v73 - 1
        local v74 = Vector3.new()
        for v75 = 1, v73 - 1 do
            local v76 = v72[v75 + 1]
            local v77 = v72[v75]
            local v78 = (v73 - 1) * (v76 - v77)
            v74 = v74 + B(v73 - 2, v75 - 1, p71) * v78
        end
        return v74
    end
    error("Bezier:CalculateDerivativeAt() only works if there are at least 2 BezierPoints!")
end
function u1.CalculateDerivativeRelativeToLength(p79, p80) --[[ Line: 400 ]]
    if type(p80) ~= "number" then
        error("Bezier:CalculateDerivativeRelativeToLength() only accepts a number, got " .. tostring(p80) .. "!")
    end
    if #p79.Points <= 1 then
        error("Bezier:CalculateDerivativeRelativeToLength() only works if there are at least 2 BezierPoints!")
        return
    end
    local v81 = p79.Length
    local v82 = p79.LengthIndeces
    local _ = p79.LengthIterations
    p79:GetAllPoints()
    local v83 = v81 * p80
    local v84 = nil
    local v85 = nil
    for v86, v87 in ipairs(v82) do
        if v83 - v87[2] <= 0 or v86 == #v82 then
            v85 = v87
            v84 = v86
            break
        end
    end
    local v88, v89
    if v82[v84 - 1] then
        v88 = p79:CalculateDerivativeAt(v82[v84 - 1][1])
        v89 = p79:CalculateDerivativeAt(v85[1])
    else
        v88 = p79:CalculateDerivativeAt(v85[1])
        v89 = p79:CalculateDerivativeAt(v82[v84 + 1][1])
    end
    local v90 = (v85[2] - v83) / (v89 - v88).Magnitude
    return v88 + (v89 - v88) * (1 - v90)
end
function u1.CreateVector3Tween(u91, u92, u93, p94, u95) --[[ Line: 458 ]]
    if #u91.Points == 0 then
        error("Bezier:CreateVector3Tween() only works if there is at least 1 BezierPoint in the Bezier!")
    end
    if typeof(u92) ~= "Instance" and typeof(u92) ~= "table" then
        error("Bezier:CreateVector3Tween() requires an Instance or a table as the first argument!")
    end
    if typeof(p94) ~= "TweenInfo" then
        error("Bezier:CreateVector3Tween() requires a TweenInfo object as the third argument!")
    end
    local v100, v101 = pcall(function() --[[ Line: 476 ]]
        --[[
        Upvalues:
            [1] = u93
            [2] = u92
        --]]
        local v96 = true
        for _, v97 in pairs(u93) do
            local v98 = u92[v97]
            if typeof(v98) ~= "Vector3" then
                local v99 = u92[v97]
                if typeof(v99) ~= "nil" then
                    return false
                end
            end
        end
        return v96
    end)
    if v100 and v101 then
        local v102 = game:GetService("TweenService")
        local u103 = Instance.new("NumberValue")
        local u104 = v102:Create(u103, p94, {
            ["Value"] = 1
        })
        local u105 = nil
        u104.Changed:Connect(function(p106) --[[ Line: 493 ]]
            --[[
            Upvalues:
                [1] = u104
                [2] = u105
                [3] = u103
                [4] = u93
                [5] = u92
                [6] = u95
                [7] = u91
            --]]
            if p106 == "PlaybackState" then
                if u104.PlaybackState == Enum.PlaybackState.Playing then
                    u105 = u103.Changed:Connect(function(p107) --[[ Line: 497 ]]
                        --[[
                        Upvalues:
                            [1] = u93
                            [2] = u92
                            [3] = u95
                            [4] = u91
                        --]]
                        for _, v108 in pairs(u93) do
                            u92[v108] = u95 and u91:CalculatePositionRelativeToLength(p107) or u91:CalculatePositionAt(p107)
                        end
                    end)
                    return
                end
                if u105 then
                    u105:Disconnect()
                    u105 = nil
                end
            end
        end)
        return u104
    end
    error("Bezier:CreateVector3Tween() requires a matching property table with Vector3 or nil property names for the object as the second argument!")
end
function u1.CreateCFrameTween(u109, u110, u111, p112, u113) --[[ Line: 519 ]]
    if #u109.Points <= 1 then
        error("Bezier:CreateVector3Tween() only works if there are at least 2 BezierPoints in the Bezier!")
    end
    if typeof(u110) ~= "Instance" and typeof(u110) ~= "table" then
        error("Bezier:CreateCFrameTween() requires an Instance or a table as the first argument!")
    end
    if typeof(p112) ~= "TweenInfo" then
        error("Bezier:CreateCFrameTween() requires a TweenInfo object as the third argument!")
    end
    local v118, v119 = pcall(function() --[[ Line: 537 ]]
        --[[
        Upvalues:
            [1] = u111
            [2] = u110
        --]]
        local v114 = true
        for _, v115 in pairs(u111) do
            local v116 = u110[v115]
            if typeof(v116) ~= "CFrame" then
                local v117 = u110[v115]
                if typeof(v117) ~= "nil" then
                    return false
                end
            end
        end
        return v114
    end)
    if v118 and v119 then
        local v120 = game:GetService("TweenService")
        local u121 = Instance.new("NumberValue")
        local u122 = v120:Create(u121, p112, {
            ["Value"] = 1
        })
        local u123 = nil
        u122.Changed:Connect(function(p124) --[[ Line: 554 ]]
            --[[
            Upvalues:
                [1] = u122
                [2] = u123
                [3] = u121
                [4] = u111
                [5] = u113
                [6] = u109
                [7] = u110
            --]]
            if p124 == "PlaybackState" then
                if u122.PlaybackState == Enum.PlaybackState.Playing then
                    u123 = u121.Changed:Connect(function(p125) --[[ Line: 558 ]]
                        --[[
                        Upvalues:
                            [1] = u111
                            [2] = u113
                            [3] = u109
                            [4] = u110
                        --]]
                        for _, v126 in pairs(u111) do
                            local v127 = u113 and u109:CalculatePositionRelativeToLength(p125) or u109:CalculatePositionAt(p125)
                            local v128 = u113 and u109:CalculateDerivativeRelativeToLength(p125) or u109:CalculateDerivativeAt(p125)
                            u110[v126] = CFrame.new(v127, v127 + v128)
                        end
                    end)
                    return
                end
                if u123 then
                    u123:Disconnect()
                    u123 = nil
                end
            end
        end)
        return u122
    end
    error("Bezier:CreateCFrameTween() requires a matching property table with CFrame or nil property names for the object as the second argument!")
end
return u1
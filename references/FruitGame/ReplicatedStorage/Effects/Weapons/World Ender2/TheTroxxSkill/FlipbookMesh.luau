 

local u1 = game:GetService("RunService")
return {
    ["Play"] = function(_, p2) --[[ Name: Play, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.Model
        local u4 = p2.Speed or 0.1
        local u5 = p2.Looped == nil and true or p2.Looped
        local u6 = {}
        local u7 = {}
        local v8 = {}
        for _, v9 in pairs(v3:GetChildren()) do
            if v9:IsA("Beam") then
                table.insert(u6, v9)
                u7[v9] = v9.Transparency
                local v10 = string.match
                local v11 = v9.Name
                local v12 = tonumber(v10(v11, "%d+$"))
                if v12 then
                    table.insert(v8, v12)
                end
            end
        end
        table.sort(v8)
        if #u6 == 0 then
            warn("No beams found in parent")
        else
            table.sort(u6, function(p13, p14) --[[ Line: 38 ]]
                local v15 = string.match
                local v16 = p13.Name
                local v17 = tonumber(v15(v16, "%d+$"))
                local v18 = string.match
                local v19 = p14.Name
                return v17 < tonumber(v18(v19, "%d+$"))
            end)
            local u20 = 1
            for _, v21 in ipairs(u6) do
                v21.Enabled = true
                v21.Transparency = NumberSequence.new(1)
            end
            local u22 = {}
            local function u37(p23, p24, p25) --[[ Line: 54 ]]
                local v26 = p23.Keypoints
                local v27 = p24.Keypoints
                local v28 = #v26
                local v29 = #v27
                local v30 = {}
                for v31 = 1, math.max(v28, v29) do
                    local v32 = v26[v31] or v26[#v26]
                    local v33 = v27[v31] or v27[#v27]
                    local v34 = v32.Time + (v33.Time - v32.Time) * p25
                    local v35 = v32.Value + (v33.Value - v32.Value) * p25
                    local v36 = NumberSequenceKeypoint.new
                    table.insert(v30, v36(v34, v35))
                end
                return NumberSequence.new(v30)
            end
            local function u48(p38, p39) --[[ Line: 72 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u6
                    [3] = u7
                    [4] = u1
                    [5] = u4
                    [6] = u37
                --]]
                if u22[p38] then
                    task.cancel(u22[p38])
                end
                local u40 = u6[p38]
                if u40 then
                    local u41 = u40.Transparency
                    local u42
                    if p39 == 0 then
                        u42 = u7[u40]
                    else
                        u42 = NumberSequence.new(1)
                    end
                    u22[p38] = task.spawn(function() --[[ Line: 89 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u4
                            [3] = u40
                            [4] = u37
                            [5] = u41
                            [6] = u42
                        --]]
                        local u43 = 0
                        local u44 = nil
                        u44 = u1.Heartbeat:Connect(function(p45) --[[ Line: 93 ]]
                            --[[
                            Upvalues:
                                [1] = u43
                                [2] = u4
                                [3] = u40
                                [4] = u37
                                [5] = u41
                                [6] = u42
                                [7] = u44
                            --]]
                            u43 = u43 + p45
                            local v46 = u43 / u4
                            local v47 = math.min(v46, 1)
                            u40.Transparency = u37(u41, u42, v47)
                            if v47 >= 1 then
                                u44:Disconnect()
                            end
                        end)
                    end)
                end
            end
            local u69 = task.spawn(function() --[[ Line: 106 ]]
                --[[
                Upvalues:
                    [1] = u20
                    [2] = u22
                    [3] = u6
                    [4] = u7
                    [5] = u1
                    [6] = u4
                    [7] = u37
                    [8] = u5
                    [9] = u48
                --]]
                local v49 = u20
                if u22[v49] then
                    task.cancel(u22[v49])
                end
                local u50 = u6[v49]
                if u50 then
                    local u51 = u50.Transparency
                    local u52 = u7[u50]
                    u22[v49] = task.spawn(function() --[[ Line: 89 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u4
                            [3] = u50
                            [4] = u37
                            [5] = u51
                            [6] = u52
                        --]]
                        local u53 = 0
                        local u54 = nil
                        u54 = u1.Heartbeat:Connect(function(p55) --[[ Line: 93 ]]
                            --[[
                            Upvalues:
                                [1] = u53
                                [2] = u4
                                [3] = u50
                                [4] = u37
                                [5] = u51
                                [6] = u52
                                [7] = u54
                            --]]
                            u53 = u53 + p55
                            local v56 = u53 / u4
                            local v57 = math.min(v56, 1)
                            u50.Transparency = u37(u51, u52, v57)
                            if v57 >= 1 then
                                u54:Disconnect()
                            end
                        end)
                    end)
                end
                while true do
                    task.wait(u4)
                    local v58 = u20
                    u20 = u20 + 1
                    if u20 > #u6 then
                        if not u5 then
                            u48(v58, 1)
                            task.wait(u4)
                            for _, v59 in ipairs(u6) do
                                v59.Enabled = false
                                v59.Transparency = NumberSequence.new(1)
                            end
                            return
                        end
                        u20 = 1
                    end
                    u48(v58, 1)
                    local v60 = u20
                    if u22[v60] then
                        task.cancel(u22[v60])
                    end
                    local u61 = u6[v60]
                    if u61 then
                        local u62 = u61.Transparency
                        local u63 = u7[u61]
                        u22[v60] = task.spawn(function() --[[ Line: 89 ]]
                            --[[
                            Upvalues:
                                [1] = u1
                                [2] = u4
                                [3] = u61
                                [4] = u37
                                [5] = u62
                                [6] = u63
                            --]]
                            local u64 = 0
                            local u65 = nil
                            u65 = u1.Heartbeat:Connect(function(p66) --[[ Line: 93 ]]
                                --[[
                                Upvalues:
                                    [1] = u64
                                    [2] = u4
                                    [3] = u61
                                    [4] = u37
                                    [5] = u62
                                    [6] = u63
                                    [7] = u65
                                --]]
                                u64 = u64 + p66
                                local v67 = u64 / u4
                                local v68 = math.min(v67, 1)
                                u61.Transparency = u37(u62, u63, v68)
                                if v68 >= 1 then
                                    u65:Disconnect()
                                end
                            end)
                        end)
                    end
                end
            end)
            v3.Destroying:Connect(function() --[[ Line: 135 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u69
                --]]
                for _, v70 in pairs(u22) do
                    task.cancel(v70)
                end
                task.cancel(u69)
            end)
        end
    end
}
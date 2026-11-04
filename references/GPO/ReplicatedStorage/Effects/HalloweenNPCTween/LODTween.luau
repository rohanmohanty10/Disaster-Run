 

local u8 = {
    ["ActiveTweens"] = {},
    ["LastUpdateTime"] = {},
    ["AddTween"] = function(_, p1, p2, p3, p4, p5) --[[ Name: AddTween, Line 17 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if p1 ~= nil then
            local v6 = p1.CFrame
            local v7 = tick()
            u8.ActiveTweens[p1] = {
                ["part"] = p1,
                ["targetCFrame"] = p2,
                ["initialCFrame"] = v6,
                ["duration"] = p3,
                ["lodSettings"] = p4,
                ["startTime"] = v7,
                ["callback"] = p5
            }
            u8.LastUpdateTime[p1] = v7
        end
    end
}
game:GetService("RunService").Heartbeat:Connect(function(_) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    local v9 = tick()
    local v10 = workspace.CurrentCamera.CFrame.Position
    local v11 = {}
    local v12 = {}
    for v13, v14 in pairs(u8.ActiveTweens) do
        local v15 = v9 - v14.startTime
        local v16 = v15 / v14.duration
        if v13 and v13:IsDescendantOf(workspace) then
            local v17 = (v10 - v13.Position).Magnitude
            local v18 = v14.lodSettings.minDistance
            local v19 = v14.lodSettings.maxDistance
            local v20 = v14.lodSettings.minLerpInterval
            local v21 = v14.lodSettings.maxLerpInterval
            if v20 + (math.clamp(v17, v18, v19) - v18) / (v19 - v18) * (v21 - v20) <= tick() - u8.LastUpdateTime[v13] then
                if v16 < 1 then
                    local v22 = v15 / v14.duration
                    local v23 = v14.initialCFrame:Lerp(v14.targetCFrame, v22)
                    table.insert(v11, v13)
                    table.insert(v12, v23)
                    u8.LastUpdateTime[v13] = tick()
                else
                    local v24 = v14.targetCFrame
                    table.insert(v11, v13)
                    table.insert(v12, v24)
                    if v14.callback then
                        v14.callback()
                    end
                    u8.ActiveTweens[v13] = nil
                    u8.LastUpdateTime[v13] = nil
                end
            end
        else
            u8.ActiveTweens[v13] = nil
            u8.LastUpdateTime[v13] = nil
        end
    end
    if #v11 > 0 then
        workspace:BulkMoveTo(v11, v12, Enum.BulkMoveMode.FireCFrameChanged)
    end
end)
return u8
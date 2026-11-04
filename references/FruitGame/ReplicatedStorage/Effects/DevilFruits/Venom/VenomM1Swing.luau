 

local v1 = {}
local function u8(p2, p3) --[[ Line: 2 ]]
    local v4 = p3 == nil and "" or p3
    local v5 = p2:GetDescendants()
    local v6 = nil
    for v7 = 1, #v5 do
        if v5[v7].Name == v4 then
            return v5[v7]
        end
    end
    return v6
end
local u9 = {
    ["1"] = "RingLeft",
    ["2"] = "RingRight",
    ["3"] = "RingLeft",
    ["4"] = "RingRight",
    ["5"] = "RingLeft"
}
local function u35(p10, p11, p12) --[[ Line: 25 ]]
    local u13
    if p12 then
        u13 = script.Parent.VenomHydra.CylinderR:Clone()
    else
        u13 = script.Parent.VenomHydra.Cylinder:Clone()
    end
    local v14 = (p10.Position - p11.Position).Magnitude
    local v15 = next
    local v16, v17 = u13:GetChildren()
    for _, v18 in v15, v16, v17 do
        local v19 = v18.Size.Y * 1.25
        local v20 = v18.Size.Z * 1.25
        v18.Size = Vector3.new(v14, v19, v20)
    end
    local v21 = CFrame.new(p10.Position, p11.Position) * CFrame.new(0, 0, -v14 / 2) * CFrame.Angles(0, -1.5707963267948966, 0)
    local v22 = CFrame.Angles
    local v23 = math.random(-360, 360)
    u13:PivotTo(v21 * v22(math.rad(v23), 0, 0))
    u13.Parent = workspace.Effects
    _G.destroy(u13, 0.4)
    local u24 = u13:GetPivot()
    local v25 = next
    local v26, v27 = u13:GetChildren()
    for _, u28 in v25, v26, v27 do
        local u29 = u28.Name == "Glass" and 0.3 or 0.25
        task.delay(0.125, function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u29
                [3] = u24
            --]]
            local v30 = _G.tween
            local v31 = u28
            local v32 = {
                u29,
                "Linear",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v33 = {}
            local v34 = u28.Size.X
            v33.Size = Vector3.new(v34, 0, 0)
            v33.CFrame = u24 + u24:inverse() * u28.Position * 0
            v30(v31, v32, v33, nil, true)
        end)
    end
    _G.customEmit(u13)
    task.delay(0.125, function() --[[ Line: 44 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u24
        --]]
        _G.tween(u13.PrimaryPart, {
            0.25,
            "Linear",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u24 + u24:inverse() * u24.Position * 0
        }, nil, true)
    end)
end
function v1.start(_, p36, p37, p38) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u35
    --]]
    if _G.checkRenderDistance(p36.PrimaryPart.Position) then
        local v39 = p38 or 0.85
        local u40 = u8(p36, u9[tostring(p37)])
        if u40 ~= nil then
            local u41 = CFrame.new(-1, -1, -0.5)
            local u42 = u40.TransformedWorldCFrame * u41
            local u44 = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u41
                    [3] = u42
                    [4] = u35
                --]]
                local v43 = u40.TransformedWorldCFrame * u41
                local _ = (workspace.CurrentCamera.CFrame.Position - v43.Position).Magnitude
                if (u42.Position - v43.Position).Magnitude >= 4 and _G.checkRenderDistance(v43.Position, 500) then
                    u35(u42, v43, true)
                    u42 = v43
                end
            end)
            task.delay(v39, function() --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u44
                --]]
                u44:Disconnect()
                u44 = nil
            end)
        end
    else
        return
    end
end
return v1
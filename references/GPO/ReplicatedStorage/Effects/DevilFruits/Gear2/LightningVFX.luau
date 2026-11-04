 

game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v1 = {}
local function u7(p2, p3) --[[ Line: 6 ]]
    local v4 = math.random() * 1.5707963267948966
    local v5 = math.random() * 3.141592653589793
    local _ = p3 * math.cos(v4)
    local v6 = p3 * math.sin(v4)
    return (CFrame.new(p2) * CFrame.new(-p3 / 2, 0, 0) * CFrame.Angles(-v5, 0, 0) * CFrame.Angles(0, v4, 0) * CFrame.new(0, 0, v6)).Position
end
local function u21(p8, p9, p10) --[[ Line: 17 ]]
    local v11 = (p8 - p9).Magnitude
    local v12 = (p9 - p8).Unit
    local v13 = v11 / p10
    local v14 = {}
    for v15 = 1, p10 do
        local v16 = math.random(-2, 2)
        local v17 = math.random(-2, 2)
        local v18 = Vector3.new(v16, v17, 0)
        local v19 = CFrame.new(p8 + v12 * v15 * v13)
        if v15 == 0 or v15 == #v14 then
            v18 = Vector3.new()
        end
        local v20 = v19 + v18
        v14[#v14 + 1] = v20
    end
    return v14
end
local u22 = {
    ["X"] = Vector3.new(0, 1, 1),
    ["Y"] = Vector3.new(1, 0, 1),
    ["Z"] = Vector3.new(1, 1, 0)
}
function v1.start(_, u23, p24, u25, u26, u27, p28, u29, p30, p31) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u21
        [3] = u22
    --]]
    local u32 = Random.new()
    for _ = 1, p31 do
        local v33 = u7(p24, p30)
        local _ = (p24 - v33).Magnitude / u32:NextNumber(1, 1.5)
        local _ = (v33 - p24).Unit
        local u34 = u21(p24, v33, p28)
        task.spawn(function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u29
                [3] = u32
                [4] = u25
                [5] = u27
                [6] = u22
                [7] = u26
                [8] = u23
            --]]
            for v35 = 1, #u34 do
                local u36 = u29 * u32:NextNumber(0.8, 1.4)
                if u34[v35 + 1] ~= nil then
                    local v37 = (v35 == 1 or v35 == #u34) and u25 / 2 or u25
                    local u38 = u34[v35].Position
                    local u39 = u34[v35 + 1].Position
                    local u40 = (u39 - u38).Magnitude
                    local v41 = {}
                    local v42 = script.CQCylinder:Clone()
                    v42.CFrame = CFrame.new(u38, u39) * u27
                    v42.Size = v37 * u22[u26] + Vector3.new()
                    local v43 = v42.Invert
                    v43.Color = u23
                    v43.Size = v43.Size * 1.6
                    v42.Parent = workspace.Effects
                    v41[1] = v42
                    v41[2] = v43
                    local u44 = u32:NextNumber(0.9, 1.25)
                    for _, u45 in pairs(v41) do
                        _G.tween(u45, { u36, Enum.EasingStyle.Quad, Enum.EasingDirection.Out }, {
                            ["CFrame"] = CFrame.new(u38, u39) * CFrame.new(0, 0, -u40 / 2) * u27,
                            ["Size"] = u45.Size * u22[u26] * u44 + Vector3.FromAxis(Enum.Axis[u26]) * u40,
                            ["Transparency"] = 0
                        })
                        task.delay(u36, function() --[[ Line: 100 ]]
                            --[[
                            Upvalues:
                                [1] = u45
                                [2] = u36
                                [3] = u38
                                [4] = u39
                                [5] = u40
                                [6] = u27
                                [7] = u22
                                [8] = u26
                                [9] = u44
                            --]]
                            _G.destroy(u45, u36 * 2)
                            _G.tween(u45, { u36, Enum.EasingStyle.Quad, Enum.EasingDirection.In }, {
                                ["CFrame"] = CFrame.new(u38, u39) * CFrame.new(0, 0, -u40 / 2) * u27,
                                ["Size"] = u45.Size * u22[u26] * 0.1 + Vector3.FromAxis(Enum.Axis[u26]) * u40 * u44,
                                ["Transparency"] = 1
                            })
                        end)
                    end
                end
                task.wait(u36 / 2)
            end
        end)
    end
end
return v1
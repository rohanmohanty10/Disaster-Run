 

local u1 = require(script.Parent:WaitForChild("getLastWordFromPascalCase"))
local u2 = {
    ["Hand"] = "Arm",
    ["Foot"] = "Leg"
}
local function u17(p3, u4) --[[ Line: 72 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local u5 = {}
    local u6 = {}
    local u7 = {}
    local function u16(p8, p9) --[[ Line: 77 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u5
            [4] = u7
            [5] = u6
            [6] = u4
            [7] = u16
        --]]
        if p8 ~= nil then
            local v10
            if p8 and p8.Name ~= "HumanoidRootPart" then
                local v11 = u1(p8.Name)
                v10 = u2[v11] or v11
                u5[v10] = u5[v10] or {}
                local v12 = u5[v10]
                table.insert(v12, p8)
                local _ = u5[v10]
                if v10 == p9 then
                    v10 = p9
                else
                    u7[v10] = u7[v10] or {}
                    if p9 then
                        u7[v10][p9] = true
                    end
                    local v13 = u6
                    table.insert(v13, {
                        ["Part"] = p8,
                        ["Type"] = v10
                    })
                end
            else
                v10 = p9
            end
            for _, v14 in ipairs(p8:GetChildren()) do
                if v14:isA("Attachment") and u4[v14.Name] then
                    local v15 = u4[v14.Name].Attachment1.Parent
                    if v15 and v15 ~= p8 then
                        u16(v15, v10)
                    end
                end
            end
        end
    end
    u16(p3)
    return u5, u6, u7
end
return function(p18, p19) --[[ Line: 122 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    local v20 = Instance.new("Folder")
    v20.Name = "NoCollisionConstraints"
    local v21, v22, v23 = u17(p19, p18)
    for v24, v25 in ipairs(v22) do
        local v26 = v22[v24 + 1]
        if v26 then
            local v27 = v25.Type
            local v28 = v26.Type
            if not (v23[v27][v28] or v23[v28][v27]) then
                local v29 = v25.Part
                local v30 = v26.Part
                local v31 = Instance.new("NoCollisionConstraint")
                v31.Name = v29.Name .. "<->" .. v30.Name
                v31.Part0 = v29
                v31.Part1 = v30
                v31.Parent = v20
            end
        end
    end
    for v32, v33 in pairs(v21) do
        for v34, _ in pairs(v23[v32]) do
            for _, v35 in v21[v34] do
                for _, v36 in ipairs(v33) do
                    local v37 = Instance.new("NoCollisionConstraint")
                    v37.Name = v36.Name .. "<->" .. v35.Name
                    v37.Part0 = v36
                    v37.Part1 = v35
                    v37.Parent = v20
                end
            end
        end
    end
    return v20
end
 

local u1 = game:GetService("RunService")
local u2 = game:GetService("TweenService")
local u3 = workspace:WaitForChild("Terrain")
local u4 = workspace:WaitForChild("Terrain")
assert(u3, "No terrain object found under workspace")
assert(u4, "No target parent found.")
local u5 = u4:FindFirstChild("AOTGizmoAdornment")
local u6 = u4:FindFirstChild("GizmoAdornment")
if not u5 then
    u5 = Instance.new("WireframeHandleAdornment")
    u5.Adornee = u3
    u5.ZIndex = 1
    u5.AlwaysOnTop = true
    u5.Name = "AOTGizmoAdornment"
    u5.Parent = u4
end
if not u6 then
    u6 = Instance.new("WireframeHandleAdornment")
    u6.Adornee = u3
    u6.ZIndex = 1
    u6.AlwaysOnTop = false
    u6.Name = "GizmoAdornment"
    u6.Parent = u4
end
local v7 = script.Parent:WaitForChild("Gizmos")
local u8 = {}
local u9 = {}
local u10 = {}
local u11 = {}
local u12 = {
    ["AlwaysOnTop"] = true,
    ["Color3"] = Color3.fromRGB(13, 105, 172),
    ["Transparency"] = 0
}
local u13 = {}
local u14 = false
local function v17(p15) --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u8
    --]]
    p15.Parent = u4
    local v16 = u8
    table.insert(v16, p15)
end
local function u23(p18) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v19 = {}
    for v20, v22 in pairs(p18) do
        if type(v22) == "table" then
            local v22 = u23(v22)
        end
        v19[v20] = v22
    end
    return v19
end
local u65 = {
    ["Enabled"] = true,
    ["ActiveRays"] = 0,
    ["ActiveInstances"] = 0,
    ["Styles"] = {
        ["Color"] = "Color3",
        ["Transparency"] = "Transparency",
        ["AlwaysOnTop"] = "AlwaysOnTop"
    },
    ["AOTWireframeHandle"] = u5,
    ["WireframeHandle"] = u6,
    ["GetPoolSize"] = function() --[[ Name: GetPoolSize, Line 506 ]]
        --[[
        Upvalues:
            [1] = u13
        --]]
        local v24 = 0
        for _, v25 in u13 do
            v24 = v24 + #v25
        end
        return v24
    end,
    ["PushProperty"] = function(u26, u27) --[[ Name: PushProperty, Line 521 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u5
            [3] = u6
        --]]
        u12[u26] = u27
        if u26 ~= "AlwaysOnTop" then
            pcall(function() --[[ Line: 528 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u26
                    [3] = u27
                    [4] = u6
                --]]
                u5[u26] = u27
                u6[u26] = u27
            end)
        end
    end,
    ["PopProperty"] = function(p28) --[[ Name: PopProperty, Line 539 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u5
        --]]
        if u12[p28] then
            return u12[p28]
        else
            return u5[p28]
        end
    end,
    ["SetStyle"] = function(p29, p30, p31) --[[ Name: SetStyle, Line 553 ]]
        --[[
        Upvalues:
            [1] = u65
        --]]
        if p29 ~= nil and typeof(p29) == "Color3" then
            u65.PushProperty("Color3", p29)
        end
        if p30 ~= nil and typeof(p30) == "number" then
            u65.PushProperty("Transparency", p30)
        end
        if p31 ~= nil and typeof(p31) == "boolean" then
            u65.PushProperty("AlwaysOnTop", p31)
        end
    end,
    ["DoCleaning"] = function() --[[ Name: DoCleaning, Line 569 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u8
            [4] = u13
            [5] = u65
        --]]
        u5:Clear()
        u6:Clear()
        for _, v32 in u8 do
            local v33 = v32.ClassName
            if not u13[v33] then
                u13[v33] = {}
            end
            v32:Remove()
            local v34 = u13[v33]
            table.insert(v34, v32)
        end
        u8 = {}
        u65.ActiveRays = 0
        u65.ActiveInstances = 0
    end,
    ["ScheduleCleaning"] = function() --[[ Name: ScheduleCleaning, Line 585 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u65
        --]]
        if not u14 then
            u14 = true
            task.delay(0, function() --[[ Line: 592 ]]
                --[[
                Upvalues:
                    [1] = u65
                    [2] = u14
                --]]
                u65.DoCleaning()
                u14 = false
            end)
        end
    end,
    ["AddDebrisInSeconds"] = function(p35, p36) --[[ Name: AddDebrisInSeconds, Line 604 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v37 = u10
        local v38 = {
            "Seconds",
            p35,
            os.clock(),
            p36
        }
        table.insert(v37, v38)
    end,
    ["AddDebrisInFrames"] = function(p39, p40) --[[ Name: AddDebrisInFrames, Line 613 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v41 = u10
        table.insert(v41, {
            "Frames",
            p39,
            0,
            p40
        })
    end,
    ["TweenProperties"] = function(p42, p43, p44) --[[ Name: TweenProperties, Line 624 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u11
        --]]
        local u45 = {
            ["p_Properties"] = p42,
            ["Properties"] = u23(p42),
            ["Goal"] = p43,
            ["TweenInfo"] = p44,
            ["Time"] = 0
        }
        u11[u45] = true
        return function() --[[ Line: 638 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u45
            --]]
            u11[u45] = nil
        end
    end,
    ["Init"] = function() --[[ Name: Init, Line 645 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u65
            [3] = u4
            [4] = u5
            [5] = u3
            [6] = u6
            [7] = u11
            [8] = u2
            [9] = u10
            [10] = u9
        --]]
        u1.RenderStepped:Connect(function(p46) --[[ Line: 646 ]]
            --[[
            Upvalues:
                [1] = u65
                [2] = u4
                [3] = u5
                [4] = u3
                [5] = u6
                [6] = u11
                [7] = u2
                [8] = u10
                [9] = u9
            --]]
            if u65.Enabled then
                if not u4:FindFirstChild("AOTGizmoAdornment") then
                    u5 = Instance.new("WireframeHandleAdornment")
                    u5.Adornee = u3
                    u5.ZIndex = 1
                    u5.AlwaysOnTop = true
                    u5.Name = "AOTGizmoAdornment"
                    u5.Parent = u4
                    u65.AOTWireframeHandle = u5
                end
                if not u4:FindFirstChild("GizmoAdornment") then
                    u6 = Instance.new("WireframeHandleAdornment")
                    u6.Adornee = u3
                    u6.ZIndex = 1
                    u6.AlwaysOnTop = false
                    u6.Name = "GizmoAdornment"
                    u6.Parent = u4
                    u65.WireframeHandle = u6
                end
            end
            for v47 in u11 do
                v47.Time = v47.Time + p46
                local v48 = v47.Time / v47.TweenInfo.Time
                local v49 = v48 > 1 and 1 or v48
                for v50, v51 in v47.Properties do
                    if v47.Goal[v50] then
                        local v52 = u2:GetValue(v49, v47.TweenInfo.EasingStyle, v47.TweenInfo.EasingDirection)
                        local v53 = v47.Goal[v50]
                        local v54
                        if type(v51) == "number" then
                            v54 = v51 + (v53 - v51) * v52
                        else
                            v54 = v51:Lerp(v53, v52)
                        end
                        v47.p_Properties[v50] = v54
                    end
                end
                if v49 == 1 then
                    u11[v47] = nil
                end
            end
            for v55 = #u10, 1, -1 do
                local v56 = u10[v55]
                local v57 = v56[1]
                local v58 = v56[2]
                local v59 = v56[3]
                local v60 = v56[4]
                if v57 == "Seconds" then
                    if v58 < os.clock() - v59 then
                        table.remove(u10, v55)
                    else
                        v60()
                    end
                elseif v58 < v59 then
                    table.remove(u10, v55)
                else
                    v56[2] = v56[2] + 1
                    v60()
                end
            end
            for v61 = #u9, 1, -1 do
                local v62 = u9[v61]
                local v63 = v62[2]
                if v63.Enabled then
                    if v63.Destroy then
                        table.remove(u9, v61)
                    end
                    v62[1]:Update(v63)
                end
            end
        end)
    end,
    ["SetEnabled"] = function(p64) --[[ Name: SetEnabled, Line 752 ]]
        --[[
        Upvalues:
            [1] = u65
        --]]
        u65.Enabled = p64
        if p64 == false then
            u65.DoCleaning()
        end
    end,
    ["RemoveAdornments"] = function() --[[ Name: RemoveAdornments, Line 763 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        if u4:FindFirstChild("AOTGizmoAdornment") then
            u4:FindFirstChild("AOTGizmoAdornment"):Destroy()
        end
        if u4:FindFirstChild("GizmoAdornment") then
            u4:FindFirstChild("GizmoAdornment"):Destroy()
        end
    end
}
local function v67(p66) --[[ Line: 66 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    if u13[p66] then
        return table.remove(u13[p66]) or Instance.new(p66)
    else
        return Instance.new(p66)
    end
end
local function v71(p68) --[[ Line: 55 ]]
    --[[
    Upvalues:
        [1] = u13
    --]]
    local v69 = p68.ClassName
    if not u13[v69] then
        u13[v69] = {}
    end
    p68:Remove()
    local v70 = u13[v69]
    table.insert(v70, p68)
end
local function v75(p72, p73) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    local v74 = u9
    table.insert(v74, { p72, p73 })
end
for _, v76 in v7:GetChildren() do
    u65[v76.Name] = require(v76).Init(u65, u12, v67, v71, v75, v17)
end
return u65
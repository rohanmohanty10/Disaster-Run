 

local u1 = game:GetService("CollectionService")
local u2 = script:GetAttribute("TagName") or "WaveSetting"
local u3 = require(script.Parent.WaveSettings)
local u4 = {}
local function u26(p5) --[[ Line: 9 ]]
    local v6 = p5.Size
    local v7 = p5.CFrame
    local v8 = {}
    local v9 = -v6.X / 2
    local v10 = -v6.Z / 2
    local v11 = Vector3.new(v9, 0, v10)
    local v12 = -v6.X / 2
    local v13 = v6.Z / 2
    local v14 = Vector3.new(v12, 0, v13)
    local v15 = v6.X / 2
    local v16 = -v6.Z / 2
    local v17 = Vector3.new(v15, 0, v16)
    local v18 = v6.X / 2
    local v19 = v6.Z / 2
    __set_list(v8, 1, {v11, v14, v17, (Vector3.new(v18, 0, v19))})
    local v20 = {}
    for _, v21 in ipairs(v8) do
        local v22 = v7:ToWorldSpace(CFrame.new(v21)).Position
        table.insert(v20, v22)
    end
    local v23 = v20[1]
    local v24 = v20[1]
    for _, v25 in ipairs(v20) do
        if v25.X < v23.X then
            if v25.Z < v23.Z then
                v23 = v25
            end
        end
        if v25.X > v24.X and v25.Z > v24.Z then
            v24 = v25
        end
    end
    return v23, v24
end
local function u51(p27) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u26
        [2] = u4
        [3] = u3
    --]]
    local v28 = {
        ["Direction"] = p27:GetAttribute("Direction") or Vector3.new(0, 0, 0),
        ["WaveLength"] = p27:GetAttribute("WaveLength"),
        ["Steepness"] = p27:GetAttribute("Steepness"),
        ["Gravity"] = p27:GetAttribute("Gravity"),
        ["Cancel"] = p27:GetAttribute("Cancel") or false
    }
    local v29 = p27:GetAttribute("Priority") or 0
    if typeof(v29) ~= "number" then
        return false
    end
    if not (v28.WaveLength and (v28.Steepness and v28.Gravity)) then
        return false
    end
    local v30 = v28.Direction
    if typeof(v30) ~= "Vector3" then
        return false
    end
    local v31 = v28.WaveLength
    if typeof(v31) ~= "number" then
        return false
    end
    local v32 = v28.Steepness
    if typeof(v32) ~= "number" then
        return false
    end
    local v33 = v28.Gravity
    if typeof(v33) ~= "number" then
        return false
    end
    local v34 = v28.Cancel
    if typeof(v34) ~= "boolean" then
        return false
    end
    local v35, v36 = u26(p27)
    local v37 = u4[p27].id
    if v37 then
        local v38 = u3.EditSetting
        local v39 = v35.X
        local v40 = v35.Z
        local v41 = Vector3.new(v39, 0, v40)
        local v42 = v36.X
        local v43 = v36.Z
        return v38(v37, v28, v41, Vector3.new(v42, 0, v43), v29)
    end
    local v44 = u3.AddSetting
    local v45 = v35.X
    local v46 = v35.Y
    local v47 = Vector3.new(v45, 0, v46)
    local v48 = v36.X
    local v49 = v36.Z
    local v50 = v44(v28, v47, Vector3.new(v48, 0, v49), v29)
    u4[p27].id = v50
    return true
end
local function u67(u52) --[[ Line: 80 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u51
        [3] = u3
    --]]
    if not u4[u52] then
        u4[u52] = {
            ["connectionList"] = {}
        }
    end
    u51(u52)
    local v53 = u4[u52].connectionList
    local v54 = u52.AttributeChanged
    local function v55() --[[ Line: 87 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u52
        --]]
        u51(u52)
    end
    table.insert(v53, v54:Connect(v55))
    local v56 = u4[u52].connectionList
    local v57 = u52:GetPropertyChangedSignal("Position")
    local function v58() --[[ Line: 90 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u52
        --]]
        u51(u52)
    end
    table.insert(v56, v57:Connect(v58))
    local v59 = u4[u52].connectionList
    local v60 = u52:GetPropertyChangedSignal("Size")
    local function v61() --[[ Line: 93 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u52
        --]]
        u51(u52)
    end
    table.insert(v59, v60:Connect(v61))
    local v62 = u4[u52].connectionList
    local v63 = u52.Destroying
    local function v66() --[[ Line: 96 ]]
        --[[
        Upvalues:
            [1] = u52
            [2] = u3
            [3] = u4
        --]]
        local v64 = u52
        u3.RemoveSetting(u4[v64].id or "")
        for _, v65 in u4[v64].connectionList do
            v65:Disconnect()
        end
        u4[v64] = nil
    end
    table.insert(v62, v63:Connect(v66))
end
u1:GetInstanceAddedSignal(u2):Connect(u67)
u1:GetInstanceRemovedSignal(u2):Connect(function(p68) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    u3.RemoveSetting(u4[p68].id or "")
    u3.RemoveSetting(u4[p68].id or "")
    for _, v69 in u4[p68].connectionList do
        v69:Disconnect()
    end
    u4[p68] = nil
end)
return {
    ["Setup"] = function() --[[ Name: Setup, Line 108 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u67
        --]]
        for _, v70 in u1:GetTagged(u2) do
            u67(v70)
        end
    end
}
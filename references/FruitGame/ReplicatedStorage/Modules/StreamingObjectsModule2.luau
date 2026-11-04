 

local u1 = {}
local u2 = {}
local u3 = {}
local u4 = game.ReplicatedStorage
local v5 = game["Run Service"]:IsServer()
local u6 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Signals"):WaitForChild("GoodSignal"))
local u7 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Trove"))
local _ = warn
local u8 = workspace:WaitForChild("Holder"):WaitForChild("HumanoidRootPart")
local function u15(p9, p10) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u15
    --]]
    local v11 = p10 or 0
    local v12 = string.rep(" ", v11)
    for v13, v14 in pairs(p9) do
        if type(v14) == "table" then
            print(v12 .. tostring(v13) .. ":")
            u15(v14, v11 + 4)
        else
            print(v12 .. tostring(v13) .. " = " .. tostring(v14))
        end
    end
end
local function u16(...) --[[ Line: 30 ]] end
local function u21(p17) --[[ Line: 36 ]]
    if next(p17) == nil then
        return "Empty"
    end
    local v18 = true
    local v19 = true
    for v20, _ in next, p17 do
        if typeof(v20) == "number" and (v20 % 1 == 0 and v20 > 0) then
            v19 = false
        else
            v18 = false
        end
    end
    return v18 and "Array" or (v19 and "Dictionary" or "Mixed")
end
function FillMissingIndexes(p22)
    local v23 = {}
    local v24 = false
    for v25, _ in pairs(p22) do
        if type(v25) ~= "number" or v25 % 1 ~= 0 then
            v24 = true
            break
        end
        table.insert(v23, v25)
    end
    if v24 then
        return p22
    end
    table.sort(v23)
    local v26 = {}
    for v27, v28 in ipairs(v23) do
        v26[v27] = p22[v28]
    end
    return v26
end
if v5 == true then
    function u1.convertToInstance(_, u29, p30) --[[ Line: 107 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u3
            [4] = u1
            [5] = u21
        --]]
        local v31 = p30 == nil and 5 or p30
        if u29 == nil then
            return "fakeNil"
        end
        if typeof(u29) == "Instance" then
            if not u2[u29] then
                if u29:GetAttribute("StreamingObjectValue") then
                    return u29
                end
                local v32 = Instance.new("ObjectValue")
                v32.Value = u29
                if u29:IsA("Model") and u29.PrimaryPart then
                    v32:SetAttribute("HasPrimaryPart", true)
                end
                v32.Name = u29:GetFullName()
                v32:SetAttribute("StreamingObjectValue", true)
                v32:SetAttribute("Timeout", v31)
                if #u29:GetDescendants() > 0 then
                    v32:SetAttribute("hasDescendants", true)
                end
                v32.Parent = u4.StreamingEnabledObjectValues
                u2[u29] = v32
                u29.Destroying:Connect(function() --[[ Line: 133 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u2
                        [3] = u3
                    --]]
                    local v33 = u29
                    local v34 = u2[v33]
                    if v34 then
                        v34:Destroy()
                        u2[v33] = nil
                        u3[v33] = nil
                    end
                end)
            end
            local u35 = u2[u29]
            if u3[u29] then
                task.cancel(u3[u29])
            end
            u3[u29] = task.delay(30, function() --[[ Line: 100 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u2
                    [3] = u29
                    [4] = u3
                --]]
                u35:Destroy()
                u2[u29] = nil
                u3[u29] = nil
            end)
            return u2[u29]
        end
        if typeof(u29) ~= "table" then
            return u29
        end
        if table.find(u29, workspace.Islands) and table.find(u29, workspace.Env) then
            return u29
        end
        if table.find(u29, workspace.Holder.PrimaryPart) then
            return u29
        end
        local v36 = {}
        for v37, v38 in pairs(u29) do
            v36[v37] = u1:convertToInstance(v38, v31)
        end
        if u21(u29) == "Array" then
            local v39 = 0
            for v40, _ in pairs(u29) do
                v39 = v40
            end
            for v41 = 1, v39 do
                if u29[v41] == nil then
                    u29[v41] = "fakeNil"
                end
            end
        end
        return v36
    end
    function u1.convertArgs(_, p42, p43) --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u21
        --]]
        if typeof(p42) == "Instance" then
            return u1:convertToInstance(p42, p43)
        end
        local v44 = {}
        for v45, v46 in pairs(p42) do
            v44[v45] = u1:convertToInstance(v46, p43)
        end
        if u21(v44) == "Array" then
            local v47 = 0
            for v48, _ in pairs(v44) do
                v47 = v48
            end
            for v49 = 1, v47 do
                if v44[v49] == nil then
                    v44[v49] = "fakeNil"
                end
            end
        end
        return v44
    end
    return u1
end
local u50 = {}
local function u57(u51) --[[ Line: 200 ]]
    --[[
    Upvalues:
        [1] = u50
        [2] = u16
        [3] = u7
        [4] = u6
    --]]
    local v52 = u51:GetAttribute("Timeout")
    local v53 = tick()
    if u50[u51] then
        u16("object already in queue", u51)
        tick()
        u50[u51]:Wait()
        return v52 <= tick() - v53 and u51.Value == nil and "TIMED OUT VALUE" or u51.Value
    end
    if u51:GetAttribute("StreamingObjectValue") == nil then
        return u51
    end
    local v54 = u7.new()
    local u55 = u6.new()
    local u56 = false
    u50[u51] = u55
    v54:Add(task.delay(v52, function() --[[ Line: 226 ]]
        --[[
        Upvalues:
            [1] = u56
            [2] = u55
        --]]
        u56 = true
        if u55 then
            u55:Fire()
        end
    end))
    v54:Add(u51.Destroying:Connect(function() --[[ Line: 235 ]]
        --[[
        Upvalues:
            [1] = u55
        --]]
        if u55 then
            u55:Fire()
        end
    end))
    v54:Add(task.defer(function() --[[ Line: 243 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u55
        --]]
        if u51.Value == nil then
            u51:GetPropertyChangedSignal("Value"):Wait()
        end
        if u51:GetAttribute("HasPrimaryPart") and u51.Value.PrimaryPart == nil then
            u51.Value:GetPropertyChangedSignal("PrimaryPart"):Wait()
        end
        if u51:GetAttribute("hasDescendants") then
            if #u51.Value:GetDescendants() <= 0 then
                u51.Value.DescendantAdded:Wait()
            end
            game["Run Service"].RenderStepped:Wait()
        end
        u55:Fire()
    end))
    u55:Wait()
    u55:Fire()
    u55:DisconnectAll()
    v54:Destroy()
    u50[u51] = nil
    u55 = nil
    u16("loaded object", u51)
    return u56 == true and "TIMED OUT VALUE" or u51.Value
end
function u1.resolveArgs(_, p58) --[[ Line: 286 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u57
        [3] = u1
        [4] = u8
    --]]
    u16("resolving", p58)
    if typeof(p58) == "Instance" then
        local v59 = u57(p58)
        u16("finished revolving", p58)
        return v59
    end
    if typeof(p58) ~= "table" then
        u16("finished revolving", p58)
        return p58
    end
    local v60 = {}
    for v61, v62 in pairs(p58) do
        if v62 ~= "finishedProcessing" and v61 ~= "finishedProcessing" then
            if typeof(v62) == "Instance" and v62:IsA("ObjectValue") then
                v60[v61] = u57(v62)
            elseif typeof(v62) == "table" then
                v60[v61] = u1:resolveArgs(v62)
            elseif v62 == "fakeNil" then
                v60[v61] = "fakeNil"
            else
                v60[v61] = v62
            end
            if v60[v61] == "TIMED OUT VALUE" then
                return "TIMED OUT VALUE"
            end
        end
    end
    for v63, v64 in pairs(v60) do
        if v64 == "fakeNil" then
            v60[v63] = nil
        end
    end
    for _, v65 in pairs(p58) do
        if v65 == u8 then
            return FillMissingIndexes(v60)
        end
    end
    return v60
end
return u1
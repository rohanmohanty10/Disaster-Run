 

local u1 = {}
local u2 = {}
local u3 = {}
local u4 = game.ReplicatedStorage
local v5 = game["Run Service"]:IsServer()
local u6 = require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Shared"):WaitForChild("Signals"):WaitForChild("GoodSignal"))
require(game.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Trove"))
local _ = warn
local u7 = workspace:WaitForChild("Holder"):WaitForChild("HumanoidRootPart")
local u8 = game:GetService("RunService")
local function u15(p9, p10) --[[ Line: 23 ]]
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
local function u16(...) --[[ Line: 36 ]] end
local function u21(p17) --[[ Line: 42 ]]
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
    function u1.convertToInstance(_, u29, p30) --[[ Line: 116 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u3
            [4] = u1
            [5] = u21
        --]]
        local v31 = p30 == nil and 15 or p30
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
                u29.Destroying:Once(function() --[[ Line: 147 ]]
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
                u3[u29] = nil
            end
            u3[u29] = task.delay(30, function() --[[ Line: 107 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u29
                    [3] = u35
                    [4] = u3
                --]]
                if u2[u29] == u35 then
                    u35:Destroy()
                    u2[u29] = nil
                    u3[u29] = nil
                end
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
    function u1.convertArgs(_, p42, p43) --[[ Line: 186 ]]
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
local function u62(u51) --[[ Line: 214 ]]
    --[[
    Upvalues:
        [1] = u50
        [2] = u16
        [3] = u6
        [4] = u8
    --]]
    local v52 = u51:GetAttribute("Timeout")
    local v53 = tick()
    if u50[u51] then
        u16("object already in queue", u51)
        while u50[u51] do
            local v54 = u51.Value
            if v54 ~= nil then
                return v54
            end
            if v52 <= tick() - v53 then
                return "TIMED OUT VALUE"
            end
            task.wait()
        end
        local v55 = u51.Value
        return v55 == nil and "TIMED OUT VALUE" or v55
    end
    if u51:GetAttribute("StreamingObjectValue") == nil then
        return u51
    end
    local u56 = u6.new()
    local u57 = false
    local u58 = false
    u50[u51] = true
    local v59 = task.delay(v52, function() --[[ Line: 251 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u57
            [3] = u56
        --]]
        if not u58 then
            u57 = true
            u56:Fire()
        end
    end)
    local v60 = u51.Destroying:Connect(function() --[[ Line: 257 ]]
        --[[
        Upvalues:
            [1] = u58
            [2] = u56
        --]]
        if not u58 then
            u56:Fire()
        end
    end)
    task.defer(function() --[[ Line: 262 ]]
        --[[
        Upvalues:
            [1] = u51
            [2] = u57
            [3] = u58
            [4] = u8
            [5] = u56
        --]]
        pcall(function() --[[ Line: 263 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u57
                [3] = u58
                [4] = u8
            --]]
            if u51.Value == nil then
                u51:GetPropertyChangedSignal("Value"):Wait()
            end
            if u57 or u58 then
                return
            else
                local v61 = u51.Value
                if v61 == nil then
                    return
                else
                    if u51:GetAttribute("HasPrimaryPart") and v61.PrimaryPart == nil then
                        v61:GetPropertyChangedSignal("PrimaryPart"):Wait()
                    end
                    if not (u57 or u58) then
                        if u51:GetAttribute("hasDescendants") then
                            if #v61:GetDescendants() <= 0 then
                                v61.DescendantAdded:Wait()
                            end
                            u8.RenderStepped:Wait()
                        end
                    end
                end
            end
        end)
        if not u58 then
            u56:Fire()
        end
    end)
    u56:Wait()
    u58 = true
    u50[u51] = nil
    pcall(task.cancel, v59)
    v60:Disconnect()
    u56:DisconnectAll()
    u16("loaded object", u51)
    return u57 and "TIMED OUT VALUE" or u51.Value
end
function u1.resolveArgs(_, p63) --[[ Line: 320 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u62
        [3] = u1
        [4] = u7
    --]]
    u16("resolving", p63)
    if typeof(p63) == "Instance" then
        local v64 = u62(p63)
        u16("finished revolving", p63)
        return v64
    end
    if typeof(p63) ~= "table" then
        u16("finished revolving", p63)
        return p63
    end
    local v65 = {}
    for v66, v67 in pairs(p63) do
        if v67 ~= "finishedProcessing" and v66 ~= "finishedProcessing" then
            if typeof(v67) == "Instance" and v67:IsA("ObjectValue") then
                v65[v66] = u62(v67)
            elseif typeof(v67) == "table" then
                v65[v66] = u1:resolveArgs(v67)
            elseif v67 == "fakeNil" then
                v65[v66] = "fakeNil"
            else
                v65[v66] = v67
            end
            if v65[v66] == "TIMED OUT VALUE" then
                return "TIMED OUT VALUE"
            end
        end
    end
    for v68, v69 in pairs(v65) do
        if v69 == "fakeNil" then
            v65[v68] = nil
        end
    end
    for _, v70 in pairs(p63) do
        if v70 == u7 then
            return FillMissingIndexes(v65)
        end
    end
    return v65
end
return u1
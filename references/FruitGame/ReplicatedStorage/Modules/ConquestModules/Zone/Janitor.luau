 

local u1 = game:GetService("RunService").Heartbeat
local u2 = newproxy(true)
getmetatable(u2).__tostring = function() --[[ Line: 11 ]]
    return "IndicesReference"
end
local u3 = newproxy(true)
getmetatable(u3).__tostring = function() --[[ Line: 16 ]]
    return "LinkToInstanceIndex"
end
local u4 = {
    ["ClassName"] = "Janitor",
    ["__index"] = {
        ["CurrentlyCleaning"] = true,
        [u2] = nil
    }
}
local u5 = {
    ["function"] = true,
    ["RBXScriptConnection"] = "Disconnect"
}
function u4.new() --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v6 = {
        ["CurrentlyCleaning"] = false,
        [u2] = nil
    }
    local v7 = u4
    return setmetatable(v6, v7)
end
function u4.Is(p8) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v9
    if type(p8) == "table" then
        v9 = getmetatable(p8) == u4
    else
        v9 = false
    end
    return v9
end
u4.is = u4.Is
function u4.__index.Add(p10, p11, p12, p13) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u5
    --]]
    if p13 == nil then
        p13 = newproxy(false)
    end
    if p13 then
        p10:Remove(p13)
        local v14 = p10[u2]
        if not v14 then
            v14 = {}
            p10[u2] = v14
        end
        v14[p13] = p11
    end
    local v15 = p12 or (u5[typeof(p11)] or "Destroy")
    if type(p11) ~= "function" and not p11[v15] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p11), tostring(v15), debug.traceback(nil, 2)))
    end
    p10[p11] = v15
    return p11, p13
end
u4.__index.Give = u4.__index.Add
function u4.__index.AddObject(p16, p17) --[[ Line: 131 ]]
    local v18 = newproxy(false)
    return p16:Add(p17, false, v18), v18
end
u4.__index.GiveObject = u4.__index.AddObject
function u4.__index.Remove(p19, p20) --[[ Line: 155 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v21 = p19[u2]
    local v22 = v21 and v21[p20]
    if v22 then
        local v23 = p19[v22]
        if v23 then
            if v23 == true then
                v22()
            else
                local v24 = v22[v23]
                if v24 then
                    v24(v22)
                end
            end
            p19[v22] = nil
        end
        v21[p20] = nil
    end
    return p19
end
function u4.__index.Get(p25, p26) --[[ Line: 189 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v27 = p25[u2]
    if v27 then
        return v27[p26]
    end
end
function u4.__index.Cleanup(p28) --[[ Line: 200 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not p28.CurrentlyCleaning then
        p28.CurrentlyCleaning = nil
        for v29, v30 in next, p28 do
            if v29 ~= u2 then
                local v31 = type(v29)
                if v31 == "string" or v31 == "number" then
                    p28[v29] = nil
                else
                    if v30 == true then
                        v29()
                    else
                        local v32 = v29[v30]
                        if v32 then
                            v32(v29)
                        end
                    end
                    p28[v29] = nil
                end
            end
        end
        local v33 = p28[u2]
        if v33 then
            for v34 in next, v33 do
                v33[v34] = nil
            end
            p28[u2] = {}
        end
        p28.CurrentlyCleaning = false
    end
end
u4.__index.Clean = u4.__index.Cleanup
function u4.__index.Destroy(p35) --[[ Line: 246 ]]
    p35:Cleanup()
end
u4.__call = u4.__index.Cleanup
local u36 = {
    ["Connected"] = true
}
u36.__index = u36
function u36.Disconnect(p37) --[[ Line: 260 ]]
    if p37.Connected then
        p37.Connected = false
        p37.Connection:Disconnect()
    end
end
function u36.__tostring(p38) --[[ Line: 267 ]]
    local v39 = p38.Connected
    return "Disconnect<" .. tostring(v39) .. ">"
end
function u4.__index.LinkToInstance(u40, p41, p42) --[[ Line: 277 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u36
        [3] = u1
    --]]
    local u43 = nil
    local v44 = p42 and newproxy(false) or u3
    local u45 = p41.Parent == nil
    local v46 = u36
    local u47 = setmetatable({}, v46)
    local function v49(_, p48) --[[ Line: 283 ]]
        --[[
        Upvalues:
            [1] = u47
            [2] = u45
            [3] = u1
            [4] = u43
            [5] = u40
        --]]
        u45 = u47.Connected and p48 == nil
        if u45 then
            coroutine.wrap(function() --[[ Line: 289 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u47
                    [3] = u43
                    [4] = u40
                    [5] = u45
                --]]
                u1:Wait()
                if u47.Connected then
                    if u43.Connected then
                        while u45 and (u43.Connected and u47.Connected) do
                            u1:Wait()
                        end
                        if u47.Connected and u45 then
                            u40:Cleanup()
                        end
                    else
                        u40:Cleanup()
                    end
                else
                    return
                end
            end)()
        end
    end
    local u50 = p41.AncestryChanged:Connect(v49)
    u47.Connection = u50
    if u45 then
        local v51 = p41.Parent
        if u47.Connected then
            if v51 == nil then
                u45 = true
            else
                u45 = false
            end
            if u45 then
                coroutine.wrap(function() --[[ Line: 289 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u47
                        [3] = u50
                        [4] = u40
                        [5] = u45
                    --]]
                    u1:Wait()
                    if u47.Connected then
                        if u50.Connected then
                            while u45 and (u50.Connected and u47.Connected) do
                                u1:Wait()
                            end
                            if u47.Connected and u45 then
                                u40:Cleanup()
                            end
                        else
                            u40:Cleanup()
                        end
                    else
                        return
                    end
                end)()
            end
        end
    end
    return u40:Add(u47, "Disconnect", v44)
end
function u4.__index.LinkToInstances(p52, ...) --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v53 = u4.new()
    for _, v54 in ipairs({ ... }) do
        v53:Add(p52:LinkToInstance(v54, true), "Disconnect")
    end
    return v53
end
for v55, v56 in next, u4.__index do
    local v57 = string.lower(v55)
    local v58 = string.sub(v57, 1, 1) .. string.sub(v55, 2)
    u4.__index[v58] = v56
end
return u4
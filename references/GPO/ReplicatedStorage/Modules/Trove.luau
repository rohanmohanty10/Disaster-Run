 

local u1 = game:GetService("RunService")
local u2 = newproxy()
local u3 = newproxy()
local u4 = table.freeze({
    "Destroy",
    "Disconnect",
    "destroy",
    "disconnect"
})
local function u10(p5, p6) --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    local v7 = typeof(p5)
    if v7 == "function" then
        return u2
    end
    if v7 == "thread" then
        return u3
    end
    if p6 then
        return p6
    end
    if v7 == "Instance" then
        return "Destroy"
    end
    if v7 == "RBXScriptConnection" then
        return "Disconnect"
    end
    if v7 == "table" then
        for _, v8 in u4 do
            local v9 = p5[v8]
            if typeof(v9) == "function" then
                return v8
            end
        end
    end
    error(("failed to get cleanup function for object %*: %*"):format(v7, p5), 3)
end
local u11 = {}
u11.__index = u11
function u11.new() --[[ Line: 180 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    local v12 = u11
    local v13 = setmetatable({}, v12)
    v13._objects = {}
    v13._cleaning = false
    return v13
end
function u11.Add(p14, p15, p16) --[[ Line: 239 ]]
    --[[
    Upvalues:
        [1] = u10
    --]]
    if p14._cleaning then
        error("cannot call trove:Add() while cleaning", 2)
    end
    local v17 = u10(p15, p16)
    local v18 = p14._objects
    table.insert(v18, { p15, v17 })
    return p15
end
function u11.Clone(p19, p20) --[[ Line: 261 ]]
    if p19._cleaning then
        error("cannot call trove:Clone() while cleaning", 2)
    end
    return p19:Add(p20:Clone())
end
function u11.Construct(p21, p22, ...) --[[ Line: 304 ]]
    if p21._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2)
    end
    local v23 = nil
    local v24 = type(p22)
    if v24 == "table" then
        v23 = p22.new(...)
    elseif v24 == "function" then
        v23 = p22(...)
    end
    return p21:Add(v23)
end
function u11.Connect(p25, p26, p27) --[[ Line: 337 ]]
    if p25._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2)
    end
    return p25:Add(p26:Connect(p27))
end
function u11.BindToRenderStep(p28, u29, p30, p31) --[[ Line: 360 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p28._cleaning then
        error("cannot call trove:BindToRenderStep() while cleaning", 2)
    end
    u1:BindToRenderStep(u29, p30, p31)
    p28:Add(function() --[[ Line: 367 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u29
        --]]
        u1:UnbindFromRenderStep(u29)
    end)
end
function u11.AddPromise(u32, u33) --[[ Line: 397 ]]
    if u32._cleaning then
        error("cannot call trove:AddPromise() while cleaning", 2)
    end
    if typeof(u33) == "table" then
        local v34 = u33.getStatus
        if typeof(v34) == "function" then
            local v35 = u33.finally
            if typeof(v35) == "function" then
                local v36 = u33.cancel
                if typeof(v36) == "function" then
                    ::l7::
                    if u33:getStatus() == "Started" then
                        u33:finally(function() --[[ Line: 404 ]]
                            --[[
                            Upvalues:
                                [1] = u32
                                [2] = u33
                            --]]
                            if not u32._cleaning then
                                u32:_findAndRemoveFromObjects(u33, false)
                            end
                        end)
                        u32:Add(u33, "cancel")
                    end
                    return u33
                end
            end
        end
    end
    error("did not receive a promise as an argument", 3)
    goto l7
end
function u11.Remove(p37, p38) --[[ Line: 429 ]]
    if p37._cleaning then
        error("cannot call trove:Remove() while cleaning", 2)
    end
    return p37:_findAndRemoveFromObjects(p38, true)
end
function u11.Extend(p39) --[[ Line: 458 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if p39._cleaning then
        error("cannot call trove:Extend() while cleaning", 2)
    end
    return p39:Construct(u11)
end
function u11.Clean(p40) --[[ Line: 478 ]]
    if not p40._cleaning then
        p40._cleaning = true
        for _, v41 in p40._objects do
            p40:_cleanupObject(v41[1], v41[2])
        end
        table.clear(p40._objects)
        p40._cleaning = false
    end
end
function u11.WrapClean(u42) --[[ Line: 520 ]]
    return function() --[[ Line: 521 ]]
        --[[
        Upvalues:
            [1] = u42
        --]]
        u42:Clean()
    end
end
function u11._findAndRemoveFromObjects(p43, p44, p45) --[[ Line: 526 ]]
    local v46 = p43._objects
    for v47, v48 in v46 do
        if v48[1] == p44 then
            local v49 = #v46
            v46[v47] = v46[v49]
            v46[v49] = nil
            if p45 then
                p43:_cleanupObject(v48[1], v48[2])
            end
            return true
        end
    end
    return false
end
function u11._cleanupObject(_, p50, p51) --[[ Line: 546 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if p51 == u2 then
        task.spawn(p50)
        return
    elseif p51 == u3 then
        pcall(task.cancel, p50)
    else
        p50[p51](p50)
    end
end
function u11.AttachToInstance(u52, p53) --[[ Line: 586 ]]
    if u52._cleaning then
        error("cannot call trove:AttachToInstance() while cleaning", 2)
    elseif not p53:IsDescendantOf(game) then
        error("instance is not a descendant of the game hierarchy", 2)
    end
    return u52:Connect(p53.Destroying, function() --[[ Line: 593 ]]
        --[[
        Upvalues:
            [1] = u52
        --]]
        u52:Destroy()
    end)
end
function u11.Destroy(p54) --[[ Line: 607 ]]
    p54:Clean()
end
return {
    ["new"] = u11.new
}
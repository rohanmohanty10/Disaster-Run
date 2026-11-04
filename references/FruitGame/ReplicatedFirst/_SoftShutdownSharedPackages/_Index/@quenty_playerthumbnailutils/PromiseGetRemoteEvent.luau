 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local u4 = v1("GetRemoteEvent")
local u5 = v1("Promise")
local u6 = v1("ResourceConstants")
return v3:IsRunning() and (v3:IsServer() and function(p7) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
    --]]
    return u5.resolved(u4(p7))
end or function(u8) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
        [4] = u4
    --]]
    local v9 = type(u8) == "string"
    assert(v9, "Bad name")
    local v10 = u2:FindFirstChild(u6.REMOTE_EVENT_STORAGE_NAME)
    local v11 = v10 and v10:FindFirstChild(u8)
    if v11 then
        return u5.resolved(v11)
    else
        return u5.spawn(function(p12, _) --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u8
            --]]
            p12(u4(u8))
        end)
    end
end) or function(p13) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u4
    --]]
    return u5.resolved(u4(p13))
end
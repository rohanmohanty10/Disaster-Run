 

local v1 = require(script.Parent.loader).load(script)
local u2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("RunService")
local u4 = v1("ResourceConstants")
return v3:IsRunning() and (v3:IsServer() and function(p5) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v6 = type(p5) == "string"
    assert(v6, "Bad name")
    local v7 = u2:FindFirstChild(u4.REMOTE_FUNCTION_STORAGE_NAME)
    if not v7 then
        v7 = Instance.new("Folder")
        v7.Name = u4.REMOTE_FUNCTION_STORAGE_NAME
        v7.Archivable = false
        v7.Parent = u2
    end
    local v8 = v7:FindFirstChild(p5)
    if v8 then
        return v8
    end
    local v9 = Instance.new("RemoteFunction")
    v9.Name = p5
    v9.Archivable = false
    v9.Parent = v7
    return v9
end or function(p10) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
    --]]
    local v11 = type(p10) == "string"
    assert(v11, "Bad name")
    return u2:WaitForChild(u4.REMOTE_FUNCTION_STORAGE_NAME):WaitForChild(p10)
end) or function(p12) --[[ Line: 51 ]]
    local v13 = Instance.new("RemoteFunction")
    v13.Name = "Mock" .. p12
    v13.Archivable = false
    return v13
end
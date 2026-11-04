 

local u1 = game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("ServerScriptService")
local u4 = require(script.Parent.LoaderUtils)
local u5 = require(script.Parent.BounceTemplateUtils)
local u6 = require(script.Parent.Loader)
local u7 = {
    ["ClassName"] = "LegacyLoader"
}
u7.__index = u7
function u7.new(p8) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v9 = {
        ["_script"] = assert(p8, "No script"),
        ["_container"] = false,
        ["_locked"] = false,
        ["_lookupMap"] = {}
    }
    local v10 = u7
    return setmetatable(v9, v10)
end
function u7.Lock(p11) --[[ Line: 29 ]]
    local v12 = not p11._container
    assert(v12, "Cannot bootstrap game when legacy loader was already used")
    p11._locked = true
end
function u7.GetLoader(_, p13) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    return u6.new(p13)
end
function u7.Require(p14, p15) --[[ Line: 38 ]]
    local v16 = not p14._locked
    assert(v16, "Cannot use legacy loader after already transformed")
    p14:_setupIfNeeded()
    if type(p15) == "number" then
        return require(p15)
    elseif type(p15) == "string" then
        local v17 = p14._lookupMap[p15]
        if v17 then
            return require(v17)
        end
        error("Error: Library \'" .. tostring(p15) .. "\' does not exist.", 2)
    else
        if typeof(p15) == "Instance" and p15:IsA("ModuleScript") then
            return require(p15)
        end
        error(("Error: module must be a string or ModuleScript, got \'%s\' for \'%s\'"):format(typeof(p15), (tostring(p15))))
    end
end
function u7._buildLookupContainer(p18) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    for _, v19 in pairs(p18._container:GetDescendants()) do
        if v19:IsA("ModuleScript") and not v19:FindFirstAncestorWhichIsA("ModuleScript") then
            local v20
            if u5.isBounceTemplate(v19) then
                v20 = u5.getTarget(v19) or v19
            else
                v20 = v19
            end
            local v21 = p18._lookupMap[v19.Name]
            if v21 then
                if v20 ~= v21 then
                    warn(("[LegacyLoader] - Duplicate module %q found, using first found\n\t(1) %s (used)\n\t(2) %s"):format(v19.Name, p18._lookupMap[v19.Name]:GetFullName(), v19:GetFullName()))
                end
            else
                p18._lookupMap[v19.Name] = v20
            end
        end
    end
end
function u7._setupIfNeeded(p22) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
        [4] = u4
    --]]
    local v23 = rawget(p22, "_container")
    if v23 then
        return v23
    else
        local v24 = p22._script.Name == "Nevermore"
        assert(v24, "Cannot invoke legacy mode if not at ReplicatedStorage.Nevermore")
        local v25 = p22._script.Parent == u2
        assert(v25, "Cannot invoke legacy mode if not at ReplicatedStorage.Nevermore")
        if u1:IsRunning() then
            if u1:IsServer() and u1:IsClient() or not u1:IsRunning() then
                if u1:IsRunning() then
                    error("Warning: Loading all modules in PlaySolo. It\'s recommended you use accurate play solo.")
                    return
                end
            else
                if u1:IsServer() then
                    local v26 = u3:FindFirstChild("Nevermore") or error("No ServerScriptService.Nevermore folder")
                    local v27, v28, v29 = u4.toWallyFormat(v26)
                    v27.Name = "_nevermoreClient"
                    v27.Parent = u2
                    v29.Name = "_nevermoreShared"
                    v29.Parent = u2
                    v28.Name = "_nevermoreServer"
                    v28.Parent = u3
                    rawset(p22, "_container", v28)
                    p22:_buildLookupContainer()
                    return
                end
                if u1:IsClient() then
                    local v30 = u2:WaitForChild("_nevermoreClient", 2)
                    if not v30 then
                        warn("[Nevermore] - Be sure to call require(ServerScriptService.Nevermore) on the server to replicate nevermore")
                        v30 = u2:WaitForChild("_nevermoreClient")
                    end
                    rawset(p22, "_container", v30)
                    p22:_buildLookupContainer()
                    return
                end
                error("Error: Unknown RunService state (Not client/server/test mode)")
            end
        else
            error("Test mode not supported")
        end
    end
end
return u7
 

local v1 = {}
local u2 = {}
local u3 = {}
local u4 = 0
local u5 = Instance.new("Folder")
u5.Name = "__ParallelWorkers"
u5.Parent = game:GetService("Players").LocalPlayer.PlayerScripts
local u6 = script.ClientWorker
local function u11() --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u6
        [3] = u5
    --]]
    for _, v7 in ipairs(u2) do
        if v7.available then
            return v7
        end
    end
    local v8 = u6:Clone()
    v8.Parent = u5
    local v9 = {
        ["run"] = require(v8.WorkerMain),
        ["available"] = true
    }
    local v10 = u2
    table.insert(v10, v9)
    return v9
end
function v1.runParallel(p12, ...) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u4
        [3] = u3
    --]]
    local v13 = u11()
    u4 = u4 + 1
    v13.available = false
    v13.run(p12, ...)
    v13.available = true
    u4 = u4 - 1
    if u4 == 0 then
        for _, v14 in next, u3 do
            task.spawn(v14)
        end
        table.clear(u3)
    end
end
function v1.waitForThreads() --[[ Line: 50 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
    --]]
    if u4 ~= 0 then
        local v15 = u3
        local v16 = coroutine.running
        table.insert(v15, v16())
        coroutine.yield()
    end
end
return v1
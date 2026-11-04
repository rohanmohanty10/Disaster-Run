 

local u1 = require("../mod/utility")
local u2 = {}
u2.__index = u2
local u3 = table.create(10000)
local u4 = table.create(10000)
local u5 = false
local u6 = coroutine.create(function() --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
    --]]
    while true do
        workspace:BulkMoveTo(u3, u4, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(u3)
        table.clear(u4)
        u5 = false
        coroutine.yield()
    end
end)
function u2.new(p7, p8, p9) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = u2
    local u11 = setmetatable({}, v10)
    u11.ref = p7
    u11.parent = p8
    u11.amount = 0
    u11.restore_amount = 0
    local v12 = p9 or {}
    for v13, v14 in {
        ["size"] = 100,
        ["excess_lifetime"] = 30
    } do
        if v12[v13] == nil then
            v12[v13] = v14
        end
    end
    u11.params = v12
    u11.scope = { p7, p8 }
    u11.unused = table.create(u11.params.size)
    u11.item_map = {}
    u11.part_mode = p7:IsA("BasePart")
    for _ = 1, u11.params.size do
        u11:_add()
    end
    local v15 = u11.scope
    local v16 = task.spawn
    table.insert(v15, v16(function() --[[ Line: 93 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        while true do
            if not task.wait(15) then
                return
            end
            if u11.restore_amount > 0 then
                for _ = 1, u11.restore_amount do
                    u11:_add()
                    local v17 = u11
                    v17.restore_amount = v17.restore_amount - 1
                end
            end
            if u11.amount > u11.params.size then
                local v18 = 0
                for v19 = 1, #u11.unused do
                    if u11.amount <= u11.params.size then
                        break
                    end
                    local v20 = v19 - v18
                    local v21 = u11.unused[v20]
                    if v21.dependents == 0 and os.clock() - v21.added <= u11.params.excess_lifetime then
                        v21.value:Destroy()
                        table.remove(u11.unused, v20)
                        u11.item_map[v21.key] = nil
                        local v22 = u11
                        v22.amount = v22.amount - 1
                        v18 = v18 + 1
                    end
                end
            end
        end
    end))
    return u11
end
function u2._add(u23, p24, p25) --[[ Line: 137 ]]
    local v26 = u23.ref:Clone()
    v26.Archivable = false
    v26.Parent = u23.parent
    local u27 = {
        ["key"] = p24,
        ["value"] = v26,
        ["added"] = os.clock(),
        ["dependents"] = 1
    }
    u23.amount = u23.amount + 1
    v26.Destroying:Connect(function() --[[ Line: 152 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u27
        --]]
        local v28 = table.find(u23.unused, u27)
        if v28 then
            table.remove(u23.unused, v28)
        end
        if u27.key then
            u23.item_map[u27.key] = nil
        end
        local v29 = u23
        v29.amount = v29.amount - 1
        local v30 = u23
        v30.restore_amount = v30.restore_amount + 1
    end)
    if p24 then
        u23.item_map[p24] = u27
    end
    if not p25 then
        local v31 = u23.unused
        table.insert(v31, u27)
    end
    return u27
end
function u2.has(p32, p33) --[[ Line: 178 ]]
    return p32.item_map[p33] and true or false
end
function u2.peek(p34, p35) --[[ Line: 182 ]]
    return p34.item_map[p35]
end
function u2.get(p36, p37) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u5
        [4] = u6
    --]]
    if p36:has(p37) then
        local v38 = p36:peek(p37)
        if v38 then
            v38.dependents = v38.dependents + 1
        end
        return v38.value
    end
    local u39 = table.remove(p36.unused)
    if u39 then
        u39.key = p37
        u39.added = os.clock()
        p36.item_map[p37] = u39
    else
        u39 = p36:_add(p37, true)
    end
    if not p36.part_mode then
        return u39.value
    end
    local v47 = {
        ["__newindex"] = function(_, p40, p41) --[[ Name: __newindex, Line 211 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u39
                [3] = u4
                [4] = u5
                [5] = u6
            --]]
            if p40 == "CFrame" then
                local v42 = u3
                local v43 = u39.value
                table.insert(v42, v43)
                local v44 = u4
                table.insert(v44, p41)
                if not u5 then
                    u5 = true
                    task.defer(u6)
                    return
                end
            else
                u39.value[p40] = p41
            end
        end,
        ["__index"] = function(_, p45) --[[ Name: __index, Line 225 ]]
            --[[
            Upvalues:
                [1] = u39
            --]]
            local u46 = u39.value[p45]
            return typeof(u46) == "function" and function(_, ...) --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u39
                --]]
                return u46(u39.value, ...)
            end or u46
        end
    }
    return setmetatable({
        ["_getReal"] = function() --[[ Name: _getReal, Line 238 ]]
            --[[
            Upvalues:
                [1] = u39
            --]]
            return u39.value
        end
    }, v47)
end
function u2.free(p48, p49) --[[ Line: 247 ]]
    local v50 = p48.item_map[p49]
    if v50 then
        local v51 = v50.dependents - 1
        v50.dependents = math.max(v51, 0)
        if v50.dependents == 0 then
            v50.added = os.clock()
            if p48.params.on_free then
                task.spawn(p48.params.on_free, v50)
            end
            local v52 = p48.unused
            table.insert(v52, v50)
        end
    end
end
function u2.destroy(p53) --[[ Line: 267 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    u1.cleanupScope(p53.scope)
    for _, v54 in p53.item_map do
        v54.value:Destroy()
    end
    table.clear(p53.unused)
    table.clear(p53.item_map)
end
return u2
 

local u1 = CFrame.new(16777216, 16777216, 16777216)
local u2 = table.create(10000)
local u3 = table.create(10000)
local u4 = false
local function v5() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    while true do
        workspace:BulkMoveTo(u2, u3, Enum.BulkMoveMode.FireCFrameChanged)
        table.clear(u2)
        table.clear(u3)
        u4 = false
        coroutine.yield()
    end
end
local u6 = coroutine.create(v5)
local u7 = {}
u7.__index = u7
function u7._GetNew(p8, p9, p10) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p10 then
        warn((("ObjectCache: Cache retrieval exceeded preallocated amount! expanding by %*..."):format(p9)))
    end
    local v11 = p8._FreeObjects
    local v12 = #p8._FreeObjects
    local v13 = p8.CacheHolder
    local v14 = p8._IsTemplateModel
    local v15 = p8._Template
    local v16 = table.create(p9)
    local v17 = table.create(p9)
    local v18 = table.create(p9)
    for v19 = v12 + 1, v12 + p9 do
        local v20 = v15:Clone()
        local v21
        if v14 then
            v21 = v20.PrimaryPart
        else
            v21 = v20
        end
        v11[v19] = v21
        local v22 = v19 - v12
        v16[v22] = v21
        v17[v22] = u1
        v18[v22] = v20
    end
    workspace:BulkMoveTo(v16, v17, Enum.BulkMoveMode.FireCFrameChanged)
    for _, v23 in v18 do
        v23.Parent = v13
    end
    return table.remove(v11)
end
function u7.GetPart(p24, p25) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u6
    --]]
    local v26 = table.remove(p24._FreeObjects) or p24:_GetNew(p24._ExpandAmount, true)
    p24._Objects[v26] = nil
    if p24._ReturnFunction then
        p24._ReturnFunction(v26)
    end
    if p25 then
        local v27 = u2
        table.insert(v27, v26)
        local v28 = u3
        table.insert(v28, p25)
        if not u4 then
            u4 = true
            task.defer(u6)
        end
    end
    return v26
end
function u7.ReturnPart(p29, p30) --[[ Line: 84 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u1
        [4] = u4
        [5] = u6
    --]]
    if not p29._Objects[p30] then
        if p29._ReturnFunction then
            p29._ReturnFunction(p30)
        end
        p30.Parent = p29.CacheHolder
        p29._Objects[p30] = true
        local v31 = p29._FreeObjects
        table.insert(v31, p30)
        local v32 = u2
        table.insert(v32, p30)
        local v33 = u3
        local v34 = u1
        table.insert(v33, v34)
        if not u4 then
            u4 = true
            task.defer(u6)
        end
    end
end
function u7.Update(_) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    task.spawn(u6)
end
function u7.ExpandCache(p35, p36) --[[ Line: 112 ]]
    local v37 = typeof(p36) ~= "number" and true or p36 >= 0
    local v38 = ("Invalid argument #1 to \'ObjectCache:ExpandCache\' (positive number expected, got %*)"):format((typeof(p36)))
    assert(v37, v38)
    p35:_GetNew(p36, false)
end
function u7.SetExpandAmount(p39, p40) --[[ Line: 116 ]]
    local v41 = typeof(p40) ~= "number" and true or p40 > 0
    local v42 = ("Invalid argument #1 to \'ObjectCache:SetExpandAmount\' (positive number expected, got %*)"):format((typeof(p40)))
    assert(v41, v42)
    p39._ExpandAmount = p40
end
function u7.IsInUse(p43, p44) --[[ Line: 121 ]]
    return p43._Objects[p44] == nil
end
function u7.Destroy(p45) --[[ Line: 125 ]]
    p45.CacheHolder:Destroy()
end
return {
    ["new"] = function(p46, p47, p48, p49) --[[ Name: new, Line 137 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u7
        --]]
        local v50 = typeof(p46)
        local v51 = v50 == "Instance"
        local v52 = ("Invalid argument #1 to \'ObjectCache.new\' (BasePart expected, got %*)"):format(v50)
        assert(v51, v52)
        local v53 = p46:IsA("BasePart") or p46:IsA("Model")
        local v54 = ("Invalid argument #1 to \'ObjectCache.new\' (BasePart or Model expected, got %*)"):format(p46.ClassName)
        assert(v53, v54)
        local v55 = p46.Archivable
        assert(v55, "ObjectCache: Cannot use template object provided, as it has Archivable set to false.")
        if p46:IsA("Model") then
            local v56 = p46.PrimaryPart ~= nil
            assert(v56, "Invalid Template provided to \'ObjectCache.new\': Model has no PrimaryPart set!")
        end
        local v57 = typeof(p47)
        local v58 = p47 == nil and true or v57 == "number"
        local v59 = ("Invalid argument #2 to \'ObjectCache.new\' (number expected, got %*)"):format(v57)
        assert(v58, v59)
        local v60 = p47 == nil and true or p47 >= 0
        local v61 = ("Invalid argument #2 to \'ObjectCache.new\' (positive number expected, got %*)"):format(p47)
        assert(v60, v61)
        local v62 = typeof(p48)
        local v63 = p48 == nil and true or v62 == "Instance"
        local v64 = ("Invalid argument #3 to \'ObjectCache.new\' (Instance expected, got %*)"):format(v62)
        assert(v63, v64)
        local v65 = p47 or 10
        local v66 = Instance.new("Folder")
        v66.Name = "ObjectCache"
        local v67 = table.create(v65)
        local v68 = table.create(v65)
        local v69 = p46:IsA("Model")
        local v70 = {}
        for v71 = 1, v65 do
            local v72 = p46:Clone()
            local v73
            if v69 then
                v73 = v72.PrimaryPart
            else
                v73 = v72
            end
            v67[v71] = v72
            v68[v71] = v73
            v73.CFrame = u1
            v72.Parent = v66
        end
        v66.Parent = p48 or workspace
        local v74 = {
            ["CacheHolder"] = v66,
            ["_ReturnFunction"] = p49 and p49.ReturnFunction or nil,
            ["_ExpandAmount"] = 50,
            ["_Template"] = p46,
            ["_FreeObjects"] = v68,
            ["_Objects"] = v70,
            ["_IsTemplateModel"] = v69,
            ["_PreallocatedAmount"] = v65
        }
        local v75 = u7
        return setmetatable(v74, v75)
    end
}
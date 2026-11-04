 

local u1 = {}
u1.__index = u1
local u2
if workspace:FindFirstChild("Cache") then
    u2 = nil
else
    u2 = Instance.new("Folder")
    u2.Name = "Cache"
    u2.Parent = workspace.Effects
end
local function u8(p3, p4) --[[ Line: 18 ]]
    local v5 = Instance.new(p3)
    for v6, v7 in next, p4 do
        if v6 ~= "Parent" and v5[v6] ~= nil then
            v5[v6] = v7
        end
    end
    v5.Parent = p4.Parent
    return v5
end
function clearTables(p9)
    for v10 = 1, #p9 do
        local v11 = p9[v10]
        if type(v11) == "table" then
            clearTables(p9)
        end
        p9[v10] = nil
    end
end
function u1.new(p12, p13, p14) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u8
        [3] = u2
    --]]
    local v15 = u1
    local v16 = setmetatable({}, v15)
    local v17 = u8("Folder", {
        ["Parent"] = u2,
        ["Name"] = p14 or "CachedFolder"
    })
    if p12:IsA("BasePart") or p12:IsA("MeshPart") then
        if not p12.Anchored then
            p12.Anchored = true
        end
    elseif p12:IsA("Model") then
        for _, _ in p12:GetChildren() do
            if (p12:IsA("BasePart") or p12:IsA("MeshPart")) and not p12.Anchored then
                p12.Anchored = true
            end
        end
    end
    v16.Active = {}
    v16.Inactive = {}
    v16.Cached = {}
    v16.ExtraObjects = {}
    v16.Template = p12
    v16.CacheArea = v17
    function v16.AddCache(p18, p19, p20) --[[ Line: 60 ]]
        for _ = 1, p19 do
            local v21 = p18.Template:Clone()
            v21.Position = Vector3.new(0, 1000000000, 0)
            v21.Parent = p18.CacheArea
            local v22 = p18.Cached
            table.insert(v22, v21)
            local v23 = p18.Inactive
            table.insert(v23, v21)
            if p20 then
                local v24 = p18.ExtraObjects
                table.insert(v24, v21)
            end
        end
    end
    function v16.GetObject(p25) --[[ Line: 73 ]]
        if p25.Inactive[1] then
            local v26 = p25.Inactive[1]
            table.remove(p25.Inactive, table.find(p25.Inactive, v26))
            local v27 = p25.Active
            table.insert(v27, v26)
            return v26
        end
        p25:AddCache(1, true)
        local v28 = p25.Inactive[1]
        table.remove(p25.Inactive, table.find(p25.Inactive, v28))
        local v29 = p25.Active
        table.insert(v29, v28)
        return v28
    end
    function v16.ReturnObject(p30, p31) --[[ Line: 90 ]]
        if table.find(p30.Cached, p31) then
            table.remove(p30.Active, table.find(p30.Inactive, p31))
            if table.find(p30.ExtraObjects, p31) then
                p31:Destroy()
                return
            end
            local v32 = p30.Inactive
            table.insert(v32, p31)
            if (p31:IsA("BasePart") or p31:IsA("MeshPart")) and not p31.Anchored then
                p31.Anchored = true
            end
            p31.Position = Vector3.new(0, 1000000000, 0)
        end
    end
    function v16.Delete(p33) --[[ Line: 106 ]]
        p33.CacheArea:Destroy()
        clearTables(p33)
        warn("CACHED DESTROYED")
    end
    function v16.DeleteExtra(p34) --[[ Line: 127 ]]
        for _, v35 in ipairs(p34.ExtraCache) do
            if os.clock() - v35[2] >= 60 then
                table.find(p34.Active, v35)
            end
        end
    end
    v16:AddCache(p13 or 20)
    warn("CACHED CREATED")
    return v16
end
return u1
 

local u1 = script.Parent
local u2 = require(script.Parent.ScriptInfoUtils)
local u3 = require(script.Parent.LoaderUtils)
local u4 = require(script.Parent.BounceTemplateUtils)
local u5 = {
    ["ClassName"] = "StaticLegacyLoader"
}
u5.__index = u5
function u5.new() --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v6 = u5
    return setmetatable({
        ["_packageLookups"] = {}
    }, v6)
end
function u5.__call(p7, p8) --[[ Line: 23 ]]
    return p7:Require(p8)
end
function u5.Lock(_) --[[ Line: 27 ]]
    error("Cannot start loader while not running")
end
function u5.Require(p9, p10, p11) --[[ Line: 31 ]]
    if type(p11) == "number" then
        return require(p11)
    elseif type(p11) == "string" then
        local v12 = p9:_findModule(p10, p11)
        if v12 then
            p9:_ensureFakeLoader(v12)
            return require(v12)
        end
        error("Error: Library \'" .. tostring(p11) .. "\' does not exist.", 2)
    else
        if typeof(p11) == "Instance" and p11:IsA("ModuleScript") then
            return require(p11)
        end
        error(("Error: module must be a string or ModuleScript, got \'%s\' for \'%s\'"):format(typeof(p11), (tostring(p11))))
    end
end
function u5._findModule(p13, p14, p15) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v16 = typeof(p14) == "Instance"
    assert(v16, "Bad root")
    local v17 = type(p15) == "string"
    assert(v17, "Bad name")
    local v18 = p13:_findPackageRoot(p14)
    while v18 do
        local v19 = p13:_getOrCreateLookup(v18)
        if v19[p15] then
            return v19[p15]
        end
        local v20 = v18:FindFirstChild(u2.DEPENDENCY_FOLDER_NAME)
        if v20 then
            for _, v21 in pairs(v20:GetChildren()) do
                if v21:IsA("Folder") and v21.Name:sub(1, 1) == "@" then
                    for _, v22 in pairs(v21:GetChildren()) do
                        local v23 = p13:_getPackageFolderLookup(v22)
                        if v23[p15] then
                            return v23[p15]
                        end
                    end
                else
                    local v24 = p13:_getPackageFolderLookup(v21)
                    if v24[p15] then
                        return v24[p15]
                    end
                end
            end
        end
        v18 = p13:_findPackageRoot(v18)
    end
    return nil
end
function u5.GetLoader(u25, u26) --[[ Line: 91 ]]
    local v27 = typeof(u26) == "Instance"
    assert(v27, "Bad moduleScript")
    return setmetatable({}, {
        ["__call"] = function(_, p28) --[[ Name: __call, Line 95 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u26
            --]]
            return u25:Require(u26, p28)
        end,
        ["__index"] = function(_, p29) --[[ Name: __index, Line 98 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u26
            --]]
            return u25:Require(u26, p29)
        end
    })
end
function u5._getPackageFolderLookup(p30, p31) --[[ Line: 104 ]]
    if p31:IsA("ObjectValue") then
        if p31.Value then
            return p30:_getOrCreateLookup(p31.Value)
        end
        warn("[StaticLegacyLoader] - Bad link in packageFolder")
        return {}
    end
    if p31:IsA("Folder") then
        return p30:_getOrCreateLookup(p31)
    end
    if p31:IsA("ModuleScript") then
        return p30:_getOrCreateLookup(p31)
    end
    warn(("Unknown instance %q (%s) in dependencyFolder - %q"):format(p31.Name, p31.ClassName, p31:GetFullName()))
    return {}
end
function u5._getOrCreateLookup(p32, p33) --[[ Line: 123 ]]
    local v34 = typeof(p33) == "Instance"
    assert(v34, "Bad packageFolderOrModuleScript")
    if p32._packageLookups[p33] then
        return p32._packageLookups[p33]
    end
    local v35 = {}
    p32:_buildLookup(v35, p33)
    p32._packageLookups[p33] = v35
    return v35
end
function u5._buildLookup(p36, p37, p38) --[[ Line: 138 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p38:IsA("Folder") then
        if p38.Name ~= u2.DEPENDENCY_FOLDER_NAME then
            for _, v39 in pairs(p38:GetChildren()) do
                p36:_buildLookup(p37, v39)
            end
            return
        end
    elseif p38:IsA("ModuleScript") then
        p37[p38.Name] = p38
    end
end
function u5._findPackageRoot(_, p40) --[[ Line: 150 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v41 = typeof(p40) == "Instance"
    assert(v41, "Bad instance")
    local v42 = p40.Parent
    while v42 and v42 ~= game do
        if u3.isPackage(v42) then
            return v42
        end
        v42 = v42.Parent
    end
    return nil
end
function u5._ensureFakeLoader(_, p43) --[[ Line: 166 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u1
    --]]
    local v44 = typeof(p43) == "Instance"
    assert(v44, "Bad module")
    local v45 = p43.Parent
    if v45 then
        local v46 = Load and true or false
        local v47 = v45:FindFirstChild("loader")
        if v47 then
            if u4.isBounceTemplate(v47) then
                v47.Archivable = v46
            end
        else
            local v48 = u4.create(u1, "loader")
            v48.Archivable = v46
            v48.Parent = v45
        end
    else
        warn("[StaticLegacyLoader] - No parent")
        return
    end
end
return u5
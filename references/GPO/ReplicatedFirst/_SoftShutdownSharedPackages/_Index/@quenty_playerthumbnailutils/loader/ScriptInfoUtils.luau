 

local u1 = game:GetService("CollectionService")
local u2 = script.Parent
local u3 = require(script.Parent.Utils)
local u4 = require(script.Parent.BounceTemplateUtils)
local u23 = {
    ["DEPENDENCY_FOLDER_NAME"] = "node_modules",
    ["ModuleReplicationTypes"] = u3.readonly({
        ["CLIENT"] = "client",
        ["SERVER"] = "server",
        ["SHARED"] = "shared",
        ["IGNORE"] = "ignore",
        ["PLUGIN"] = "plugin"
    }),
    ["createScriptInfo"] = function(p5, p6, p7) --[[ Name: createScriptInfo, Line 23 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v8 = typeof(p5) == "Instance"
        assert(v8, "Bad instance")
        local v9 = type(p6) == "string"
        assert(v9, "Bad name")
        local v10 = type(p7) == "string"
        assert(v10, "Bad replicationMode")
        return u3.readonly({
            ["name"] = p6,
            ["replicationMode"] = p7,
            ["instance"] = p5
        })
    end,
    ["createScriptInfoLookup"] = function() --[[ Name: createScriptInfoLookup, Line 35 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u23
        --]]
        return u3.readonly({
            [u23.ModuleReplicationTypes.SERVER] = {},
            [u23.ModuleReplicationTypes.CLIENT] = {},
            [u23.ModuleReplicationTypes.SHARED] = {},
            [u23.ModuleReplicationTypes.PLUGIN] = {}
        })
    end,
    ["getScriptInfoLookupForMode"] = function(p11, p12) --[[ Name: getScriptInfoLookupForMode, Line 45 ]]
        local v13 = type(p11) == "table"
        assert(v13, "Bad scriptInfoLookup")
        local v14 = type(p12) == "string"
        assert(v14, "Bad replicationMode")
        return p11[p12]
    end,
    ["populateScriptInfoLookup"] = function(p15, p16, p17) --[[ Name: populateScriptInfoLookup, Line 52 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u4
            [3] = u2
        --]]
        local v18 = typeof(p15) == "Instance"
        assert(v18, "Bad instance")
        local v19 = type(p16) == "table"
        assert(v19, "Bad scriptInfoLookup")
        local v20 = type(p17) == "string"
        assert(v20, "Bad lastReplicationMode")
        if p15:IsA("Folder") then
            local v21 = u23.getFolderReplicationMode(p15.Name, p17)
            if v21 ~= u23.ModuleReplicationTypes.IGNORE then
                for _, v22 in pairs(p15:GetChildren()) do
                    if not u4.isBounceTemplate(v22) then
                        if v22:IsA("Folder") then
                            u23.populateScriptInfoLookup(v22, p16, v21)
                        elseif v22:IsA("ModuleScript") then
                            u23.addToInfoMap(p16, u23.createScriptInfo(v22, v22.Name, v21))
                        end
                    end
                end
                return
            end
        elseif p15:IsA("ModuleScript") then
            if not u4.isBounceTemplate(p15) then
                if p15 == u2 then
                    u23.addToInfoMap(p16, u23.createScriptInfo(p15, "loader", p17))
                else
                    u23.addToInfoMap(p16, u23.createScriptInfo(p15, p15.Name, p17))
                end
            end
        elseif p15:IsA("ObjectValue") then
            error("ObjectValue links are not supported at this time for retrieving inline module scripts")
        end
    end
}
local u24 = {
    ["HoldingBindersServer"] = true,
    ["HoldingBindersClient"] = true,
    ["IKService"] = true,
    ["IKServiceClient"] = true
}
function u23.isAvailableInShared(p25) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u24
    --]]
    return u1:HasTag(p25.instance, "LinkToShared") and true or u24[p25.name]
end
function u23.addToInfoMap(p26, p27) --[[ Line: 103 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v28 = type(p26) == "table"
    assert(v28, "Bad scriptInfoLookup")
    local v29 = type(p27) == "table"
    assert(v29, "Bad scriptInfo")
    local v30 = p27.replicationMode
    local v31 = assert(v30, "Bad replicationMode")
    local v32 = p26[v31]
    local v33 = assert(v32, "Bad replicationMode")
    u23.addToInfoMapForMode(v33, p27)
    if v31 == u23.ModuleReplicationTypes.SHARED then
        u23.addToInfoMapForMode(p26[u23.ModuleReplicationTypes.SERVER], p27)
        u23.addToInfoMapForMode(p26[u23.ModuleReplicationTypes.CLIENT], p27)
    elseif u23.isAvailableInShared(p27) then
        u23.addToInfoMapForMode(p26[u23.ModuleReplicationTypes.SHARED], p27)
    end
end
function u23.addToInfoMapForMode(p34, p35) --[[ Line: 123 ]]
    if p34[p35.name] then
        warn(("Duplicate module %q in same package under same replication scope. Only using first one. \n- %q\n- %q"):format(p35.name, p35.instance:GetFullName(), p34[p35.name].instance:GetFullName()))
    else
        p34[p35.name] = p35
    end
end
function u23.getFolderReplicationMode(p36, p37) --[[ Line: 135 ]]
    --[[
    Upvalues:
        [1] = u23
    --]]
    local v38 = type(p36) == "string"
    assert(v38, "Bad folderName")
    local v39 = type(p37) == "string"
    assert(v39, "Bad lastReplicationMode")
    if p36 == u23.DEPENDENCY_FOLDER_NAME then
        return u23.ModuleReplicationTypes.IGNORE
    elseif p37 == u23.ModuleReplicationTypes.PLUGIN then
        return p37
    elseif p36 == "Shared" then
        return u23.ModuleReplicationTypes.SHARED
    elseif p36 == "Client" then
        return u23.ModuleReplicationTypes.CLIENT
    elseif p36 == "Server" then
        return u23.ModuleReplicationTypes.SERVER
    else
        return p37
    end
end
return u23
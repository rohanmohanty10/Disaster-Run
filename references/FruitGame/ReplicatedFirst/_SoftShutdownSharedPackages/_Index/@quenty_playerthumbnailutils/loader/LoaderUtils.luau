 

local u1 = script.Parent
local u2 = require(script.Parent.BounceTemplateUtils)
local u3 = require(script.Parent.GroupInfoUtils)
local u4 = require(script.Parent.PackageInfoUtils)
local u5 = require(script.Parent.ScriptInfoUtils)
local v6 = require(script.Parent.Utils)
local u74 = {
    ["Utils"] = v6,
    ["ContextTypes"] = v6.readonly({
        ["CLIENT"] = "client",
        ["SERVER"] = "server"
    }),
    ["IncludeBehavior"] = v6.readonly({
        ["NO_INCLUDE"] = "noInclude",
        ["INCLUDE_ONLY"] = "includeOnly",
        ["INCLUDE_SHARED"] = "includeShared"
    }),
    ["toWallyFormat"] = function(p7, p8) --[[ Name: toWallyFormat, Line 26 ]]
        --[[
        Upvalues:
            [1] = u74
            [2] = u5
            [3] = u4
            [4] = u3
        --]]
        local v9 = typeof(p7) == "Instance"
        assert(v9, "Bad instance")
        local v10 = type(p8) == "boolean"
        assert(v10, "Bad isPlugin")
        local v11 = {}
        u74.discoverTopLevelPackages(v11, p7)
        u74.injectLoader(v11)
        local v12 = p8 and u5.ModuleReplicationTypes.PLUGIN or u5.ModuleReplicationTypes.SHARED
        local v13 = {}
        local v14 = {}
        for _, v15 in pairs(v11) do
            local v16 = u4.getOrCreatePackageInfo(v15, v13, "", v12)
            table.insert(v14, v16)
        end
        u4.fillDependencySet(v14)
        if p8 then
            local v17 = u3.groupPackageInfos(v14, u5.ModuleReplicationTypes.PLUGIN)
            local v18 = u74.getPublishPackageInfoSet(v14)
            local v19 = Instance.new("Folder")
            v19.Name = "PluginPackages"
            u74.reifyGroupList(v17, v18, v19, u5.ModuleReplicationTypes.PLUGIN)
            return v19
        end
        local v20 = u3.groupPackageInfos(v14, u5.ModuleReplicationTypes.CLIENT)
        local v21 = u3.groupPackageInfos(v14, u5.ModuleReplicationTypes.SERVER)
        local v22 = u3.groupPackageInfos(v14, u5.ModuleReplicationTypes.SHARED)
        local v23 = u74.getPublishPackageInfoSet(v14)
        local v24 = Instance.new("Folder")
        v24.Name = "Packages"
        local v25 = Instance.new("Folder")
        v25.Name = "SharedPackages"
        local v26 = Instance.new("Folder")
        v26.Name = "Packages"
        u74.reifyGroupList(v20, v23, v24, u5.ModuleReplicationTypes.CLIENT)
        u74.reifyGroupList(v21, v23, v26, u5.ModuleReplicationTypes.SERVER)
        u74.reifyGroupList(v22, v23, v25, u5.ModuleReplicationTypes.SHARED)
        return v24, v26, v25
    end,
    ["isPackage"] = function(p27) --[[ Name: isPackage, Line 86 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v28 = typeof(p27) == "Instance"
        assert(v28, "Bad instance")
        for _, v29 in pairs(p27:GetChildren()) do
            if v29:IsA("Folder") and (v29.Name == "Server" or (v29.Name == "Client" or (v29.Name == "Shared" or v29.Name == u5.DEPENDENCY_FOLDER_NAME))) then
                return true
            end
        end
        return false
    end,
    ["injectLoader"] = function(p30) --[[ Name: injectLoader, Line 103 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        for _, v31 in pairs(p30) do
            if v31 == u1 or u1:IsDescendantOf(v31) then
                return
            end
        end
        local v32 = u1
        table.insert(p30, v32)
    end,
    ["discoverTopLevelPackages"] = function(p33, p34) --[[ Name: discoverTopLevelPackages, Line 115 ]]
        --[[
        Upvalues:
            [1] = u74
        --]]
        local v35 = type(p33) == "table"
        assert(v35, "Bad packages")
        local v36 = typeof(p34) == "Instance"
        assert(v36, "Bad instance")
        if u74.isPackage(p34) then
            table.insert(p33, p34)
        elseif p34:IsA("ObjectValue") then
            local v37 = p34.Value
            if v37 and u74.isPackage(v37) then
                table.insert(p33, v37)
                return
            end
        else
            for _, v38 in pairs(p34:GetChildren()) do
                if v38:IsA("Folder") then
                    u74.discoverTopLevelPackages(p33, v38)
                elseif v38:IsA("ObjectValue") then
                    local v39 = v38.Value
                    if v39 and u74.isPackage(v39) then
                        table.insert(p33, v39)
                    end
                elseif v38:IsA("ModuleScript") then
                    table.insert(p33, v38)
                end
            end
        end
    end,
    ["reifyGroupList"] = function(p40, p41, p42, p43) --[[ Name: reifyGroupList, Line 143 ]]
        --[[
        Upvalues:
            [1] = u74
            [2] = u2
        --]]
        local v44 = type(p40) == "table"
        assert(v44, "Bad groupInfoList")
        local v45 = type(p41) == "table"
        assert(v45, "Bad publishSet")
        local v46 = typeof(p42) == "Instance"
        assert(v46, "Bad parent")
        local v47 = type(p43) == "string"
        assert(v47, "Bad replicationMode")
        local v48 = Instance.new("Folder")
        v48.Name = "_Index"
        for _, v49 in pairs(p40) do
            if u74.needToReify(v49, p43) then
                u74.reifyGroup(v49, v48, p43)
            end
        end
        for v50, _ in pairs(p41) do
            for v51, v52 in pairs(v50.scriptInfoLookup[p43]) do
                u2.create(v52.instance, v51).Parent = p42
            end
        end
        v48.Parent = p42
    end,
    ["getPublishPackageInfoSet"] = function(p53) --[[ Name: getPublishPackageInfoSet, Line 169 ]]
        local v54 = {}
        for _, v55 in pairs(p53) do
            v54[v55] = true
            for v56, _ in pairs(v55.explicitDependencySet) do
                v54[v56] = true
            end
        end
        return v54
    end,
    ["needToReify"] = function(p57, p58) --[[ Name: needToReify, Line 181 ]]
        for _, v59 in pairs(p57.packageScriptInfoMap) do
            if v59.replicationMode == p58 then
                return true
            end
        end
        return false
    end,
    ["reifyGroup"] = function(p60, p61, p62) --[[ Name: reifyGroup, Line 191 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v63 = type(p60) == "table"
        assert(v63, "Bad groupInfo")
        local v64 = typeof(p61) == "Instance"
        assert(v64, "Bad parent")
        local v65 = type(p62) == "string"
        assert(v65, "Bad replicationMode")
        local v66 = Instance.new("Folder")
        local v67 = next(p60.packageSet).fullName
        v66.Name = assert(v67, "Bad package fullName")
        for v68, v69 in pairs(p60.packageScriptInfoMap) do
            local v70 = v69.name == v68
            assert(v70, "Bad scriptInfo.name")
            if v69.replicationMode == p62 then
                if v69.instance == u1 and u1.Parent == game:GetService("ReplicatedStorage") then
                    u2.create(v69.instance, v68).Parent = v66
                else
                    v69.instance.Name = v68
                    v69.instance.Parent = v66
                end
            elseif v69.instance == u1 then
                u2.create(v69.instance, v68).Parent = v66
            else
                u2.createLink(v69.instance, v68).Parent = v66
            end
        end
        for v71, v72 in pairs(p60.scriptInfoMap) do
            local v73 = v72.name == v71
            assert(v73, "Bad scriptInfo.name")
            if not p60.packageScriptInfoMap[v71] then
                if v72.instance == u1 then
                    u2.create(v72.instance, v71).Parent = v66
                else
                    u2.createLink(v72.instance, v71).Parent = v66
                end
            end
        end
        v66.Parent = p61
    end
}
return u74
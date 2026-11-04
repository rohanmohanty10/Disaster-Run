 

local u1 = require(script.Parent.BounceTemplateUtils)
local u2 = require(script.Parent.LoaderConstants)
local u3 = require(script.Parent.Queue)
local u4 = require(script.Parent.ScriptInfoUtils)
local u5 = require(script.Parent.Utils)
local u79 = {
    ["createPackageInfo"] = function(p6, p7, p8, p9) --[[ Name: createPackageInfo, Line 15 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v10 = typeof(p6) == "Instance"
        assert(v10, "Bad packageFolder")
        local v11 = type(p7) == "table"
        assert(v11, "Bad explicitDependencySet")
        local v12 = type(p8) == "table"
        assert(v12, "Bad scriptInfoLookup")
        local v13 = type(p9) == "string"
        assert(v13, "Bad fullName")
        return u5.readonly({
            ["name"] = p6.Name,
            ["fullName"] = p9,
            ["instance"] = p6,
            ["explicitDependencySet"] = p7,
            ["dependencySet"] = false,
            ["scriptInfoLookup"] = p8
        })
    end,
    ["createDependencyQueueInfo"] = function(p14, p15) --[[ Name: createDependencyQueueInfo, Line 31 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v16 = type(p14) == "table"
        assert(v16, "Bad packageInfo")
        local v17 = type(p15) == "table"
        assert(v17, "Bad implicitDependencySet")
        return u5.readonly({
            ["packageInfo"] = p14,
            ["implicitDependencySet"] = p15
        })
    end,
    ["fillDependencySet"] = function(p18) --[[ Name: fillDependencySet, Line 41 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u79
        --]]
        local v19 = type(p18) == "table"
        assert(v19, "Bad packageInfoList")
        local v20 = u3.new()
        local v21 = {}
        local v22 = {}
        for _, v23 in pairs(p18) do
            if not v21[v23] then
                v22[v23] = v23
                v21[v23] = true
                v20:PushRight(u79.createDependencyQueueInfo(v23, v22))
            end
        end
        while not v20:IsEmpty() do
            local v24 = v20:PopLeft()
            local v25 = not v24.packageInfo.dependencySet
            assert(v25, "Already wrote dependencySet")
            local v26 = u79.computePackageDependencySet(v24.packageInfo, v24.implicitDependencySet)
            v24.packageInfo.dependencySet = v26
            for v27, _ in pairs(v24.packageInfo.explicitDependencySet) do
                if not v21[v27] then
                    v21[v27] = true
                    v20:PushRight(u79.createDependencyQueueInfo(v27, v26))
                end
            end
        end
    end,
    ["computePackageDependencySet"] = function(p28, p29) --[[ Name: computePackageDependencySet, Line 79 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v30 = type(p28) == "table"
        assert(v30, "Bad packageInfo")
        local v31 = type(p29) == "table"
        assert(v31, "Bad implicitDependencySet")
        local v32 = {}
        if u2.INCLUDE_IMPLICIT_DEPENDENCIES then
            for v33, _ in pairs(p29) do
                v32[v33.name] = v33
            end
        end
        for v34, _ in pairs(p28.explicitDependencySet) do
            v32[v34.name] = v34
        end
        v32[p28.name] = nil
        local v35 = {}
        for _, v36 in pairs(v32) do
            v35[v36] = true
        end
        return v35
    end,
    ["getOrCreatePackageInfo"] = function(p37, p38, p39, p40) --[[ Name: getOrCreatePackageInfo, Line 110 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u79
        --]]
        local v41 = typeof(p37) == "Instance"
        assert(v41, "Bad packageFolder")
        local v42 = type(p38) == "table"
        assert(v42, "Bad packageInfoMap")
        local v43 = type(p39) == "string"
        assert(v43, "Bad scope")
        assert(p40, "No defaultReplicationType")
        if p38[p37] then
            return p38[p37]
        end
        local v44 = u4.createScriptInfoLookup()
        u4.populateScriptInfoLookup(p37, v44, p40)
        local v45 = {}
        local v46
        if p39 == "" then
            v46 = p37.Name
        else
            v46 = p39 .. "/" .. p37.Name
        end
        local v47 = u79.createPackageInfo(p37, v45, v44, v46)
        p38[p37] = v47
        u79.fillExplicitPackageDependencySet(v45, p37, p38, p40)
        return v47
    end,
    ["getPackageInfoListFromDependencyFolder"] = function(p48, p49, p50) --[[ Name: getPackageInfoListFromDependencyFolder, Line 148 ]]
        --[[
        Upvalues:
            [1] = u79
        --]]
        local v51
        if typeof(p48) == "Instance" then
            v51 = p48:IsA("Folder")
        else
            v51 = false
        end
        assert(v51, "Bad folder")
        local v52 = type(p49) == "table"
        assert(v52, "Bad packageInfoMap")
        assert(p50, "No defaultReplicationType")
        local v53 = {}
        for _, v54 in pairs(p48:GetChildren()) do
            if v54:IsA("Folder") then
                if v54.Name:sub(1, 1) == "@" then
                    local v55 = v54.Name
                    for _, v56 in pairs(v54:GetChildren()) do
                        u79.tryLoadPackageFromInstance(v53, p49, v56, v55, p50)
                    end
                else
                    u79.tryLoadPackageFromInstance(v53, p49, v54, "", p50)
                end
            else
                warn(("Unknown instance in dependencyFolder - %q"):format(v54:GetFullName()))
            end
        end
        return v53
    end,
    ["tryLoadPackageFromInstance"] = function(p57, p58, p59, p60, p61) --[[ Name: tryLoadPackageFromInstance, Line 176 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u79
        --]]
        local v62 = type(p57) == "table"
        assert(v62, "Bad packageInfoList")
        local v63 = type(p58) == "table"
        assert(v63, "Bad packageInfoMap")
        local v64 = typeof(p59) == "Instance"
        assert(v64, "Bad instance")
        local v65 = type(p60) == "string"
        assert(v65, "Bad scope")
        assert(p61, "No defaultReplicationType")
        if u1.isBounceTemplate(p59) then
            return
        elseif p59:IsA("Folder") or p59:IsA("ModuleScript") then
            local v66 = u79.getOrCreatePackageInfo
            table.insert(p57, v66(p59, p58, p60, p61))
        elseif p59:IsA("ObjectValue") then
            local v67 = p59.Value
            if v67 and (v67:IsA("Folder") or v67:IsA("ModuleScript")) then
                local v68 = u79.getOrCreatePackageInfo
                table.insert(p57, v68(v67, p58, p60, p61))
                return
            end
            error(("Invalid %q ObjectValue in package linking to nothing cannot be resolved into package dependency\n\t-> %s"):format(p59.Name, p59:GetFullName()))
        end
    end,
    ["fillExplicitPackageDependencySet"] = function(p69, p70, p71, p72) --[[ Name: fillExplicitPackageDependencySet, Line 206 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u79
        --]]
        local v73 = type(p69) == "table"
        assert(v73, "Bad explicitDependencySet")
        local v74 = typeof(p70) == "Instance"
        assert(v74, "Bad packageFolder")
        local v75 = type(p71) == "table"
        assert(v75, "Bad packageInfoMap")
        assert(p72, "No defaultReplicationType")
        for _, v76 in pairs(p70:GetChildren()) do
            if v76:IsA("Folder") and v76.Name == u4.DEPENDENCY_FOLDER_NAME then
                local v77 = u79.getPackageInfoListFromDependencyFolder(v76, p71, p72)
                for _, v78 in pairs(v77) do
                    p69[v78] = true
                end
            end
        end
    end
}
return u79
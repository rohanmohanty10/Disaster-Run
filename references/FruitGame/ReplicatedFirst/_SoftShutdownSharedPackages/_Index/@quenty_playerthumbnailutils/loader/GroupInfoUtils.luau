 

local u1 = require(script.Parent.Utils)
local u2 = require(script.Parent.Queue)
local u3 = require(script.Parent.LoaderConstants)
local u54 = {
    ["createGroupInfo"] = function() --[[ Name: createGroupInfo, Line 13 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        return u1.readonly({
            ["scriptInfoMap"] = {},
            ["packageScriptInfoMap"] = {},
            ["packageSet"] = {}
        })
    end,
    ["groupPackageInfos"] = function(p4, p5) --[[ Name: groupPackageInfos, Line 21 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u54
            [3] = u3
        --]]
        local v6 = type(p4) == "table"
        assert(v6, "Bad packageInfoList")
        local v7 = type(p5) == "string"
        assert(v7, "Bad replicationMode")
        local v8 = u2.new()
        local v9 = {}
        for _, v10 in pairs(p4) do
            if not v9[v10] then
                v9[v10] = true
                v8:PushRight(v10)
            end
        end
        local v11 = u54.createGroupInfo()
        local v12 = {}
        while not v8:IsEmpty() do
            local v13 = v8:PopLeft()
            if u54.hasAnythingToReplicate(v13, p5) then
                if u54.canAddPackageInfoToGroup(v11, v13, p5) then
                    u54.addPackageInfoToGroup(v11, v13, p5)
                    if u3.GROUP_EACH_PACKAGE_INDIVIDUALLY then
                        table.insert(v12, v11)
                        v11 = u54.createGroupInfo()
                    end
                elseif u3.ALLOW_MULTIPLE_GROUPS then
                    table.insert(v12, v11)
                    v11 = u54.createGroupInfo()
                    u54.addPackageInfoToGroup(v11, v13, p5)
                else
                    u54.addPackageInfoToGroup(v11, v13, p5)
                    error("Cannot add package to group")
                end
            end
            for v14, _ in pairs(v13.dependencySet) do
                if not v9[v14] then
                    v9[v14] = true
                    v8:PushRight(v14)
                end
            end
        end
        if next(v11.packageSet) then
            table.insert(v12, v11)
        end
        return v12
    end,
    ["hasAnythingToReplicate"] = function(p15, p16) --[[ Name: hasAnythingToReplicate, Line 75 ]]
        return next(p15.scriptInfoLookup[p16]) ~= nil
    end,
    ["canAddScriptInfoToGroup"] = function(p17, p18, p19, p20) --[[ Name: canAddScriptInfoToGroup, Line 79 ]]
        local v21 = type(p17) == "table"
        assert(v21, "Bad groupInfo")
        local v22 = type(p18) == "table"
        assert(v22, "Bad scriptInfo")
        local v23 = type(p19) == "string"
        assert(v23, "Bad scriptName")
        local v24 = type(p20) == "table"
        assert(v24, "Bad tempScriptInfoMap")
        local v25 = p20[p19]
        if v25 and v25 ~= p18 then
            return false
        end
        local v26 = p17.scriptInfoMap[p19]
        return (not v26 or v26 == p18) and true or false
    end,
    ["canAddPackageInfoToGroup"] = function(p27, p28, p29) --[[ Name: canAddPackageInfoToGroup, Line 98 ]]
        --[[
        Upvalues:
            [1] = u54
        --]]
        local v30 = type(p27) == "table"
        assert(v30, "Bad groupInfo")
        local v31 = type(p28) == "table"
        assert(v31, "Bad packageInfo")
        local v32 = type(p29) == "string"
        assert(v32, "Bad replicationMode")
        local v33 = {}
        for v34, v35 in pairs(p28.scriptInfoLookup[p29]) do
            if not u54.canAddScriptInfoToGroup(p27, v35, v34, v33) then
                return false
            end
            v33[v34] = v35
        end
        for v36, _ in pairs(p28.dependencySet) do
            if not p27.packageSet[v36] then
                for v37, v38 in pairs(v36.scriptInfoLookup[p29]) do
                    if not u54.canAddScriptInfoToGroup(p27, v38, v37, v33) then
                        return false
                    end
                    v33[v37] = v38
                end
            end
        end
        return true
    end,
    ["addScriptToGroup"] = function(p39, p40, p41) --[[ Name: addScriptToGroup, Line 132 ]]
        local v42 = type(p39) == "table"
        assert(v42, "Bad groupInfo")
        local v43 = type(p41) == "table"
        assert(v43, "Bad scriptInfo")
        local v44 = type(p40) == "string"
        assert(v44, "Bad scriptName")
        local v45 = p39.scriptInfoMap[p40]
        if v45 and v45 ~= p41 then
            error(("Cannot add to package group, conflicting scriptInfo for %q already there"):format(p40))
        end
        p39.scriptInfoMap[p40] = p41
    end,
    ["addPackageInfoToGroup"] = function(p46, p47, p48) --[[ Name: addPackageInfoToGroup, Line 146 ]]
        --[[
        Upvalues:
            [1] = u54
        --]]
        p46.packageSet[p47] = true
        for v49, v50 in pairs(p47.scriptInfoLookup[p48]) do
            u54.addScriptToGroup(p46, v49, v50)
            p46.packageScriptInfoMap[v49] = v50
        end
        for v51, _ in pairs(p47.dependencySet) do
            if not p46.packageSet[v51] then
                for v52, v53 in pairs(v51.scriptInfoLookup[p48]) do
                    u54.addScriptToGroup(p46, v52, v53)
                end
            end
        end
    end
}
return u54
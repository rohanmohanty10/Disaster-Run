 

local u1 = game:GetService("HttpService")
local u2 = {}
u2.__index = u2
local u3 = {}
u3.__index = u3
function u2.new(p4, p5, p6, p7, p8, p9) --[[ Line: 83 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v10 = {
        ["uid"] = game:GetService("HttpService"):GenerateGUID(false),
        ["minX"] = p4,
        ["maxX"] = p5,
        ["minZ"] = p6,
        ["maxXZ"] = math.max(p4, p5, p6, p7),
        ["right"] = nil,
        ["left"] = nil,
        ["maxZ"] = p7,
        ["data"] = p8,
        ["priority"] = p9
    }
    local v11 = u2
    return setmetatable(v10, v11)
end
function u2.UpdateMaxXZ(p12) --[[ Line: 102 ]]
    local v13 = p12.minX
    local v14 = p12.maxX
    local v15 = p12.minZ
    local v16 = p12.maxZ
    local v17 = math.max(v13, v14, v15, v16)
    if p12.left then
        local v18 = p12.left.maxXZ
        v17 = math.max(v17, v18)
    end
    if p12.right then
        local v19 = p12.right.maxXZ
        v17 = math.max(v17, v19)
    end
    p12.maxXZ = v17
    return p12.maxXZ
end
function u3.new() --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v20 = u3
    return setmetatable({
        ["root"] = nil
    }, v20)
end
function u3.Insert(p21, p22, p23, p24, p25, p26, p27) --[[ Line: 132 ]]
    local v28 = p21:_InsertRecursive(p21.root, p22, p23, p24, p25, p26, p27)
    p21.root = v28
    return v28.uid
end
function u3._InsertRecursive(p29, p30, p31, p32, p33, p34, p35, p36) --[[ Line: 147 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if not p30 then
        return u2.new(p31, p32, p33, p34, p35, p36)
    end
    if p31 < p30.minX then
        p30.left = p29:_InsertRecursive(p30.left, p31, p32, p33, p34, p35, p36)
    else
        p30.right = p29:_InsertRecursive(p30.right, p31, p32, p33, p34, p35, p36)
    end
    p30:UpdateMaxXZ()
    return p29:_Rebalance(p30) or p30
end
function u3.Search(p37, p38, p39, p40) --[[ Line: 171 ]]
    local v41, _ = p37:_SearchRecursive(p37.root, p38, p39, {}, (-1 / 0), p40)
    return v41
end
function u3._SearchRecursive(p42, p43, p44, p45, p46, p47, p48) --[[ Line: 183 ]]
    if not p43 then
        return p46, p47
    end
    if p43.minX <= p44 and (p44 <= p43.maxX and (p43.minZ <= p45 and p45 <= p43.maxZ)) then
        if p47 < p43.priority then
            if p48 then
                p46 = {
                    {
                        ["uid"] = p43.uid,
                        ["data"] = p43.data
                    }
                }
            else
                p46 = { p43.data }
            end
            p47 = p43.priority
        elseif p43.priority == p47 then
            if p48 then
                local v49 = {
                    ["uid"] = p43.uid,
                    ["data"] = p43.data
                }
                table.insert(p46, v49)
            else
                local v50 = p43.data
                table.insert(p46, v50)
            end
        end
    end
    if p43.left and p44 <= p43.left.maxXZ then
        p46, p47 = p42:_SearchRecursive(p43.left, p44, p45, p46, p47)
    end
    if p43.right and p43.minX <= p44 then
        p46, p47 = p42:_SearchRecursive(p43.right, p44, p45, p46, p47)
    end
    return p46, p47
end
function u3.Remove(p51, p52) --[[ Line: 219 ]]
    local v53, v54 = p51:_RemoveRecursive(p51.root, p52)
    p51.root = v53
    return v54
end
function u3._RemoveRecursive(p55, p56, p57) --[[ Line: 229 ]]
    if not p56 then
        return nil, false
    end
    if p56.uid ~= p57 then
        local v58, v59 = p55:_RemoveRecursive(p56.left, p57)
        p56.left = v58
        if not v59 then
            local v60
            v60, v59 = p55:_RemoveRecursive(p56.right, p57)
            p56.right = v60
        end
        if v59 then
            p56:UpdateMaxXZ()
        end
        return p56, v59
    end
    if not p56.left then
        return p56.right, true
    end
    if not p56.right then
        return p56.left, true
    end
    local v61 = p55:_FindMin(p56.right)
    p56.uid = v61.uid
    p56.minX = v61.minX
    p56.maxX = v61.maxX
    p56.minZ = v61.minZ
    p56.maxZ = v61.maxZ
    p56.data = v61.data
    p56.priority = v61.priority
    p56.right = p55:_RemoveRecursive(p56.right, v61.uid)
    p56:UpdateMaxXZ()
    return p56, true
end
function u3._FindMin(_, p62) --[[ Line: 269 ]]
    while p62.left do
        p62 = p62.left
    end
    return p62
end
function u3.Update(p63, p64, p65, p66, p67, p68, p69, p70) --[[ Line: 285 ]]
    local v71, v72 = p63:_UpdateRecursive(p63.root, p64, p65, p66, p67, p68, p69, p70)
    p63.root = v71
    local v73 = v72 and p63:_Rebalance(p63.root)
    if v73 then
        p63.root = v73
    end
    return v72
end
function u3._UpdateRecursive(p74, p75, p76, p77, p78, p79, p80, p81, p82) --[[ Line: 307 ]]
    if not p75 then
        return nil, false
    end
    if p75.uid ~= p76 then
        local v83, v84 = p74:_UpdateRecursive(p75.left, p76, p77, p78, p79, p80, p81, p82)
        p75.left = v83
        if not v84 then
            local v85
            v85, v84 = p74:_UpdateRecursive(p75.right, p76, p77, p78, p79, p80, p81, p82)
            p75.right = v85
        end
        if v84 then
            p75:UpdateMaxXZ()
        end
        return p75, v84
    end
    p75.minX = p77
    p75.maxX = p78
    p75.minZ = p79
    p75.maxZ = p80
    p75.data = p81
    p75.priority = p82
    p75:UpdateMaxXZ()
    return p75, true
end
function u3._Rebalance(p86, p87) --[[ Line: 339 ]]
    if p87 then
        local v88 = p86:_GetBalance(p87)
        if v88 > 1 then
            if p87.left and p86:_GetBalance(p87.left) < 0 then
                p87.left = p86:_RotateLeft(p87.left)
            end
            if p87.left then
                return p86:_RotateRight(p87)
            else
                return p87
            end
        elseif v88 < -1 then
            if p87.right and p86:_GetBalance(p87.right) > 0 then
                p87.right = p86:_RotateRight(p87.right)
            end
            if p87.right then
                return p86:_RotateLeft(p87)
            else
                return p87
            end
        else
            return p87
        end
    else
        return nil
    end
end
function u3._GetBalance(p89, p90) --[[ Line: 372 ]]
    return not p90 and 0 or p89:_GetHeight(p90.left) - p89:_GetHeight(p90.right)
end
function u3._GetHeight(p91, p92) --[[ Line: 382 ]]
    if not p92 then
        return 0
    end
    local v93 = p91:_GetHeight(p92.left)
    local v94 = p92.right
    return math.max(v93, p91:_GetHeight(v94)) + 1
end
function u3._RotateLeft(_, p95) --[[ Line: 392 ]]
    local v96 = p95.right
    if not v96 then
        return p95
    end
    local v97 = v96.left
    v96.left = p95
    p95.right = v97
    p95:UpdateMaxXZ()
    v96:UpdateMaxXZ()
    return v96
end
function u3._RotateRight(_, p98) --[[ Line: 411 ]]
    local v99 = p98.left
    if not v99 then
        return p98
    end
    local v100 = v99.right
    v99.right = p98
    p98.left = v100
    p98:UpdateMaxXZ()
    v99:UpdateMaxXZ()
    return v99
end
function u3.Serialize(p101) --[[ Line: 429 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local function u106(p102) --[[ Line: 430 ]]
        --[[
        Upvalues:
            [1] = u106
        --]]
        if typeof(p102) == "Vector3" then
            return {
                ["__type"] = "Vector3",
                ["x"] = p102.X,
                ["y"] = p102.Y,
                ["z"] = p102.Z
            }
        end
        if typeof(p102) ~= "table" then
            return p102
        end
        local v103 = {}
        for v104, v105 in pairs(p102) do
            v103[v104] = u106(v105)
        end
        return v103
    end
    local function u108(p107) --[[ Line: 444 ]]
        --[[
        Upvalues:
            [1] = u106
            [2] = u108
        --]]
        return p107 and {
            ["uid"] = p107.uid,
            ["minX"] = p107.minX,
            ["maxX"] = p107.maxX,
            ["minZ"] = p107.minZ,
            ["maxZ"] = p107.maxZ,
            ["priority"] = p107.priority,
            ["data"] = u106(p107.data),
            ["left"] = u108(p107.left),
            ["right"] = u108(p107.right)
        } or nil
    end
    return u1:JSONEncode((u108(p101.root)))
end
function u3.Deserialize(p109) --[[ Line: 465 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v110 = u1:JSONDecode(p109)
    local function u118(p111) --[[ Line: 468 ]]
        --[[
        Upvalues:
            [1] = u118
        --]]
        if typeof(p111) == "table" and p111.__type == "Vector3" then
            local v112 = p111.x
            local v113 = p111.y
            local v114 = p111.z
            return Vector3.new(v112, v113, v114)
        else
            if typeof(p111) ~= "table" then
                return p111
            end
            local v115 = {}
            for v116, v117 in pairs(p111) do
                v115[v116] = u118(v117)
            end
            return v115
        end
    end
    local function u128(p119) --[[ Line: 482 ]]
        --[[
        Upvalues:
            [1] = u118
            [2] = u128
            [3] = u2
        --]]
        if not p119 then
            return nil
        end
        local v120 = {
            ["uid"] = p119.uid
        }
        local v121 = p119.minX
        v120.minX = tonumber(v121)
        local v122 = p119.maxX
        v120.maxX = tonumber(v122)
        local v123 = p119.minZ
        v120.minZ = tonumber(v123)
        local v124 = p119.maxZ
        v120.maxZ = tonumber(v124)
        local v125 = p119.priority
        v120.priority = tonumber(v125)
        v120.data = u118(p119.data)
        v120.left = u128(p119.left)
        v120.right = u128(p119.right)
        local v126 = u2
        local v127 = setmetatable(v120, v126)
        v127:UpdateMaxXZ()
        return v127
    end
    local v129 = u3.new()
    v129.root = u128(v110)
    return v129
end
return table.freeze(u3)
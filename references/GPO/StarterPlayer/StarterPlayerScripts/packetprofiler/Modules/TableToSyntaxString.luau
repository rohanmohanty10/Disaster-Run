 

local v1 = script.Parent.Parent
local v2 = v1.Modules
local v3 = v1.Components
local v4 = require(v2.Packages)
local u5 = require(v4.Directory.PacketSizeCounter)
local u6 = require(v3.StudioSettings)
local u7 = {
    ["\7"] = "\\a",
    ["\8"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
    ["\11"] = "\\v",
    ["\0"] = "\\0"
}
local u8 = {
    ["and"] = true,
    ["break"] = true,
    ["do"] = true,
    ["else"] = true,
    ["elseif"] = true,
    ["end"] = true,
    ["false"] = true,
    ["for"] = true,
    ["function"] = true,
    ["if"] = true,
    ["in"] = true,
    ["local"] = true,
    ["nil"] = true,
    ["not"] = true,
    ["or"] = true,
    ["repeat"] = true,
    ["return"] = true,
    ["then"] = true,
    ["true"] = true,
    ["until"] = true,
    ["while"] = true,
    ["continue"] = true
}
local u9 = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["\""] = "&quot;",
    ["\'"] = "&apos;"
}
local u10 = {
    ["string"] = "ScriptString",
    ["number"] = "ScriptNumber",
    ["operator"] = "ScriptOperator",
    ["keyword"] = "ScriptKeyword",
    ["boolean"] = "ScriptKeyword",
    ["builtin"] = "ScriptBuiltInFunction",
    ["funcname"] = "ScriptFunctionName",
    ["text"] = "ScriptText",
    ["nil"] = "ScriptKeyword",
    ["bytesize"] = "ScriptComment",
    ["bracket"] = "ScriptBracket"
}
local u11 = {}
local function v15() --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u10
        [3] = u11
    --]]
    local v12 = u6.Theme
    for v13, v14 in u10 do
        u11[v13] = ("#%*"):format((v12:GetColor(v14):ToHex()))
    end
end
v15()
u6.ThemeChanged:Connect(v15)
local u16 = {}
u16.__index = u16
function u16.new(p17) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u16
    --]]
    local v18 = u16
    return setmetatable({
        ["parts"] = {},
        ["glyphCount"] = 0,
        ["maxGlyphs"] = p17 or 20000,
        ["trimmed"] = false
    }, v18)
end
function u16.getRemainingGlyphs(p19) --[[ Line: 70 ]]
    local v20 = p19.maxGlyphs - p19.glyphCount - 13
    return math.max(0, v20)
end
function u16.canAddGlyphs(p21, p22) --[[ Line: 74 ]]
    return p21.glyphCount + p22 + 13 <= p21.maxGlyphs
end
function u16.addRaw(p23, p24) --[[ Line: 78 ]]
    if p23.trimmed then
        return false
    end
    local v25 = #p24
    if p23:canAddGlyphs(v25) then
        local v26 = p23.parts
        table.insert(v26, p24)
        p23.glyphCount = p23.glyphCount + v25
        return true
    end
    p23.trimmed = true
    local v27 = p23.parts
    table.insert(v27, "... [Trimmed]")
    p23.glyphCount = p23.glyphCount + 13
    return false
end
function u16.addFormatted(p28, p29, p30) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u11
    --]]
    if p28.trimmed then
        return false
    end
    local v31 = #p30
    if p28:canAddGlyphs(v31) then
        local v32 = p28.parts
        table.insert(v32, p29)
        p28.glyphCount = p28.glyphCount + v31
        return true
    end
    local v33 = p28:getRemainingGlyphs()
    if v33 > 0 then
        local v34 = string.sub(p30, 1, v33)
        local v35 = p28.parts
        local v36 = string.format
        local v37 = string.match(p29, "color=\"([^\"]+)\"") or u11.text
        table.insert(v35, v36("<font color=\"%s\">%s</font>", v37, v34))
        p28.glyphCount = p28.glyphCount + #v34
    end
    p28.trimmed = true
    local v38 = p28.parts
    table.insert(v38, "... [Trimmed]")
    p28.glyphCount = p28.glyphCount + 13
    return false
end
function u16.toString(p39) --[[ Line: 121 ]]
    return table.concat(p39.parts)
end
function u16.isTrimmed(p40) --[[ Line: 125 ]]
    return p40.trimmed
end
local u59 = {
    ["."] = function(p41) --[[ Line: 139 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v42 = string.format("<font color=\"%s\">%s</font>", u11.operator or u11.text, ".")
        if not p41 then
            return v42
        end
        p41:addFormatted(v42, ".")
        return v42
    end,
    [","] = function(p43) --[[ Line: 140 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v44 = string.format("<font color=\"%s\">%s</font>", u11.text or u11.text, ",")
        if not p43 then
            return v44
        end
        p43:addFormatted(v44, ",")
        return v44
    end,
    ["="] = function(p45) --[[ Line: 141 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v46 = string.format("<font color=\"%s\">%s</font>", u11.operator or u11.text, "=")
        if not p45 then
            return v46
        end
        p45:addFormatted(v46, "=")
        return v46
    end,
    ["("] = function(p47) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v48 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, "(")
        if not p47 then
            return v48
        end
        p47:addFormatted(v48, "(")
        return v48
    end,
    [")"] = function(p49) --[[ Line: 143 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v50 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, ")")
        if not p49 then
            return v50
        end
        p49:addFormatted(v50, ")")
        return v50
    end,
    ["{"] = function(p51) --[[ Line: 144 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v52 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, "{")
        if not p51 then
            return v52
        end
        p51:addFormatted(v52, "{")
        return v52
    end,
    ["}"] = function(p53) --[[ Line: 145 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v54 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, "}")
        if not p53 then
            return v54
        end
        p53:addFormatted(v54, "}")
        return v54
    end,
    ["["] = function(p55) --[[ Line: 146 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v56 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, "[")
        if not p55 then
            return v56
        end
        p55:addFormatted(v56, "[")
        return v56
    end,
    ["]"] = function(p57) --[[ Line: 147 ]]
        --[[
        Upvalues:
            [1] = u11
        --]]
        local v58 = string.format("<font color=\"%s\">%s</font>", u11.bracket or u11.text, "]")
        if not p57 then
            return v58
        end
        p57:addFormatted(v58, "]")
        return v58
    end
}
local function u77(p60, p61) --[[ Line: 156 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u9
        [3] = u8
        [4] = u11
        [5] = u59
    --]]
    local v62 = true
    local v63 = {}
    local v64 = {}
    while v62 do
        local v65 = p60.Parent
        v62 = v65 and v65.Parent
        if v62 then
            v62 = v65 ~= game
        end
        local v66 = p60.Name
        local v67 = string.gsub(v66, "[%c%z]", u7)
        local v68 = string.gsub(v67, "[%&%<%>%\"%\']", u9)
        if u8[v68] or not string.match(v68, "^[_%a][_%w]*$") then
            local v69 = ("&quot;%*&quot;"):format(v68)
            local v70 = string.format("<font color=\"%s\">%s</font>", u11.string or u11.text, v69)
            local v71 = ("%*%*%*"):format(u59["["](nil), v70, (u59["]"](nil)))
            table.insert(v63, 1, v71)
            local v72 = ("[\"%*\"]"):format(v68)
            table.insert(v64, 1, v72)
            p60 = v65
        else
            local v73 = ("%*%*"):format(v62 and u59["."](nil) or "", (string.format("<font color=\"%s\">%s</font>", u11.text or u11.text, v68)))
            table.insert(v63, 1, v73)
            local v74 = ("%*%*"):format(v62 and "." or "", v68)
            table.insert(v64, 1, v74)
            p60 = v65
        end
    end
    local v75 = table.concat(v63)
    local v76 = table.concat(v64)
    if p61 then
        p61:addFormatted(v75, v76)
    end
    return v75
end
local function u83(p78) --[[ Line: 192 ]]
    local v79 = buffer.len(p78)
    local v80 = table.create(v79)
    for v81 = 0, v79 - 1 do
        local v82 = buffer.readu8(p78, v81)
        table.insert(v80, v82)
    end
    return table.concat(v80, " ")
end
local function u94(p84, p85, p86) --[[ Line: 202 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u9
        [3] = u11
        [4] = u77
        [5] = u83
        [6] = u59
    --]]
    local v87, v88
    if p85 == "string" then
        local v89 = string.gsub(p84, "[%c%z]", u7)
        local v90 = string.gsub(v89, "[%&%<%>%\"%\']", u9)
        v87 = ("\"%*\""):format(v90)
        local v91 = ("&quot;%*&quot;"):format(v90)
        v88 = string.format("<font color=\"%s\">%s</font>", u11.string or u11.text, v91)
    else
        if p85 == "Instance" then
            return u77(p84, p86)
        end
        if p85 == "buffer" then
            local v92 = u83(p84)
            v87 = ("buffer.new($%*)"):format(v92)
            v88 = ("%*%*%*%*%*%*"):format(string.format("<font color=\"%s\">%s</font>", u11.builtin or u11.text, "buffer"), u59["."](nil), string.format("<font color=\"%s\">%s</font>", u11.builtin or u11.text, "new"), u59["("](nil), string.format("<font color=\"%s\">%s</font>", u11.number or u11.text, v92), (u59[")"](nil)))
        elseif type(p84) == p85 then
            v87 = tostring(p84)
            v88 = string.format("<font color=\"%s\">%s</font>", u11[p85] or u11.text, v87)
        else
            local v93 = tostring(p84)
            v87 = ("%*.new(%*)"):format(p85, v93)
            v88 = ("%*%*%*%*%*%*"):format(string.format("<font color=\"%s\">%s</font>", u11.builtin or u11.text, p85), u59["."](nil), string.format("<font color=\"%s\">%s</font>", u11.builtin or u11.text, "new"), u59["("](nil), string.format("<font color=\"%s\">%s</font>", u11.number or u11.text, v93), (u59[")"](nil)))
        end
    end
    if p86 then
        p86:addFormatted(v88, v87)
    end
    return v88
end
local function u126(p95, p96, p97, p98, p99) --[[ Line: 232 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u11
        [3] = u59
        [4] = u7
        [5] = u9
        [6] = u8
        [7] = u126
        [8] = u94
        [9] = u5
    --]]
    local v100 = p99 or u16.new()
    local v101 = p97 or {}
    if v101[p95] then
        local v102 = string.format("<font color=\"%s\">%s</font>", u11.string or u11.text, "&quot;[Cyclic reference]&quot;")
        if v100 then
            v100:addFormatted(v102, "&quot;[Cyclic reference]&quot;")
        end
        return v100:toString()
    end
    v101[p95] = true
    local v103 = not p96
    local v104 = (p98 or 0) + 1
    local v105 = string.rep("    ", v104 - 1)
    local v106 = string.rep("    ", v104 - 2)
    local v107 = next(p95) == nil
    local v108 = true
    if v104 ~= 1 and not v107 then
        u59["{"](v100)
        v100:addRaw("\n")
    end
    local v109 = 1
    for v115, v111 in p95 do
        if v100:isTrimmed() then
            break
        end
        if v109 ~= v115 then
            v108 = false
        end
        local v112 = typeof(v115)
        local v113 = typeof(v111)
        if v109 > 1 then
            v100:addRaw("\n")
        end
        v100:addRaw(v105)
        if not v108 then
            if v112 == "string" then
                local v114 = string.gsub(v115, "[%c%z]", u7)
                local v115 = string.gsub(v114, "[%&%<%>%\"%\']", u9)
                if u8[v115] or not string.match(v115, "^[_%a][_%w]*$") then
                    u59["["](v100)
                    local v116 = ("&quot;%*&quot;"):format(v115)
                    local v117 = string.format("<font color=\"%s\">%s</font>", u11.string or u11.text, v116)
                    if v100 then
                        v100:addFormatted(v117, v116)
                    end
                    u59["]"](v100)
                else
                    v100:addRaw(v115)
                end
            else
                u59["["](v100)
                if v112 == "table" then
                    u126(v115, p96, v101, 1, v100)
                else
                    u94(v115, v112, v100)
                end
                u59["]"](v100)
            end
            if v112 ~= "table" and v103 then
                local v118 = u5.GetDataByteSize(v115)
                local v119
                if v118 < 1000 then
                    v119 = ("%* bytes"):format(v118)
                else
                    v119 = string.format("%.3f kilobytes", v118 / 1000)
                end
                local v120 = (": %* "):format(v119)
                local v121 = string.format("<font color=\"%s\">%s</font>", u11.bytesize or u11.text, v120)
                if v100 then
                    v100:addFormatted(v121, v120)
                end
            end
            v100:addRaw(" ")
            u59["="](v100)
            v100:addRaw(" ")
        end
        if v113 == "table" then
            u126(v111, p96, v101, v104, v100)
        else
            u94(v111, v113, v100)
        end
        if v113 ~= "table" and v103 then
            local v122 = u5.GetDataByteSize(v111)
            local v123
            if v122 < 1000 then
                v123 = ("%* bytes"):format(v122)
            else
                v123 = string.format("%.3f kilobytes", v122 / 1000)
            end
            local v124 = (": %*"):format(v123)
            local v125 = string.format("<font color=\"%s\">%s</font>", u11.bytesize or u11.text, v124)
            if v100 then
                v100:addFormatted(v125, v124)
            end
        end
        u59[","](v100)
        v109 = v109 + 1
    end
    if v104 == 1 then
        return v100:toString()
    end
    if v107 then
        u59["{"](v100)
        u59["}"](v100)
    else
        v100:addRaw("\n")
        v100:addRaw(v106)
        u59["}"](v100)
    end
    return v100:toString()
end
return u126
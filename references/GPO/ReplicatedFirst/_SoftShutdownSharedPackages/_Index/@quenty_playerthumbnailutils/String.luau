 

local u27 = {
    ["trim"] = function(p1, p2) --[[ Name: trim, Line 15 ]]
        if p2 then
            return p1:match("^" .. p2 .. "*(.-)" .. p2 .. "*$")
        else
            return p1:match("^%s*(.-)%s*$")
        end
    end,
    ["toCamelCase"] = function(p3) --[[ Name: toCamelCase, Line 31 ]]
        return p3:lower():gsub("[ _](%a)", string.upper):gsub("^%a", string.upper):gsub("%p", "")
    end,
    ["uppercaseFirstLetter"] = function(p4) --[[ Name: uppercaseFirstLetter, Line 46 ]]
        return p4:gsub("^%a", string.upper)
    end,
    ["toLowerCamelCase"] = function(p5) --[[ Name: toLowerCamelCase, Line 55 ]]
        return p5:lower():gsub("[ _](%a)", string.upper):gsub("^%a", string.lower):gsub("%p", "")
    end,
    ["toPrivateCase"] = function(p6) --[[ Name: toPrivateCase, Line 69 ]]
        return "_" .. p6:sub(1, 1):lower() .. p6:sub(2, #p6)
    end,
    ["trimFront"] = function(p7, p8) --[[ Name: trimFront, Line 79 ]]
        local v9 = p8 or "%s"
        return p7:gsub("^" .. v9 .. "*(.-)" .. v9 .. "*", "%1")
    end,
    ["checkNumOfCharacterInString"] = function(p10, p11) --[[ Name: checkNumOfCharacterInString, Line 95 ]]
        local v12 = 0
        for _ in string.gmatch(p10, p11) do
            v12 = v12 + 1
        end
        return v12
    end,
    ["isEmptyOrWhitespaceOrNil"] = function(p13) --[[ Name: isEmptyOrWhitespaceOrNil, Line 108 ]]
        --[[
        Upvalues:
            [1] = u27
        --]]
        return type(p13) ~= "string" and true or (p13 == "" and true or u27.isWhitespace(p13))
    end,
    ["isWhitespace"] = function(p14) --[[ Name: isWhitespace, Line 117 ]]
        return string.match(p14, "[%s]+") == p14
    end,
    ["elipseLimit"] = function(p15, p16) --[[ Name: elipseLimit, Line 127 ]]
        if p16 < #p15 then
            p15 = p15:sub(1, p16 - 3) .. "..."
        end
        return p15
    end,
    ["removePrefix"] = function(p17, p18) --[[ Name: removePrefix, Line 140 ]]
        if p17:sub(1, #p18) == p18 then
            return p17:sub(#p18 + 1)
        else
            return p17
        end
    end,
    ["removePostfix"] = function(p19, p20) --[[ Name: removePostfix, Line 154 ]]
        if p19:sub(-#p20) == p20 then
            return p19:sub(1, -#p20 - 1)
        else
            return p19
        end
    end,
    ["endsWith"] = function(p21, p22) --[[ Name: endsWith, Line 168 ]]
        return p21:sub(-#p22) == p22
    end,
    ["startsWith"] = function(p23, p24) --[[ Name: startsWith, Line 178 ]]
        return p23:sub(1, #p24) == p24
    end,
    ["addCommas"] = function(p25) --[[ Name: addCommas, Line 187 ]]
        if type(p25) == "number" then
            p25 = tostring(p25)
        end
        local v26 = -1
        while v26 ~= 0 do
            p25, v26 = string.gsub(p25, "^(-?%d+)(%d%d%d)", "%1,%2")
        end
        return p25
    end
}
return u27
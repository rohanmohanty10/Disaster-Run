 

local v1 = {}
local u2 = {
    [""] = 0,
    ["_fill"] = 1,
    ["_outline"] = 2,
    ["_tint"] = 3,
    ["_emissive"] = 4
}
local u3 = {
    [0] = "",
    [1] = "_fill",
    [2] = "_outline",
    [3] = "_tint",
    [4] = "_emissive"
}
local u4 = {
    "_emissive",
    "_outline",
    "_fill",
    "_tint"
}
local function u9(p5) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    for _, v6 in u4 do
        local v7 = -#v6
        if string.sub(p5, v7) == v6 then
            local v8 = -#v6 - 1
            return string.sub(p5, 1, v8), v6
        end
    end
    return p5, ""
end
local function u18(p10) --[[ Line: 52 ]]
    local v11 = string.gsub(p10, "-", "")
    if #v11 ~= 32 then
        return nil
    end
    local v12 = {}
    for v13 = 1, 32, 2 do
        local v14 = v13 + 1
        local v15 = string.sub(v11, v13, v14)
        local v16 = tonumber(v15, 16)
        if not v16 then
            return nil
        end
        local v17 = string.char(v16)
        table.insert(v12, v17)
    end
    return table.concat(v12)
end
local function u52(p19, p20) --[[ Line: 66 ]]
    local v21 = string.format
    local v22 = string.byte(p19, p20)
    local v23 = p20 + 1
    local v24 = string.byte(p19, v23)
    local v25 = p20 + 2
    local v26 = string.byte(p19, v25)
    local v27 = p20 + 3
    local v28 = string.byte(p19, v27)
    local v29 = p20 + 4
    local v30 = string.byte(p19, v29)
    local v31 = p20 + 5
    local v32 = string.byte(p19, v31)
    local v33 = p20 + 6
    local v34 = string.byte(p19, v33)
    local v35 = p20 + 7
    local v36 = string.byte(p19, v35)
    local v37 = p20 + 8
    local v38 = string.byte(p19, v37)
    local v39 = p20 + 9
    local v40 = string.byte(p19, v39)
    local v41 = p20 + 10
    local v42 = string.byte(p19, v41)
    local v43 = p20 + 11
    local v44 = string.byte(p19, v43)
    local v45 = p20 + 12
    local v46 = string.byte(p19, v45)
    local v47 = p20 + 13
    local v48 = string.byte(p19, v47)
    local v49 = p20 + 14
    local v50 = string.byte(p19, v49)
    local v51 = p20 + 15
    return v21("%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x", v22, v24, v26, v28, v30, v32, v34, v36, v38, v40, v42, v44, v46, v48, v50, string.byte(p19, v51))
end
local function u72(p53) --[[ Line: 89 ]]
    if #p53 == 0 then
        return ""
    end
    local v54 = {}
    local v55 = 256
    for v56 = 0, 255 do
        v54[string.char(v56)] = v56
    end
    local v57 = ""
    local v58 = {}
    for v59 = 1, #p53 do
        local v60 = string.sub(p53, v59, v59)
        local v61 = v57 .. v60
        if v54[v61] then
            v57 = v61
        else
            local v62 = v54[v57]
            table.insert(v58, v62)
            if v55 < 65536 then
                v54[v61] = v55
                v55 = v55 + 1
            end
            v57 = v60
        end
    end
    if v57 ~= "" then
        local v63 = v54[v57]
        table.insert(v58, v63)
    end
    local v64 = {}
    for v65 = 1, #v58 do
        local v66 = v58[v65]
        local v67 = v66 / 256
        local v68 = math.floor(v67)
        local v69 = string.char(v68)
        table.insert(v64, v69)
        local v70 = v66 % 256
        local v71 = string.char(v70)
        table.insert(v64, v71)
    end
    return table.concat(v64)
end
local function u88(p73) --[[ Line: 126 ]]
    if #p73 == 0 or #p73 % 2 ~= 0 then
        return nil
    end
    local v74 = {}
    for v75 = 1, #p73, 2 do
        local v76 = string.byte(p73, v75)
        local v77 = v75 + 1
        local v78 = string.byte(p73, v77)
        local v79 = v76 * 256 + v78
        table.insert(v74, v79)
    end
    if #v74 == 0 then
        return nil
    end
    local v80 = {}
    local v81 = 256
    for v82 = 0, 255 do
        v80[v82] = string.char(v82)
    end
    local v83 = {}
    local v84 = v80[v74[1]]
    if not v84 then
        return nil
    end
    table.insert(v83, v84)
    for v85 = 2, #v74 do
        local v86 = v74[v85]
        local v87
        if v80[v86] then
            v87 = v80[v86]
        else
            if v86 ~= v81 then
                return nil
            end
            v87 = v84 .. string.sub(v84, 1, 1)
        end
        table.insert(v83, v87)
        if v81 < 65536 then
            v80[v81] = v84 .. string.sub(v87, 1, 1)
            v81 = v81 + 1
        end
        v84 = v87
    end
    return table.concat(v83)
end
local function u113(p89) --[[ Line: 170 ]]
    local v90 = 0
    local v91 = 0
    local v92 = {}
    for v93 = 1, #p89 do
        v91 = v91 + string.byte(p89, v93) * 2 ^ v90
        v90 = v90 + 8
        if v90 > 13 then
            local v94 = v91 % 8192
            if v94 > 88 then
                local v95 = v91 / 8192
                v91 = math.floor(v95)
                v90 = v90 - 13
            else
                v94 = v91 % 16384
                local v96 = v91 / 16384
                v91 = math.floor(v96)
                v90 = v90 - 14
            end
            local v97 = v94 % 91 + 1
            local v98 = v94 % 91 + 1
            local v99 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v97, v98)
            table.insert(v92, v99)
            local v100 = v94 / 91
            local v101 = math.floor(v100) + 1
            local v102 = v94 / 91
            local v103 = math.floor(v102) + 1
            local v104 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v101, v103)
            table.insert(v92, v104)
        end
    end
    if v90 > 0 then
        local v105 = v91 % 91 + 1
        local v106 = v91 % 91 + 1
        local v107 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v105, v106)
        table.insert(v92, v107)
        if v90 > 7 or v91 > 90 then
            local v108 = v91 / 91
            local v109 = math.floor(v108) + 1
            local v110 = v91 / 91
            local v111 = math.floor(v110) + 1
            local v112 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v109, v111)
            table.insert(v92, v112)
        end
    end
    return table.concat(v92)
end
local function u130(p114) --[[ Line: 200 ]]
    local v115 = {}
    for v116 = 1, 91 do
        v115[string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v116)] = v116 - 1
    end
    local v117 = {}
    local v118 = -1
    local v119 = 0
    local v120 = 0
    for v121 = 1, #p114 do
        local v122 = v115[string.byte(p114, v121)]
        if v122 ~= nil then
            if v118 == -1 then
                v118 = v122
            else
                local v123 = v118 + v122 * 91
                local v124 = v123 % 8192 > 88 and 13 or 14
                v120 = v120 + v123 * 2 ^ v119
                v119 = v119 + v124
                while v119 > 7 do
                    local v125 = v120 % 256
                    local v126 = string.char(v125)
                    table.insert(v117, v126)
                    local v127 = v120 / 256
                    v120 = math.floor(v127)
                    v119 = v119 - 8
                end
                v118 = -1
            end
        end
    end
    if v118 ~= -1 then
        local v128 = (v120 + v118 * 2 ^ v119) % 256
        local v129 = string.char(v128)
        table.insert(v117, v129)
    end
    return table.concat(v117)
end
function v1.encode(p131) --[[ Line: 235 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u2
        [3] = u18
        [4] = u72
        [5] = u113
    --]]
    if not (p131 and next(p131)) then
        return ""
    end
    local v132 = {}
    for v133, v134 in p131 do
        local v135, v136 = u9(v133)
        local v137 = u2[v136]
        if v137 then
            local v138 = u18(v135)
            if v138 then
                local v139 = string.sub(v134, 1, 2)
                local v140 = tonumber(v139, 16)
                local v141 = string.sub(v134, 3, 4)
                local v142 = tonumber(v141, 16)
                local v143 = string.sub(v134, 5, 6)
                local v144 = tonumber(v143, 16)
                if v140 and (v142 and v144) then
                    table.insert(v132, {
                        ["uidBytes"] = v138,
                        ["suffixFlag"] = v137,
                        ["r"] = v140,
                        ["g"] = v142,
                        ["b"] = v144
                    })
                end
            end
        end
    end
    if #v132 == 0 then
        return ""
    end
    local v145 = {}
    local v146 = #v132
    local v147 = v146 / 256
    local v148 = math.floor(v147) % 256
    local v149 = v146 % 256
    __set_list(v145, 1, {(string.char(v148, v149))})
    for _, v150 in v132 do
        local v151 = v150.uidBytes
        table.insert(v145, v151)
        local v152 = v150.suffixFlag
        local v153 = string.char(v152)
        table.insert(v145, v153)
        local v154 = v150.r
        local v155 = v150.g
        local v156 = v150.b
        local v157 = string.char(v154, v155, v156)
        table.insert(v145, v157)
    end
    local v158 = table.concat(v145)
    local v159 = u72(v158)
    local v160 = #v159 < #v158
    if not v160 then
        v159 = v158
    end
    return u113(string.char(v160 and 1 or 0) .. v159)
end
function v1.decode(p161) --[[ Line: 276 ]]
    --[[
    Upvalues:
        [1] = u130
        [2] = u88
        [3] = u52
        [4] = u3
    --]]
    if p161 and p161 ~= "" then
        if string.sub(p161, 1, 1) == "{" then
            local v162 = game:GetService("HttpService")
            local v163, v164 = pcall(v162.JSONDecode, v162, p161)
            if v163 and typeof(v164) == "table" then
                return v164
            else
                return nil
            end
        else
            local v165 = u130(p161)
            if not v165 or #v165 < 1 then
                return nil
            end
            local v166 = string.byte(v165, 1)
            local v167 = string.sub(v165, 2)
            local v168 = v166 ~= 1 or u88(v167)
            if not v168 then
                return nil
            end
            if #v168 < 2 then
                return nil
            end
            local v169 = string.byte(v168, 1)
            local v170 = string.byte(v168, 2)
            local v171 = v169 * 256 + v170
            local v172 = 3
            if #v168 < 2 + v171 * 20 then
                return nil
            end
            local v173 = {}
            for _ = 1, v171 do
                local v174 = u52(v168, v172)
                local v175 = v172 + 16
                local v176 = string.byte(v168, v175)
                local v177 = v175 + 1
                local v178 = string.byte(v168, v177)
                local v179 = v177 + 1
                local v180 = string.byte(v168, v179)
                local v181 = v177 + 2
                local v182 = string.byte(v168, v181)
                v172 = v177 + 3
                v173[v174 .. (u3[v176] or "")] = string.format("%02x%02x%02x", v178, v180, v182)
            end
            return v173
        end
    else
        return nil
    end
end
return v1
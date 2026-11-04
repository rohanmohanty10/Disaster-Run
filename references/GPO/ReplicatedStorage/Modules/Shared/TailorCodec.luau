 

local u1 = game:GetService("HttpService")
game:GetService("ReplicatedStorage")
local u2 = {}
local u3 = {
    ["Plastic"] = true,
    ["SmoothPlastic"] = true,
    ["Metal"] = true,
    ["DiamondPlate"] = true,
    ["Foil"] = true,
    ["Granite"] = true,
    ["Marble"] = true,
    ["Basalt"] = true,
    ["Ice"] = true,
    ["Glacier"] = true,
    ["Wood"] = true,
    ["WoodPlanks"] = true,
    ["Cobblestone"] = true,
    ["Brick"] = true,
    ["Sand"] = true,
    ["Sandstone"] = true,
    ["Rock"] = true,
    ["Fabric"] = true,
    ["Leather"] = true,
    ["Concrete"] = true,
    ["CorrodedMetal"] = true,
    ["Slate"] = true,
    ["Pebble"] = true,
    ["Pavement"] = true,
    ["Limestone"] = true,
    ["Asphalt"] = true,
    ["Grass"] = true,
    ["LeafyGrass"] = true,
    ["Snow"] = true,
    ["Mud"] = true,
    ["Ground"] = true,
    ["Salt"] = true,
    ["Cardboard"] = true,
    ["Carpet"] = true,
    ["CeramicTiles"] = true,
    ["ClayRoofTiles"] = true,
    ["RoofShingles"] = true,
    ["Plaster"] = true,
    ["Rubber"] = true
}
local function u33(p4) --[[ Line: 73 ]]
    local v5 = (3 - #p4 % 3) % 3
    local v6 = p4 .. string.rep("\0", v5)
    local v7 = {}
    for v8 = 1, #v6, 3 do
        local v9 = v8 + 2
        local v10, v11, v12 = string.byte(v6, v8, v9)
        local v13 = v10 * 65536 + v11 * 256 + v12
        local v14 = v13 / 262144
        local v15 = math.floor(v14) % 64 + 1
        local v16 = v13 / 262144
        local v17 = math.floor(v16) % 64 + 1
        local v18 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v15, v17)
        table.insert(v7, v18)
        local v19 = v13 / 4096
        local v20 = math.floor(v19) % 64 + 1
        local v21 = v13 / 4096
        local v22 = math.floor(v21) % 64 + 1
        local v23 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v20, v22)
        table.insert(v7, v23)
        local v24 = v13 / 64
        local v25 = math.floor(v24) % 64 + 1
        local v26 = v13 / 64
        local v27 = math.floor(v26) % 64 + 1
        local v28 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v25, v27)
        table.insert(v7, v28)
        local v29 = v13 % 64 + 1
        local v30 = v13 % 64 + 1
        local v31 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v29, v30)
        table.insert(v7, v31)
    end
    for v32 = 1, v5 do
        v7[#v7 - v32 + 1] = "="
    end
    return table.concat(v7)
end
local function u62(p34) --[[ Line: 95 ]]
    local v35 = {}
    for v36 = 1, 64 do
        v35[string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", v36, v36)] = v36 - 1
    end
    v35["="] = 0
    local v37 = string.gsub(p34, "[^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=]", "")
    if #v37 % 4 ~= 0 then
        return nil
    end
    local v38 = {}
    local v39 = 0
    if string.sub(v37, -1) == "=" then
        v39 = v39 + 1
    end
    if string.sub(v37, -2, -2) == "=" then
        v39 = v39 + 1
    end
    for v40 = 1, #v37, 4 do
        local v41 = string.sub(v37, v40, v40)
        local v42 = v40 + 1
        local v43 = v40 + 1
        local v44 = string.sub(v37, v42, v43)
        local v45 = v40 + 2
        local v46 = v40 + 2
        local v47 = string.sub(v37, v45, v46)
        local v48 = v40 + 3
        local v49 = v40 + 3
        local v50 = string.sub(v37, v48, v49)
        local v51 = v35[v41] * 262144 + v35[v44] * 4096 + v35[v47] * 64 + v35[v50]
        local v52 = v51 / 65536
        local v53 = math.floor(v52) % 256
        local v54 = string.char(v53)
        table.insert(v38, v54)
        local v55 = v51 / 256
        local v56 = math.floor(v55) % 256
        local v57 = string.char(v56)
        table.insert(v38, v57)
        local v58 = v51 % 256
        local v59 = string.char(v58)
        table.insert(v38, v59)
    end
    local v60 = table.concat(v38)
    local v61 = #v38 - v39
    return string.sub(v60, 1, v61)
end
local function u82(p63) --[[ Line: 125 ]]
    if #p63 == 0 then
        return ""
    end
    local v64 = {}
    local v65 = 256
    for v66 = 0, 255 do
        v64[string.char(v66)] = v66
    end
    local v67 = ""
    local v68 = {}
    for v69 = 1, #p63 do
        local v70 = string.sub(p63, v69, v69)
        local v71 = v67 .. v70
        if v64[v71] then
            v67 = v71
        else
            local v72 = v64[v67]
            table.insert(v68, v72)
            if v65 < 65536 then
                v64[v71] = v65
                v65 = v65 + 1
            end
            v67 = v70
        end
    end
    if v67 ~= "" then
        local v73 = v64[v67]
        table.insert(v68, v73)
    end
    local v74 = {}
    for v75 = 1, #v68 do
        local v76 = v68[v75]
        local v77 = v76 / 256
        local v78 = math.floor(v77)
        local v79 = string.char(v78)
        table.insert(v74, v79)
        local v80 = v76 % 256
        local v81 = string.char(v80)
        table.insert(v74, v81)
    end
    return table.concat(v74)
end
local function u98(p83) --[[ Line: 172 ]]
    if #p83 == 0 or #p83 % 2 ~= 0 then
        return nil
    end
    local v84 = {}
    for v85 = 1, #p83, 2 do
        local v86 = string.byte(p83, v85)
        local v87 = v85 + 1
        local v88 = string.byte(p83, v87)
        local v89 = v86 * 256 + v88
        table.insert(v84, v89)
    end
    if #v84 == 0 then
        return nil
    end
    local v90 = {}
    local v91 = 256
    for v92 = 0, 255 do
        v90[v92] = string.char(v92)
    end
    local v93 = {}
    local v94 = v90[v84[1]]
    if not v94 then
        return nil
    end
    table.insert(v93, v94)
    for v95 = 2, #v84 do
        local v96 = v84[v95]
        local v97
        if v90[v96] then
            v97 = v90[v96]
        else
            if v96 ~= v91 then
                return nil
            end
            v97 = v94 .. string.sub(v94, 1, 1)
        end
        table.insert(v93, v97)
        if v91 < 65536 then
            v90[v91] = v94 .. string.sub(v97, 1, 1)
            v91 = v91 + 1
        end
        v94 = v97
    end
    return table.concat(v93)
end
local function u123(p99) --[[ Line: 229 ]]
    local v100 = 0
    local v101 = 0
    local v102 = {}
    for v103 = 1, #p99 do
        v101 = v101 + string.byte(p99, v103) * 2 ^ v100
        v100 = v100 + 8
        if v100 > 13 then
            local v104 = v101 % 8192
            if v104 > 88 then
                local v105 = v101 / 8192
                v101 = math.floor(v105)
                v100 = v100 - 13
            else
                v104 = v101 % 16384
                local v106 = v101 / 16384
                v101 = math.floor(v106)
                v100 = v100 - 14
            end
            local v107 = v104 % 91 + 1
            local v108 = v104 % 91 + 1
            local v109 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v107, v108)
            table.insert(v102, v109)
            local v110 = v104 / 91
            local v111 = math.floor(v110) + 1
            local v112 = v104 / 91
            local v113 = math.floor(v112) + 1
            local v114 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v111, v113)
            table.insert(v102, v114)
        end
    end
    if v100 > 0 then
        local v115 = v101 % 91 + 1
        local v116 = v101 % 91 + 1
        local v117 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v115, v116)
        table.insert(v102, v117)
        if v100 > 7 or v101 > 90 then
            local v118 = v101 / 91
            local v119 = math.floor(v118) + 1
            local v120 = v101 / 91
            local v121 = math.floor(v120) + 1
            local v122 = string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v119, v121)
            table.insert(v102, v122)
        end
    end
    return table.concat(v102)
end
local function u140(p124) --[[ Line: 259 ]]
    local v125 = {}
    for v126 = 1, 91 do
        v125[string.byte("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!#$%&()*+,-./:;<=>?@[]^_`{|}~", v126)] = v126 - 1
    end
    local v127 = {}
    local v128 = -1
    local v129 = 0
    local v130 = 0
    for v131 = 1, #p124 do
        local v132 = v125[string.byte(p124, v131)]
        if v132 ~= nil then
            if v128 == -1 then
                v128 = v132
            else
                local v133 = v128 + v132 * 91
                local v134 = v133 % 8192 > 88 and 13 or 14
                v130 = v130 + v133 * 2 ^ v129
                v129 = v129 + v134
                while v129 > 7 do
                    local v135 = v130 % 256
                    local v136 = string.char(v135)
                    table.insert(v127, v136)
                    local v137 = v130 / 256
                    v130 = math.floor(v137)
                    v129 = v129 - 8
                end
                v128 = -1
            end
        end
    end
    if v128 ~= -1 then
        local v138 = (v130 + v128 * 2 ^ v129) % 256
        local v139 = string.char(v138)
        table.insert(v127, v139)
    end
    return table.concat(v127)
end
local function u185(p141) --[[ Line: 292 ]]
    if typeof(p141) ~= "string" then
        return ""
    end
    local v142 = 1
    local v143 = {}
    while v142 <= #p141 do
        local v144 = string.byte(p141, v142)
        if v144 >= 0 and v144 <= 127 then
            local v145 = string.char(v144)
            table.insert(v143, v145)
            v142 = v142 + 1
        elseif v144 >= 194 and v144 <= 223 then
            local v146 = v142 + 1
            local v147 = string.byte(p141, v146)
            if v147 and (v147 >= 128 and v147 <= 191) then
                local v148 = v142 + 1
                table.insert(v143, p141:sub(v142, v148))
                v142 = v142 + 2
            else
                v142 = v142 + 1
            end
        elseif v144 == 224 then
            local v149 = v142 + 1
            local v150 = string.byte(p141, v149)
            local v151 = v142 + 2
            local v152 = string.byte(p141, v151)
            if v150 and (v152 and (v150 >= 160 and (v150 <= 191 and (v152 >= 128 and v152 <= 191)))) then
                local v153 = v142 + 2
                table.insert(v143, p141:sub(v142, v153))
                v142 = v142 + 3
            else
                v142 = v142 + 1
            end
        elseif v144 >= 225 and v144 <= 236 or v144 >= 238 and v144 <= 239 then
            local v154 = v142 + 1
            local v155 = string.byte(p141, v154)
            local v156 = v142 + 2
            local v157 = string.byte(p141, v156)
            if v155 and (v157 and (v155 >= 128 and (v155 <= 191 and (v157 >= 128 and v157 <= 191)))) then
                local v158 = v142 + 2
                table.insert(v143, p141:sub(v142, v158))
                v142 = v142 + 3
            else
                v142 = v142 + 1
            end
        elseif v144 == 237 then
            local v159 = v142 + 1
            local v160 = string.byte(p141, v159)
            local v161 = v142 + 2
            local v162 = string.byte(p141, v161)
            if v160 and (v162 and (v160 >= 128 and (v160 <= 159 and (v162 >= 128 and v162 <= 191)))) then
                local v163 = v142 + 2
                table.insert(v143, p141:sub(v142, v163))
                v142 = v142 + 3
            else
                v142 = v142 + 1
            end
        elseif v144 == 240 then
            local v164 = v142 + 1
            local v165 = string.byte(p141, v164)
            local v166 = v142 + 2
            local v167 = string.byte(p141, v166)
            local v168 = v142 + 3
            local v169 = string.byte(p141, v168)
            if v165 and (v167 and (v169 and (v165 >= 144 and (v165 <= 191 and (v167 >= 128 and (v167 <= 191 and (v169 >= 128 and v169 <= 191))))))) then
                local v170 = v142 + 3
                table.insert(v143, p141:sub(v142, v170))
                v142 = v142 + 4
            else
                v142 = v142 + 1
            end
        elseif v144 >= 241 and v144 <= 243 then
            local v171 = v142 + 1
            local v172 = string.byte(p141, v171)
            local v173 = v142 + 2
            local v174 = string.byte(p141, v173)
            local v175 = v142 + 3
            local v176 = string.byte(p141, v175)
            if v172 and (v174 and (v176 and (v172 >= 128 and (v172 <= 191 and (v174 >= 128 and (v174 <= 191 and (v176 >= 128 and v176 <= 191))))))) then
                local v177 = v142 + 3
                table.insert(v143, p141:sub(v142, v177))
                v142 = v142 + 4
            else
                v142 = v142 + 1
            end
        elseif v144 == 244 then
            local v178 = v142 + 1
            local v179 = string.byte(p141, v178)
            local v180 = v142 + 2
            local v181 = string.byte(p141, v180)
            local v182 = v142 + 3
            local v183 = string.byte(p141, v182)
            if v179 and (v181 and (v183 and (v179 >= 128 and (v179 <= 143 and (v181 >= 128 and (v181 <= 191 and (v183 >= 128 and v183 <= 191))))))) then
                local v184 = v142 + 3
                table.insert(v143, p141:sub(v142, v184))
                v142 = v142 + 4
            else
                v142 = v142 + 1
            end
        else
            v142 = v142 + 1
        end
    end
    return table.concat(v143)
end
local function u187(p186) --[[ Line: 383 ]]
    if #p186 == 32 then
        return string.format("%s-%s-%s-%s-%s", string.sub(p186, 1, 8), string.sub(p186, 9, 12), string.sub(p186, 13, 16), string.sub(p186, 17, 20), (string.sub(p186, 21, 32)))
    else
        return nil
    end
end
local u188 = {
    ["_fill"] = 0,
    ["_outline"] = 1,
    ["_tint"] = 2,
    ["_emissive"] = 3
}
local u189 = {
    [0] = "_fill",
    [1] = "_outline",
    [2] = "_tint",
    [3] = "_emissive"
}
local function u200(p190) --[[ Line: 399 ]]
    local v191 = string.gsub(p190, "-", "")
    if #v191 < 8 then
        return nil
    end
    local v192 = string.sub(v191, 1, 2)
    local v193 = tonumber(v192, 16)
    local v194 = string.sub(v191, 3, 4)
    local v195 = tonumber(v194, 16)
    local v196 = string.sub(v191, 5, 6)
    local v197 = tonumber(v196, 16)
    local v198 = string.sub(v191, 7, 8)
    local v199 = tonumber(v198, 16)
    return string.char(v193, v195, v197, v199)
end
local function u212(p201) --[[ Line: 488 ]]
    if typeof(p201) ~= "table" then
        return nil
    end
    if #p201 ~= 12 then
        return nil
    end
    local v202 = 0
    for _ in pairs(p201) do
        v202 = v202 + 1
        if v202 > 12 then
            return nil
        end
    end
    if v202 ~= 12 then
        return nil
    end
    local v203 = {}
    for v204 = 1, 12 do
        local v205 = p201[v204]
        local v206
        if typeof(v205) == "number" and (v205 == v205 and (v205 ~= (1 / 0) and v205 ~= (-1 / 0))) then
            v206 = math.abs(v205) <= 100
        else
            v206 = false
        end
        if not v206 then
            return nil
        end
        v203[v204] = v205
    end
    local v207 = v203[1]
    if math.abs(v207) <= 0.5 then
        local v208 = v203[2]
        if math.abs(v208) <= 0.5 then
            local v209 = v203[3]
            if math.abs(v209) <= 0.5 then
                for v210 = 4, 12 do
                    local v211 = v203[v210]
                    if math.abs(v211) > 1.001 then
                        return nil
                    end
                end
                return v203
            end
        end
    end
    return nil
end
local function u214(p213) --[[ Line: 540 ]]
    if typeof(p213) == "buffer" then
        return buffer.len(p213) == 48 and {
            buffer.readf32(p213, 0),
            buffer.readf32(p213, 4),
            buffer.readf32(p213, 8),
            buffer.readf32(p213, 12),
            buffer.readf32(p213, 16),
            buffer.readf32(p213, 20),
            buffer.readf32(p213, 24),
            buffer.readf32(p213, 28),
            buffer.readf32(p213, 32),
            buffer.readf32(p213, 36),
            buffer.readf32(p213, 40),
            buffer.readf32(p213, 44)
        } or nil
    else
        return nil
    end
end
local function u221(p215) --[[ Line: 556 ]]
    --[[
    Upvalues:
        [1] = u212
    --]]
    local v216 = u212(p215)
    if not v216 then
        return nil
    end
    local v217 = buffer.create(48)
    for v218 = 1, 12 do
        local v219 = (v218 - 1) * 4
        local v220 = v216[v218]
        buffer.writef32(v217, v219, v220)
    end
    return v217
end
local function u250(p222, p223, p224, p225) --[[ Line: 574 ]]
    --[[
    Upvalues:
        [1] = u212
        [2] = u3
    --]]
    if typeof(p222) ~= "string" or (#p222 == 0 or #p222 > 100) then
        return nil
    end
    local v226 = {
        ["n"] = p222
    }
    local v227 = false
    if p223 and typeof(p223) == "table" then
        local v228 = 0
        local v229 = {}
        local v230 = {}
        for v231, v232 in pairs(p223) do
            if v228 >= (1 / 0) then
                break
            end
            if typeof(v231) == "string" and typeof(v232) == "string" then
                local v233 = string.gsub(v232, "^#", "")
                local v234
                if typeof(v233) == "string" then
                    local v235
                    if string.sub(v233, 1, 1) == "#" then
                        v235 = string.sub(v233, 2)
                    else
                        v235 = v233
                    end
                    if #v235 == 6 then
                        v234 = string.match(v235, "^%x%x%x%x%x%x$") ~= nil
                    else
                        v234 = false
                    end
                else
                    v234 = false
                end
                if v234 then
                    local v236 = string.gsub(v231, "-", "")
                    local v237
                    if typeof(v236) == "string" and #v236 == 32 then
                        v237 = string.match(v236, "^%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
                    else
                        v237 = false
                    end
                    if v237 then
                        local v238 = v236 .. v233
                        table.insert(v229, v238)
                    else
                        v230[v231] = v233
                    end
                    v228 = v228 + 1
                    v227 = true
                end
            end
        end
        if #v229 > 0 then
            v226.c = table.concat(v229)
        end
        if next(v230) then
            v226.xc = v230
        end
    end
    if p224 then
        local v239 = u212(p224)
        if v239 then
            local v240 = {}
            for v241 = 1, 12 do
                local v242 = v239[v241] * 1000
                v240[v241] = math.round(v242) / 1000
            end
            v226.p = v240
            v227 = true
        end
    end
    if p225 and typeof(p225) == "table" then
        local v243 = 0
        local v244 = {}
        for v245, v246 in pairs(p225) do
            if v243 >= (1 / 0) then
                break
            end
            if typeof(v245) == "string" then
                local v247
                if typeof(v246) == "string" then
                    v247 = u3[v246] == true
                else
                    v247 = false
                end
                if v247 then
                    local v248 = string.gsub(v245, "-", "")
                    local v249
                    if typeof(v248) == "string" and #v248 == 32 then
                        v249 = string.match(v248, "^%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
                    else
                        v249 = false
                    end
                    if v249 then
                        v244[v248] = v246
                        v243 = v243 + 1
                        v227 = true
                    end
                end
            end
        end
        if next(v244) then
            v226.m = v244
        end
    end
    if v227 then
        return v226
    else
        return nil
    end
end
local function u344(p251) --[[ Line: 674 ]]
    --[[
    Upvalues:
        [1] = u188
        [2] = u200
        [3] = u212
        [4] = u3
    --]]
    if typeof(p251) ~= "table" or (#p251 == 0 or #p251 > 50) then
        return nil, "Invalid items"
    end
    local v252 = {}
    local v253 = #p251
    local v254 = string.char(3, 0, v253)
    table.insert(v252, v254)
    for _, v255 in ipairs(p251) do
        local v256 = v255.name
        if typeof(v256) == "string" and (#v256 ~= 0 and #v256 <= 100) then
            local v257 = #v256
            local v258 = string.char(v257)
            table.insert(v252, v258)
            table.insert(v252, v256)
            local v259 = {}
            local v260 = {}
            if v255.colors then
                local v261 = v255.colors
                if typeof(v261) == "table" then
                    for v262, v263 in pairs(v255.colors) do
                        if typeof(v262) == "string" and typeof(v263) == "string" then
                            local v264 = string.gsub(v263, "^#", "")
                            local v265
                            if typeof(v264) == "string" then
                                local v266
                                if string.sub(v264, 1, 1) == "#" then
                                    v266 = string.sub(v264, 2)
                                else
                                    v266 = v264
                                end
                                if #v266 == 6 then
                                    v265 = string.match(v266, "^%x%x%x%x%x%x$") ~= nil
                                else
                                    v265 = false
                                end
                            else
                                v265 = false
                            end
                            if v265 then
                                local v267, v268 = string.match(v262, "^(.+)(_%a+)$")
                                if v267 and u188[v268] then
                                    local v269 = u200(v267)
                                    if v269 then
                                        local v270 = { v269, u188[v268], v264 }
                                        table.insert(v260, v270)
                                    end
                                else
                                    local v271 = u200(v262)
                                    if v271 then
                                        if not v259[v264] then
                                            v259[v264] = {}
                                        end
                                        local v272 = v259[v264]
                                        table.insert(v272, v271)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            local v273 = false
            local v274
            if v255.cframeArray then
                v274 = u212(v255.cframeArray)
                if v274 then
                    v273 = true
                end
            else
                v274 = nil
            end
            local v275 = #v260 > 0
            local v276 = false
            local v277 = {}
            if v255.materials then
                local v278 = v255.materials
                if typeof(v278) == "table" then
                    for v279, v280 in pairs(v255.materials) do
                        if typeof(v279) == "string" then
                            local v281
                            if typeof(v280) == "string" then
                                v281 = u3[v280] == true
                            else
                                v281 = false
                            end
                            if v281 then
                                local v282 = u200(v279)
                                if v282 then
                                    local v283 = Enum.Material[v280]
                                    if v283 then
                                        local v284 = { v282, v283.Value }
                                        table.insert(v277, v284)
                                    end
                                end
                            end
                        end
                    end
                    if #v277 > 0 then
                        v276 = true
                    else
                        v276 = false
                    end
                end
            end
            local v285 = 0
            if v273 then
                v285 = bit32.bor(v285, 1)
            end
            if v275 then
                v285 = bit32.bor(v285, 2)
            end
            if v276 then
                v285 = bit32.bor(v285, 4)
            end
            local v286 = string.char(v285)
            table.insert(v252, v286)
            local v287 = 0
            for _ in pairs(v259) do
                v287 = v287 + 1
            end
            local v288 = v287 / 256
            local v289 = math.floor(v288) % 256
            local v290 = v287 % 256
            local v291 = string.char(v289, v290)
            table.insert(v252, v291)
            for v292, v293 in pairs(v259) do
                local v294 = string.sub(v292, 1, 2)
                local v295 = tonumber(v294, 16)
                local v296 = string.sub(v292, 3, 4)
                local v297 = tonumber(v296, 16)
                local v298 = string.sub(v292, 5, 6)
                local v299 = tonumber(v298, 16)
                local v300 = string.char(v295, v297, v299)
                table.insert(v252, v300)
                local v301 = #v293
                local v302 = v301 / 256
                local v303 = math.floor(v302) % 256
                local v304 = v301 % 256
                local v305 = string.char(v303, v304)
                table.insert(v252, v305)
                for _, v306 in ipairs(v293) do
                    table.insert(v252, v306)
                end
            end
            if v275 then
                local v307 = #v260
                local v308 = v307 / 256
                local v309 = math.floor(v308) % 256
                local v310 = v307 % 256
                local v311 = string.char(v309, v310)
                table.insert(v252, v311)
                for _, v312 in ipairs(v260) do
                    local v313 = v312[1]
                    table.insert(v252, v313)
                    local v314 = v312[2]
                    local v315 = string.char(v314)
                    table.insert(v252, v315)
                    local v316 = v312[3]
                    local v317 = string.sub(v316, 1, 2)
                    local v318 = tonumber(v317, 16)
                    local v319 = string.sub(v316, 3, 4)
                    local v320 = tonumber(v319, 16)
                    local v321 = string.sub(v316, 5, 6)
                    local v322 = tonumber(v321, 16)
                    local v323 = string.char(v318, v320, v322)
                    table.insert(v252, v323)
                end
            end
            if v276 then
                local v324 = #v277
                local v325 = v324 / 256
                local v326 = math.floor(v325) % 256
                local v327 = v324 % 256
                local v328 = string.char(v326, v327)
                table.insert(v252, v328)
                for _, v329 in ipairs(v277) do
                    local v330 = v329[1]
                    table.insert(v252, v330)
                    local v331 = v329[2]
                    local v332 = v331 / 256
                    local v333 = math.floor(v332) % 256
                    local v334 = v331 % 256
                    local v335 = string.char(v333, v334)
                    table.insert(v252, v335)
                end
            end
            if v273 and v274 then
                local v336 = buffer.create(4)
                for v337 = 1, 12 do
                    local v338 = v274[v337]
                    buffer.writef32(v336, 0, v338)
                    local v339 = buffer.readu8(v336, 0)
                    local v340 = buffer.readu8(v336, 1)
                    local v341 = buffer.readu8(v336, 2)
                    local v342 = buffer.readu8(v336, 3)
                    local v343 = string.char(v339, v340, v341, v342)
                    table.insert(v252, v343)
                end
            end
        end
    end
    return table.concat(v252), nil
end
local function u415(p345) --[[ Line: 836 ]]
    --[[
    Upvalues:
        [1] = u185
        [2] = u189
        [3] = u3
        [4] = u212
    --]]
    if typeof(p345) ~= "string" or #p345 < 3 then
        return nil, "Data too short"
    end
    local v346 = 1
    local v347
    if #p345 < v346 then
        v347 = nil
    else
        local v348 = v346
        v347 = string.byte(p345, v348)
        v346 = v346 + 1
    end
    if v347 ~= 3 then
        return nil, "Unsupported binary version: " .. tostring(v347)
    end
    if #p345 >= v346 then
        string.byte(p345, v346)
        v346 = v346 + 1
    end
    local v349
    if #p345 < v346 then
        v349 = nil
    else
        local v350 = v346
        v349 = string.byte(p345, v350)
        v346 = v346 + 1
    end
    if not v349 or v349 == 0 then
        return nil, "No items"
    end
    if v349 > 50 then
        return nil, "Too many items"
    end
    local v351 = {}
    for _ = 1, v349 do
        local v352
        if #p345 < v346 then
            v352 = nil
        else
            v352 = string.byte(p345, v346)
            v346 = v346 + 1
        end
        if not v352 or v352 == 0 then
            return nil, "Invalid item name length"
        end
        local v353
        if v346 + v352 - 1 > #p345 then
            v353 = nil
        else
            local v354 = v346 + v352 - 1
            v353 = string.sub(p345, v346, v354)
            v346 = v346 + v352
        end
        if not v353 then
            return nil, "Truncated item name"
        end
        local v355 = u185(v353)
        if #v355 == 0 then
            return nil, "Empty item name after cleanup"
        end
        local v356
        if #p345 < v346 then
            v356 = nil
        else
            v356 = string.byte(p345, v346)
            v346 = v346 + 1
        end
        if not v356 then
            return nil, "Truncated item flags"
        end
        local v357 = bit32.band(v356, 1) > 0
        local v358 = bit32.band(v356, 2) > 0
        local v359 = bit32.band(v356, 4) > 0
        local v360
        if v346 + 1 > #p345 then
            v360 = nil
        else
            local v361 = string.byte(p345, v346)
            local v362 = v346 + 1
            local v363 = string.byte(p345, v362)
            v346 = v346 + 2
            v360 = v361 * 256 + v363
        end
        if not v360 then
            return nil, "Truncated color group count"
        end
        local v364 = nil
        for _ = 1, v360 do
            local v365
            if #p345 < v346 then
                v365 = nil
            else
                v365 = string.byte(p345, v346)
                v346 = v346 + 1
            end
            local v366
            if #p345 < v346 then
                v366 = nil
            else
                local v367 = v346
                v366 = string.byte(p345, v367)
                v346 = v346 + 1
            end
            local v368
            if #p345 < v346 then
                v368 = nil
            else
                local v369 = v346
                v368 = string.byte(p345, v369)
                v346 = v346 + 1
            end
            if not (v365 and (v366 and v368)) then
                return nil, "Truncated color RGB"
            end
            local v370 = string.format("#%02x%02x%02x", v365, v366, v368)
            local v371
            if v346 + 1 > #p345 then
                v371 = nil
            else
                local v372 = string.byte(p345, v346)
                local v373 = v346 + 1
                local v374 = string.byte(p345, v373)
                v346 = v346 + 2
                v371 = v372 * 256 + v374
            end
            if not v371 then
                return nil, "Truncated guid count"
            end
            for _ = 1, v371 do
                local v375
                if v346 + 4 - 1 > #p345 then
                    v375 = nil
                else
                    local v376 = v346 + 4 - 1
                    v375 = string.sub(p345, v346, v376)
                    v346 = v346 + 4
                end
                if not v375 then
                    return nil, "Truncated guid prefix"
                end
                v364 = v364 or {}
                v364[string.format("%02x%02x%02x%02x", string.byte(v375, 1), string.byte(v375, 2), string.byte(v375, 3), string.byte(v375, 4)) .. "-0000-0000-0000-000000000000"] = v370
            end
        end
        if v358 then
            local v377
            if v346 + 1 > #p345 then
                v377 = nil
            else
                local v378 = string.byte(p345, v346)
                local v379 = v346 + 1
                local v380 = string.byte(p345, v379)
                v346 = v346 + 2
                v377 = v378 * 256 + v380
            end
            if not v377 then
                return nil, "Truncated extended count"
            end
            for _ = 1, v377 do
                local v381
                if v346 + 4 - 1 > #p345 then
                    v381 = nil
                else
                    local v382 = v346 + 4 - 1
                    v381 = string.sub(p345, v346, v382)
                    v346 = v346 + 4
                end
                if not v381 then
                    return nil, "Truncated extended guid prefix"
                end
                local v383 = string.format("%02x%02x%02x%02x", string.byte(v381, 1), string.byte(v381, 2), string.byte(v381, 3), string.byte(v381, 4))
                local v384
                if #p345 < v346 then
                    v384 = nil
                else
                    v384 = string.byte(p345, v346)
                    v346 = v346 + 1
                end
                if not v384 then
                    return nil, "Truncated suffix type"
                end
                local v385 = u189[v384] or ""
                local v386
                if #p345 < v346 then
                    v386 = nil
                else
                    v386 = string.byte(p345, v346)
                    v346 = v346 + 1
                end
                local v387
                if #p345 < v346 then
                    v387 = nil
                else
                    local v388 = v346
                    v387 = string.byte(p345, v388)
                    v346 = v346 + 1
                end
                local v389
                if #p345 < v346 then
                    v389 = nil
                else
                    local v390 = v346
                    v389 = string.byte(p345, v390)
                    v346 = v346 + 1
                end
                if not (v386 and (v387 and v389)) then
                    return nil, "Truncated extended color RGB"
                end
                local v391 = string.format("#%02x%02x%02x", v386, v387, v389)
                local v392 = v383 .. "-0000-0000-0000-000000000000"
                if v385 ~= "" then
                    v392 = v392 .. v385
                end
                v364 = v364 or {}
                v364[v392] = v391
            end
        end
        local v393 = nil
        if v359 then
            local v394
            if v346 + 1 > #p345 then
                v394 = nil
            else
                local v395 = string.byte(p345, v346)
                local v396 = v346 + 1
                local v397 = string.byte(p345, v396)
                v346 = v346 + 2
                v394 = v395 * 256 + v397
            end
            if not v394 then
                return nil, "Truncated material count"
            end
            for _ = 1, v394 do
                local v398
                if v346 + 4 - 1 > #p345 then
                    v398 = nil
                else
                    local v399 = v346 + 4 - 1
                    v398 = string.sub(p345, v346, v399)
                    v346 = v346 + 4
                end
                if not v398 then
                    return nil, "Truncated material guid prefix"
                end
                local v400 = string.format("%02x%02x%02x%02x", string.byte(v398, 1), string.byte(v398, 2), string.byte(v398, 3), string.byte(v398, 4))
                local v401
                if v346 + 1 > #p345 then
                    v401 = nil
                else
                    local v402 = string.byte(p345, v346)
                    local v403 = v346 + 1
                    local v404 = string.byte(p345, v403)
                    v346 = v346 + 2
                    v401 = v402 * 256 + v404
                end
                if not v401 then
                    return nil, "Truncated material enum value"
                end
                local v405 = nil
                for _, v406 in Enum.Material:GetEnumItems() do
                    if v406.Value == v401 then
                        v405 = v406.Name
                        break
                    end
                end
                if v405 then
                    local v407
                    if typeof(v405) == "string" then
                        v407 = u3[v405] == true
                    else
                        v407 = false
                    end
                    if v407 then
                        v393 = v393 or {}
                        v393[v400 .. "-0000-0000-0000-000000000000"] = v405
                    end
                end
            end
        end
        local v408
        if v357 then
            local v409 = {}
            for v410 = 1, 12 do
                local v411
                if v346 + 3 > #p345 then
                    v411 = nil
                else
                    local v412 = v346 + 3
                    local v413 = string.sub(p345, v346, v412)
                    v346 = v346 + 4
                    local v414 = buffer.fromstring(v413)
                    v411 = buffer.readf32(v414, 0)
                end
                if not v411 then
                    return nil, "Truncated CFrame data"
                end
                v409[v410] = v411
            end
            v408 = u212(v409)
        else
            v408 = nil
        end
        table.insert(v351, {
            ["name"] = v355,
            ["colors"] = v364,
            ["cframeArray"] = v408,
            ["materials"] = v393
        })
    end
    if #v351 == 0 then
        return nil, "No valid items"
    else
        return {
            ["items"] = v351
        }, nil
    end
end
local function u446(p416) --[[ Line: 1073 ]]
    --[[
    Upvalues:
        [1] = u185
        [2] = u187
        [3] = u212
        [4] = u3
    --]]
    if typeof(p416) ~= "table" then
        return nil, nil, nil, nil
    end
    local v417 = p416.n
    if typeof(v417) ~= "string" or (#v417 == 0 or #v417 > 100) then
        return nil, nil, nil, nil
    end
    local v418 = u185(v417)
    if #v418 == 0 then
        return nil, nil, nil, nil
    end
    local v419 = nil
    local v420 = nil
    local v421 = nil
    if p416.c then
        local v422 = p416.c
        if typeof(v422) == "string" then
            local v423 = p416.c
            if #v423 % 38 == 0 and #v423 > 0 then
                v419 = {}
                for v424 = 1, #v423, 38 do
                    local v425 = v424 + 31
                    local v426 = string.sub(v423, v424, v425)
                    local v427 = v424 + 32
                    local v428 = v424 + 37
                    local v429 = string.sub(v423, v427, v428)
                    local v430
                    if typeof(v426) == "string" and #v426 == 32 then
                        v430 = string.match(v426, "^%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
                    else
                        v430 = false
                    end
                    if v430 then
                        local v431
                        if typeof(v429) == "string" then
                            local v432
                            if string.sub(v429, 1, 1) == "#" then
                                v432 = string.sub(v429, 2)
                            else
                                v432 = v429
                            end
                            if #v432 == 6 then
                                v431 = string.match(v432, "^%x%x%x%x%x%x$") ~= nil
                            else
                                v431 = false
                            end
                        else
                            v431 = false
                        end
                        if v431 then
                            local v433 = u187(v426)
                            if v433 then
                                v419[v433] = "#" .. v429
                            end
                        end
                    end
                end
                if not next(v419) then
                    v419 = nil
                end
            end
        end
    end
    if p416.xc then
        local v434 = p416.xc
        if typeof(v434) == "table" then
            v419 = v419 or {}
            for v435, v436 in pairs(p416.xc) do
                if typeof(v435) == "string" and typeof(v436) == "string" then
                    local v437
                    if typeof(v436) == "string" then
                        local v438
                        if string.sub(v436, 1, 1) == "#" then
                            v438 = string.sub(v436, 2)
                        else
                            v438 = v436
                        end
                        if #v438 == 6 then
                            v437 = string.match(v438, "^%x%x%x%x%x%x$") ~= nil
                        else
                            v437 = false
                        end
                    else
                        v437 = false
                    end
                    if v437 then
                        v419[v435] = "#" .. v436
                    end
                end
            end
            if not next(v419) then
                v419 = nil
            end
        end
    end
    if p416.p then
        v420 = u212(p416.p)
    end
    if p416.m then
        local v439 = p416.m
        if typeof(v439) == "table" then
            local v440 = 0
            v421 = {}
            for v441, v442 in pairs(p416.m) do
                if v440 >= (1 / 0) then
                    break
                end
                if typeof(v441) == "string" then
                    local v443
                    if typeof(v442) == "string" then
                        v443 = u3[v442] == true
                    else
                        v443 = false
                    end
                    if v443 then
                        local v444
                        if typeof(v441) == "string" and #v441 == 32 then
                            v444 = string.match(v441, "^%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
                        else
                            v444 = false
                        end
                        if v444 then
                            local v445 = u187(v441)
                            if v445 then
                                v421[v445] = v442
                                v440 = v440 + 1
                            end
                        end
                    end
                end
            end
            if not next(v421) then
                v421 = nil
            end
        end
    end
    return v418, v419, v420, v421
end
local function u448(p447) --[[ Line: 1174 ]]
    --[[
    Upvalues:
        [1] = u214
    --]]
    if p447 then
        if typeof(p447) == "CFrame" then
            return { p447:GetComponents() }
        elseif typeof(p447) == "buffer" then
            return u214(p447)
        elseif typeof(p447) == "table" then
            return p447
        else
            return nil
        end
    else
        return nil
    end
end
function u2.ExportMultiple(p449, p450, p451, p452) --[[ Line: 1199 ]]
    --[[
    Upvalues:
        [1] = u448
        [2] = u344
        [3] = u82
        [4] = u123
    --]]
    local v453 = {}
    local v454 = 0
    local v455 = {}
    if p449 and typeof(p449) == "table" then
        for v456, v457 in pairs(p449) do
            if v454 >= 50 then
                break
            end
            if typeof(v456) == "string" and (typeof(v457) == "table" and (not p451 or p451[v456] ~= false)) then
                local v458
                if p450 and p450[v456] then
                    v458 = u448(p450[v456])
                else
                    v458 = nil
                end
                local v459
                if p452 and p452[v456] then
                    v459 = p452[v456]
                else
                    v459 = nil
                end
                table.insert(v453, {
                    ["name"] = v456,
                    ["colors"] = v457,
                    ["cframeArray"] = v458,
                    ["materials"] = v459
                })
                v455[v456] = true
                v454 = v454 + 1
            end
        end
    end
    if p450 and typeof(p450) == "table" then
        for v460, v461 in pairs(p450) do
            if v454 >= 50 then
                break
            end
            if not v455[v460] and (typeof(v460) == "string" and (not p451 or p451[v460] ~= false)) then
                local v462 = u448(v461)
                local v463
                if p452 and p452[v460] then
                    v463 = p452[v460]
                else
                    v463 = nil
                end
                table.insert(v453, {
                    ["name"] = v460,
                    ["colors"] = nil,
                    ["cframeArray"] = v462,
                    ["materials"] = v463
                })
                v455[v460] = true
                v454 = v454 + 1
            end
        end
    end
    if #v453 == 0 then
        return nil, "No tailor data"
    end
    local v464, v465 = u344(v453)
    if not v464 then
        return nil, v465 or "Pack failed"
    end
    local v466 = u82(v464)
    local v467
    if v466 then
        if #v466 > 0 then
            v467 = #v466 < #v464
        else
            v467 = false
        end
    else
        v467 = v466
    end
    local v468
    if v467 then
        v468 = "\1" .. v466
    else
        v468 = "\0" .. v464
    end
    return "GPO3-" .. u123(v468), nil
end
function u2.ExportSingle(p469, p470, p471, p472) --[[ Line: 1307 ]]
    --[[
    Upvalues:
        [1] = u448
        [2] = u344
        [3] = u82
        [4] = u123
    --]]
    if typeof(p469) ~= "string" or #p469 == 0 then
        return nil, "Invalid item name"
    end
    local v473, v474 = u344({
        {
            ["name"] = p469,
            ["colors"] = p470,
            ["cframeArray"] = u448(p471),
            ["materials"] = p472
        }
    })
    if not v473 then
        return nil, v474 or "Pack failed"
    end
    local v475 = u82(v473)
    local v476
    if v475 then
        if #v475 > 0 then
            v476 = #v475 < #v473
        else
            v476 = false
        end
    else
        v476 = v475
    end
    local v477
    if v476 then
        v477 = "\1" .. v475
    else
        v477 = "\0" .. v473
    end
    return "GPO3-" .. u123(v477), nil
end
function u2.Decode(p478) --[[ Line: 1352 ]]
    --[[
    Upvalues:
        [1] = u140
        [2] = u98
        [3] = u415
        [4] = u62
        [5] = u1
        [6] = u446
    --]]
    if typeof(p478) == "string" then
        if #p478 > 50000 then
            return nil, "Code too long"
        else
            local v479 = string.gsub(p478, "%s+", "")
            if #v479 < 10 then
                return nil, "Code too short"
            elseif string.sub(v479, 1, 5) == "GPOS-" then
                local v480 = string.sub(v479, 6)
                if #v480 == 6 and string.match(v480, "^[A-Za-z0-9]+$") then
                    return {
                        ["needsServerFetch"] = true,
                        ["shortCode"] = v480
                    }, nil
                else
                    return nil, "Invalid share code format"
                end
            elseif string.sub(v479, 1, 5) == "GPO3-" then
                local v481 = u140((string.sub(v479, 6)))
                if v481 and #v481 >= 2 then
                    local v482 = string.byte(v481, 1)
                    local v483 = string.sub(v481, 2)
                    local v484 = v482 ~= 1 or u98(v483)
                    if v484 then
                        return u415(v484)
                    else
                        return nil, "Decompression failed"
                    end
                else
                    return nil, "Invalid Base91"
                end
            elseif string.sub(v479, 1, 5) == "GPO2-" then
                local v485 = u62((string.sub(v479, 6)))
                if v485 then
                    local u486 = u98(v485)
                    if u486 then
                        if #u486 > 50000 then
                            return nil, "Data too large"
                        else
                            local v487, v488 = pcall(function() --[[ Line: 1421 ]]
                                --[[
                                Upvalues:
                                    [1] = u1
                                    [2] = u486
                                --]]
                                return u1:JSONDecode(u486)
                            end)
                            if v487 and typeof(v488) == "table" then
                                if v488.v == 2 then
                                    local v489 = v488.i
                                    if typeof(v489) == "table" then
                                        local v490 = v488.i
                                        local v491 = 0
                                        local v492 = nil or 50
                                        for _ in pairs(v490) do
                                            v491 = v491 + 1
                                            if v492 < v491 then
                                                break
                                            end
                                        end
                                        if v491 > 50 then
                                            return nil, "Too many items"
                                        else
                                            local v493 = {}
                                            for _, v494 in ipairs(v488.i) do
                                                local v495, v496, v497, v498 = u446(v494)
                                                if v495 then
                                                    table.insert(v493, {
                                                        ["name"] = v495,
                                                        ["colors"] = v496,
                                                        ["cframeArray"] = v497,
                                                        ["materials"] = v498
                                                    })
                                                end
                                            end
                                            if #v493 == 0 then
                                                return nil, "No valid items"
                                            else
                                                return {
                                                    ["items"] = v493
                                                }, nil
                                            end
                                        end
                                    else
                                        return nil, "Invalid structure"
                                    end
                                else
                                    return nil, "Unsupported version"
                                end
                            else
                                return nil, "Parse failed"
                            end
                        end
                    else
                        return nil, "Decompression failed"
                    end
                else
                    return nil, "Invalid base64"
                end
            else
                return nil, "Invalid code prefix"
            end
        end
    else
        return nil, "Invalid code type"
    end
end
function u2.Import(p499, p500, p501) --[[ Line: 1477 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u221
        [4] = u1
    --]]
    if typeof(p499) ~= "Instance" or not p499:IsA("Player") then
        return nil, "Invalid player"
    end
    local v502, v503 = u2.Decode(p500)
    if not v502 then
        return nil, v503
    end
    local v504 = p501.GetProfile(p499)
    if not v504 then
        return nil, "Profile not found"
    end
    local u505 = p501.GetStats(p499)
    if not u505 then
        return nil, "Stats not found"
    end
    if not v504.Data.CustomTailoredColors then
        v504.Data.CustomTailoredColors = {}
    end
    if not v504.Data.CustomTailoredCFrames then
        v504.Data.CustomTailoredCFrames = {}
    end
    if not v504.Data.CustomTailoredMaterials then
        v504.Data.CustomTailoredMaterials = {}
    end
    local v506 = 0
    local v507 = 0
    for _, v508 in ipairs(v502.items) do
        local v509 = v508.name
        if p501.HasItem(p499, v509) then
            if p501.ToolDesc[v509] then
                local v510 = p501.ToolsFolder:FindFirstChild(v509)
                if v510 then
                    local v511 = v510:GetDescendants()
                    local u512 = {}
                    local v513 = {}
                    for v514 = 1, #v511 do
                        local v515 = v511[v514]:GetAttribute("UniqueID")
                        if v515 and typeof(v515) == "string" then
                            u512[v515] = true
                            if v511[v514]:IsA("BasePart") then
                                v513[v515] = true
                            end
                        end
                    end
                    local v516 = {}
                    for v517, _ in pairs(u512) do
                        local v518 = string.gsub(v517, "-", ""):lower()
                        v516[string.sub(v518, 1, 8)] = v517
                    end
                    u2.ResolveV3Prefixes({
                        ["items"] = { v508 }
                    }, {
                        [v508.name] = v516
                    })
                    local v519 = false
                    local v520 = false
                    if v508.colors then
                        local v521 = 0
                        local function v526(p522) --[[ Line: 1563 ]]
                            --[[
                            Upvalues:
                                [1] = u512
                            --]]
                            if u512[p522] then
                                return true
                            end
                            local v523 = string.gsub(p522, "_fill$", "")
                            local v524 = string.gsub(v523, "_outline$", "")
                            local v525 = string.gsub(v524, "_tint$", "")
                            return u512[string.gsub(v525, "_emissive$", "")] == true
                        end
                        local v527 = {}
                        for v528, u529 in pairs(v508.colors) do
                            if v521 >= (1 / 0) then
                                break
                            end
                            if v526(v528) then
                                local v530
                                if typeof(u529) == "string" then
                                    local v531
                                    if string.sub(u529, 1, 1) == "#" then
                                        v531 = string.sub(u529, 2)
                                    else
                                        v531 = u529
                                    end
                                    if #v531 == 6 then
                                        v530 = string.match(v531, "^%x%x%x%x%x%x$") ~= nil
                                    else
                                        v530 = false
                                    end
                                else
                                    v530 = false
                                end
                                if v530 and pcall(function() --[[ Line: 1588 ]]
                                    --[[
                                    Upvalues:
                                        [1] = u529
                                    --]]
                                    return Color3.fromHex(u529)
                                end) then
                                    v527[v528] = u529
                                    v521 = v521 + 1
                                end
                            end
                        end
                        if next(v527) then
                            v504.Data.CustomTailoredColors[v509] = v527
                            v519 = true
                        end
                    end
                    if v508.materials then
                        local v532 = 0
                        local v533 = {}
                        for v534, v535 in pairs(v508.materials) do
                            if v532 >= (1 / 0) then
                                break
                            end
                            if v513[v534] then
                                local v536
                                if typeof(v535) == "string" then
                                    v536 = u3[v535] == true
                                else
                                    v536 = false
                                end
                                if v536 then
                                    v533[v534] = v535
                                    v532 = v532 + 1
                                end
                            end
                        end
                        if next(v533) then
                            v504.Data.CustomTailoredMaterials[v509] = v533
                            v520 = true
                        end
                    end
                    local v537 = v508.cframeArray and u221(v508.cframeArray)
                    if v537 then
                        v504.Data.CustomTailoredCFrames[v509] = v537
                    end
                    if v519 or (v520 or v508.cframeArray) then
                        v506 = v506 + 1
                    else
                        v507 = v507 + 1
                    end
                else
                    v507 = v507 + 1
                end
            else
                v507 = v507 + 1
            end
        else
            v507 = v507 + 1
        end
    end
    local v538, v539 = pcall(function() --[[ Line: 1649 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u505
        --]]
        return u1:JSONDecode(u505.Inventory.CustomTailoredOutfitsToggle.Value)
    end)
    local u540 = (not v538 or typeof(v539) ~= "table") and {} or v539
    for v541, _ in pairs(v504.Data.CustomTailoredColors) do
        u540[v541] = true
    end
    local v542, v543 = pcall(function() --[[ Line: 1661 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u540
        --]]
        return u1:JSONEncode(u540)
    end)
    if v542 then
        u505.Inventory.CustomTailoredOutfitsToggle.Value = v543
    end
    return {
        ["appliedItems"] = v506,
        ["skippedItems"] = v507
    }
end
function u2.ApplyToComponents(p544, p545, p546) --[[ Line: 1684 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u212
    --]]
    local v547 = {}
    local v548 = 0
    local v549 = 0
    local v550 = 0
    local v551 = 0
    local v552 = nil
    for v553, v554 in pairs(p545) do
        local v555 = nil
        if typeof(v553) == "Instance" then
            v555 = v553:GetAttribute("UniqueID")
        elseif v554.partID then
            v555 = v554.partID
        end
        if v555 then
            v547[v555] = v554
        end
    end
    for _, v556 in ipairs(p544.items) do
        if not p546 or v556.name == p546 then
            if v556.colors then
                for v557, u558 in pairs(v556.colors) do
                    local v559 = v547[v557]
                    if v559 then
                        local v560, v561 = pcall(function() --[[ Line: 1715 ]]
                            --[[
                            Upvalues:
                                [1] = u558
                            --]]
                            return Color3.fromHex(u558)
                        end)
                        if v560 and v559.SetColor then
                            v559:SetColor(v561)
                            v548 = v548 + 1
                        else
                            v549 = v549 + 1
                        end
                    else
                        v549 = v549 + 1
                    end
                end
            end
            if v556.materials then
                for v562, v563 in pairs(v556.materials) do
                    local v564 = v547[v562]
                    if v564 and (v564.isBasePart and v564.SetMaterial) then
                        local v565 = u3[v563] == true
                        if not v565 then
                            local v566 = v564.Part:GetAttribute("OrgDefaultMaterial")
                            v565 = v566 and v566 == v563 and true or v565
                        end
                        if v565 then
                            local v567 = Enum.Material[v563]
                            if v567 then
                                v564:SetMaterial(v567)
                                v550 = v550 + 1
                            else
                                v551 = v551 + 1
                            end
                        else
                            v551 = v551 + 1
                        end
                    else
                        v551 = v551 + 1
                    end
                end
            end
            if v556.cframeArray then
                local v568 = u212(v556.cframeArray)
                if v568 then
                    v552 = CFrame.new(unpack(v568))
                end
            end
        end
    end
    return {
        ["appliedColors"] = v548,
        ["skippedColors"] = v549,
        ["appliedMaterials"] = v550,
        ["skippedMaterials"] = v551,
        ["offset"] = v552
    }
end
function u2.ResolveV3Prefixes(p569, p570) --[[ Line: 1787 ]]
    --[[
    Upvalues:
        [1] = u189
    --]]
    if not (p569 and p570) then
        return p569
    end
    for _, v571 in ipairs(p569.items) do
        local v572 = p570[v571.name]
        if v572 then
            if v571.colors then
                local v573 = {}
                for v574, v575 in pairs(v571.colors) do
                    local v576 = v574
                    local v577 = ""
                    for _, v578 in pairs(u189) do
                        local v579 = -#v578
                        if string.sub(v574, v579) == v578 then
                            local v580 = -#v578 - 1
                            v576 = string.sub(v574, 1, v580)
                            v577 = v578
                            break
                        end
                    end
                    local v581 = string.gsub(v576, "-", ""):lower()
                    local v582 = v572[string.sub(v581, 1, 8)]
                    if v582 then
                        v573[v582 .. v577] = v575
                    end
                end
                v571.colors = v573
            end
            if v571.materials then
                local v583 = {}
                for v584, v585 in pairs(v571.materials) do
                    local v586 = string.gsub(v584, "-", ""):lower()
                    local v587 = v572[string.sub(v586, 1, 8)]
                    if v587 then
                        v583[v587] = v585
                    end
                end
                v571.materials = v583
            end
        end
    end
    return p569
end
function u2.ExportLoadout(p588) --[[ Line: 1836 ]]
    --[[
    Upvalues:
        [1] = u448
        [2] = u250
        [3] = u1
        [4] = u82
        [5] = u33
    --]]
    if typeof(p588) ~= "table" then
        return nil, "Invalid slot data"
    end
    local u589 = {
        ["v"] = 3,
        ["e"] = p588.Items or {},
        ["a"] = p588.Vanity or {},
        ["t"] = p588.Title or "",
        ["s"] = p588.FightingStyle or "",
        ["i"] = {}
    }
    local v590 = 0
    local v591 = {}
    if p588.TailoredColors then
        local v592 = p588.TailoredColors
        if typeof(v592) == "table" then
            for v593, v594 in pairs(p588.TailoredColors) do
                if v590 >= 50 then
                    break
                end
                if typeof(v593) == "string" and (typeof(v594) == "table" and (not p588.TailoredToggles or p588.TailoredToggles[v593] ~= false)) then
                    local v595
                    if p588.TailoredCFrames and p588.TailoredCFrames[v593] then
                        v595 = u448(p588.TailoredCFrames[v593])
                    else
                        v595 = nil
                    end
                    local v596
                    if p588.TailoredMaterials and p588.TailoredMaterials[v593] then
                        v596 = p588.TailoredMaterials[v593]
                    else
                        v596 = nil
                    end
                    local v597 = u250(v593, v594, v595, v596)
                    if v597 then
                        local v598 = u589.i
                        table.insert(v598, v597)
                        v591[v593] = true
                        v590 = v590 + 1
                    end
                end
            end
        end
    end
    if p588.TailoredCFrames then
        local v599 = p588.TailoredCFrames
        if typeof(v599) == "table" then
            for v600, v601 in pairs(p588.TailoredCFrames) do
                if v590 >= 50 then
                    break
                end
                if not v591[v600] and (typeof(v600) == "string" and (not p588.TailoredToggles or p588.TailoredToggles[v600] ~= false)) then
                    local v602 = u448(v601)
                    local v603
                    if p588.TailoredMaterials and p588.TailoredMaterials[v600] then
                        v603 = p588.TailoredMaterials[v600]
                    else
                        v603 = nil
                    end
                    local v604 = u250(v600, nil, v602, v603)
                    if v604 then
                        local v605 = u589.i
                        table.insert(v605, v604)
                        v591[v600] = true
                        v590 = v590 + 1
                    end
                end
            end
        end
    end
    if #u589.e == 0 and #u589.a == 0 then
        return nil, "No loadout data"
    else
        local v606, v607 = pcall(function() --[[ Line: 1905 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u589
            --]]
            return u1:JSONEncode(u589)
        end)
        if v606 then
            local v608 = u82(v607)
            if v608 and #v608 ~= 0 then
                return "GPOL-" .. u33(v608), nil
            else
                return nil, "Compression failed"
            end
        else
            return nil, "Encode failed"
        end
    end
end
function u2.DecodeLoadout(p609) --[[ Line: 1921 ]]
    --[[
    Upvalues:
        [1] = u62
        [2] = u98
        [3] = u1
        [4] = u185
        [5] = u446
    --]]
    if typeof(p609) ~= "string" then
        return nil, "Invalid code type"
    end
    if #p609 > 50000 then
        return nil, "Code too long"
    end
    local v610 = string.gsub(p609, "%s+", "")
    if #v610 < 10 then
        return nil, "Code too short"
    end
    if string.sub(v610, 1, 5) ~= "GPOL-" then
        return nil, "Invalid code prefix"
    end
    local v611 = u62((string.sub(v610, 6)))
    if not v611 then
        return nil, "Invalid base64"
    end
    local u612 = u98(v611)
    if not u612 then
        return nil, "Decompression failed"
    end
    if #u612 > 50000 then
        return nil, "Data too large"
    end
    local v613, v614 = pcall(function() --[[ Line: 1956 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u612
        --]]
        return u1:JSONDecode(u612)
    end)
    if not v613 or typeof(v614) ~= "table" then
        return nil, "Parse failed"
    end
    if v614.v ~= 3 then
        return nil, "Unsupported version"
    end
    local v615 = {}
    local v616 = v614.e
    if typeof(v616) == "table" then
        for _, v617 in ipairs(v614.e) do
            if typeof(v617) == "string" and (#v617 > 0 and #v617 <= 100) then
                local v618 = u185
                table.insert(v615, v618(v617))
            end
        end
    end
    local v619 = {}
    local v620 = v614.a
    if typeof(v620) == "table" then
        for _, v621 in ipairs(v614.a) do
            if typeof(v621) == "string" and (#v621 > 0 and #v621 <= 100) then
                local v622 = u185
                table.insert(v619, v622(v621))
            end
        end
    end
    local v623 = v614.t
    local v624 = (typeof(v623) ~= "string" or #v614.t > 100) and "" or u185(v614.t)
    local v625 = v614.s
    local v626 = (typeof(v625) ~= "string" or #v614.s > 100) and "" or u185(v614.s)
    local v627 = {}
    local v628 = v614.i
    if typeof(v628) == "table" then
        local v629 = v614.i
        local v630 = 0
        local v631 = nil or 50
        for _ in pairs(v629) do
            v630 = v630 + 1
            if v631 < v630 then
                break
            end
        end
        if v630 <= 50 then
            for _, v632 in ipairs(v614.i) do
                local v633, v634, v635, v636 = u446(v632)
                if v633 then
                    table.insert(v627, {
                        ["name"] = v633,
                        ["colors"] = v634,
                        ["cframeArray"] = v635,
                        ["materials"] = v636
                    })
                end
            end
        end
    end
    return {
        ["items"] = v615,
        ["vanity"] = v619,
        ["title"] = v624,
        ["fightingStyle"] = v626,
        ["tailorItems"] = v627
    }, nil
end
function u2.PromptPortCodeUI(u637, p638) --[[ Line: 2022 ]]
    local v639 = game:GetService("Players").LocalPlayer
    if v639 then
        v639 = v639:FindFirstChild("PlayerGui")
    end
    if not v639 then
        return nil
    end
    local v640 = v639:FindFirstChild("PortCodeUI")
    if v640 then
        v640:Destroy()
    end
    local v641 = script:FindFirstChild("PortCodeUI")
    if not v641 then
        return nil
    end
    local u642 = v641:Clone()
    local v643 = u642:FindFirstChild("PortFrame")
    local v644 = v643:FindFirstChild("PortType")
    local u645 = v643:FindFirstChild("TextBox")
    local v646 = v643:FindFirstChild("CloseButton")
    u645.ClearTextOnFocus = false
    u645.TextWrapped = true
    if u637 == "Export" then
        v644.Text = "Export"
        u645.Text = p638 or ""
        u645.TextEditable = false
    else
        v644.Text = "Import"
        u645.Text = ""
        u645.TextEditable = true
    end
    u642.Parent = v639
    if u637 == "Import" then
        u645:CaptureFocus()
    end
    local u647 = nil
    local u648 = false
    v646.MouseButton1Click:Once(function() --[[ Line: 2069 ]]
        --[[
        Upvalues:
            [1] = u637
            [2] = u647
            [3] = u645
            [4] = u648
            [5] = u642
        --]]
        if u637 == "Import" then
            u647 = u645.Text
        end
        u648 = true
        u642:Destroy()
    end)
    local v649 = u647
    while not u648 do
        task.wait()
    end
    return v649
end
u2.CFrameBufferToArray = u214
u2.ArrayToCFrameBuffer = u221
u2.ValidateCFrameArray = u212
u2.CleanUtf8String = u185
u2.ALLOWED_MATERIALS = u3
u2.SHARED_PREFIX = "GPOS-"
function u2.IsValidMaterial(p650) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v651
    if typeof(p650) == "string" then
        v651 = u3[p650] == true
    else
        v651 = false
    end
    return v651
end
return u2
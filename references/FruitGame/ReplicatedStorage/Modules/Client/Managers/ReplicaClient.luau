 

local v1 = game.ReplicatedStorage.ReplicaShared
local v2 = require(v1.Remote)
local u3 = require(v1.Signal)
local u4 = require(v1.Maid)
local u5 = {}
local v6 = game:GetService("CollectionService")
game:GetService("ReplicatedStorage")
game:GetService("Players")
local u7 = false
local u8 = {}
local u9 = {}
local u10 = {}
local u11 = {}
local u12 = {}
local u13 = v2.New("ReplicaRequestData")
local v14 = v2.New("ReplicaSet")
local v15 = v2.New("ReplicaSetValues")
local v16 = v2.New("ReplicaTableInsert")
local v17 = v2.New("ReplicaTableRemove")
local v18 = v2.New("ReplicaWrite")
local u19 = v2.New("ReplicaSignal")
local v20 = v2.New("ReplicaParent")
local v21 = v2.New("ReplicaCreate")
local v22 = v2.New("ReplicaBind")
local v23 = v2.New("ReplicaDestroy")
local u24 = v2.New("ReplicaSignalUnreliable", true)
local u25 = {}
local u26 = false
local function u39(p27) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u25
    --]]
    local v28 = u25[p27]
    if v28 ~= nil then
        return v28
    end
    local v29 = require(p27)
    local v30 = {}
    for v31, v32 in pairs(v29) do
        table.insert(v30, { v31, v32 })
    end
    table.sort(v30, function(p33, p34) --[[ Line: 128 ]]
        return p33[1] < p34[1]
    end)
    local v35 = {}
    for v36, v37 in ipairs(v30) do
        local v38 = {
            ["Name"] = v37[1],
            ["Id"] = v36,
            ["fn"] = v37[2]
        }
        v35[v37[1]] = v38
        v35[v36] = v38
    end
    u25[p27] = v35
    return v35
end
local u40 = nil
local function u43(p41, ...) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u40
    --]]
    local v42 = u40
    u40 = nil
    p41(...)
    u40 = v42
end
local function u44(...) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u43
    --]]
    u43(...)
    while true do
        u43(coroutine.yield())
    end
end
local u45 = {
    ["IsReady"] = false,
    ["OnLocalReady"] = u3.New()
}
u45.__index = u45
local function u54(p46, p47) --[[ Line: 199 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u10
        [3] = u9
        [4] = u3
        [5] = u4
        [6] = u5
        [7] = u45
    --]]
    local v48
    if p47[5] == nil then
        v48 = nil
    else
        v48 = u39(p47[5])
    end
    local v49 = p47[1]
    local v50 = u10[p47[4]] or u9[p47[4]]
    local v51 = {
        ["Tags"] = p47[2],
        ["Data"] = p47[3],
        ["Id"] = p46,
        ["Token"] = v49,
        ["Parent"] = v50,
        ["Children"] = {},
        ["BoundInstance"] = nil,
        ["OnClientEvent"] = u3.New(),
        ["Maid"] = u4.New(u5),
        ["self_creation"] = p47,
        ["write_lib"] = v48,
        ["set_listeners"] = {},
        ["write_listeners"] = {},
        ["changed_listeners"] = u3.New()
    }
    local v52 = u45
    local v53 = setmetatable(v51, v52)
    if v50 ~= nil then
        v50.Children[v53] = true
    end
    return v53
end
function u45.RequestData() --[[ Line: 238 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u13
        [3] = u45
    --]]
    if u7 ~= true then
        u7 = true
        task.spawn(function() --[[ Line: 246 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u45
            --]]
            u13:FireServer()
            while task.wait(2) and u45.IsReady ~= true do
                u13:FireServer()
            end
        end)
    end
end
function u45.OnNew(p55, u56) --[[ Line: 261 ]]
    --[[
    Upvalues:
        [1] = u12
        [2] = u3
        [3] = u8
        [4] = u40
        [5] = u44
    --]]
    if type(p55) ~= "string" then
        error((("[%*]: \"token\" must be a string"):format(script.Name)))
    end
    local v57 = u12[p55]
    if v57 == nil then
        v57 = u3.New()
        u12[p55] = v57
    end
    local v58 = u8[p55]
    local u59 = v57:Connect(u56)
    if v58 ~= nil then
        local u60 = {}
        for v61 in pairs(v58) do
            u60[v61] = true
        end
        task.defer(function() --[[ Line: 285 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u59
                [3] = u40
                [4] = u44
                [5] = u56
            --]]
            for v62 in pairs(u60) do
                if u59.IsConnected ~= true then
                    break
                end
                if not u40 then
                    u40 = coroutine.create(u44)
                end
                task.spawn(u40, u56, v62)
            end
        end)
    end
    return u59
end
function u45.FromId(p63) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    return u9[p63]
end
function u45.Test() --[[ Line: 306 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u9
        [3] = u10
        [4] = u11
    --]]
    return {
        ["TokenReplicas"] = u8,
        ["Replicas"] = u9,
        ["BindReplicas"] = u10,
        ["BindInstances"] = u11
    }
end
function u45.OnSet(p64, p65, p66) --[[ Line: 315 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v67 = table.concat(p65, ".")
    local v68 = p64.set_listeners[v67]
    if v68 == nil then
        v68 = u3.New()
        p64.set_listeners[v67] = v68
    end
    return v68:Connect(p66)
end
function u45.OnWrite(p69, p70, p71) --[[ Line: 326 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v72 = p69.write_listeners[p70]
    if v72 == nil then
        v72 = u3.New()
        p69.write_listeners[p70] = v72
    end
    return v72:Connect(p71)
end
function u45.OnChange(p73, p74) --[[ Line: 336 ]]
    return p73.changed_listeners:Connect(p74)
end
function u45.GetChild(p75, p76) --[[ Line: 340 ]]
    if type(p76) ~= "string" then
        error((("[%*]: \"token\" must be a string"):format(script.Name)))
    end
    for v77 in pairs(p75.Children) do
        if v77.Token == p76 then
            return v77
        end
    end
    return nil
end
function u45.FireServer(p78, ...) --[[ Line: 352 ]]
    --[[
    Upvalues:
        [1] = u19
    --]]
    u19:FireServer(p78.Id, ...)
end
function u45.UFireServer(p79, ...) --[[ Line: 356 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    u24:FireServer(p79.Id, ...)
end
function u45.Identify(p80) --[[ Line: 360 ]]
    local v81 = ""
    local v82 = true
    for v83, v84 in pairs(p80.Tags) do
        v81 = v81 .. ("%*%*=%*"):format(v82 == true and "" or ";", tostring(v83), (tostring(v84)))
        v82 = false
    end
    return ("[Id:%*;Token:%*;Tags:[%*]]"):format(p80.Id, p80.Token, v81)
end
function u45.IsActive(p85) --[[ Line: 370 ]]
    return p85.Maid:IsActive()
end
function u45.Set(p86, p87, p88) --[[ Line: 374 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if u26 ~= true then
        error((("[%*]: \"Set()\" can\'t be called outside of WriteLibs client-side"):format(script.Name)))
    end
    local v89 = p86.Data
    for v90 = 1, #p87 - 1 do
        v89 = v89[p87[v90]]
    end
    local v91 = p87[#p87]
    local v92 = v89[v91]
    v89[v91] = p88
    if next(p86.set_listeners) ~= nil then
        local v93 = p86.set_listeners[table.concat(p87, ".")]
        if v93 ~= nil then
            v93:Fire(p88, v92)
        end
    end
    p86.changed_listeners:Fire("Set", p87, p88, v92)
end
function u45.SetValues(p94, p95, p96) --[[ Line: 402 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if u26 ~= true then
        error((("[%*]: \"SetValues()\" can\'t be called outside of WriteLibs client-side"):format(script.Name)))
    end
    local v97 = p94.Data
    for _, v98 in ipairs(p95) do
        v97 = v97[v98]
    end
    for v99, v100 in pairs(p96) do
        v97[v99] = v100
    end
    p94.changed_listeners:Fire("SetValues", p95, p96)
end
function u45.TableInsert(p101, p102, p103, p104) --[[ Line: 424 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if u26 ~= true then
        error((("[%*]: \"TableInsert()\" can\'t be called outside of WriteLibs client-side"):format(script.Name)))
    end
    local v105 = p101.Data
    for _, v106 in ipairs(p102) do
        v105 = v105[v106]
    end
    if p104 == nil then
        table.insert(v105, p103)
        p104 = #v105
    else
        table.insert(v105, p104, p103)
    end
    p101.changed_listeners:Fire("TableInsert", p102, p103, p104)
    return p104
end
function u45.TableRemove(p107, p108, p109) --[[ Line: 451 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if u26 ~= true then
        error((("[%*]: \"TableRemove()\" can\'t be called outside of WriteLibs client-side"):format(script.Name)))
    end
    local v110 = p107.Data
    for _, v111 in ipairs(p108) do
        v110 = v110[v111]
    end
    local v112 = table.remove(v110, p109)
    p107.changed_listeners:Fire("TableRemove", p108, v112, p109)
    return v112
end
function u45.Write(p113, p114, ...) --[[ Line: 473 ]]
    --[[
    Upvalues:
        [1] = u26
    --]]
    if u26 ~= true then
        error((("[%*]: \"Write()\" can\'t be called outside of WriteLibs client-side"):format(script.Name)))
    end
    local v115 = p113.write_lib[p114]
    local v116 = table.pack(v115.fn(p113, ...))
    local v117 = p113.write_listeners[p114]
    if v117 ~= nil then
        v117:Fire(...)
    end
    return table.unpack(v116)
end
local function u123(p118, p119) --[[ Line: 495 ]]
    --[[
    Upvalues:
        [1] = u123
        [2] = u8
        [3] = u9
        [4] = u10
        [5] = u5
    --]]
    for v120 in pairs(p118.Children) do
        u123(v120, true)
    end
    if p119 ~= true and p118.Parent ~= nil then
        p118.Parent.Children[p118] = nil
    end
    local v121 = p118.Id
    local v122 = u8[p118.Token]
    if v122 ~= nil then
        v122[p118] = nil
    end
    if u9[v121] == p118 then
        u9[v121] = nil
    end
    if u10[v121] == p118 then
        u10[v121] = nil
    end
    p118.Maid:Unlock(u5)
    p118.Maid:Cleanup()
    p118.BoundInstance = nil
end
local function u128(p124, p125) --[[ Line: 527 ]]
    --[[
    Upvalues:
        [1] = u54
        [2] = u10
        [3] = u128
        [4] = u123
    --]]
    local v126 = u54(p124.Id, p124.self_creation)
    u10[p124.Id] = v126
    for v127 in pairs(p124.Children) do
        u128(v127, true)
    end
    if p125 ~= true then
        u123(p124)
    end
    return v126
end
local function u137(p129, p130) --[[ Line: 548 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u8
        [3] = u9
        [4] = u137
        [5] = u12
    --]]
    local v131
    if p130 == nil then
        p130 = {}
        v131 = true
    else
        v131 = false
    end
    u10[p129.Id] = nil
    local v132 = p129.Token
    local v133 = u8[v132]
    if v133 == nil then
        v133 = {}
        u8[v132] = v133
    end
    v133[p129] = true
    u9[p129.Id] = p129
    table.insert(p130, p129)
    for v134 in pairs(p129.Children) do
        u137(v134, p130)
    end
    if v131 == true then
        for _, v135 in ipairs(p130) do
            local v136 = u12[v135.Token]
            if v136 ~= nil then
                v136:Fire(v135)
            end
        end
    end
end
local function u145(p138, p139, p140) --[[ Line: 587 ]]
    --[[
    Upvalues:
        [1] = u145
    --]]
    local v141 = p138[p140]
    if v141 ~= nil then
        table.sort(v141, function(p142, p143) --[[ Line: 591 ]]
            return p142.Id < p143.Id
        end)
        for _, v144 in ipairs(v141) do
            p139(v144.Id, v144.SelfCreation)
            u145(p138, p139, v144.Id)
        end
    end
end
local function u178(p146, p147, p148) --[[ Line: 603 ]]
    --[[
    Upvalues:
        [1] = u145
    --]]
    local v149 = {}
    local v150 = {}
    local v151 = {}
    local v152 = p146[1]
    if type(v152) == "table" then
        for _, v153 in ipairs(p146) do
            for v154, v155 in pairs(v153) do
                local v156 = {
                    ["Id"] = tonumber(v154),
                    ["SelfCreation"] = v155
                }
                local v157 = v155[4]
                if v157 == 0 or v156.Id == p147 then
                    table.insert(v149, v156)
                elseif v153[tostring(v157)] == nil then
                    table.insert(v151, v156)
                else
                    local v158 = v150[v157]
                    if v158 == nil then
                        v158 = {}
                        v150[v157] = v158
                    end
                    table.insert(v158, v156)
                end
            end
        end
    else
        for v159, v160 in pairs(p146) do
            local v161 = {
                ["Id"] = tonumber(v159),
                ["SelfCreation"] = v160
            }
            local v162 = v160[4]
            if v162 == 0 or v161.Id == p147 then
                table.insert(v149, v161)
            elseif p146[tostring(v162)] == nil then
                table.insert(v151, v161)
            else
                local v163 = v150[v162]
                if v163 == nil then
                    v163 = {}
                    v150[v162] = v163
                end
                table.insert(v163, v161)
            end
        end
    end
    table.sort(v149, function(p164, p165) --[[ Line: 654 ]]
        return p164.Id < p165.Id
    end)
    local v166 = {}
    for _, v167 in ipairs(v149) do
        p148(v167.Id, v167.SelfCreation)
        u145(v150, p148, v167.Id)
    end
    if #v151 ~= 0 then
        local v168 = ("[%*]: GROUP REPLICATION ERROR - Missing parents for:\n"):format(script.Name)
        local v169 = #v151
        for v170 = 1, math.min(v169, 50) do
            local v171 = v151[v170]
            local v172 = v171.SelfCreation
            local v173 = ""
            local v174 = true
            for v175, v176 in pairs(v172[2]) do
                v173 = v173 .. ("%*%*=%*"):format(v174 == true and "" or ";", tostring(v175), (tostring(v176)))
                v174 = false
            end
            v168 = v168 .. ("[Id:%*;ParentId:%*;Token:%*;Tags:[%*]]\n"):format(v171.Id, v172[4], v172[1], v173)
        end
        if #v151 > 50 then
            v168 = v168 .. ("(hiding %* more)\n"):format(50 - #v151)
        end
        local v177 = v168 .. "Traceback:\n" .. debug.traceback()
        warn(v177)
    end
    return v166
end
u13.OnClientEvent:Connect(function() --[[ Line: 705 ]]
    --[[
    Upvalues:
        [1] = u45
    --]]
    if u45.IsReady ~= true then
        u45.IsReady = true
        print((("[%*]: Initial data received"):format(script.Name)))
        u45.OnLocalReady:Fire()
    end
end)
v14.OnClientEvent:Connect(function(p179, p180, p181) --[[ Line: 716 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u26
    --]]
    local v182 = u9[p179] or u10[p179]
    if v182 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p179)))
    end
    u26 = true
    local v183, v184 = pcall(v182.Set, v182, p180, p181)
    u26 = false
    if v183 ~= true then
        error(("[%*]: Error while updating replica:\n%*\n"):format(script.Name, (v182:Identify())) .. v184)
    end
end)
v15.OnClientEvent:Connect(function(p185, p186, p187) --[[ Line: 726 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u26
    --]]
    local v188 = u9[p185] or u10[p185]
    if v188 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p185)))
    end
    u26 = true
    local v189, v190 = pcall(v188.SetValues, v188, p186, p187)
    u26 = false
    if v189 ~= true then
        error(("[%*]: Error while updating replica:\n%*\n"):format(script.Name, (v188:Identify())) .. v190)
    end
end)
v16.OnClientEvent:Connect(function(p191, p192, p193, p194) --[[ Line: 736 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u26
    --]]
    local v195 = u9[p191] or u10[p191]
    if v195 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p191)))
    end
    u26 = true
    local v196, v197 = pcall(v195.TableInsert, v195, p192, p193, p194)
    u26 = false
    if v196 ~= true then
        error(("[%*]: Error while updating replica:\n%*\n"):format(script.Name, (v195:Identify())) .. v197)
    end
end)
v17.OnClientEvent:Connect(function(p198, p199, p200) --[[ Line: 746 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u26
    --]]
    local v201 = u9[p198] or u10[p198]
    if v201 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p198)))
    end
    u26 = true
    local v202, v203 = pcall(v201.TableRemove, v201, p199, p200)
    u26 = false
    if v202 ~= true then
        error(("[%*]: Error while updating replica:\n%*\n"):format(script.Name, (v201:Identify())) .. v203)
    end
end)
v18.OnClientEvent:Connect(function(p204, p205, ...) --[[ Line: 756 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u26
    --]]
    local v206 = u9[p204] or u10[p204]
    if v206 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p204)))
    end
    local v207 = v206.write_lib[p205].Name
    u26 = true
    local v208, v209 = pcall(v206.Write, v206, v207, ...)
    u26 = false
    if v208 ~= true then
        error(("[%*]: Error while updating replica:\n%*\n"):format(script.Name, (v206:Identify())) .. v209)
    end
end)
local function v212(p210, ...) --[[ Line: 767 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
    --]]
    local v211 = u9[p210] or u10[p210]
    if v211 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p210)))
    end
    v211.OnClientEvent:Fire(...)
end
u19.OnClientEvent:Connect(v212)
u24.OnClientEvent:Connect(v212)
v20.OnClientEvent:Connect(function(p213, p214) --[[ Line: 775 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u137
        [4] = u128
    --]]
    local v215 = u9[p213] or u10[p213]
    if v215 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p213)))
    end
    local v216 = v215.Parent
    local v217 = u9[p214] or u10[p214]
    if v217 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p214)))
    end
    v216.Children[v215] = nil
    v217.Children[v215] = true
    v215.Parent = v217
    v215.self_creation[4] = p214
    if u10[v216.Id] == nil or u9[p214] == nil then
        if u9[v216.Id] ~= nil and u10[p214] ~= nil then
            u128(v215)
        end
    else
        u137(v215)
    end
end)
v21.OnClientEvent:Connect(function(p218, p219) --[[ Line: 796 ]]
    --[[
    Upvalues:
        [1] = u178
        [2] = u54
        [3] = u11
        [4] = u10
        [5] = u8
        [6] = u9
        [7] = u12
    --]]
    local u220 = {}
    u178(p218, p219, function(p221, p222) --[[ Line: 800 ]]
        --[[
        Upvalues:
            [1] = u54
            [2] = u11
            [3] = u10
            [4] = u8
            [5] = u9
            [6] = u220
        --]]
        local v223 = p222[4]
        local v224 = u54(p221, p222)
        local v225 = false
        if v223 == 0 then
            if v224.Tags.Bind == true then
                local v226 = u11[p221]
                v224.BoundInstance = v226
                v225 = v226 == nil and true or v225
            end
        else
            v225 = u10[v223] ~= nil and true or v225
        end
        if v225 == true then
            u10[p221] = v224
        else
            local v227 = v224.Token
            local v228 = u8[v227]
            if v228 == nil then
                v228 = {}
                u8[v227] = v228
            end
            v228[v224] = true
            u9[p221] = v224
            local v229 = u220
            table.insert(v229, v224)
        end
    end)
    for _, v230 in ipairs(u220) do
        local v231 = u12[v230.Token]
        if v231 ~= nil then
            v231:Fire(v230)
        end
    end
end)
v22.OnClientEvent:Connect(function(p232) --[[ Line: 855 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u11
        [4] = u128
    --]]
    local v233 = u9[p232] or u10[p232]
    if v233 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p232)))
    end
    v233.Tags.Bind = true
    local v234 = u11[p232]
    v233.BoundInstance = v234
    if v234 == nil then
        u128(v233)
    end
end)
v23.OnClientEvent:Connect(function(p235) --[[ Line: 869 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u10
        [3] = u123
    --]]
    local v236 = u9[p235] or u10[p235]
    if v236 == nil then
        error((("[%*]: Received update for missing replica [Id:%*]"):format(script.Name, p235)))
    end
    u123(v236)
end)
v6:GetInstanceAddedSignal("REPLICA"):Connect(function(p237) --[[ Line: 904 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
        [3] = u137
    --]]
    if p237:IsA("NumberValue") == true then
        local v238 = p237.Value
        local v239 = p237.Parent
        u11[v238] = v239
        local v240 = u10[v238]
        if v240 ~= nil then
            v240.BoundInstance = v239
            u137(v240)
        end
    end
end)
v6:GetInstanceRemovedSignal("REPLICA"):Connect(function(p241) --[[ Line: 910 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u9
        [3] = u128
    --]]
    if p241:IsA("NumberValue") == true then
        local v242 = p241.Value
        u11[v242] = nil
        local v243 = u9[v242]
        if v243 ~= nil then
            u128(v243)
        end
    end
end)
for _, v244 in pairs(v6:GetTagged("REPLICA")) do
    if v244:IsA("NumberValue") == true then
        local v245 = v244.Value
        local v246 = v244.Parent
        u11[v245] = v246
        local v247 = u10[v245]
        if v247 ~= nil then
            v247.BoundInstance = v246
            u137(v247)
        end
    end
end
return u45
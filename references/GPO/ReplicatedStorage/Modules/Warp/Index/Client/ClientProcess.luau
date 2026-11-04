 

local v1 = {}
local u2 = game:GetService("RunService")
local v3 = script.Parent.Parent.Util
require(script.Parent.Parent.Type)
local v4 = require(script.Parent.Parent.Event)
local u5 = require(v3.Spawn)
local u6 = require(v3.Key)
local u7 = require(v3.RateLimit)
local u8 = require(v3.Buffer)
local u9 = {}
local u10 = {}
local u11 = {}
local u12 = {}
local u13 = {}
local u14 = {}
local u15 = {}
local u16 = {}
u15[1] = {}
u15[2] = {}
u16[1] = {}
u16[2] = {}
local u17 = v4.Reliable
local u18 = v4.Unreliable
local u19 = v4.Request
function v1.insertQueue(p20, p21, ...) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
    --]]
    if p21 then
        if not u10[p20] then
            u10[p20] = {}
        end
        local v22 = u10[p20]
        table.insert(v22, { ... })
    else
        if not u11[p20] then
            u11[p20] = {}
        end
        local v23 = u11[p20]
        table.insert(v23, { ... })
    end
end
function v1.insertRequest(p24, u25, ...) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u6
    --]]
    if not u13[p24] then
        u13[p24] = {}
    end
    local u26 = coroutine.running()
    local u27 = os.clock()
    local u28 = task.delay(u25, function() --[[ Line: 66 ]]
        --[[
        Upvalues:
            [1] = u26
        --]]
        task.spawn(u26, nil)
    end)
    local v29 = u13[p24]
    local v30 = {}
    local v31 = u6
    __set_list(v30, 1, {tostring(v31()), function(...) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u27
        [2] = u25
        [3] = u28
        [4] = u26
    --]]
    if u25 >= os.clock() - u27 then
        task.cancel(u28)
        task.spawn(u26, ...)
    end
end, { ... }})
    table.insert(v29, v30)
    return coroutine.yield()
end
function v1.add(p32, p33, _) --[[ Line: 77 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u9
        [3] = u7
        [4] = u10
        [5] = u11
        [6] = u13
        [7] = u12
        [8] = u16
        [9] = u15
    --]]
    if not u14[p32] then
        u14[p32] = true
        if not u9[p32] then
            u9[p32] = u7.create(p33)
        end
        if not u10[p32] then
            u10[p32] = {}
        end
        if not u11[p32] then
            u11[p32] = {}
        end
        if not u13[p32] then
            u13[p32] = {}
        end
        if not u12[p32] then
            u12[p32] = {}
        end
        if not u16[1][p32] then
            u16[1][p32] = {}
        end
        if not u16[2][p32] then
            u16[2][p32] = {}
        end
        if not u15[1][p32] then
            u15[1][p32] = {}
        end
        if not u15[2][p32] then
            u15[2][p32] = {}
        end
    end
end
function v1.remove(p34) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u10
        [3] = u11
        [4] = u13
        [5] = u12
        [6] = u9
        [7] = u16
        [8] = u15
    --]]
    if u14[p34] then
        u14[p34] = nil
        u10[p34] = nil
        u11[p34] = nil
        u13[p34] = nil
        u12[p34] = nil
        u9[p34] = nil
        u16[1][p34] = nil
        u16[2][p34] = nil
        u15[1][p34] = nil
        u15[2][p34] = nil
    end
end
function v1.addCallback(p35, p36, p37) --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12[p35][p36] = p37
end
function v1.removeCallback(p38, p39) --[[ Line: 130 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12[p38][p39] = nil
end
function v1.start() --[[ Line: 134 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u11
        [3] = u9
        [4] = u18
        [5] = u8
        [6] = u10
        [7] = u17
        [8] = u16
        [9] = u19
        [10] = u14
        [11] = u13
        [12] = u12
        [13] = u15
        [14] = u5
    --]]
    debug.setmemorycategory("Warp")
    u2.PostSimulation:Connect(function() --[[ Line: 136 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u9
            [3] = u18
            [4] = u8
            [5] = u10
            [6] = u17
            [7] = u16
            [8] = u19
            [9] = u14
            [10] = u13
            [11] = u12
            [12] = u15
            [13] = u5
        --]]
        for v40, v41 in u11 do
            if #v41 ~= 0 then
                if u9[v40](#v41) then
                    for _, v42 in v41 do
                        u18:FireServer(u8.revert(v40), u8.write(v42))
                    end
                end
                u11[v40] = nil
            end
        end
        for v43, v44 in u10 do
            if #v44 > 0 then
                if u9[v43](#v44) then
                    for _, v45 in v44 do
                        u17:FireServer(u8.revert(v43), u8.write(v45))
                    end
                end
                u10[v43] = nil
            end
        end
        for v46, v47 in u16[1] do
            if #v47 ~= 0 then
                u19:FireServer(u8.revert(v46), "\1", v47)
                u16[1][v46] = nil
            end
        end
        for v48, v49 in u16[2] do
            if #v49 ~= 0 then
                u19:FireServer(u8.revert(v48), "\0", v49)
                u16[2][v48] = nil
            end
        end
        for u50 in u14 do
            if u13[u50] then
                for _, v51 in u13[u50] do
                    if v51[3] then
                        if not u16[1][u50] then
                            u16[1][u50] = {}
                        end
                        local v52 = u16[1][u50]
                        local v53 = { v51[1], v51[3] }
                        table.insert(v52, v53)
                        v51[3] = nil
                    end
                end
            end
            local v54 = u12[u50] or nil
            if v54 then
                if u15[1][u50] then
                    for _, v55 in u15[1][u50] do
                        if #v55 ~= 0 then
                            for _, u56 in v54 do
                                for v57 = 1, #v55 do
                                    if v55[v57] then
                                        local u58 = v55[v57][1]
                                        local u59 = v55[v57][2]
                                        u5(function() --[[ Line: 196 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u56
                                                [2] = u59
                                                [3] = u16
                                                [4] = u50
                                                [5] = u58
                                            --]]
                                            local v60 = {}
                                            local v61 = u59
                                            __set_list(v60, 1, {u56(table.unpack(v61))})
                                            if not u16[2][u50] then
                                                u16[2][u50] = {}
                                            end
                                            local v62 = u16[2][u50]
                                            local v63 = { u58, v60 }
                                            table.insert(v62, v63)
                                            u58 = nil
                                            u59 = nil
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    u15[1][u50] = nil
                end
                if u15[2][u50] then
                    if u13[u50] then
                        for _, v64 in u15[2][u50] do
                            for _, v65 in v64 do
                                if #v65 ~= 1 then
                                    for v66 = 1, #u13[u50] do
                                        local v67 = u13[u50][v66]
                                        if v67 and v67[1] == v65[1] then
                                            local v68 = u5
                                            local v69 = v67[2]
                                            local v70 = v65[2]
                                            v68(v69, table.unpack(v70))
                                            table.remove(u13[u50], v66)
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                    u15[2][u50] = nil
                end
            end
        end
    end)
    local function v78(p71, p72, p73) --[[ Line: 233 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u14
            [3] = u12
            [4] = u5
        --]]
        if p71 and (typeof(p71) == "buffer" and (p72 and typeof(p72) == "buffer")) then
            local v74 = u8.convert(p71)
            if u14[v74] then
                local v75 = u8.read(p72, p73)
                if v75 then
                    local v76 = u12[v74]
                    if v76 then
                        for _, v77 in v76 do
                            u5(v77, table.unpack(v75))
                        end
                    end
                else
                    return
                end
            else
                return
            end
        else
            return
        end
    end
    u17.OnClientEvent:Connect(v78)
    u18.OnClientEvent:Connect(v78)
    u19.OnClientEvent:Connect(function(p79, p80, p81) --[[ Line: 247 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u15
        --]]
        if p79 and p81 then
            local v82 = u8.convert(p79)
            if p80 == "\1" then
                if not u15[1][v82] then
                    u15[1][v82] = {}
                end
                local v83 = u15[1][v82]
                table.insert(v83, p81)
            else
                if not u15[2][v82] then
                    u15[2][v82] = {}
                end
                local v84 = u15[2][v82]
                table.insert(v84, p81)
            end
        else
            return
        end
    end)
end
return v1
 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("Players")
local v4 = script.Parent.Parent.Util
require(script.Parent.Parent.Type)
local v5 = require(script.Parent.Parent.Event)
local u6 = require(v4.Spawn)
local u7 = require(v4.Key)
local u8 = require(v4.RateLimit)
local u9 = require(v4.Buffer)
local u10 = {}
local u11 = {}
local u12 = {}
local u13 = {}
local u14 = {}
local u15 = {}
local u16 = {}
local u17 = {}
u16[1] = {}
u16[2] = {}
u17[1] = {}
u17[2] = {}
local u18 = v5.Reliable
local u19 = v5.Unreliable
local u20 = v5.Request
u8.Protect()
local function u23(p21) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u14
        [3] = u13
        [4] = u17
        [5] = u16
    --]]
    if not p21 then
        return
    end
    if not u15[p21] then
        u15[p21] = {}
    end
    for v22 in u14 do
        if not p21 then
            break
        end
        if not u15[p21][v22] then
            u15[p21][v22] = {}
        end
        if not u13[v22] then
            u13[v22] = {}
        end
        if not u13[v22][p21] then
            u13[v22][p21] = {}
        end
        if not u17[1][v22] then
            u17[1][v22] = {}
        end
        if not u17[2][v22] then
            u17[2][v22] = {}
        end
        if not u16[1][v22][p21] then
            u16[1][v22][p21] = {}
            u16[2][v22][p21] = {}
        end
        if not u17[1][v22][p21] then
            u17[1][v22][p21] = {}
            u17[2][v22][p21] = {}
        end
    end
end
u3.PlayerAdded:Connect(u23)
u3.PlayerRemoving:Connect(function(p24) --[[ Line: 88 ]]
    --[[
    Upvalues:
        [1] = u15
        [2] = u10
        [3] = u11
        [4] = u13
        [5] = u16
        [6] = u17
    --]]
    if p24 then
        if u15[p24] then
            u15[p24] = nil
        end
        for _, v25 in { u10, u11, u13 } do
            for v26 in v25 do
                v25[v26][p24] = nil
            end
        end
        for v27 = 1, 2 do
            for v28 in u16[v27] do
                if u16[v27][v28][p24] then
                    u16[v27][v28][p24] = nil
                end
            end
            for v29 in u17[v27] do
                if u17[v27][v29][p24] then
                    u17[v27][v29][p24] = nil
                end
            end
        end
    end
end)
function v1.insertQueue(p30, p31, p32, ...) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u10
    --]]
    if p31 then
        if not u10[p30] then
            u10[p30] = {}
        end
        if not u10[p30][p32] then
            u10[p30][p32] = {}
        end
        local v33 = u10[p30][p32]
        table.insert(v33, { ... })
    else
        if not u11[p30] then
            u11[p30] = {}
        end
        if not u11[p30][p32] then
            u11[p30][p32] = {}
        end
        local v34 = u11[p30][p32]
        table.insert(v34, { ... })
    end
end
function v1.insertRequest(p35, u36, p37, ...) --[[ Line: 132 ]]
    --[[
    Upvalues:
        [1] = u13
        [2] = u7
    --]]
    if not u13[p35] then
        u13[p35] = {}
    end
    if not u13[p35][p37] then
        u13[p35][p37] = {}
    end
    local u38 = coroutine.running()
    local u39 = os.clock()
    local u40 = task.delay(u36, function() --[[ Line: 140 ]]
        --[[
        Upvalues:
            [1] = u38
        --]]
        task.spawn(u38, nil)
    end)
    local v41 = u13[p35][p37]
    local v42 = {}
    local v43 = u7
    __set_list(v42, 1, {tostring(v43()), function(...) --[[ Line: 143 ]]
    --[[
    Upvalues:
        [1] = u39
        [2] = u36
        [3] = u40
        [4] = u38
    --]]
    if u36 >= os.clock() - u39 then
        task.cancel(u40)
        task.spawn(u38, ...)
    end
end, { ... }})
    table.insert(v41, v42)
    return coroutine.yield()
end
function v1.add(p44, p45, p46) --[[ Line: 151 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u8
        [3] = u10
        [4] = u13
        [5] = u12
        [6] = u11
        [7] = u16
        [8] = u17
        [9] = u3
        [10] = u23
    --]]
    if not u14[p44] then
        u14[p44] = true
        u8.create(p45, p46.rateLimit and (p46.rateLimit.maxEntrance or 200) or 200, p46.rateLimit and p46.rateLimit.interval or 2)
        if not u10[p44] then
            u10[p44] = {}
        end
        if not u13[p44] then
            u13[p44] = {}
        end
        if not u12[p44] then
            u12[p44] = {}
        end
        if not u11[p44] then
            u11[p44] = {}
        end
        if not u16[1][p44] then
            u16[1][p44] = {}
        end
        if not u16[2][p44] then
            u16[2][p44] = {}
        end
        if not u17[1][p44] then
            u17[1][p44] = {}
        end
        if not u17[2][p44] then
            u17[2][p44] = {}
        end
        for _, v47 in ipairs(u3:GetPlayers()) do
            task.spawn(u23, v47)
        end
    end
end
function v1.remove(p48) --[[ Line: 189 ]]
    --[[
    Upvalues:
        [1] = u14
        [2] = u10
        [3] = u13
        [4] = u12
        [5] = u11
        [6] = u16
        [7] = u17
    --]]
    if u14[p48] then
        u14[p48] = nil
        u10[p48] = nil
        u13[p48] = nil
        u12[p48] = nil
        u11[p48] = nil
        u16[1][p48] = nil
        u16[2][p48] = nil
        u17[1][p48] = nil
        u17[2][p48] = nil
    end
end
function v1.addCallback(p49, p50, p51) --[[ Line: 202 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12[p49][p50] = p51
end
function v1.removeCallback(p52, p53) --[[ Line: 206 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    u12[p52][p53] = nil
end
function v1.start() --[[ Line: 210 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u11
        [3] = u19
        [4] = u9
        [5] = u10
        [6] = u15
        [7] = u18
        [8] = u17
        [9] = u20
        [10] = u14
        [11] = u13
        [12] = u12
        [13] = u16
        [14] = u6
    --]]
    debug.setmemorycategory("Warp")
    u2.PostSimulation:Connect(function() --[[ Line: 212 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u19
            [3] = u9
            [4] = u10
            [5] = u15
            [6] = u18
            [7] = u17
            [8] = u20
            [9] = u14
            [10] = u13
            [11] = u12
            [12] = u16
            [13] = u6
        --]]
        for v54, v55 in u11 do
            for v56, v57 in v55 do
                if #v57 ~= 0 then
                    for _, v58 in v57 do
                        u19:FireClient(v56, u9.revert(v54), u9.write(v58))
                    end
                    u11[v54][v56] = nil
                end
            end
            u11[v54] = nil
        end
        for v59, v60 in u10 do
            for v61, v62 in v60 do
                if #v62 > 0 and u15[v61] then
                    for _, v63 in v62 do
                        u18:FireClient(v61, u9.revert(v59), u9.write(v63))
                    end
                end
                u10[v59][v61] = nil
            end
            u10[v59] = nil
        end
        for v64, v65 in u17[1] do
            for v66, v67 in v65 do
                if #v67 > 0 then
                    u20:FireClient(v66, u9.revert(v64), "\1", v67)
                end
                u17[1][v64][v66] = nil
            end
            u17[1][v64] = nil
        end
        for v68, v69 in u17[2] do
            for v70, v71 in v69 do
                if #v71 > 0 then
                    u20:FireClient(v70, u9.revert(v68), "\0", v71)
                end
                u17[2][v68][v70] = nil
            end
            u17[2][v68] = nil
        end
        for u72 in u14 do
            if u13[u72] then
                for v73, v74 in u13[u72] do
                    if #v74 == 0 then
                        u13[u72][v73] = nil
                    else
                        for _, v75 in v74 do
                            if v75[3] then
                                if not u17[1][u72] then
                                    u17[1][u72] = {}
                                end
                                if not u17[1][u72][v73] then
                                    u17[1][u72][v73] = {}
                                end
                                local v76 = u17[1][u72][v73]
                                local v77 = { v75[1], v75[3] }
                                table.insert(v76, v77)
                                v75[3] = nil
                            end
                        end
                    end
                end
            end
            local v78 = u12[u72] or nil
            if v78 then
                for u79, v80 in u16[1][u72] do
                    if not v78 then
                        break
                    end
                    for _, v81 in v80 do
                        if not v78 then
                            break
                        end
                        if #v81 ~= 0 then
                            for _, u82 in v78 do
                                for v83 = 1, #v81 do
                                    if v81[v83] then
                                        local u84 = v81[v83][1]
                                        local u85 = v81[v83][2]
                                        u6(function() --[[ Line: 289 ]]
                                            --[[
                                            Upvalues:
                                                [1] = u82
                                                [2] = u79
                                                [3] = u85
                                                [4] = u17
                                                [5] = u72
                                                [6] = u84
                                            --]]
                                            local v86 = {}
                                            local v87 = u85
                                            __set_list(v86, 1, {u82(u79, table.unpack(v87))})
                                            if not u17[2][u72] then
                                                u17[2][u72] = {}
                                            end
                                            if not u17[2][u72][u79] then
                                                u17[2][u72][u79] = {}
                                            end
                                            local v88 = u17[2][u72][u79]
                                            local v89 = { u84, v86 }
                                            table.insert(v88, v89)
                                            u84 = nil
                                            u85 = nil
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    u16[1][u72][u79] = nil
                end
                for v90, v91 in u16[2][u72] do
                    if not v78 then
                        break
                    end
                    for _, v92 in v91 do
                        for _, v93 in v92 do
                            if not v78 then
                                break
                            end
                            if #v93 ~= 1 then
                                local v94 = u13[u72][v90]
                                for v95 = 1, #v94 do
                                    local v96 = v94[v95]
                                    if v96 and v96[1] == v93[1] then
                                        local v97 = u6
                                        local v98 = v96[2]
                                        local v99 = v93[2]
                                        v97(v98, table.unpack(v99))
                                        table.remove(v94, v95)
                                        break
                                    end
                                end
                            end
                        end
                    end
                    u16[2][u72][v90] = nil
                end
            end
        end
    end)
    local function v108(p100, p101, p102, p103) --[[ Line: 330 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u14
            [3] = u12
            [4] = u6
        --]]
        if p101 and (typeof(p101) == "buffer" and (p102 and typeof(p102) == "buffer")) then
            local v104 = u9.convert(p101)
            if u14[v104] then
                local v105 = u9.read(p102, p103)
                if v105 then
                    local v106 = u12[v104]
                    if v106 then
                        for _, v107 in v106 do
                            u6(v107, p100, table.unpack(v105))
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
    u18.OnServerEvent:Connect(v108)
    u19.OnServerEvent:Connect(v108)
    u20.OnServerEvent:Connect(function(p109, p110, p111, p112) --[[ Line: 344 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u16
            [3] = u10
        --]]
        if p110 and p112 then
            local v113 = u9.convert(p110)
            if not u16[1][v113][p109] then
                u16[1][v113][p109] = {}
            end
            if not u16[2][v113][p109] then
                u16[2][v113][p109] = {}
            end
            if not u10[v113] then
                u10[v113] = {}
            end
            if not u10[v113][p109] then
                u10[v113][p109] = {}
            end
            if p111 == "\1" then
                local v114 = u16[1][v113][p109]
                table.insert(v114, p112)
            else
                local v115 = u16[2][v113][p109]
                table.insert(v115, p112)
            end
        else
            return
        end
    end)
end
for _, v116 in ipairs(u3:GetPlayers()) do
    task.spawn(u23, v116)
end
return v1
 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Maid")
local u3 = v1("Brio")
local u56 = {
    ["clone"] = function(p4) --[[ Name: clone, Line 20 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        assert(p4, "Bad brio")
        if p4:IsDead() then
            return u3.DEAD
        end
        local u5 = u3.new(p4:GetValue())
        u5:ToMaid():GiveTask(p4:GetDiedSignal():Connect(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u5
            --]]
            u5:Kill()
        end))
        return u5
    end,
    ["aliveOnly"] = function(p6) --[[ Name: aliveOnly, Line 42 ]]
        local v7 = {}
        for _, v8 in pairs(p6) do
            if not v8:IsDead() then
                table.insert(v7, v8)
            end
        end
        return v7
    end,
    ["firstAlive"] = function(p9) --[[ Name: firstAlive, Line 58 ]]
        for _, v10 in pairs(p9) do
            if not v10:IsDead() then
                return v10
            end
        end
        return nil
    end,
    ["flatten"] = function(p11) --[[ Name: flatten, Line 74 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u56
        --]]
        local v12 = {}
        local v13 = {}
        for v14, v15 in pairs(p11) do
            if u3.isBrio(v15) then
                if v15:IsDead() then
                    return u3.DEAD
                end
                table.insert(v12, v15)
                v13[v14] = v15:GetValue()
            else
                v13[v14] = v15
            end
        end
        return u56.first(v12, v13)
    end,
    ["first"] = function(p16, ...) --[[ Name: first, Line 102 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        for _, v17 in pairs(p16) do
            if u3.isBrio(v17) and v17:IsDead() then
                return u3.DEAD
            end
        end
        local u18 = u2.new()
        local u19 = u3.new(...)
        for _, v20 in pairs(p16) do
            if u3.isBrio(v20) then
                u18:GiveTask(v20:GetDiedSignal():Connect(function() --[[ Line: 116 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                    --]]
                    u19:Kill()
                end))
            end
        end
        u18:GiveTask(u19:GetDiedSignal():Connect(function() --[[ Line: 122 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18:DoCleaning()
        end))
        return u19
    end,
    ["withOtherValues"] = function(p21, ...) --[[ Name: withOtherValues, Line 138 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        assert(p21, "Bad brio")
        if p21:IsDead() then
            return u3.DEAD
        end
        local u22 = u3.new(...)
        u22:ToMaid():GiveTask(p21:GetDiedSignal():Connect(function() --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u22
            --]]
            u22:Kill()
        end))
        return u22
    end,
    ["extend"] = function(p23, ...) --[[ Name: extend, Line 162 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        if p23:IsDead() then
            return u3.DEAD
        end
        local v24 = p23._values
        local v25 = {}
        for v26 = 1, v24.n do
            v25[v26] = v24[v26]
        end
        local v27 = table.pack(...)
        for v28 = 1, v27.n do
            v25[v24.n + v28] = v27[v28]
        end
        local u29 = u2.new()
        local v30 = u3.new
        local v31 = v24.n + v27.n
        local u32 = v30(unpack(v25, 1, v31))
        u29:GiveTask(p23:GetDiedSignal():Connect(function() --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u32
            --]]
            u32:Kill()
        end))
        u29:GiveTask(u32:GetDiedSignal():Connect(function() --[[ Line: 184 ]]
            --[[
            Upvalues:
                [1] = u29
            --]]
            u29:DoCleaning()
        end))
        return u32
    end,
    ["prepend"] = function(p33, ...) --[[ Name: prepend, Line 200 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        if p33:IsDead() then
            return u3.DEAD
        end
        local v34 = p33._values
        local v35 = table.pack(...)
        local v36 = {}
        for v37 = 1, v35.n do
            v36[v37] = v35[v37]
        end
        for v38 = 1, v34.n do
            v36[v35.n + v38] = v34[v38]
        end
        local u39 = u2.new()
        local v40 = u3.new
        local v41 = v34.n + v35.n
        local u42 = v40(unpack(v36, 1, v41))
        u39:GiveTask(p33:GetDiedSignal():Connect(function() --[[ Line: 218 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            u42:Kill()
        end))
        u39:GiveTask(u42:GetDiedSignal():Connect(function() --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u39
            --]]
            u39:DoCleaning()
        end))
        return u42
    end,
    ["merge"] = function(p43, p44) --[[ Name: merge, Line 236 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v45 = u3.isBrio(p43)
        assert(v45, "Not a brio")
        local v46 = u3.isBrio(p44)
        assert(v46, "Not a brio")
        if p43:IsDead() or p44:IsDead() then
            return u3.DEAD
        end
        local v47 = p43._values
        local v48 = {}
        for v49 = 1, v47.n do
            v48[v49] = v47[v49]
        end
        local v50 = p44._values
        for v51 = 1, v50.n do
            v48[v47.n + v51] = v50[v51]
        end
        local u52 = u2.new()
        local v53 = u3.new
        local v54 = v47.n + v50.n
        local u55 = v53(unpack(v48, 1, v54))
        u52:GiveTask(p43:GetDiedSignal():Connect(function() --[[ Line: 258 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            u55:Kill()
        end))
        u52:GiveTask(p44:GetDiedSignal():Connect(function() --[[ Line: 261 ]]
            --[[
            Upvalues:
                [1] = u55
            --]]
            u55:Kill()
        end))
        u52:GiveTask(u55:GetDiedSignal():Connect(function() --[[ Line: 265 ]]
            --[[
            Upvalues:
                [1] = u52
            --]]
            u52:DoCleaning()
        end))
        return u55
    end
}
return u56
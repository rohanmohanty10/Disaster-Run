 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Signal")
local u3 = v1("Maid")
local u4 = v1("Observable")
local u24 = {
    ["ClassName"] = "ValueObject",
    ["new"] = function(p5) --[[ Name: new, Line 21 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u24
        --]]
        local v6 = {}
        rawset(v6, "_value", p5)
        v6._maid = u3.new()
        v6.Changed = u2.new()
        v6._maid:GiveTask(v6.Changed)
        local v7 = u24
        return setmetatable(v6, v7)
    end,
    ["fromObservable"] = function(p8) --[[ Name: fromObservable, Line 44 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        local u9 = u24.new()
        u9._maid:GiveTask(p8:Subscribe(function(p10) --[[ Line: 47 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            u9.Value = p10
        end))
        return u9
    end,
    ["isValueObject"] = function(p11) --[[ Name: isValueObject, Line 59 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        local v12
        if type(p11) == "table" then
            v12 = getmetatable(p11) == u24
        else
            v12 = false
        end
        return v12
    end,
    ["Observe"] = function(u13) --[[ Name: Observe, Line 67 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        return u4.new(function(u14) --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u3
            --]]
            if u13.Destroy then
                local v15 = u3.new()
                v15:GiveTask(u13.Changed:Connect(function() --[[ Line: 78 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u13
                    --]]
                    u14:Fire(u13.Value)
                end))
                u14:Fire(u13.Value)
                return v15
            end
            warn("[ValueObject.observeValue] - Connecting to dead ValueObject")
            u14:Complete()
        end)
    end,
    ["__index"] = function(p16, p17) --[[ Name: __index, Line 94 ]]
        --[[
        Upvalues:
            [1] = u24
        --]]
        if p17 == "Value" then
            return p16._value
        end
        if u24[p17] then
            return u24[p17]
        end
        if p17 == "_value" then
            return nil
        end
        error(("%q is not a member of ValueObject"):format((tostring(p17))))
    end,
    ["__newindex"] = function(p18, p19, p20) --[[ Name: __newindex, Line 106 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        if p19 == "Value" then
            local v21 = rawget(p18, "_value")
            if v21 ~= p20 then
                rawset(p18, "_value", p20)
                local v22 = u3.new()
                p18.Changed:Fire(p20, v21, v22)
                p18._maid._valueMaid = v22
                return
            end
        else
            error(("%q is not a member of ValueObject"):format((tostring(p19))))
        end
    end,
    ["Destroy"] = function(p23) --[[ Name: Destroy, Line 128 ]]
        rawset(p23, "_value", nil)
        p23._maid:DoCleaning()
        setmetatable(p23, nil)
    end
}
return u24
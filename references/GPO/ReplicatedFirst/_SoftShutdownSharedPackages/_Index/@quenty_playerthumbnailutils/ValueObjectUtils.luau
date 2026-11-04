 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Maid")
local u3 = v1("Brio")
local u4 = v1("Observable")
local u5 = v1("ValueObject")
return {
    ["syncValue"] = function(u6, u7) --[[ Name: syncValue, Line 21 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v8 = u2.new()
        u7.Value = u6.Value
        v8:GiveTask(u6.Changed:Connect(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u6
            --]]
            u7.Value = u6.Value
        end))
        return v8
    end,
    ["observeValue"] = function(u9) --[[ Name: observeValue, Line 37 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u4
            [3] = u2
        --]]
        local v10 = u5.isValueObject(u9)
        assert(v10, "Bad valueObject")
        return u4.new(function(u11) --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u2
            --]]
            if u9.Destroy then
                local v12 = u2.new()
                v12:GiveTask(u9.Changed:Connect(function() --[[ Line: 50 ]]
                    --[[
                    Upvalues:
                        [1] = u11
                        [2] = u9
                    --]]
                    u11:Fire(u9.Value)
                end))
                u11:Fire(u9.Value)
                return v12
            end
            warn("[ValueObjectUtils.observeValue] - Connecting to dead ValueObject")
            u11:Complete()
        end)
    end,
    ["observeValueBrio"] = function(u13) --[[ Name: observeValueBrio, Line 65 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u3
        --]]
        assert(u13, "Bad valueObject")
        return u4.new(function(u14) --[[ Line: 68 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
                [3] = u13
            --]]
            local u15 = u2.new()
            local function v17() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u13
                    [3] = u15
                    [4] = u14
                --]]
                local v16 = u3.new(u13.Value)
                u15._lastBrio = v16
                u14:Fire(v16)
            end
            u15:GiveTask(u13.Changed:Connect(v17))
            local v18 = u3.new(u13.Value)
            u15._lastBrio = v18
            u14:Fire(v18)
            return u15
        end)
    end
}
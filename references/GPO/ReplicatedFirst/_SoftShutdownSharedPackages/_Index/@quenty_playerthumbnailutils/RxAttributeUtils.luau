 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Observable")
local u3 = v1("Maid")
return {
    ["observeAttribute"] = function(u4, u5, u6) --[[ Name: observeAttribute, Line 20 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local v7 = typeof(u4) == "Instance"
        assert(v7, "Bad instance")
        local v8 = type(u5) == "string"
        assert(v8, "Bad attributeName")
        return u2.new(function(u9) --[[ Line: 24 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
                [3] = u5
                [4] = u6
            --]]
            local v10 = u3.new()
            local function v12() --[[ Line: 27 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u5
                    [3] = u9
                    [4] = u6
                --]]
                local v11 = u4:GetAttribute(u5)
                if v11 == nil then
                    u9:Fire(u6)
                else
                    u9:Fire(v11)
                end
            end
            v10:GiveTask(u4:GetAttributeChangedSignal(u5):Connect(v12))
            local v13 = u4:GetAttribute(u5)
            if v13 == nil then
                u9:Fire(u6)
                return v10
            else
                u9:Fire(v13)
                return v10
            end
        end)
    end
}
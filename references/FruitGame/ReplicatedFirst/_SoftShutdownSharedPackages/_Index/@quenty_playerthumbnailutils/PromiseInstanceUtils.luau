 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Promise")
local u3 = v1("Maid")
return {
    ["promiseRemoved"] = function(p4) --[[ Name: promiseRemoved, Line 16 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v5 = game
        assert(p4:IsDescendantOf(v5))
        local u6 = u3.new()
        local u7 = u2.new()
        u6:GiveTask(p4.AncestryChanged:Connect(function(_, p8) --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            if not p8 then
                u7:Resolve()
            end
        end))
        u7:Finally(function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            u6:DoCleaning()
        end)
        return u7
    end
}
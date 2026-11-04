 

local v1 = require(script.Parent.loader).load(script)
local u2 = v1("Observable")
local u3 = v1("Maid")
local u4 = v1("Rx")
local u5 = v1("BasicPane")
local u17 = {
    ["observeVisible"] = function(u6) --[[ Name: observeVisible, Line 19 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u3
        --]]
        local v7 = u5.isBasicPane(u6)
        assert(v7, "Bad BasicPane")
        return u2.new(function(u8) --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u6
            --]]
            local v9 = u3.new()
            v9:GiveTask(u6.VisibleChanged:Connect(function(p10) --[[ Line: 25 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8:Fire(p10)
            end))
            u8:Fire(u6:IsVisible())
            return v9
        end)
    end,
    ["observePercentVisible"] = function(p11) --[[ Name: observePercentVisible, Line 39 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u17
            [3] = u4
        --]]
        local v12 = u5.isBasicPane(p11)
        assert(v12, "Bad BasicPane")
        return u17.observeVisible(p11):Pipe({ u4.map(function(p13) --[[ Line: 43 ]]
                return p13 and 1 or 0
            end), u4.startWith({ 0 }) })
    end,
    ["toTransparency"] = u4.map(function(p14) --[[ Line: 58 ]]
        return 1 - p14
    end),
    ["observeShow"] = function(p15) --[[ Name: observeShow, Line 67 ]]
        --[[
        Upvalues:
            [1] = u17
            [2] = u4
        --]]
        return u17.observeVisible(p15):Pipe({ u4.where(function(p16) --[[ Line: 69 ]]
                return p16
            end) })
    end
}
return u17
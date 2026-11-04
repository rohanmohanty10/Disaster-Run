 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.getDefaultInstanceProperty)
    it("should get default name string values", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _, v2 = u1("StringValue", "Name")
        expect(v2).to.equal("Value")
    end)
    it("should get default empty string values", function() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _, v3 = u1("StringValue", "Value")
        expect(v3).to.equal("")
    end)
    it("should get default number values", function() --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _, v4 = u1("IntValue", "Value")
        expect(v4).to.equal(0)
    end)
    it("should get nil default values", function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _, v5 = u1("ObjectValue", "Value")
        expect(v5).to.equal(nil)
    end)
    it("should get bool default values", function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local _, v6 = u1("BoolValue", "Value")
        expect(v6).to.equal(false)
    end)
end
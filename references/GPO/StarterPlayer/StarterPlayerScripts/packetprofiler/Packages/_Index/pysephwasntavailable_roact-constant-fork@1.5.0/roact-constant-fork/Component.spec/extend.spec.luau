 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.Type)
    local u2 = require(script.Parent.Parent.Component)
    it("should be extendable", function() --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v3 = u2:extend("The Senate")
        expect(v3).to.be.ok()
        expect(u1.of(v3)).to.equal(u1.StatefulComponentClass)
    end)
    it("should prevent extending a user component", function() --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local u4 = u2:extend("Sheev")
        expect(function() --[[ Line: 16 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            u4:extend("Frank")
        end).to.throw()
    end)
    it("should use a given name", function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v5 = u2:extend("FooBar")
        local v6 = tostring(v5)
        expect(v6).to.be.a("string")
        expect(v6:find("FooBar")).to.be.ok()
    end)
end
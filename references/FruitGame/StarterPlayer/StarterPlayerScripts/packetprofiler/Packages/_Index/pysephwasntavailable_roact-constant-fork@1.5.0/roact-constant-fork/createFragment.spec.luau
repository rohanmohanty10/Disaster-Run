 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.ElementKind)
    local u2 = require(script.Parent.Type)
    local u3 = require(script.Parent.createFragment)
    it("should create new primitive elements", function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        local v4 = u3({})
        expect(v4).to.be.ok()
        expect(u2.of(v4)).to.equal(u2.Element)
        expect(u1.of(v4)).to.equal(u1.Fragment)
    end)
    it("should accept children", function() --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        local v5 = u3({})
        local v6 = u3({
            ["key"] = v5
        })
        expect(v6.elements.key).to.equal(v5)
    end)
end
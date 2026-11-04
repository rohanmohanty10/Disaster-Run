 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Binding)
    local u2 = require(script.Parent.Type)
    local u3 = require(script.Parent.createRef)
    it("should create refs, which are specialized bindings", function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
        --]]
        local v4 = u3()
        expect(u2.of(v4)).to.equal(u2.Binding)
        expect(v4.current).to.equal(nil)
    end)
    it("should have a \'current\' field that is the same as the internal binding\'s value", function() --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v5 = u3()
        expect(v5.current).to.equal(nil)
        u1.update(v5, 10)
        expect(v5.current).to.equal(10)
    end)
    it("should support tostring on refs", function() --[[ Line: 23 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v6 = u3()
        expect(v6.current).to.equal(nil)
        expect((tostring(v6))).to.equal("RoactRef(nil)")
        u1.update(v6, 10)
        expect((tostring(v6))).to.equal("RoactRef(10)")
    end)
    it("should not allow assignments to the \'current\' field", function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local u7 = u3()
        expect(u7.current).to.equal(nil)
        u1.update(u7, 99)
        expect(u7.current).to.equal(99)
        expect(function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7.current = 77
        end).to.throw()
        expect(u7.current).to.equal(99)
    end)
    it("should return the same thing from getValue as its current field", function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
        --]]
        local v8 = u3()
        u1.update(v8, 10)
        expect(v8:getValue()).to.equal(10)
        expect(v8:getValue()).to.equal(v8.current)
    end)
end
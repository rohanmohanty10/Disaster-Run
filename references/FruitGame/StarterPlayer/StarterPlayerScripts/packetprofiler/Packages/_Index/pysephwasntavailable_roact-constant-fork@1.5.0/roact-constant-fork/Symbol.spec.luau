 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Symbol)
    describe("named", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should give an opaque object", function() --[[ Line: 5 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v2 = u1.named("foo")
            expect(v2).to.be.a("userdata")
        end)
        it("should coerce to the given name", function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v3 = u1.named("foo")
            local v4 = tostring(v3):find("foo")
            expect(v4).to.be.ok()
        end)
        it("should be unique when constructed", function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v5 = u1.named("abc")
            local v6 = u1.named("abc")
            expect(v5).never.to.equal(v6)
        end)
    end)
end
 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Type)
    describe("of", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should return nil if the value is not a table", function() --[[ Line: 5 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            expect(u1.of(1)).to.equal(nil)
            expect(u1.of(true)).to.equal(nil)
            expect(u1.of("test")).to.equal(nil)
            expect(u1.of(print)).to.equal(nil)
        end)
        it("should return nil if the table has no type", function() --[[ Line: 12 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            expect(u1.of({})).to.equal(nil)
        end)
        it("should return the assigned type", function() --[[ Line: 16 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v2 = {
                [u1] = u1.Element
            }
            expect(u1.of(v2)).to.equal(u1.Element)
        end)
    end)
end
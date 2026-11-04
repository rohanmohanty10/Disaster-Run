 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Portal)
    local u2 = require(script.Parent.Component)
    local u3 = require(script.Parent.ElementKind)
    describe("of", function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        it("should return nil for non-table values", function() --[[ Line: 8 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            expect(u3.of(nil)).to.equal(nil)
            expect(u3.of(5)).to.equal(nil)
            expect(u3.of(newproxy(true))).to.equal(nil)
        end)
        it("should return nil for table values without an ElementKind key", function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            expect(u3.of({})).to.equal(nil)
        end)
        it("should return the ElementKind from a table", function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            local v4 = {
                [u3] = u3.Stateful
            }
            expect(u3.of(v4)).to.equal(u3.Stateful)
        end)
    end)
    describe("fromComponent", function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u1
        --]]
        it("should handle host components", function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            expect(u3.fromComponent("foo")).to.equal(u3.Host)
        end)
        it("should handle function components", function() --[[ Line: 32 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            expect(u3.fromComponent(function() --[[ Name: foo, Line 33 ]] end)).to.equal(u3.Function)
        end)
        it("should handle stateful components", function() --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            local v5 = u2:extend("Foo")
            expect(u3.fromComponent(v5)).to.equal(u3.Stateful)
        end)
        it("should handle portals", function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u1
            --]]
            expect(u3.fromComponent(u1)).to.equal(u3.Portal)
        end)
        it("should return nil for invalid inputs", function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            expect(u3.fromComponent(5)).to.equal(nil)
            expect(u3.fromComponent(newproxy(true))).to.equal(nil)
        end)
    end)
end
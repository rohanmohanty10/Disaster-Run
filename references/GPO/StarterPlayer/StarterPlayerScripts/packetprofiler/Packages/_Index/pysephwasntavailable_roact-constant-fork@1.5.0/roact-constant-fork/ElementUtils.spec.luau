 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.ElementUtils)
    local u2 = require(script.Parent.createElement)
    local u3 = require(script.Parent.createFragment)
    local u4 = require(script.Parent.Type)
    describe("iterateElements", function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u4
        --]]
        it("should iterate once for a single child", function() --[[ Line: 8 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v5 = u2("TextLabel")
            local v6 = u1.iterateElements(v5)
            local v7, v8 = v6()
            expect(v7).to.equal(u1.UseParentKey)
            expect(v8).to.equal(v5)
            local v9 = v6()
            expect(v9).to.equal(nil)
        end)
        it("should iterate over tables", function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
                [3] = u4
            --]]
            local v10 = {
                ["a"] = u2("TextLabel"),
                ["b"] = u2("TextLabel")
            }
            local v11 = {}
            local v12 = 0
            for v13, v14 in u1.iterateElements(v10) do
                expect((typeof(v13))).to.equal("string")
                expect(u4.of(v14)).to.equal(u4.Element)
                v11[v14] = v13
                v12 = v12 + 1
            end
            expect(v12).to.equal(2)
            expect(v11[v10.a]).to.equal("a")
            expect(v11[v10.b]).to.equal("b")
        end)
        it("should return a zero-element iterator for booleans", function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v15 = u1.iterateElements(false)
            expect(v15()).to.equal(nil)
        end)
        it("should return a zero-element iterator for nil", function() --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v16 = u1.iterateElements(nil)
            expect(v16()).to.equal(nil)
        end)
        it("should throw if given an illegal value", function() --[[ Line: 51 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            expect(function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u1
                --]]
                u1.iterateElements(1)
            end).to.throw()
        end)
    end)
    describe("getElementByKey", function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
            [3] = u3
        --]]
        it("should return nil for booleans", function() --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            expect(u1.getElementByKey(true, "test")).to.equal(nil)
        end)
        it("should return nil for nil", function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            expect(u1.getElementByKey(nil, "test")).to.equal(nil)
        end)
        describe("single elements", function() --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local u17 = u2("TextLabel")
            it("should return the element if the key is UseParentKey", function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u17
                --]]
                expect(u1.getElementByKey(u17, u1.UseParentKey)).to.equal(u17)
            end)
            it("should return nil if the key is not UseParentKey", function() --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u17
                --]]
                expect(u1.getElementByKey(u17, "test")).to.equal(nil)
            end)
        end)
        it("should return the corresponding element from a table", function() --[[ Line: 79 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            local v18 = {
                ["a"] = u2("TextLabel"),
                ["b"] = u2("TextLabel")
            }
            expect(u1.getElementByKey(v18, "a")).to.equal(v18.a)
            expect(u1.getElementByKey(v18, "b")).to.equal(v18.b)
        end)
        it("should return nil if the key does not exist", function() --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u1
            --]]
            local v19 = u3({})
            expect(u1.getElementByKey(v19, "a")).to.equal(nil)
        end)
    end)
end
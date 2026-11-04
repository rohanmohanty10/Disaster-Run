 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createSpy)
    describe("createSpy", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should create spies", function() --[[ Line: 5 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v2 = u1(function() --[[ Line: 6 ]] end)
            expect(v2).to.be.ok()
        end)
        it("should throw if spies are indexed by an invalid key", function() --[[ Line: 11 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u3 = u1(function() --[[ Line: 12 ]] end)
            expect(function() --[[ Line: 14 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                return u3.test
            end).to.throw()
        end)
    end)
    describe("value", function() --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should increment callCount when called", function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v4 = u1(function() --[[ Line: 22 ]] end)
            v4.value()
            expect(v4.callCount).to.equal(1)
        end)
        it("should store all values passed", function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v5 = u1(function() --[[ Line: 29 ]] end)
            v5.value(1, true, "3")
            expect(v5.valuesLength).to.equal(3)
            expect(v5.values[1]).to.equal(1)
            expect(v5.values[2]).to.equal(true)
            expect(v5.values[3]).to.equal("3")
        end)
        it("should return the value of the inner function", function() --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v6 = u1(function() --[[ Line: 39 ]]
                return true
            end)
            expect(v6.value()).to.equal(true)
        end)
    end)
    describe("assertCalledWith", function() --[[ Line: 47 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should throw if the number of values differs", function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u7 = u1(function() --[[ Line: 49 ]] end)
            u7.value(1, 2)
            expect(function() --[[ Line: 52 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                u7:assertCalledWith(1)
            end).to.throw()
        end)
        it("should throw if any value differs", function() --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u8 = u1(function() --[[ Line: 58 ]] end)
            u8.value(1, 2)
            expect(function() --[[ Line: 61 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8:assertCalledWith(1, 3)
            end).to.throw()
            expect(function() --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                u8:assertCalledWith(2, 3)
            end).to.throw()
        end)
    end)
    describe("captureValues", function() --[[ Line: 71 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        it("should throw if the number of values differs", function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local u9 = u1(function() --[[ Line: 73 ]] end)
            u9.value(1, 2)
            expect(function() --[[ Line: 76 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9:captureValues("a")
            end).to.throw()
        end)
        it("should capture all values in a table", function() --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u1
            --]]
            local v10 = u1(function() --[[ Line: 82 ]] end)
            v10.value(1, 2)
            local v11 = v10:captureValues("a", "b")
            expect(v11.a).to.equal(1)
            expect(v11.b).to.equal(2)
        end)
    end)
end
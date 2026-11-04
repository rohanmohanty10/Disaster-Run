 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = v1("BrioUtils")
local u3 = v1("Brio")
return function() --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    describe("BrioUtils.flatten({})", function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local u4 = u2.flatten({})
        describe("should return a brio that", function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
            --]]
            it("is a brio", function() --[[ Line: 15 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u3
                --]]
                expect(u4).to.be.a("table")
                expect(u3.isBrio(u4)).to.equal(true)
            end)
            it("is alive", function() --[[ Line: 20 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                expect(not u4:IsDead()).to.equal(true)
            end)
            it("contains a table", function() --[[ Line: 24 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                expect(u4:GetValue()).to.be.a("table")
            end)
            it("contains a table with nothing in it", function() --[[ Line: 28 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                expect(next(u4:GetValue())).to.equal(nil)
            end)
        end)
    end)
    describe("BrioUtils.flatten with out a brio in it", function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local u5 = u2.flatten({
            ["value"] = 5
        })
        describe("should return a brio that", function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u3
            --]]
            it("is a brio", function() --[[ Line: 40 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u3
                --]]
                expect(u5).to.be.a("table")
                expect(u3.isBrio(u5)).to.equal(true)
            end)
            it("is alive", function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                expect(not u5:IsDead()).to.equal(true)
            end)
            it("contains a table", function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                expect(u5:GetValue()).to.be.a("table")
            end)
            it("contains a table with value", function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                expect(u5:GetValue().value).to.equal(5)
            end)
        end)
    end)
    describe("BrioUtils.flatten a dead brio in it", function() --[[ Line: 59 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        local u6 = u2.flatten({
            ["value"] = u3.DEAD
        })
        describe("should return a brio that", function() --[[ Line: 64 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
            --]]
            it("is a brio", function() --[[ Line: 65 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u3
                --]]
                expect(u6).to.be.a("table")
                expect(u3.isBrio(u6)).to.equal(true)
            end)
            it("is dead", function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                expect(u6:IsDead()).to.equal(true)
            end)
        end)
    end)
end
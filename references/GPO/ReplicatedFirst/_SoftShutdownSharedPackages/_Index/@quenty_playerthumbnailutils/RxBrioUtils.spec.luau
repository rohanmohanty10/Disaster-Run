 

local v1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)
local u2 = v1("RxBrioUtils")
local u3 = v1("Brio")
local u4 = v1("Observable")
return function() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    describe("RxBrioUtils.combineLatest({})", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
        --]]
        it("should execute immediately", function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            local v5 = u2.combineLatest({})
            local u6 = nil
            local v8 = v5:Subscribe(function(p7) --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                u6 = p7
            end)
            expect(u6).to.be.ok()
            expect(u3.isBrio(u6)).to.equal(true)
            expect(u6:IsDead()).to.equal(true)
            v8:Destroy()
        end)
    end)
    describe("RxBrioUtils.combineLatest({ value = Observable(Brio(5)) })", function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u4
            [3] = u3
        --]]
        it("should execute immediately", function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
                [3] = u3
            --]]
            local v10 = u2.combineLatest({
                ["value"] = u4.new(function(p9) --[[ Line: 30 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                    --]]
                    p9:Fire(u3.new(5))
                end),
                ["otherValue"] = 25
            })
            local u11 = nil
            local v13 = v10:Subscribe(function(p12) --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u11
                --]]
                u11 = p12
            end)
            expect(u11).to.be.ok()
            expect(u3.isBrio(u11)).to.equal(true)
            expect(not u11:IsDead()).to.equal(true)
            expect(u11:GetValue()).to.be.a("table")
            expect(u11:GetValue().value).to.equal(5)
            v13:Destroy()
        end)
    end)
    describe("RxBrioUtils.flatCombineLatest", function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u4
        --]]
        local u14 = nil
        local u15 = u3.new(5)
        local u17 = u2.flatCombineLatest({
            ["value"] = u4.new(function(u16) --[[ Line: 54 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u14
                --]]
                u16:Fire(u15)
                u14 = function(...) --[[ Line: 56 ]]
                    --[[
                    Upvalues:
                        [1] = u16
                    --]]
                    u16:Fire(...)
                end
            end),
            ["otherValue"] = 25
        })
        local u18 = nil
        local u19 = 0
        it("should execute immediately", function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u17
                [2] = u18
                [3] = u19
                [4] = u3
            --]]
            local v21 = u17:Subscribe(function(p20) --[[ Line: 67 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u19
                --]]
                u18 = p20
                u19 = u19 + 1
            end)
            expect(u19).to.equal(1)
            expect(u18).to.be.a("table")
            expect(u3.isBrio(u18)).to.equal(false)
            expect(u18.value).to.equal(5)
            expect(u18.otherValue).to.equal(25)
            v21:Destroy()
        end)
        it("should reset when the brio is killed", function() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u15
                [3] = u18
                [4] = u3
            --]]
            expect(u19).to.equal(1)
            u15:Kill()
            expect(u19).to.equal(2)
            expect(u18).to.be.a("table")
            expect(u3.isBrio(u18)).to.equal(false)
            expect(u18.value).to.equal(nil)
            expect(u18.otherValue).to.equal(25)
        end)
        it("should allow a new value", function() --[[ Line: 92 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u14
                [3] = u3
                [4] = u18
            --]]
            expect(u19).to.equal(2)
            u14(u3.new(70))
            expect(u19).to.equal(3)
            expect(u18).to.be.a("table")
            expect(u3.isBrio(u18)).to.equal(false)
            expect(u18.value).to.equal(70)
            expect(u18.otherValue).to.equal(25)
        end)
        it("should only fire once if we replace the value", function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u14
                [3] = u3
                [4] = u18
            --]]
            expect(u19).to.equal(3)
            u14(u3.new(75))
            expect(u19).to.equal(4)
            expect(u18).to.be.a("table")
            expect(u3.isBrio(u18)).to.equal(false)
            expect(u18.value).to.equal(75)
            expect(u18.otherValue).to.equal(25)
        end)
    end)
end
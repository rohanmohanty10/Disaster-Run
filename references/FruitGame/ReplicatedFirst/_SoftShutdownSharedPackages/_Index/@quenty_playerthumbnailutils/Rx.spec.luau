 

local u1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)("Rx")
return function() --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    describe("Rx.combineLatest({})", function() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u2 = u1.combineLatest({})
        local u3 = nil
        it("should execute immediately", function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u3
            --]]
            local v5 = u2:Subscribe(function(p4) --[[ Line: 15 ]]
                --[[
                Upvalues:
                    [1] = u3
                --]]
                u3 = p4
            end)
            expect(u3).to.be.a("table")
            v5:Destroy()
        end)
    end)
    describe("Rx.combineLatest({ value = 5 })", function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u6 = u1.combineLatest({
            ["value"] = 5
        })
        local u7 = nil
        it("should execute immediately", function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u7
            --]]
            local v9 = u6:Subscribe(function(p8) --[[ Line: 29 ]]
                --[[
                Upvalues:
                    [1] = u7
                --]]
                u7 = p8
            end)
            expect(u7).to.be.a("table")
            expect(u7.value).to.equal(5)
            v9:Destroy()
        end)
    end)
    describe("Rx.combineLatest({ value = Rx.of(5) })", function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u10 = u1.combineLatest({
            ["value"] = u1.of(5)
        })
        local u11 = nil
        it("should execute immediately", function() --[[ Line: 43 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
            --]]
            local v13 = u10:Subscribe(function(p12) --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u11
                --]]
                u11 = p12
            end)
            expect(u11).to.be.a("table")
            expect(u11.value).to.equal(5)
            v13:Destroy()
        end)
    end)
end
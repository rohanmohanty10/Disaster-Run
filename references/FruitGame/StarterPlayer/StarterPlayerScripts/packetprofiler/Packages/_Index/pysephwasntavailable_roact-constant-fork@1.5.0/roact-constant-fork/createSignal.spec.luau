 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createSignal)
    local u2 = require(script.Parent.createSpy)
    it("should fire subscribers and disconnect them", function() --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v3 = u1()
        local v4 = u2()
        local v5 = v3:subscribe(v4.value)
        expect(v4.callCount).to.equal(0)
        local v6 = {}
        v3:fire(1, v6, "hello")
        expect(v4.callCount).to.equal(1)
        v4:assertCalledWith(1, v6, "hello")
        v5()
        v3:fire()
        expect(v4.callCount).to.equal(1)
    end)
    it("should handle multiple subscribers", function() --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v7 = u1()
        local v8 = u2()
        local v9 = u2()
        local v10 = v7:subscribe(v8.value)
        local v11 = v7:subscribe(v9.value)
        expect(v8.callCount).to.equal(0)
        expect(v9.callCount).to.equal(0)
        local v12 = {}
        v7:fire(v12, 67)
        expect(v8.callCount).to.equal(1)
        v8:assertCalledWith(v12, 67)
        expect(v9.callCount).to.equal(1)
        v9:assertCalledWith(v12, 67)
        v10()
        v7:fire(67, v12)
        expect(v8.callCount).to.equal(1)
        expect(v9.callCount).to.equal(2)
        v9:assertCalledWith(67, v12)
        v11()
    end)
    it("should stop firing a connection if disconnected mid-fire", function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v13 = u1()
        local u14 = nil
        local u15 = nil
        local v16 = u2(function() --[[ Line: 73 ]]
            --[[
            Upvalues:
                [1] = u15
            --]]
            u15()
        end)
        local v17 = u2(function() --[[ Line: 77 ]]
            --[[
            Upvalues:
                [1] = u14
            --]]
            u14()
        end)
        u14 = v13:subscribe(v16.value)
        u15 = v13:subscribe(v17.value)
        v13:fire()
        expect(v16.callCount + v17.callCount).to.equal(1)
    end)
    it("should allow adding listener in the middle of firing", function() --[[ Line: 90 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local u18 = u1()
        local u19 = nil
        local u20 = u2()
        local v21 = u18:subscribe(function(_, _) --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
                [3] = u20
            --]]
            u19 = u18:subscribe(u20.value)
        end)
        expect(u20.callCount).to.equal(0)
        local v22 = {}
        u18:fire(v22, 67)
        expect(u20.callCount).to.equal(0)
        u18:fire(67, v22)
        expect(u20.callCount).to.equal(1)
        u20:assertCalledWith(67, v22)
        u19()
        v21()
        u18:fire(v22)
        expect(u20.callCount).to.equal(1)
    end)
    it("should have one connection instance when add the same listener multiple times", function() --[[ Line: 122 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v23 = u1()
        local v24 = u2()
        local v25 = v23:subscribe(v24.value)
        expect(v24.callCount).to.equal(0)
        local v26 = {}
        v23:fire(v26, 67)
        expect(v24.callCount).to.equal(1)
        v24:assertCalledWith(v26, 67)
        local v27 = v23:subscribe(v24.value)
        v23:fire(67, v26)
        expect(v24.callCount).to.equal(2)
        v24:assertCalledWith(67, v26)
        v27()
        v23:fire(v26)
        expect(v24.callCount).to.equal(2)
        v25()
        v23:fire(v26)
        expect(v24.callCount).to.equal(2)
    end)
end
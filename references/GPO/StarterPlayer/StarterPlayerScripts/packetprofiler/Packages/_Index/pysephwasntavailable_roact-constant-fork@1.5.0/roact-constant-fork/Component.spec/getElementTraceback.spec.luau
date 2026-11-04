 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.createElement)
    local v2 = require(script.Parent.Parent.createReconciler)
    local u3 = require(script.Parent.Parent.GlobalConfig)
    local v4 = require(script.Parent.Parent.NoopRenderer)
    local u5 = require(script.Parent.Parent.Component)
    local u6 = v2(v4)
    it("should return stack traces in initial renders", function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u3
            [3] = u1
            [4] = u6
        --]]
        local u7 = u5:extend("TestComponent")
        local u8 = nil
        function u7.init(p9) --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8 = p9:getElementTraceback()
        end
        function u7.render(_) --[[ Line: 19 ]]
            return nil
        end
        u3.scoped({
            ["elementTracing"] = true
        }, function() --[[ Line: 27 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u7
                [3] = u6
            --]]
            local v10 = u1(u7)
            u6.mountVirtualNode(v10, nil, "Some key")
        end)
        expect(u8).to.be.a("string")
    end)
    itSKIP("it should return an updated stack trace after an update", function() --[[ Line: 38 ]] end)
    it("should return nil when elementTracing is off", function() --[[ Line: 40 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u3
            [3] = u1
            [4] = u6
        --]]
        local u11 = nil
        local u12 = u5:extend("TestComponent")
        function u12.init(p13) --[[ Line: 49 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            u11 = p13:getElementTraceback()
        end
        function u12.render(_) --[[ Line: 53 ]]
            return nil
        end
        u3.scoped({
            ["elementTracing"] = false
        }, function() --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u12
                [3] = u6
            --]]
            local v14 = u1(u12)
            u6.mountVirtualNode(v14, nil, "Some key")
        end)
        expect(u11).to.equal(nil)
    end)
end
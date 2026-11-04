 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.createElement)
    local v2 = require(script.Parent.Parent.createReconciler)
    local u3 = require(script.Parent.Parent.createSpy)
    local v4 = require(script.Parent.Parent.NoopRenderer)
    local u5 = require(script.Parent.Parent.Type)
    local u6 = require(script.Parent.Parent.Component)
    local u7 = v2(v4)
    it("should be invoked when unmounted", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u3
            [3] = u1
            [4] = u7
            [5] = u5
        --]]
        local v8 = u6:extend("MyComponent")
        local v9 = u3()
        v8.willUnmount = v9.value
        function v8.render(_) --[[ Line: 19 ]]
            return nil
        end
        local v10 = u1(v8)
        local v11 = u7.mountVirtualNode(v10, nil, "Test")
        u7.unmountVirtualNode(v11)
        expect(v9.callCount).to.equal(1)
        local v12 = v9:captureValues("self")
        expect(u5.of(v12.self)).to.equal(u5.StatefulComponentInstance)
    end)
end
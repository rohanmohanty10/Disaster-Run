 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local u4 = require(script.Parent.Parent.createSpy)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Type)
    local u7 = require(script.Parent.Parent.Component)
    local u8 = v3(v5)
    it("should be invoked when updated via updateVirtualNode", function() --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
            [6] = u1
        --]]
        local v9 = u7:extend("MyComponent")
        local v10 = u4()
        v9.didUpdate = v10.value
        function v9.render(_) --[[ Line: 19 ]]
            return nil
        end
        local v11 = {
            ["a"] = 5
        }
        local v12 = u2(v9, v11)
        local v13 = u8.mountVirtualNode(v12, nil, "Test")
        expect(v10.callCount).to.equal(0)
        local v14 = u2(v9, {
            ["a"] = 6,
            ["b"] = 2
        })
        u8.updateVirtualNode(v13, v14)
        expect(v10.callCount).to.equal(1)
        local v15 = v10:captureValues("self", "oldProps", "oldState")
        expect(u6.of(v15.self)).to.equal(u6.StatefulComponentInstance)
        u1(v15.oldProps, v11)
        u1(v15.oldState, {})
    end)
    it("should be invoked when updated via setState", function() --[[ Line: 50 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
            [6] = u1
        --]]
        local v16 = u7:extend("MyComponent")
        local v17 = u4()
        v16.didUpdate = v17.value
        local u18 = {
            ["a"] = 4
        }
        local u19 = nil
        function v16.init(u20) --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
            --]]
            u19 = function(...) --[[ Line: 62 ]]
                --[[
                Upvalues:
                    [1] = u20
                --]]
                return u20:setState(...)
            end
            u20:setState(u18)
        end
        function v16.render(_) --[[ Line: 69 ]] end
        local v21 = u2(v16)
        u8.mountVirtualNode(v21, nil, "Test")
        expect(v17.callCount).to.equal(0)
        u19({
            ["a"] = 5
        })
        expect(v17.callCount).to.equal(1)
        local v22 = v17:captureValues("self", "oldProps", "oldState")
        expect(u6.of(v22.self)).to.equal(u6.StatefulComponentInstance)
        u1(v22.oldProps, {})
        u1(v22.oldState, u18)
    end)
end
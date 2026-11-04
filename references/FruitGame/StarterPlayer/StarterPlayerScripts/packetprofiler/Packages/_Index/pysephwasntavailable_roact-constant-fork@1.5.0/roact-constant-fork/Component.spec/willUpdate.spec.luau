 

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
        v9.willUpdate = v10.value
        function v9.render(_) --[[ Line: 20 ]]
            return nil
        end
        local v11 = u2(v9, {
            ["a"] = 5
        })
        local v12 = u8.mountVirtualNode(v11, nil, "Test")
        local v13 = {
            ["a"] = 6,
            ["b"] = 2
        }
        local v14 = u2(v9, v13)
        u8.updateVirtualNode(v12, v14)
        expect(v10.callCount).to.equal(1)
        local v15 = v10:captureValues("self", "newProps", "newState")
        expect(u6.of(v15.self)).to.equal(u6.StatefulComponentInstance)
        u1(v15.newProps, v13)
        u1(v15.newState, {})
    end)
    it("it should be invoked when updated via setState", function() --[[ Line: 49 ]]
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
        local u17 = nil
        local v18 = u4()
        v16.willUpdate = v18.value
        function v16.init(u19) --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            u17 = function(p20) --[[ Line: 58 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19:setState(p20)
            end
            u19:setState({
                ["foo"] = 1
            })
        end
        function v16.render(_) --[[ Line: 67 ]]
            return nil
        end
        local v21 = u2(v16)
        u8.mountVirtualNode(v21, nil, "Test")
        expect(v18.callCount).to.equal(0)
        u17({
            ["foo"] = 2
        })
        expect(v18.callCount).to.equal(1)
        local v22 = v18:captureValues("self", "newProps", "newState")
        expect(u6.of(v22.self)).to.equal(u6.StatefulComponentInstance)
        u1(v22.newProps, {})
        u1(v22.newState, {
            ["foo"] = 2
        })
    end)
end
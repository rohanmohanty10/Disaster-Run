 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local u4 = require(script.Parent.Parent.createSpy)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Type)
    local u7 = require(script.Parent.Parent.Component)
    local u8 = v3(v5)
    it("should be invoked when props update", function() --[[ Line: 13 ]]
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
        local u10 = nil
        local u11 = nil
        local v13 = u4(function(p12) --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u11
            --]]
            u10 = p12.props
            u11 = p12.state
            return true
        end)
        v9.shouldUpdate = v13.value
        function v9.render(_) --[[ Line: 27 ]]
            return nil
        end
        local v14 = {
            ["a"] = 5
        }
        local v15 = u2(v9, v14)
        local v16 = u8.mountVirtualNode(v15, nil, "Test")
        expect(v13.callCount).to.equal(0)
        local v17 = {
            ["a"] = 6,
            ["b"] = 2
        }
        local v18 = u2(v9, v17)
        u8.updateVirtualNode(v16, v18)
        expect(v13.callCount).to.equal(1)
        local v19 = v13:captureValues("self", "newProps", "newState")
        expect(u6.of(v19.self)).to.equal(u6.StatefulComponentInstance)
        u1(v19.newProps, v17)
        u1(u10, v14)
        expect(v19.newState).to.equal(u11)
        u1(u11, {})
    end)
    it("should be invoked when state is updated", function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
            [6] = u1
        --]]
        local v20 = u7:extend("MyComponent")
        local u21 = {
            ["a"] = 1
        }
        local u22 = nil
        local u23 = nil
        function v20.init(u24) --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u21
                [3] = u23
            --]]
            u22 = function(...) --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                return u24:setState(...)
            end
            u24:setState(u21)
            u23 = u24.state
        end
        local u25 = nil
        local u26 = nil
        local v28 = u4(function(p27) --[[ Line: 84 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u26
            --]]
            u25 = p27.props
            u26 = p27.state
            return true
        end)
        v20.shouldUpdate = v28.value
        function v20.render(_) --[[ Line: 93 ]]
            return nil
        end
        local v29 = u2(v20)
        u8.mountVirtualNode(v29, nil, "Test")
        expect(v28.callCount).to.equal(0)
        local v30 = {
            ["a"] = 2,
            ["b"] = 3
        }
        u22(v30)
        expect(v28.callCount).to.equal(1)
        local v31 = v28:captureValues("self", "newProps", "newState")
        expect(u6.of(v31.self)).to.equal(u6.StatefulComponentInstance)
        expect(v31.newProps).to.equal(u25)
        u1(u25, {})
        u1(u26, u21)
        expect(u26).to.equal(u23)
        u1(v31.newState, v30)
    end)
    it("should not abort an update when returning true", function() --[[ Line: 126 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
        --]]
        local v32 = u7:extend("MyComponent")
        function v32.shouldUpdate(_) --[[ Line: 129 ]]
            return true
        end
        local v33 = u4()
        v32.render = v33.value
        local v34 = u2(v32)
        local v35 = u8.mountVirtualNode(v34, nil, "Test")
        expect(v33.callCount).to.equal(1)
        local v36 = u2(v32)
        u8.updateVirtualNode(v35, v36)
        expect(v33.callCount).to.equal(2)
    end)
    it("should abort an update when retuning false", function() --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
        --]]
        local v37 = u7:extend("MyComponent")
        function v37.shouldUpdate(_) --[[ Line: 154 ]]
            return false
        end
        local v38 = u4()
        v37.render = v38.value
        local v39 = u2(v37)
        local v40 = u8.mountVirtualNode(v39, nil, "Test")
        expect(v38.callCount).to.equal(1)
        local v41 = u2(v37)
        u8.updateVirtualNode(v40, v41)
        expect(v38.callCount).to.equal(1)
    end)
end
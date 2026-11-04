 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createSpy)
    local u3 = require(script.Parent.Parent.createElement)
    local u4 = require(script.Parent.Parent.createFragment)
    local v5 = require(script.Parent.Parent.createReconciler)
    local v6 = require(script.Parent.Parent.NoopRenderer)
    local u7 = require(script.Parent.Parent.Component)
    local u8 = v5(v6)
    it("should be invoked on initial mount", function() --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u3
            [4] = u8
            [5] = u1
        --]]
        local v9 = u2()
        local v10 = u7:extend("WithDerivedState")
        v10.getDerivedStateFromProps = v9.value
        function v10.render(_) --[[ Line: 19 ]]
            return nil
        end
        local v11 = u3(v10, {
            ["someProp"] = 1
        })
        u8.mountVirtualNode(v11, nil, "WithDerivedState")
        expect(v9.callCount).to.equal(1)
        local v12 = v9:captureValues("props", "state")
        u1(v12.props, {
            ["someProp"] = 1
        })
        u1(v12.state, {})
    end)
    it("should be invoked when updated via props", function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u8
            [4] = u3
            [5] = u1
        --]]
        local v13 = u2()
        local v14 = u7:extend("WithDerivedState")
        v14.getDerivedStateFromProps = v13.value
        function v14.render(_) --[[ Line: 45 ]]
            return nil
        end
        local v15 = u8.mountVirtualNode(u3(v14, {
            ["someProp"] = 1
        }), nil, "WithDerivedState")
        u8.updateVirtualNode(v15, u3(v14, {
            ["someProp"] = 2
        }))
        expect(v13.callCount).to.equal(2)
        local v16 = v13:captureValues("props", "state")
        u1(v16.props, {
            ["someProp"] = 2
        })
        u1(v16.state, {})
    end)
    it("should be invoked when updated via state", function() --[[ Line: 75 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u3
            [4] = u8
            [5] = u1
        --]]
        local v17 = u2()
        local v18 = u7:extend("WithDerivedState")
        v18.getDerivedStateFromProps = v17.value
        function v18.init(p19) --[[ Line: 81 ]]
            p19:setState({
                ["someState"] = 1
            })
        end
        function v18.render(_) --[[ Line: 87 ]]
            return nil
        end
        local v20 = u3(v18)
        local v21 = u8.mountVirtualNode(v20, nil, "WithDerivedState")
        u8.updateVirtualNode(v21, v20, {
            ["someState"] = 2
        })
        expect(v17.callCount).to.equal(4)
        local v22 = v17:captureValues("props", "state")
        u1(v22.props, {})
        u1(v22.state, {
            ["someState"] = 2
        })
    end)
    it("should be invoked when updating via state in init (which skips reconciliation)", function() --[[ Line: 114 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u3
            [4] = u8
            [5] = u1
        --]]
        local v23 = u2()
        local v24 = u7:extend("WithDerivedState")
        v24.getDerivedStateFromProps = v23.value
        function v24.init(p25) --[[ Line: 120 ]]
            p25:setState({
                ["stateFromInit"] = 1
            })
        end
        function v24.render(_) --[[ Line: 126 ]]
            return nil
        end
        local v26 = u3(v24, {
            ["someProp"] = 1
        })
        u8.mountVirtualNode(v26, nil, "WithDerivedState")
        expect(v23.callCount).to.equal(3)
        local v27 = v23:captureValues("props", "state")
        u1(v27.props, {
            ["someProp"] = 1
        })
        u1(v27.state, {
            ["stateFromInit"] = 1
        })
    end)
    it("should receive defaultProps", function() --[[ Line: 154 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u3
            [4] = u8
            [5] = u1
        --]]
        local v28 = u2()
        local v29 = u7:extend("WithDerivedState")
        v29.defaultProps = {
            ["someDefaultProp"] = "foo"
        }
        v29.getDerivedStateFromProps = v28.value
        function v29.render(_) --[[ Line: 164 ]]
            return nil
        end
        local v30 = u3(v29, {
            ["someProp"] = 1
        })
        local v31 = u8.mountVirtualNode(v30, nil, "WithDerivedState")
        expect(v28.callCount).to.equal(1)
        u1(v28:captureValues("props", "state").props, {
            ["someDefaultProp"] = "foo",
            ["someProp"] = 1
        })
        local v32 = u3(v29, {
            ["someProp"] = 2
        })
        u8.updateVirtualNode(v31, v32)
        expect(v28.callCount).to.equal(2)
        u1(v28:captureValues("props", "state").props, {
            ["someDefaultProp"] = "foo",
            ["someProp"] = 2
        })
    end)
    it("should derive state for all setState updates, even when deferred", function() --[[ Line: 202 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u2
            [3] = u4
            [4] = u3
            [5] = u8
        --]]
        local u33 = u7:extend("Child")
        local u34 = u2(function() --[[ Line: 204 ]]
            return {}
        end)
        local v35 = u2()
        function u33.render(_) --[[ Line: 209 ]]
            return nil
        end
        function u33.didMount(p36) --[[ Line: 213 ]]
            p36.props.callback()
        end
        local v37 = u7:extend("Parent")
        v37.getDerivedStateFromProps = v35.value
        function v37.render(u38) --[[ Line: 221 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u4
                [3] = u3
                [4] = u33
            --]]
            local function v39() --[[ Line: 222 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u34
                --]]
                u38:setState(u34.value)
            end
            local v40 = u4
            local v41 = {
                ["ChildA"] = u3(u33, {
                    ["callback"] = v39
                }),
                ["ChildB"] = u3(u33, {
                    ["callback"] = v39
                })
            }
            return v40(v41)
        end
        local v42 = u3(v37)
        u8.mountVirtualNode(v42, nil, "Test")
        expect(u34.callCount).to.equal(2)
        expect(v35.callCount).to.equal(3)
    end)
    it("should have derived state after assigning to state in init", function() --[[ Line: 248 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u7
            [3] = u3
            [4] = u8
            [5] = u1
        --]]
        local u43 = nil
        local v44 = u2(function() --[[ Line: 250 ]]
            return {
                ["derived"] = true
            }
        end)
        local v45 = u7:extend("WithDerivedState")
        v45.getDerivedStateFromProps = v44.value
        function v45.init(u46) --[[ Line: 259 ]]
            --[[
            Upvalues:
                [1] = u43
            --]]
            u46.state = {
                ["init"] = true
            }
            u43 = function() --[[ Line: 264 ]]
                --[[
                Upvalues:
                    [1] = u46
                --]]
                return u46.state
            end
        end
        function v45.render(_) --[[ Line: 269 ]]
            return nil
        end
        local v47 = u3(v45)
        u8.mountVirtualNode(v47, nil, "WithDerivedState")
        expect(v44.callCount).to.equal(2)
        u1(u43(), {
            ["init"] = true,
            ["derived"] = true
        })
    end)
end
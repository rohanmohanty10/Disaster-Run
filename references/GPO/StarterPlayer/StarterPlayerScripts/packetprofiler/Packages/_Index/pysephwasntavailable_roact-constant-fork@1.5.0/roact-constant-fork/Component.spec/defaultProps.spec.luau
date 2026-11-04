 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local u4 = require(script.Parent.Parent.None)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Component)
    local u7 = v3(v5)
    it("should fill in when mounting before init", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local v8 = {
            ["a"] = 3,
            ["b"] = 2
        }
        local v9 = u6:extend("Foo")
        v9.defaultProps = v8
        local u10 = nil
        function v9.init(p11) --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u10
            --]]
            u10 = p11.props
        end
        function v9.render(_) --[[ Line: 27 ]] end
        local v12 = {
            ["b"] = 4,
            ["c"] = 6
        }
        local v13 = u2(v9, v12)
        u7.mountVirtualNode(v13, nil, "Some Foo")
        u1(u10, {
            ["a"] = v8.a,
            ["b"] = v12.b,
            ["c"] = v12.c
        })
    end)
    it("should fill in when updating via props", function() --[[ Line: 49 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local v14 = {
            ["a"] = 3,
            ["b"] = 2
        }
        local v15 = u6:extend("Foo")
        v15.defaultProps = v14
        local u16 = nil
        function v15.render(p17) --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            u16 = p17.props
        end
        local v18 = u2(v15, {
            ["b"] = 4,
            ["c"] = 6
        })
        local v19 = u7.mountVirtualNode(v18, nil, "Some Foo")
        local v20 = {
            ["c"] = 5
        }
        local v21 = u2(v15, v20)
        u7.updateVirtualNode(v19, v21)
        u1(u16, {
            ["a"] = v14.a,
            ["b"] = v14.b,
            ["c"] = v20.c
        })
    end)
    it("should respect None to override a default prop with nil", function() --[[ Line: 91 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u4
            [3] = u2
            [4] = u7
            [5] = u1
        --]]
        local v22 = {
            ["a"] = 3,
            ["b"] = 2
        }
        local v23 = u6:extend("Foo")
        v23.defaultProps = v22
        local u24 = nil
        function v23.render(p25) --[[ Line: 102 ]]
            --[[
            Upvalues:
                [1] = u24
            --]]
            u24 = p25.props
        end
        local v26 = {
            ["b"] = u4,
            ["c"] = 4
        }
        local v27 = u2(v23, v26)
        u7.mountVirtualNode(v27, nil, "Some Foo")
        u1(u24, {
            ["a"] = v22.a,
            ["b"] = nil,
            ["c"] = v26.c
        })
    end)
end
 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local u4 = require(script.Parent.Parent.createSpy)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Type)
    local u7 = require(script.Parent.Parent.Component)
    local u8 = v3(v5)
    it("should be invoked with props when mounted", function() --[[ Line: 13 ]]
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
        v9.init = v10.value
        function v9.render(_) --[[ Line: 20 ]]
            return nil
        end
        local v11 = {
            ["a"] = 5
        }
        local v12 = u2(v9, v11)
        u8.mountVirtualNode(v12, nil, "Some Component Key")
        expect(v10.callCount).to.equal(1)
        local v13 = v10:captureValues("self", "props")
        expect(u6.of(v13.self)).to.equal(u6.StatefulComponentInstance)
        local v14 = expect
        local v15 = v13.props
        v14((typeof(v15))).to.equal("table")
        u1(v13.props, v11)
    end)
end
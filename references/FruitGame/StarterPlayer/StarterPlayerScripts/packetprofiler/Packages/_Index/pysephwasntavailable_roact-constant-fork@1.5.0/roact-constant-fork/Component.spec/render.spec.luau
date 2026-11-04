 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local u4 = require(script.Parent.Parent.createSpy)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Type)
    local u7 = require(script.Parent.Parent.Component)
    local u8 = v3(v5)
    it("should throw on mount if not overridden", function() --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u2
            [3] = u8
        --]]
        local u9 = u2((u7:extend("MyComponent")))
        local v10, v11 = pcall(function() --[[ Line: 20 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u9
            --]]
            u8.mountVirtualNode(u9, nil, "Test")
        end)
        expect(v10).to.equal(false)
        expect(v11:match("MyComponent")).to.be.ok()
        expect(v11:match("render")).to.be.ok()
    end)
    it("should be invoked when a component is mounted", function() --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
            [6] = u1
        --]]
        local v12 = u7:extend("Foo")
        local u13 = nil
        local u14 = nil
        local v16 = u4(function(p15) --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u14
            --]]
            u13 = p15.props
            u14 = p15.state
        end)
        v12.render = v16.value
        local v17 = u2(v12)
        u8.mountVirtualNode(v17, nil, "Foo Test")
        expect(v16.callCount).to.equal(1)
        local v18 = v16:captureValues("self")
        expect(u6.of(v18.self)).to.equal(u6.StatefulComponentInstance)
        u1(u13, {})
        u1(u14, {})
    end)
    it("should be invoked when a component is updated via props", function() --[[ Line: 55 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
            [6] = u1
        --]]
        local v19 = u7:extend("Foo")
        local u20 = nil
        local u21 = nil
        local v23 = u4(function(p22) --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u20
                [2] = u21
            --]]
            u20 = p22.props
            u21 = p22.state
        end)
        v19.render = v23.value
        local v24 = {
            ["a"] = 2
        }
        local v25 = u2(v19, v24)
        local v26 = u8.mountVirtualNode(v25, nil, "Foo Test")
        expect(v23.callCount).to.equal(1)
        local v27 = v23:captureValues("self")
        local v28 = u20
        local v29 = u21
        expect(u6.of(v27.self)).to.equal(u6.StatefulComponentInstance)
        u1(v28, v24)
        u1(v29, {})
        local v30 = {
            ["a"] = 3
        }
        local v31 = u2(v19, v30)
        u8.updateVirtualNode(v26, v31)
        expect(v23.callCount).to.equal(2)
        local v32 = v23:captureValues("self")
        local v33 = u20
        local v34 = u21
        expect(u6.of(v32.self)).to.equal(u6.StatefulComponentInstance)
        expect(v33).never.to.equal(v28)
        u1(v33, v30)
        expect(v34).to.equal(v29)
    end)
    it("should be invoked when a component is updated via state", function() --[[ Line: 104 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
            [3] = u2
            [4] = u8
            [5] = u6
        --]]
        local v35 = u7:extend("Foo")
        local u36 = nil
        function v35.init(u37) --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u36
            --]]
            u36 = function(...) --[[ Line: 109 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                return u37:setState(...)
            end
        end
        local u38 = nil
        local u39 = nil
        local v41 = u4(function(p40) --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u39
            --]]
            u38 = p40.props
            u39 = p40.state
        end)
        v35.render = v41.value
        local v42 = u2(v35)
        u8.mountVirtualNode(v42, nil, "Foo Test")
        expect(v41.callCount).to.equal(1)
        local v43 = v41:captureValues("self")
        local v44 = u38
        local v45 = u39
        expect(u6.of(v43.self)).to.equal(u6.StatefulComponentInstance)
        u36({})
        expect(v41.callCount).to.equal(2)
        local v46 = v41:captureValues("self")
        expect(u6.of(v46.self)).to.equal(u6.StatefulComponentInstance)
        expect(u38).to.equal(v44)
        expect(u39).never.to.equal(v45)
    end)
    itSKIP("Test defaultProps on initial render", function() --[[ Line: 147 ]] end)
    itSKIP("Test defaultProps on prop update", function() --[[ Line: 148 ]] end)
    itSKIP("Test defaultProps on state update", function() --[[ Line: 149 ]] end)
end
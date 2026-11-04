 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local v4 = require(script.Parent.Parent.NoopRenderer)
    local u5 = require(script.Parent.Parent.Component)
    local u6 = v3(v4)
    it("should be provided as a mutable self._context in Component:init", function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
        --]]
        local v7 = u5:extend("Provider")
        function v7.init(p8) --[[ Line: 14 ]]
            p8._context.foo = "bar"
        end
        function v7.render(_) --[[ Line: 18 ]] end
        local v9 = u2(v7)
        u1(u6.mountVirtualNode(v9, nil, "Provider").legacyContext, {
            ["foo"] = "bar"
        })
    end)
    it("should be inherited from parent stateful nodes", function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
        --]]
        local u10 = u5:extend("Consumer")
        local u11 = nil
        function u10.init(p12) --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u11
            --]]
            u11 = p12._context
        end
        function u10.render(_) --[[ Line: 40 ]] end
        local v13 = u5:extend("Parent")
        function v13.render(_) --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u10
            --]]
            return u2(u10)
        end
        local v14 = u2(v13)
        local v15 = {
            ["hello"] = "world",
            ["value"] = 6
        }
        local v16 = u6.mountVirtualNode(v14, nil, "Parent", nil, v15)
        expect(u11).never.to.equal(v15)
        expect(u11).never.to.equal(v16.legacyContext)
        u1(v16.legacyContext, v15)
        u1(u11, v15)
    end)
    it("should be inherited from parent function nodes", function() --[[ Line: 63 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
        --]]
        local u17 = u5:extend("Consumer")
        local u18 = nil
        function u17.init(p19) --[[ Line: 67 ]]
            --[[
            Upvalues:
                [1] = u18
            --]]
            u18 = p19._context
        end
        function u17.render(_) --[[ Line: 71 ]] end
        local v20 = u2(function() --[[ Name: Parent, Line 73 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u17
            --]]
            return u2(u17)
        end)
        local v21 = {
            ["hello"] = "world",
            ["value"] = 6
        }
        local v22 = u6.mountVirtualNode(v20, nil, "Parent", nil, v21)
        expect(u18).never.to.equal(v21)
        expect(u18).never.to.equal(v22.legacyContext)
        u1(v22.legacyContext, v21)
        u1(u18, v21)
    end)
    it("should contain values put into the tree by parent nodes", function() --[[ Line: 92 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
        --]]
        local u23 = u5:extend("Consumer")
        local u24 = nil
        function u23.init(p25) --[[ Line: 96 ]]
            --[[
            Upvalues:
                [1] = u24
            --]]
            u24 = p25._context
        end
        function u23.render(_) --[[ Line: 100 ]] end
        local v26 = u5:extend("Provider")
        function v26.init(p27) --[[ Line: 104 ]]
            p27._context.frob = "ulator"
        end
        function v26.render(_) --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u23
            --]]
            return u2(u23)
        end
        local v28 = u2(v26)
        local v29 = {
            ["dont"] = "try it"
        }
        local v30 = u6.mountVirtualNode(v28, nil, "Consumer", nil, v29)
        local v31 = {
            ["dont"] = "try it",
            ["frob"] = "ulator"
        }
        expect(v30.legacyContext).never.to.equal(v29)
        expect(u24).never.to.equal(v29)
        expect(u24).never.to.equal(v30.legacyContext)
        u1(v29, {
            ["dont"] = "try it"
        })
        u1(v30.legacyContext, v31)
        u1(u24, v31)
    end)
    it("should transfer context to children that are replaced", function() --[[ Line: 139 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
        --]]
        local u32 = u5:extend("ConsumerA")
        local u33 = nil
        function u32.init(p34) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u33
            --]]
            p34._context.A = "hello"
            u33 = p34._context
        end
        function u32.render(_) --[[ Line: 149 ]] end
        local u35 = u5:extend("ConsumerB")
        local u36 = nil
        function u35.init(p37) --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u36
            --]]
            p37._context.B = "hello"
            u36 = p37._context
        end
        function u35.render(_) --[[ Line: 160 ]] end
        local v38 = u5:extend("Provider")
        function v38.init(p39) --[[ Line: 164 ]]
            p39._context.frob = "ulator"
        end
        function v38.render(p40) --[[ Line: 168 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u35
                [3] = u32
            --]]
            if p40.props.useConsumerB then
                return u2(u35)
            else
                return u2(u32)
            end
        end
        local v41 = u2(v38)
        local v42 = u6.mountVirtualNode(v41, nil, "Consumer")
        u1(u33, {
            ["frob"] = "ulator",
            ["A"] = "hello"
        })
        local v43 = u2(v38, {
            ["useConsumerB"] = true
        })
        u6.updateVirtualNode(v42, v43)
        u1(u36, {
            ["frob"] = "ulator",
            ["B"] = "hello"
        })
    end)
end
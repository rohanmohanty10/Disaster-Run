 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.assertDeepEqual)
    local u2 = require(script.Parent.Parent.createElement)
    local v3 = require(script.Parent.Parent.createReconciler)
    local v4 = require(script.Parent.Parent.NoopRenderer)
    local u5 = require(script.Parent.Parent.oneChild)
    local u6 = require(script.Parent.Parent.Component)
    local u7 = v3(v4)
    it("should be provided as an internal api on Component", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local v8 = u6:extend("Provider")
        function v8.init(p9) --[[ Line: 15 ]]
            p9:__addContext("foo", "bar")
        end
        function v8.render(_) --[[ Line: 19 ]] end
        local v10 = u2(v8)
        u1(u7.mountVirtualNode(v10, nil, "Provider").context, {
            ["foo"] = "bar"
        })
    end)
    it("should be inherited from parent stateful nodes", function() --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local u11 = u6:extend("Consumer")
        local u12 = nil
        function u11.init(p13) --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u12
            --]]
            u12 = {
                ["hello"] = p13:__getContext("hello"),
                ["value"] = p13:__getContext("value")
            }
        end
        function u11.render(_) --[[ Line: 44 ]] end
        local v14 = u6:extend("Parent")
        function v14.render(_) --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u11
            --]]
            return u2(u11)
        end
        local v15 = u2(v14)
        local v16 = {
            ["hello"] = "world",
            ["value"] = 6
        }
        local v17 = u7.mountVirtualNode(v15, nil, "Parent", v16)
        expect(u12).never.to.equal(v16)
        expect(u12).never.to.equal(v17.context)
        u1(v17.context, v16)
        u1(u12, v16)
    end)
    it("should be inherited from parent function nodes", function() --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local u18 = u6:extend("Consumer")
        local u19 = nil
        function u18.init(p20) --[[ Line: 71 ]]
            --[[
            Upvalues:
                [1] = u19
            --]]
            u19 = {
                ["hello"] = p20:__getContext("hello"),
                ["value"] = p20:__getContext("value")
            }
        end
        function u18.render(_) --[[ Line: 78 ]] end
        local v21 = u2(function() --[[ Name: Parent, Line 80 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u18
            --]]
            return u2(u18)
        end)
        local v22 = {
            ["hello"] = "world",
            ["value"] = 6
        }
        local v23 = u7.mountVirtualNode(v21, nil, "Parent", v22)
        expect(u19).never.to.equal(v22)
        expect(u19).never.to.equal(v23.context)
        u1(v23.context, v22)
        u1(u19, v22)
    end)
    it("should not copy the context table if it doesn\'t need to", function() --[[ Line: 99 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
            [5] = u5
        --]]
        local v24 = u6:extend("Parent")
        function v24.init(p25) --[[ Line: 102 ]]
            p25:__addContext("parent", "I\'m here!")
        end
        function v24.render(_) --[[ Line: 106 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return u2(function() --[[ Line: 108 ]] end)
        end
        local v26 = u2(v24)
        local v27 = u7.mountVirtualNode(v26, nil, "Parent")
        u1(v27.context, {
            ["parent"] = "I\'m here!"
        })
        local v28 = u5(v27.children)
        expect(v27.context).to.equal(v28.context)
    end)
    it("should not allow context to move up the tree", function() --[[ Line: 128 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u5
            [5] = u1
        --]]
        local u29 = u6:extend("ChildProvider")
        function u29.init(p30) --[[ Line: 131 ]]
            p30:__addContext("child", "I\'m here too!")
        end
        function u29.render(_) --[[ Line: 135 ]] end
        local v31 = u6:extend("ParentProvider")
        function v31.init(p32) --[[ Line: 139 ]]
            p32:__addContext("parent", "I\'m here!")
        end
        function v31.render(_) --[[ Line: 143 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u29
            --]]
            return u2(u29)
        end
        local v33 = u2(v31)
        local v34 = u7.mountVirtualNode(v33, nil, "Parent")
        local v35 = u5(v34.children)
        u1(v34.context, {
            ["parent"] = "I\'m here!"
        })
        u1(v35.context, {
            ["parent"] = "I\'m here!",
            ["child"] = "I\'m here too!"
        })
    end)
    it("should contain values put into the tree by parent nodes", function() --[[ Line: 168 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local u36 = u6:extend("Consumer")
        local u37 = nil
        function u36.init(p38) --[[ Line: 172 ]]
            --[[
            Upvalues:
                [1] = u37
            --]]
            u37 = {
                ["dont"] = p38:__getContext("dont"),
                ["frob"] = p38:__getContext("frob")
            }
        end
        function u36.render(_) --[[ Line: 179 ]] end
        local v39 = u6:extend("Provider")
        function v39.init(p40) --[[ Line: 183 ]]
            p40:__addContext("frob", "ulator")
        end
        function v39.render(_) --[[ Line: 187 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u36
            --]]
            return u2(u36)
        end
        local v41 = u2(v39)
        local v42 = {
            ["dont"] = "try it"
        }
        local v43 = u7.mountVirtualNode(v41, nil, "Consumer", v42)
        local v44 = {
            ["dont"] = "try it",
            ["frob"] = "ulator"
        }
        expect(v43.context).never.to.equal(v42)
        expect(u37).never.to.equal(v42)
        expect(u37).never.to.equal(v43.context)
        u1(v42, {
            ["dont"] = "try it"
        })
        u1(v43.context, v44)
        u1(u37, v44)
    end)
    it("should transfer context to children that are replaced", function() --[[ Line: 218 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u7
            [4] = u1
        --]]
        local u45 = u6:extend("ConsumerA")
        local function u47(p46) --[[ Line: 221 ]]
            return {
                ["A"] = p46:__getContext("A"),
                ["B"] = p46:__getContext("B"),
                ["frob"] = p46:__getContext("frob")
            }
        end
        local u48 = nil
        function u45.init(p49) --[[ Line: 230 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u47
            --]]
            p49:__addContext("A", "hello")
            u48 = u47(p49)
        end
        function u45.render(_) --[[ Line: 236 ]] end
        local u50 = u6:extend("ConsumerB")
        local u51 = nil
        function u50.init(p52) --[[ Line: 241 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u47
            --]]
            p52:__addContext("B", "hello")
            u51 = u47(p52)
        end
        function u50.render(_) --[[ Line: 247 ]] end
        local v53 = u6:extend("Provider")
        function v53.init(p54) --[[ Line: 251 ]]
            p54:__addContext("frob", "ulator")
        end
        function v53.render(p55) --[[ Line: 255 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u50
                [3] = u45
            --]]
            if p55.props.useConsumerB then
                return u2(u50)
            else
                return u2(u45)
            end
        end
        local v56 = u2(v53)
        local v57 = u7.mountVirtualNode(v56, nil, "Consumer")
        u1(u48, {
            ["frob"] = "ulator",
            ["A"] = "hello"
        })
        local v58 = u2(v53, {
            ["useConsumerB"] = true
        })
        u7.updateVirtualNode(v57, v58)
        u1(u51, {
            ["frob"] = "ulator",
            ["B"] = "hello"
        })
    end)
end
 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createElement)
    local v2 = require(script.Parent.NoopRenderer)
    local v3 = require(script.Parent.createReconciler)
    local u4 = require(script.Parent.PureComponent)
    local u5 = v3(v2)
    it("should be extendable", function() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        local v6 = u4:extend("MyComponent")
        expect(v6).to.be.ok()
    end)
    it("should skip updates for shallow-equal props", function() --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u5
        --]]
        local u7 = 0
        local u8 = nil
        local u9 = u4:extend("PureChild")
        function u9.willUpdate(_) --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u7
            --]]
            u7 = u7 + 1
        end
        function u9.render(_) --[[ Line: 26 ]]
            return nil
        end
        local v10 = u4:extend("PureContainer")
        function v10.init(p11) --[[ Line: 32 ]]
            p11.state = {
                ["value"] = 0
            }
        end
        function v10.didMount(u12) --[[ Line: 38 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8 = function(p13) --[[ Line: 39 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12:setState({
                    ["value"] = p13
                })
            end
        end
        function v10.render(p14) --[[ Line: 46 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u9
            --]]
            return u1(u9, {
                ["value"] = p14.state.value
            })
        end
        local v15 = u1(v10)
        local v16 = u5.mountVirtualTree(v15, nil, "PureComponent Tree")
        expect(u7).to.equal(0)
        u8(1)
        expect(u7).to.equal(1)
        u8(1)
        expect(u7).to.equal(1)
        u8(2)
        expect(u7).to.equal(2)
        u8(1)
        expect(u7).to.equal(3)
        u5.unmountVirtualTree(v16)
    end)
end
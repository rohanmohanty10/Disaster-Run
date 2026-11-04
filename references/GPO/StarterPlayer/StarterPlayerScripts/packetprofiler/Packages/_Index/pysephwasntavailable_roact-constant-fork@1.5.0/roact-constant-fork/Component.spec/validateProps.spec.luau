 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.createElement)
    local v2 = require(script.Parent.Parent.createReconciler)
    local u3 = require(script.Parent.Parent.createSpy)
    local v4 = require(script.Parent.Parent.NoopRenderer)
    local u5 = require(script.Parent.Parent.GlobalConfig)
    local u6 = require(script.Parent.Parent.Component)
    local u7 = v2(v4)
    it("should be invoked when mounted", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u3
            [4] = u1
            [5] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 17 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local v8 = u6:extend("MyComponent")
            local v9 = u3(function() --[[ Line: 20 ]]
                return true
            end)
            v8.validateProps = v9.value
            function v8.render(_) --[[ Line: 26 ]]
                return nil
            end
            local v10 = u1(v8)
            u7.mountVirtualNode(v10, nil, "Test")
            expect(v9.callCount).to.equal(1)
        end)
    end)
    it("should be invoked when props change", function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u3
            [4] = u1
            [5] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local v11 = u6:extend("MyComponent")
            local v12 = u3(function() --[[ Line: 47 ]]
                return true
            end)
            v11.validateProps = v12.value
            function v11.render(_) --[[ Line: 53 ]]
                return nil
            end
            local v13 = u1(v11, {
                ["a"] = 1
            })
            local v14 = u7.mountVirtualNode(v13, nil, "Test")
            expect(v12.callCount).to.equal(1)
            v12:assertCalledWithDeepEqual({
                ["a"] = 1
            })
            local v15 = u1(v11, {
                ["a"] = 2
            })
            u7.updateVirtualNode(v14, v15)
            expect(v12.callCount).to.equal(2)
            v12:assertCalledWithDeepEqual({
                ["a"] = 2
            })
        end)
    end)
    it("should not be invoked when state changes", function() --[[ Line: 76 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u3
            [4] = u1
            [5] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 81 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local v16 = u6:extend("MyComponent")
            local u17 = nil
            local v18 = u3(function() --[[ Line: 85 ]]
                return true
            end)
            v16.validateProps = v18.value
            function v16.init(u19) --[[ Line: 91 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                u17 = function(p20) --[[ Line: 92 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                    --]]
                    u19:setState(p20)
                end
            end
            function v16.render(_) --[[ Line: 97 ]]
                return nil
            end
            local v21 = u1(v16, {
                ["a"] = 1
            })
            u7.mountVirtualNode(v21, nil, "Test")
            expect(v18.callCount).to.equal(1)
            v18:assertCalledWithDeepEqual({
                ["a"] = 1
            })
            u17({
                ["b"] = 1
            })
            expect(v18.callCount).to.equal(1)
        end)
    end)
    it("should throw if validateProps is not a function", function() --[[ Line: 119 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u1
            [4] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 124 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v22 = u6:extend("MyComponent")
            v22.validateProps = 1
            function v22.render(_) --[[ Line: 128 ]]
                return nil
            end
            local u23 = u1(v22)
            expect(function() --[[ Line: 136 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u23
                --]]
                u7.mountVirtualNode(u23, nil, "Test")
            end).to.throw()
        end)
    end)
    it("should throw if validateProps returns false", function() --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u1
            [4] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 147 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v24 = u6:extend("MyComponent")
            function v24.validateProps() --[[ Line: 149 ]]
                return false
            end
            function v24.render(_) --[[ Line: 153 ]]
                return nil
            end
            local u25 = u1(v24)
            expect(function() --[[ Line: 161 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u25
                --]]
                u7.mountVirtualNode(u25, nil, "Test")
            end).to.throw()
        end)
    end)
    it("should include the component name in the error message", function() --[[ Line: 167 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u1
            [4] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 172 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v26 = u6:extend("MyComponent")
            function v26.validateProps() --[[ Line: 174 ]]
                return false
            end
            function v26.render(_) --[[ Line: 178 ]]
                return nil
            end
            local u27 = u1(v26)
            local v28, v29 = pcall(function() --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u27
                --]]
                u7.mountVirtualNode(u27, nil, "Test")
            end)
            expect(v28).to.equal(false)
            local v30 = v29:find("MyComponent")
            expect(v30).to.be.ok()
        end)
    end)
    it("should be invoked after defaultProps are applied", function() --[[ Line: 196 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u3
            [4] = u1
            [5] = u7
        --]]
        u5.scoped({
            ["propValidation"] = true
        }, function() --[[ Line: 201 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local v31 = u6:extend("MyComponent")
            local v32 = u3(function() --[[ Line: 204 ]]
                return true
            end)
            v31.validateProps = v32.value
            function v31.render(_) --[[ Line: 210 ]]
                return nil
            end
            v31.defaultProps = {
                ["b"] = 2
            }
            local v33 = u1(v31, {
                ["a"] = 1
            })
            local v34 = u7.mountVirtualNode(v33, nil, "Test")
            expect(v32.callCount).to.equal(1)
            v32:assertCalledWithDeepEqual({
                ["a"] = 1,
                ["b"] = 2
            })
            local v35 = u1(v31, {
                ["a"] = 2
            })
            u7.updateVirtualNode(v34, v35)
            expect(v32.callCount).to.equal(2)
            v32:assertCalledWithDeepEqual({
                ["a"] = 2,
                ["b"] = 2
            })
        end)
    end)
    it("should not be invoked if the flag is off", function() --[[ Line: 239 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u3
            [4] = u1
            [5] = u7
        --]]
        u5.scoped({
            ["propValidation"] = false
        }, function() --[[ Line: 244 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local v36 = u6:extend("MyComponent")
            local v37 = u3(function() --[[ Line: 247 ]]
                return true
            end)
            v36.validateProps = v37.value
            function v36.render(_) --[[ Line: 253 ]]
                return nil
            end
            local v38 = u1(v36, {
                ["a"] = 1
            })
            local v39 = u7.mountVirtualNode(v38, nil, "Test")
            expect(v37.callCount).to.equal(0)
            local v40 = u1(v36, {
                ["a"] = 2
            })
            u7.updateVirtualNode(v39, v40)
            expect(v37.callCount).to.equal(0)
        end)
    end)
end
 

return function() --[[ Line: 1 ]]
    local u1 = game:GetService("ReplicatedStorage")
    local u2 = require(script.Parent.Component)
    local v3 = require(script.Parent.NoopRenderer)
    local u4 = require(script.Parent.PropMarkers.Children)
    local u5 = require(script.Parent.createContext)
    local u6 = require(script.Parent.createElement)
    local u7 = require(script.Parent.createFragment)
    local v8 = require(script.Parent.createReconciler)
    local u9 = require(script.Parent.createSpy)
    local u10 = v8(v3)
    local u11 = v8((require(script.Parent.RobloxRenderer)))
    it("should return a table", function() --[[ Line: 18 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v12 = u5("Test")
        expect(v12).to.be.ok()
        expect((type(v12))).to.equal("table")
    end)
    it("should contain a Provider and a Consumer", function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u5
        --]]
        local v13 = u5("Test")
        expect(v13.Provider).to.be.ok()
        expect(v13.Consumer).to.be.ok()
    end)
    describe("Provider", function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u9
            [3] = u6
            [4] = u10
        --]]
        it("should render its children", function() --[[ Line: 31 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u9
                [3] = u6
                [4] = u10
            --]]
            local v14 = u5("Test")
            local v15 = u9(function() --[[ Line: 34 ]]
                return nil
            end)
            local v16 = u6(v14.Provider, {
                ["value"] = "Test"
            }, {
                ["Listener"] = u6(v15.value)
            })
            local v17 = u10.mountVirtualTree(v16, nil, "Provide Tree")
            u10.unmountVirtualTree(v17)
            expect(v15.callCount).to.equal(1)
        end)
    end)
    describe("Consumer", function() --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u10
            [4] = u9
            [5] = u2
            [6] = u7
            [7] = u4
        --]]
        it("should expect a render function", function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u10
            --]]
            local u18 = u6(u5("Test").Consumer)
            expect(function() --[[ Line: 56 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u18
                --]]
                u10.mountVirtualTree(u18, nil, "Provide Tree")
            end).to.throw()
        end)
        it("should return the default value if there is no Provider", function() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u5
                [3] = u6
                [4] = u10
            --]]
            local v19 = u9()
            local v20 = u6(u5("Test").Consumer, {
                ["render"] = v19.value
            })
            local v21 = u10.mountVirtualTree(v20, nil, "Provide Tree")
            u10.unmountVirtualTree(v21)
            v19:assertCalledWith("Test")
        end)
        it("should pass the value to the render function", function() --[[ Line: 75 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u5
                [3] = u6
                [4] = u10
            --]]
            local u22 = u9()
            local u23 = u5("Test")
            local function v24() --[[ Line: 79 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u23
                    [3] = u22
                --]]
                return u6(u23.Consumer, {
                    ["render"] = u22.value
                })
            end
            local v25 = u6(u23.Provider, {
                ["value"] = "NewTest"
            }, {
                ["Listener"] = u6(v24)
            })
            local v26 = u10.mountVirtualTree(v25, nil, "Provide Tree")
            u10.unmountVirtualTree(v26)
            u22:assertCalledWith("NewTest")
        end)
        it("should update when the value updates", function() --[[ Line: 97 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u5
                [3] = u6
                [4] = u10
            --]]
            local u27 = u9()
            local u28 = u5("Test")
            local function v29() --[[ Line: 101 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u28
                    [3] = u27
                --]]
                return u6(u28.Consumer, {
                    ["render"] = u27.value
                })
            end
            local v30 = u6(u28.Provider, {
                ["value"] = "NewTest"
            }, {
                ["Listener"] = u6(v29)
            })
            local v31 = u10.mountVirtualTree(v30, nil, "Provide Tree")
            expect(u27.callCount).to.equal(1)
            u27:assertCalledWith("NewTest")
            u10.updateVirtualTree(v31, u6(u28.Provider, {
                ["value"] = "ThirdTest"
            }, {
                ["Listener"] = u6(v29)
            }))
            expect(u27.callCount).to.equal(2)
            u27:assertCalledWith("ThirdTest")
            u10.unmountVirtualTree(v31)
        end)
        it("should update when the value updates through an update blocking component", function() --[[ Line: 138 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u5
                [3] = u2
                [4] = u7
                [5] = u4
                [6] = u6
                [7] = u10
            --]]
            local u32 = u9()
            local u33 = u5("Test")
            local v34 = u2:extend("UpdateBlocker")
            function v34.render(p35) --[[ Line: 144 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u4
                --]]
                return u7(p35.props[u4])
            end
            function v34.shouldUpdate(_) --[[ Line: 148 ]]
                return false
            end
            local function v36() --[[ Line: 152 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u33
                    [3] = u32
                --]]
                return u6(u33.Consumer, {
                    ["render"] = u32.value
                })
            end
            local v37 = u6
            local v38 = u33.Provider
            local v39 = {
                ["Blocker"] = u6(v34, nil, {
                    ["Listener"] = u6(v36)
                })
            }
            local v40 = v37(v38, {
                ["value"] = "NewTest"
            }, v39)
            local v41 = u10.mountVirtualTree(v40, nil, "Provide Tree")
            expect(u32.callCount).to.equal(1)
            u32:assertCalledWith("NewTest")
            local v42 = u10.updateVirtualTree
            local v43 = u6
            local v44 = u33.Provider
            local v45 = {
                ["Blocker"] = u6(v34, nil, {
                    ["Listener"] = u6(v36)
                })
            }
            v42(v41, v43(v44, {
                ["value"] = "ThirdTest"
            }, v45))
            expect(u32.callCount).to.equal(2)
            u32:assertCalledWith("ThirdTest")
            u10.unmountVirtualTree(v41)
        end)
        it("should behave correctly when the default value is nil", function() --[[ Line: 188 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u9
                [3] = u6
                [4] = u10
            --]]
            local u46 = u5(nil)
            local u47 = u9()
            local function v48() --[[ Line: 192 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u46
                    [3] = u47
                --]]
                return u6(u46.Consumer, {
                    ["render"] = u47.value
                })
            end
            local v49 = u10.mountVirtualTree(u6(v48), nil, "Provide Tree")
            expect(u47.callCount).to.equal(1)
            u47:assertCalledWith(nil)
            local v50 = u10.updateVirtualTree(v49, u6(v48))
            u10.unmountVirtualTree(v50)
            expect(u47.callCount).to.equal(2)
            u47:assertCalledWith(nil)
        end)
    end)
    describe("Update order", function() --[[ Line: 210 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u10
        --]]
        it("should update context at the same time as props", function() --[[ Line: 264 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u10
            --]]
            local u51 = false
            local u52 = false
            local u53 = 0
            local u54 = u5("default")
            local function v58(u55) --[[ Line: 273 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u54
                    [3] = u53
                    [4] = u51
                    [5] = u52
                --]]
                local v57 = {
                    ["render"] = function(p56) --[[ Name: render, Line 275 ]]
                        --[[
                        Upvalues:
                            [1] = u53
                            [2] = u55
                            [3] = u51
                            [4] = u52
                        --]]
                        u53 = u53 + 1
                        if p56 == "context_1" then
                            expect(u55.someProp).to.equal("prop_1")
                            u51 = true
                            return
                        elseif p56 == "context_2" then
                            expect(u55.someProp).to.equal("prop_2")
                            u52 = true
                        else
                            error("Unexpected context value")
                        end
                    end
                }
                return u6(u54.Consumer, v57)
            end
            local v59 = u6
            local v60 = u54.Provider
            local v61 = {
                ["Child"] = u6(v58, {
                    ["someProp"] = "prop_1"
                })
            }
            local v62 = v59(v60, {
                ["value"] = "context_1"
            }, v61)
            local v63 = u6
            local v64 = u54.Provider
            local v65 = {
                ["Child"] = u6(v58, {
                    ["someProp"] = "prop_2"
                })
            }
            local v66 = v63(v64, {
                ["value"] = "context_2"
            }, v65)
            local v67 = u10.mountVirtualTree(v62, nil, "UpdateObservationIsFun")
            u10.updateVirtualTree(v67, v66)
            expect(u53).to.equal(2)
            expect(u51).to.equal(true)
            expect(u52).to.equal(true)
        end)
    end)
    it("does not throw if willUnmount is called twice on a context consumer", function() --[[ Line: 317 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u2
            [3] = u6
            [4] = u1
            [5] = u11
        --]]
        local u68 = u5({})
        local u69 = u2:extend("LowestComponent")
        function u69.init(_) --[[ Line: 321 ]] end
        function u69.render(_) --[[ Line: 323 ]]
            --[[
            Upvalues:
                [1] = u6
            --]]
            return u6("Frame")
        end
        function u69.didMount(p70) --[[ Line: 327 ]]
            p70.props.onDidMountCallback()
        end
        local u71 = u2:extend("FirstComponent")
        function u71.init(_) --[[ Line: 332 ]] end
        function u71.render(_) --[[ Line: 334 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u68
            --]]
            local v72 = {
                ["render"] = function() --[[ Name: render, Line 336 ]]
                    --[[
                    Upvalues:
                        [1] = u6
                    --]]
                    return u6("TextLabel")
                end
            }
            return u6(u68.Consumer, v72)
        end
        local u73 = u2:extend("ChildComponent")
        function u73.init(p74) --[[ Line: 344 ]]
            p74:setState({
                ["firstTime"] = true
            })
        end
        local u75 = nil
        function u73.render(p76) --[[ Line: 350 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u71
                [3] = u69
            --]]
            if p76.state.firstTime then
                return u6(u71)
            else
                return u6(u69, {
                    ["onDidMountCallback"] = p76.props.onDidMountCallback
                })
            end
        end
        function u73.didMount(u77) --[[ Line: 360 ]]
            --[[
            Upvalues:
                [1] = u75
            --]]
            u75 = function() --[[ Line: 361 ]]
                --[[
                Upvalues:
                    [1] = u77
                --]]
                u77:setState({
                    ["firstTime"] = false
                })
            end
        end
        local v78 = u2:extend("ParentComponent")
        local u79 = 0
        function v78.init(u80) --[[ Line: 370 ]]
            --[[
            Upvalues:
                [1] = u79
            --]]
            u80:setState({
                ["count"] = 1
            })
            function u80.onDidMountCallback() --[[ Line: 373 ]]
                --[[
                Upvalues:
                    [1] = u79
                    [2] = u80
                --]]
                u79 = u79 + 1
                if u80.state.count < 5 then
                    u80:setState({
                        ["count"] = u80.state.count + 1
                    })
                end
            end
        end
        function v78.render(p81) --[[ Line: 381 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u68
                [3] = u73
            --]]
            local v82 = u6
            local v83 = {}
            local v84 = u6
            local v85 = u68.Provider
            local v86 = {
                ["ChildComponent"] = u6(u73, {
                    ["count"] = p81.state.count,
                    ["onDidMountCallback"] = p81.onDidMountCallback
                })
            }
            v83.Provider = v84(v85, {
                ["value"] = {}
            }, v86)
            return v82("Frame", {}, v83)
        end
        local v87 = Instance.new("ScreenGui")
        v87.Parent = u1
        u11.mountVirtualNode(u6(v78), v87, "Some Key")
        expect(function() --[[ Line: 400 ]]
            --[[
            Upvalues:
                [1] = u75
            --]]
            u75()
        end).never.to.throw()
    end)
end
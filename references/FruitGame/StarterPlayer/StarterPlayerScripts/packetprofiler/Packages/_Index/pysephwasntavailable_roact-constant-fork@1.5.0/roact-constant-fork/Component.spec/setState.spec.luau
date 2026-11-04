 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.createElement)
    local v2 = require(script.Parent.Parent.createReconciler)
    local u3 = require(script.Parent.Parent.createSpy)
    local u4 = require(script.Parent.Parent.None)
    local v5 = require(script.Parent.Parent.NoopRenderer)
    local u6 = require(script.Parent.Parent.Component)
    local u7 = v2(v5)
    describe("setState", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u1
            [3] = u7
            [4] = u4
        --]]
        it("should not trigger an extra update when called in init", function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u8 = 0
            local u9 = 0
            local u10 = nil
            local v11 = u6:extend("InitComponent")
            function v11.init(p12) --[[ Line: 20 ]]
                p12:setState({
                    ["a"] = 1
                })
            end
            function v11.willUpdate(_) --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                u9 = u9 + 1
            end
            function v11.render(p13) --[[ Line: 30 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u10
                --]]
                u8 = u8 + 1
                u10 = p13.state
                return nil
            end
            local v14 = u1(v11)
            u7.mountVirtualTree(v14)
            expect(u8).to.equal(1)
            expect(u9).to.equal(0)
            expect(u10.a).to.equal(1)
        end)
        it("should throw when called in render", function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v15 = u6:extend("TestComponent")
            function v15.render(p16) --[[ Line: 48 ]]
                p16:setState({
                    ["a"] = 1
                })
            end
            local v17 = u1(v15)
            local v18, v19 = pcall(u7.mountVirtualTree, v17)
            expect(v18).to.equal(false)
            expect(v19:match("render")).to.be.ok()
            expect(v19:match("TestComponent")).to.be.ok()
        end)
        it("should throw when called in shouldUpdate", function() --[[ Line: 63 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v20 = u6:extend("TestComponent")
            function v20.render(_) --[[ Line: 66 ]]
                return nil
            end
            function v20.shouldUpdate(p21) --[[ Line: 70 ]]
                p21:setState({
                    ["a"] = 1
                })
            end
            local v22 = u1(v20)
            local v23 = u1(v20)
            local v24 = u7.mountVirtualTree(v22)
            local v25, v26 = pcall(u7.updateVirtualTree, v24, v23)
            expect(v25).to.equal(false)
            expect(v26:match("shouldUpdate")).to.be.ok()
            expect(v26:match("TestComponent")).to.be.ok()
        end)
        it("should throw when called in willUpdate", function() --[[ Line: 88 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v27 = u6:extend("TestComponent")
            function v27.render(_) --[[ Line: 91 ]]
                return nil
            end
            function v27.willUpdate(p28) --[[ Line: 95 ]]
                p28:setState({
                    ["a"] = 1
                })
            end
            local v29 = u1(v27)
            local v30 = u1(v27)
            local v31 = u7.mountVirtualTree(v29)
            local v32, v33 = pcall(u7.updateVirtualTree, v31, v30)
            expect(v32).to.equal(false)
            expect(v33:match("willUpdate")).to.be.ok()
            expect(v33:match("TestComponent")).to.be.ok()
        end)
        it("should not throw when called in willUnmount", function() --[[ Line: 112 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v34 = u6:extend("TestComponent")
            function v34.render(_) --[[ Line: 115 ]]
                return nil
            end
            function v34.willUnmount(p35) --[[ Line: 119 ]]
                p35:setState({
                    ["a"] = 1
                })
            end
            local v36 = u1(v34)
            local v37 = u7.mountVirtualTree(v36)
            local v38, _ = pcall(u7.unmountVirtualTree, v37)
            expect(v38).to.equal(true)
        end)
        it("should remove values from state when the value is None", function() --[[ Line: 133 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
                [4] = u4
            --]]
            local v39 = u6:extend("TestComponent")
            local u40 = nil
            local u41 = nil
            function v39.init(u42) --[[ Line: 137 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u41
                --]]
                u40 = function(p43) --[[ Line: 138 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                    --]]
                    u42:setState(p43)
                end
                u41 = function() --[[ Line: 142 ]]
                    --[[
                    Upvalues:
                        [1] = u42
                    --]]
                    return u42.state
                end
                u42:setState({
                    ["value"] = 0
                })
            end
            function v39.render(_) --[[ Line: 151 ]]
                return nil
            end
            local v44 = u1(v39)
            local v45 = u7.mountVirtualNode(v44, nil, "Test")
            expect(u41().value).to.equal(0)
            u40({
                ["value"] = u4
            })
            expect(u41().value).to.equal(nil)
            u7.unmountVirtualNode(v45)
        end)
        it("should invoke functions to compute a partial state", function() --[[ Line: 169 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v46 = u6:extend("TestComponent")
            local u47 = nil
            local u48 = nil
            local u49 = nil
            function v46.init(u50) --[[ Line: 173 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u48
                    [3] = u49
                --]]
                u47 = function(p51) --[[ Line: 174 ]]
                    --[[
                    Upvalues:
                        [1] = u50
                    --]]
                    u50:setState(p51)
                end
                u48 = function() --[[ Line: 178 ]]
                    --[[
                    Upvalues:
                        [1] = u50
                    --]]
                    return u50.state
                end
                u49 = function() --[[ Line: 182 ]]
                    --[[
                    Upvalues:
                        [1] = u50
                    --]]
                    return u50.props
                end
                u50:setState({
                    ["value"] = 0
                })
            end
            function v46.render(_) --[[ Line: 191 ]]
                return nil
            end
            local v52 = u1(v46)
            local v53 = u7.mountVirtualNode(v52, nil, "Test")
            expect(u48().value).to.equal(0)
            u47(function(p54, p55) --[[ Line: 200 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u49
                --]]
                expect(p54).to.equal(u48())
                expect(p55).to.equal(u49())
                return {
                    ["value"] = p54.value + 1
                }
            end)
            expect(u48().value).to.equal(1)
            u7.unmountVirtualNode(v53)
        end)
        it("should cancel rendering if the function returns nil", function() --[[ Line: 214 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v56 = u6:extend("TestComponent")
            local u57 = nil
            local u58 = 0
            function v56.init(u59) --[[ Line: 219 ]]
                --[[
                Upvalues:
                    [1] = u57
                --]]
                u57 = function(p60) --[[ Line: 220 ]]
                    --[[
                    Upvalues:
                        [1] = u59
                    --]]
                    u59:setState(p60)
                end
                u59:setState({
                    ["value"] = 0
                })
            end
            function v56.render(_) --[[ Line: 229 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                u58 = u58 + 1
                return nil
            end
            local v61 = u1(v56)
            local v62 = u7.mountVirtualNode(v61, nil, "Test")
            expect(u58).to.equal(1)
            u57(function(_, _) --[[ Line: 238 ]]
                return nil
            end)
            expect(u58).to.equal(1)
            u7.unmountVirtualNode(v62)
        end)
    end)
    describe("setState suspension", function() --[[ Line: 248 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u1
            [3] = u7
            [4] = u3
        --]]
        it("should defer setState triggered while reconciling", function() --[[ Line: 249 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u63 = u6:extend("Child")
            local u64 = nil
            function u63.render(_) --[[ Line: 253 ]]
                return nil
            end
            function u63.didMount(p65) --[[ Line: 257 ]]
                p65.props.callback()
            end
            local v66 = u6:extend("Parent")
            function v66.init(u67) --[[ Line: 263 ]]
                --[[
                Upvalues:
                    [1] = u64
                --]]
                u64 = function() --[[ Line: 264 ]]
                    --[[
                    Upvalues:
                        [1] = u67
                    --]]
                    return u67.state
                end
            end
            function v66.render(u68) --[[ Line: 269 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u63
                --]]
                return u1(u63, {
                    ["callback"] = function() --[[ Name: callback, Line 271 ]]
                        --[[
                        Upvalues:
                            [1] = u68
                        --]]
                        u68:setState({
                            ["foo"] = "bar"
                        })
                    end
                })
            end
            local v69 = u1(v66)
            local v70 = u7.mountVirtualNode(v69, nil, "Test")
            expect(v70).to.be.ok()
            expect(u64().foo).to.equal("bar")
        end)
        it("should defer setState triggered while reconciling during an update", function() --[[ Line: 289 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u71 = u6:extend("Child")
            local u72 = nil
            function u71.render(_) --[[ Line: 293 ]]
                return nil
            end
            function u71.didUpdate(p73) --[[ Line: 297 ]]
                p73.props.callback()
            end
            local v74 = u6:extend("Parent")
            function v74.init(u75) --[[ Line: 303 ]]
                --[[
                Upvalues:
                    [1] = u72
                --]]
                u72 = function() --[[ Line: 304 ]]
                    --[[
                    Upvalues:
                        [1] = u75
                    --]]
                    return u75.state
                end
            end
            function v74.render(u76) --[[ Line: 309 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u71
                --]]
                return u1(u71, {
                    ["callback"] = function() --[[ Name: callback, Line 311 ]]
                        --[[
                        Upvalues:
                            [1] = u76
                        --]]
                        if not u76.state.foo then
                            u76:setState({
                                ["foo"] = "bar"
                            })
                        end
                    end
                })
            end
            local v77 = u1(v74)
            local v78 = u7.mountVirtualNode(v77, nil, "Test")
            expect(v78).to.be.ok()
            expect(u72().foo).to.equal(nil)
            local v79 = u7.updateVirtualNode(v78, u1(v74))
            expect(v79).to.be.ok()
            expect(u72().foo).to.equal("bar")
            u7.unmountVirtualNode(v79)
        end)
        it("should combine pending state changes properly", function() --[[ Line: 339 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u80 = u6:extend("Child")
            local u81 = nil
            function u80.render(_) --[[ Line: 343 ]]
                return nil
            end
            function u80.didMount(p82) --[[ Line: 347 ]]
                p82.props.callback("foo", 1)
                p82.props.callback("bar", 3)
            end
            local v83 = u6:extend("Parent")
            function v83.init(u84) --[[ Line: 354 ]]
                --[[
                Upvalues:
                    [1] = u81
                --]]
                u81 = function() --[[ Line: 355 ]]
                    --[[
                    Upvalues:
                        [1] = u84
                    --]]
                    return u84.state
                end
            end
            function v83.render(u85) --[[ Line: 360 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u80
                --]]
                return u1(u80, {
                    ["callback"] = function(p86, p87) --[[ Name: callback, Line 362 ]]
                        --[[
                        Upvalues:
                            [1] = u85
                        --]]
                        u85:setState({
                            [p86] = p87
                        })
                    end
                })
            end
            local v88 = u1(v83)
            local v89 = u7.mountVirtualNode(v88, nil, "Test")
            expect(v89).to.be.ok()
            expect(u81().foo).to.equal(1)
            expect(u81().bar).to.equal(3)
            u7.unmountVirtualNode(v89)
        end)
        it("should abort properly when functional setState returns nil while deferred", function() --[[ Line: 383 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u3
                [3] = u1
                [4] = u7
            --]]
            local u90 = u6:extend("Child")
            function u90.render(_) --[[ Line: 386 ]]
                return nil
            end
            function u90.didMount(p91) --[[ Line: 390 ]]
                p91.props.callback()
            end
            local v92 = u6:extend("Parent")
            local v94 = u3(function(u93) --[[ Line: 396 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u90
                --]]
                return u1(u90, {
                    ["callback"] = function() --[[ Name: callback, Line 398 ]]
                        --[[
                        Upvalues:
                            [1] = u93
                        --]]
                        u93:setState(function() --[[ Line: 399 ]]
                            return nil
                        end)
                    end
                })
            end)
            v92.render = v94.value
            local v95 = u1(v92)
            local v96 = u7.mountVirtualNode(v95, nil, "Test")
            expect(v96).to.be.ok()
            expect(v94.callCount).to.equal(1)
            u7.unmountVirtualNode(v96)
        end)
        it("should still apply pending state if a subsequent state update was aborted", function() --[[ Line: 421 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u97 = u6:extend("Child")
            local u98 = nil
            function u97.render(_) --[[ Line: 425 ]]
                return nil
            end
            function u97.didMount(p99) --[[ Line: 429 ]]
                p99.props.callback(function() --[[ Line: 430 ]]
                    return {
                        ["foo"] = 1
                    }
                end)
                p99.props.callback(function() --[[ Line: 435 ]]
                    return nil
                end)
            end
            local v100 = u6:extend("Parent")
            function v100.init(u101) --[[ Line: 442 ]]
                --[[
                Upvalues:
                    [1] = u98
                --]]
                u98 = function() --[[ Line: 443 ]]
                    --[[
                    Upvalues:
                        [1] = u101
                    --]]
                    return u101.state
                end
            end
            function v100.render(u102) --[[ Line: 448 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u97
                --]]
                return u1(u97, {
                    ["callback"] = function(p103) --[[ Name: callback, Line 450 ]]
                        --[[
                        Upvalues:
                            [1] = u102
                        --]]
                        u102:setState(p103)
                    end
                })
            end
            local v104 = u1(v100)
            local v105 = u7.mountVirtualNode(v104, nil, "Test")
            expect(v105).to.be.ok()
            expect(u98().foo).to.equal(1)
            u7.unmountVirtualNode(v105)
        end)
        it("should not re-process new state when pending state is present after update", function() --[[ Line: 468 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local u106 = nil
            local u107 = nil
            local v108 = u6:extend("MyComponent")
            function v108.init(u109) --[[ Line: 474 ]]
                --[[
                Upvalues:
                    [1] = u106
                    [2] = u107
                --]]
                u109:setState({
                    ["hasUpdatedOnce"] = false,
                    ["counter"] = 0
                })
                u106 = function(p110) --[[ Line: 480 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    u109:setState(p110)
                end
                u107 = function() --[[ Line: 484 ]]
                    --[[
                    Upvalues:
                        [1] = u109
                    --]]
                    return u109.state
                end
            end
            function v108.render(_) --[[ Line: 489 ]]
                return nil
            end
            function v108.didUpdate(p111) --[[ Line: 493 ]]
                if p111.state.hasUpdatedOnce == false then
                    p111:setState({
                        ["hasUpdatedOnce"] = true
                    })
                end
            end
            local v112 = u1(v108)
            u7.mountVirtualNode(v112, nil, "Test")
            expect(u107().hasUpdatedOnce).to.equal(false)
            expect(u107().counter).to.equal(0)
            u106(function(p113) --[[ Line: 510 ]]
                return {
                    ["counter"] = p113.counter + 1
                }
            end)
            expect(u107().hasUpdatedOnce).to.equal(true)
            expect(u107().counter).to.equal(1)
        end)
        it("should throw when an infinite update is triggered", function() --[[ Line: 520 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v114 = u6:extend("InfiniteUpdater")
            function v114.render(_) --[[ Line: 523 ]]
                return nil
            end
            function v114.didMount(p115) --[[ Line: 527 ]]
                p115:setState({})
            end
            function v114.didUpdate(p116) --[[ Line: 531 ]]
                p116:setState({})
            end
            local v117 = u1(v114)
            local v118, v119 = pcall(u7.mountVirtualNode, v117, nil, "Test")
            expect(v118).to.equal(false)
            expect(v119:find("InfiniteUpdater")).to.be.ok()
            expect(v119:find("reached the setState update recursion limit")).to.be.ok()
        end)
        itSKIP("should process single updates with both new and pending state", function() --[[ Line: 546 ]] end)
        it("should call trigger update after didMount when setting state in didMount", function() --[[ Line: 553 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v120 = u6:extend("MyComponent")
            function v120.init(p121) --[[ Line: 564 ]]
                p121:setState({
                    ["status"] = "initial mount"
                })
                p121.isMounted = false
            end
            function v120.render(_) --[[ Line: 572 ]]
                return nil
            end
            function v120.didMount(p122) --[[ Line: 576 ]]
                p122:setState({
                    ["status"] = "mounted"
                })
                p122.isMounted = true
            end
            function v120.didUpdate(p123, _, p124) --[[ Line: 584 ]]
                expect(p124.status).to.equal("initial mount")
                expect(p123.state.status).to.equal("mounted")
                expect(p123.isMounted).to.equal(true)
            end
            local v125 = u1(v120)
            local v126 = u7.mountVirtualNode(v125, nil, "Test")
            expect(v126).to.be.ok()
        end)
    end)
end
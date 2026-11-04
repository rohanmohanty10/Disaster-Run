 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.assign)
    local u2 = require(script.Parent.createElement)
    local u3 = require(script.Parent.createFragment)
    local u4 = require(script.Parent.createSpy)
    local u5 = require(script.Parent.NoopRenderer)
    local u6 = require(script.Parent.Type)
    local u7 = require(script.Parent.ElementKind)
    local u8 = require(script.Parent.createReconciler)
    local u9 = u8(u5)
    describe("tree operations", function() --[[ Line: 14 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
        --]]
        it("should mount and unmount", function() --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u2
            --]]
            local v10 = u9.mountVirtualTree(u2("StringValue"))
            expect(v10).to.be.ok()
            u9.unmountVirtualTree(v10)
        end)
        it("should mount, update, and unmount", function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u2
            --]]
            local v11 = u9.mountVirtualTree(u2("StringValue"))
            expect(v11).to.be.ok()
            u9.updateVirtualTree(v11, u2("StringValue"))
            u9.unmountVirtualTree(v11)
        end)
    end)
    describe("booleans", function() --[[ Line: 34 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
        --]]
        it("should mount booleans as nil", function() --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u9
            --]]
            local v12 = u9.mountVirtualNode(false, nil, "test")
            expect(v12).to.equal(nil)
        end)
        it("should unmount nodes if they are updated to a boolean value", function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u2
            --]]
            local v13 = u9.mountVirtualNode(u2("StringValue"), nil, "test")
            expect(v13).to.be.ok()
            local v14 = u9.updateVirtualNode(v13, true)
            expect(v14).to.equal(nil)
        end)
    end)
    describe("invalid elements", function() --[[ Line: 51 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u2
        --]]
        it("should throw errors when attempting to mount invalid elements", function() --[[ Line: 52 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u2
            --]]
            local function u15() --[[ Line: 54 ]]
                return "Hello"
            end
            local function u16() --[[ Line: 57 ]]
                return 1
            end
            local function u17() --[[ Line: 60 ]]
                return function() --[[ Line: 61 ]] end
            end
            local function u18() --[[ Line: 63 ]]
                return {}
            end
            expect(function() --[[ Line: 70 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                    [3] = u15
                --]]
                u9.mountVirtualNode(u2(u15), nil, "Some Key")
            end).to.throw()
            expect(function() --[[ Line: 74 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                    [3] = u16
                --]]
                u9.mountVirtualNode(u2(u16), nil, "Some Key")
            end).to.throw()
            expect(function() --[[ Line: 78 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                    [3] = u17
                --]]
                u9.mountVirtualNode(u2(u17), nil, "Some Key")
            end).to.throw()
            expect(function() --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u2
                    [3] = u18
                --]]
                u9.mountVirtualNode(u2(u18), nil, "Some Key")
            end).to.throw()
        end)
    end)
    describe("Host components", function() --[[ Line: 88 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u1
            [4] = u8
            [5] = u2
            [6] = u6
        --]]
        it("should invoke the renderer to mount host nodes", function() --[[ Line: 89 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
                [3] = u1
                [4] = u8
                [5] = u2
                [6] = u6
            --]]
            local v19 = u4(u5.mountHostNode)
            local v20 = u8((u1({}, u5, {
                ["mountHostNode"] = v19.value
            })))
            local v21 = u2("StringValue")
            local v22 = v20.mountVirtualNode(v21, nil, "Some Key")
            expect(u6.of(v22)).to.equal(u6.VirtualNode)
            expect(v19.callCount).to.equal(1)
            local v23 = v19:captureValues("reconciler", "node")
            expect(v23.reconciler).to.equal(v20)
            expect(v23.node).to.equal(v22)
        end)
        it("should invoke the renderer to update host nodes", function() --[[ Line: 113 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
                [3] = u1
                [4] = u8
                [5] = u2
                [6] = u6
            --]]
            local v24 = u4(u5.updateHostNode)
            local v25 = u8((u1({}, u5, {
                ["mountHostNode"] = u5.mountHostNode,
                ["updateHostNode"] = v24.value
            })))
            local v26 = u2("StringValue")
            local v27 = v25.mountVirtualNode(v26, nil, "Key")
            expect(u6.of(v27)).to.equal(u6.VirtualNode)
            local v28 = u2("StringValue")
            local v29 = v25.updateVirtualNode(v27, v28)
            expect(v29).to.equal(v27)
            expect(v24.callCount).to.equal(1)
            local v30 = v24:captureValues("reconciler", "node", "newElement")
            expect(v30.reconciler).to.equal(v25)
            expect(v30.node).to.equal(v27)
            expect(v30.newElement).to.equal(v28)
        end)
        it("should invoke the renderer to unmount host nodes", function() --[[ Line: 144 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u5
                [3] = u1
                [4] = u8
                [5] = u2
                [6] = u6
            --]]
            local v31 = u4(u5.unmountHostNode)
            local v32 = u8((u1({}, u5, {
                ["mountHostNode"] = u5.mountHostNode,
                ["unmountHostNode"] = v31.value
            })))
            local v33 = u2("StringValue")
            local v34 = v32.mountVirtualNode(v33, nil, "Key")
            expect(u6.of(v34)).to.equal(u6.VirtualNode)
            v32.unmountVirtualNode(v34)
            expect(v31.callCount).to.equal(1)
            local v35 = v31:captureValues("reconciler", "node")
            expect(v35.reconciler).to.equal(v32)
            expect(v35.node).to.equal(v34)
        end)
    end)
    describe("Function components", function() --[[ Line: 172 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u9
            [4] = u6
            [5] = u3
        --]]
        it("should mount and unmount function components", function() --[[ Line: 173 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u9
                [4] = u6
            --]]
            local v36 = u4(function(_) --[[ Line: 174 ]]
                return nil
            end)
            local v37 = u2(v36.value, {
                ["someValue"] = 5
            })
            local v38 = u9.mountVirtualNode(v37, nil, "A Key")
            expect(u6.of(v38)).to.equal(u6.VirtualNode)
            expect(v36.callCount).to.equal(1)
            local v39 = v36:captureValues("props")
            expect(v39.props).to.be.a("table")
            expect(v39.props.someValue).to.equal(5)
            u9.unmountVirtualNode(v38)
            expect(v36.callCount).to.equal(1)
        end)
        it("should mount single children of function components", function() --[[ Line: 199 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u9
                [4] = u6
            --]]
            local u40 = u4(function(_) --[[ Line: 200 ]]
                return nil
            end)
            local v42 = u4(function(p41) --[[ Line: 204 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u40
                --]]
                return u2(u40.value, {
                    ["value"] = p41.value + 1
                })
            end)
            local v43 = u2(v42.value, {
                ["value"] = 13
            })
            local v44 = u9.mountVirtualNode(v43, nil, "A Key")
            expect(u6.of(v44)).to.equal(u6.VirtualNode)
            expect(v42.callCount).to.equal(1)
            expect(u40.callCount).to.equal(1)
            local v45 = v42:captureValues("props")
            local v46 = u40:captureValues("props")
            expect(v45.props).to.be.a("table")
            expect(v45.props.value).to.equal(13)
            expect(v46.props).to.be.a("table")
            expect(v46.props.value).to.equal(14)
            u9.unmountVirtualNode(v44)
            expect(v42.callCount).to.equal(1)
            expect(u40.callCount).to.equal(1)
        end)
        it("should mount fragments returned by function components", function() --[[ Line: 237 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u2
                [4] = u9
                [5] = u6
            --]]
            local u47 = u4(function(_) --[[ Line: 238 ]]
                return nil
            end)
            local u48 = u4(function(_) --[[ Line: 242 ]]
                return nil
            end)
            local v52 = u4(function(p49) --[[ Line: 246 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u2
                    [3] = u47
                    [4] = u48
                --]]
                local v50 = u3
                local v51 = {
                    ["A"] = u2(u47.value, {
                        ["value"] = p49.value + 1
                    }),
                    ["B"] = u2(u48.value, {
                        ["value"] = p49.value + 5
                    })
                }
                return v50(v51)
            end)
            local v53 = u2(v52.value, {
                ["value"] = 17
            })
            local v54 = u9.mountVirtualNode(v53, nil, "A Key")
            expect(u6.of(v54)).to.equal(u6.VirtualNode)
            expect(v52.callCount).to.equal(1)
            expect(u47.callCount).to.equal(1)
            expect(u48.callCount).to.equal(1)
            local v55 = v52:captureValues("props")
            local v56 = u47:captureValues("props")
            local v57 = u48:captureValues("props")
            expect(v55.props).to.be.a("table")
            expect(v55.props.value).to.equal(17)
            expect(v56.props).to.be.a("table")
            expect(v56.props.value).to.equal(18)
            expect(v57.props).to.be.a("table")
            expect(v57.props.value).to.equal(22)
            u9.unmountVirtualNode(v54)
            expect(v52.callCount).to.equal(1)
            expect(u47.callCount).to.equal(1)
            expect(u48.callCount).to.equal(1)
        end)
    end)
    describe("Fragments", function() --[[ Line: 291 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u9
            [3] = u7
            [4] = u4
            [5] = u2
        --]]
        it("should mount fragments", function() --[[ Line: 292 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u9
                [3] = u7
            --]]
            local v58 = u3({})
            local v59 = u9.mountVirtualNode(v58, nil, "test")
            expect(v59).to.be.ok()
            expect(u7.of(v59.currentElement)).to.equal(u7.Fragment)
        end)
        it("should mount an empty fragment", function() --[[ Line: 300 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u9
            --]]
            local v60 = u3({})
            local v61 = u9.mountVirtualNode(v60, nil, "test")
            expect(v61).to.be.ok()
            local v62 = next(v61.children)
            expect(v62).to.never.be.ok()
        end)
        it("should mount all fragment\'s children", function() --[[ Line: 310 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u3
                [4] = u9
            --]]
            local v63 = u4(function(_) --[[ Line: 311 ]]
                return nil
            end)
            local v64 = {}
            for v65 = 1, 5 do
                v64["key" .. tostring(v65)] = u2(v63.value, {})
            end
            local v66 = u3(v64)
            local v67 = u9.mountVirtualNode(v66, nil, "test")
            expect(v67).to.be.ok()
            expect(v63.callCount).to.equal(5)
        end)
    end)
end
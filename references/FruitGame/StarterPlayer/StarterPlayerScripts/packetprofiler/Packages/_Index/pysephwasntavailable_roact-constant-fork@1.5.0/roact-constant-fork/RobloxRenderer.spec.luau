 

return function() --[[ Line: 1 ]]
    local u1 = game:GetService("ReplicatedStorage")
    local u2 = require(script.Parent.assertDeepEqual)
    local u3 = require(script.Parent.Binding)
    local u4 = require(script.Parent.PropMarkers.Children)
    local u5 = require(script.Parent.Component)
    local u6 = require(script.Parent.createElement)
    local u7 = require(script.Parent.createFragment)
    local v8 = require(script.Parent.createReconciler)
    local u9 = require(script.Parent.createRef)
    local u10 = require(script.Parent.createSpy)
    local u11 = require(script.Parent.GlobalConfig)
    local u12 = require(script.Parent.Portal)
    local u13 = require(script.Parent.PropMarkers.Ref)
    local u14 = require(script.Parent.PropMarkers.Event)
    local u15 = require(script.Parent.RobloxRenderer)
    local u16 = v8(u15)
    describe("mountHostNode", function() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u16
            [3] = u15
            [4] = u3
            [5] = u9
            [6] = u13
            [7] = u10
            [8] = u11
        --]]
        it("should create instances with correct props", function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u16
                [3] = u15
            --]]
            local v17 = Instance.new("Folder")
            local v18 = u6("StringValue", {
                ["Value"] = "Hello!"
            })
            local v19 = u16.createVirtualNode(v18, v17, "Some Key")
            u15.mountHostNode(u16, v19)
            expect(#v17:GetChildren()).to.equal(1)
            local v20 = v17:GetChildren()[1]
            expect(v20.ClassName).to.equal("StringValue")
            expect(v20.Value).to.equal("Hello!")
            expect(v20.Name).to.equal("Some Key")
        end)
        it("should create children with correct names and props", function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u16
                [3] = u15
            --]]
            local v21 = Instance.new("Folder")
            local v22 = u6
            local v23 = {
                ["ChildA"] = u6("IntValue", {
                    ["Value"] = 173
                }),
                ["ChildB"] = u6("Folder")
            }
            local v24 = v22("StringValue", {
                ["Value"] = "Hey there!"
            }, v23)
            local v25 = u16.createVirtualNode(v24, v21, "Some Key")
            u15.mountHostNode(u16, v25)
            expect(#v21:GetChildren()).to.equal(1)
            local v26 = v21:GetChildren()[1]
            expect(v26.ClassName).to.equal("StringValue")
            expect(v26.Value).to.equal("Hey there!")
            expect(v26.Name).to.equal("Some Key")
            expect(#v26:GetChildren()).to.equal(2)
            local v27 = v26.ChildA
            local v28 = v26.ChildB
            expect(v27).to.be.ok()
            expect(v28).to.be.ok()
            expect(v27.ClassName).to.equal("IntValue")
            expect(v27.Value).to.equal(173)
            expect(v28.ClassName).to.equal("Folder")
        end)
        it("should attach Bindings to Roblox properties", function() --[[ Line: 87 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u6
                [3] = u16
                [4] = u15
            --]]
            local v29 = Instance.new("Folder")
            local v30, v31 = u3.create(10)
            local v32 = u6("IntValue", {
                ["Value"] = v30
            })
            local v33 = u16.createVirtualNode(v32, v29, "Some Key")
            u15.mountHostNode(u16, v33)
            expect(#v29:GetChildren()).to.equal(1)
            local v34 = v29:GetChildren()[1]
            expect(v34.ClassName).to.equal("IntValue")
            expect(v34.Value).to.equal(10)
            v31(20)
            expect(v34.Value).to.equal(20)
            u15.unmountHostNode(u16, v33)
        end)
        it("should connect Binding refs", function() --[[ Line: 114 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v35 = Instance.new("Folder")
            local v36 = u9()
            local v37 = u6("Frame", {
                [u13] = v36
            })
            local v38 = u16.createVirtualNode(v37, v35, "Some Key")
            u15.mountHostNode(u16, v38)
            expect(#v35:GetChildren()).to.equal(1)
            local v39 = v35:GetChildren()[1]
            expect(v36.current).to.be.ok()
            expect(v36.current).to.equal(v39)
            u15.unmountHostNode(u16, v38)
        end)
        it("should call function refs", function() --[[ Line: 137 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v40 = Instance.new("Folder")
            local v41 = u10()
            local v42 = u6("Frame", {
                [u13] = v41.value
            })
            local v43 = u16.createVirtualNode(v42, v40, "Some Key")
            u15.mountHostNode(u16, v43)
            expect(#v40:GetChildren()).to.equal(1)
            local v44 = v40:GetChildren()[1]
            expect(v41.callCount).to.equal(1)
            v41:assertCalledWith(v44)
            u15.unmountHostNode(u16, v43)
        end)
        it("should throw if setting invalid instance properties", function() --[[ Line: 160 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u6
                [3] = u16
                [4] = u15
            --]]
            u11.scoped({
                ["elementTracing"] = true
            }, function() --[[ Line: 165 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u16
                    [3] = u15
                --]]
                local v45 = Instance.new("Folder")
                local v46 = u6("Frame", {
                    ["Frob"] = 6
                })
                local v47 = u16.createVirtualNode(v46, v45, "Some Key")
                local v48, v49 = pcall(u15.mountHostNode, u16, v47)
                assert(not v48, "Expected call to fail")
                expect(v49:find("Frob")).to.be.ok()
                expect(v49:find("Frame")).to.be.ok()
                expect(v49:find("RobloxRenderer%.spec")).to.be.ok()
            end)
        end)
    end)
    describe("updateHostNode", function() --[[ Line: 185 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u16
            [3] = u15
            [4] = u3
            [5] = u9
            [6] = u13
            [7] = u10
            [8] = u11
        --]]
        it("should update node props and children", function() --[[ Line: 186 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u16
                [3] = u15
            --]]
            local v50 = Instance.new("Folder")
            local v51 = Instance.new("StringValue").Value
            local v52 = u6
            local v53 = {
                ["ChildA"] = u6("IntValue", {
                    ["Value"] = 1
                }),
                ["ChildB"] = u6("BoolValue", {
                    ["Value"] = true
                }),
                ["ChildC"] = u6("StringValue", {
                    ["Value"] = "test"
                }),
                ["ChildD"] = u6("StringValue", {
                    ["Value"] = "test"
                })
            }
            local v54 = v52("StringValue", {
                ["Value"] = "foo"
            }, v53)
            local v55 = u16.createVirtualNode(v54, v50, "updateHostNodeTest")
            u15.mountHostNode(u16, v55)
            local v56 = u6
            local v57 = {
                ["ChildA"] = u6("StringValue", {
                    ["Value"] = "test"
                }),
                ["ChildB"] = u6("BoolValue", {
                    ["Value"] = false
                }),
                ["ChildC"] = u6("StringValue", {}),
                ["ChildE"] = u6("Folder", {})
            }
            local v58 = v56("StringValue", {
                ["Value"] = "bar"
            }, v57)
            u15.updateHostNode(u16, v55, v58)
            local v59 = v50.updateHostNodeTest
            expect(v59.ClassName).to.equal("StringValue")
            expect(v59.Value).to.equal("bar")
            expect(#v59:GetChildren()).to.equal(4)
            local v60 = v59.ChildA
            expect(v60.ClassName).to.equal("StringValue")
            expect(v60.Value).to.equal("test")
            local v61 = v59.ChildB
            expect(v61.ClassName).to.equal("BoolValue")
            expect(v61.Value).to.equal(false)
            local v62 = v59.ChildC
            expect(v62.ClassName).to.equal("StringValue")
            expect(v62.Value).to.equal(v51)
            local v63 = v59.ChildE
            expect(v63.ClassName).to.equal("Folder")
        end)
        it("should update Bindings", function() --[[ Line: 260 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u6
                [3] = u16
                [4] = u15
            --]]
            local v64 = Instance.new("Folder")
            local v65, v66 = u3.create(10)
            local v67 = u6("IntValue", {
                ["Value"] = v65
            })
            local v68 = u16.createVirtualNode(v67, v64, "Some Key")
            u15.mountHostNode(u16, v68)
            local v69 = v64:GetChildren()[1]
            expect(v69.Value).to.equal(10)
            local v70, v71 = u3.create(99)
            local v72 = u6("IntValue", {
                ["Value"] = v70
            })
            u15.updateHostNode(u16, v68, v72)
            expect(v69.Value).to.equal(99)
            v66(123)
            expect(v69.Value).to.equal(99)
            v71(123)
            expect(v69.Value).to.equal(123)
            u15.unmountHostNode(u16, v68)
        end)
        it("should update Binding refs", function() --[[ Line: 297 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v73 = Instance.new("Folder")
            local v74 = u9()
            local v75 = u9()
            local v76 = u6("Frame", {
                [u13] = v74
            })
            local v77 = u16.createVirtualNode(v76, v73, "Some Key")
            u15.mountHostNode(u16, v77)
            expect(#v73:GetChildren()).to.equal(1)
            local v78 = v73:GetChildren()[1]
            expect(v74.current).to.equal(v78)
            expect(v75.current).never.to.be.ok()
            local v79 = u6("Frame", {
                [u13] = v75
            })
            u15.updateHostNode(u16, v77, v79)
            expect(v74.current).never.to.be.ok()
            expect(v75.current).to.equal(v78)
            u15.unmountHostNode(u16, v77)
        end)
        it("should call old function refs with nil and new function refs with a valid rbx", function() --[[ Line: 331 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v80 = Instance.new("Folder")
            local v81 = u10()
            local v82 = u10()
            local v83 = u6("Frame", {
                [u13] = v81.value
            })
            local v84 = u16.createVirtualNode(v83, v80, "Some Key")
            u15.mountHostNode(u16, v84)
            expect(#v80:GetChildren()).to.equal(1)
            local v85 = v80:GetChildren()[1]
            expect(v81.callCount).to.equal(1)
            v81:assertCalledWith(v85)
            expect(v82.callCount).to.equal(0)
            local v86 = u6("Frame", {
                [u13] = v82.value
            })
            u15.updateHostNode(u16, v84, v86)
            expect(v81.callCount).to.equal(2)
            v81:assertCalledWith(nil)
            expect(v82.callCount).to.equal(1)
            v82:assertCalledWith(v85)
            u15.unmountHostNode(u16, v84)
        end)
        it("should not call function refs again if they didn\'t change", function() --[[ Line: 368 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v87 = Instance.new("Folder")
            local v88 = u10()
            local v89 = u6("Frame", {
                ["Size"] = UDim2.new(1, 0, 1, 0),
                [u13] = v88.value
            })
            local v90 = u16.createVirtualNode(v89, v87, "Some Key")
            u15.mountHostNode(u16, v90)
            expect(#v87:GetChildren()).to.equal(1)
            local v91 = v87:GetChildren()[1]
            expect(v88.callCount).to.equal(1)
            v88:assertCalledWith(v91)
            local v92 = u6("Frame", {
                ["Size"] = UDim2.new(0.5, 0, 0.5, 0),
                [u13] = v88.value
            })
            u15.updateHostNode(u16, v90, v92)
            expect(v88.callCount).to.equal(1)
        end)
        it("should throw if setting invalid instance properties", function() --[[ Line: 401 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u6
                [3] = u16
                [4] = u15
            --]]
            u11.scoped({
                ["elementTracing"] = true
            }, function() --[[ Line: 406 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u16
                    [3] = u15
                --]]
                local v93 = Instance.new("Folder")
                local v94 = u6("Frame")
                local v95 = u6("Frame", {
                    ["Frob"] = 6
                })
                local v96 = u16.createVirtualNode(v94, v93, "Some Key")
                u15.mountHostNode(u16, v96)
                local v97, v98 = pcall(u15.updateHostNode, u16, v96, v95)
                assert(not v97, "Expected call to fail")
                expect(v98:find("Frob")).to.be.ok()
                expect(v98:find("Frame")).to.be.ok()
                expect(v98:find("RobloxRenderer%.spec")).to.be.ok()
            end)
        end)
        it("should delete instances when reconciling to nil children", function() --[[ Line: 427 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u16
                [3] = u15
            --]]
            local v99 = Instance.new("Folder")
            local v100 = u6("Frame", {
                ["Size"] = UDim2.new(1, 0, 1, 0)
            }, {
                ["child"] = u6("Frame")
            })
            local v101 = u16.createVirtualNode(v100, v99, "Some Key")
            u15.mountHostNode(u16, v101)
            expect(#v99:GetChildren()).to.equal(1)
            local v102 = v99:GetChildren()[1]
            expect(#v102:GetChildren()).to.equal(1)
            local v103 = u6("Frame", {
                ["Size"] = UDim2.new(0.5, 0, 0.5, 0)
            })
            u15.updateHostNode(u16, v101, v103)
            expect(#v102:GetChildren()).to.equal(0)
        end)
    end)
    describe("unmountHostNode", function() --[[ Line: 455 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u16
            [3] = u15
            [4] = u3
            [5] = u9
            [6] = u13
            [7] = u10
        --]]
        it("should delete instances from the inside-out", function() --[[ Line: 456 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u16
                [3] = u15
            --]]
            local v104 = Instance.new("Folder")
            local v105 = u6
            local v106 = {
                ["Child"] = u6("Folder", nil, {
                    ["Grandchild"] = u6("Folder")
                })
            }
            local v107 = v105("Folder", nil, v106)
            local v108 = u16.mountVirtualNode(v107, v104, "Root")
            expect(#v104:GetChildren()).to.equal(1)
            local v109 = v104:GetChildren()[1]
            expect(#v109:GetChildren()).to.equal(1)
            local v110 = v109:GetChildren()[1]
            expect(#v110:GetChildren()).to.equal(1)
            local v111 = v110:GetChildren()[1]
            u15.unmountHostNode(u16, v108)
            expect(v111.Parent).to.equal(nil)
            expect(v110.Parent).to.equal(nil)
            expect(v109.Parent).to.equal(nil)
        end)
        it("should unsubscribe from any Bindings", function() --[[ Line: 484 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u6
                [3] = u16
                [4] = u15
            --]]
            local v112 = Instance.new("Folder")
            local v113, v114 = u3.create(10)
            local v115 = u6("IntValue", {
                ["Value"] = v113
            })
            local v116 = u16.createVirtualNode(v115, v112, "Some Key")
            u15.mountHostNode(u16, v116)
            local v117 = v112:GetChildren()[1]
            expect(v117.Value).to.equal(10)
            u15.unmountHostNode(u16, v116)
            v114(56)
            expect(v117.Value).to.equal(10)
        end)
        it("should clear Binding refs", function() --[[ Line: 507 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v118 = Instance.new("Folder")
            local v119 = u9()
            local v120 = u6("Frame", {
                [u13] = v119
            })
            local v121 = u16.createVirtualNode(v120, v118, "Some Key")
            u15.mountHostNode(u16, v121)
            expect(v119.current).to.be.ok()
            u15.unmountHostNode(u16, v121)
            expect(v119.current).never.to.be.ok()
        end)
        it("should call function refs with nil", function() --[[ Line: 527 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u6
                [3] = u13
                [4] = u16
                [5] = u15
            --]]
            local v122 = Instance.new("Folder")
            local v123 = u10()
            local v124 = u6("Frame", {
                [u13] = v123.value
            })
            local v125 = u16.createVirtualNode(v124, v122, "Some Key")
            u15.mountHostNode(u16, v125)
            expect(v123.callCount).to.equal(1)
            u15.unmountHostNode(u16, v125)
            expect(v123.callCount).to.equal(2)
            v123:assertCalledWith(nil)
        end)
    end)
    describe("Portals", function() --[[ Line: 549 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u12
            [3] = u16
        --]]
        it("should create and destroy instances as children of `target`", function() --[[ Line: 550 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u12
                [3] = u16
            --]]
            local v126 = Instance.new("Folder")
            local function v128(p127) --[[ Line: 553 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                return u6("IntValue", {
                    ["Value"] = p127.value
                })
            end
            local v129 = u6
            local v130 = u12
            local v131 = {
                ["folderOne"] = u6("Folder"),
                ["folderTwo"] = u6("Folder"),
                ["intValueOne"] = u6(v128, {
                    ["value"] = 42
                })
            }
            local v132 = v129(v130, {
                ["target"] = v126
            }, v131)
            local v133 = u16.mountVirtualNode(v132, nil, "Some Key")
            expect(#v126:GetChildren()).to.equal(3)
            expect(v126:FindFirstChild("folderOne")).to.be.ok()
            expect(v126:FindFirstChild("folderTwo")).to.be.ok()
            expect(v126:FindFirstChild("intValueOne")).to.be.ok()
            expect(v126:FindFirstChild("intValueOne").Value).to.equal(42)
            u16.unmountVirtualNode(v133)
            expect(#v126:GetChildren()).to.equal(0)
        end)
        it("should pass prop updates through to children", function() --[[ Line: 584 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u12
                [3] = u16
            --]]
            local v134 = Instance.new("Folder")
            local v135 = u6
            local v136 = u12
            local v137 = {
                ["ChildValue"] = u6("IntValue", {
                    ["Value"] = 1
                })
            }
            local v138 = v135(v136, {
                ["target"] = v134
            }, v137)
            local v139 = u6
            local v140 = u12
            local v141 = {
                ["ChildValue"] = u6("IntValue", {
                    ["Value"] = 2
                })
            }
            local v142 = v139(v140, {
                ["target"] = v134
            }, v141)
            local v143 = u16.mountVirtualNode(v138, nil, "A Host Key")
            expect(#v134:GetChildren()).to.equal(1)
            local v144 = v134.ChildValue
            expect(v144.Value).to.equal(1)
            local v145 = u16.updateVirtualNode(v143, v142)
            expect(#v134:GetChildren()).to.equal(1)
            local v146 = v134.ChildValue
            expect(v144).to.equal(v146)
            expect(v146.Value).to.equal(2)
            u16.unmountVirtualNode(v145)
            expect(#v134:GetChildren()).to.equal(0)
        end)
        it("should throw if `target` is nil", function() --[[ Line: 625 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u12
                [3] = u16
            --]]
            local u147 = u6(u12)
            expect(function() --[[ Line: 631 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u147
                --]]
                u16.mountVirtualNode(u147, nil, "Keys for Everyone")
            end).to.throw()
        end)
        it("should throw if `target` is not a Roblox instance", function() --[[ Line: 636 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u12
                [3] = u16
            --]]
            local u148 = u6(u12, {
                ["target"] = {}
            })
            expect(function() --[[ Line: 643 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u148
                --]]
                u16.mountVirtualNode(u148, nil, "Unleash the keys!")
            end).to.throw()
        end)
        it("should recreate instances if `target` changes in an update", function() --[[ Line: 648 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u12
                [3] = u16
            --]]
            local v149 = Instance.new("Folder")
            local v150 = Instance.new("Folder")
            local v151 = u6
            local v152 = u12
            local v153 = {
                ["ChildValue"] = u6("IntValue", {
                    ["Value"] = 1
                })
            }
            local v154 = v151(v152, {
                ["target"] = v149
            }, v153)
            local v155 = u6
            local v156 = u12
            local v157 = {
                ["ChildValue"] = u6("IntValue", {
                    ["Value"] = 2
                })
            }
            local v158 = v155(v156, {
                ["target"] = v150
            }, v157)
            local v159 = u16.mountVirtualNode(v154, nil, "Some Key")
            expect(#v149:GetChildren()).to.equal(1)
            expect(#v150:GetChildren()).to.equal(0)
            local v160 = v149.ChildValue
            expect(v160.Value).to.equal(1)
            local v161 = u16.updateVirtualNode(v159, v158)
            expect(#v149:GetChildren()).to.equal(0)
            expect(#v150:GetChildren()).to.equal(1)
            local v162 = v150.ChildValue
            expect(v162.Value).to.equal(2)
            u16.unmountVirtualNode(v161)
            expect(#v149:GetChildren()).to.equal(0)
            expect(#v150:GetChildren()).to.equal(0)
        end)
    end)
    describe("Fragments", function() --[[ Line: 693 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u6
            [3] = u16
        --]]
        it("should parent the fragment\'s elements into the fragment\'s parent", function() --[[ Line: 694 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u6
                [3] = u16
            --]]
            local v163 = Instance.new("Folder")
            local v164 = u7
            local v165 = {
                ["key"] = u6("IntValue", {
                    ["Value"] = 1
                }),
                ["key2"] = u6("IntValue", {
                    ["Value"] = 2
                })
            }
            local v166 = v164(v165)
            local v167 = u16.mountVirtualNode(v166, v163, "test")
            expect(v163:FindFirstChild("key")).to.be.ok()
            expect(v163.key.ClassName).to.equal("IntValue")
            expect(v163.key.Value).to.equal(1)
            expect(v163:FindFirstChild("key2")).to.be.ok()
            expect(v163.key2.ClassName).to.equal("IntValue")
            expect(v163.key2.Value).to.equal(2)
            u16.unmountVirtualNode(v167)
            expect(#v163:GetChildren()).to.equal(0)
        end)
        it("should allow sibling fragment to have common keys", function() --[[ Line: 721 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u7
                [3] = u16
            --]]
            local v168 = Instance.new("Folder")
            local function v175(_) --[[ Line: 725 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u7
                --]]
                local v169 = u6
                local v170 = {}
                local v171 = u7
                local v172 = {
                    ["key"] = u6("StringValue", {
                        ["Value"] = "A"
                    }),
                    ["key2"] = u6("StringValue", {
                        ["Value"] = "B"
                    })
                }
                v170.fragmentA = v171(v172)
                local v173 = u7
                local v174 = {
                    ["key"] = u6("StringValue", {
                        ["Value"] = "C"
                    }),
                    ["key2"] = u6("StringValue", {
                        ["Value"] = "D"
                    })
                }
                v170.fragmentB = v173(v174)
                return v169("IntValue", {}, v170)
            end
            local v176 = u16.mountVirtualNode(u6(v175), v168, "Test")
            local v177 = v168.Test:GetChildren()
            expect(#v177).to.equal(4)
            local v178 = {}
            for _, v179 in pairs(v177) do
                expect(v179.ClassName).to.equal("StringValue")
                v178[v179.Value] = 1 + (v178[v179.Value] or 0)
            end
            expect(v178.A).to.equal(1)
            expect(v178.B).to.equal(1)
            expect(v178.C).to.equal(1)
            expect(v178.D).to.equal(1)
            u16.unmountVirtualNode(v176)
            expect(#v168:GetChildren()).to.equal(0)
        end)
        it("should render nested fragments", function() --[[ Line: 769 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u6
                [3] = u16
            --]]
            local v180 = Instance.new("Folder")
            local v181 = u7
            local v182 = {}
            local v183 = u7
            local v184 = {
                ["TheValue"] = u6("IntValue", {
                    ["Value"] = 1
                }),
                ["TheOtherValue"] = u6("IntValue", {
                    ["Value"] = 2
                })
            }
            v182.key = v183(v184)
            local v185 = v181(v182)
            local v186 = u16.mountVirtualNode(v185, v180, "Test")
            expect(v180:FindFirstChild("TheValue")).to.be.ok()
            expect(v180.TheValue.ClassName).to.equal("IntValue")
            expect(v180.TheValue.Value).to.equal(1)
            expect(v180:FindFirstChild("TheOtherValue")).to.be.ok()
            expect(v180.TheOtherValue.ClassName).to.equal("IntValue")
            expect(v180.TheOtherValue.Value).to.equal(2)
            u16.unmountVirtualNode(v186)
            expect(#v180:GetChildren()).to.equal(0)
        end)
        it("should not add any instances if the fragment is empty", function() --[[ Line: 798 ]]
            --[[
            Upvalues:
                [1] = u16
                [2] = u7
            --]]
            local v187 = Instance.new("Folder")
            local v188 = u16.mountVirtualNode(u7({}), v187, "test")
            expect(#v187:GetChildren()).to.equal(0)
            u16.unmountVirtualNode(v188)
            expect(#v187:GetChildren()).to.equal(0)
        end)
    end)
    describe("Context", function() --[[ Line: 811 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u16
            [4] = u2
            [5] = u4
            [6] = u12
        --]]
        it("should pass context values through Roblox host nodes", function() --[[ Line: 812 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u16
                [4] = u2
            --]]
            local v189 = u5:extend("Consumer")
            local u190 = nil
            function v189.init(p191) --[[ Line: 816 ]]
                --[[
                Upvalues:
                    [1] = u190
                --]]
                u190 = {
                    ["hello"] = p191:__getContext("hello")
                }
            end
            function v189.render(_) --[[ Line: 822 ]] end
            local v192 = u6("Folder", nil, {
                ["Consumer"] = u6(v189)
            })
            local v193 = {
                ["hello"] = "world"
            }
            local v194 = u16.mountVirtualNode(v192, nil, "Context Test", v193)
            expect(u190).never.to.equal(v193)
            u2(u190, v193)
            u16.unmountVirtualNode(v194)
        end)
        it("should pass context values through portal nodes", function() --[[ Line: 840 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u4
                [4] = u12
                [5] = u16
                [6] = u2
            --]]
            local v195 = Instance.new("Folder")
            local v196 = u5:extend("Provider")
            function v196.init(p197) --[[ Line: 845 ]]
                p197:__addContext("foo", "bar")
            end
            function v196.render(p198) --[[ Line: 849 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u4
                --]]
                return u6("Folder", nil, p198.props[u4])
            end
            local v199 = u5:extend("Consumer")
            local u200 = nil
            function v199.init(p201) --[[ Line: 856 ]]
                --[[
                Upvalues:
                    [1] = u200
                --]]
                u200 = {
                    ["foo"] = p201:__getContext("foo")
                }
            end
            function v199.render(_) --[[ Line: 862 ]]
                return nil
            end
            local v202 = u6
            local v203 = {
                ["Portal"] = u6(u12, {
                    ["target"] = v195
                }, {
                    ["Consumer"] = u6(v199)
                })
            }
            local v204 = v202(v196, nil, v203)
            u16.mountVirtualNode(v204, nil, "Some Key")
            u2(u200, {
                ["foo"] = "bar"
            })
        end)
    end)
    describe("Legacy context", function() --[[ Line: 883 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u16
            [4] = u2
            [5] = u4
            [6] = u12
        --]]
        it("should pass context values through Roblox host nodes", function() --[[ Line: 884 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u16
                [4] = u2
            --]]
            local v205 = u5:extend("Consumer")
            local u206 = nil
            function v205.init(p207) --[[ Line: 888 ]]
                --[[
                Upvalues:
                    [1] = u206
                --]]
                u206 = p207._context
            end
            function v205.render(_) --[[ Line: 892 ]] end
            local v208 = u6("Folder", nil, {
                ["Consumer"] = u6(v205)
            })
            local v209 = {
                ["hello"] = "world"
            }
            local v210 = u16.mountVirtualNode(v208, nil, "Context Test", nil, v209)
            expect(u206).never.to.equal(v209)
            u2(u206, v209)
            u16.unmountVirtualNode(v210)
        end)
        it("should pass context values through portal nodes", function() --[[ Line: 910 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u4
                [4] = u12
                [5] = u16
                [6] = u2
            --]]
            local v211 = Instance.new("Folder")
            local v212 = u5:extend("Provider")
            function v212.init(p213) --[[ Line: 915 ]]
                p213._context.foo = "bar"
            end
            function v212.render(p214) --[[ Line: 919 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u4
                --]]
                return u6("Folder", nil, p214.props[u4])
            end
            local v215 = u5:extend("Consumer")
            local u216 = nil
            function v215.init(p217) --[[ Line: 926 ]]
                --[[
                Upvalues:
                    [1] = u216
                --]]
                u216 = p217._context
            end
            function v215.render(_) --[[ Line: 930 ]]
                return nil
            end
            local v218 = u6
            local v219 = {
                ["Portal"] = u6(u12, {
                    ["target"] = v211
                }, {
                    ["Consumer"] = u6(v215)
                })
            }
            local v220 = v218(v212, nil, v219)
            u16.mountVirtualNode(v220, nil, "Some Key")
            u2(u216, {
                ["foo"] = "bar"
            })
        end)
    end)
    describe("Integration Tests", function() --[[ Line: 951 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u5
            [3] = u6
            [4] = u14
            [5] = u16
        --]]
        local u221 = nil
        beforeEach(function() --[[ Line: 953 ]]
            --[[
            Upvalues:
                [1] = u221
                [2] = u1
            --]]
            u221 = Instance.new("Folder")
            u221.Parent = u1
        end)
        afterEach(function() --[[ Line: 958 ]]
            --[[
            Upvalues:
                [1] = u221
            --]]
            u221:Destroy()
            u221 = nil
        end)
        it("should not allow re-entrancy in updateChildren", function() --[[ Line: 963 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u14
                [4] = u221
                [5] = u16
            --]]
            local u222 = u5:extend("ChildComponent")
            function u222.init(p223) --[[ Line: 966 ]]
                p223:setState({
                    ["firstTime"] = true
                })
            end
            local u224 = nil
            function u222.render(p225) --[[ Line: 974 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                if p225.state.firstTime then
                    return u6("Frame")
                else
                    return u6("TextLabel")
                end
            end
            function u222.didMount(u226) --[[ Line: 982 ]]
                --[[
                Upvalues:
                    [1] = u224
                --]]
                u224 = coroutine.create(function() --[[ Line: 983 ]]
                    --[[
                    Upvalues:
                        [1] = u226
                    --]]
                    u226:setState({
                        ["firstTime"] = false
                    })
                end)
            end
            local v227 = u5:extend("ParentComponent")
            function v227.init(u228) --[[ Line: 992 ]]
                u228:setState({
                    ["count"] = 1
                })
                function u228.childAdded() --[[ Line: 997 ]]
                    --[[
                    Upvalues:
                        [1] = u228
                    --]]
                    u228:setState({
                        ["count"] = u228.state.count + 1
                    })
                end
            end
            function v227.render(p229) --[[ Line: 1004 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u14
                    [3] = u222
                --]]
                local v230 = u6
                local v231 = {
                    [u14.ChildAdded] = p229.childAdded
                }
                local v232 = {
                    ["ChildComponent"] = u6(u222, {
                        ["count"] = p229.state.count
                    })
                }
                return v230("Frame", v231, v232)
            end
            local v233 = Instance.new("ScreenGui")
            v233.Parent = u221
            local v234 = u6(v227)
            local v235 = u16.mountVirtualNode(v234, v233, "Some Key")
            coroutine.resume(u224)
            expect(#v233:GetChildren()).to.equal(1)
            local v236 = v233:GetChildren()[1]
            expect(#v236:GetChildren()).to.equal(1)
            u16.unmountVirtualNode(v235)
        end)
        it("should not allow re-entrancy in updateChildren even with callbacks", function() --[[ Line: 1033 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u221
                [4] = u16
            --]]
            local u237 = u5:extend("LowestComponent")
            function u237.render(_) --[[ Line: 1036 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                return u6("Frame")
            end
            function u237.didMount(p238) --[[ Line: 1040 ]]
                p238.props.onDidMountCallback()
            end
            local u239 = u5:extend("ChildComponent")
            function u239.init(p240) --[[ Line: 1046 ]]
                p240:setState({
                    ["firstTime"] = true
                })
            end
            local u241 = nil
            function u239.render(p242) --[[ Line: 1054 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u237
                --]]
                if p242.state.firstTime then
                    return u6("Frame")
                else
                    return u6(u237, {
                        ["onDidMountCallback"] = p242.props.onDidMountCallback
                    })
                end
            end
            function u239.didMount(u243) --[[ Line: 1064 ]]
                --[[
                Upvalues:
                    [1] = u241
                --]]
                u241 = coroutine.create(function() --[[ Line: 1065 ]]
                    --[[
                    Upvalues:
                        [1] = u243
                    --]]
                    u243:setState({
                        ["firstTime"] = false
                    })
                end)
            end
            local v244 = u5:extend("ParentComponent")
            local u245 = 0
            function v244.init(u246) --[[ Line: 1076 ]]
                --[[
                Upvalues:
                    [1] = u245
                --]]
                u246:setState({
                    ["count"] = 1
                })
                function u246.onDidMountCallback() --[[ Line: 1081 ]]
                    --[[
                    Upvalues:
                        [1] = u245
                        [2] = u246
                    --]]
                    u245 = u245 + 1
                    if u246.state.count < 5 then
                        u246:setState({
                            ["count"] = u246.state.count + 1
                        })
                    end
                end
            end
            function v244.render(p247) --[[ Line: 1091 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u239
                --]]
                local v248 = u6
                local v249 = {
                    ["ChildComponent"] = u6(u239, {
                        ["count"] = p247.state.count,
                        ["onDidMountCallback"] = p247.onDidMountCallback
                    })
                }
                return v248("Frame", {}, v249)
            end
            local v250 = Instance.new("ScreenGui")
            v250.Parent = u221
            local v251 = u6(v244)
            local v252 = u16.mountVirtualNode(v251, v250, "Some Key")
            coroutine.resume(u241)
            expect(#v250:GetChildren()).to.equal(1)
            local v253 = v250:GetChildren()[1]
            expect(#v253:GetChildren()).to.equal(1)
            expect(u245 <= 2).to.equal(true)
            u16.unmountVirtualNode(v252)
        end)
        it("should never call unmount twice in the case of update children re-rentrancy", function() --[[ Line: 1123 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u221
                [4] = u16
            --]]
            local u254 = {}
            local u255 = u5:extend("LowestComponent")
            function u255.init(p256) --[[ Line: 1135 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                u254[tostring(p256)] = 0
            end
            function u255.render(_) --[[ Line: 1139 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                return u6("Frame")
            end
            function u255.didMount(p257) --[[ Line: 1143 ]]
                p257.props.onDidMountCallback()
            end
            function u255.willUnmount(p258) --[[ Line: 1147 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                local v259 = tostring(p258)
                u254[v259] = u254[v259] + 1
            end
            local u260 = u5:extend("FirstComponent")
            function u260.init(p261) --[[ Line: 1152 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                u254[tostring(p261)] = 0
            end
            function u260.render(_) --[[ Line: 1156 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                return u6("TextLabel")
            end
            function u260.willUnmount(p262) --[[ Line: 1160 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                local v263 = tostring(p262)
                u254[v263] = u254[v263] + 1
            end
            local u264 = u5:extend("ChildComponent")
            function u264.init(p265) --[[ Line: 1166 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                u254[tostring(p265)] = 0
                p265:setState({
                    ["firstTime"] = true
                })
            end
            local u266 = nil
            function u264.render(p267) --[[ Line: 1176 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u260
                    [3] = u255
                --]]
                if p267.state.firstTime then
                    return u6(u260)
                else
                    return u6(u255, {
                        ["onDidMountCallback"] = p267.props.onDidMountCallback
                    })
                end
            end
            function u264.didMount(u268) --[[ Line: 1186 ]]
                --[[
                Upvalues:
                    [1] = u266
                --]]
                u266 = coroutine.create(function() --[[ Line: 1187 ]]
                    --[[
                    Upvalues:
                        [1] = u268
                    --]]
                    u268:setState({
                        ["firstTime"] = false
                    })
                end)
            end
            function u264.willUnmount(p269) --[[ Line: 1194 ]]
                --[[
                Upvalues:
                    [1] = u254
                --]]
                local v270 = tostring(p269)
                u254[v270] = u254[v270] + 1
            end
            local v271 = u5:extend("ParentComponent")
            local u272 = 0
            function v271.init(u273) --[[ Line: 1202 ]]
                --[[
                Upvalues:
                    [1] = u272
                --]]
                u273:setState({
                    ["count"] = 1
                })
                function u273.onDidMountCallback() --[[ Line: 1207 ]]
                    --[[
                    Upvalues:
                        [1] = u272
                        [2] = u273
                    --]]
                    u272 = u272 + 1
                    if u273.state.count < 5 then
                        u273:setState({
                            ["count"] = u273.state.count + 1
                        })
                    end
                end
            end
            function v271.render(p274) --[[ Line: 1217 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u264
                --]]
                local v275 = u6
                local v276 = {
                    ["ChildComponent"] = u6(u264, {
                        ["count"] = p274.state.count,
                        ["onDidMountCallback"] = p274.onDidMountCallback
                    })
                }
                return v275("Frame", {}, v276)
            end
            local v277 = Instance.new("ScreenGui")
            v277.Parent = u221
            local v278 = u6(v271)
            local v279 = u16.mountVirtualNode(v278, v277, "Some Key")
            coroutine.resume(u266)
            expect(#v277:GetChildren()).to.equal(1)
            local v280 = v277:GetChildren()[1]
            expect(#v280:GetChildren()).to.equal(1)
            expect(u272 <= 2).to.equal(true)
            u16.unmountVirtualNode(v279)
            for _, v281 in pairs(u254) do
                expect(v281).to.equal(1)
            end
        end)
        it("should never unmount a node unnecesarily in the case of re-rentry", function() --[[ Line: 1253 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u6
                [3] = u221
                [4] = u16
            --]]
            local u282 = u5:extend("LowestComponent")
            function u282.render(_) --[[ Line: 1255 ]]
                --[[
                Upvalues:
                    [1] = u6
                --]]
                return u6("Frame")
            end
            function u282.didUpdate(p283, p284, _) --[[ Line: 1259 ]]
                if p284.firstTime and not p283.props.firstTime then
                    p283.props.onChangedCallback()
                end
            end
            local u285 = u5:extend("ChildComponent")
            function u285.init(p286) --[[ Line: 1267 ]]
                p286:setState({
                    ["firstTime"] = true
                })
            end
            local u287 = nil
            function u285.render(p288) --[[ Line: 1275 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u282
                --]]
                return u6(u282, {
                    ["firstTime"] = p288.state.firstTime,
                    ["onChangedCallback"] = p288.props.onChangedCallback
                })
            end
            function u285.didMount(u289) --[[ Line: 1282 ]]
                --[[
                Upvalues:
                    [1] = u287
                --]]
                u287 = coroutine.create(function() --[[ Line: 1283 ]]
                    --[[
                    Upvalues:
                        [1] = u289
                    --]]
                    u289:setState({
                        ["firstTime"] = false
                    })
                end)
            end
            local v290 = u5:extend("ParentComponent")
            local u291 = 0
            function v290.init(u292) --[[ Line: 1294 ]]
                --[[
                Upvalues:
                    [1] = u291
                --]]
                u292:setState({
                    ["count"] = 1
                })
                function u292.onChangedCallback() --[[ Line: 1299 ]]
                    --[[
                    Upvalues:
                        [1] = u291
                        [2] = u292
                    --]]
                    u291 = u291 + 1
                    if u292.state.count < 5 then
                        u292:setState({
                            ["count"] = u292.state.count + 1
                        })
                    end
                end
            end
            function v290.render(p293) --[[ Line: 1309 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u285
                --]]
                local v294 = u6
                local v295 = {
                    ["ChildComponent"] = u6(u285, {
                        ["count"] = p293.state.count,
                        ["onChangedCallback"] = p293.onChangedCallback
                    })
                }
                return v294("Frame", {}, v295)
            end
            local v296 = Instance.new("ScreenGui")
            v296.Parent = u221
            local v297 = u6(v290)
            local v298 = u16.mountVirtualNode(v297, v296, "Some Key")
            coroutine.resume(u287)
            expect(#v296:GetChildren()).to.equal(1)
            local v299 = v296:GetChildren()[1]
            expect(#v299:GetChildren()).to.equal(1)
            expect(u291).to.equal(1)
            u16.unmountVirtualNode(v298)
        end)
    end)
end
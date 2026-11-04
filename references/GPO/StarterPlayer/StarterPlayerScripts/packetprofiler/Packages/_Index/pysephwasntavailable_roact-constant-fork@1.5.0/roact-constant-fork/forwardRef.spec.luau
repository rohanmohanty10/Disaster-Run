 

return function() --[[ Line: 4 ]]
    local u1 = require(script.Parent.assign)
    local u2 = require(script.Parent.createElement)
    local u3 = require(script.Parent.createRef)
    local u4 = require(script.Parent.forwardRef)
    local v5 = require(script.Parent.createReconciler)
    local u6 = require(script.Parent.Component)
    local u7 = require(script.Parent.GlobalConfig)
    local u8 = require(script.Parent.PropMarkers.Ref)
    local u9 = v5((require(script.Parent.RobloxRenderer)))
    it("should update refs when switching between children", function() --[[ Line: 18 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u4
            [4] = u1
            [5] = u3
            [6] = u9
        --]]
        local function u21(p10) --[[ Line: 19 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u8
            --]]
            local v11 = p10.forwardedRef
            local v12
            if p10.setRefOnDiv then
                v12 = nil
            else
                v12 = v11
                v11 = nil
            end
            local v13 = u2
            local v14 = {}
            local v15 = u2
            local v16 = {
                [u8] = v11
            }
            local v17 = {
                ["Child"] = u2("TextLabel", {
                    ["Text"] = "First"
                })
            }
            v14.First = v15("Frame", v16, v17)
            local v18 = u2
            local v19 = {
                [u8] = v12
            }
            local v20 = {
                ["Child"] = u2("TextLabel", {
                    ["Text"] = "Second"
                })
            }
            v14.Second = v18("ScrollingFrame", v19, v20)
            return v13("Frame", nil, v14)
        end
        local v24 = u4(function(p22, p23) --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u21
                [3] = u1
            --]]
            return u2(u21, u1({}, p22, {
                ["forwardedRef"] = p23
            }))
        end)
        local v25 = u3()
        local v26 = u2(v24, {
            [u8] = v25,
            ["setRefOnDiv"] = true
        })
        local v27 = u9.mountVirtualTree(v26, nil, "switch refs")
        expect(v25.current.ClassName).to.equal("Frame")
        u9.unmountVirtualTree(v27)
        local v28 = u2(v24, {
            [u8] = v25,
            ["setRefOnDiv"] = false
        })
        local v29 = u9.mountVirtualTree(v28, nil, "switch refs")
        expect(v25.current.ClassName).to.equal("ScrollingFrame")
        u9.unmountVirtualTree(v29)
    end)
    it("should support rendering nil", function() --[[ Line: 71 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
            [4] = u8
            [5] = u9
        --]]
        local v30 = u4(function(_, _) --[[ Line: 72 ]]
            return nil
        end)
        local v31 = u3()
        local v32 = u2(v30, {
            [u8] = v31
        })
        local v33 = u9.mountVirtualTree(v32, nil, "nil ref")
        expect(v31.current).to.equal(nil)
        u9.unmountVirtualTree(v33)
    end)
    it("should support rendering nil for multiple children", function() --[[ Line: 84 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
            [3] = u2
            [4] = u8
            [5] = u9
        --]]
        local v34 = u4(function(_, _) --[[ Line: 85 ]]
            return nil
        end)
        local v35 = u3()
        local v36 = u2
        local v37 = {
            ["NoRef1"] = u2("Frame"),
            ["WithRef"] = u2(v34, {
                [u8] = v35
            }),
            ["NoRef2"] = u2("Frame")
        }
        local v38 = v36("Frame", nil, v37)
        local v39 = u9.mountVirtualTree(v38, nil, "multiple children nil ref")
        expect(v35.current).to.equal(nil)
        u9.unmountVirtualTree(v39)
    end)
    itSKIP("should support defaultProps", function() --[[ Line: 103 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u4
            [4] = u1
            [5] = u3
            [6] = u9
        --]]
        local function u41(p40) --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u8
            --]]
            return u2("Frame", {
                [u8] = p40.forwardedRef
            }, {
                ["OptionalChild"] = p40.optional,
                ["RequiredChild"] = p40.required
            })
        end
        local v44 = u4(function(p42, p43) --[[ Line: 116 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u41
                [3] = u1
            --]]
            return u2(u41, u1({}, p42, {
                ["forwardedRef"] = p43
            }))
        end)
        v44.defaultProps = {
            ["optional"] = u2("TextLabel")
        }
        local v45 = u3()
        local v46 = u2(v44, {
            [u8] = v45,
            ["optional"] = u2("Frame"),
            ["required"] = u2("ScrollingFrame")
        })
        local v47 = u9.mountVirtualTree(v46, nil, "with optional")
        expect(v45.current:FindFirstChild("OptionalChild").ClassName).to.equal("Frame")
        expect(v45.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
        u9.unmountVirtualTree(v47)
        local v48 = u2(v44, {
            [u8] = v45,
            ["required"] = u2("ScrollingFrame")
        })
        local v49 = u9.mountVirtualTree(v48, nil, "with default")
        expect(v45.current:FindFirstChild("OptionalChild").ClassName).to.equal("TextLabel")
        expect(v45.current:FindFirstChild("RequiredChild").ClassName).to.equal("ScrollingFrame")
        u9.unmountVirtualTree(v49)
    end)
    it("should error if not provided a callback when type checking is enabled", function() --[[ Line: 153 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u4
        --]]
        u7.scoped({
            ["typeChecks"] = true
        }, function() --[[ Line: 156 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            expect(function() --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                u4(nil)
            end).to.throw()
        end)
        u7.scoped({
            ["typeChecks"] = true
        }, function() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            expect(function() --[[ Line: 165 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                u4("foo")
            end).to.throw()
        end)
    end)
    it("should work without a ref to be forwarded", function() --[[ Line: 171 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
            [3] = u8
            [4] = u4
            [5] = u9
        --]]
        local function u50() --[[ Line: 172 ]]
            return nil
        end
        local function u52(p51) --[[ Line: 176 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u50
                [3] = u1
                [4] = u8
            --]]
            return u2(u50, u1({}, p51, {
                [u8] = p51.forwardedRef
            }))
        end
        local v55 = u2(u4(function(p53, p54) --[[ Line: 180 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u52
                [3] = u1
            --]]
            return u2(u52, u1({}, p53, {
                ["forwardedRef"] = p54
            }))
        end), {
            ["value"] = 123
        })
        local v56 = u9.mountVirtualTree(v55, nil, "nil ref")
        u9.unmountVirtualTree(v56)
    end)
    it("should forward a ref for a single child", function() --[[ Line: 189 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u1
            [4] = u4
            [5] = u3
            [6] = u9
        --]]
        local u57 = nil
        local function u59(p58) --[[ Line: 191 ]]
            --[[
            Upvalues:
                [1] = u57
                [2] = u2
                [3] = u8
            --]]
            u57 = p58.value
            return u2("Frame", {
                [u8] = p58[u8]
            })
        end
        local function u61(p60) --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u59
                [3] = u1
                [4] = u8
            --]]
            return u2(u59, u1({}, p60, {
                [u8] = p60.forwardedRef
            }))
        end
        local v64 = u4(function(p62, p63) --[[ Line: 202 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u61
                [3] = u1
            --]]
            return u2(u61, u1({}, p62, {
                ["forwardedRef"] = p63
            }))
        end)
        local v65 = u3()
        local v66 = u2(v64, {
            [u8] = v65,
            ["value"] = 123
        })
        local v67 = u9.mountVirtualTree(v66, nil, "single child ref")
        expect(u57).to.equal(123)
        expect(v65.current.ClassName).to.equal("Frame")
        u9.unmountVirtualTree(v67)
    end)
    it("should forward a ref for multiple children", function() --[[ Line: 215 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u1
            [4] = u4
            [5] = u3
            [6] = u9
        --]]
        local function u69(p68) --[[ Line: 216 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u8
            --]]
            return u2("Frame", {
                [u8] = p68[u8]
            })
        end
        local function u71(p70) --[[ Line: 222 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u69
                [3] = u1
                [4] = u8
            --]]
            return u2(u69, u1({}, p70, {
                [u8] = p70.forwardedRef
            }))
        end
        local v74 = u4(function(p72, p73) --[[ Line: 226 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u71
                [3] = u1
            --]]
            return u2(u71, u1({}, p72, {
                ["forwardedRef"] = p73
            }))
        end)
        local v75 = u3()
        local v76 = u2
        local v77 = {
            ["NoRef1"] = u2("Frame"),
            ["WithRef"] = u2(v74, {
                [u8] = v75
            }),
            ["NoRef2"] = u2("Frame")
        }
        local v78 = v76("Frame", nil, v77)
        local v79 = u9.mountVirtualTree(v78, nil, "multi child ref")
        expect(v75.current.ClassName).to.equal("Frame")
        u9.unmountVirtualTree(v79)
    end)
    it("should maintain child instance and ref through updates", function() --[[ Line: 242 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u1
            [4] = u4
            [5] = u9
        --]]
        local u80 = nil
        local function u82(p81) --[[ Line: 244 ]]
            --[[
            Upvalues:
                [1] = u80
                [2] = u2
                [3] = u8
            --]]
            u80 = p81.value
            return u2("Frame", {
                [u8] = p81[u8]
            })
        end
        local function u84(p83) --[[ Line: 251 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u82
                [3] = u1
                [4] = u8
            --]]
            return u2(u82, u1({}, p83, {
                [u8] = p83.forwardedRef
            }))
        end
        local v87 = u4(function(p85, p86) --[[ Line: 255 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u84
                [3] = u1
            --]]
            return u2(u84, u1({}, p85, {
                ["forwardedRef"] = p86
            }))
        end)
        local u88 = 0
        local u89 = nil
        local function v91(p90) --[[ Line: 262 ]]
            --[[
            Upvalues:
                [1] = u88
                [2] = u89
            --]]
            u88 = u88 + 1
            u89 = p90
        end
        local v92 = u2(v87, {
            [u8] = v91,
            ["value"] = 123
        })
        local v93 = u9.mountVirtualTree(v92, nil, "maintains instance")
        expect(u80).to.equal(123)
        expect(u89.ClassName).to.equal("Frame")
        expect(u88).to.equal(1)
        local v94 = u2(v87, {
            [u8] = v91,
            ["value"] = 456
        })
        local v95 = u9.updateVirtualTree(v93, v94)
        expect(u80).to.equal(456)
        expect(u88).to.equal(1)
        u9.unmountVirtualTree(v95)
    end)
    it("should not re-run the render callback on a deep setState", function() --[[ Line: 282 ]]
        --[[
        Upvalues:
            [1] = u6
            [2] = u2
            [3] = u8
            [4] = u4
            [5] = u1
            [6] = u9
        --]]
        local u96 = nil
        local u97 = {}
        local u98 = u6:extend("Inner")
        function u98.render(p99) --[[ Line: 287 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u96
                [3] = u2
                [4] = u8
            --]]
            local v100 = u97
            table.insert(v100, "Inner")
            u96 = p99
            return u2("Frame", {
                [u8] = p99.props.forwardedRef
            })
        end
        local function u103(p101) --[[ Line: 293 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u2
                [3] = u98
            --]]
            local v102 = u97
            table.insert(v102, "Middle")
            return u2(u98, p101)
        end
        local u107 = u4(function(p104, p105) --[[ Line: 298 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u2
                [3] = u103
                [4] = u1
            --]]
            local v106 = u97
            table.insert(v106, "Forward")
            return u2(u103, u1({}, p104, {
                ["forwardedRef"] = p105
            }))
        end)
        local function v109() --[[ Line: 303 ]]
            --[[
            Upvalues:
                [1] = u97
                [2] = u2
                [3] = u107
            --]]
            local v108 = u97
            table.insert(v108, "App")
            return u2(u107)
        end
        local v110 = u9.mountVirtualTree(u2(v109), nil, "deep setState")
        expect(#u97).to.equal(4)
        expect(u97[1]).to.equal("App")
        expect(u97[2]).to.equal("Forward")
        expect(u97[3]).to.equal("Middle")
        expect(u97[4]).to.equal("Inner")
        u97 = {}
        u96:setState({})
        expect(#u97).to.equal(1)
        expect(u97[1]).to.equal("Inner")
        u9.unmountVirtualTree(v110)
    end)
    it("should not include the ref in the forwarded props", function() --[[ Line: 322 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u8
            [3] = u4
            [4] = u1
            [5] = u3
            [6] = u9
        --]]
        local u111 = nil
        local function u113(p112) --[[ Line: 324 ]]
            --[[
            Upvalues:
                [1] = u111
                [2] = u2
                [3] = u8
            --]]
            u111 = p112
            return u2("Frame", {
                [u8] = p112.forwardedRef
            })
        end
        local v116 = u4(function(p114, p115) --[[ Line: 329 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u113
                [3] = u1
            --]]
            return u2(u113, u1({}, p114, {
                ["forwardedRef"] = p115
            }))
        end)
        local v117 = u3()
        local v118 = u2(v116, {
            [u8] = v117
        })
        local v119 = u9.mountVirtualTree(v118, nil, "no ref in props")
        expect(u111).to.be.ok()
        expect(u111.forwardedRef).to.equal(v117)
        expect(u111[u8]).to.equal(nil)
        u9.unmountVirtualTree(v119)
    end)
end
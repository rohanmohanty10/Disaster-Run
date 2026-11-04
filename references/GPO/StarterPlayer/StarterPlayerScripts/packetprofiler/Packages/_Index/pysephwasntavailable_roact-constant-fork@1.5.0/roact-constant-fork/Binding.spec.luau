 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createSpy)
    local u2 = require(script.Parent.Type)
    local u3 = require(script.Parent.GlobalConfig)
    local u4 = require(script.Parent.Binding)
    describe("Binding.create", function() --[[ Line: 8 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
        --]]
        it("should return a Binding object and an update function", function() --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v5, v6 = u4.create(1)
            expect(u2.of(v5)).to.equal(u2.Binding)
            expect((typeof(v6))).to.equal("function")
        end)
        it("should support tostring on bindings", function() --[[ Line: 16 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v7, v8 = u4.create(1)
            expect((tostring(v7))).to.equal("RoactBinding(1)")
            v8("foo")
            expect((tostring(v7))).to.equal("RoactBinding(foo)")
        end)
    end)
    describe("Binding object", function() --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
        --]]
        it("should provide a getter and setter", function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v9, v10 = u4.create(1)
            expect(v9:getValue()).to.equal(1)
            v10(3)
            expect(v9:getValue()).to.equal(3)
        end)
        it("should let users subscribe and unsubscribe to its updates", function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u1
            --]]
            local v11, v12 = u4.create(1)
            local v13 = u1()
            local v14 = u4.subscribe(v11, v13.value)
            expect(v13.callCount).to.equal(0)
            v12(2)
            expect(v13.callCount).to.equal(1)
            v13:assertCalledWith(2)
            v14()
            v12(3)
            expect(v13.callCount).to.equal(1)
        end)
    end)
    describe("Mapped bindings", function() --[[ Line: 56 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
        --]]
        it("should be composable", function() --[[ Line: 57 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v15, v16 = u4.create("hi")
            local v17 = v15:map(string.len)
            local v19 = v17:map(function(p18) --[[ Line: 61 ]]
                return p18 % 2 == 0
            end)
            expect(v15:getValue()).to.equal("hi")
            expect(v17:getValue()).to.equal(2)
            expect(v19:getValue()).to.equal(true)
            v16("sup")
            expect(v15:getValue()).to.equal("sup")
            expect(v17:getValue()).to.equal(3)
            expect(v19:getValue()).to.equal(false)
        end)
        it("should cascade updates when subscribed", function() --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u1
            --]]
            local v20, v21 = u4.create("hi")
            local v22 = u1()
            local v23 = u4.subscribe(v20, v22.value)
            local v24 = v20:map(string.len)
            local v25 = u1()
            local v26 = u4.subscribe(v24, v25.value)
            local v28 = v24:map(function(p27) --[[ Line: 90 ]]
                return p27 % 2 == 0
            end)
            local v29 = u1()
            local v30 = u4.subscribe(v28, v29.value)
            expect(v22.callCount).to.equal(0)
            expect(v25.callCount).to.equal(0)
            expect(v29.callCount).to.equal(0)
            v21("nice")
            expect(v22.callCount).to.equal(1)
            v22:assertCalledWith("nice")
            expect(v25.callCount).to.equal(1)
            v25:assertCalledWith(4)
            expect(v29.callCount).to.equal(1)
            v29:assertCalledWith(true)
            v23()
            v26()
            v30()
            v21("goodbye")
            expect(v22.callCount).to.equal(1)
            expect(v29.callCount).to.equal(1)
            expect(v25.callCount).to.equal(1)
        end)
        it("should throw when updated directly", function() --[[ Line: 123 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local u32 = u4.create(1):map(function(p31) --[[ Line: 125 ]]
                return p31
            end)
            expect(function() --[[ Line: 129 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u32
                --]]
                u4.update(u32, 5)
            end).to.throw()
        end)
    end)
    describe("Binding.join", function() --[[ Line: 135 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u3
        --]]
        it("should have getValue", function() --[[ Line: 136 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v33 = {
                u4.create(1),
                u4.create(2),
                ["foo"] = u4.create(3)
            }
            local v34 = u4.join(v33):getValue()
            expect(v34).to.be.a("table")
            expect(v34[1]).to.equal(1)
            expect(v34[2]).to.equal(2)
            expect(v34.foo).to.equal(3)
        end)
        it("should update when any one of the subscribed bindings updates", function() --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u1
            --]]
            local v35, v36 = u4.create(1)
            local v37, v38 = u4.create(2)
            local v39, v40 = u4.create(3)
            local v41 = u4.join({
                v35,
                v37,
                ["foo"] = v39
            })
            local v42 = u1()
            u4.subscribe(v41, v42.value)
            expect(v42.callCount).to.equal(0)
            v36(3)
            expect(v42.callCount).to.equal(1)
            local v43 = v42:captureValues("value")
            expect(v43.value).to.be.a("table")
            expect(v43.value[1]).to.equal(3)
            expect(v43.value[2]).to.equal(2)
            expect(v43.value.foo).to.equal(3)
            v38(4)
            expect(v42.callCount).to.equal(2)
            local v44 = v42:captureValues("value")
            expect(v44.value).to.be.a("table")
            expect(v44.value[1]).to.equal(3)
            expect(v44.value[2]).to.equal(4)
            expect(v44.value.foo).to.equal(3)
            v40(8)
            expect(v42.callCount).to.equal(3)
            local v45 = v42:captureValues("value")
            expect(v45.value).to.be.a("table")
            expect(v45.value[1]).to.equal(3)
            expect(v45.value[2]).to.equal(4)
            expect(v45.value.foo).to.equal(8)
        end)
        it("should disconnect from all upstream bindings", function() --[[ Line: 198 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u1
            --]]
            local v46, v47 = u4.create(1)
            local v48, v49 = u4.create(2)
            local v50 = u4.join({ v46, v48 })
            local v51 = u1()
            local v52 = u4.subscribe(v50, v51.value)
            expect(v51.callCount).to.equal(0)
            v47(3)
            expect(v51.callCount).to.equal(1)
            v49(3)
            expect(v51.callCount).to.equal(2)
            v52()
            v47(4)
            expect(v51.callCount).to.equal(2)
            v49(2)
            expect(v51.callCount).to.equal(2)
            local v53 = v50:getValue()
            expect(v53[1]).to.equal(4)
            expect(v53[2]).to.equal(2)
        end)
        it("should be okay with calling disconnect multiple times", function() --[[ Line: 227 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v54 = u4.join({})
            local v55 = u4.subscribe(v54, function() --[[ Line: 230 ]] end)
            v55()
            v55()
        end)
        it("should throw if updated directly", function() --[[ Line: 236 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local u56 = u4.join({})
            expect(function() --[[ Line: 239 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u56
                --]]
                u4.update(u56, 0)
            end)
        end)
        it("should throw when a non-table value is passed", function() --[[ Line: 244 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
            --]]
            u3.scoped({
                ["typeChecks"] = true
            }, function() --[[ Line: 247 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                expect(function() --[[ Line: 248 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    u4.join("hi")
                end).to.throw()
            end)
        end)
        it("should throw when a non-binding value is passed via table", function() --[[ Line: 254 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
            --]]
            u3.scoped({
                ["typeChecks"] = true
            }, function() --[[ Line: 257 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                expect(function() --[[ Line: 258 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                    --]]
                    local v57 = { u4.create(123), "abcde" }
                    u4.join(v57)
                end).to.throw()
            end)
        end)
    end)
end
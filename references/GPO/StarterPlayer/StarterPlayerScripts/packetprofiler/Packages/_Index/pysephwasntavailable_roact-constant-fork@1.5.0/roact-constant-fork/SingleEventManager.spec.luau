 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.assertDeepEqual)
    local u2 = require(script.Parent.createSpy)
    local u3 = require(script.Parent.Logging)
    local u4 = require(script.Parent.SingleEventManager)
    describe("new", function() --[[ Line: 8 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        it("should create a SingleEventManager", function() --[[ Line: 9 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v5 = u4.new()
            expect(v5).to.be.ok()
        end)
    end)
    describe("connectEvent", function() --[[ Line: 16 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
            [3] = u1
            [4] = u3
        --]]
        it("should connect to events", function() --[[ Line: 17 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v6 = Instance.new("BindableEvent")
            local v7 = u4.new(v6)
            local v8 = u2()
            v7:connectEvent("Event", v8.value)
            v7:resume()
            v6:Fire("foo")
            expect(v8.callCount).to.equal(1)
            v8:assertCalledWith(v6, "foo")
            v6:Fire("bar")
            expect(v8.callCount).to.equal(2)
            v8:assertCalledWith(v6, "bar")
            v7:connectEvent("Event", nil)
            v6:Fire("baz")
            expect(v8.callCount).to.equal(2)
        end)
        it("should drop events until resumed initially", function() --[[ Line: 39 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v9 = Instance.new("BindableEvent")
            local v10 = u4.new(v9)
            local v11 = u2()
            v10:connectEvent("Event", v11.value)
            v9:Fire("foo")
            expect(v11.callCount).to.equal(0)
            v10:resume()
            v9:Fire("bar")
            expect(v11.callCount).to.equal(1)
            v11:assertCalledWith(v9, "bar")
        end)
        it("should invoke suspended events when resumed", function() --[[ Line: 56 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v12 = Instance.new("BindableEvent")
            local v13 = u4.new(v12)
            local v14 = u2()
            v13:connectEvent("Event", v14.value)
            v13:resume()
            v12:Fire("foo")
            expect(v14.callCount).to.equal(1)
            v14:assertCalledWith(v12, "foo")
            v13:suspend()
            v12:Fire("bar")
            expect(v14.callCount).to.equal(1)
            v13:resume()
            expect(v14.callCount).to.equal(2)
            v14:assertCalledWith(v12, "bar")
        end)
        it("should invoke events triggered during resumption in the correct order", function() --[[ Line: 78 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
                [3] = u1
            --]]
            local u15 = Instance.new("BindableEvent")
            local v16 = u4.new(u15)
            local u17 = {}
            local v20 = u2(function(_, p18) --[[ Line: 83 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u15
                --]]
                local v19 = u17
                table.insert(v19, p18)
                if p18 == 2 then
                    u15:Fire(3)
                elseif p18 == 3 then
                    u15:Fire(4)
                end
            end)
            v16:connectEvent("Event", v20.value)
            v16:suspend()
            u15:Fire(1)
            u15:Fire(2)
            v16:resume()
            expect(v20.callCount).to.equal(4)
            u1(u17, {
                1,
                2,
                3,
                4
            })
        end)
        it("should not invoke events fired during suspension but disconnected before resumption", function() --[[ Line: 104 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v21 = Instance.new("BindableEvent")
            local v22 = u4.new(v21)
            local v23 = u2()
            v22:connectEvent("Event", v23.value)
            v22:suspend()
            v21:Fire(1)
            v22:connectEvent("Event", nil)
            v22:resume()
            expect(v23.callCount).to.equal(0)
        end)
        it("should not yield events through the SingleEventManager when resuming", function() --[[ Line: 120 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local u24 = Instance.new("BindableEvent")
            local u25 = u4.new(u24)
            u25:connectEvent("Event", function() --[[ Line: 124 ]]
                coroutine.yield()
            end)
            u25:resume()
            local v26 = coroutine.create(function() --[[ Line: 130 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24:Fire(5)
            end)
            local v27 = coroutine.resume
            assert(v27(v26))
            expect(coroutine.status(v26)).to.equal("dead")
            u25:suspend()
            u24:Fire(5)
            local v28 = coroutine.create(function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25:resume()
            end)
            local v29 = coroutine.resume
            assert(v29(v28))
            expect(coroutine.status(v28)).to.equal("dead")
        end)
        it("should not throw errors through SingleEventManager when resuming", function() --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
            --]]
            local v30 = Instance.new("BindableEvent")
            local u31 = u4.new(v30)
            u31:connectEvent("Event", function() --[[ Line: 154 ]]
                error("Error from SingleEventManager test")
            end)
            u31:resume()
            u31:suspend()
            v30:Fire(5)
            local v32 = u3.capture(function() --[[ Line: 167 ]]
                --[[
                Upvalues:
                    [1] = u31
                --]]
                u31:resume()
            end)
            expect(#v32.errors).to.equal(0)
            expect(#v32.warnings).to.equal(1)
            expect(#v32.infos).to.equal(0)
            expect(v32.warnings[1]:find("Error from SingleEventManager test")).to.be.ok()
        end)
        it("should not overflow with events if manager:resume() is invoked when resuming a suspended event", function() --[[ Line: 178 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local u33 = Instance.new("BindableEvent")
            local u34 = u4.new(u33)
            local v36 = u2(function(_, p35) --[[ Line: 186 ]]
                --[[
                Upvalues:
                    [1] = u34
                    [2] = u33
                --]]
                if p35 == 1 then
                    u34:suspend()
                    u33:Fire(2)
                    u34:resume()
                end
            end)
            u34:connectEvent("Event", v36.value)
            u34:suspend()
            u33:Fire(1)
            u34:resume()
            expect(v36.callCount).to.equal(2)
        end)
    end)
    describe("connectPropertyChange", function() --[[ Line: 204 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u2
        --]]
        it("should connect to property changes", function() --[[ Line: 208 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u2
            --]]
            local v37 = Instance.new("Folder")
            local v38 = u4.new(v37)
            local v39 = u2()
            v38:connectPropertyChange("Name", v39.value)
            v38:resume()
            v37.Name = "foo"
            expect(v39.callCount).to.equal(1)
            v39:assertCalledWith(v37)
            v37.Name = "bar"
            expect(v39.callCount).to.equal(2)
            v39:assertCalledWith(v37)
            v38:connectPropertyChange("Name")
            v37.Name = "baz"
            expect(v39.callCount).to.equal(2)
        end)
        it("should throw an error if the property is invalid", function() --[[ Line: 230 ]]
            --[[
            Upvalues:
                [1] = u4
            --]]
            local v40 = Instance.new("Folder")
            local u41 = u4.new(v40)
            expect(function() --[[ Line: 234 ]]
                --[[
                Upvalues:
                    [1] = u41
                --]]
                u41:connectPropertyChange("foo", function() --[[ Line: 235 ]] end)
            end).to.throw()
        end)
    end)
end
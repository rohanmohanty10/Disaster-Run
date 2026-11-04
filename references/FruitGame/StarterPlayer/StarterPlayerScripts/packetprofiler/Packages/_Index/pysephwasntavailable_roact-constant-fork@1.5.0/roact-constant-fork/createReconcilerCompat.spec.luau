 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createElement)
    local v2 = require(script.Parent.createReconciler)
    local u3 = require(script.Parent.Logging)
    local v4 = require(script.Parent.NoopRenderer)
    local v5 = require(script.Parent.createReconcilerCompat)
    local u6 = v2(v4)
    local u7 = v5(u6)
    it("reify should only warn once per call site", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u7
            [3] = u1
            [4] = u6
        --]]
        local v10 = u3.capture(function() --[[ Line: 13 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u1
                [3] = u6
            --]]
            local v8 = u7.reify(u1("StringValue"))
            u6.unmountVirtualTree(v8)
            local v9 = u7.reify(u1("StringValue"))
            u6.unmountVirtualTree(v9)
        end)
        expect(#v10.warnings).to.equal(1)
        expect(v10.warnings[1]:find("reify")).to.be.ok()
        local v12 = u3.capture(function() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u1
                [3] = u6
            --]]
            local v11 = u7.reify(u1("StringValue"))
            u6.unmountVirtualTree(v11)
        end)
        expect(#v12.warnings).to.equal(1)
        expect(v12.warnings[1]:find("reify")).to.be.ok()
    end)
    it("teardown should only warn once per call site", function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u6
            [3] = u1
            [4] = u7
        --]]
        local v15 = u3.capture(function() --[[ Line: 36 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v13 = u6.mountVirtualTree(u1("StringValue"))
            u7.teardown(v13)
            local v14 = u6.mountVirtualTree(u1("StringValue"))
            u7.teardown(v14)
        end)
        expect(#v15.warnings).to.equal(1)
        expect(v15.warnings[1]:find("teardown")).to.be.ok()
        local v17 = u3.capture(function() --[[ Line: 48 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v16 = u6.mountVirtualTree(u1("StringValue"))
            u7.teardown(v16)
        end)
        expect(#v17.warnings).to.equal(1)
        expect(v17.warnings[1]:find("teardown")).to.be.ok()
    end)
    it("update should only warn once per call site", function() --[[ Line: 58 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u6
            [3] = u1
            [4] = u7
        --]]
        local v19 = u3.capture(function() --[[ Line: 59 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            for _ = 1, 2 do
                local v18 = u6.mountVirtualTree(u1("StringValue"))
                u7.reconcile(v18, u1("StringValue"))
                u6.unmountVirtualTree(v18)
            end
        end)
        expect(#v19.warnings).to.equal(1)
        expect(v19.warnings[1]:find("reconcile")).to.be.ok()
        local v21 = u3.capture(function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u6
                [2] = u1
                [3] = u7
            --]]
            local v20 = u6.mountVirtualTree(u1("StringValue"))
            u7.reconcile(v20, u1("StringValue"))
            u6.unmountVirtualTree(v20)
        end)
        expect(#v21.warnings).to.equal(1)
        expect(v21.warnings[1]:find("reconcile")).to.be.ok()
    end)
end
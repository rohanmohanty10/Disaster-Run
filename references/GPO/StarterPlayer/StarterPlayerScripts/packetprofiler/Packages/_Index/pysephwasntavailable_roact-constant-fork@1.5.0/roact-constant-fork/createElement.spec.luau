 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Component)
    local u2 = require(script.Parent.ElementKind)
    local u3 = require(script.Parent.GlobalConfig)
    local u4 = require(script.Parent.Logging)
    local u5 = require(script.Parent.Type)
    local u6 = require(script.Parent.Portal)
    local u7 = require(script.Parent.PropMarkers.Children)
    local u8 = require(script.Parent.createElement)
    it("should create new primitive elements", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u5
            [3] = u2
        --]]
        local v9 = u8("Frame")
        expect(v9).to.be.ok()
        expect(u5.of(v9)).to.equal(u5.Element)
        expect(u2.of(v9)).to.equal(u2.Host)
    end)
    it("should create new functional elements", function() --[[ Line: 20 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u5
            [3] = u2
        --]]
        local v10 = u8(function() --[[ Line: 21 ]] end)
        expect(v10).to.be.ok()
        expect(u5.of(v10)).to.equal(u5.Element)
        expect(u2.of(v10)).to.equal(u2.Function)
    end)
    it("should create new stateful components", function() --[[ Line: 28 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u8
            [3] = u5
            [4] = u2
        --]]
        local v11 = u8((u1:extend("Foo")))
        expect(v11).to.be.ok()
        expect(u5.of(v11)).to.equal(u5.Element)
        expect(u2.of(v11)).to.equal(u2.Stateful)
    end)
    it("should create new portal elements", function() --[[ Line: 38 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u6
            [3] = u5
            [4] = u2
        --]]
        local v12 = u8(u6)
        expect(v12).to.be.ok()
        expect(u5.of(v12)).to.equal(u5.Element)
        expect(u2.of(v12)).to.equal(u2.Portal)
    end)
    it("should accept props", function() --[[ Line: 46 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        local v13 = u8("StringValue", {
            ["Value"] = "Foo"
        })
        expect(v13).to.be.ok()
        expect(v13.props.Value).to.equal("Foo")
    end)
    it("should accept props and children", function() --[[ Line: 55 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u7
        --]]
        local v14 = u8("IntValue")
        local v15 = u8("StringValue", {
            ["Value"] = "Foo"
        }, {
            ["Child"] = v14
        })
        expect(v15).to.be.ok()
        expect(v15.props.Value).to.equal("Foo")
        expect(v15.props[u7]).to.be.ok()
        expect(v15.props[u7].Child).to.equal(v14)
    end)
    it("should accept children with without props", function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u7
        --]]
        local v16 = u8("IntValue")
        local v17 = u8("StringValue", nil, {
            ["Child"] = v16
        })
        expect(v17).to.be.ok()
        expect(v17.props[u7]).to.be.ok()
        expect(v17.props[u7].Child).to.equal(v16)
    end)
    it("should warn once if children is specified in two different ways", function() --[[ Line: 82 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u8
            [3] = u7
        --]]
        local v18 = u4.capture(function() --[[ Line: 83 ]]
            --[[
            Upvalues:
                [1] = u8
                [2] = u7
            --]]
            for _ = 1, 2 do
                u8("Frame", {
                    [u7] = {}
                }, {})
            end
        end)
        expect(#v18.warnings).to.equal(1)
        expect(v18.warnings[1]:find("createElement")).to.be.ok()
        expect(v18.warnings[1]:find("Children")).to.be.ok()
    end)
    it("should have a `source` member if elementTracing is set", function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u8
        --]]
        u3.scoped({
            ["elementTracing"] = true
        }, function() --[[ Line: 103 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            local v19 = u8("StringValue")
            expect(v19.source).to.be.a("string")
        end)
    end)
end
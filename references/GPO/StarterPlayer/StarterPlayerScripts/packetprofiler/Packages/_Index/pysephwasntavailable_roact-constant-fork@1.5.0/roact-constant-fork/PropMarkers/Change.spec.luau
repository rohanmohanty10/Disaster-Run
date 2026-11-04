 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.Parent.Type)
    local u2 = require(script.Parent.Change)
    it("should yield change listener objects when indexed", function() --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        expect(u1.of(u2.Text)).to.equal(u1.HostChangeEvent)
        expect(u1.of(u2.Selected)).to.equal(u1.HostChangeEvent)
    end)
    it("should yield the same object when indexed again", function() --[[ Line: 11 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v3 = u2.Text
        local v4 = u2.Text
        local v5 = u2.Selected
        expect(v3).to.equal(v4)
        expect(v3).never.to.equal(v5)
    end)
end
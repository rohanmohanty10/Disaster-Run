 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.GlobalConfig)
    it("should have the correct methods", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        expect(u1).to.be.ok()
        expect(u1.set).to.be.ok()
        expect(u1.get).to.be.ok()
    end)
end
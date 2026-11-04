 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.createElement)
    local u2 = require(script.Parent.oneChild)
    it("should get zero children from a table", function() --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        expect(u2({})).to.equal(nil)
    end)
    it("should get exactly one child", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v3 = u1("Frame")
        expect(u2({
            ["foo"] = v3
        })).to.equal(v3)
    end)
    it("should error with more than one child", function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local u4 = {
            ["a"] = u1("Frame"),
            ["b"] = u1("Frame")
        }
        expect(function() --[[ Line: 27 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u4
            --]]
            u2(u4)
        end).to.throw()
    end)
    it("should handle being passed nil", function() --[[ Line: 32 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        expect(u2(nil)).to.equal(nil)
    end)
end
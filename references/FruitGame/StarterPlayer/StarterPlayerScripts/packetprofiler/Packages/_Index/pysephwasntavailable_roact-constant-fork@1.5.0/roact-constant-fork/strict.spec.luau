 

return function() --[[ Line: 1 ]]
    local u1 = require(script.Parent.strict)
    it("should error when getting a nonexistent key", function() --[[ Line: 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u2 = u1({
            ["a"] = 1,
            ["b"] = 2
        })
        expect(function() --[[ Line: 10 ]]
            --[[
            Upvalues:
                [1] = u2
            --]]
            return u2.c
        end).to.throw()
    end)
    it("should error when setting a nonexistent key", function() --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = u1({
            ["a"] = 1,
            ["b"] = 2
        })
        expect(function() --[[ Line: 21 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            u3.c = 3
        end).to.throw()
    end)
end
 

local u1 = require(game:GetService("ServerScriptService"):FindFirstChild("LoaderUtils", true).Parent).load(script)("RxInstanceUtils")
return function() --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    describe("RxInstanceUtils.observeChildrenBrio", function() --[[ Line: 10 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = Instance.new("Part")
        local u3 = u1.observeChildrenBrio(v2)
        local u4 = nil
        it("should not emit anything", function() --[[ Line: 15 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u4
            --]]
            u3:Subscribe(function(p5) --[[ Line: 16 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                u4 = p5
            end)
            expect(u4).to.equal(nil)
        end)
    end)
end
 

local u1 = require(script.Parent:WaitForChild("RopeConstraint"))
return function() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u2 = {
        ["Bones"] = {
            {
                ["Position"] = Vector3.new(0, 0, 0),
                ["FreeLength"] = 3,
                ["ParentIndex"] = 0
            },
            {
                ["Position"] = Vector3.new(0, 10, 0),
                ["FreeLength"] = 3,
                ["ParentIndex"] = 1
            }
        }
    }
    describe("Rope Constraint", function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local u3 = u2.Bones[2]
        local u4 = 0
        local u5 = nil
        local function u7() --[[ Line: 25 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
                [3] = u2
                [4] = u5
            --]]
            local v6 = u1(u3, u3.Position, u2)
            expect(v6.Magnitude).to.equal(u3.FreeLength)
            u3.FreeLength = math.random(1, 20)
            u5()
        end
        local function u9() --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
                [3] = u2
                [4] = u5
            --]]
            local v8 = u1(u3, u3.Position, u2)
            expect(v8.Magnitude).to.equal(u3.Position.Magnitude)
            u3.FreeLength = math.random(1, 20)
            u5()
        end
        u5 = function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u4
                [2] = u3
                [3] = u9
                [4] = u7
            --]]
            if u4 >= 10 then
                return
            else
                u4 = u4 + 1
                if u3.Position.Magnitude < u3.FreeLength then
                    it(("Should stay the same #%*"):format(u4), u9)
                else
                    it(("Should limit to %* studs #%*"):format(u3.FreeLength, u4), u7)
                end
            end
        end
        u5()
    end)
end
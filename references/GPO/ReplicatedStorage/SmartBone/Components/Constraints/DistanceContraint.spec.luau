 

local u1 = require(script.Parent:WaitForChild("DistanceConstraint"))
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
                ["Position"] = Vector3.new(0, 1, 0),
                ["FreeLength"] = 3,
                ["ParentIndex"] = 1
            }
        }
    }
    describe("Distance Constraint", function() --[[ Line: 19 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local u3 = u2.Bones[2]
        local function v5() --[[ Line: 22 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
                [3] = u2
            --]]
            local v4 = u1(u3, u3.Position, u2)
            expect(v4.Magnitude).to.equal(u3.FreeLength)
            u3.Position = v4
        end
        for v6 = 1, 10 do
            it(("Should limit to %* studs #%*"):format(u3.FreeLength, v6), v5)
            u3.FreeLength = math.random(1, 20)
        end
    end)
end
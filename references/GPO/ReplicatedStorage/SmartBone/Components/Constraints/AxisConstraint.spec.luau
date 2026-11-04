 

local u1 = require(script.Parent:WaitForChild("AxisConstraint"))
return function() --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u2 = {
        ["Radius"] = 0,
        ["XAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["YAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["ZAxisLimits"] = NumberRange.new((-1 / 0), (1 / 0)),
        ["AxisLocked"] = { false, false, false },
        ["ClipVelocity"] = function() --[[ Name: ClipVelocity, Line 10 ]] end
    }
    afterEach(function() --[[ Line: 13 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2.AxisLocked = { false, false, false }
    end)
    describe("Axis Lock", function() --[[ Line: 17 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        it("Should lock X Axis", function() --[[ Line: 18 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            u2.AxisLocked = { true, false, false }
            local v3 = u1(u2, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity)
            expect(v3.X).to.equal(0)
        end)
        it("Should lock Y Axis", function() --[[ Line: 26 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            u2.AxisLocked = { false, true, false }
            local v4 = u1(u2, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity)
            expect(v4.Y).to.equal(0)
        end)
        it("Should lock Z Axis", function() --[[ Line: 34 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            u2.AxisLocked = { false, false, true }
            local v5 = u1(u2, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity)
            expect(v5.Z).to.equal(0)
        end)
    end)
    describe("Axis Limit", function() --[[ Line: 43 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        describe("Should limit X Axis", function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            it("Min Limit", function() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.XAxisLimits = NumberRange.new(-5, (1 / 0))
                local v6 = u1(u2, Vector3.new(-10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v6.X).to.equal(-5)
            end)
            it("Max Limit", function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.XAxisLimits = NumberRange.new((-1 / 0), 5)
                local v7 = u1(u2, Vector3.new(10, 0, 0), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v7.X).to.equal(5)
            end)
        end)
        describe("Should limit Y Axis", function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            it("Min Limit", function() --[[ Line: 63 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.YAxisLimits = NumberRange.new(-5, (1 / 0))
                local v8 = u1(u2, Vector3.new(0, -10, 0), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v8.Y).to.equal(-5)
            end)
            it("Max Limit", function() --[[ Line: 71 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.YAxisLimits = NumberRange.new((-1 / 0), 5)
                local v9 = u1(u2, Vector3.new(0, 10, 0), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v9.Y).to.equal(5)
            end)
        end)
        describe("Should limit Z Axis", function() --[[ Line: 80 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            it("Min Limit", function() --[[ Line: 81 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.ZAxisLimits = NumberRange.new(-5, (1 / 0))
                local v10 = u1(u2, Vector3.new(0, 0, -10), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v10.Z).to.equal(-5)
            end)
            it("Max Limit", function() --[[ Line: 89 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u1
                --]]
                u2.ZAxisLimits = NumberRange.new((-1 / 0), 5)
                local v11 = u1(u2, Vector3.new(0, 0, 10), Vector3.new(0, 0, 0), CFrame.identity)
                expect(v11.Z).to.equal(5)
            end)
        end)
    end)
end
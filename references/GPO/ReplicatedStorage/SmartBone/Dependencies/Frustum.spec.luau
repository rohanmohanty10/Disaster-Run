 

local u1 = require(script.Parent:WaitForChild("Frustum"))
return function() --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u2 = {
        ["CFrame"] = CFrame.identity,
        ["FieldOfView"] = 70,
        ["ViewportSize"] = Vector2.new(1920, 1080)
    }
    local u3 = {}
    describe("Generates CFrames", function() --[[ Line: 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        local v4 = os.clock()
        u3 = table.pack(u1.GetCFrames(u2, 500))
        local v5 = os.clock()
        u3.n = nil
        print((("Solved view frustum in %*\206\188s"):format((string.format("%.2f", (v5 - v4) * 1000000)))))
    end)
    describe("Point In View", function() --[[ Line: 24 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        it("Close In View Point", function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
            --]]
            local v6 = u3
            expect(u1.InViewFrustum(Vector3.new(0, 0, -5), table.unpack(v6))).to.equal(true)
        end)
        it("Past FarPlane Point", function() --[[ Line: 33 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
            --]]
            local v7 = u3
            expect(u1.InViewFrustum(Vector3.new(0, 0, -550), table.unpack(v7))).to.equal(false)
        end)
        it("Out Of View Point", function() --[[ Line: 37 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u3
            --]]
            local v8 = u3
            expect(u1.InViewFrustum(Vector3.new(0, 0, 5), table.unpack(v8))).to.equal(false)
        end)
    end)
    describe("Object In View", function() --[[ Line: 42 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
        --]]
        local u9 = {
            ["CFrame"] = CFrame.new(0, 0, -5),
            ["Size"] = Vector3.new(1, 1, 3)
        }
        local u10 = {
            ["CFrame"] = CFrame.new(0, 0, -550),
            ["Size"] = Vector3.new(1, 1, 3)
        }
        local u11 = {
            ["CFrame"] = CFrame.new(0, 0, 5),
            ["Size"] = Vector3.new(1, 1, 3)
        }
        it("Close In View Object", function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u9
                [3] = u3
            --]]
            local v12 = u3
            expect(u1.ObjectInFrustum(u9, table.unpack(v12))).to.equal(true)
        end)
        it("Past FarPlane Object", function() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u10
                [3] = u3
            --]]
            local v13 = u3
            expect(u1.ObjectInFrustum(u10, table.unpack(v13))).to.equal(false)
        end)
        it("Out Of View Object", function() --[[ Line: 66 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u11
                [3] = u3
            --]]
            local v14 = u3
            expect(u1.ObjectInFrustum(u11, table.unpack(v14))).to.equal(false)
        end)
    end)
end
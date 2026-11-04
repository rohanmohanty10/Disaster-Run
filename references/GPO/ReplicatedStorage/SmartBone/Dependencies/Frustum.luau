 

local v1 = script.Parent
local u2 = require(v1:WaitForChild("Config"))
local u3 = require(v1:WaitForChild("Utilities"))
local u4 = math.tan
local u5 = CFrame.new
local u6 = Vector3.new
local u52 = {
    ["GetCFrames"] = function(p7, p8) --[[ Name: GetCFrames, Line 12 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u6
        --]]
        local v9 = p7.CFrame
        local v10 = v9.Position
        local v11 = v9.RightVector
        local v12 = v9.UpVector
        local v13 = p8 * 0.5
        local v14 = u4((p7.FieldOfView + 5) * 0.5 * 0.017453) * p8
        local v15 = v14 * (p7.ViewportSize.X / p7.ViewportSize.Y)
        local v16 = v9 * u5(0, 0, -p8)
        local v17 = v16 * u6(v15, v14, 0)
        local v18 = v16 * u6(-v15, -v14, 0)
        local v19 = v16 * u6(v15, -v14, 0)
        return (v9 * u5(0, 0, -v13)):Inverse(), v15, v14, v13, v12:Cross(v19 - v10).Unit, v12:Cross(v18 - v10).Unit, v11:Cross(v10 - v17).Unit, v11:Cross(v10 - v19).Unit, v9
    end,
    ["InViewFrustum"] = function(p20, p21, p22, p23, p24, p25, p26, p27, p28, p29) --[[ Name: InViewFrustum, Line 35 ]]
        local v30 = p29.Position
        local v31 = p21 * p20
        if p22 < v31.X or (v31.X < -p22 or (p23 < v31.Y or (v31.Y < -p23 or (p24 < v31.Z or v31.Z < -p24)))) then
            return false
        end
        local v32 = p20 - v30
        return p25:Dot(v32) >= 0 and (p26:Dot(v32) <= 0 and (p27:Dot(v32) >= 0 and p28:Dot(v32) <= 0))
    end,
    ["ObjectInFrustum"] = function(p33, p34, p35, p36, p37, p38, p39, p40, p41, p42) --[[ Name: ObjectInFrustum, Line 76 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u52
        --]]
        local v43 = p33.CFrame
        local v44 = p33.Size
        local v45 = u2.FAR_PLANE * 0.5
        local v46 = p42.Position
        local v47 = p42.LookVector
        local v48 = v46 + v47 * v45
        local v49 = u3.ClosestPointOnLine(v48, v47, v45, v43.Position)
        local v50, v51 = u3.ClosestPointInBox(v43, v44, v49)
        return v50 and true or u52.InViewFrustum(v51, p34, p35, p36, p37, p38, p39, p40, p41, p42)
    end
}
return u52
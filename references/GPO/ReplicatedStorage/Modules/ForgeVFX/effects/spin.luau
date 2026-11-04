 

local u1 = require("../mod/attributes")
local u2 = require("../mod/tween")
require("../types")
local u3 = require("../mod/utility")
return {
    ["emit"] = function(u4, p5) --[[ Name: emit, Line 8 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u1
            [3] = u2
        --]]
        if not u3.isSpinModelStatic(u4) then
            local v6 = u1.get(u4, "SpinRotation", Vector3.new(0, 0, 0)) * u3.DEG_TO_RAD
            local u7 = u1.get(u4, "Scale_Start", 1)
            local u8 = u1.get(u4, "Scale_End", 1)
            local v9 = u1.get(u4, "EmitDelay", 0)
            local v10 = u1.get(u4, "ResetDelay", 0)
            local v11 = u1.get(u4, "ResetOnFinish", true)
            local u12 = u1.get(u4, "SyncPosition", false)
            local u13 = u1.get(u4, "SpinDuration", 0.5)
            local v14 = u1.get(u4, "SpinSpeed_Duration", 0.1)
            local u15 = u1.get(u4, "SpinSpeed_Start", 0)
            local u16 = u1.get(u4, "SpinSpeed_End", 1)
            local u17 = u15
            task.wait(v9)
            local u18
            if u15 == u16 then
                u18 = nil
            else
                u18 = u2.fromParams(u1.get(u4, "SpinSpeed_Curve", u3.default_bezier), v14, function(p19, p20) --[[ Line: 40 ]]
                    --[[
                    Upvalues:
                        [1] = u17
                        [2] = u3
                        [3] = u15
                        [4] = u16
                    --]]
                    u17 = u3.lerp(u15, u16, p19)
                    return p20
                end)
                table.insert(p5, u18)
            end
            local u21 = u4:GetPivot()
            local u22 = u4:GetScale()
            if u7 == u8 then
                u4:ScaleTo(u7)
            else
                local v23 = u2.fromParams
                local v24 = u1.get(u4, "Scale_Curve", u3.default_bezier)
                local function v27(p25, p26) --[[ Line: 55 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u3
                        [3] = u7
                        [4] = u8
                    --]]
                    u4:ScaleTo(u3.lerp(u7, u8, p25))
                    return p26
                end
                table.insert(p5, v23(v24, u13, v27))
            end
            local u28 = u4:FindFirstAncestorOfClass("Attachment") or u4:FindFirstAncestorWhichIsA("BasePart")
            if v11 then
                local function v29() --[[ Line: 67 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u28
                        [3] = u3
                        [4] = u21
                        [5] = u22
                    --]]
                    u4:PivotTo(u28 and u3.getTransformedOriginExtents(u28) or u21)
                    u4:ScaleTo(u22)
                end
                table.insert(p5, v29)
            end
            local u30 = v6 * u13
            u2.timer(u13 + v10, function(p31, p32) --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u30
                    [3] = u28
                    [4] = u12
                    [5] = u3
                    [6] = u21
                    [7] = u4
                    [8] = u17
                    [9] = u18
                --]]
                local v33 = p32 / u13
                local v34 = u30 * math.clamp(v33, 0, 1)
                local v35
                if u28 and u12 then
                    v35 = u3.getTransformedOriginExtents(u28)
                else
                    v35 = u21
                end
                u4:PivotTo(v35 * CFrame.fromOrientation(v34.x, v34.y, v34.z))
                if u17 > 0 or p32 > 0 and u18.Connected then
                    return p31 * u17
                else
                    return nil
                end
            end, u18, p5, u3.RENDER_PRIORITY + p5.depth)
        end
    end
}
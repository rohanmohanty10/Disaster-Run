 

local u1 = require("./mod/tween")
local u2 = require("./mod/utility")
return {
    ["emit"] = function(u3, p4) --[[ Name: emit, Line 6 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        local v5 = u2.getAttribute(u3, "SpinRotation", Vector3.new(0, 0, 0), true) * u2.DEG_TO_RAD
        local u6 = u2.getAttribute(u3, "Scale_Start", 1, true)
        local u7 = u2.getAttribute(u3, "Scale_End", 1, true)
        if v5 ~= Vector3.new(0, 0, 0) or (u6 ~= 1 or u7 ~= 1) then
            local v8 = u2.getAttribute(u3, "EmitDelay", 0)
            local u9 = u2.getAttribute(u3, "SyncPosition", false)
            local u10 = u2.getAttribute(u3, "SpinDuration", 0.5)
            local v11 = u2.getAttribute(u3, "SpinSpeed_Duration", 0.1)
            local u12 = u2.getAttribute(u3, "SpinSpeed_Start", 0)
            local u13 = u2.getAttribute(u3, "SpinSpeed_End", 1)
            local u14 = u12
            task.wait(v8)
            local u15
            if u12 == u13 then
                u15 = nil
            else
                u15 = u1.fromParams(u2.getAttribute(u3, "SpinSpeed_Curve", u2.default_bezier), v11, function(p16, p17) --[[ Line: 36 ]]
                    --[[
                    Upvalues:
                        [1] = u14
                        [2] = u2
                        [3] = u12
                        [4] = u13
                    --]]
                    u14 = u2.lerp(u12, u13, p16)
                    return p17
                end)
                table.insert(p4, u15)
            end
            local u18 = u3:GetPivot()
            local u19 = u3:GetScale()
            if u6 == u7 then
                u3:ScaleTo(u6)
            else
                local v20 = u1.fromParams
                local v21 = u2.getAttribute(u3, "Scale_Curve", u2.default_bezier)
                local function v24(p22, p23) --[[ Line: 54 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u2
                        [3] = u6
                        [4] = u7
                    --]]
                    u3:ScaleTo(u2.lerp(u6, u7, p22))
                    return p23
                end
                table.insert(p4, v20(v21, u10, v24))
            end
            local u25 = u3:FindFirstAncestorOfClass("Attachment") or u3:FindFirstAncestorWhichIsA("BasePart")
            table.insert(p4, function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u25
                    [3] = u18
                    [4] = u19
                --]]
                u3:PivotTo(u25 and (u25:IsA("Attachment") and u25.WorldCFrame or u25.CFrame) or u18)
                u3:ScaleTo(u19)
            end)
            local u26 = v5 * u10
            u1.timer(u10, function(p27, p28) --[[ Line: 73 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u26
                    [3] = u25
                    [4] = u9
                    [5] = u18
                    [6] = u3
                    [7] = u14
                    [8] = u15
                --]]
                local v29 = p28 / u10
                local v30 = u26 * math.clamp(v29, 0, 1)
                local v31
                if u25 and u9 then
                    v31 = u25:IsA("Attachment") and u25.WorldCFrame or u25.CFrame
                else
                    v31 = u18
                end
                u3:PivotTo(v31 * CFrame.fromOrientation(v30.x, v30.y, v30.z))
                if u14 > 0 or p28 > 0 and u15.Connected then
                    return p27 * u14
                else
                    return nil
                end
            end, u15, p4, u2.RENDER_PRIORITY + p4.depth)
        end
    end
}
 

local u1 = game:GetService("RunService")
local u2 = require("./mod/utility")
return {
    ["emit"] = function(u3, p4) --[[ Name: emit, Line 7 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if u3:GetAttribute("Enabled") then
            local u5 = u2.getAttribute(u3, "PartScale", Vector3.new(1, 1, 1))
            local u6 = u2.getAttribute(u3, "PartDistance", 1.5)
            local u7 = u2.getAttribute(u3, "OffsetPosition", Vector3.new(0, 0, 0))
            local u8 = u2.getAttribute(u3, "OffsetRotation", Vector3.new(0, 0, 0)) * u2.DEG_TO_RAD
            local u9 = u3.CFrame
            local u10 = u3.Size
            local u11 = u3.CollisionGroup
            u3.CollisionGroup = "ForgeMouseIgnore"
            table.insert(p4, function() --[[ Line: 24 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u10
                    [3] = u9
                    [4] = u11
                --]]
                u3.Size = u10
                u3.CFrame = u9
                u3.CollisionGroup = u11 == "" and "Default" or (u11 or "Default")
            end)
            local u12 = u2.getRanomId()
            u1:BindToRenderStep(u12, u2.RENDER_PRIORITY + p4.depth, function() --[[ Line: 32 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u3
                    [3] = u5
                    [4] = u7
                    [5] = u8
                --]]
                local v13 = workspace.CurrentCamera
                local v14 = v13.FieldOfView / 2
                local v15 = math.rad(v14)
                local v16 = math.tan(v15) * u6 * 2
                local v17 = v13.ViewportSize.X / v13.ViewportSize.Y * v16
                local v18 = v13.CFrame * CFrame.new(0, 0, -u6)
                local v19 = u3
                local v20 = u3.Size.Z
                v19.Size = Vector3.new(v17, v16, v20) * u5
                u3.CFrame = v18 * CFrame.new(u7) * CFrame.fromOrientation(u8.x, u8.y, u8.z)
            end)
            local function v21() --[[ Line: 45 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u12
                --]]
                u1:UnbindFromRenderStep(u12)
            end
            table.insert(p4, v21)
        end
    end
}
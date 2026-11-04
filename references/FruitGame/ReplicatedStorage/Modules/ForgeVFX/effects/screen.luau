 

local u1 = game:GetService("RunService")
local u2 = require("../mod/attributes")
require("../types")
local u3 = require("../mod/utility")
return {
    ["emit"] = function(u4, p5) --[[ Name: emit, Line 9 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u3
            [3] = u1
        --]]
        if u4:GetAttribute("Enabled") then
            local u6 = u2.get(u4, "PartScale", Vector3.new(1, 1, 1))
            local u7 = u2.get(u4, "PartDistance", 1.5)
            local u8 = u2.get(u4, "OffsetPosition", Vector3.new(0, 0, 0))
            local u9 = u2.get(u4, "OffsetRotation", Vector3.new(0, 0, 0)) * u3.DEG_TO_RAD
            local u10 = u4.CFrame
            local u11 = u4.Size
            local u12 = u4.CollisionGroup
            u4.CollisionGroup = "ForgeMouseIgnore"
            table.insert(p5, function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u11
                    [3] = u10
                    [4] = u12
                --]]
                u4.Size = u11
                u4.CFrame = u10
                u4.CollisionGroup = u12 == "" and "Default" or (u12 or "Default")
            end)
            local function v21() --[[ Line: 33 ]]
                --[[
                Upvalues:
                    [1] = u7
                    [2] = u4
                    [3] = u6
                    [4] = u8
                    [5] = u9
                --]]
                local v13 = workspace.CurrentCamera
                local v14 = v13.FieldOfView / 2
                local v15 = math.rad(v14)
                local v16 = math.tan(v15) * u7 * 2
                local v17 = v13.ViewportSize.X / v13.ViewportSize.Y * v16
                local v18 = v13.CFrame * CFrame.new(0, 0, -u7)
                local v19 = u4
                local v20 = u4.Size.Z
                v19.Size = Vector3.new(v17, v16, v20) * u6
                u4.CFrame = v18 * CFrame.new(u8) * CFrame.fromOrientation(u9.x, u9.y, u9.z)
            end
            if u1:IsRunning() then
                local u22 = u3.getRandomId()
                u1:BindToRenderStep(u22, Enum.RenderPriority.Last.Value + 2 + p5.depth, v21)
                local function v23() --[[ Line: 53 ]]
                    --[[
                    Upvalues:
                        [1] = u1
                        [2] = u22
                    --]]
                    u1:UnbindFromRenderStep(u22)
                end
                table.insert(p5, v23)
            else
                local v24 = u1.RenderStepped
                table.insert(p5, v24:Connect(v21))
            end
            return true
        end
    end
}
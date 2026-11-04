 

game:GetService("TweenService")
game:GetService("Debris")
local u1 = game:GetService("RunService")
local _ = game:GetService("Players").LocalPlayer
local _ = workspace.CurrentCamera
Random.new()
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 14 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u3 = p2.Model
        local u4 = p2.Character
        local _ = p2.AnimationID
        if u3 then
            local v5 = u3:GetChildren()
            for v6 = 1, #v5 do
                local v7 = v5[v6]:GetAttribute("OrgTrans")
                if v7 then
                    v5[v6].Transparency = v7
                end
            end
            local u8 = nil
            local v9 = u3.PrimaryPart
            if v9 == nil then
                return
            end
            local v10 = v9.Position
            local v11 = RaycastParams.new()
            v11.FilterType = Enum.RaycastFilterType.Include
            v11.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
            local v12 = workspace:Raycast(v10 + Vector3.new(0, 2, 0), Vector3.new(0, -25, 0), v11)
            local u13 = not v12 and Vector3.new(0, 1, 0) or v12.Normal
            local _ = u1.Heartbeat:Connect(function(p14) --[[ Line: 62 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u8
                    [3] = u4
                    [4] = u13
                --]]
                local v15 = u3.PrimaryPart
                if v15 == nil then
                    if u8 then
                        u8:Disconnect()
                        u8 = nil
                    end
                    return
                elseif u3:GetAttribute("Destroying") then
                    if u8 then
                        u8:Disconnect()
                        u8 = nil
                    end
                elseif u3:GetAttribute("isAttacking") == nil then
                    local v16 = u4.PrimaryPart
                    local v17 = v15.Position
                    local v18 = v16.Position - v17
                    local v19 = v18.X
                    local v20 = v18.Z
                    local v21 = Vector3.new(v19, 0, v20)
                    local v22
                    if v21.Magnitude > 0 then
                        v22 = v21.Unit
                    else
                        v22 = v15.CFrame.LookVector
                    end
                    local v23 = v22:Cross(u13)
                    local v24
                    if v23.Magnitude > 0 then
                        v24 = v23.Unit
                    else
                        v24 = v15.CFrame.RightVector
                    end
                    local v25 = u13:Cross(v24).Unit
                    local v26 = CFrame.fromMatrix(v17, v24, u13, -v25)
                    v15.CFrame = v15.CFrame:Lerp(v26, 50 * p14)
                end
            end)
        end
    end
}
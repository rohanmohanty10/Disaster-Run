 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        local u2 = p1.char
        local u3 = p1.nt
        local _ = p1.t
        local u4 = p1.v0
        local u5 = p1.x0
        local u6 = p1.en2
        local u7 = p1.endcf
        local u8 = p1.g
        if _G.checkRenderDistance(u2.HumanoidRootPart.CFrame.p) ~= false then
            local u9 = nil
            u9 = game["Run Service"].RenderStepped:Connect(function(p10) --[[ Line: 18 ]]
                --[[
                Upvalues:
                    [1] = u2
                    [2] = u8
                    [3] = u3
                    [4] = u4
                    [5] = u5
                    [6] = u6
                    [7] = u7
                    [8] = u9
                --]]
                u2.HumanoidRootPart.CFrame = CFrame.new(CFrame.new(0.5 * u8 * u3 * u3 + u4 * u3 + u5).p, u6)
                local v11 = u3 + p10
                local v12 = CFrame.new(0.5 * u8 * v11 * v11 + u4 * v11 + u5)
                local v13 = Ray.new(u2.HumanoidRootPart.CFrame.p, (u2.HumanoidRootPart.CFrame.p - v12.p).unit * -(u2.HumanoidRootPart.CFrame.p - v12.p).magnitude)
                local v14, v15 = _G.raycastIgnoreList(v13, {
                    u2,
                    workspace.Ragdolls,
                    workspace.Effects,
                    workspace.Projectiles,
                    workspace.CurrentCamera,
                    workspace.PlayerCharacters
                })
                Ray.new(u2.HumanoidRootPart.CFrame.p, (u2.HumanoidRootPart.CFrame.p - v12.p).unit * (u2.HumanoidRootPart.CFrame.p - v12.p).magnitude / 2)
                if v14 then
                    local v16 = u2.Humanoid.HipHeight * 1.5
                    local v17 = v15 + Vector3.new(0, v16)
                    local v18 = u2.HumanoidRootPart
                    local v19 = CFrame.new
                    local v20 = u6.x
                    local v21 = v17.y
                    local v22 = u6.z
                    v18.CFrame = v19(v17, (Vector3.new(v20, v21, v22))) * CFrame.Angles(0, 3.141592653589793, 0)
                    u7 = u2.HumanoidRootPart.CFrame
                    u9:disconnect()
                    u9 = nil
                end
                u3 = u3 + p10
            end)
        end
    end
}
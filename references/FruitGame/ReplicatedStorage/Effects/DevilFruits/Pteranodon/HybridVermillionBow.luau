 

local u1 = game:GetService("TweenService")
local v2 = RaycastParams.new()
v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 13 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local u4 = p3.Character
        local v5 = p3.Duration
        if u4 == nil then
            return
        elseif _G.checkRenderDistance(u4.PrimaryPart.Position) ~= false then
            u4:FindFirstChild("UpperTorso")
            local v6 = u4.HumanoidRootPart
            local _ = v6.CFrame
            local v7 = p3.FlameMode == true and script.Flame or script.Base
            for _, v8 in u4.PteraHybridForm:GetDescendants() do
                if v8:IsA("Trail") then
                    v8.Enabled = true
                end
            end
            task.delay(v5, function() --[[ Line: 53 ]]
                --[[
                Upvalues:
                    [1] = u4
                --]]
                for _, v9 in u4.PteraHybridForm:GetDescendants() do
                    if v9:IsA("Trail") then
                        v9.Enabled = false
                    end
                end
            end)
            local u10 = v7.VermillionBow:Clone()
            u10.CFrame = v6.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(-1.5707963267948966, 0, 0)
            u10.Parent = workspace.Effects
            _G.destroy(u10, 5)
            local v11 = Instance.new("WeldConstraint")
            v11.Part0 = v6
            v11.Part1 = u10
            v11.Parent = u10
            for _, v12 in u10:GetDescendants() do
                if v12:IsA("PointLight") then
                    local v13 = v12.Brightness
                    v12.Brightness = 0
                    u1:Create(v12, TweenInfo.new(0.23), {
                        ["Brightness"] = v13
                    }):Play()
                end
            end
            local u14 = u4.Humanoid:LoadAnimation(script.flyLoop)
            u14:Play()
            u14:AdjustWeight(5)
            task.delay(v5 * 0.8, function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                _G.particleEnabled(u10.SpeedLines, false)
            end)
            task.delay(v5 * 0.9, function() --[[ Line: 91 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u4
                    [3] = u10
                --]]
                u14:Stop()
                local v15 = u4.Humanoid:LoadAnimation(script.punchAnim)
                v15:Play()
                v15:AdjustWeight(5)
                _G.customEmit(u10.Emit)
                _G.particleEnabled(u10.Emit, false)
            end)
            task.wait(v5)
            for _, v16 in u10:GetDescendants() do
                if v16:IsA("ParticleEmitter") or v16:IsA("Trail") then
                    v16.Enabled = false
                elseif v16:IsA("PointLight") then
                    u1:Create(v16, TweenInfo.new(0.5), {
                        ["Brightness"] = 0
                    }):Play()
                end
            end
        end
    end
}
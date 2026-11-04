 

local u1 = game:GetService("TweenService")
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 13 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u2
        --]]
        local v4 = p3.Character
        if v4 == nil then
            return
        elseif _G.checkRenderDistance(v4.PrimaryPart.Position) ~= false then
            local v5 = p3.inFlame == true and script.Flame or script.Base
            local v6 = v5.HybridSonicScreech:Clone()
            v6.Parent = workspace.Effects
            _G.PlaySound(v4.PrimaryPart, v5:FindFirstChild("RoarSFX"))
            for _, u7 in v6:GetDescendants() do
                if u7:IsA("PointLight") then
                    local v8 = u7.Brightness
                    u7.Brightness = 0
                    u1:Create(u7, TweenInfo.new(0.14), {
                        ["Brightness"] = v8
                    }):Play()
                    task.delay(0.14, function() --[[ Line: 39 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u7
                        --]]
                        u1:Create(u7, TweenInfo.new(0.24, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut, -1, true), {
                            ["Range"] = u7.Range + 4
                        }):Play()
                    end)
                end
            end
            local _ = v4.HumanoidRootPart
            local _ = v4.Humanoid
            local v9 = v4:FindFirstChild("FaceFrontAttachment", true)
            local v10 = v4.PrimaryPart
            local v11 = workspace:Raycast(v10.Position, v10.CFrame.UpVector * -15, u2)
            if v11 then
                local u12 = v5.SonicScreechDust:Clone()
                u12.CFrame = CFrame.new(v11.Position, v11.Position + v11.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
                u12.Parent = workspace.Effects
                for _, v13 in u12.Dust:GetDescendants() do
                    v13.Enabled = true
                    v13.Color = ColorSequence.new(v11.Instance.Color)
                end
                task.delay(1, function() --[[ Line: 85 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                    --]]
                    _G.particleEnabled(u12, false)
                end)
            end
            if v9 then
                local v14 = os.clock()
                while os.clock() - v14 < 1 do
                    v6.CFrame = v9.WorldCFrame
                    task.wait()
                end
            end
            for _, v15 in v6:GetDescendants() do
                if v15:IsA("ParticleEmitter") then
                    v15.Enabled = false
                elseif v15:IsA("PointLight") then
                    u1:Create(v15, TweenInfo.new(0.4), {
                        ["Brightness"] = v15.Brightness / 2,
                        ["Range"] = 25
                    }):Play()
                end
            end
            task.wait(0.65)
            v6.CFrame = v9.WorldCFrame
            for _, u16 in v6:GetDescendants() do
                if u16:IsA("PointLight") then
                    u1:Create(u16, TweenInfo.new(0.3), {
                        ["Range"] = 52,
                        ["Brightness"] = 4
                    }):Play()
                    task.delay(0.3, function() --[[ Line: 117 ]]
                        --[[
                        Upvalues:
                            [1] = u1
                            [2] = u16
                        --]]
                        u1:Create(u16, TweenInfo.new(1.2), {
                            ["Brightness"] = 0
                        }):Play()
                    end)
                end
            end
            _G.customEmit(v6.Emit)
            _G.destroy(v6, 2)
        end
    end
}
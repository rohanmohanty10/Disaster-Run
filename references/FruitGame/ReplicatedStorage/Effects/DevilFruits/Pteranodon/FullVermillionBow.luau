 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
game:GetService("UserInputService")
local v2 = RaycastParams.new()
v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v4 = p3.Character
        local v5 = p3.HitFX_Result
        if v4 == nil then
            return
        elseif _G.checkRenderDistance(v4.PrimaryPart.Position) == false then
            return
        else
            local v6 = p3.Duration
            local v7 = p3.FlameMode == true and script.Flame or script.Base
            v4:FindFirstChild("Bone", true)
            local v8 = v4.HumanoidRootPart
            if v5 then
                if v7:FindFirstChild("Hit") then
                    local v9 = v7.Hit:Clone()
                    v9.CFrame = CFrame.new(v5.Position, v5.Position + v5.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.06, 0)
                    v9.Parent = workspace.Effects
                    _G.destroy(v9, 5)
                    for _, v10 in v9:GetDescendants() do
                        if v10:IsA("ParticleEmitter") or v10:IsA("Trail") then
                            v10.Enabled = false
                            _G.customEmit(v10)
                        end
                    end
                end
            else
                for _, v11 in v7.Swirl:GetChildren() do
                    local v12 = v11:Clone()
                    v12.CFrame = v8.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 0, math.random(-100, 100))
                    v12.Parent = workspace.Effects
                    _G.destroy(v12, 0.35)
                    u1:Create(v12, TweenInfo.new(0.35), {
                        ["CFrame"] = v12.CFrame * CFrame.new(0, 0, 1) * CFrame.Angles(0, 0, -3.141592653589793),
                        ["Size"] = v12.Size * 1.3,
                        ["Transparency"] = 1
                    }):Play()
                end
                local v13 = v7.VermillionBow:Clone()
                v13.CFrame = v8.CFrame * CFrame.new(0, 0, -9) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v13.Parent = workspace.Effects
                _G.destroy(v13, 5)
                for _, v14 in v13:GetDescendants() do
                    if v14:IsA("PointLight") then
                        local v15 = v14.Brightness
                        v14.Brightness = 0
                        u1:Create(v14, TweenInfo.new(0.2), {
                            ["Brightness"] = v15
                        }):Play()
                    end
                end
                local v16 = Instance.new("WeldConstraint")
                v16.Part0 = v8
                v16.Part1 = v13
                v16.Parent = v13
                task.wait(v6)
                for _, v17 in v13:GetDescendants() do
                    if v17:IsA("ParticleEmitter") or v17:IsA("Trail") then
                        v17.Enabled = false
                    elseif v17:IsA("PointLight") then
                        u1:Create(v17, TweenInfo.new(0.5), {
                            ["Brightness"] = 0
                        }):Play()
                    end
                end
                return
            end
        end
    end
}
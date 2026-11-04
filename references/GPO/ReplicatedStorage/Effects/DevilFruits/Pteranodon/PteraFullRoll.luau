 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local v1 = RaycastParams.new()
v1.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
v1.FilterType = Enum.RaycastFilterType.Include
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 19 ]]
        if p2 == nil then
            return
        elseif _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
            local v3 = script.Roll
            local u4 = p2:FindFirstChild("Bone", true)
            local _ = p2.HumanoidRootPart
            for _, u5 in v3:GetChildren() do
                if u5.Name == "Emit" then
                    local v6 = u5:Clone()
                    v6.Parent = workspace.Terrain
                    v6.WorldCFrame = p2.HumanoidRootPart.CFrame
                    _G.customEmit(v6)
                    _G.destroy(v6, 3)
                else
                    task.spawn(function() --[[ Line: 33 ]]
                        --[[
                        Upvalues:
                            [1] = u5
                            [2] = u4
                        --]]
                        local v7 = u5:Clone()
                        v7.Parent = u4
                        for _, v8 in v7:GetDescendants() do
                            if v8:IsA("ParticleEmitter") then
                                v8.Enabled = true
                            end
                        end
                        task.wait(0.5)
                        for _, v9 in v7:GetDescendants() do
                            if v9:IsA("ParticleEmitter") then
                                v9.Enabled = false
                            end
                        end
                        _G.destroy(v7, 2)
                    end)
                end
            end
        end
    end
}
 

game:GetService("RunService")
local u1 = game:GetService("TweenService")
game:GetService("UserInputService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local u2 = RaycastParams.new()
u2.FilterType = Enum.RaycastFilterType.Include
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p3, _) --[[ Name: start, Line 22 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u1
        --]]
        if p3 == nil then
            return
        elseif _G.checkRenderDistance(p3.PrimaryPart.Position) ~= false then
            script.HybridSonicScreech:Clone().Parent = workspace.Effects
            local u4 = p3.HumanoidRootPart
            local u5 = p3.Humanoid
            p3:FindFirstChild("FaceFrontAttachment", true)
            task.spawn(function() --[[ Line: 37 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u2
                    [3] = u5
                    [4] = u1
                --]]
                for _ = 1, 5 do
                    local v6 = workspace:Raycast(u4.Position, Vector3.new(0, -30, 0), u2)
                    local v7 = script.BlackWind:Clone()
                    v7.CFrame = v6 and CFrame.new(v6.Position, v6.Position + v6.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 1, 0) or u4.CFrame * CFrame.new(0, -u4.Size.Y - u5.HipHeight - 1, 0)
                    v7.CFrame = v7.CFrame * CFrame.Angles(0, math.random(-360, 360), 0)
                    v7.Parent = workspace.Effects
                    _G.destroy(v7, 1)
                    u1:Create(v7.Mesh, TweenInfo.new(0.5), {
                        ["Scale"] = v7.Mesh.Scale * 4
                    }):Play()
                    u1:Create(v7.Decal, TweenInfo.new(0.5), {
                        ["Transparency"] = 1
                    }):Play()
                    task.wait(0.12)
                end
            end)
        end
    end
}
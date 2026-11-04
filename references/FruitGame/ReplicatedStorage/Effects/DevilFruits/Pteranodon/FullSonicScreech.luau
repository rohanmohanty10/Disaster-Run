 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
game:GetService("TweenService")
local _ = workspace.CurrentCamera
Emit = _G.Emit
Ess = _G.Ess
TweenCreate = Ess.Tween
Mouse = Ess.Mouse
local u1 = RaycastParams.new()
u1.FilterType = Enum.RaycastFilterType.Include
u1.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 21 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.Character
        if _G.checkRenderDistance(v3:GetPivot().Position) == false then
            return
        else
            local v4 = p2.inFlame == true and script.Flame or script.Base
            local v5 = v3:FindFirstChild("Beak_Top", true)
            if v5 ~= nil then
                local v6 = v4.SonicScreech:Clone()
                v6.Parent = workspace.Effects
                local v7 = v3.PrimaryPart
                local v8 = workspace:Raycast(v5.WorldCFrame.Position, v7.CFrame.UpVector * -15, u1)
                if v8 then
                    local u9 = v4.SonicScreechDust:Clone()
                    u9.CFrame = CFrame.new(v8.Position, v8.Position + v8.Normal) * CFrame.Angles(1.5707963267948966, 0, 0)
                    u9.Parent = workspace.Effects
                    for _, v10 in u9.Dust:GetDescendants() do
                        v10.Enabled = true
                        v10.Color = ColorSequence.new(v8.Instance.Color)
                    end
                    task.delay(0.6, function() --[[ Line: 84 ]]
                        --[[
                        Upvalues:
                            [1] = u9
                        --]]
                        _G.particleEnabled(u9, false)
                    end)
                end
                _G.PlaySound(v3.PrimaryPart, v4.PtreanMeteorRoar)
                if v5 then
                    local v11 = os.clock()
                    while os.clock() - v11 < 0.6 do
                        v6.CFrame = v5.WorldCFrame * CFrame.new(0, 1.2, -1)
                        task.wait()
                    end
                end
                _G.particleEnabled(v6, false)
                _G.destroy(v6, 1)
            end
        end
    end
}
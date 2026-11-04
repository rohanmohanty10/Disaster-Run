 

game:GetService("Players")
local u1 = game:GetService("RunService")
local v2 = {}
game:GetService("TweenService")
Random.new()
function v2.start(_, u3) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u4 = workspace.CurrentCamera
    u4.CameraType = Enum.CameraType.Scriptable
    local u5 = u4.CFrame
    local v6 = game.Players.LocalPlayer.Character
    v6.HumanoidRootPart.Anchored = true
    local u7 = true
    task.spawn(function() --[[ Line: 18 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u1
            [3] = u4
            [4] = u5
            [5] = u3
        --]]
        local v8 = 0
        while u7 do
            local v9 = u1.RenderStepped:Wait()
            local v10 = math.min(v8, 1)
            u4.CFrame = u5:Lerp(u3.CameraPos, v10 * v10)
            if v10 >= 1 then
                break
            end
            v8 = v8 + v9 / u3.AnimationDuration
        end
    end)
    task.wait(u3.Wait + u3.AnimationDuration)
    u7 = false
    task.spawn(function() --[[ Line: 37 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u1
            [3] = u5
            [4] = u3
        --]]
        local v11 = u4.CFrame
        local v12 = 0
        while u4.CameraType ~= Enum.CameraType.Custom do
            local v13 = u1.RenderStepped:Wait()
            local v14 = math.min(v12, 1)
            u4.CFrame = v11:Lerp(u5, v14 * v14)
            if v14 >= 1 then
                break
            end
            v12 = v12 + v13 / u3.AnimationDuration
        end
    end)
    task.wait(u3.AnimationDuration)
    v6.HumanoidRootPart.Anchored = false
    u4.CameraType = Enum.CameraType.Custom
end
return v2
 

return {
    ["start"] = function(_, _, _, _) --[[ Name: start, Line 4 ]]
        local u1 = script.cameraPart:Clone()
        u1.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 1.5707963267948966, 0)
        u1.Parent = workspace.Effects
        u1.colorFill:Emit(3)
        u1.electricitySurround:Emit(30)
        u1.pulseWave:Emit(1)
        _G.destroy(u1, 0.8)
        local u2 = nil
        u2 = game:GetService("RunService").RenderStepped:Connect(function() --[[ Line: 14 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u2
            --]]
            if u1.Parent == workspace.Effects then
                u1.CFrame = game.Workspace.Camera.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, 1.5707963267948966, 0)
            else
                u2:Disconnect()
            end
        end)
    end
}
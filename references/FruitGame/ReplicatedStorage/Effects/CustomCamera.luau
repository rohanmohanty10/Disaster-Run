 

return {
    ["start"] = function(_, u1) --[[ Name: start, Line 3 ]]
        local u2 = workspace.CurrentCamera
        game["Run Service"].RenderStepped:Connect(function() --[[ Line: 5 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u1
            --]]
            u2.CameraType = Enum.CameraType.Scriptable
            u2.CFrame = u1.CFrame
            pcall(function() --[[ Line: 8 ]]
                game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
            end)
        end)
    end
}
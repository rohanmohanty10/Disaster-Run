 

game:GetService("RunService")
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
return {
    ["start"] = function(_, p1, p2) --[[ Name: start, Line 20 ]]
        if _G.checkRenderDistance(p1.HumanoidRootPart.Position) then
            Random.new()
            local v3 = p1:FindFirstChildWhichIsA("Humanoid").RootPart
            local v4 = TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
            local v5 = TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
            local v6 = p2 * CFrame.new(0, -2.8, -5)
            local v7 = v3.Position
            local _ = v7 + Vector3.new(0, -2.8, 0)
            local v8 = workspace:Raycast(v7 + Vector3.new(0, 5, 0), Vector3.new(0, -10, 0), _G.Ess.RaycastParams)
            if v8 then
                local _ = v8.Normal
            end
            if v8 then
                local _ = v8.Position
            end
            _G.PlaySound(v3, script.DopplemanSummon)
            local u9 = script.Shadow:Clone()
            u9.CFrame = v6
            u9.Parent = workspace.Effects
            for _, v10 in u9:GetDescendants() do
                if v10:IsA("Attachment") and v10.Name:match("end") then
                    local v11 = v10.Position
                    local v12 = v11.X
                    local v13 = v11.Z
                    v10.Position = Vector3.new(v12, 0, v13)
                    Tween(v10, v4, {
                        ["Position"] = v11
                    })
                elseif v10:IsA("Beam") then
                    Tween(v10, v5, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
            task.delay(v4.Time, function() --[[ Line: 78 ]]
                --[[
                Upvalues:
                    [1] = u9
                --]]
                Emit(u9:GetDescendants(), false)
            end)
        end
    end
}
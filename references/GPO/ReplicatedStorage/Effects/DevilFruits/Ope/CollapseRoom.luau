 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = game.Workspace.Effects:WaitForChild("roomBubble" .. p1, 3)
        if v2 ~= nil then
            local v3 = game.Workspace.Effects:FindFirstChild("rockOpeGroup" .. p1)
            if v3 then
                v3.floatingVal.Value = false
                local v4 = v3:Clone()
                v4.Parent = workspace.Effects
                v4.Name = "done"
                v3:Destroy()
                for _, v5 in pairs(v4:GetChildren()) do
                    if v5:IsA("Model") and v5.PrimaryPart ~= nil then
                        v5:SetAttribute("shotRock", true)
                        v5.PrimaryPart.Anchored = false
                        v5.Parent = workspace.Effects
                        _G.destroy(v5, 3)
                    end
                end
                v4:Destroy()
            end
            v2.OpeRoomClose.Playing = true
            game:GetService("TweenService"):Create(v2, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Transparency"] = 1
            }, true):Play()
            v2.centerAttach.floorFill.Enabled = false
            v2.centerAttach.floorWave.Enabled = false
            _G.tween(v2.OpeRoomAmbience, {
                0.25,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            for _, v6 in pairs(v2:GetChildren()) do
                if v6:IsA("Beam") then
                    game:GetService("TweenService"):Create(v6, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }, true):Play()
                elseif v6:IsA("ParticleEmitter") then
                    v6.Enabled = false
                end
            end
            for _, v7 in pairs(v2.Model:GetChildren()) do
                if v7:IsA("Model") then
                    v7.WeldConstraint:Destroy()
                else
                    v7.Trail.Enabled = false
                    v7.electricitySurround.Enabled = false
                    v7.centerAttach.dustThrow.Enabled = false
                    v7.centerAttach.rockThrow.Enabled = false
                    v7.topAttach.impactBurst.Enabled = false
                    v7.topAttach.impactLinger.Enabled = false
                end
            end
            v2.Name = "leftover"
            _G.destroy(v2, 2.5)
        end
    end
}
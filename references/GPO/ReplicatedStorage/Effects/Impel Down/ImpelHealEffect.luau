 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = p1.Character:FindFirstChild("HumanoidRootPart")
        if v2 then
            local v3 = script.Heal.emit:Clone()
            v3.Parent = v2
            local v4 = script.Sound:Clone()
            v4.Parent = v2
            v4:Play()
            _G.destroy(v4, 2)
            for _, v5 in pairs(v3:GetDescendants()) do
                if v5:IsA("ParticleEmitter") then
                    _G.customEmit(v5)
                end
            end
            task.wait(5)
            v3:Destroy()
        end
    end
}
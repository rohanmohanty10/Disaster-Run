 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_) --[[ Name: start, Line 6 ]]
        local v1 = workspace.Islands:WaitForChild("Whole Cake Island", 5)
        if v1 then
            local v2 = v1.WholeCakeIsland:WaitForChild("CelebrationVFX", 5)
            if v2 then
                v2:WaitForChild("ParticlesEmit", 5)
                local v3 = v2:WaitForChild("ParticlesEnabled", 5)
                if v3 then
                    local v4 = workspace.CurrentCamera
                    local v5 = tick()
                    repeat
                        task.wait()
                    until (v4.CFrame.Position - v3.Position).Magnitude <= 500 or tick() - v5 >= 3
                    warn("Emitting celerbation")
                    _G.customEmit(v2)
                end
            else
                warn("cant find vfx model ")
                return
            end
        else
            warn("cant find island")
            return
        end
    end
}
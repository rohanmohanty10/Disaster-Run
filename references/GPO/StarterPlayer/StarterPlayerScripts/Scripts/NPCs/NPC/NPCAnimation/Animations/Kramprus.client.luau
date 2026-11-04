 

local v1 = script:WaitForChild("Character").Value
if v1 then
    local v2 = workspace
    local v3 = v1:WaitForChild("Humanoid", 5)
    if v3:IsA("Humanoid") == false then
        script:Destroy()
        return
    elseif v3 and v3.Health > 0 then
        local v4 = v3:WaitForChild("Animator", 3) or v3
        if v3.Parent and (v3:IsDescendantOf(v2) and (v4.Parent and v4:IsDescendantOf(v2))) then
            v4:LoadAnimation(script.idle):Play()
            local v5
            if v1:FindFirstChild("Overhead") == nil then
                local v6 = script.Overhead:Clone()
                v6.Adornee = v1.Head
                v6.Health.Frame.Script.char.Value = v1
                v6.Parent = game.Players.LocalPlayer.PlayerGui.HealthBars
                v6.Health.Frame.Script.Disabled = false
                v5 = 1
            else
                v5 = 1
            end
            while true do
                task.wait(math.random(5, 10))
                _G.PlaySound(v1.Head, script["H" .. v5]).Parent = v1.Head
                local v7 = v5 + 1
                v5 = v7 > 3 and 1 or v7
            end
        else
            return
        end
    else
        script:Destroy()
        return
    end
else
    script:Destroy()
    return
end
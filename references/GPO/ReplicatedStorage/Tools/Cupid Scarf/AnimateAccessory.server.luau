 

local v1 = script.Parent.Parent
local u2 = v1:WaitForChild("HumanoidRootPart")
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u3 = script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("whiteCape"))
u3:Play()
game["Run Service"].Stepped:connect(function() --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if u2 then
        local v4 = u3
        local v5 = u2.AssemblyLinearVelocity.Magnitude / 6
        v4:AdjustSpeed((math.clamp(v5, 1, 10)))
    end
end)
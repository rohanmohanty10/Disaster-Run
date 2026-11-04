 

local v1 = script.Parent.Parent
v1:WaitForChild("HumanoidRootPart")
game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
local u2 = script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("whiteCape"))
u2:Play()
local u3 = v1:WaitForChild("HumanoidRootPart")
game["Run Service"].Stepped:connect(function() --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v4 = u2
    local v5 = u3.AssemblyLinearVelocity.Magnitude / 6
    v4:AdjustSpeed((math.clamp(v5, 1, 10)))
end)
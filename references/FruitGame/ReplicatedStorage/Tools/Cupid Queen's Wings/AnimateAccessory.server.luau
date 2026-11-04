 

local u1 = script.Parent.Parent:WaitForChild("HumanoidRootPart")
local u2 = script.Parent:WaitForChild("AnimationController"):LoadAnimation(script:WaitForChild("whiteCape"))
u2:Play()
script.Parent:WaitForChild("RootPart"):GetDescendants()
game["Run Service"].Stepped:connect(function() --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    if u1 then
        local v3 = u2
        local v4 = u1.AssemblyLinearVelocity.Magnitude / 6
        v3:AdjustSpeed((math.clamp(v4, 1, 10)))
    end
end)
 

local u1 = script.Parent
game:GetService("RunService").Heartbeat:Connect(function(p2) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v3 = u1
    local v4 = u1:GetPivot()
    local v5 = CFrame.Angles
    local v6 = -40 * p2
    v3:PivotTo(v4 * v5(0, math.rad(v6), 0))
end)
 

task.wait(1)
game["Run Service"].Heartbeat:Connect(function(p1) --[[ Line: 2 ]]
    local v2 = script.Parent:GetChildren()
    local v3 = 30 * p1
    for v4 = 1, #v2 do
        if v2[v4] ~= script then
            local v5 = v2[v4].Fan.PrimaryPart
            if v5 ~= nil then
                v5.CFrame = v5.CFrame * CFrame.Angles(0, 0, (math.rad(v3)))
            end
        end
    end
end)
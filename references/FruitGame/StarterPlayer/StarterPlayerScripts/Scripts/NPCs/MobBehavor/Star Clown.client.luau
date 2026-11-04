 

game.ReplicatedStorage.Events.buggyTrack.OnClientEvent:Connect(function(p1, p2, p3) --[[ Line: 1 ]]
    if p1 ~= nil then
        local v4 = p1:FindFirstChild("Info")
        local v5 = v4:FindFirstChild("Target")
        while true do
            local v6 = v4 ~= nil and (v5 ~= nil and v5.Value)
            if not v6 then
                break
            end
            p3.CFrame = CFrame.new(p1.UpperTorso.CFrame.p, (v6.CFrame * CFrame.new(0, 0, 0)).p) * CFrame.Angles(-1.5707963267948966, 0, 0)
            p2.Velocity = p2.Parent.CFrame.upVector * 50
            game["Run Service"].Stepped:Wait()
            if p3.Parent == nil or p2.Parent == nil then
                break
            end
        end
    end
end)
 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 4 ]]
        local v2 = p1.Parent:GetChildren()
        for v3 = 1, #v2 do
            if v2[v3]:IsA("BasePart") then
                local v4 = Instance.new("Part")
                v4.Anchored = true
                v4.Transparency = 1
                v4.CanCollide = false
                v4.Size = v2[v3].Size
                v4.CFrame = v2[v3].CFrame
                v4.Parent = workspace.Effects
                _G.destroy(v4, 2)
                local v5 = script.sm2:Clone()
                v5.Parent = v4
                v5:Emit(3)
                local v6 = script.sm3:Clone()
                v6.Parent = v4
                v6:Emit(3)
            end
        end
    end
}
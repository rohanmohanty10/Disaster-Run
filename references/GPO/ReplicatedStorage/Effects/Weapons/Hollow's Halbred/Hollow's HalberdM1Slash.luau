 

local _ = script
game:GetService("ReplicatedStorage")
return {
    ["start"] = function(_, p1, p2, _, p3) --[[ Name: start, Line 6 ]]
        local v4 = p3 == true and "Dash" or p1
        local v5 = script.Slashes:FindFirstChild(v4)
        if v5 then
            local v6 = script.Slashes.HumanoidRootPart.CFrame:toObjectSpace(v5.CFrame)
            local v7 = v5:Clone()
            v7.CFrame = p2.CFrame * v6
            v7.Parent = workspace.Effects
            _G.customEmit(v7)
            _G.destroy(v7, 5)
        else
            warn("cant find " .. v5)
        end
    end
}
 

return {
    ["check"] = function(_) --[[ Name: check, Line 14 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name)
        local v3 = Ray.new(v2.HumanoidRootPart.Position, v2.HumanoidRootPart.CFrame.upVector * -1000)
        _G.raycastWhitelist(v3, { workspace.Islands })
    end
}
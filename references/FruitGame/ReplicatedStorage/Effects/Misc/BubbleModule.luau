 

local u1 = game:GetService("TweenService")
return {
    ["start"] = function(_, p2, p3, p4, p5, p6, p7) --[[ Name: start, Line 9 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        if _G.checkRenderDistance(p2.Position) ~= false then
            if workspace.Effects:FindFirstChild("bubbleFolder") == nil then
                local v8 = Instance.new("Model")
                v8.Name = "bubbleFolder"
                local v9 = Instance.new("Highlight")
                v9.Enabled = false
                v9.Parent = v8
                v8.Parent = workspace.Effects
            end
            if p3 == nil then
                p3 = Color3.fromRGB(255, 255, 255)
            end
            local v10 = script.Mesh:Clone()
            v10.CFrame = p2
            v10.Size = p4
            v10.Transparency = p5
            v10.Color = p3
            v10.Parent = workspace.Effects:FindFirstChild("bubbleFolder")
            _G.destroy(v10, p7)
            u1:Create(v10, TweenInfo.new(p7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0), {
                ["Transparency"] = 1,
                ["Size"] = p6
            }):Play()
        end
    end
}
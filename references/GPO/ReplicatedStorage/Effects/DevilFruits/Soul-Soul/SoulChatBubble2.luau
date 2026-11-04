 

local u1 = game:GetService("TweenService")
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.PlayerCharacter
        local v4 = p2.Cloud
        local u5 = p2.Message
        local v6 = p2.Lifetime or 3
        local v7 = v3:FindFirstChild(v4.Name .. "Chat") or script.ChatHolder:Clone()
        v7.Name = v4.Name .. "Chat"
        local v8 = v7.Frame.ChatBubbleFrameTemplate
        v8.Visible = false
        v7.StudsOffset = Vector3.new(4.556, -2, 0)
        if v4.Name == "Zeus" then
            v7.StudsOffset = Vector3.new(5, -1, 0)
            v7.StudsOffset = Vector3.new(-10, -1, 0)
            v7.Frame.ChatBubbleFrameTemplate.Images.ChatImage.Image = "rbxassetid://85169597790720"
            v7.Frame.Rotation = -v7.Frame.Rotation
        end
        v7.Parent = v3
        v7.Adornee = v4.AttachedPart
        local u9 = v8:Clone()
        u9.Size = UDim2.new(0, 0, 0.25, 0)
        u9.Visible = true
        u9.TextLabel.Text = ""
        u9.Parent = v7.Frame
        u1:Create(u9, TweenInfo.new(0.15), {
            ["Size"] = UDim2.fromScale(1, 0.25)
        }):Play()
        task.delay(0.15, function() --[[ Line: 58 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u5
            --]]
            u9.TextLabel.Text = u5
        end)
        task.wait(v6)
        u9.TextLabel.Text = ""
        u1:Create(u9, TweenInfo.new(0.15), {
            ["Size"] = UDim2.fromScale(0, 0.25)
        }):Play()
        task.wait(0.15)
        u9:Destroy()
        u9 = nil
    end
}
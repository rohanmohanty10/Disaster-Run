 

return {
    ["start"] = function(_, p1, p2, p3) --[[ Name: start, Line 5 ]]
        if p1 == nil then
            return
        elseif _G.checkRenderDistance(p1.CFrame, 75) ~= false then
            local v4 = game:GetService("TextService"):GetTextSize(p2, 16, Enum.Font.Montserrat, Vector2.new(1000, 100))
            local u5 = script.BubbleChat:Clone()
            u5.BubbleChatList.Bubble.Size = UDim2.new(0, v4.X + 50, 0, 32)
            u5.BubbleChatList.Bubble.Frame.Text.Text = p2
            u5.Parent = p1
            local u6 = u5:GetDescendants()
            for v7 = 1, #u6 do
                if u6[v7]:IsA("TextLabel") and u6[v7].TextTransparency ~= 1 then
                    local v8 = u6[v7].TextTransparency
                    u6[v7].TextTransparency = 1
                    game:GetService("TweenService"):Create(u6[v7], TweenInfo.new(0.25), {
                        ["TextTransparency"] = v8
                    }):Play()
                elseif u6[v7]:IsA("Frame") and u6[v7].BackgroundTransparency ~= 1 then
                    local v9 = u6[v7].BackgroundTransparency
                    u6[v7].BackgroundTransparency = 1
                    game:GetService("TweenService"):Create(u6[v7], TweenInfo.new(0.25), {
                        ["BackgroundTransparency"] = v9
                    }):Play()
                elseif u6[v7]:IsA("ImageLabel") and (u6[v7].ImageTransparency ~= 1 and u6[v7].BackgroundTransparency ~= 1) then
                    local v10 = u6[v7].ImageTransparency
                    local v11 = u6[v7].BackgroundTransparency
                    u6[v7].BackgroundTransparency = 1
                    u6[v7].ImageTransparency = 1
                    game:GetService("TweenService"):Create(u6[v7], TweenInfo.new(0.25), {
                        ["ImageTransparency"] = v10,
                        ["BackgroundTransparency"] = v11
                    }):Play()
                end
            end
            task.delay(p3, function() --[[ Line: 44 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u5
                --]]
                for v12 = 1, #u6 do
                    if u6[v12]:IsA("TextLabel") then
                        game:GetService("TweenService"):Create(u6[v12], TweenInfo.new(0.25), {
                            ["TextTransparency"] = 1,
                            ["BackgroundTransparency"] = 1
                        }):Play()
                    elseif u6[v12]:IsA("Frame") then
                        game:GetService("TweenService"):Create(u6[v12], TweenInfo.new(0.25), {
                            ["BackgroundTransparency"] = 1
                        }):Play()
                    elseif u6[v12]:IsA("ImageLabel") then
                        game:GetService("TweenService"):Create(u6[v12], TweenInfo.new(0.25), {
                            ["ImageTransparency"] = 1,
                            ["BackgroundTransparency"] = 1
                        }):Play()
                    end
                end
                _G.destroy(u5, 0.25)
            end)
        end
    end
}
 

repeat
    task.wait()
until game.Players.LocalPlayer
local _ = game.Players.LocalPlayer
game:GetService("TextChatService").MessageReceived:Connect(function(p1) --[[ Line: 7 ]]
    local v2 = p1.TextSource
    local v3 = p1.Text
    if v2 and v2.Name == game.Players.LocalPlayer.Name then
        if v3 == "/sounds" then
            print("PLAYING SOUNDS\n")
            local u4 = game:GetDescendants()
            for u5 = 1, #u4 do
                pcall(function() --[[ Line: 15 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u5
                    --]]
                    if u4[u5]:IsA("Sound") and u4[u5].IsPlaying == true then
                        local v6 = print
                        local v7 = u4[u5]:GetFullName()
                        local v8 = u4[u5].Looped
                        v6(v7 .. " is Playing! Looped: " .. tostring(v8) .. " Length: " .. u4[u5].TimeLength)
                    end
                end)
            end
            return
        end
        if v3 == "/highlights" then
            print("all highlights")
            local u9 = game:GetDescendants()
            for u10 = 1, #u9 do
                pcall(function() --[[ Line: 25 ]]
                    --[[
                    Upvalues:
                        [1] = u9
                        [2] = u10
                    --]]
                    if u9[u10]:IsA("Highlight") then
                        print(u9[u10]:GetFullName() .. " is a highlight!")
                    end
                end)
            end
        end
    end
end)
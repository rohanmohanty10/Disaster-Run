 

local v1 = {}
game:GetService("TextChatService")
function v1.start(_, p2) --[[ Line: 4 ]]
    local v3 = p2.CFrame
    local v4 = p2.Text
    local v5 = p2.VoiceId
    local v6 = script.DialogueVolume:Clone()
    local v7 = v6:GetChildren()
    table.insert(v7, v6)
    local u8 = v6.AudioTextToSpeech
    if v3 then
        v6.CFrame = v3
    end
    u8.Text = v4
    u8.TimePosition = 0
    u8.VoiceId = v5 or 2
    for u9, u10 in pairs(p2) do
        if u9 ~= "Parent" then
            pcall(function() --[[ Line: 26 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u9
                    [3] = u10
                --]]
                u8[u9] = u10
            end)
        end
    end
    if p2.Parent then
        for v11 = 1, #v7 do
            v7[v11].Parent = p2.Parent
        end
    else
        v6.Parent = workspace.Effects
    end
    if u8.IsLoaded == false then
        local v12 = os.clock()
        repeat
            task.wait()
        until u8.IsLoaded == true or os.clock() - v12 > 10
        if not u8.IsLoaded then
            warn("TIMEOUT: TTSMessage IsLoaded expired")
            _G.destroy(v7, 0)
            return
        end
    end
    u8:Play()
    local v13 = os.clock()
    repeat
        task.wait(0.25)
    until not u8.IsPlaying or os.clock() - v13 > 60
    _G.destroy(v7, 6)
end
return v1
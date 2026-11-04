 

local v1 = {}
local u2 = {}
local u3 = require(game:GetService("ReplicatedFirst"):FindFirstChild("OpenTextChatService"))
function v1.start(_, p4) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if p4 == true then
        local v5 = game.Players.LocalPlayer.PlayerGui:GetChildren()
        for v6 = 1, #v5 do
            if v5[v6]:IsA("ScreenGui") and (v5[v6].Enabled == true and (v5[v6].Name ~= "Chat" and v5[v6]:GetAttribute("unhideable") == nil)) then
                v5[v6].Enabled = false
                local v7 = u2
                local v8 = v5[v6]
                table.insert(v7, v8)
            end
        end
        u3.SetChatCoreGuiEnabled(false)
    else
        for v9 = 1, #u2 do
            if u2[v9] then
                u2[v9].Enabled = true
            end
        end
        table.clear(u2)
        u3.SetChatCoreGuiEnabled(true)
    end
end
return v1
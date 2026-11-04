 

local v1 = {}
local u2 = game:GetService("TextChatService")
local v3 = game:GetService("ReplicatedFirst")
local u4 = require(v3.OpenTextChatService)
function v1.start(_, p5) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u2
    --]]
    if p5 == "hideChatUI" then
        u4.ChatWindowConfiguration.Enabled = false
        return
    elseif p5 == "showChatUI" then
        u4.ChatWindowConfiguration.Enabled = true
        return
    elseif typeof(p5) ~= "boolean" then
        u2.TextChannels.RBXSystem:DisplaySystemMessage(p5)
    end
end
return v1
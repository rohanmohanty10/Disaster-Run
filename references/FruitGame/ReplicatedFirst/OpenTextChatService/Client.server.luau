 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("ReplicatedFirst")
if not (script:IsDescendantOf(v1) or script:IsDescendantOf(v2)) then
    error("OpenTextChatService must be insatlled in ReplicatedStorage or ReplicatedFirst. Please refer to the usage guide.\nhttps://devforum.roblox.com/t/3605944")
end
if script.Parent:GetAttribute("Enabled") then
    require(script.Parent)
end
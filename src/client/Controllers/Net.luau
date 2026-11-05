--!strict
-- Safe wrapper around Remotes.Request so a network hiccup never errors a UI script.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local Net = {}

function Net.Request(action: string, ...: any): { [string]: any }
	local ok, result = pcall(Remotes.Function("Request").InvokeServer, Remotes.Function("Request"), action, ...)
	if not ok or type(result) ~= "table" then
		return { Ok = false, Reason = "Network", Message = "Connection problem. Please try again." }
	end
	return result
end

return Net

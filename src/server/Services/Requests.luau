--!strict
-- Routes client requests (Remotes.Request:InvokeServer(action, ...)) to registered handlers.
-- Handlers must validate every argument: anything from the client can be anything.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

export type Result = { Ok: boolean, Reason: string?, Message: string?, [string]: any }
type Handler = (player: Player, ...any) -> Result

local Requests = {}

local handlers: { [string]: Handler } = {}

function Requests.Register(action: string, handler: Handler)
	assert(handlers[action] == nil, `Request {action} registered twice`)
	handlers[action] = handler
end

function Requests.Fail(reason: string, message: string?): Result
	return { Ok = false, Reason = reason, Message = message }
end

-- Toast message on one player's screen.
function Requests.Notify(player: Player, text: string, color: Color3?)
	Remotes.Event("Notify"):FireClient(player, text, color)
end

function Requests.Init()
	Remotes.Function("Request").OnServerInvoke = function(player: Player, action: any, ...: any): Result
		if type(action) ~= "string" then
			return Requests.Fail("BadRequest")
		end
		local handler = handlers[action]
		if not handler then
			return Requests.Fail("UnknownAction")
		end
		local ok, result = pcall(handler, player, ...)
		if not ok then
			warn(`[Requests] {action} failed for {player.Name}: {result}`)
			return Requests.Fail("Error", "Something went wrong. Please try again.")
		end
		return result
	end
end

return Requests

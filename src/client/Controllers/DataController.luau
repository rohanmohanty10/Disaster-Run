--!strict
-- Local copy of the player's save data, kept in sync by the server's DataUpdated snapshots.
-- Read-only on the client: every change is a request to the server.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local Net = require(script.Parent.Net)

local DataController = {}

DataController.Data = nil :: { [string]: any }?
DataController.Changed = Signal.new() -- (data)

local function set(data: { [string]: any })
	DataController.Data = data
	DataController.Changed:Fire(data)
end

-- Yields until data has arrived.
function DataController.Wait(): { [string]: any }
	while DataController.Data == nil do
		DataController.Changed:Wait()
	end
	return DataController.Data :: { [string]: any }
end

function DataController.Init()
	Remotes.Event("DataUpdated").OnClientEvent:Connect(set)
end

function DataController.Start()
	-- In case the first snapshot was sent before we connected.
	if DataController.Data == nil then
		local result = Net.Request("GetData")
		if result.Ok and DataController.Data == nil then
			set(result.Data)
		end
	end
end

return DataController

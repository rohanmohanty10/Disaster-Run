--!strict
-- Every remote in one place. The server creates them; clients wait for them.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FOLDER_NAME = "Remotes"

local Definitions = {
	-- Client -> server requests that return a result: Request:InvokeServer(action, ...)
	Request = "RemoteFunction",
	-- Server -> client: full save-data snapshot for the local player
	DataUpdated = "RemoteEvent",
	-- Server -> client: toast message (text, colour?)
	Notify = "RemoteEvent",
}

local Remotes = {}

local function getFolder(): Folder
	if RunService:IsServer() then
		local folder = ReplicatedStorage:FindFirstChild(FOLDER_NAME)
		if not folder then
			folder = Instance.new("Folder")
			folder.Name = FOLDER_NAME
			folder.Parent = ReplicatedStorage
		end
		return folder :: Folder
	end
	return ReplicatedStorage:WaitForChild(FOLDER_NAME) :: Folder
end

local function get(name: string): Instance
	local className = Definitions[name]
	assert(className, `Unknown remote {name}`)
	local folder = getFolder()
	local remote = folder:FindFirstChild(name)
	if not remote then
		if RunService:IsServer() then
			remote = Instance.new(className)
			remote.Name = name
			remote.Parent = folder
		else
			remote = folder:WaitForChild(name)
		end
	end
	return remote :: Instance
end

function Remotes.Function(name: string): RemoteFunction
	return get(name) :: RemoteFunction
end

function Remotes.Event(name: string): RemoteEvent
	return get(name) :: RemoteEvent
end

-- Server: create everything up front so clients never wait on a missing remote.
function Remotes.CreateAll()
	for name in Definitions do
		get(name)
	end
end

return Remotes

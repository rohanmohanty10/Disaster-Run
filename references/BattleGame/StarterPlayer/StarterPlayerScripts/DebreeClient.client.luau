-- StarterPlayer > StarterPlayerScripts > DebreeClient   (LocalScript, CLIENT)
--
-- Starts Debree on this client once: builds the piece pool, connects the remotes and
-- tells the server it's ready. StarterPlayerScripts runs once per join (not per respawn),
-- so the pool survives deaths.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DebreeController = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Debree"):WaitForChild("DebreeController"))

DebreeController.Start()

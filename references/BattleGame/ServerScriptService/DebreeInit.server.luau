-- ServerScriptService > DebreeInit   (Script, SERVER)
--
-- Starts Debree on the server as soon as the game starts, so it's ready before the
-- first player's client asks for the current destroyed state.

local ServerStorage = game:GetService("ServerStorage")

local DebreeService = require(ServerStorage:WaitForChild("SBGModules"):WaitForChild("DebreeService"))

DebreeService.Start()

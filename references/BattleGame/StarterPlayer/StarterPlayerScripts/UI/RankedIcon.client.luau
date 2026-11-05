-- "Ranked" topbar button (TopbarPlus, same Icon module as StarterPlayerScripts.Icons).
-- Pressing it opens the Servers menu on its Public tab (ServerBrowserClient), which lists the
-- public and private servers and joins the Ranked Lobby.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local Ranked = ReplicatedStorage:WaitForChild("Ranked")
local PlaceRole = require(Ranked:WaitForChild("PlaceRole"))
if not PlaceRole.IsMain() then
	return -- no button in the Arena (or the Lobby)
end

repeat
	task.wait()
until game:IsLoaded() and player:GetAttribute("Loaded")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local Icon = require(Modules:WaitForChild("Icon"))
local SoundsModule = require(Modules:WaitForChild("SoundHandler"))
local ClickSound = ReplicatedStorage.Assets.Sounds.UI:WaitForChild("click1")

local ICON_IMAGE = 16011109823 -- server rack (Ultimate Battlegrounds' Servers icon)
local LABEL = "" -- icon only

local icon = Icon.new()
icon:setName("Ranked")
icon:setLabel(LABEL)
icon:setImage(ICON_IMAGE)
icon:bindEvent("selected", function(self)
	self:deselect()
	if shared.servergui then
		shared.servergui("Public")
	end
end)

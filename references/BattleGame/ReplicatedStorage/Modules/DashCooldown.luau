--ReplicatedStorage DashCooldown Module
--
--Single source of truth for dash cooldown lengths, plus the client side clock
--that the dash cooldown HUD reads from.
--
--The lengths used to be hardcoded in six separate places:
--	StarterPlayer.StarterPlayerScripts.Replication	(the two client gates)
--	ServerScriptService.Systems.NewCombatSystem		(DashCD / SideDashCD tag delays)
--Both sides now read from here, so the HUD bar can never drift away from the
--gate the player actually hits.

local Players = game:GetService("Players")

local DashCooldown = {}

--Cooldown keys. The HUD builds one slot per entry.
DashCooldown.Keys = {
	Side = "Side",
	Forward = "Forward",
}

--Default lengths in seconds. Side covers Left/Right, Forward covers Front/Back
--(both share the DashCD tag on the server).
local Defaults = {
	Side = 2,
	Forward = 5,
}

--Optional per character overrides, set as attributes on the character model.
local OverrideAttributes = {
	Side = "CustomSideDashCooldown",
	Forward = "CustomForwardDashCooldown",
}

--The CollectionService tags the server applies for each key. The HUD watches
--these so it can also show cooldowns the client never predicted locally, which
--is how the Front dash gets picked up.
DashCooldown.Tags = {
	Side = "SideDashCD",
	Forward = "DashCD",
}

--Client side clock. Unused on the server, which tracks cooldowns with tags.
local endTimes = {}
local durations = {}

local changedEvent = Instance.new("BindableEvent")
DashCooldown.Changed = changedEvent.Event

--Returns how long a cooldown of this key should last for this character,
--honouring the attribute override when it holds a usable number.
function DashCooldown.GetConfiguredDuration(character, key)
	local default = Defaults[key] or 0

	local attribute = OverrideAttributes[key]
	if not character or not attribute then
		return default
	end

	local value = character:GetAttribute(attribute)

	--Reject anything that is not a real number, so a bad attribute falls back
	--to the default instead of breaking the gate.
	if typeof(value) ~= "number" or value ~= value or value == math.huge or value == -math.huge then
		return default
	end

	return math.max(value, 0)
end

--True while the player, or the whole server, has dash cooldowns turned off.
function DashCooldown.IsBypassed(player)
	player = player or Players.LocalPlayer

	local configuration = workspace:FindFirstChild("Configuration")
	local serverToggle = configuration and configuration:FindFirstChild("NoDashCD")
	if serverToggle and serverToggle.Value then
		return true
	end

	local commands = player and player:FindFirstChild("Commands")
	local playerToggle = commands and commands:FindFirstChild("NoDashCD")
	if playerToggle and playerToggle.Value then
		return true
	end

	return false
end

--Starts a cooldown. Does nothing while cooldowns are bypassed, and never
--shortens one that is already running for longer.
function DashCooldown.Start(key, character, duration)
	if DashCooldown.IsBypassed() then
		return
	end

	local total = duration or DashCooldown.GetConfiguredDuration(character, key)
	if total <= 0 then
		return
	end

	local finish = tick() + total
	if (endTimes[key] or 0) >= finish then
		return
	end

	endTimes[key] = finish
	durations[key] = total

	changedEvent:Fire(key)
end

--Starts a cooldown only when nothing is running for that key. The HUD uses
--this for server tags so a tag arriving one ping late cannot stretch a
--cooldown the client already predicted.
function DashCooldown.StartIfIdle(key, character, duration)
	if DashCooldown.GetRemaining(key) > 0 then
		return
	end

	DashCooldown.Start(key, character, duration)
end

--Seconds left on a cooldown, 0 when it is not running.
function DashCooldown.GetRemaining(key)
	local finish = endTimes[key]
	if not finish then
		return 0
	end

	return math.max(finish - tick(), 0)
end

--Length of the cooldown currently running, used for the HUD bar fraction.
function DashCooldown.GetDuration(key)
	return durations[key] or Defaults[key] or 1
end

function DashCooldown.Clear(key)
	if endTimes[key] == nil then
		return
	end

	endTimes[key] = nil
	changedEvent:Fire(key)
end

--Wipes every running cooldown. Called on respawn, and the hook to use if you
--ever want an ability to refund a dash.
function DashCooldown.ClearAll()
	for key in Defaults do
		DashCooldown.Clear(key)
	end
end

return DashCooldown

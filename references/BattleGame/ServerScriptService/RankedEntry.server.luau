-- Sends a player from the main game to the Ranked Lobby when they press the "Ranked" topbar
-- button (StarterPlayerScripts.RankedButton). Main game only: does nothing in the Arena or Lobby.
--
-- Refused while in combat (a DamagedLog / DamagerLog from DamageHandler.CombatLogger is on the
-- character, i.e. hit or hitting someone in the last 10 s; training dummies don't count), so the
-- button can't be used to escape a fight. Studio prints instead of teleporting.
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")

local Ranked = ReplicatedStorage:WaitForChild("Ranked")
local Config = require(Ranked.Config)
local PlaceRole = require(Ranked.PlaceRole)
local Remote: RemoteFunction = ReplicatedStorage.Remotes:WaitForChild("JoinRankedLobby")
local Notify: RemoteEvent = ReplicatedStorage.Remotes.Comunicator.Set

local COOLDOWN = 5 -- seconds between attempts per player
local RETRIES = 1 -- extra tries after a TeleportInitFailed
local RETRY_DELAY = 2

if not PlaceRole.IsMain() then
	Remote.OnServerInvoke = function()
		return false
	end
	return
end

local lastTry = {} -- [Player] = os.clock()
local teleporting = {} -- [Player] = { Tries = number } while a teleport is in flight

local function notify(player: Player, text: string)
	if player.Parent == Players then
		Notify:FireClient(player, "SendNotification", { Title = "RANKED", Text = text, Time = 4 })
	end
end

local function inCombat(player: Player): boolean
	local character = player.Character
	if not character then
		return false
	end
	for _, name in { "DamagedLog", "DamagerLog" } do
		local log = character:FindFirstChild(name)
		if log and not log:HasTag("Dummy") then
			return true
		end
	end
	return false
end

local function teleport(player: Player): boolean
	if RunService:IsStudio() then
		print("[RankedEntry] (Studio) would teleport", player.Name, "to the Ranked Lobby")
		teleporting[player] = nil
		return true
	end
	local ok, err = pcall(TeleportService.TeleportAsync, TeleportService, Config.PlaceIds.Lobby, { player })
	if not ok then
		warn("[RankedEntry] Teleport to Lobby failed for", player.Name, err)
	end
	return ok
end

local function refuse(player: Player, text: string): boolean
	notify(player, text)
	return false
end

Remote.OnServerInvoke = function(player: Player): boolean
	if teleporting[player] then
		return false
	end
	local now = os.clock()
	if lastTry[player] and now - lastTry[player] < COOLDOWN then
		return refuse(player, "Wait a moment before trying again.")
	end
	lastTry[player] = now
	if not player:GetAttribute("Loaded") then
		return refuse(player, "Still loading your data.")
	end
	if inCombat(player) then
		return refuse(player, "You can't join ranked while in combat.")
	end

	teleporting[player] = { Tries = 0 }
	notify(player, "Joining the ranked lobby...")
	if teleport(player) then
		return true
	end
	teleporting[player] = nil
	return refuse(player, "Couldn't reach the ranked lobby. Try again.")
end

-- Teleports can also fail after TeleportAsync returns (server full, flood limit, etc.).
TeleportService.TeleportInitFailed:Connect(function(player: Player, _result, message)
	local state = teleporting[player]
	if not state then
		return
	end
	warn("[RankedEntry] Teleport to Lobby failed for", player.Name, message)
	state.Tries += 1
	if state.Tries <= RETRIES then
		task.wait(RETRY_DELAY)
		if player.Parent == Players and teleporting[player] == state and teleport(player) then
			return
		end
	end
	teleporting[player] = nil
	notify(player, "Couldn't join the ranked lobby. Try again.")
end)

Players.PlayerRemoving:Connect(function(player: Player)
	lastTry[player] = nil
	teleporting[player] = nil
end)

-- Chat commands (server)
--
-- Handles the "/" admin commands that were advertised on join but never wired up
-- (the old MainHandler hook was commented out). Listens to Player.Chatted, gates
-- to admins, parses "/command args", and runs the matching handler below.
--
-- WHO CAN USE THESE (isAdmin): Studio, the private-server owner (workspace
-- "ServerOwner" attribute / PrivateServerOwnerId), the game creator, or any UserId
-- listed in Info.Admins. For a LIVE game, add your UserId to Info.Admins.
--
-- NOTE: because this uses Player.Chatted, the command text is still visible in chat
-- (e.g. "/ban bob" shows to everyone). If you want commands hidden, we can switch
-- to TextChatCommand objects — ask and I'll convert it.

local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage      = game:GetService("ServerStorage")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")

local Info           = require(ReplicatedStorage.Info)
local DataManager    = require(ServerScriptService.Data.DataManager)
local iFramesService = require(ServerStorage.SBGModules.iFramesService)

local Comunicator = ReplicatedStorage.Remotes.Comunicator.Set

-- No admin commands in live arena matches (they'd decide ranked games). Still on in Studio.
local IsArena = require(ReplicatedStorage:WaitForChild("Ranked"):WaitForChild("PlaceRole")).IsArena()


-- ── Permission ───────────────────────────────────────────────────────────────
local function isAdmin(player: Player): boolean
	if RunService:IsStudio() then return true end
	if IsArena then return false end
	--if workspace:GetAttribute("ServerOwner") == player.UserId then return true end
	--if game.PrivateServerOwnerId ~= 0 and player.UserId == game.PrivateServerOwnerId then return true end
	--if player.UserId == game.CreatorId then return true end
	--if Info.Admins and table.find(Info.Admins, player.UserId) then return true end
	if player:GetAttribute("Admin") == true then return true end
	return false
end


-- ── Helpers ──────────────────────────────────────────────────────────────────
-- Find a connected player by (partial, case-insensitive) name.
local function findPlayer(query: string?): Player?
	if not query or query == "" then return nil end
	query = query:lower()

	local partial: Player? = nil
	for _, p in Players:GetPlayers() do
		local name = p.Name:lower()
		if name == query then return p end
		if not partial and name:sub(1, #query) == query then partial = p end
	end
	return partial
end

-- Sends the sender a small notification (reuses the game's SendNotification UI).
local function notify(player: Player, text: string)
	Comunicator:FireClient(player, "SendNotification", { Title = "COMMAND", Text = text })
end

local function rootOf(character: Model?): BasePart?
	return character and character:FindFirstChild("HumanoidRootPart")
end


-- ── Command handlers ─────────────────────────────────────────────────────────
-- Each handler receives (sender: Player, args: {string}) where args are the
-- space-separated tokens AFTER the command word.
local Commands: { [string]: (Player, { string }) -> () } = {}

Commands["kick"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then return notify(sender, "Player not found: " .. tostring(args[1])) end

	local reason = table.concat(args, " ", 2)
	if reason == "" then reason = "Kicked by an admin." end
	target:Kick(reason)
	notify(sender, "Kicked " .. target.Name)
end

Commands["ban"] = function(sender, args)
	local target = findPlayer(args[1])
	if not target then return notify(sender, "Player must be in-game to ban: " .. tostring(args[1])) end

	local reason = table.concat(args, " ", 2)
	if reason == "" then reason = "Banned by an admin." end

	local ok, err = pcall(function()
		Players:BanAsync({
			UserIds = { target.UserId },
			Duration = -1, -- permanent
			DisplayReason = reason,
			PrivateReason = "Chat /ban by " .. sender.Name,
			ExcludeAltAccounts = false,
			ApplyToUniverse = false,
		})
	end)
	notify(sender, ok and ("Banned " .. target.Name) or ("Ban failed: " .. tostring(err)))
end

Commands["unban"] = function(sender, args)
	local name = args[1]
	if not name then return notify(sender, "Usage: /unban <username>") end

	local ok, userId = pcall(function() return Players:GetUserIdFromNameAsync(name) end)
	if not ok or not userId then return notify(sender, "Couldn't find user: " .. name) end

	local ok2, err = pcall(function()
		Players:UnbanAsync({ UserIds = { userId }, ApplyToUniverse = false })
	end)
	notify(sender, ok2 and ("Unbanned " .. name) or ("Unban failed: " .. tostring(err)))
end

Commands["announce"] = function(sender, args)
	local msg = table.concat(args, " ")
	if msg == "" then return notify(sender, "Usage: /announce <message>") end
	Comunicator:FireAllClients("SendNotification", { Title = "ANNOUNCEMENT", Text = msg })
end

Commands["goto"] = function(sender, args)
	local target = findPlayer(args[1])
	local targetRoot = rootOf(target and target.Character)
	if not targetRoot or not sender.Character then return notify(sender, "Player not found: " .. tostring(args[1])) end
	sender.Character:PivotTo(targetRoot.CFrame * CFrame.new(0, 0, 3))
end

Commands["bring"] = function(sender, args)
	local target = findPlayer(args[1])
	local senderRoot = rootOf(sender.Character)
	if not target or not target.Character or not senderRoot then return notify(sender, "Player not found: " .. tostring(args[1])) end
	target.Character:PivotTo(senderRoot.CFrame * CFrame.new(0, 0, 3))
end

Commands["respawn"] = function(sender, args)
	local target = args[1] and findPlayer(args[1]) or sender
	if not target then return notify(sender, "Player not found: " .. tostring(args[1])) end
	target:LoadCharacter()
	notify(sender, "Respawned " .. target.Name)
end

Commands["godmode"] = function(sender, args)
	local target = args[1] and findPlayer(args[1]) or sender
	local char = target and target.Character
	if not char then return notify(sender, "Player not found: " .. tostring(args[1])) end

	local on = not char:GetAttribute("CmdGodmode")
	char:SetAttribute("CmdGodmode", on)
	if on then
		iFramesService:AddAlliFrames(char)
	else
		iFramesService:RemoveAlliFrames(char)
	end
	notify(sender, ("Godmode %s for %s"):format(on and "ON" or "OFF", target.Name))
end

-- Testing helper: /addkills <amount>  OR  /addkills <username> <amount>
Commands["addkills"] = function(sender, args)
	local target, amount
	if #args >= 2 then
		target = findPlayer(args[1])
		amount = tonumber(args[2])
	else
		target = sender
		amount = tonumber(args[1])
	end

	if not target then return notify(sender, "Player not found.") end
	if not amount then return notify(sender, "Usage: /kills [username] <amount>") end

	DataManager.addTotalKill(target, amount)
	DataManager.addMonthlyKill(target, amount)
	notify(sender, ("Gave %d kills to %s"):format(amount, target.Name))
end

Commands["addgold"] = function(sender, args)
	local target, amount
	if #args >= 2 then
		target = findPlayer(args[1])
		amount = tonumber(args[2])
	else
		target = sender
		amount = tonumber(args[1])
	end

	if not target then return notify(sender, "Player not found.") end
	if not amount then return notify(sender, "Usage: /addGold [username] <amount>") end

	DataManager.addGold(target, amount)
	notify(sender, ("Gave %d gold to %s"):format(amount, target.Name))
end

Commands["addemotespins"] = function(sender, args)
	local target, amount
	if #args >= 2 then
		target = findPlayer(args[1])
		amount = tonumber(args[2])
	else
		target = sender
		amount = tonumber(args[1])
	end

	if not target then return notify(sender, "Player not found.") end
	if not amount then return notify(sender, "Usage: /addEmoteSpins [username] <amount>") end

	DataManager.addEmoteSpins(target, amount)
	notify(sender, ("Gave %d emote spins to %s"):format(amount, target.Name))
end

-- Testing helper: /kills <amount>  OR  /kills <username> <amount>
Commands["giveallemotes"] = function(sender, args)
	local target = args[1] and findPlayer(args[1]) or sender
	if not target then return notify(sender, "Player not found: " .. tostring(args[1])) end

	local profile = DataManager.Profiles[target]
	if not profile or not profile.Data.Emotes then
		return notify(sender, "No loaded data for " .. target.Name)
	end

	local owned = profile.Data.Emotes.OwnedEmotes
	local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes

	local added = 0
	for _, desc in EmotesFolder:GetDescendants() do
		if desc:IsA("Animation") and not table.find(owned, desc.Name) then
			table.insert(owned, desc.Name)
			added += 1
		end
	end

	-- Push the updated list so the target's emote UI builds the new cards.
	ReplicatedStorage.Remotes.Emotes.Set:FireClient(target, "UpdateOwnedEmotes", {
		OwnedEmotes = owned,
	})

	notify(sender, ("Gave %d emote(s) to %s"):format(added, target.Name))
end

-- ── Chat listener ────────────────────────────────────────────────────────────
local function onChatted(sender: Player, message: string)
	if message:sub(1, 1) ~= "/" then return end
	if not isAdmin(sender) then return end -- silently ignore non-admins

	local parts = string.split(message, " ")
	local cmd = parts[1]:sub(2):lower() -- drop the leading "/"
	table.remove(parts, 1)              -- remaining tokens are the args

	local handler = Commands[cmd]
	if not handler then return end

	local ok, err = pcall(handler, sender, parts)
	if not ok then
		warn("[ChatCommands] error in /" .. cmd .. ": " .. tostring(err))
		notify(sender, "Command errored: " .. tostring(err))
	end
end

local function hookPlayer(player: Player)
	player.Chatted:Connect(function(message)
		onChatted(player, message)
	end)
end

Players.PlayerAdded:Connect(hookPlayer)
for _, player in Players:GetPlayers() do
	hookPlayer(player) -- in case the script loads after players joined
end
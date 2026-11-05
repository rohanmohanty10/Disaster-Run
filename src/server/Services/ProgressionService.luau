--!strict
-- Player levels and XP, plus the one place rewards are granted from (GAME_PLAN.md Section 3C:
-- Spin Tokens come from matches, quests and level-ups). Daily rewards and quests call Grant().
--
-- Replicated: player attribute Level (so other players' UIs can show it).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ProgressionConfig = require(ReplicatedStorage.Shared.Config.ProgressionConfig)
local DailyConfig = require(ReplicatedStorage.Shared.Config.DailyConfig)
local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local ProgressionMath = require(ReplicatedStorage.Shared.Util.ProgressionMath)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local DataService = require(script.Parent.DataService)

local ProgressionService = {}

-- (player, newLevel)
ProgressionService.LevelUp = Signal.new()

local GOLD = Color3.fromRGB(255, 215, 90)
local CYAN = Color3.fromRGB(120, 220, 255)

local function notify(player: Player, text: string, color: Color3?)
	Remotes.Event("Notify"):FireClient(player, text, color)
end

-- Grants a reward table. Spins / Lucky Spins / Boosted Spins go to BOTH vaults.
-- Returns a short description ("+$500, +1 Spin") for toasts. Doesn't notify by itself.
function ProgressionService.Grant(player: Player, reward: DailyConfig.Reward): string
	local data = DataService.Get(player)
	if not data then
		return ""
	end
	local parts = {}
	if reward.Cash and reward.Cash > 0 then
		data.Cash += reward.Cash
		table.insert(parts, `+${reward.Cash}`)
	end
	for _, role in Kits.Roles do
		local roleData = (data :: any)[role]
		roleData.Spins += reward.Spins or 0
		roleData.LuckySpins += reward.LuckySpins or 0
		roleData.AdBoost += reward.BoostedSpins or 0
	end
	if reward.Spins and reward.Spins > 0 then
		table.insert(parts, `+{reward.Spins} Spin{if reward.Spins == 1 then "" else "s"} (both vaults)`)
	end
	if reward.LuckySpins and reward.LuckySpins > 0 then
		table.insert(parts, `+{reward.LuckySpins} Lucky Spin{if reward.LuckySpins == 1 then "" else "s"} (both vaults)`)
	end
	if reward.BoostedSpins and reward.BoostedSpins > 0 then
		table.insert(parts, `+{reward.BoostedSpins} Boosted Spins (both vaults)`)
	end
	DataService.Changed(player)
	if reward.XP and reward.XP > 0 then
		ProgressionService.AddXP(player, reward.XP)
		table.insert(parts, `+{reward.XP} XP`)
	end
	return table.concat(parts, ", ")
end

-- Adds XP and handles level-ups (with their rewards).
function ProgressionService.AddXP(player: Player, amount: number)
	local data = DataService.Get(player)
	if not data or amount <= 0 then
		return
	end
	local before = data.Level
	local level, xp, gained = ProgressionMath.AddXP(data.Level, data.XP, amount, ProgressionConfig.XPCurve, ProgressionConfig.MaxLevel)
	data.Level = level
	data.XP = xp
	DataService.Changed(player)
	if gained <= 0 then
		return
	end
	player:SetAttribute("Level", level)
	local rewards = ProgressionConfig.LevelUpRewards
	for reached = before + 1, level do
		local reward: DailyConfig.Reward = { Cash = rewards.Cash, Spins = rewards.Spins }
		if rewards.LuckySpinsEvery > 0 and reached % rewards.LuckySpinsEvery == 0 then
			reward.LuckySpins = rewards.LuckySpins
		end
		local text = ProgressionService.Grant(player, reward)
		notify(player, `LEVEL {reached}! {text}`, CYAN)
		ProgressionService.LevelUp:Fire(player, reached)
	end
end

-- Cash and XP together, with one toast (match rewards).
function ProgressionService.Reward(player: Player, cash: number, xp: number, reason: string)
	local data = DataService.Get(player)
	if data and cash > 0 then
		data.Cash += cash
		DataService.Changed(player)
	end
	if xp > 0 then
		ProgressionService.AddXP(player, xp)
	end
	local text = if cash > 0 then `+${cash}` else ""
	if xp > 0 then
		text ..= (if text ~= "" then "  " else "") .. `+{xp} XP`
	end
	if text ~= "" then
		notify(player, `{text} {reason}`, GOLD)
	end
end

function ProgressionService.Init() end

function ProgressionService.Start()
	DataService.Loaded:Connect(function(player: Player, data: any)
		player:SetAttribute("Level", data.Level)
	end)
end

return ProgressionService

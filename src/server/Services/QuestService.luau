--!strict
-- Daily quests (GAME_PLAN.md Section 3C: Spin Tokens from quests) and the daily login reward
-- (Section 3E: daily logins grant boosted spins).
--
-- Quests: each UTC day a player gets DailyConfig.QuestsPerDay quests from the pool, picked from
-- a seed of their user id and the day (stable all day). Game code reports counters with
-- QuestService.Increment(player, stat, amount); rewards are claimed from the Quests panel.
--
-- Requests: "ClaimQuest"(index), "ClaimDaily"().

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local DailyConfig = require(ReplicatedStorage.Shared.Config.DailyConfig)
local ProgressionMath = require(ReplicatedStorage.Shared.Util.ProgressionMath)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local Requests = require(script.Parent.Requests)
local DataService = require(script.Parent.DataService)
local ProgressionService = require(script.Parent.ProgressionService)

local QuestService = {}

local function today(): number
	return ProgressionMath.Day(os.time())
end

-- The quest definitions for a player on a day, in order.
function QuestService.PicksFor(userId: number, day: number): { DailyConfig.QuestDef }
	local indexes = ProgressionMath.PickIndexes(userId * 7 + day * 131, #DailyConfig.Quests, DailyConfig.QuestsPerDay)
	local list = {}
	for _, index in indexes do
		table.insert(list, DailyConfig.Quests[index])
	end
	return list
end

-- "Survive 3 rounds" from "Survive {goal} rounds".
function QuestService.Describe(quest: DailyConfig.QuestDef): string
	return (string.gsub(quest.Text, "{goal}", tostring(quest.Goal)))
end

local function definition(id: string): DailyConfig.QuestDef?
	for _, quest in DailyConfig.Quests do
		if quest.Id == id then
			return quest
		end
	end
	return nil
end

-- Rolls today's quests if the saved ones are from another day. Returns true if it changed data.
function QuestService.Refresh(player: Player): boolean
	local data = DataService.Get(player)
	if not data then
		return false
	end
	local day = today()
	if data.Quests.Day == day and #data.Quests.List > 0 then
		return false
	end
	local list = {}
	for _, quest in QuestService.PicksFor(player.UserId, day) do
		table.insert(list, { Id = quest.Id, Progress = 0, Claimed = false })
	end
	data.Quests = { Day = day, List = list }
	DataService.Changed(player)
	return true
end

-- Adds to every unclaimed quest of today that tracks `stat`.
function QuestService.Increment(player: Player, stat: string, amount: number?)
	local data = DataService.Get(player)
	if not data then
		return
	end
	QuestService.Refresh(player)
	local add = amount or 1
	if add <= 0 then
		return
	end
	local changed = false
	for _, entry in data.Quests.List do
		local quest = definition(entry.Id)
		if quest and quest.Stat == stat and not entry.Claimed and entry.Progress < quest.Goal then
			local before = entry.Progress
			entry.Progress = math.min(entry.Progress + add, quest.Goal)
			changed = true
			if before < quest.Goal and entry.Progress >= quest.Goal then
				Remotes.Event("Notify"):FireClient(player, `Quest complete: {QuestService.Describe(quest)}! Claim it in Quests.`, Color3.fromRGB(120, 255, 160))
			end
		end
	end
	if changed then
		DataService.Changed(player)
	end
end

local function claimQuest(player: Player, index: any): Requests.Result
	if type(index) ~= "number" or index % 1 ~= 0 then
		return Requests.Fail("BadIndex")
	end
	local data = DataService.Get(player)
	if not data then
		return Requests.Fail("NotLoaded", "Your data is still loading!")
	end
	QuestService.Refresh(player)
	local entry = data.Quests.List[index]
	local quest = entry and definition(entry.Id)
	if not entry or not quest then
		return Requests.Fail("BadIndex")
	end
	if entry.Claimed then
		return Requests.Fail("Claimed", "Already claimed!")
	end
	if entry.Progress < quest.Goal then
		return Requests.Fail("NotDone", "Finish the quest first!")
	end
	entry.Claimed = true
	local text = ProgressionService.Grant(player, quest.Reward)
	DataService.Changed(player)
	return { Ok = true, Text = text }
end

local function claimDaily(player: Player): Requests.Result
	local data = DataService.Get(player)
	if not data then
		return Requests.Fail("NotLoaded", "Your data is still loading!")
	end
	local day = today()
	local streak, canClaim = ProgressionMath.ClaimStreak(data.Daily.LastClaimDay, data.Daily.Streak, day)
	if not canClaim then
		return Requests.Fail("Claimed", "Come back tomorrow for your next reward!")
	end
	data.Daily.LastClaimDay = day
	data.Daily.Streak = streak
	local base = DailyConfig.Rewards[ProgressionMath.StreakIndex(streak, #DailyConfig.Rewards)]
	local reward = table.clone(base)
	reward.BoostedSpins = (reward.BoostedSpins or 0) + DailyConfig.BoostedSpinsPerClaim
	local text = ProgressionService.Grant(player, reward)
	DataService.Changed(player)
	local profile = DataService.GetProfile(player)
	if profile then
		profile:Save()
	end
	return { Ok = true, Streak = streak, Text = text }
end

function QuestService.Init()
	Requests.Register("ClaimQuest", claimQuest)
	Requests.Register("ClaimDaily", claimDaily)
end

function QuestService.Start()
	DataService.Loaded:Connect(function(player: Player)
		QuestService.Refresh(player)
	end)
	for _, player in Players:GetPlayers() do
		task.spawn(QuestService.Refresh, player)
	end
end

return QuestService

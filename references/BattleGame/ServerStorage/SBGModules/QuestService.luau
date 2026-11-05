-- ServerStorage > SBGModules > QuestService   (ModuleScript, server)
--
-- Quest progress lives in the player's ProfileStore profile (Data.QuestJournal). There's no
-- remote for clients to report progress; it only comes from the server:
--   DamageHandler -> QuestService.RecordCombat   (Kills, Damage, Blocks)
--   ItemService   -> QuestService.Add(player, "ItemsUsed", 1)
--   this module   -> Minutes, once a minute for everyone in the game
-- Claiming pays Gold and emote spins. Started by ServerScriptService > Systems > QuestBootstrap.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local DataManager = require(game:GetService("ServerScriptService").Data.DataManager)
local QuestConfig = require(ReplicatedStorage.Modules.QuestConfig)

local QuestService = {}

local LastRequest: { [Player]: number } = {}
local Dirty: { [Player]: true } = {}
local LastBlock: { [Player]: number } = {}
local LastKill: { [Player]: { [number]: number } } = {}
local CountedDeaths = setmetatable({}, { __mode = "k" })
local Changed: RemoteEvent? = nil

local function Journal(Player: Player)
	local Profile = DataManager.Profiles[Player]
	if not Profile or (Profile.IsActive and not Profile:IsActive()) then
		return nil
	end
	local Data = Profile.Data
	if type(Data.QuestJournal) ~= "table" or Data.QuestJournal.Version ~= QuestConfig.Version then
		Data.QuestJournal = { Version = QuestConfig.Version, Periods = {} }
	end
	local Book = Data.QuestJournal
	local Now = os.time()
	for _, Category in QuestConfig.Categories do
		local Key = QuestConfig.Period(Category, Now)
		if not Book.Periods[Category] or Book.Periods[Category].Key ~= Key then
			Book.Periods[Category] = { Key = Key, Progress = {}, Claimed = {} }
		end
	end
	return Book
end

function QuestService.Snapshot(Player: Player)
	local Book = Journal(Player)
	if not Book then
		return nil
	end
	local Result = { Periods = {}, ServerTime = os.time() }
	for _, Category in QuestConfig.Categories do
		local Key, ResetAt = QuestConfig.Period(Category, Result.ServerTime)
		local Period = Book.Periods[Category]
		Result.Periods[Category] = { Key = Key, ResetAt = ResetAt, Progress = table.clone(Period.Progress), Claimed = table.clone(Period.Claimed) }
	end
	return Result
end

-- Adds to every unclaimed quest using this metric
function QuestService.Add(Player: Player, Metric: string, Amount: number)
	if type(Amount) ~= "number" or Amount ~= Amount or Amount <= 0 or Amount == math.huge then
		return
	end
	local Book = Journal(Player)
	if not Book then
		return
	end
	local Character = Player:GetAttribute("Character")
	for _, Category in QuestConfig.Categories do
		-- character quests only count while playing as that character
		if QuestConfig.Permanent[Category] and Character ~= Category then
			continue
		end
		local Period = Book.Periods[Category]
		for _, Quest in QuestConfig.Quests[Category] do
			if Quest.Metric == Metric and not Period.Claimed[Quest.Id] then
				Period.Progress[Quest.Id] = math.min(Quest.Goal, (Period.Progress[Quest.Id] or 0) + Amount)
			end
		end
	end
	Dirty[Player] = true
end

-- Called by DamageHandler for every hit between players
function QuestService.RecordCombat(AttackerCharacter: Model?, TargetHumanoid: Humanoid?, HealthBefore: number, WasBlocked: boolean)
	-- no farming in private servers (except while testing in Studio)
	if game.PrivateServerId ~= "" and not (RunService:IsStudio() and QuestConfig.AllowStudioProgress) then
		return
	end
	if RunService:IsStudio() and not QuestConfig.AllowStudioProgress then
		return
	end
	if not AttackerCharacter or not TargetHumanoid or not TargetHumanoid.Parent or HealthBefore <= 0 then
		return
	end
	local Attacker = Players:GetPlayerFromCharacter(AttackerCharacter)
	local Target = Players:GetPlayerFromCharacter(TargetHumanoid.Parent)
	if not Attacker or not Target or Attacker == Target then
		return
	end
	local Now = os.clock()
	if WasBlocked then
		if Now - (LastBlock[Target] or -math.huge) >= 0.45 then
			LastBlock[Target] = Now
			QuestService.Add(Target, "Blocks", 1)
		end
		return
	end
	local Damage = math.clamp(HealthBefore - TargetHumanoid.Health, 0, HealthBefore)
	if Damage <= 0 then
		return
	end
	QuestService.Add(Attacker, "Damage", Damage)
	if TargetHumanoid.Health <= 0 and not CountedDeaths[TargetHumanoid] then
		CountedDeaths[TargetHumanoid] = true
		LastKill[Attacker] = LastKill[Attacker] or {}
		local Previous = LastKill[Attacker][Target.UserId] or -math.huge
		if Now - Previous >= 60 then -- killing the same person over and over counts once a minute
			LastKill[Attacker][Target.UserId] = Now
			QuestService.Add(Attacker, "Kills", 1)
		end
	end
end

function QuestService.Claim(Player: Player, Category: string, Id: string, ExpectedKey: string)
	if type(Category) ~= "string" or type(Id) ~= "string" or type(ExpectedKey) ~= "string" then
		return false, "Invalid quest."
	end
	local Quest = QuestConfig.Find(Category, Id)
	local Book = Journal(Player)
	if not Quest or not Book then
		return false, "Your quests are still loading."
	end
	local Period = Book.Periods[Category]
	if ExpectedKey ~= Period.Key then
		return false, "This quest has reset. Check the new goals."
	end
	if Period.Claimed[Id] then
		return false, "Already claimed."
	end
	if (Period.Progress[Id] or 0) < Quest.Goal then
		return false, "Finish the objective first."
	end
	-- no yield between checking, marking and paying: a double request can't pay twice
	Period.Claimed[Id] = true
	if not DataManager.addGold(Player, Quest.Gold or 0) then
		Period.Claimed[Id] = nil
		return false, "Your data is unavailable. Try again."
	end
	if Quest.Spins and Quest.Spins > 0 then
		DataManager.addEmoteSpins(Player, Quest.Spins)
	end
	if Category == "Daily" then
		QuestService.Add(Player, "DailyClaims", 1)
	end
	Dirty[Player] = true
	local Text = `+{Quest.Gold or 0} Gold`
	if Quest.Spins then
		Text ..= ` +{Quest.Spins} Spin{if Quest.Spins > 1 then "s" else ""}`
	end
	return true, Text
end

function QuestService.Start()
	if Changed then
		return
	end
	local Root = ReplicatedStorage:WaitForChild("Remotes")
	local Folder = Root:FindFirstChild("Quests") or Instance.new("Folder")
	Folder.Name = "Quests"
	Folder.Parent = Root
	local function Remote(ClassName: string, Name: string): any
		local Object = Folder:FindFirstChild(Name) or Instance.new(ClassName)
		Object.Name = Name
		Object.Parent = Folder
		return Object
	end
	Changed = Remote("RemoteEvent", "Changed")
	local Request: RemoteFunction = Remote("RemoteFunction", "Request")
	Request.OnServerInvoke = function(Player: Player, Action: any, Category: any, Id: any, Key: any)
		local Now = os.clock()
		if Now - (LastRequest[Player] or -math.huge) < 0.2 then
			return false, "Please wait a moment."
		end
		LastRequest[Player] = Now
		if Action == "Get" then
			local State = QuestService.Snapshot(Player)
			return State ~= nil, State or "Your quests are still loading."
		elseif Action == "Claim" then
			local Ok, Message = QuestService.Claim(Player, Category, Id, Key)
			return Ok, Message, QuestService.Snapshot(Player)
		elseif Action == "ClaimAll" then
			if type(Key) ~= "table" then
				return false, "Invalid quest periods."
			end
			local Count = 0
			-- dailies first, so the "claim N dailies" quests can finish in the same go
			for _, Group in QuestConfig.Categories do
				for _, Quest in QuestConfig.Quests[Group] do
					if QuestService.Claim(Player, Group, Quest.Id, Key[Group]) then
						Count += 1
					end
				end
			end
			return Count > 0, if Count > 0 then `Claimed {Count} reward{if Count > 1 then "s" else ""}!` else "No finished quests to claim.", QuestService.Snapshot(Player)
		end
		return false, "Unknown quest request."
	end
	Players.PlayerRemoving:Connect(function(Player)
		Dirty[Player] = nil
		LastRequest[Player] = nil
		LastBlock[Player] = nil
		LastKill[Player] = nil
	end)

	-- once a second: send changed quests; once a minute: count playtime; at midnight UTC:
	-- refresh everyone so the new dailies show up
	task.spawn(function()
		local LastDay = math.floor(os.time() / 86400)
		local Seconds = 0
		while (Changed :: RemoteEvent).Parent do
			task.wait(1)
			Seconds += 1
			if Seconds >= 60 then
				Seconds = 0
				for _, Player in Players:GetPlayers() do
					QuestService.Add(Player, "Minutes", 1)
				end
			end
			local Day = math.floor(os.time() / 86400)
			if Day ~= LastDay then
				LastDay = Day
				for _, Player in Players:GetPlayers() do
					Dirty[Player] = true
				end
			end
			for Player in Dirty do
				Dirty[Player] = nil
				if Player.Parent == Players then
					local State = QuestService.Snapshot(Player)
					if State then
						(Changed :: RemoteEvent):FireClient(Player, State)
					end
				end
			end
		end
	end)
end

return QuestService

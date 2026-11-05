local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local module = {}

local KillstreakAssets = game.ServerStorage.Assets.Models.Killstreak
local ComSet: RemoteEvent = game.ReplicatedStorage.Remotes.Comunicator.Set

-- Streak announcements and bounties. Once a streak reaches BOUNTY_START, whoever ends it takes
-- the bounty on top of their normal kill Gold. The bounty is also the character's "Bounty" attribute.
local ANNOUNCE_EVERY = 5 -- chat announcement at 5, 10, 15... kills
local BOUNTY_START = 5
local BOUNTY_PER_KILL = 15 -- Gold per kill in the streak
local BOUNTY_MAX = 600

local function Chat(Tag: string, Color: string, Text: string)
	ComSet:FireAllClients("ChatMessage", `<font face='GothamBold' color='#{Color}'>[{Tag}]</font> <font face='GothamBold'>{Text}</font>`)
end

function module:GetBounty(Character: Model): number
	local Streak = Character:GetAttribute("Streak") or 0
	if Streak < BOUNTY_START then
		return 0
	end
	return math.min(Streak * BOUNTY_PER_KILL, BOUNTY_MAX)
end

-- DamageHandler calls this once a kill is counted (after the killer's Streak went up).
-- Returns the bounty Gold the killer earned from the victim.
function module:OnKill(Damager: Model, Damaged: Model): number
	local Killer = Players:GetPlayerFromCharacter(Damager)
	local Victim = Players:GetPlayerFromCharacter(Damaged)

	local Claimed = if Victim then module:GetBounty(Damaged) else 0
	if Killer and Victim and Claimed > 0 then
		Chat("BOUNTY", "FFC23D", `{Killer.DisplayName} ended {Victim.DisplayName}'s {Damaged:GetAttribute("Streak")} kill streak and claimed {Claimed} Gold!`)
	end

	local Streak = Damager:GetAttribute("Streak") or 0
	local Bounty = module:GetBounty(Damager)
	Damager:SetAttribute("Bounty", Bounty)
	if Killer and Streak > 0 and Streak % ANNOUNCE_EVERY == 0 then
		Chat(`{Streak} KILLSTREAK`, "FF3B3B", `{Killer.DisplayName} (@{Killer.Name}) is on a rampage! Bounty: {Bounty} Gold`)
	end

	return Claimed
end

function module:AddKillstreak(Character: Model)
	local Player = Players:GetPlayerFromCharacter(Character)
	if not Player then return end

	local HighestStreak = 0
	for _, EnemyCharacter: Model in workspace.World.Live.Players:GetChildren() do
		if EnemyCharacter == Character then continue end

		local EnemyStreak = EnemyCharacter:GetAttribute('EnemyStreak') or 0

		if EnemyStreak > HighestStreak then
			HighestStreak = EnemyStreak
		end
	end

	if (Character:GetAttribute('Streak') or 0) >= HighestStreak then
		for _, EnemyCharacter: Model in workspace.World.Live.Players:GetChildren() do
			module:RemoveKillstreak(EnemyCharacter)
		end

		Character:AddTag('HighestStreak')

		local Gui = KillstreakAssets.KillstreakGui:Clone()
		local streakImage = Gui.Frame.ImageLabel
		local streakText = Gui.Frame.TextLabel
		Gui.Parent = Character.Head

		local Highlight = KillstreakAssets.KillstreakHL:Clone()
		Highlight.Parent = Character

		local C, C2, C3
		C = Character:GetAttributeChangedSignal('Streak'):Connect(function()
			Gui.Frame.TextLabel.Text = tostring(Character:GetAttribute('Streak'))

			local currentStreak = Character:GetAttribute('Streak')
			local newColor
			if currentStreak > 10 and currentStreak <= 100 then
				newColor = 255 - (25.5 * (currentStreak/10))

				TS:Create(Highlight, TweenInfo.new(.5), { OutlineColor = Color3.fromRGB(255, newColor, 0) }):Play()
				TS:Create(streakImage, TweenInfo.new(.5), { ImageColor3 = Color3.fromRGB(255, newColor, newColor) }):Play()
				TS:Create(streakText, TweenInfo.new(.5), { TextColor3 = Color3.fromRGB(255, newColor, 0) }):Play()
			elseif currentStreak <= 10 then
				newColor = 255
			else
				newColor = 0
			end

			TS:Create(Highlight, TweenInfo.new(.5), { OutlineColor = Color3.fromRGB(255, newColor, 0) }):Play()
			TS:Create(streakImage, TweenInfo.new(.5), { ImageColor3 = Color3.fromRGB(255, newColor, newColor) }):Play()
			TS:Create(streakText, TweenInfo.new(.5), { TextColor3 = Color3.fromRGB(255, newColor, 0) }):Play()
		end)

		Gui.Frame.TextLabel.Text = tostring(Character:GetAttribute('Streak'))

		C2 = Character:GetPropertyChangedSignal('Parent'):Connect(function()
			if Character.Parent == nil then
				C:Disconnect()
				C2:Disconnect()
				if C3 then C3:Disconnect() end
			end
		end)

		-- VIP "Hide Killstreak" setting. It's saved in Player.Configuration by DataManager.setSetting
		-- (the server only accepts it from VIP players), so read it from there.
		local Config = Player:FindFirstChild("Configuration")
		local HideSetting = Config and Config:FindFirstChild("Hide Killstreak")

		local function applyHide()
			local hide = Player:GetAttribute("HasVIP") == true and HideSetting ~= nil and HideSetting.Value == true
			Gui.Enabled = not hide
			Highlight.Enabled = not hide
		end
		applyHide()

		if HideSetting then
			C3 = HideSetting.Changed:Connect(function()
				if not Gui.Parent or not Highlight.Parent then
					return C3:Disconnect()
				end
				applyHide()
			end)
		end
	end
end

function module:RemoveKillstreak(Character: Model)
	Character:RemoveTag('HighestStreak')

	local Gui = Character.Head:FindFirstChild('KillstreakGui')
	if Gui then
		Gui:Destroy()
	end

	local Highlight = Character:FindFirstChild('KillstreakHL')
	if Highlight then
		Highlight:Destroy()
	end
end

return module

-- Titles menu (client)
--
-- Builds the title selection list from the styled TextLabel templates that live
-- in ReplicatedStorage.Assets.Cosmetics.Titles. Each template carries attributes
-- that drive its unlock rule:
--   Requirement (number)  - threshold to unlock
--   ReqType     (string)  - "Kills" (default) / "Emotes" / "Awakens" / "TreesDestroyed"
--                           / "WallCombo" / "Counters" / "Killstreak"
--                           / "Special" / "VIP"
--   LayoutOrder (number)  - order in the list
--   ID          (number)  - UserId, for Special (dev/staff) titles
--   Description (string, optional)   ProgressColor (Color3, optional)
--
-- Equipping is server-authoritative: clicking a title just asks the server via
-- Remotes.Cosmetics.Set (the same pipeline accessories/auras use). The server
-- re-checks the requirement, saves it, sets the player's EquippedTitle/TitleColor
-- attributes (which the chat hook reads) and builds the over-head name-tag. This
-- script only reacts to those attributes to update the highlight and preview.


-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService    = game:GetService("Players")
local TweenService      = game:GetService("TweenService")


-- Local Player
local LocalPlayer = PlayersService.LocalPlayer
repeat task.wait() until game:IsLoaded() and LocalPlayer:GetAttribute("Loaded") == true --and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Remotes
local Remotes     = ReplicatedStorage:WaitForChild("Remotes")
local CosmeticSet = Remotes.Cosmetics:WaitForChild("Set") -- equip/unequip ride the cosmetics pipeline


-- Assets (the styled title labels now live in ReplicatedStorage so the client can render them)
local Assets      = ReplicatedStorage:WaitForChild("Assets")
local Cosmetics   = Assets:WaitForChild("Cosmetics")
local TitleAssets = Cosmetics:WaitForChild("Titles")


-- GUI
local GUI = script.Parent
local ContainerFrame = GUI.Frame
local TitleList = ContainerFrame.TitleList.TitleList
local TitlesScroll = TitleList.Scroll.Container
local TitlesLayout = TitlesScroll.UIListLayout
local PreviewLabel = TitleList.Preview:FindFirstChild("Label", true) -- found even if you move it into TitleRow

local TitleTemplate = script.TitleTemplate
local LockedTemplate = script.Locked


-- Local Functions
local function GetNameValue(Name)
	local NameValue = 0

	for i = 1, #Name do
		local BytedString = string.byte((string.sub(Name, i, i)))
		local CurrentLetter = #Name - i + 1

		if #Name % 2 == 1 then
			CurrentLetter -= 1
		end

		if CurrentLetter % 4 >= 2 then
			BytedString = -BytedString
		end

		NameValue += BytedString
	end

	return NameValue
end

local function FormatNumber(number: number)
	if not number then
		return "nil"
	end

	return tostring(number):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end


-- Config
local MainTweenInfo = TweenInfo.new(0.162, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

-- Card layout tuning (all in pixels)
local CARD_HEIGHT  = 110                        -- height of each title card; lower = more compact
local BAR_HEIGHT   = 6                          -- thickness of the kill-progress bar
local BAR_BG_COLOR = Color3.fromRGB(20, 20, 20) -- track colour behind the fill

local RequirementFormats = {
	Kills          = { "%s KILL",            true  },
	Emotes         = { "OWN %s EMOTE",       true  },
	Cosmetics      = { "OWN %s COSMETIC",    true  },
	Awakens        = { "AWAKEN %s TIME",     true  },
	TreesDestroyed = { "DESTROY %s TREE",    true  },
	WallCombo      = { "WALL COMBO %s TIME", true  },
	Counters       = { "COUNTER %s TIME",    true  },
	Killstreak     = { "%s KILLSTREAK",      false },
}
local ProgressFormats = {
	Killstreak = "YOUR HIGHEST: %s"
}

local DisplayColors = {
	Color3.new(0.9921568627450981, 0.1607843137254902, 0.2627450980392157),
	Color3.new(0.00392156862745098, 0.6352941176470588, 1),
	Color3.new(0.00784313725490196, 0.7215686274509804, 0.3411764705882353),
	BrickColor.new("Bright violet").Color,
	BrickColor.new("Bright orange").Color,
	BrickColor.new("Bright yellow").Color,
	BrickColor.new("Light reddish violet").Color,
	BrickColor.new("Brick yellow").Color
}
local DisplayColor = DisplayColors[GetNameValue(LocalPlayer.Name) % #DisplayColors + 1]:ToHex()


-- State
local EquipTweens   = {}
local UnequipTweens = {}
local Cards         = {} -- title name -> { Frame, Text, Color, ReqType, Requirement, ID, ProgressColor }

-- Progress source: titles are gated by the player's Total Kills leaderstat.
local leaderKills = LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Total Kills")


-- Helpers
local function getProgress(reqType: string): number
	-- All numeric requirements read Total Kills from leaderstats. If you later add
	-- titles gated by a different stat, map its ReqType to the right leaderstat here.
	return leaderKills.Value
end

-- Client-side unlock hint (the server is the real authority on equip).
local function isUnlocked(info): boolean
	if info.ReqType == "Special" then
		return info.ID == LocalPlayer.UserId
	elseif info.ReqType == "VIP" then
		return LocalPlayer:GetAttribute("HasVIP") == true
	end
	return getProgress(info.ReqType) >= (info.Requirement or 0)
end

local function playClickSfx()
	if not shared.sfx then return end
	shared.sfx({
		SoundId = "rbxassetid://552900451",
		Parent = workspace,
		Volume = 0.35,
	}):Play()
end

-- Copies the styled label's look (text, colour, font, gradient/stroke) onto the
-- card's placeholder Title so the menu shows each title's real appearance.
local function styleCardTitle(cardTitle: TextLabel, styled: TextLabel)
	cardTitle.Text = styled.Text
	cardTitle.TextColor3 = styled.TextColor3
	cardTitle.FontFace = styled.FontFace

	for _, child in styled:GetChildren() do
		if child:IsA("UIGradient") or child:IsA("UIStroke") then
			local existing = cardTitle:FindFirstChildOfClass(child.ClassName)
			if existing then existing:Destroy() end
			child:Clone().Parent = cardTitle
		end
	end
end

-- Spotlight glow: you build it in Studio (a Frame named "Spotlight" inside your
-- TitleTemplate, behind the Title — size/round it, add a UIGradient + transparency
-- however you like). The script only sets its COLOUR per title so it auto-contrasts:
-- a light glow behind dark titles, a dark glow behind light ones. You can override
-- these two colours per-card by adding LightColor / DarkColor (Color3) attributes
-- to the Spotlight frame in Studio.
local SPOTLIGHT_LIGHT_COLOR = Color3.fromRGB(255, 245, 225) -- glow behind DARK titles
local SPOTLIGHT_DARK_COLOR  = Color3.fromRGB(10, 10, 15)    -- glow behind LIGHT titles

-- Read-only: a title's visible brightness (gradient average, else TextColor3).
-- Used ONLY to choose the glow colour; it never modifies the title.
local function getTitleLuminance(styled: TextLabel): number
	local color = styled.TextColor3

	local gradient = styled:FindFirstChildOfClass("UIGradient")
	if gradient then
		local kps = gradient.Color.Keypoints
		local r, g, b = 0, 0, 0
		for _, kp in kps do
			r += kp.Value.R
			g += kp.Value.G
			b += kp.Value.B
		end
		color = Color3.new(r / #kps, g / #kps, b / #kps)
	end

	return 0.299 * color.R + 0.587 * color.G + 0.114 * color.B
end

-- Tints the Studio-made "Spotlight" frame in a card to auto-contrast the title.
-- Everything else about the glow (size, shape, transparency, edge fade) is yours
-- to set in Studio; this only picks its colour. Does nothing if there's no Spotlight.
local function applySpotlightColor(card: Frame, styled: TextLabel)
	local glow = card:FindFirstChild("Spotlight", true)
	if not glow then return end

	local light = glow:GetAttribute("LightColor") or SPOTLIGHT_LIGHT_COLOR
	local dark = glow:GetAttribute("DarkColor") or SPOTLIGHT_DARK_COLOR
	local color = (getTitleLuminance(styled) < 0.5) and light or dark

	if glow:IsA("ImageLabel") then
		glow.ImageColor3 = color   -- radial-glow image
	else
		glow.BackgroundColor3 = color -- plain Frame glow
	end
end

-- Preview replicates how your message actually looks in chat: the equipped title
-- (in its chat colour, with brackets) then your name and a sample line. It's plain
-- rich text on a single label, so it matches chat exactly — chat can't render
-- gradients/custom fonts, so the preview deliberately shows the same flat look.
-- Brackets are on the title only; the name has none.
local function setPreview(info)
	if info then
		local titleColor = LocalPlayer:GetAttribute("TitleColor") or info.Color
		PreviewLabel.Text = "<font color='#" .. titleColor:ToHex() .. "'>[" .. info.Text .. "]</font> <font color='#" .. DisplayColor .. "'>" .. LocalPlayer.DisplayName .. ":</font> Greetings!"
	else
		PreviewLabel.Text = "<font color='#" .. DisplayColor .. "'>" .. LocalPlayer.DisplayName .. ":</font> Greetings!"
	end
end

-- Reflects the server-set EquippedTitle attribute (which holds the title's
-- display text) onto the list highlight and the chat preview.
local function refreshEquipped()
	local equippedName = LocalPlayer:GetAttribute("EquippedTitleName")
	local equippedInfo = equippedName and Cards[equippedName] or nil

	for name in Cards do
		if name == equippedName then
			EquipTweens[name]:Play()
		else
			UnequipTweens[name]:Play()
		end
	end

	setPreview(equippedInfo)
end


-- Creates (or fetches) the thin kill-progress bar at the bottom of a card and
-- returns its Fill frame. Mirrors the accessory cards' bar in CosmeticsLocalScript.
local function getOrCreateProgressBar(card): Frame
	local bar = card:FindFirstChild("TitleProgressBar")
	if bar then
		return bar:FindFirstChild("Fill")
	end

	bar = Instance.new("Frame")
	bar.Name = "TitleProgressBar"
	bar.AnchorPoint = Vector2.new(0.5, 1)
	bar.Position = UDim2.new(0.5, 0, 1, -4)
	bar.Size = UDim2.new(1, -12, 0, BAR_HEIGHT)
	bar.BackgroundColor3 = BAR_BG_COLOR
	bar.BorderSizePixel = 0
	bar.ZIndex = 5

	local trackCorner = Instance.new("UICorner")
	trackCorner.CornerRadius = UDim.new(0, BAR_HEIGHT / 2)
	trackCorner.Parent = bar

	local fill = Instance.new("Frame")
	fill.Name = "Fill"
	fill.Size = UDim2.new(0, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(200, 40, 40)
	fill.BorderSizePixel = 0
	fill.ZIndex = 6

	local fillCorner = Instance.new("UICorner")
	fillCorner.CornerRadius = UDim.new(0, BAR_HEIGHT / 2)
	fillCorner.Parent = fill

	fill.Parent = bar
	bar.Parent = card

	return fill
end


-- Build one card from a styled title label
local function buildCard(styled: TextLabel)
	local reqType = styled:GetAttribute("ReqType") or "Kills"
	local id = styled:GetAttribute("ID")

	-- Special (dev/staff) titles are only shown to the matching player.
	if reqType == "Special" and id ~= LocalPlayer.UserId then
		return
	end

	local name = styled.Name

	local card = TitleTemplate:Clone()
	card.Name = name
	card.LayoutOrder = styled:GetAttribute("LayoutOrder") or 0
	card.Size = UDim2.new(card.Size.X.Scale, card.Size.X.Offset, 0, CARD_HEIGHT)
	styleCardTitle(card.Title, styled)
	applySpotlightColor(card, styled)
	if card:FindFirstChild("Description") then
		card.Description.Text = styled:GetAttribute("Description") or ""
	end

	local info = {
		Frame = card,
		Source = styled,
		Text = styled.Text,
		Color = styled.TextColor3,
		ReqType = reqType,
		Requirement = styled:GetAttribute("Requirement") or 0,
		ID = id,
		ProgressColor = styled:GetAttribute("ProgressColor") or styled.TextColor3,
	}
	Cards[name] = info

	EquipTweens[name] = TweenService:Create(card.Background, MainTweenInfo, { BackgroundTransparency = 0.5 }) --.21
	UnequipTweens[name] = TweenService:Create(card.Background, MainTweenInfo, { BackgroundTransparency = .9 }) --.5

	-- Locked overlay + kill-progress bar, shown until the title unlocks.
	local function updateLock()
		local lock = card:FindFirstChild("Locked")
		local bar = card:FindFirstChild("TitleProgressBar")

		if isUnlocked(info) then
			if lock then lock:Destroy() end
			if bar then bar:Destroy() end
			return
		end

		lock = lock or LockedTemplate:Clone()

		if reqType == "VIP" then
			lock.Label.Text = "VIP GAMEPASS"
			lock.Progress.Text = ""
			if bar then bar:Destroy() end -- VIP is binary; no bar
		else
			local format = RequirementFormats[reqType]
			local requirement = info.Requirement
			local progress = getProgress(reqType)

			local suffix = ""
			if format and format[2] == true and requirement > 1 then
				suffix = "S"
			end
			lock.Label.Text = format and (string.format(format[1], FormatNumber(requirement)) .. suffix)
				or (FormatNumber(requirement) .. " REQUIRED")

			-- The bar shows how far along you are, so no numeric ratio is shown.
			local progressFormat = ProgressFormats[reqType]
			if progressFormat then
				lock.Progress.Text = string.format(progressFormat, FormatNumber(progress))
			else
				lock.Progress.Text = ""
			end

			-- Red→green fill, matching the accessory cards (UpdateFrameVisuals).
			local pct = math.clamp(progress / math.max(requirement, 1), 0, 1)
			local fill = getOrCreateProgressBar(card)
			fill.Size = UDim2.new(pct, 0, 1, 0)
			fill.BackgroundColor3 = Color3.fromHSV(pct * (120 / 360), 0.85, 0.75)
		end

		lock.Progress.TextColor3 = info.ProgressColor
		lock.Parent = card
	end

	updateLock()

	-- Keep the lock overlay live as the player's kills change.
	if reqType == "VIP" then
		LocalPlayer:GetAttributeChangedSignal("HasVIP"):Connect(updateLock)
	elseif reqType ~= "Special" then
		leaderKills:GetPropertyChangedSignal("Value"):Connect(updateLock)
	end

	-- Toggle equip/unequip through the server (server re-validates the unlock).
	card.Button.MouseButton1Click:Connect(function()
		playClickSfx()
		if not isUnlocked(info) then return end

		local currentlyEquipped = (LocalPlayer:GetAttribute("EquippedTitleName") == name)
		CosmeticSet:FireServer({
			Type = "Titles",
			Name = name,
			State = currentlyEquipped and "Unequip" or "Equip",
		})
	end)

	card.Parent = TitlesScroll
end


-- Build the list
for _, styled in TitleAssets:GetChildren() do
	if styled:IsA("TextLabel") then
		buildCard(styled)
	end
end

refreshEquipped()

-- Update highlight/preview whenever the server changes the equipped title
-- (equip, unequip, or the per-spawn re-equip on respawn).
LocalPlayer:GetAttributeChangedSignal("EquippedTitleName"):Connect(refreshEquipped)

TitlesScroll.Parent.CanvasSize = UDim2.new(0, TitlesLayout.AbsoluteContentSize.X, 0, TitlesLayout.AbsoluteContentSize.Y + 10)
GUI:SetAttribute("Loaded", true)

GUI:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	TitlesScroll.Parent.CanvasSize = UDim2.new(0, TitlesLayout.AbsoluteContentSize.X, 0, TitlesLayout.AbsoluteContentSize.Y + 10)
end)
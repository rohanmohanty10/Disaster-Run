--!strict
-- Drives both gacha screens (GodVault and RunnerVault). Behaviour follows the reference
-- vault screen: slots with locks and equip, normal + lucky spins with a name-flashing reel,
-- pity counters, an odds list where clicking a kit boosts it, a confirm prompt before spinning
-- away a good kit, buy-spin panels and a Permanent Vault panel for Mythical/Secret kits.

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)
local GachaConfig = require(ReplicatedStorage.Shared.Config.GachaConfig)
local UIConfig = require(ReplicatedStorage.Shared.Config.UIConfig)
local Roller = require(ReplicatedStorage.Shared.Gacha.Roller)
local Banners = require(ReplicatedStorage.Shared.Gacha.Banners)
local Format = require(ReplicatedStorage.Shared.Util.Format)

local Net = require(script.Parent.Net)
local DataController = require(script.Parent.DataController)
local UIController = require(script.Parent.UIController)
local ShowcaseStage = require(script.Parent.ShowcaseStage)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
local Assets = ReplicatedStorage:WaitForChild("Assets")
local AssetUI = Assets:WaitForChild("UI")

local ERROR_COLOR = Color3.new(1, 0.458824, 0.466667)
local GOOD_COLOR = Color3.fromRGB(120, 255, 140)

-- Which odds folder each table is shown in.
local ODDS_FOLDERS = {
	Normal = "NormalRarities",
	Lucky = "LuckyRarities",
	Boosted = "BoostedRarities",
}

local Vault = {}
Vault.__index = Vault

local canSkipCache: boolean? = nil

local function canSkip(): boolean
	if GachaConfig.SkipSpinGamePassId == 0 then
		return true
	end
	if canSkipCache == nil then
		local ok, owns = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, LocalPlayer.UserId, GachaConfig.SkipSpinGamePassId)
		canSkipCache = ok and owns == true
	end
	return canSkipCache == true
end

-- Puts a rarity's gradient on a text label (white text over a gradient, black outline).
local function paintRarity(label: TextLabel | TextButton, rarity: string, desaturate: boolean?)
	for _, child in label:GetChildren() do
		if child:IsA("UIGradient") then
			child:Destroy()
		end
	end
	local source = AssetUI.RarityGradients:FindFirstChild(rarity) :: UIGradient?
	if source then
		local gradient = source:Clone()
		if desaturate then
			-- Same trick as the reference odds rows: fade the gradient's end toward grey.
			local first = gradient.Color.Keypoints[1].Value
			local h, s, v = first:ToHSV()
			gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, first),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(h, math.max(s - 0.6, 0), v)),
			})
		end
		gradient.Parent = label
		label.TextColor3 = Color3.new(1, 1, 1)
	else
		label.TextColor3 = Rarities.Colors[rarity] or Color3.new(1, 1, 1)
	end
	local stroke = label:FindFirstChildOfClass("UIStroke")
	if stroke then
		stroke.Color = Color3.new(0, 0, 0)
	end
end

local function setFolderVisible(folder: Instance, visible: boolean)
	for _, child in folder:GetChildren() do
		if child:IsA("GuiObject") then
			child.Visible = visible
		end
	end
end

function Vault.new(role: Kits.Role, guiName: string)
	local self = setmetatable({}, Vault)
	self.Role = role
	self.Gui = PlayerGui:WaitForChild(guiName) :: ScreenGui
	self.BG = self.Gui:WaitForChild("BG") :: Frame
	self.Spinning = false
	self.SkipRequested = false
	self.PendingSpin = nil :: string?
	self.OddsMode = "Normal" -- "Normal" or "Lucky"
	self.Expanded = {} :: { [string]: string? } -- [folder name] = expanded rarity
	self.OddsKey = ""
	self.VaultKey = ""
	self.SlotTemplate = (self.BG.Slots :: any).Slot1:Clone()
	self.Blackout = nil :: Frame?
	return self
end

function Vault.RoleData(self: any): any?
	local data = DataController.Data
	return data and data[self.Role]
end

function Vault.EquippedKit(self: any): string
	local rd = self:RoleData()
	if not rd then
		return ""
	end
	if rd.VaultEquipped ~= "" then
		return rd.VaultEquipped
	end
	return rd.Slots[rd.Selected] or ""
end

function Vault.IsOpen(self: any): boolean
	return self.Gui.Enabled
end

-- ------------------------------------------------------------------ title / description
function Vault.ShowKit(self: any, kitId: string)
	local BG = self.BG
	local kit = if kitId ~= "" then Kits.Get(self.Role, kitId) else nil
	if kit then
		BG.KitName.Text = string.upper(kit.Name)
		BG.Desc.Text = kit.Desc
		paintRarity(BG.KitName, kit.Rarity)
	else
		BG.KitName.Text = "EMPTY SLOT"
		BG.Desc.Text = "Spin to roll a kit into this slot!"
		paintRarity(BG.KitName, "Common")
	end
end

-- ------------------------------------------------------------------ refresh
function Vault.RefreshCounters(self: any)
	local data = DataController.Data
	local rd = self:RoleData()
	if not data or not rd then
		return
	end
	local BG = self.BG
	BG.Spin.Left.Text = if rd.Spins > 0 then `{rd.Spins} Spins` else Format.Cash(GachaConfig.CashSpinCost)
	BG.LuckySpin.Left.Text = `{math.max(rd.LuckySpins, 0)} Spins`
	BG.CurrencyPitty.Pity.Text = `Pity: {rd.Pity.Normal}/{GachaConfig.Pity.Normal} Done`
	BG.CurrencyPitty.LuckyPity.Text = `Lucky Pity: {rd.Pity.LuckyMythical}/{GachaConfig.Pity.LuckyMythical} Done`
	BG.CurrencyPitty.BG.Currency.Text = Format.Cash(data.Cash)

	-- Live event banner (GAME_PLAN.md 3B).
	local banner = Banners.Active(self.Role, workspace:GetServerTimeNow())[1]
	if self.BannerLabel then
		self.BannerLabel.Visible = banner ~= nil
		if banner then
			local left = math.max(banner.ExpiresAt - workspace:GetServerTimeNow(), 0)
			local days = math.floor(left / 86400)
			local hours = math.floor(left % 86400 / 3600)
			self.BannerLabel.Text = `★ EVENT: {string.upper(banner.Name)} · ends in {days}d {hours}h ★`
		end
	end
	self:RefreshAuto()
end

function Vault.RefreshSlots(self: any)
	local rd = self:RoleData()
	if not rd then
		return
	end
	for i = 1, GachaConfig.MaxSlots do
		local slot = self.BG.Slots:FindFirstChild(`Slot{i}`)
		if not slot then
			continue
		end
		local kitId = rd.Slots[i] or ""
		local kit = if kitId ~= "" then Kits.Get(self.Role, kitId) else nil
		local equipped = i == rd.Selected and rd.VaultEquipped == ""
		if i <= rd.MaxSlots then
			if kit then
				slot.KitName.Text = kit.Name
				slot.ImageColor3 = Rarities.Colors[kit.Rarity]
			else
				slot.KitName.Text = "Empty"
				slot.ImageColor3 = Color3.fromRGB(150, 150, 150)
			end
			slot.EquipTxt.Visible = true
			slot.EquipTxt.Text = if equipped then "EQUIPPED" else "EQUIP"
			slot.Lock.Visible = true
			slot.Lock.Image = if rd.Locked[i] then UIConfig.LockImages.Locked else UIConfig.LockImages.Unlocked
		else
			slot.KitName.Text = if i == rd.MaxSlots + 1 then "BUY SLOT" else "LOCKED"
			slot.ImageColor3 = Color3.fromRGB(49, 49, 49)
			slot.EquipTxt.Visible = false
			slot.Lock.Visible = false
		end
	end
end

function Vault.RefreshVault(self: any)
	local rd = self:RoleData()
	if not rd then
		return
	end
	local content = self.BG.Vault.Content
	local key = table.concat(rd.Vault, ",")
	if key ~= self.VaultKey then
		self.VaultKey = key
		for _, child in content:GetChildren() do
			if child:IsA("GuiButton") then
				child:Destroy()
			end
		end
		local template = self.BG.Slots.Slot1
		local ratio = if template.AbsoluteSize.Y > 0 then template.AbsoluteSize.X / template.AbsoluteSize.Y else 3.2
		for order, kitId in rd.Vault do
			local kit = Kits.Get(self.Role, kitId)
			if not kit then
				continue
			end
			local entry = self.SlotTemplate:Clone()
			entry.Name = kitId
			entry.LayoutOrder = order
			entry.Size = UDim2.fromScale(0.92, 0)
			local aspect = Instance.new("UIAspectRatioConstraint")
			aspect.AspectRatio = ratio
			aspect.Parent = entry
			entry.KitName.Text = kit.Name
			entry.ImageColor3 = Rarities.Colors[kit.Rarity]
			entry.EquipTxt.Visible = true
			local lock = entry:FindFirstChild("Lock")
			if lock then
				lock:Destroy()
			end
			entry.Activated:Connect(function()
				local current = self:RoleData()
				if self.Spinning or (current and current.VaultEquipped == kitId) then
					return
				end
				local result = Net.Request("EquipVault", self.Role, kitId)
				if not result.Ok and result.Message then
					UIController.Popup(result.Message, 2, ERROR_COLOR)
				end
			end)
			entry.Parent = content
		end
	end
	for _, child in content:GetChildren() do
		if child:IsA("GuiButton") then
			local equipText = child:FindFirstChild("EquipTxt") :: TextLabel
			equipText.Text = if rd.VaultEquipped == child.Name then "EQUIPPED" else "EQUIP"
		end
	end
end

function Vault.Refresh(self: any)
	self:RefreshCounters()
	if self.Spinning then
		return -- the reel owns the title until it finishes
	end
	local rd = self:RoleData()
	if not rd then
		return
	end
	self:ShowKit(self:EquippedKit())
	local BG = self.BG
	BG.WatchAd.Visible = false -- rewarded ads aren't set up yet
	BG.AdRarityNote.Visible = rd.AdBoost > 0
	BG.AdRarityNote.Text = `Boosted Spins Remaining: {rd.AdBoost}`
	self:RefreshSlots()
	self:RefreshVault()
	self:RefreshOdds()
end

-- ------------------------------------------------------------------ odds list
function Vault.OddsFolderFor(self: any, mode: string): string
	local rd = self:RoleData()
	if mode == "Lucky" then
		return "Lucky"
	end
	return if rd and rd.AdBoost > 0 then "Boosted" else "Normal"
end

function Vault.ShowOdds(self: any, mode: string)
	self.OddsMode = mode
	local visibleTable = self:OddsFolderFor(mode)
	for tableName, folderName in ODDS_FOLDERS do
		setFolderVisible(self.BG.Rarities[folderName], tableName == visibleTable)
	end
end

function Vault.BuildKitRows(self: any, folder: Instance, rarityChance: Roller.RarityChance, baseOrder: number, template: TextLabel)
	local rd = self:RoleData()
	local boosted = if rd then rd.BoostedKit else ""
	for j, kitChance in rarityChance.Kits do
		local kit = Kits.Get(self.Role, kitChance.Id)
		if not kit then
			continue
		end
		local row = Instance.new("TextButton")
		row.Name = `Kit_{kitChance.Id}`
		row.LayoutOrder = baseOrder + j
		row.BackgroundTransparency = 1
		row.Size = template.Size
		row.FontFace = template.FontFace
		row.TextScaled = true
		row.AutoButtonColor = false
		row:SetAttribute("Generated", true)
		local label = `{kit.Name} - {Format.Percent(kitChance.Chance)}%`
		row.Text = if boosted == kitChance.Id then `> {label} <` else label
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Parent = row
		paintRarity(row, rarityChance.Rarity)
		row.Activated:Connect(function()
			local current = self:RoleData()
			local newBoost = if current and current.BoostedKit == kitChance.Id then "" else kitChance.Id
			local result = Net.Request("SetBoostedKit", self.Role, newBoost)
			if result.Ok then
				UIController.Popup(if newBoost == "" then "Boost removed" else `Higher chance to get {kit.Name}`)
			end
		end)
		row.Visible = (self.BG.Rarities[ODDS_FOLDERS[self:OddsFolderFor(self.OddsMode)]] == folder)
		row.Parent = folder
	end
end

function Vault.RefreshOdds(self: any)
	local rd = self:RoleData()
	if not rd then
		return
	end
	local now = workspace:GetServerTimeNow()
	local bannerIds = {}
	for _, banner in Banners.Active(self.Role, now) do
		table.insert(bannerIds, banner.Id)
	end
	local key = `{rd.BoostedKit}|{rd.AdBoost > 0}|{rd.Pity.Normal}|{rd.Pity.LuckyMythical}|{rd.Pity.LuckySecret}|{self.Expanded.NormalRarities}|{self.Expanded.LuckyRarities}|{self.Expanded.BoostedRarities}|{table.concat(bannerIds, ",")}`
	if key == self.OddsKey then
		return
	end
	self.OddsKey = key
	local boosted = if rd.BoostedKit ~= "" then rd.BoostedKit else nil

	for tableName, folderName in ODDS_FOLDERS do
		local folder = self.BG.Rarities[folderName]
		for _, child in folder:GetChildren() do
			if child:GetAttribute("Generated") then
				child:Destroy()
			end
		end
		local template = folder:FindFirstChild("0 OddsText") :: TextLabel
		for i, rarityChance in Roller.Chances(self.Role, tableName, boosted, now) do
			local row = AssetUI.RarityTitle:Clone()
			row.Name = rarityChance.Rarity
			row.LayoutOrder = i * 100
			row:SetAttribute("Generated", true)
			row.TextLabel.Text = rarityChance.Rarity
			row.Percentage.Text = `({Format.Percent(rarityChance.Chance)}%)`
			row.TimeLeft.Visible = false
			paintRarity(row.TextLabel, rarityChance.Rarity)
			local rowGradient = AssetUI.RarityGradients:FindFirstChild(rarityChance.Rarity)
			if rowGradient then
				-- The row background gets the softened gradient, like the reference list.
				local g = rowGradient:Clone()
				local first = g.Color.Keypoints[1].Value
				local h, s, v = first:ToHSV()
				g.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, first),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(h, math.max(s - 0.6, 0), v)),
				})
				g.Parent = row
			end
			row.Activated:Connect(function()
				self.Expanded[folderName] = if self.Expanded[folderName] == rarityChance.Rarity then nil else rarityChance.Rarity
				self:RefreshOdds()
			end)
			row.Parent = folder
			if self.Expanded[folderName] == rarityChance.Rarity then
				self:BuildKitRows(folder, rarityChance, i * 100, template)
			end
		end

		local note = folder:FindFirstChild("ProbabilityNote") :: TextLabel?
		if note then
			note.LayoutOrder = 10000
			local base = "NOTE: The displayed probabilities are rounded values."
			if tableName == "Lucky" then
				note.Text = `{base} Mythical+ guaranteed in {GachaConfig.Pity.LuckyMythical - rd.Pity.LuckyMythical} lucky spins, Secret in {GachaConfig.Pity.LuckySecret - rd.Pity.LuckySecret}.`
			elseif tableName == "Normal" then
				note.Text = `{base} Legendary+ guaranteed in {GachaConfig.Pity.Normal - rd.Pity.Normal} spins.`
			else
				note.Text = `{base} Boosted spins don't count toward pity.`
			end
		end
	end
	self:ShowOdds(self.OddsMode)
end

-- ------------------------------------------------------------------ spinning
function Vault.ShouldConfirm(self: any, spinType: string): boolean
	if spinType ~= "Normal" then
		return false
	end
	local kit = Kits.Get(self.Role, self:EquippedKit())
	return kit ~= nil and Rarities.AtLeast(kit.Rarity, GachaConfig.ConfirmAtOrAbove)
end

function Vault.TrySpin(self: any, spinType: string)
	local rd = self:RoleData()
	local data = DataController.Data
	if not rd or not data then
		return
	end
	if self.Spinning then
		if canSkip() then
			self.SkipRequested = true
		elseif GachaConfig.SkipSpinGamePassId ~= 0 then
			MarketplaceService:PromptGamePassPurchase(LocalPlayer, GachaConfig.SkipSpinGamePassId)
		end
		return
	end
	if rd.VaultEquipped ~= "" then
		UIController.Popup("Equip a slot to spin! Vault kits can't be spun away.", 2.5, ERROR_COLOR)
		return
	end
	if rd.Locked[rd.Selected] then
		UIController.Popup("This slot is locked!", 1, ERROR_COLOR)
		return
	end
	if spinType == "Normal" and rd.Spins <= 0 and data.Cash < GachaConfig.CashSpinCost then
		self:ShowBuyPanel("Normal")
		return
	end
	if spinType == "Lucky" and rd.LuckySpins <= 0 then
		self:ShowBuyPanel("Lucky")
		return
	end
	if self:ShouldConfirm(spinType) then
		self.PendingSpin = spinType
		self.BG.Confirm.Visible = true
		return
	end
	self:DoSpin(spinType)
end

function Vault.GetBlackout(self: any): Frame
	if not self.Blackout then
		local frame = Instance.new("Frame")
		frame.Name = "Blackout"
		frame.BackgroundColor3 = Color3.new(0, 0, 0)
		frame.BackgroundTransparency = 1
		frame.BorderSizePixel = 0
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromScale(0.5, 0.5)
		frame.Size = UDim2.fromScale(3, 3) -- covers the screen whatever BG's size is
		frame.ZIndex = 1000
		frame.Visible = false
		frame.Parent = self.Gui
		self.Blackout = frame
	end
	return self.Blackout
end

-- Mythical / Secret: blackout, heartbeat, then a flash in the rarity's colour.
function Vault.DramaticReveal(self: any, rarity: string)
	local frame = self:GetBlackout()
	frame.BackgroundColor3 = Color3.new(0, 0, 0)
	frame.BackgroundTransparency = 1
	frame.Visible = true
	TweenService:Create(frame, TweenInfo.new(0.25), { BackgroundTransparency = 0 }):Play()
	task.wait(0.3)
	for beat = 1, 2 do
		if self.SkipRequested then
			break
		end
		UIController.PlaySound("Dramatic", 0.45 + beat * 0.05)
		task.wait(0.45)
	end
	frame.BackgroundColor3 = Rarities.Colors[rarity] or Color3.new(1, 1, 1)
	frame.BackgroundTransparency = 0
	TweenService:Create(frame, TweenInfo.new(0.7, Enum.EasingStyle.Quad), { BackgroundTransparency = 1 }):Play()
	task.delay(0.7, function()
		frame.Visible = false
	end)
end

-- Spins once and returns the server's result (nil if the spin was refused).
-- auto = true for auto-spin: the reel is skipped when the player can skip.
function Vault.DoSpin(self: any, spinType: string, auto: boolean?): { [string]: any }?
	self.Spinning = true
	self.SkipRequested = auto == true and canSkip()
	local buttonLabel = (if spinType == "Lucky" then self.BG.LuckySpin else self.BG.Spin).TextLabel
	local restoreText = buttonLabel.Text

	local result = Net.Request("Spin", self.Role, spinType)
	if not result.Ok then
		self.Spinning = false
		if result.Reason == "NoSpins" then
			self:ShowBuyPanel("Normal")
		elseif result.Reason == "NoLuckySpins" then
			self:ShowBuyPanel("Lucky")
		end
		if result.Message then
			UIController.Popup(result.Message, 2, ERROR_COLOR)
		end
		self:Refresh()
		return nil
	end

	buttonLabel.Text = "SKIP"
	-- The reel: random kit names flash past, slowing down, then land on the result.
	local pool = Kits.Order[self.Role]
	local ticks = math.random(GachaConfig.ReelTicks.Min, GachaConfig.ReelTicks.Max)
	for i = 1, ticks do
		if self.SkipRequested or not self.Gui.Enabled then
			break
		end
		self:ShowKit(pool[math.random(1, #pool)])
		UIController.PlaySound("Tick", 1 + (i / ticks) * 0.2)
		task.wait(i / ticks / 4)
	end

	if Rarities.Dramatic[result.Rarity] and self.Gui.Enabled then
		self:DramaticReveal(result.Rarity)
	end

	self:ShowKit(result.Kit)
	UIController.PlaySound("Reveal")
	ShowcaseStage.Burst(Rarities.Colors[result.Rarity] or Color3.new(1, 1, 1), Rarities.Dramatic[result.Rarity])

	local kit = Kits.Get(self.Role, result.Kit)
	local kitName = if kit then kit.Name else result.Kit
	if result.Duplicate then
		local extra = {}
		if result.RefundLuckySpins > 0 then
			table.insert(extra, `+{result.RefundLuckySpins} Lucky Spins`)
		end
		if result.RefundCash > 0 then
			table.insert(extra, `+{Format.Cash(result.RefundCash)}`)
		end
		if result.Shards > 0 then
			table.insert(extra, `+{result.Shards} Divine Shards`)
		end
		UIController.Popup(`Duplicate {kitName}! {table.concat(extra, ", ")}`, 3, Color3.fromRGB(255, 191, 0))
	elseif result.Vaulted then
		UIController.Popup(`{string.upper(kitName)} added to your Vault!`, 3, Rarities.Colors[result.Rarity])
	else
		UIController.Popup(`You got {kitName}!`, 2, Rarities.Colors[result.Rarity])
	end

	buttonLabel.Text = restoreText
	self.Spinning = false
	self.SkipRequested = false
	self:Refresh()

	if result.Vaulted and not result.Duplicate and self.Gui.Enabled then
		self.BG.Vault.Visible = true
		local entry = self.BG.Vault.Content:FindFirstChild(result.Kit) :: ImageButton?
		if entry then
			entry.ImageTransparency = 0.6
			TweenService:Create(entry, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 3, true), { ImageTransparency = 0 }):Play()
		end
	end
	return result
end

-- ------------------------------------------------------------------ auto-spin (GAME_PLAN.md 3)
-- Keeps spinning normal spins until a kit of the chosen rarity (or better) lands, the player
-- runs out of spins (Cash is only used if "Use Cash" is on), or they turn it off / close the vault.
function Vault.RefreshAuto(self: any)
	local auto = self.AutoFrame
	if not auto then
		return
	end
	auto.Toggle.Text = if self.AutoOn then "AUTO: ON" else "AUTO: OFF"
	auto.Toggle.BackgroundColor3 = if self.AutoOn then Color3.fromRGB(34, 140, 80) else Color3.fromRGB(30, 41, 59)
	auto.Stop.Text = `Stop at {self.AutoStop}+`
	auto.Stop.TextColor3 = Rarities.Colors[self.AutoStop] or Color3.new(1, 1, 1)
	auto.Cash.Text = if self.AutoUseCash then "Use Cash: ON" else "Use Cash: OFF"
end

function Vault.RunAuto(self: any)
	local first = true
	while self.AutoOn and self.Gui.Enabled do
		local rd = self:RoleData()
		local data = DataController.Data
		if not rd or not data then
			break
		end
		if rd.VaultEquipped ~= "" then
			UIController.Popup("Equip a slot to auto-spin! Vault kits can't be spun away.", 2.5, ERROR_COLOR)
			break
		end
		if rd.Locked[rd.Selected] then
			UIController.Popup("This slot is locked!", 1.5, ERROR_COLOR)
			break
		end
		if first then
			first = false
			local current = Kits.Get(self.Role, self:EquippedKit())
			if current and Rarities.AtLeast(current.Rarity, self.AutoStop) then
				UIController.Popup(`This slot already has a {current.Rarity} kit. Pick another slot to auto-spin.`, 3, ERROR_COLOR)
				break
			end
		end
		local canPay = rd.Spins > 0 or (self.AutoUseCash and data.Cash >= GachaConfig.CashSpinCost)
		if not canPay then
			UIController.Popup("Auto-spin stopped: out of spins.", 2, ERROR_COLOR)
			break
		end
		local result = self:DoSpin("Normal", true)
		if not result then
			break
		end
		if Rarities.AtLeast(result.Rarity, self.AutoStop) then
			UIController.Popup(`Auto-spin stopped: you got a {result.Rarity}!`, 3, Rarities.Colors[result.Rarity])
			break
		end
		task.wait(0.2)
	end
	self.AutoOn = false
	self:RefreshAuto()
end

function Vault.SetupAuto(self: any)
	local BG = self.BG
	self.AutoOn = false
	self.AutoStop = GachaConfig.AutoSpinStops[2] or "Legendary"
	self.AutoUseCash = false

	local frame = Instance.new("Frame")
	frame.Name = "AutoSpin"
	frame.BackgroundTransparency = 1
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.fromScale(0.29, 0.88)
	frame.Size = UDim2.fromScale(0.15, 0.13)
	frame.Parent = BG
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0.04, 0)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = frame
	local function makeButton(name: string, order: number): TextButton
		local b = Instance.new("TextButton")
		b.Name = name
		b.LayoutOrder = order
		b.Size = UDim2.fromScale(1, 0.3)
		b.BackgroundColor3 = Color3.fromRGB(30, 41, 59)
		b.TextColor3 = Color3.new(1, 1, 1)
		b.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
		b.TextScaled = true
		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0.25, 0)
		corner.Parent = b
		b.Parent = frame
		UIController.AnimateButton(b)
		return b
	end
	local toggle = makeButton("Toggle", 1)
	local stop = makeButton("Stop", 2)
	local cash = makeButton("Cash", 3)
	self.AutoFrame = { Toggle = toggle, Stop = stop, Cash = cash }

	toggle.Activated:Connect(function()
		if self.AutoOn then
			self.AutoOn = false -- stops after the current spin
			self:RefreshAuto()
			return
		end
		if self.Spinning then
			return
		end
		self.AutoOn = true
		self:RefreshAuto()
		task.spawn(self.RunAuto, self)
	end)
	stop.Activated:Connect(function()
		local stops = GachaConfig.AutoSpinStops
		local index = table.find(stops, self.AutoStop) or 0
		self.AutoStop = stops[index % #stops + 1]
		self:RefreshAuto()
	end)
	cash.Activated:Connect(function()
		self.AutoUseCash = not self.AutoUseCash
		self:RefreshAuto()
	end)

	-- Event banner line under the kit description.
	local label = Instance.new("TextLabel")
	label.Name = "EventBanner"
	label.BackgroundTransparency = 1
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.Position = UDim2.fromScale(0.5, 0.225)
	label.Size = UDim2.fromScale(0.45, 0.035)
	label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	label.TextScaled = true
	label.TextColor3 = Color3.fromRGB(255, 215, 90)
	label.Visible = false
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5
	stroke.Parent = label
	label.Parent = BG
	self.BannerLabel = label
	self:RefreshAuto()
end

-- ------------------------------------------------------------------ buying
function Vault.ShowBuyPanel(self: any, spinType: string)
	local BG = self.BG
	BG.BuySpinsUI.Visible = spinType == "Normal" and not BG.BuySpinsUI.Visible
	BG.BuyLuckySpinsUI.Visible = spinType == "Lucky" and not BG.BuyLuckySpinsUI.Visible
end

function Vault.SetupBuyPanels(self: any)
	local BG = self.BG
	local packs = GachaConfig.Products.Spins[self.Role]
	local function wire(panel: Instance, spinType: string, list: { any })
		for _, pack in list do
			local button = panel:FindFirstChild(if spinType == "Lucky" then `Buy{pack.Amount}LuckySpins` else `Buy{pack.Amount}Spins`) :: TextButton?
			if not button then
				continue
			end
			button.Text = `Buy {pack.Amount} {if spinType == "Lucky" then "Lucky " else ""}Spins (R${pack.Robux})`
			button.Activated:Connect(function()
				if pack.ProductId == 0 then
					UIController.Popup("Spin packs are coming soon!", 2)
					return
				end
				MarketplaceService:PromptProductPurchase(LocalPlayer, pack.ProductId)
			end)
		end
	end
	wire(BG.BuySpinsUI, "Normal", packs.Normal)
	wire(BG.BuyLuckySpinsUI, "Lucky", packs.Lucky)
	BG.BuySpins.Activated:Connect(function()
		self:ShowBuyPanel("Normal")
	end)
	BG.Spins.Activated:Connect(function()
		self:ShowBuyPanel("Lucky")
	end)
end

-- ------------------------------------------------------------------ setup
function Vault.SetupSlots(self: any)
	for i = 1, GachaConfig.MaxSlots do
		local slot = self.BG.Slots:FindFirstChild(`Slot{i}`) :: ImageButton?
		if not slot then
			continue
		end
		local busyUntil = 0
		slot.Activated:Connect(function()
			local rd = self:RoleData()
			if not rd or self.Spinning or os.clock() < busyUntil then
				return
			end
			if i > rd.MaxSlots + 1 then
				return -- slots are bought in order
			end
			if i > rd.MaxSlots then
				local productId = GachaConfig.Products.Slots[self.Role][i] or 0
				if productId == 0 then
					UIController.Popup("Extra slots are coming soon!", 2)
				else
					MarketplaceService:PromptProductPurchase(LocalPlayer, productId)
				end
				return
			end
			if i == rd.Selected and rd.VaultEquipped == "" then
				return
			end
			busyUntil = os.clock() + 0.4
			local result = Net.Request("EquipSlot", self.Role, i)
			if not result.Ok and result.Message then
				UIController.Popup(result.Message, 2, ERROR_COLOR)
			end
		end)
		local lockButton = slot:FindFirstChild("Lock") :: GuiButton
		lockButton.Activated:Connect(function()
			local rd = self:RoleData()
			if not rd or i > rd.MaxSlots then
				return
			end
			local locked = not rd.Locked[i]
			local result = Net.Request("SetLocked", self.Role, i, locked)
			if result.Ok then
				UIController.Popup(`Slot {if locked then "locked" else "unlocked"}!`)
			end
		end)
	end
end

function Vault.Setup(self: any)
	local BG = self.BG
	self:SetupSlots()
	self:SetupBuyPanels()
	self:SetupAuto()

	BG.Spin.Activated:Connect(function()
		self:TrySpin("Normal")
	end)
	BG.LuckySpin.Activated:Connect(function()
		self:TrySpin("Lucky")
	end)
	BG.Confirm.Yes.Activated:Connect(function()
		BG.Confirm.Visible = false
		local pending = self.PendingSpin
		self.PendingSpin = nil
		if pending and not self.Spinning then
			self:DoSpin(pending)
		end
	end)
	BG.Confirm.No.Activated:Connect(function()
		BG.Confirm.Visible = false
		self.PendingSpin = nil
	end)

	BG.NormalOdds.Activated:Connect(function()
		self:ShowOdds("Normal")
	end)
	BG.LuckyOdds.Activated:Connect(function()
		self:ShowOdds("Lucky")
	end)

	BG.VaultButton.Activated:Connect(function()
		BG.Vault.Visible = not BG.Vault.Visible
	end)
	BG.Vault.Close.Activated:Connect(function()
		BG.Vault.Visible = false
	end)
	BG.Close.Activated:Connect(function()
		self:Close()
	end)

	for _, name in { "Spin", "LuckySpin", "BuySpins", "Spins", "Close", "NormalOdds", "LuckyOdds", "VaultButton" } do
		local button = BG:FindFirstChild(name)
		if button and button:IsA("GuiButton") then
			UIController.AnimateButton(button)
		end
	end

	DataController.Changed:Connect(function()
		if self.Gui.Enabled then
			self:Refresh()
		end
		self:RefreshAlert()
	end)
	self:RefreshAlert()
end

-- HUD button glows while the player has spins to use in this vault.
function Vault.RefreshAlert(self: any)
	local rd = self:RoleData()
	local hud = PlayerGui:FindFirstChild("HUD") :: any
	local buttons = hud and hud:FindFirstChild("Buttons")
	local frame = buttons and buttons:FindFirstChild(self.Gui.Name)
	if frame and rd then
		UIController.Alert(frame, rd.Spins > 0 or rd.LuckySpins > 0)
	end
end

function Vault.Open(self: any)
	local BG = self.BG
	BG.Confirm.Visible = false
	BG.BuySpinsUI.Visible = false
	BG.BuyLuckySpinsUI.Visible = false
	BG.Vault.Visible = false
	UIController.SetHUDVisible(false)
	ShowcaseStage.Show()
	self.Gui.Enabled = true
	self.OddsKey = "" -- rebuild odds now that the screen has a size
	self.VaultKey = ""
	self:Refresh()
end

function Vault.Close(self: any)
	self.AutoOn = false
	self.SkipRequested = true
	self.PendingSpin = nil
	self.Gui.Enabled = false
	ShowcaseStage.Hide()
	UIController.SetHUDVisible(true)
end

-- ------------------------------------------------------------------ controller
local VaultController = {}

VaultController.Vaults = {} :: { [string]: any }

function VaultController.Get(role: Kits.Role): any
	return VaultController.Vaults[role]
end

function VaultController.Init() end

function VaultController.Start()
	DataController.Wait()
	for _, entry in { { "God", "GodVault" }, { "Runner", "RunnerVault" } } do
		local role, guiName = entry[1] :: Kits.Role, entry[2]
		local vault = Vault.new(role, guiName)
		vault:Setup()
		VaultController.Vaults[role] = vault
		UIController.RegisterScreen(guiName, {
			Open = function()
				vault:Open()
			end,
			Close = function()
				vault:Close()
			end,
			IsOpen = function()
				return vault:IsOpen()
			end,
		})
	end
end

return VaultController

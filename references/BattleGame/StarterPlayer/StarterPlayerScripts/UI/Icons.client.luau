local Player = game.Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

--Services
local MarketService = game:GetService("MarketplaceService")
local RNS = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")
local VoiceChatService = game:GetService("VoiceChatService")
local TextChatService = game:GetService("TextChatService")

--Remotes
local Remotes = RS.Remotes

local ComRemotes = Remotes.Comunicator

local Comunicator = ComRemotes.Set
local Getter = ComRemotes.Get

--Modules 
local InfoModule = require(RS.Info)
local SoundsModule = require(RS.Modules.SoundHandler)
--local WindShake = require(RPModules.WindShake)
--local SmartBone = require(RPModules.SmartBone)

--Sounds
local ClickSound = RS.Assets.Sounds.UI.click1


--Player
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid: Humanoid = Character:FindFirstChild('Humanoid') or Character:WaitForChild('Humanoid', 10)
local Animator: Animator = Humanoid:FindFirstChild("Animator") or Humanoid:WaitForChild("Animator", 10)
local HumRP: BasePart = Character:FindFirstChild('HumanoidRootPart') or Character:WaitForChild('HumanoidRootPart', 10)
local Camera = workspace.CurrentCamera
local gameSettings = UserSettings().GameSettings
local ConfigFolder = Player:FindFirstChild("Configuration") or Player:WaitForChild("Configuration", 10)
local ShiftlockConfig: BoolValue = ConfigFolder:FindFirstChild('Shiftlock') or ConfigFolder:WaitForChild('Shiftlock', 10)

-- apply saved audio volumes to the SoundGroups on join
task.spawn(function()
	local function applySaved(cfgName, groupName)
		local cfg = ConfigFolder:FindFirstChild(cfgName)
		local group = game.SoundService:FindFirstChild(groupName)
		if cfg and group then
			group.Volume = cfg.Value
		end
	end
	applySaved("Volume", "Sounds")
	applySaved("MusicVolume", "Music")
end)

local PlayerGui = Player.PlayerGui

local sortedMovesetIcons = nil
local Cons = {}


--Icons
task.spawn(function()
	--if shared.IsMobile and (not DashButton or not PunchButton or not BlockButton or not ShiftlockButton) then
	--	repeat task.wait() until DashButton and PunchButton and BlockButton and ShiftlockButton
	--end

	local startTick = tick()
	if game:GetService("GuiService").TopbarInset.Max.Y <= 0 then
		while true do
			task.wait()

			if not (tick() - startTick <= 5 and game:GetService("GuiService").TopbarInset.Max.Y <= 0) then
				break
			end
		end
	end

	local isOldUI = game:GetService("GuiService").TopbarInset.Height == 36
	local Icon = require(RS.Modules.Icon)


	shared.triggerTopbar = function(bool)
		Icon.setTopbarEnabled(bool)
	end

	task.wait()




	local IsNotDuelsHub = game.PlaceId ~= workspace:GetAttribute("DuelsHubPlaceId")
	local CharactersIcon = Icon.new(true)
	CharactersIcon:setImage(12285568530)
	CharactersIcon:setName("Characters")
	CharactersIcon:setLabel("Characters")
	CharactersIcon:autoDeselect(true)
	CharactersIcon:setLabel("Characters")
	CharactersIcon:setOrder(1)
	CharactersIcon:modifyTheme({
		{"Dropdown", "MaxIcons", UIS.TouchEnabled and 6 or 10},
		{"Dropdown", "BackgroundTransparency", 0.05},
	})

	CharactersIcon:bindEvent('selected', function(icon)
		if shared.ServersIcon then
			shared.ServersIcon:deselect()
		end
		if shared.SettingsIcon then
			shared.SettingsIcon:deselect()
		end
		if shared.AdminIcon then
			shared.AdminIcon:deselect()
		end

		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
		CharactersIcon:setLabel("Characters")
	end)

	CharactersIcon:bindEvent('deselected', function()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
	end)


	local HasAdminChar = RS.Remotes.Admin.IsAdmin:InvokeServer()
	local MovesetIconsArray = {}
	sortedMovesetIcons = {
		Public = {},
		Quest = {},
		EarlyAccess = {},
		AdminOnly = {}
	}

	for Name, Info in InfoModule.Movesets do
		local Order = Info.Order
		local imageId = Info.Icon
		local isAdmin = Info.Admin
		local isQuest = Info.isQuest
		local isEA = Info.EarlyAccess
		local IsMastery = Info.IsMastery
		if IsMastery then continue end

		local MovesetIcon = Icon.new()
		task.spawn(function()
			MovesetIcon:setLabel(Name)
			MovesetIcon:setName(Name)
			MovesetIcon:setImage(imageId)
			MovesetIcon:setOrder(Order)

			MovesetIcon:setImageScale(.8)
			MovesetIcon:setImageRatio(1)
			MovesetIcon:setWidth(150)

			MovesetIcon:autoDeselect(true)
			MovesetIcon:bindEvent("selected", function(icon)
				MovesetIcon:deselect()
				SoundsModule:AddSound(ClickSound)
				Remotes.ChooseCharacter:FireServer(Name)
			end)

			--if isAdmin == true then
			--	sortedMovesetIcons.AdminOnly[Name] = MovesetIcon

			--	MovesetIcon:set("iconTextColor", Color3.fromRGB(255, 255, 0))

			--	if HasAdminChar ~= true then
			--		MovesetIcon:setEnabled(false)
			--	end
			--elseif isQuest == true then
			--	sortedMovesetIcons.Quest[Name] = MovesetIcon

			--	MovesetIcon:set("iconTextColor", Color3.fromRGB(255, 216, 19))
			--elseif isEA == true then
			--	sortedMovesetIcons.EarlyAccess[Name] = MovesetIcon

			--	MovesetIcon:set("iconTextColor", Color3.fromRGB(255, 255, 0))
			--else
			--	sortedMovesetIcons.Public[Name] = MovesetIcon
			--end
			sortedMovesetIcons.Public[Name] = MovesetIcon
		end)

		local widget = MovesetIcon:getInstance("Widget")

		table.insert(MovesetIconsArray, MovesetIcon)
	end

	local function ApplyDropdownChildTheme(state)
		CharactersIcon:modifyChildTheme({
			{"Widget", "MinimumWidth", 180, state},
			{"Widget", "DesiredWidth", 180, state},
			{"Widget", "MinimumHeight", 44, state},

			{"IconImageScale", "Value", 0.8, state},
			{"IconImageRatio", "AspectRatio", 1, state},

			{"IconLabel", "TextXAlignment", Enum.TextXAlignment.Left, state},
			{"IconLabel", "TextSize", 22, state},

			{"IconOverlay", "Size", UDim2.new(1, 0, 1, 0), state},

		})
	end

	ApplyDropdownChildTheme("Deselected")
	ApplyDropdownChildTheme("Viewing")
	ApplyDropdownChildTheme("Selected")

	CharactersIcon:setDropdown(MovesetIconsArray)


	shared.CharactersIcon = CharactersIcon	


	local MasteryFrames = {}

	local DropdownTemplate = (function()
		for _, v in pairs(PlayerGui:GetDescendants()) do
			if v.Name == "IconImage" and v.Image == "http://www.roblox.com/asset/?id=12285568530" then
				local charactersWidget = v:FindFirstAncestor("Characters")
				if charactersWidget then
					return charactersWidget:FindFirstChild("Dropdown", true)
				end
			end
		end

	end)()


	local function ApllyCanvas(Frame)
		if Frame:GetAttribute("Applied") then return end

		Frame:SetAttribute("Applied", true)
		local UIListLayout = Frame:FindFirstChildOfClass("UIListLayout")

		local function onLayoutChange()
			Frame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		end

		Frame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(onLayoutChange)
	end

	local function AnimateFrame(Name)
		local FramesList = MasteryFrames[Name] or {}

		for i = 1, math.floor(#FramesList / 2) do
			local j = #FramesList - i + 1
			local BackFrame = FramesList[j]
			local FrontFrame = FramesList[i]

			FramesList[i] = BackFrame
			FramesList[j] = FrontFrame
		end

		for _, WrapperFrame in pairs(FramesList) do
			local InnerFrame = WrapperFrame:FindFirstChild("Frame")

			if InnerFrame then
				InnerFrame:TweenPosition(UDim2.new(0, 0, -3, 0), nil, nil, 0.35, true)

				task.delay(0.3, function()
					InnerFrame.Visible = false
				end)

				task.delay(0.1, function()
					WrapperFrame:TweenSize(UDim2.new(0.925, WrapperFrame.Size.X.Offset, WrapperFrame.Size.Y.Scale, -2), nil, nil, 0.4, true)

					task.delay(0.75, function()
						WrapperFrame:Destroy()
					end)
				end)

				task.wait(0.06)
			end
		end
	end

	local function MasteryFrame(Name, MasteryName)
		local TemplateFrame = DropdownTemplate:FindFirstChild(Name):Clone()
		TemplateFrame.Name = TemplateFrame.Name .. "Mastery"

		local Wrapper = Instance.new("Frame")
		local Offset = TemplateFrame.Size.Y.Offset

		Wrapper.Name = TemplateFrame.Name
		Wrapper.Size = UDim2.new(0.925, TemplateFrame.Size.X.Offset, TemplateFrame.Size.Y.Scale, -2)
		Wrapper.Position = TemplateFrame.Position
		Wrapper.BackgroundTransparency = 1
		Wrapper.LayoutOrder = TemplateFrame.LayoutOrder
		Wrapper.Parent = DropdownTemplate
		Wrapper.ClipsDescendants = true

		TemplateFrame.IconButton.MouseEnter:Connect(function()
			TemplateFrame.IconOverlay.BackgroundTransparency = 0.9
		end)

		TemplateFrame.IconButton.MouseLeave:Connect(function()
			TemplateFrame.IconOverlay.BackgroundTransparency = 1
		end)

		TemplateFrame.IconButton.IconImage.Image = "rbxassetid://" .. InfoModule.Movesets[MasteryName].Icon
		TemplateFrame.IconButton.IconLabel.Text = InfoModule.Movesets[MasteryName].Name
		TemplateFrame.IconButton.IconImage.IconGlow2.ImageColor3 = InfoModule.Movesets[MasteryName].Glow or Color3.new(1, 1, 1)
		TemplateFrame.IconOverlay.BackgroundTransparency = 1
		TemplateFrame.IconOverlay.IconImage:Destroy()

		TemplateFrame.IconButton.MouseButton1Click:Connect(function()
			SoundsModule:AddSound(ClickSound)

			--ChooseCharacter:FireServer(name)

			--Comunicator:FireServer('SetMoveset', MasteryName)
		end)

		TemplateFrame.Size = UDim2.new(1, 0, 1, 0)
		TemplateFrame.Name = "Frame"
		TemplateFrame.Position = UDim2.new(0, 0, -3, 0)
		TemplateFrame.Parent = Wrapper

		task.delay(0.1, function()
			TemplateFrame:TweenPosition(UDim2.new(0, 0, 0, 0), nil, nil, 0.25, true)
		end)

		Wrapper:TweenSize(UDim2.new(0.925, Wrapper.Size.X.Offset, Wrapper.Size.Y.Scale, Offset - 4), nil, nil, 0.25, true)

		if not MasteryFrames[Name] then
			MasteryFrames[Name] = {}
		end

		table.insert(MasteryFrames[Name], Wrapper)

		return TemplateFrame
	end

	local function MasteryToggle(Name, List)
		local MovesetTemplate = DropdownTemplate:FindFirstChild(Name)
		local ClonedIcon = MovesetTemplate:WaitForChild("IconButton"):WaitForChild("IconImage"):Clone()


		ClonedIcon.AnchorPoint = Vector2.new(1, 0.5)
		ClonedIcon.Image = "rbxassetid://120815996782931"
		ClonedIcon.Position = UDim2.new(1, ClonedIcon.Position.X.Offset * -1 + 8, 0.5, 0)
		ClonedIcon.Parent = MovesetTemplate.IconOverlay
		ClonedIcon.Parent.ClipsDescendants = true
		RS.Resources.IconGlow:Clone().Parent = ClonedIcon

		local OverlayButton = Instance.new("ImageButton")
		OverlayButton.Size = UDim2.new(1, 0, 1, 0)
		OverlayButton.BackgroundTransparency = 1
		OverlayButton.ZIndex = ClonedIcon.ZIndex + 2
		OverlayButton.ImageTransparency = 1
		OverlayButton.Parent = ClonedIcon

		local isOpen = nil
		local lastRandom = 0

		OverlayButton.MouseButton1Click:Connect(function()
			local sawAll = false
			local previousOpen = isOpen
			isOpen = not isOpen

			SoundsModule:AddSound(ClickSound)

			local randomSeed = math.random(1, 2000000000)
			lastRandom = randomSeed

			if not previousOpen then
				for _, skillName in pairs(List) do
					if randomSeed == lastRandom then
						MasteryFrame(Name, skillName)

						task.wait(0.06)
					else
						sawAll = true
					end

					if sawAll then
						break
					end
				end

				if not sawAll then
					return
				end
			else
				AnimateFrame(Name)
			end

			sawAll = false
		end)
	end

	task.delay(.1, function()
		--task.wait(0.25)

		local dropdown = CharactersIcon:getInstance("Dropdown")
		local scroller = CharactersIcon:getInstance("DropdownScroller")
		local list = CharactersIcon:getInstance("DropdownList")

		for _, movesetIcon in ipairs(MovesetIconsArray) do
			local iconImage = movesetIcon:getInstance("IconImage")
			local iconLabel = movesetIcon:getInstance("IconLabel")
			local widget = movesetIcon:getInstance("Widget")

			if widget then
				widget.AutomaticSize = Enum.AutomaticSize.None
				widget.Size = UDim2.new(0, 180, 0, 44)
			end

			if iconLabel then
				iconLabel.ZIndex = 12
			end

			if iconImage and not iconImage:FindFirstChild("IconGlow") then
				local info = InfoModule.Movesets[movesetIcon.name]

				local glow = RS.Assets.CharacterSelection.IconGlow:Clone()
				glow.Name = "IconGlow"
				glow.ImageTransparency = 1
				glow.ZIndex = iconImage.ZIndex - 1
				glow.ImageColor3 = info and info.Glow or Color3.new(1, 1, 1)
				glow.Parent = iconImage

				game:GetService("TweenService"):Create(
					glow,
					TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ ImageTransparency = 0.875 }
				):Play()
			end

			if iconImage and not iconImage:FindFirstChild("IconGlow2") then
				local info = InfoModule.Movesets[movesetIcon.name]

				local glow2 = RS.Assets.CharacterSelection.IconGlow2:Clone()
				glow2.Name = "IconGlow2"
				glow2.ImageTransparency = 1
				glow2.ZIndex = iconImage.ZIndex - 1
				glow2.ImageColor3 = info and info.Glow or Color3.new(1, 1, 1)
				glow2.Parent = iconImage

				game:GetService("TweenService"):Create(
					glow2,
					TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ ImageTransparency = 0.875 }
				):Play()
			end
		end
	end)
	--[[
	task.delay(0.1, function()
		--if not DropdownTemplate or DropdownTemplate and not DropdownTemplate:IsA("ScrollingFrame") then
		--	local startTick = tick()
		--	local function findTemplate()
		--		for _, descendant in pairs(PlayerGui:GetDescendants()) do
		--			if descendant.Name == "IconImage" and descendant.Image == "http://www.roblox.com/asset/?id=12285568530" then
		--				return descendant.Parent.Parent.DropdownContainer.DropdownFrame
		--			end
		--		end
		--	end

		--	repeat
		--		task.wait()
		--		DropdownTemplate = findTemplate()
		--	until DropdownTemplate and DropdownTemplate:IsA("ScrollingFrame") or tick(0.005) - startTick >= 5
		--end
		if not DropdownTemplate or not DropdownTemplate:IsA("ScrollingFrame") then
			local startTick = tick()

			local function findTemplate()
				return CharactersIcon:getInstance("DropdownScroller")
			end

			repeat
				task.wait()
				DropdownTemplate = findTemplate()
			until (DropdownTemplate and DropdownTemplate:IsA("ScrollingFrame")) or tick() - startTick >= 5
		end
		
		if not DropdownTemplate then
			warn("DropdownTemplate was not found")
			return
		end
		
		local DropdownList = DropdownTemplate:FindFirstChild("DropdownList")
		if DropdownList then
			--DropdownList.HorizontalAlignment = Enum.HorizontalAlignment.Right
			DropdownList.HorizontalAlignment = "Right"
			warn("Did it")
		end
		
		--DropdownTemplate.DropdownList.HorizontalAlignment = "Right"
		ApllyCanvas(DropdownTemplate)


		--DropdownTemplate.DropdownList.HorizontalAlignment = "Right"
		--ApllyCanvas(DropdownTemplate)

		for Name, Info in InfoModule.Movesets do
			local HasMastery = Info.Mastery
			local Frame = DropdownTemplate:FindFirstChild(Name)

			if Frame and Frame:IsA("Frame") then
				local IconGlow = RS.Assets.CharacterSelection:FindFirstChild("IconGlow"):Clone()
				IconGlow.ImageTransparency = 1

				local IconButton = Frame:FindFirstChild("IconButton")
				if IconButton then
					IconButton.ClipsDescendants = true

					local IconLabel = IconButton:FindFirstChild("IconLabel")
					if IconLabel then
						IconLabel.ZIndex = 12
					end

					IconGlow.ZIndex = 11
					IconGlow.ImageColor3 = Info.Glow or Color3.new(1, 1, 1)

					local IconImage = IconButton:FindFirstChild("IconImage")
					if IconImage then
						IconGlow.Parent = IconImage
					end

					game:GetService("TweenService"):Create(IconGlow, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 0.875
					}):Play()
				end
			end

			if Frame and Frame:IsA("Frame") then
				local IconGlow2 = RS.Assets.CharacterSelection:FindFirstChild("IconGlow2"):Clone()
				IconGlow2.ImageTransparency = 1

				local IconButton = Frame:FindFirstChild("IconButton")
				if IconButton then
					IconButton.ClipsDescendants = true

					local IconLabel = IconButton:FindFirstChild("IconLabel")
					if IconLabel then
						IconLabel.ZIndex = 12
					end

					IconGlow2.ZIndex = 11
					IconGlow2.ImageColor3 = Info.Glow or Color3.new(1, 1, 1)

					local IconImage = IconButton:FindFirstChild("IconImage")
					if IconImage then
						IconGlow2.Parent = IconImage
					end

					game:GetService("TweenService"):Create(IconGlow2, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						ImageTransparency = 0.875
					}):Play()
				end
			end

			if HasMastery then
				MasteryToggle(Name, HasMastery)
			end
		end
	end)
	
	]]
	task.wait(0.15)

	local IsDuels  = game.PlaceId == workspace:GetAttribute("DuelsPlaceId")
	local IsNotDuels = game.PlaceId ~= workspace:GetAttribute("DuelsPlaceId")


	--[[
	task.spawn(function()
		local ServersDropdown = {}

		if game.PlaceId ~= workspace:GetAttribute("DuelsHubPlaceId") then
			local DuelsIcon = Icon.new()
				:setLabel('Join Duels')

				:setImage(12558753709)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					Comunicator:FireServer("JoinServer", { Type = "Duels" })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			table.insert(ServersDropdown, DuelsIcon)
		end

		if game.PlaceId ~= workspace:GetAttribute("NormalServerPlaceId") then
			local NormalIcon = Icon.new()
				:setLabel('Join Normal Server')

				:setImage(98088244135735)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					Comunicator:FireServer("JoinServer", { Type = "Normal" })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			table.insert(ServersDropdown, NormalIcon)
		end


		local ServersIcon = Icon.new(true)
		ServersIcon:setName("Servers")
		ServersIcon:setEnabled(IsNotDuels)
		ServersIcon:setImage(70541965716698)
		ServersIcon:set("dropdownSquareCorners", true)
		ServersIcon:set("iconImageRatio", 1)
		ServersIcon:bindEvent('selected', function()
			if shared.SettingsIcon then
				shared.SettingsIcon:deselect()
			end
			if shared.CharactersIcon then
				shared.CharactersIcon:deselect()
			end

			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

			SoundsModule:AddSound(ClickSound)
		end)
		ServersIcon:bindEvent('deselected', function()
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

			SoundsModule:AddSound(ClickSound)
		end)
		ServersIcon:setDropdown(ServersDropdown)
		shared.ServersIcon = ServersIcon
	end)
	]]

	task.wait(0.15)

	--[[
	local ConfigIcon = Icon.new(true)
	ConfigIcon:setName("Config")
	ConfigIcon:setImage(3687980595)
--	ConfigIcon:set("dropdownSquareCorners", true)
--	ConfigIcon:set("dropdownMaxIconsBeforeScroll", 8)
	ConfigIcon:setEnabled(IsNotDuelsHub)
	ConfigIcon:bindEvent('selected', function()
		if shared.ServersIcon then
			shared.ServersIcon:deselect()
		end
		if shared.CharactersIcon then
			shared.CharactersIcon:deselect()
		end

		--StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

		SoundsModule:AddSound(ClickSound)
	end)
	ConfigIcon:bindEvent('deselected', function()
		--StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

		SoundsModule:AddSound(ClickSound)
	end)
	]]


	local IsAdmin = RS.Remotes.Admin.IsAdmin:InvokeServer()
	local notBoolId = 14795471064
	local GreenSquareId, RedSquareId = 12343172777, 12343172715
	local function getBoolConfigLabel(ConfigName)
		local ConfigObj: BoolValue = ConfigFolder:FindFirstChild(ConfigName)

		if ConfigObj then
			if ConfigObj.Value == true then
				return GreenSquareId
			else
				return RedSquareId
			end
		end
	end

	local function getPSBoolImg(ConfigName, Parent)
		Parent = Parent  --or PSCfgFolder

		if Parent[ConfigName].Value then
			return GreenSquareId
		else
			return RedSquareId
		end
	end

	local SetSetting = RS.Remotes.Settings.Set    -- RemoteEvent

	-- ================= Settings menu helpers =================
	local settingsOrder = 100
	local pendingInjections = {}  -- steppers get their +/- buttons injected after render

	-- Collapsible category (accordion). Children start hidden; header toggles them.
	local function newCategory(name)
		settingsOrder += 1
		local children, expanded, header = {}, false, nil

		local function setExpanded(state)
			expanded = state
			for _, child in children do child:setEnabled(state) end
			header:setLabel((state and "[-] " or "[+] ") .. name:upper())
			if state then
				task.defer(function()
					for _, inject in pendingInjections do inject() end
				end)
			end
		end

		header = Icon.new()
			:setName(name)
			:setOrder(settingsOrder)
			:setLabel("[+] " .. name:upper())
			:autoDeselect(true)
			:bindEvent("selected", function(icon)
				icon:deselect()
				setExpanded(not expanded)
				SoundsModule:AddSound(ClickSound)
			end)

		local api = { all = { header } }
		function api.add(childIcon)
			settingsOrder += 1
			childIcon:setOrder(settingsOrder)
			childIcon.SettingsCategory = name    -- its category in the Settings menu
			childIcon:setEnabled(false)          -- collapsed by default
			table.insert(children, childIcon)
			table.insert(api.all, childIcon)
			return childIcon
		end
		return api
	end

	-- Row with a label + on-row [-]/[+] buttons (Sound Volume: 1.00  [-][+])
	local function makeStepper(name, getValue, setValue, opts)
		opts = opts or {}
		local step, min, max = opts.step or 0.1, opts.min or 0.1, opts.max or 1
		local fmt = opts.format or function(v) return name..": "..string.format("%.2f", v) end

		local icon = Icon.new()
			:setName(name)
			:setImage(notBoolId)
			:setLabel(fmt(getValue()))
			:autoDeselect(true)
			:bindEvent("selected", function(ic) ic:deselect() end)  -- clicking the label does nothing

		local function apply(v)
			v = math.clamp(tonumber(string.format("%.2f", v)), min, max)
			setValue(v)
			icon:setLabel(fmt(v))
		end
		icon.SettingsStep = function(dir) apply(getValue() + dir * step) end -- the Settings menu's [-]/[+]

		-- defer button injection until the row's GUI exists
		table.insert(pendingInjections, function()
			local widget = icon:getInstance("Widget")
			if not widget then return end
			if widget:FindFirstChild("StepPlus") then return end
			widget.ClipsDescendants = false

			local function mkBtn(bname, sym, xOff)
				local b = Instance.new("TextButton")
				b.Name = bname
				b.AnchorPoint = Vector2.new(1, 0.5)
				b.Position = UDim2.new(1, xOff, 0.5, 0)
				b.Size = UDim2.new(0, 30, 0, 26)
				b.BackgroundColor3 = Color3.fromRGB(70, 74, 88)
				b.AutoButtonColor = true
				b.Text, b.Font, b.TextSize = sym, Enum.Font.GothamBold, 22
				b.TextColor3 = Color3.new(1, 1, 1)
				b.ZIndex = 50
				b.Active = true
				Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
				b.Parent = widget
				return b
			end

			local plus = mkBtn("StepPlus", "+", -4)
			local minus = mkBtn("StepMinus", "-", -40)

			plus.Activated:Connect(function()
				apply(getValue() + step)
				SoundsModule:AddSound(ClickSound)
			end)
			minus.Activated:Connect(function()
				apply(getValue() - step)
				SoundsModule:AddSound(ClickSound)
			end)
		end)

		return icon
	end

	-- ON/OFF row
	local function makeToggle(name, getValue, setValue)
		local icon
		local function refresh(v) icon:setLabel(name..": "..(v and "ON" or "OFF")) end
		icon = Icon.new()
			:setName(name)
			:setImage(notBoolId)
			:autoDeselect(true)
			:bindEvent("selected", function(ic)
				ic:deselect()
				local v = not getValue()
				setValue(v); refresh(v)
				SoundsModule:AddSound(ClickSound)
			end)
		refresh(getValue())
		return icon
	end
	-- ================= end helpers =================

	local audio = newCategory("Audio")

	audio.add(makeStepper("Sound Volume",
		function() return game.SoundService.Sounds.Volume end,
		function(v) game.SoundService.Sounds.Volume = v; SetSetting:FireServer("Volume", v) end,
		{ min = 0.1, max = 1, step = 0.1, format = function(v) return "Sound Volume: "..string.format("%.2f", v) end }))

	audio.add(makeStepper("Music Volume",
		function() return game.SoundService.Music.Volume end,
		function(v) game.SoundService.Music.Volume = v; SetSetting:FireServer("MusicVolume", v) end,
		{ min = 0, max = 2, step = 0.1, format = function(v) return if v <= 0 then "Music Volume: OFF" else "Music Volume: "..string.format("%.1f", v) end }))
	audio.add(makeToggle("Ultimate Music",
		function() return ConfigFolder["Awakening Music"].Value end,
		function(v) SetSetting:FireServer("Awakening Music", v) end))

	-- ================= Mobile controls settings =================
	local function getMobileButtons()
		local MobileGui = PlayerGui:FindFirstChild("Mobile")
		local MobileFrame = MobileGui and MobileGui:FindFirstChild("MobileFrame")
		local TouchGui = PlayerGui:FindFirstChild("TouchGui")
		local TouchControlFrame = TouchGui and TouchGui:FindFirstChild("TouchControlFrame")
		local JumpButton = TouchControlFrame and TouchControlFrame:FindFirstChild("JumpButton")

		if not MobileFrame or not JumpButton then return nil end

		return {
			Jump = JumpButton,
			Dash = MobileFrame:FindFirstChild("DashButton"),
			M1 = MobileFrame:FindFirstChild("PunchButton"),
			Block = MobileFrame:FindFirstChild("BlockButton"),
			Shiftlock = MobileFrame:FindFirstChild("ShiftlockButton"),
		}
	end

	-- default position each button loads at, per the MobileButtons formula
	local function defaultButtonPos(B, buttonName)
		local halfX = B.Jump.Size.X.Offset / 2
		local gap = B.Jump.Size.Y.Offset / 2 + 7

		if buttonName == "Dash" then
			return B.Jump.Position.X.Offset + halfX, B.Jump.Position.Y.Offset - gap
		elseif buttonName == "M1" then
			return B.Jump.Position.X.Offset + halfX, B.Jump.Position.Y.Offset - 2.5 * gap
		elseif buttonName == "Block" then
			return B.Jump.Position.X.Offset + halfX, B.Jump.Position.Y.Offset - 4 * gap
		else -- Shiftlock
			return B.Jump.Position.X.Offset - halfX, B.Jump.Position.Y.Offset - 3.25 * gap
		end
	end

	local mobileSettings
	if UIS.TouchEnabled then
		mobileSettings = newCategory("Mobile Controls")

		local editIcon
		editIcon = mobileSettings.add(Icon.new()
			:setName("Move_Buttons")
			:setImage(notBoolId)
			:setLabel("Edit Button Positions")
			:autoDeselect(true)
			:bindEvent("selected", function(icon)
				icon:deselect()
				SoundsModule:AddSound(ClickSound)

				local CurrentCharacter = Player.Character
				local B = getMobileButtons()
				if not CurrentCharacter or not B then return end

				local ChangingButtons = CurrentCharacter:FindFirstChild("ChangingButtons")
				if ChangingButtons then
					-- leaving edit mode: save deltas from the default formula
					icon:setLabel("Edit Button Positions")
					ChangingButtons:Destroy()

					local Positions = {}
					for _, name in {"Dash", "M1", "Block", "Shiftlock"} do
						local btn = B[name]
						if btn then
							local defX, defY = defaultButtonPos(B, name)
							Positions[name] = {
								ScaleX = btn.Position.X.Scale - B.Jump.Position.X.Scale,
								OffsetX = btn.Position.X.Offset - defX,
								ScaleY = btn.Position.Y.Scale - B.Jump.Position.Y.Scale,
								OffsetY = btn.Position.Y.Offset - defY,
							}
						end
					end

					Comunicator:FireServer("SaveButtonsPos", Positions)
					return
				end

				icon:setLabel("Save Edits?")

				ChangingButtons = Instance.new("BoolValue")
				ChangingButtons.Name = "ChangingButtons"
				ChangingButtons.Value = true
				ChangingButtons.Parent = CurrentCharacter
			end))

		mobileSettings.add(Icon.new()
			:setName("Reset_Buttons")
			:setImage(notBoolId)
			:setLabel("Reset Button Positions")
			:autoDeselect(true)
			:bindEvent("selected", function(icon)
				icon:deselect()
				SoundsModule:AddSound(ClickSound)

				local B = getMobileButtons()
				if not B then return end

				local Positions = {}
				for _, name in {"Dash", "M1", "Block", "Shiftlock"} do
					local btn = B[name]
					if btn then
						local defX, defY = defaultButtonPos(B, name)
						btn.Position = UDim2.new(B.Jump.Position.X.Scale, defX, B.Jump.Position.Y.Scale, defY)
						Positions[name] = { ScaleX = 0, OffsetX = 0, ScaleY = 0, OffsetY = 0 }
					end
				end

				Comunicator:FireServer("SaveButtonsPos", Positions)
			end))

		local sizeRows = {
			{ label = "Punch Size", key = "M1" },
			{ label = "Dash Size", key = "Dash" },
			{ label = "Block Size", key = "Block" },
			{ label = "Shiftlock Size", key = "Shiftlock" },
		}

		local sizeStepperRefreshers = {}

		mobileSettings.add(Icon.new()
			:setName("Reset_Button_Sizes")
			:setImage(notBoolId)
			:setLabel("Reset Button Sizes")
			:autoDeselect(true)
			:bindEvent("selected", function(icon)
				icon:deselect()
				SoundsModule:AddSound(ClickSound)

				local B = getMobileButtons()
				if not B then return end

				for _, key in {"M1", "Dash", "Block", "Shiftlock"} do
					local btn = B[key]
					if btn then
						btn:SetAttribute("SizeMultiplier", 1)
						Comunicator:FireServer("SaveButtonSize", { Button = key, Size = 1 })
					end
				end

				for _, refresh in sizeStepperRefreshers do refresh() end
			end))

		for _, row in sizeRows do
			local function currentSize()
				local B = getMobileButtons()
				local btn = B and B[row.key]
				return btn and btn:GetAttribute("SizeMultiplier") or 1
			end

			local stepperIcon = makeStepper(row.label,
				currentSize,
				function(v)
					local B = getMobileButtons()
					local btn = B and B[row.key]
					if not btn then return end
					btn:SetAttribute("SizeMultiplier", v)
					Comunicator:FireServer("SaveButtonSize", { Button = row.key, Size = v })
				end,
				{ min = 0.5, max = 2.5, step = 0.25,
					format = function(v) return row.label..": "..string.format("%.2f", v).."x" end })

			local function refreshLabel()
				stepperIcon:setLabel(row.label..": "..string.format("%.2f", currentSize()).."x")
			end
			table.insert(sizeStepperRefreshers, refreshLabel)
			table.insert(pendingInjections, refreshLabel)

			mobileSettings.add(stepperIcon)
		end


	end


	-- ================= end mobile controls settings =================
	--[[
	task.spawn(function()
		ConfigIcon:set('dropdownMaxIconsBeforeScroll', 8)

		for Index, Icon in configDropdown do
			Icon:setOrder(Index - #configDropdown)

			Icon:set("forcedIconSizeX", 32)
			Icon:set("forcedIconSizeY", 32)
			Icon:set("iconSize", UDim2.new(0, 32, 0, 32))
			Icon:set("iconImageRatio", 0.6)
		end
	end)
	]]

	task.wait(.15)

	-- Setting stuff
	local SettingsIcon
	if true then
		SettingsIcon = Icon.new()
			--:notify()
			:setOrder(2)
			:setName("Settings")
			--:setLabel("Settings")
			:setImage(3687980595)
			--:setCaption("Open Cosmetics")
			:modifyTheme({
				{"Dropdown", "MaxIcons", 8},
				{"Dropdown", "BackgroundTransparency", 1},
				{"DropdownList", "Padding", UDim.new(0, 2)},
				{"DropdownScroller", "ScrollBarImageColor3", Color3.fromRGB(0, 0, 0)},
				{"DropdownScroller", "ScrollBarImageTransparency", 0.1},
				{"DropdownPadding", "PaddingTop", UDim.new(0, 0)},
				{"DropdownPadding", "PaddingRight", UDim.new(0, 2)},
				{"DropdownPadding", "PaddingBottom", UDim.new(0, 0)},
				{"Selection", "RotationSpeed", 4},
				{"SelectionGradient", "Color", ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
				})},
			})
			:bindEvent("selected", function(icon)
				if shared.ServersIcon then
					shared.ServersIcon:deselect()
				end
				if shared.CharactersIcon then
					shared.CharactersIcon:deselect()
				end
				if shared.AdminIcon then
					shared.AdminIcon:deselect()
				end

				SoundsModule:AddSound(ClickSound)

				icon:modifyChildTheme({
					{"Widget", "BorderSize", 0},
					{"IconButton", "BackgroundTransparency", 0.18},
					{"IconCorners", "CornerRadius", UDim.new(0, 4)},
					{"Widget", "MinimumWidth", 290},
					{"Widget", "MinimumHeight", 35},
					{"IconLabel", "TextSize", 16},
					{"PaddingLeft", "Size", UDim2.fromOffset(15, 0)},
					{"Notice", "Position", UDim2.new(1, -24, 0, 5)},
				})
			end)
			:bindEvent('deselected', function(icon)
				--StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)

				SoundsModule:AddSound(ClickSound)
			end)
		local settingsDropdown = {
			Icon.new()
				:setLabel('Update Log')
				:autoDeselect(true)
				:setImage(notBoolId)

				:bindEvent('selected', function(icon)
					icon:deselect()

					SoundsModule:AddSound(ClickSound)

					local CurrentValue = Player:GetAttribute("Changelogs")

					--Comunicator:FireServer("UpdateSettings", { SettingName = "Changelogs", Value = CurrentValue })

					if CurrentValue == true then
						Player:SetAttribute("Changelogs", false)
					else
						Player:SetAttribute("Changelogs", true)
					end
				end)
			;

			--Icon.new()
			--	:setLabel('Auto Activate')
			--	:setImage(getBoolConfigLabel('Auto Use'))
			--	:autoDeselect(true)

			--	:bindEvent('selected', function(icon)
			--		icon:deselect()

			--		if ConfigFolder['Auto Use'].Value == true then
			--			icon:setImage(RedSquareId)

			--			SetSetting:FireServer("Auto Use", false)
			--		else
			--			icon:setImage(GreenSquareId)

			--			SetSetting:FireServer("Auto Use", true)
			--		end

			--		SoundsModule:AddSound(ClickSound)
			--	end)
			--;

			--Icon.new()
			--	:setLabel('Remove Packages')
			--	:setImage(getBoolConfigLabel('Character Packages'))
			--	:autoDeselect(true)

			--	:bindEvent('selected', function(icon)
			--		icon:deselect()

			--		if ConfigFolder['Character Packages'].Value == true then
			--			icon:setImage(RedSquareId)

			--			SetSetting:FireServer("Remove Packages", true)
			--		else
			--			icon:setImage(GreenSquareId)

			--			SetSetting:FireServer("Remove Packages", true)
			--			for _,v in workspace.Live:GetDescendants() do
			--				if v:IsA("CharacterMesh") then
			--					v:Destroy()
			--				end
			--			end
			--		end

			--		SoundsModule:AddSound(ClickSound)
			--	end)
			--;

			Icon.new()
				:setLabel('Fast Mode')
				:setName("FastMode")
				:setImage(getBoolConfigLabel('Fast Mode'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Fast Mode'].Value == true then
						icon:setImage(RedSquareId)

						--Comunicator:FireServer('SetConfig', { CN = 'Fast Mode'; V = false })
						SetSetting:FireServer("Fast Mode", false)
						Lighting.GlobalShadows = true
						--WindShake:Init({ MatchWorkspaceWind = false })
					else
						icon:setImage(GreenSquareId)
						Lighting.GlobalShadows = false
						--Comunicator:FireServer('SetConfig', { CN = 'Fast Mode'; V = true })
						SetSetting:FireServer("Fast Mode", true)

						--WindShake:Cleanup()
						--WindShake:Pause()

					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Day Night Cicle')
				:setName("DayNightCicle")
				:setImage(getBoolConfigLabel('Day Night Cicle'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Day Night Cicle'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Day Night Cicle", false)
						--Comunicator:FireServer('SetConfig', { CN = 'Day Night Cicle'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Day Night Cicle", true)
						--Comunicator:FireServer('SetConfig', { CN = 'Day Night Cicle'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Auto Run')
				:setImage(getBoolConfigLabel('Auto Run'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Auto Run'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Auto Run", false)

						--Comunicator:FireServer('SetConfig', { CN = 'Auto Run'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Auto Run", true)

						--Comunicator:FireServer('SetConfig', { CN = 'Auto Run'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			--Icon.new()
			--:setLabel('Awakening Music')
			--:setImage(getBoolConfigLabel('Awakening Music'))
			--:autoDeselect(true)

			--:bindEvent('selected', function(icon)
			--	icon:deselect()

			--	if ConfigFolder['Awakening Music'].Value == true then
			--		icon:setImage(RedSquareId)
			--		SetSetting:FireServer("Awakening Music", false)

			--		--Comunicator:FireServer('SetConfig', { CN = 'Awakening Music'; V = false })
			--	else
			--		icon:setImage(GreenSquareId)
			--		SetSetting:FireServer("Awakening Music", true)

			--		--Comunicator:FireServer('SetConfig', { CN = 'Awakening Music'; V = true })
			--	end

			--	SoundsModule:AddSound(ClickSound)
			--end)
			--;

			Icon.new()
				:setLabel('Emote Music')
				:setName("EmoteMusic")
				:setImage(getBoolConfigLabel('Emote Music'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Emote Music'].Value == true then
						icon:setImage(RedSquareId)

						game.SoundService["Emote Music"].Volume = 0
						SetSetting:FireServer("Emote Music", false)

						--Comunicator:FireServer('SetConfig', { CN = 'Emote Music'; V = false })
					else
						icon:setImage(GreenSquareId)

						game.SoundService["Emote Music"].Volume = 1
						SetSetting:FireServer("Emote Music", true)

						--Comunicator:FireServer('SetConfig', { CN = 'Emote Music'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Reduced Camera Shake')
				:setName("ReduceCamShake")
				:setImage(getBoolConfigLabel('Reduce Camera Shake'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Reduce Camera Shake'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Reduce Camera Shake", false)
						--Comunicator:FireServer('SetConfig', { CN = 'Reduce Camera Shake'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Reduce Camera Shake", true)
						--Comunicator:FireServer('SetConfig', { CN = 'Reduce Camera Shake'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Camera Shake')
				:setName("CameraShake")
				:setImage(getBoolConfigLabel('Camera Shake'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Camera Shake'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Camera Shake", false)
						--Comunicator:FireServer('SetConfig', { CN = 'Camera Shake'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Camera Shake", true)
						--Comunicator:FireServer('SetConfig', { CN = 'Camera Shake'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Camera Follow')
				:setName("CameraFollow")
				:setImage(getBoolConfigLabel('Camera Follow'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Camera Follow'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Camera Follow", false)
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Camera Follow", true)
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			--Icon.new()
			--	:setLabel('Destruction Physics')
			--	:setImage(getBoolConfigLabel('Destruction Physics'))
			--	:autoDeselect(true)

			--	:bindEvent('selected', function(icon)
			--		icon:deselect()

			--		if ConfigFolder['Destruction Physics'].Value == true then
			--			icon:setImage(RedSquareId)
			--			SetSetting:FireServer("Destruction Physics", false)
			--			--Comunicator:FireServer('SetConfig', { CN = 'Destruction Physics'; V = false })
			--		else
			--			icon:setImage(GreenSquareId)
			--			SetSetting:FireServer("Destruction Physics", true)
			--			--Comunicator:FireServer('SetConfig', { CN = 'Destruction Physics'; V = true })
			--		end

			--		SoundsModule:AddSound(ClickSound)
			--	end)
			--;

			Icon.new()
				:setLabel('Blood')
				:setName("Blood")
				:setImage(getBoolConfigLabel('Blood'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Blood'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Blood", false)

						--Comunicator:FireServer('SetConfig', { CN = 'Blood'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Blood", true)

						--Comunicator:FireServer('SetConfig', { CN = 'Blood'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Low Graphics')
				:setName("LowGraphics")
				:setImage(getBoolConfigLabel('Low Graphics'))
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Low Graphics'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Low Graphics", false)
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Low Graphics", true)
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Hide Gold')
				:setImage(getBoolConfigLabel('Hide Gold'))
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if ConfigFolder['Hide Gold'].Value == true then
						icon:setImage(RedSquareId)

						--Comunicator:FireServer('SetConfig', { CN = 'Hide Gold'; V = false })
					else
						icon:setImage(GreenSquareId)

						--Comunicator:FireServer('SetConfig', { CN = 'Hide Gold'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Console Controls')
				:setImage(getBoolConfigLabel('Show Console Controls'))
				:setEnabled(UIS.GamepadEnabled == true)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					local Console = PlayerGui:FindFirstChild('Console')
					local Controls = Console and Console:FindFirstChild('ConsoleControls')

					if ConfigFolder['Show Console Controls'].Value == true then
						icon:setImage(RedSquareId)

						SetSetting:FireServer("Show Console Controls", false)
						if Controls then
							Controls.Visible = false
						end
					else
						icon:setImage(GreenSquareId)

						SetSetting:FireServer("Show Console Controls", true)
						if Controls then
							Controls.Visible = UIS.GamepadEnabled
						end
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			--Icon.new()
			--:setLabel('Sound Volume: x'.. string.format("%.1f", math.clamp(ConfigFolder.Volume.Value, .1, 1)))
			--:setImage(notBoolId)
			----:set("forcedIconSizeX", 32)
			----:set("forcedIconSizeY", 32)
			----:set("iconSize", UDim2.new(0, 32, 0, 32))
			----:set("iconImageRatio", 0.6)
			--:autoDeselect(true)

			--:bindEvent("selected", function(icon)
			--	icon:deselect()

			--	SoundsModule:AddSound(ClickSound)

			--	local newVolume = ConfigFolder.Volume.Value + 0.1
			--	if 1 < newVolume then
			--		newVolume = 0.1
			--	elseif newVolume <= 0 then
			--		newVolume = 1
			--	end


			--	local volumeString = string.format("%.1f", math.clamp(newVolume, .1, 1))
			--	newVolume = tonumber(volumeString)

			--	game.SoundService.Sounds.Volume = newVolume
			--	icon:setLabel('Sound Volume: x'..volumeString)
			--	Comunicator:FireServer('SetConfig', { CN = 'Volume'; V = newVolume })
			--end)
			--;




			Icon.new()
				:setLabel('Shiftlock Offset: '.. ConfigFolder["Shiftlock Offset"].Value .. ' Studs')
				:setName("ShiftlockOffset")
				:autoDeselect(true)
				:bindEvent("selected", function(icon)
					icon:deselect()

					SoundsModule:AddSound(ClickSound)

					local newOffset = math.round((ConfigFolder["Shiftlock Offset"].Value + 0.05) * 100) / 100
					if newOffset > 5.5 then
						newOffset = 0
					end

					icon:setLabel('Shiftlock Offset: '.. tostring(newOffset) .. ' Studs')
					--Comunicator:FireServer('SetConfig', { CN = 'Shiftlock Offset'; V = newOffset })
				end)
			;

			Icon.new()
				:setLabel('Reset Shiftlock Offset')
				:autoDeselect(true)
				:setImage(notBoolId)
				:bindEvent("selected", function(icon)
					icon:deselect()

					SoundsModule:AddSound(ClickSound)

					local newOffset = math.round(1.75 * 100) / 100
					local ShiftlockOffsetIcon = PlayerGui.TopbarPlus.TopbarContainer.Config.DropdownContainer.DropdownFrame:FindFirstChild("ShiftlockOffset")
					if ShiftlockOffsetIcon then
						ShiftlockOffsetIcon.IconButton.IconLabel.Text = 'Shiftlock Offset: 1.75 Studs'
					end
					--Comunicator:FireServer('SetConfig', { CN = 'Shiftlock Offset'; V = newOffset })
				end)
			;

			--Icon.new()
			--	:setLabel('Customize Kill Sound')
			--	:setImage(notBoolId)
			--	:autoDeselect(true)
			--	--:set("iconTextColor", Color3.new(1, 0.882353, 0))
			--	:bindEvent("selected", function(icon)
			--		icon:deselect()

			--		SoundsModule:AddSound(ClickSound)

			--		local CurrentValue = Player:GetAttribute("CustomizeKillSound")

			--		if Player:GetAttribute("HasVIP") then
			--			--Comunicator:FireServer("UpdateSettings", { SettingName = "CustomizeKillSound", Value = CurrentValue })
			--		else
			--			--MarketService:PromptGamePassPurchase(Passes.VIP)
			--		end

			--		if CurrentValue == true then
			--			Player:SetAttribute("CustomizeKillSound", false)
			--		else
			--			Player:SetAttribute("CustomizeKillSound", true)
			--		end
			--	end)
			--;

			--Icon.new()
			--	:setLabel('Customize Awakening Outfit')
			--	:setImage(notBoolId)
			--	:autoDeselect(true)
			--	--:set("iconTextColor", Color3.new(1, 0.882353, 0))
			--	:bindEvent("selected", function(icon)
			--		icon:deselect()

			--		SoundsModule:AddSound(ClickSound)

			--		local CurrentValue = Player:GetAttribute("CustomizeAwakeningOutfit")

			--		if Player:GetAttribute("HasVIP") then
			--			--Comunicator:FireServer("UpdateSettings", { SettingName = "CustomizeAwakeningOutfit", Value = CurrentValue })
			--		else
			--			--MarketService:PromptGamePassPurchase(Passes.VIP)
			--		end

			--		if CurrentValue == true then
			--			Player:SetAttribute("CustomizeAwakeningOutfit", false)
			--		else
			--			Player:SetAttribute("CustomizeAwakeningOutfit", true)
			--		end
			--	end)
			--;

			--Icon.new()
			--	:setLabel('Customize VIP Cape')
			--	:setImage(notBoolId)
			--	:autoDeselect(true)
			--	--:set("iconTextColor", Color3.new(1, 0.882353, 0))
			--	:bindEvent("selected", function(icon)
			--		icon:deselect()

			--		SoundsModule:AddSound(ClickSound)

			--		local CurrentValue = Player:GetAttribute("CustomizeVIPCape")

			--		if Player:GetAttribute("HasVIP") then
			--			--Comunicator:FireServer("UpdateSettings", { SettingName = "CustomizeVIPCape", Value = CurrentValue })
			--		else
			--			--MarketService:PromptGamePassPurchase(Passes.VIP)
			--		end

			--		if CurrentValue == true then
			--			Player:SetAttribute("CustomizeVIPCape", false)
			--		else
			--			Player:SetAttribute("CustomizeVIPCape", true)
			--		end
			--	end)
			--;

			Icon.new()
				:setLabel('Hide Kills')
				:setImage(getBoolConfigLabel('Hide Kills'))
				:autoDeselect(true)
				--:set("iconTextColor", Color3.new(1, 0.882353, 0))
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Player:GetAttribute("HasVIP") then
						--return MarketService:PromptGamePassPurchase(Passes.VIP)
					end

					if ConfigFolder['Hide Kills'].Value == true then
						icon:setImage(RedSquareId)

						--Comunicator:FireServer('SetConfig', { CN = 'Hide Kills'; V = false })
					else
						icon:setImage(GreenSquareId)

						--Comunicator:FireServer('SetConfig', { CN = 'Hide Kills'; V = true })
					end

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Icon.new()
				:setLabel('Hide Killstreak')
				:setImage(getBoolConfigLabel('Hide Killstreak'))
				:autoDeselect(true)
				--:set("iconTextColor", Color3.new(1, 0.882353, 0))
				:bindEvent('selected', function(icon)
					icon:deselect()

					SoundsModule:AddSound(ClickSound)

					if not Player:GetAttribute("HasVIP") then
						-- VIP-only: offer the pass instead (the server rejects this setting for non-VIP anyway)
						return RS.Remotes.Gamepasses.RequestGamepass:FireServer("VIP")
					end

					if ConfigFolder['Hide Killstreak'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Hide Killstreak", false)
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Hide Killstreak", true)
					end
				end)
			;

			Icon.new()
				:setLabel('Hide FPS')
				:setImage(getBoolConfigLabel('Hide FPS'))
				:autoDeselect(true)
				--:set("iconTextColor", Color3.new(1, 0.882353, 0))
				:bindEvent('selected', function(icon)
					icon:deselect()

					SoundsModule:AddSound(ClickSound)

					if ConfigFolder['Hide FPS'].Value == true then
						icon:setImage(RedSquareId)
						SetSetting:FireServer("Hide FPS", false)
						--Comunicator:FireServer('SetConfig', { CN = 'Hide Killstreak'; V = false })
					else
						icon:setImage(GreenSquareId)
						SetSetting:FireServer("Hide FPS", true)
						--Comunicator:FireServer('SetConfig', { CN = 'Hide Killstreak'; V = true })
					end
				end)
			;
		}
		for _, ic in audio.all do
			table.insert(settingsDropdown, ic)
		end

		if mobileSettings then
			for _, ic in mobileSettings.all do
				table.insert(settingsDropdown, ic)
			end
		end

		SettingsIcon:setDropdown(settingsDropdown)
		SettingsIcon:setEnabled(false) -- only holds the rows now (after setDropdown, which re-enables it); the SettingsMenu button opens them
		shared.SettingsRows = settingsDropdown -- shown in the Settings menu (SettingsMenuClient)

		-- inject the +/- buttons after rows render
		task.delay(0.1, function()
			for _, inject in pendingInjections do
				inject()
			end
		end)
	end


	task.wait(.15)


	local PSE = Remotes.Commands.Set



	-- Admin stuff/ps owner stuff
	local AdminIcon

	if IsAdmin then
		------------------------------------------------------------------
		-- Kill controls (inline accordion under the "Kill" row)
		------------------------------------------------------------------
		local KillIndent = "      "
		local KillIcon, KillAllIcon, KillOthersIcon, KillSelfIcon, KillPlayerIcon
		local killExpanded = false

		local NoDotTheme = {
			{"IconImage", "ImageTransparency", 1},
		}

		-- expand / collapse the 4 inline options
		local function setKillExpanded(state)
			killExpanded = state

			KillAllIcon:setEnabled(state)
			KillOthersIcon:setEnabled(state)
			KillSelfIcon:setEnabled(state)
			KillPlayerIcon:setEnabled(state)

			if not state then
				KillPlayerIcon:deselect() -- close its scroll if it was open
			end

			KillIcon:setLabel((state and "[-] " or "[+] ") .. "Kill")
		end

		KillIcon = Icon.new()
			:setName("Kill")
			:setLabel("[+] Kill")
			:setImage(notBoolId)
			:setOrder(30)
			:autoDeselect(true)
			:bindEvent("selected", function(icon)
				icon:deselect()
				setKillExpanded(not killExpanded)
				SoundsModule:AddSound(ClickSound)
			end)

		KillAllIcon = Icon.new()
			:setName("ResetAll")
			:setLabel(KillIndent .. "Reset All Players")
			:setImage(notBoolId)
			:setOrder(31)
			:setEnabled(false)
			:autoDeselect(true)
			:modifyTheme(NoDotTheme)
			:bindEvent("selected", function(icon)
				icon:deselect()
				PSE:FireServer("Kill", { Type = "All" })
				SoundsModule:AddSound(ClickSound)
			end)

		KillOthersIcon = Icon.new()
			:setName("ResetOthers")
			:setLabel(KillIndent .. "Reset Everyone Else")
			:setImage(notBoolId)
			:setOrder(32)
			:setEnabled(false)
			:autoDeselect(true)
			:modifyTheme(NoDotTheme)
			:bindEvent("selected", function(icon)
				icon:deselect()
				PSE:FireServer("Kill", { Type = "Others" })
				SoundsModule:AddSound(ClickSound)
			end)

		KillSelfIcon = Icon.new()
			:setName("ResetSelf")
			:setLabel(KillIndent .. "Reset Yourself")
			:setImage(notBoolId)
			:setOrder(33)
			:setEnabled(false)
			:autoDeselect(true)
			:modifyTheme(NoDotTheme)
			:bindEvent("selected", function(icon)
				icon:deselect()
				PSE:FireServer("Kill", { Type = "Me" })
				SoundsModule:AddSound(ClickSound)
			end)

		KillPlayerIcon = Icon.new()
			:setName("ResetPlayer")
			:setLabel(KillIndent .. "Reset Player")
			:setImage(notBoolId)
			:setOrder(34)
			:setEnabled(false)
			:modifyTheme(NoDotTheme)
			:bindEvent("selected", function(icon)
				icon:deselect()
				if shared.killgui then
					warn("Pressed")
					shared.killgui()
				end
				SoundsModule:AddSound(ClickSound)
			end)

		AdminIcon = Icon.new()
			--:notify()
			:setOrder(3)
			:setName("AdminPanel")
			:setImage(89712560286067) -- wrench and screwdriver, no label
			--:setCaption("Open Cosmetics")
			:modifyTheme({
				{"Dropdown", "MaxIcons", 8},
				{"Dropdown", "BackgroundTransparency", 1},
				{"DropdownList", "Padding", UDim.new(0, 2)},
				{"DropdownScroller", "ScrollBarImageColor3", Color3.fromRGB(0, 0, 0)},
				{"DropdownScroller", "ScrollBarImageTransparency", 0.1},
				{"DropdownPadding", "PaddingTop", UDim.new(0, 0)},
				{"DropdownPadding", "PaddingRight", UDim.new(0, 2)},
				{"DropdownPadding", "PaddingBottom", UDim.new(0, 0)},
				{"Selection", "RotationSpeed", 4},
				{"SelectionGradient", "Color", ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
				})},
			})
			:bindEvent("selected", function(icon)
				if shared.ServersIcon then
					shared.ServersIcon:deselect()
				end
				if shared.CharactersIcon then
					shared.CharactersIcon:deselect()
				end
				if shared.SettingsIcon then
					shared.SettingsIcon:deselect()
				end

				SoundsModule:AddSound(ClickSound)

				icon:modifyChildTheme({
					{"Widget", "BorderSize", 0},
					{"IconButton", "BackgroundTransparency", 0.18},
					{"IconCorners", "CornerRadius", UDim.new(0, 4)},
					{"Widget", "MinimumWidth", 290},
					{"Widget", "MinimumHeight", 35},
					{"IconLabel", "TextSize", 16},
					{"PaddingLeft", "Size", UDim2.fromOffset(15, 0)},
					{"Notice", "Position", UDim2.new(1, -24, 0, 5)},
				})
			end)
			:bindEvent('deselected', function(icon)
				--StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
				if shared.killgui then
					shared.killgui("close")
				end

				SoundsModule:AddSound(ClickSound)
			end)
			:setDropdown({

				-- We do workspace since we want to see it on all devices. But only for the multipliers.
				SpeedMult = Icon.new()
				:setLabel('Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.SpeedMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)
				:setOrder(1)
				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['SpeedMult'] then
						Cons['SpeedMult'] = workspace.Configuration.SpeedMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.SpeedMult.Value, 0, 10)) .. "x")
						end)
					end

					PSE:FireServer('SpeedMult')
					SoundsModule:AddSound(ClickSound)
				end)
				;

				DamageMult = Icon.new()
				:setLabel('DamageMult: ' .. string.format("%.1f", math.clamp(workspace.Configuration.DamageMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)
				:setOrder(2)
				:autoDeselect(true)
				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['DamageMult'] then
						Cons['DamageMult'] = workspace.Configuration.DamageMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Damage Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.DamageMult.Value, 0, 10)) .. "x")
						end)
					end

					PSE:FireServer('DamageMult')
					SoundsModule:AddSound(ClickSound)
				end)
				;

				HealthMult = Icon.new()
				:setLabel('HealthMult: ' .. string.format("%.1f", math.clamp(workspace.Configuration.HealthMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)
				:setOrder(3)
				:autoDeselect(true)
				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['HealthMult'] then
						Cons['HealthMult'] = workspace.Configuration.HealthMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Health Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.HealthMult.Value, 0, 10)) .. "x")
						end)
					end

					PSE:FireServer('HealthMult')
					SoundsModule:AddSound(ClickSound)
				end)
				;

				RegenMult = Icon.new()
				:setLabel('RegenMult: ' .. string.format("%.1f", math.clamp(workspace.Configuration.RegenMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)
				:setOrder(4)
				:autoDeselect(true)
				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['RegenMult'] then
						Cons['RegenMult'] = workspace.Configuration.RegenMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Regen Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.RegenMult.Value, 0, 10)) .. "x")
						end)
					end

					PSE:FireServer('RegenMult')
					SoundsModule:AddSound(ClickSound)
				end)
				;

				NoCooldown = Icon.new()
				:setName('NoCooldown')
				:setLabel('No Cooldowns')
				:setImage(getPSBoolImg('NoCooldown', Player.Commands))
				:setOrder(5)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NCDS'] then
						--Cons['NCDS'] = PSCfgFolder.NoCooldown:GetPropertyChangedSignal('Value'):Connect(function()
						Cons['NCDS'] = Player.Commands.NoCooldown:GetPropertyChangedSignal("Value"):Connect(function()
							icon:setImage(getPSBoolImg('NoCooldown', Player.Commands))
						end)
					end

					PSE:FireServer('NoCooldown', {Type = "Me"})

					SoundsModule:AddSound(ClickSound)
				end)
				;

				InfiniteAwk = Icon.new()
				:setName('InfiniteAwk')
				:setLabel('Infinite Awakening')
				:setImage(getPSBoolImg('InfiniteAwk', Player.Commands))
				:autoDeselect(true)
				:setOrder(6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['INFAWK'] then
						Cons['INFAWK'] = Player.Commands.InfiniteAwk:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('InfiniteAwk', Player.Commands))
						end)
					end

					PSE:FireServer('InfiniteAwk')

					SoundsModule:AddSound(ClickSound)
				end)
				;

				GiveAwakening = Icon.new()
				:setName('Give Awakening')
				:setLabel('Give Awakening')
				:setImage(notBoolId)
				:setOrder(7)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('GiveAwakening', {Type = "Me"})

					SoundsModule:AddSound(ClickSound)
				end)
				;

				RemoveAwk = Icon.new()
				:setName('RemoveAwk')
				:setLabel('Remove Awakening')
				:setImage(notBoolId)
				:autoDeselect(true)
				:setOrder(8)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('RemoveAwk')

					SoundsModule:AddSound(ClickSound)
				end)
				;

				KillIcon ;
				KillAllIcon ;
				KillOthersIcon ;
				KillSelfIcon ;
				KillPlayerIcon ;

				--Kill = Icon.new()
				--:setName('Kill')
				--:setLabel('Kill')
				--:setImage(notBoolId)
				--:autoDeselect(true)
				--:modifyTheme({
				--	{"Dropdown", "MaxIcons", 8},
				--	{"Dropdown", "BackgroundTransparency", 1},
				--	{"DropdownList", "Padding", UDim.new(0, 2)},
				--	{"DropdownScroller", "ScrollBarImageColor3", Color3.fromRGB(0, 0, 0)},
				--	{"DropdownScroller", "ScrollBarImageTransparency", 0.1},
				--	{"DropdownPadding", "PaddingTop", UDim.new(0, 0)},
				--	{"DropdownPadding", "PaddingRight", UDim.new(0, 2)},
				--	{"DropdownPadding", "PaddingBottom", UDim.new(0, 0)},
				--	{"Selection", "RotationSpeed", 4},
				--	{"SelectionGradient", "Color", ColorSequence.new({
				--		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				--		ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
				--	})},
				--})
				--:bindEvent('selected', function(icon)
				--	icon:deselect()

				--	PSE:FireServer('Kill')

				--	SoundsModule:AddSound(ClickSound)
				--end)
				--;

				SpawnDummy = Icon.new()
				:setName('SpawnDummy')
				:setLabel('Spawn Dummy')
				:setImage(notBoolId)
				:setOrder(50)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil; ScriptName = nil })

					SoundsModule:AddSound(ClickSound)
				end)
				;

				SpawnAttackingDummy = Icon.new()
				:setName('SpawnAttackingDummy')
				:setLabel('Spawn Attacking Dummy')
				:setImage(notBoolId)
				:setOrder(51)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'AttackScript' })

					SoundsModule:AddSound(ClickSound)
				end)
				;

				SpawnBlockingDummy = Icon.new()
				:setName('SpawnBlockingDummy')
				:setLabel('Spawn Blocking Dummy')
				:setImage(notBoolId)
				:setOrder(52)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'BlockScript' })

					SoundsModule:AddSound(ClickSound)
				end)
				;

				-- Will add this later when we actually have a counter script.

				--SpawnCounteringDummy = Icon.new()
				--:setName('SpawnCounteringDummy')
				--:setLabel('Spawn Countering Dummy')
				--:setImage(notBoolId)
				--:autoDeselect(true)
				--:bindEvent('selected', function(icon)
				--	icon:deselect()

				--	PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'CounterScript' })

				--	SoundsModule:AddSound(ClickSound)
				--end)
				--;

				SpawnFinisherDummy = Icon.new()
				:setName('SpawnFinisherDummy')
				:setLabel('Spawn Finisher Dummy')
				:setImage(notBoolId)
				:setOrder(53)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = 1; ScriptName = nil })

					SoundsModule:AddSound(ClickSound)
				end)
				;

				ClearDummies = Icon.new()
				:setName('ClearDummies')
				:setLabel('Clear Dummies')
				:setImage(notBoolId)
				:setOrder(54)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('ClearDummies')

					SoundsModule:AddSound(ClickSound)
				end)
				;

				StunIndicator = Icon.new()
				:setName('ClearDummies')
				:setLabel('Stun Indicator')
				:setImage(notBoolId)
				:setOrder(55)
				:autoDeselect(true)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('StunIndicator', {Type = "Me"})

					SoundsModule:AddSound(ClickSound)
				end)
				;
			})
		AdminIcon:setEnabled(false) -- its rows are in the Settings menu now
	end

	--[[
	if Getter:InvokeServer('IsPSOwner') == true and game.PlaceId ~= workspace:GetAttribute("DuelsPlaceId") then
		local MenuSize = 8

		local CategoryChildNames = {
			{
				"Private Server +",
				'Mode',
				'MenuSize'
			},

			{
				"General",
				'Counter',
				"Godmode",
				'Heal',
				'Respawn',
				'Kill',
				'Bring',
				'Ragdoll'
			},

			{
				"Dummies",
				'SpawnDummy',
				'SpawnAttackingDummy',
				'SpawnBlockingDummy',
				'SpawnCounteringDummy',
				'SpawnFinisherDummy',
				'ClearDummies'
			},

			{
				"Toggles",
				"TpDash",
				"NoRespawn",
				"NoDashCD",
				"NoMovement",
				'NoAttack',
				'NoCooldown',
				"NoRagdoll",
				"NoFatigue",
				'NoStun',
				"NoBlock",
				"NoReset"
			},

			{
				"Awakening",
				'GiveAwk',
				'RemoveAwk',
				"ActivateAwk",
				'InfiniteAwk',
				"InstantAwk",
				"NoAwk"
			},

			{
				"Multipliers",
				"AttackSMult",
				"HealthMult",
				"DamageMult",
				"RegenMult",
				"SpeedMult",
				"GravityMult"
			},

			{
				"Moveset",
				"RandomMoveset",
				"DualMoveset",
				"OnlyFinishers"
			},

			{
				"Map",
				"BuildMode",
				"HideMap"
			},

			{
				"Misc",
				"StormActive",
				"ResetStorm",
				"StormSpeedMultiplier",
				"StormDamageMultiplier"
			},

			{
				"Server",
				"LockServer",
				"KickOnDeath",
				"ShutdownServer",
				"RefreshServer"
			}
		}

		local PSIcons = {
			GravityMult = Icon.new()
				:setLabel('Gravity Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.GravityMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['GravityMult'] then
						Cons['GravityMult'] = workspace.Configuration.GravityMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Gravity Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.GravityMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('GravityMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpeedMult = Icon.new()
				:setLabel('Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.SpeedMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['SpeedMult'] then
						Cons['SpeedMult'] = workspace.Configuration.SpeedMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.SpeedMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('SpeedMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			RegenMult = Icon.new()
				:setLabel('Regen Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.RegenMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['RegenMult'] then
						Cons['RegenMult'] = workspace.Configuration.RegenMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Regen Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.RegenMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('RegenMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			DamageMult = Icon.new()
				:setLabel('Damage Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.DamageMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['DamageMult'] then
						Cons['DamageMult'] = workspace.Configuration.DamageMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Damage Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.DamageMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('DamageMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			HealthMult = Icon.new()
				:setLabel('Health Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.HealthMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['HealthMult'] then
						Cons['HealthMult'] = workspace.Configuration.HealthMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Health Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.HealthMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('HealthMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			AttackSMult = Icon.new()
				:setLabel('Attack Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.AttackSMult.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['AttackSMult'] then
						Cons['AttackSMult'] = workspace.Configuration.AttackSMult:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Attack Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.AttackSMult.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('AttackSMult')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			StormDamageMultiplier = Icon.new()
				:setLabel('Storm Damage Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.StormDamageMultiplier.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['StormDamageMultiplier'] then
						Cons['StormDamageMultiplier'] = workspace.Configuration.StormDamageMultiplier:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Storm Damage Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.StormDamageMultiplier.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('StormDamageMultiplier')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			StormSpeedMultiplier = Icon.new()
				:setLabel('Storm Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.StormSpeedMultiplier.Value, 0, 10)) .. "x")
				:setImage(notBoolId)

				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:autoDeselect(true)

				:bindEvent("selected", function(icon)
					icon:deselect()

					if not Cons['StormSpeedMultiplier'] then
						Cons['StormSpeedMultiplier'] = workspace.Configuration.StormSpeedMultiplier:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Storm Speed Multiplier: ' .. string.format("%.1f", math.clamp(workspace.Configuration.StormSpeedMultiplier.Value, 0, 10)) .. "x")
						end)
					end


					PSE:FireServer('StormSpeedMultiplier')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			ResetStorm = Icon.new()
				:setName('ResetStorm')
				:setLabel('Reset Storm')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('ResetStorm')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			StormActive = Icon.new()
				:setName('StormActive')
				:setLabel('Storm Active')
				:setImage(getPSBoolImg('StormActive', workspace.Configuration))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['StormActive'] then
						Cons['StormActive'] = workspace.Configuration.StormActive:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('StormActive', workspace.Configuration))
						end)
					end


					PSE:FireServer('StormActive')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			RefreshServer = Icon.new()
				:setName('RefreshServer')
				:setLabel('Refresh Server')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('RefreshServer')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			ShutdownServer = Icon.new()
				:setName('ShutdownServer')
				:setLabel('Shutdown Server')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('ShutdownServer')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			KickOnDeath = Icon.new()
				:setName('KickOnDeath')
				:setLabel('Kick On Death')
				:setImage(getPSBoolImg('KickOnDeath', workspace.Configuration))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['KickOnDeath'] then
						Cons['KickOnDeath'] = workspace.Configuration.KickOnDeath:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('KickOnDeath', workspace.Configuration))
						end)
					end


					PSE:FireServer('KickOnDeath')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			LockServer = Icon.new()
				:setName('LockServer')
				:setLabel('Lock Server')
				:setImage(getPSBoolImg('LockServer', workspace.Configuration))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['LockServer'] then
						Cons['LockServer'] = workspace.Configuration.LockServer:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('LockServer', workspace.Configuration))
						end)
					end


					PSE:FireServer('LockServer')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			BuildMode = Icon.new()
				:setName('BuildMode')
				:setLabel('Build Mode')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['BuildMode'] then
						Cons['BuildMode'] = PSCfgFolder.BuildMode:GetPropertyChangedSignal('Value'):Connect(function()
							if PSCfgFolder.BuildMode.Value == true then
								shared.buildmode()
							else
								shared.nobuildmode()
							end
						end)
					end

					PSCfgFolder.BuildMode.Value = not PSCfgFolder.BuildMode.Value

					SoundsModule:AddSound(ClickSound)
				end)
			;

			HideMap = Icon.new()
				:setName('HideMap')
				:setLabel('Hide Map')
				:setImage(getPSBoolImg('HideMap', workspace.Configuration))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['HideMap'] then
						Cons['HideMap'] = workspace.Configuration.HideMap:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('HideMap', workspace.Configuration))


							local CurrGuiValue = not workspace.Configuration.HideMap.Value

							PlayerGui.Donations.Enabled = CurrGuiValue
							workspace.Miscellaneous.Donations.a.SurfaceGui.Enabled = CurrGuiValue
							workspace.Miscellaneous.Kills.a.SurfaceGui.Enabled = CurrGuiValue
							workspace.Miscellaneous.TotalKills.a.SurfaceGui.Enabled = CurrGuiValue
						end)
					end


					PSE:FireServer('HideMap')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			RandomMoveset = Icon.new()
				:setName('RandomMoveset')
				:setLabel('Random Moveset')
				:setImage(getPSBoolImg('RandomMoveset'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['RandomMoveset'] then
						Cons['RandomMoveset'] = PSCfgFolder.RandomMoveset:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('RandomMoveset'))
						end)
					end


					PSE:FireServer('RandomMoveset')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			DualMoveset = Icon.new()
				:setName('DualMoveset')
				:setLabel('Dual Moveset')
				:setImage(getPSBoolImg('DualMoveset'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['DualMoveset'] then
						Cons['DualMoveset'] = PSCfgFolder.DualMoveset:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('DualMoveset'))
						end)
					end


					PSE:FireServer('DualMoveset')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			Mode = Icon.new()
				:setName('Mode')
				:setLabel('Mode: '..getConfigValue('Mode'))
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['Mode'] then
						Cons['Mode'] = PSCfgFolder.Mode:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setLabel('Mode: '..getConfigValue('Mode'))
						end)
					end


					PSE:FireServer('Mode')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			MenuSize = Icon.new()
				:setName('MenuSize')
				:setLabel('Menu Size: '..tostring(MenuSize))
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					MenuSize += 4

					if MenuSize > 24 then
						MenuSize = 8
					end

					ConfigIcon:set('dropdownMaxIconsBeforeScroll', MenuSize)
					icon:setLabel('Menu Size: '..tostring(MenuSize))


					SoundsModule:AddSound(ClickSound)
				end)
			;

			TpDash = Icon.new()
				:setName('TpDash')
				:setLabel('Teleport Dash')
				:setImage(getPSBoolImg('TpDash'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['TpDash'] then
						Cons['TpDash'] = PSCfgFolder.TpDash:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('TpDash'))
						end)
					end


					PSE:FireServer('TpDash')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoRespawn = Icon.new()
				:setName('NoRespawn')
				:setLabel('No Respawn')
				:setImage(getPSBoolImg('NoRespawn'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoRespawn'] then
						Cons['NoRespawn'] = PSCfgFolder.NoRespawn:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoRespawn'))
						end)
					end


					PSE:FireServer('NoRespawn')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoMovement = Icon.new()
				:setName('NoMovement')
				:setLabel('No Movement')
				:setImage(getPSBoolImg('NoMovement'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoMovement'] then
						Cons['NoMovement'] = PSCfgFolder.NoMovement:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoMovement'))
						end)
					end


					PSE:FireServer('NoMovement')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoAttack = Icon.new()
				:setName('NoAttack')
				:setLabel('No Attack')
				:setImage(getPSBoolImg('NoAttack'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoAttack'] then
						Cons['NoAttack'] = PSCfgFolder.NoAttack:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoAttack'))
						end)
					end

					PSE:FireServer('NoAttack')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoCooldown = Icon.new()
				:setName('NoCooldown')
				:setLabel('No Cooldowns')
				:setImage(getPSBoolImg('NoCooldown'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NCDS'] then
						Cons['NCDS'] = PSCfgFolder.NoCooldown:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoCooldown'))
						end)
					end


					PSE:FireServer('NoCooldown')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoRagdoll = Icon.new()
				:setName('NoRagdoll')
				:setLabel('No Ragdoll')
				:setImage(getPSBoolImg('NoRagdoll'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoRagdoll'] then
						Cons['NoRagdoll'] = PSCfgFolder.NoRagdoll:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoRagdoll'))
						end)
					end


					PSE:FireServer('NoRagdoll')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoDashCD = Icon.new()
				:setName('NoDashCD')
				:setLabel('No Dash Cooldowns')
				:setImage(getPSBoolImg('NoDashCD'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NDCDS'] then
						Cons['NDCDS'] = PSCfgFolder.NoDashCD:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoDashCD'))
						end)
					end


					PSE:FireServer('NoDashCD')


					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoStun = Icon.new()
				:setName('NoStun')
				:setLabel('No Stun')
				:setImage(getPSBoolImg('NoStun'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['STN'] then
						Cons['STN'] = PSCfgFolder.NoStun:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoStun'))
						end)
					end

					PSE:FireServer('NoStun')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoBlock = Icon.new()
				:setName('NoBlock')
				:setLabel('No Block')
				:setImage(getPSBoolImg('NoBlock'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoBlock'] then
						Cons['NoBlock'] = PSCfgFolder.NoBlock:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoBlock'))
						end)
					end

					PSE:FireServer('NoBlock')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoReset = Icon.new()
				:setName('NoReset')
				:setLabel('No Reset')
				:setImage(getPSBoolImg('NoReset'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoReset'] then
						Cons['NoReset'] = PSCfgFolder.NoReset:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoReset'))
						end)
					end

					PSE:FireServer('NoReset')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoFatigue = Icon.new()
				:setName('NoFatigue')
				:setLabel('No Fatigue')
				:setImage(getPSBoolImg('NoFatigue'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NFG'] then
						Cons['NFG'] = PSCfgFolder.NoFatigue:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoFatigue'))
						end)
					end

					PSE:FireServer('NoFatigue')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			OnlyFinishers = Icon.new()
				:setName('OnlyFinishers')
				:setLabel('Finishers Only')
				:setImage(getPSBoolImg('OnlyFinishers'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['OnlyFinishers'] then
						Cons['OnlyFinishers'] = PSCfgFolder.OnlyFinishers:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('OnlyFinishers'))
						end)
					end

					PSE:FireServer('OnlyFinishers')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			GiveAwk = Icon.new()
				:setName('GiveAwk')
				:setLabel('Give Awakening')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('GiveAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			RemoveAwk = Icon.new()
				:setName('RemoveAwk')
				:setLabel('Remove Awakening')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('RemoveAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			ActivateAwk = Icon.new()
				:setName('ActivateAwk')
				:setLabel('Activate Awakening')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('ActivateAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			InfiniteAwk = Icon.new()
				:setName('InfiniteAwk')
				:setLabel('Infinite Awakening')
				:setImage(getPSBoolImg('InfiniteAwk'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['INFAWK'] then
						Cons['INFAWK'] = PSCfgFolder.InfiniteAwk:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('InfiniteAwk'))
						end)
					end

					PSE:FireServer('InfiniteAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			InstantAwk = Icon.new()
				:setName('InstantAwk')
				:setLabel('Instant Awakening')
				:setImage(getPSBoolImg('InstantAwk'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['InstantAwk'] then
						Cons['InstantAwk'] = PSCfgFolder.InstantAwk:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('InstantAwk'))
						end)
					end

					PSE:FireServer('InstantAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			NoAwk = Icon.new()
				:setName('NoAwk')
				:setLabel('No Awakening')
				:setImage(getPSBoolImg('NoAwk'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['NoAwk'] then
						Cons['NoAwk'] = PSCfgFolder.NoAwk:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('NoAwk'))
						end)
					end

					PSE:FireServer('NoAwk')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Counter = Icon.new()
				:setName('Counter')
				:setLabel('Activate Counter')
				:setImage(getPSBoolImg('Counter'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['CNTR'] then
						Cons['CNTR'] = PSCfgFolder.Counter:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('Counter'))
						end)
					end

					PSE:FireServer('Counter')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Godmode = Icon.new()
				:setName('Godmode')
				:setLabel('Godmode')
				:setImage(getPSBoolImg('Godmode'))
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					if not Cons['Godmode'] then
						Cons['Godmode'] = PSCfgFolder.Godmode:GetPropertyChangedSignal('Value'):Connect(function()
							icon:setImage(getPSBoolImg('Godmode'))
						end)
					end

					PSE:FireServer('Godmode')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Heal = Icon.new()
				:setName('Heal')
				:setLabel('Heal')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('Heal')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Respawn = Icon.new()
				:setName('Respawn')
				:setLabel('Respawn')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('Respawn')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Bring = Icon.new()
				:setName('Bring')
				:setLabel('Bring')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('Bring')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Kill = Icon.new()
				:setName('Kill')
				:setLabel('Kill')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('Kill')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			Ragdoll = Icon.new()
				:setName('Ragdoll')
				:setLabel('Ragdoll')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('Ragdoll')

					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpawnDummy = Icon.new()
				:setName('SpawnDummy')
				:setLabel('Spawn Dummy')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil; ScriptName = nil })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpawnAttackingDummy = Icon.new()
				:setName('SpawnAttackingDummy')
				:setLabel('Spawn Attacking Dummy')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'AttackScript' })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpawnBlockingDummy = Icon.new()
				:setName('SpawnBlockingDummy')
				:setLabel('Spawn Blocking Dummy')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'BlockScript' })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpawnCounteringDummy = Icon.new()
				:setName('SpawnCounteringDummy')
				:setLabel('Spawn Countering Dummy')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = nil, ScriptName = 'CounterScript' })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			SpawnFinisherDummy = Icon.new()
				:setName('SpawnFinisherDummy')
				:setLabel('Spawn Finisher Dummy')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('SpawnDummy', { InitialHp = 1; ScriptName = nil })

					SoundsModule:AddSound(ClickSound)
				end)
			;

			ClearDummies = Icon.new()
				:setName('ClearDummies')
				:setLabel('Clear Dummies')
				:setImage(notBoolId)
				:autoDeselect(true)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)
				:bindEvent('selected', function(icon)
					icon:deselect()

					PSE:FireServer('ClearDummies')

					SoundsModule:AddSound(ClickSound)
				end)
			;
		}


		local function toggleCategory(CategoryName, State)
			for _,v in CategoryChildNames do
				if v[1] ~= CategoryName then continue end

				for i, vv in v do
					if i == 1 then continue end

					PSIcons[vv]:setEnabled(State)
				end
			end
		end

		local CategoryIcons = {}
		local CategoryStates = {}


		local AddedIcons = 0
		for _, Parameters in CategoryChildNames do
			AddedIcons += 1


			local CategoryName = Parameters[1]
			CategoryStates[CategoryName] = true

			local Icon = Icon.new()
				:setName(CategoryName)

				:set("iconFont", Enum.Font.GothamBold)
				:set("forcedIconSizeX", 32)
				:set("forcedIconSizeY", 32)
				:set("iconSize", UDim2.new(0, 32, 0, 32))
				:set("iconImageRatio", 0.6)

				:setLabel('[-] ' .. CategoryName:upper())
				:autoDeselect(true)

				:bindEvent('selected', function(icon)
					icon:deselect()

					CategoryStates[CategoryName] = not CategoryStates[CategoryName]

					toggleCategory(CategoryName, CategoryStates[CategoryName])
					icon:setLabel("[" .. (CategoryStates[CategoryName] == false and "+" or "-") .. "] " .. CategoryName:upper())

					SoundsModule:AddSound(ClickSound)
				end)
			;

			CategoryIcons[CategoryName] = Icon


			CategoryIcons[Parameters(1)]:setOrder(AddedIcons)

			for ParameterIndex, ParameterName in Parameters do
				if ParameterIndex == 1 then continue end
				AddedIcons += 1

				PSIcons[ParameterName]:setOrder(AddedIcons)
			end
		end


		for _,v in CategoryIcons do
			table.insert(configDropdown, v)
		end

		for _,v in PSIcons do
			table.insert(configDropdown, v)
		end
	end

	]]


	--[[
	local ConfigIcon = Icon.new(true)
	ConfigIcon:setDropdown(configDropdown)
	shared.SettingsIcon = ConfigIcon
	]]

	shared.SettingsIcon = SettingsIcon	
	shared.AdminIcon = AdminIcon

	-- Settings + Admin in one menu (SettingsMenuClient)
	local SettingsMenuIcon = Icon.new(true)
	SettingsMenuIcon:setName("SettingsMenu")
	SettingsMenuIcon:setImage(3687980595)
	SettingsMenuIcon:autoDeselect(true)
	SettingsMenuIcon:setOrder(2)
	SettingsMenuIcon:bindEvent('selected', function()
		SettingsMenuIcon:deselect()

		if shared.settingsmenu then
			shared.settingsmenu()
		end
	end)

	task.wait(0.15)


	local EmoteIcon = Icon.new(true)
	EmoteIcon:setName('Emotes')
	EmoteIcon:setImage(13715869387)
	EmoteIcon:autoDeselect(true)
	EmoteIcon:setOrder(4)
	EmoteIcon:bindEvent('selected', function()
		EmoteIcon:deselect()

		if shared.emotegui then
			shared.emotegui()
		end
	end)


	task.wait(0.15)


	local CosmeticsIcon = Icon.new(true)
	CosmeticsIcon:setEnabled(IsNotDuels)
	CosmeticsIcon:setName('Cosmetics')
	CosmeticsIcon:setImage(12291352118)
	CosmeticsIcon:autoDeselect(true)
	CosmeticsIcon:setOrder(5)
	CosmeticsIcon:bindEvent('selected', function()
		CosmeticsIcon:deselect()

		if shared.cosgui then
			shared.cosgui()
		end
	end)


	task.wait(0.15)


	local ShopIcon = Icon.new(true)
	ShopIcon:setName("Shop")
	ShopIcon:setImage(85946371003304) -- cart (Ultimate Battlegrounds' cart without its outline; image inside decal 137762426078382)
	ShopIcon:autoDeselect(true)
	ShopIcon:setOrder(7)
	ShopIcon:bindEvent('selected', function()
		ShopIcon:deselect()

		if shared.shopgui then
			shared.shopgui()
		end
	end)
	task.wait(0.15)

	local QuestIcon = Icon.new(true)
	QuestIcon:setName("Quests")
	QuestIcon:setImage(84981818259686) -- scroll (Ultimate Battlegrounds' Quests icon, mirrored, top line removed)
	QuestIcon:autoDeselect(true)
	QuestIcon:setOrder(8)
	QuestIcon:bindEvent('selected', function()
		QuestIcon:deselect()

		if shared.questgui then
			shared.questgui()
		end
	end)

	local GroupService = game:GetService("GroupService")
	local GroupID = 6302684 -- TS
	local GroupIcon = Icon.new(true)
	GroupIcon:setName("Gifting")
	GroupIcon:setImage(132472330694697)
	GroupIcon:autoDeselect(true)
	GroupIcon:setOrder(100)
	GroupIcon:bindEvent('selected', function()
		GroupIcon:deselect()

		local GoalChildren = Player.PlayerGui:GetChildren()

		for _, ScreenGUI in pairs(GoalChildren) do
			if ScreenGUI.Name == "Cape Customization" or ScreenGUI.Name == "Awakening Outfit" or ScreenGUI.Name == "Kill Sound" then
				game:GetService("Debris"):AddItem(ScreenGUI, 0)
			end

			if ScreenGUI.Name == "Cosmetics" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				GoalFrame.Visible = true
				GoalFrame.Visible = false
			elseif ScreenGUI.Name == "Gifting" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				GoalFrame.Visible = true
				GoalFrame.Visible = false
			elseif ScreenGUI.Name == "Emotes" then
				local GoalImageLabel = ScreenGUI:FindFirstChild("ImageLabel")
				GoalImageLabel.Visible = true
				GoalImageLabel.Visible = false
			end
		end

		pcall(function()
			GroupService:PromptJoinAsync(GroupID)
		end)
	end)
	GroupIcon:align("Right")

	-- Update Log (UpdateLogClient; what it says is ReplicatedStorage.Modules.UpdateLog)
	local UpdateLogIcon = Icon.new(true)
	UpdateLogIcon:setName("UpdateLog")
	UpdateLogIcon:setImage(103556445419081) -- newspaper
	UpdateLogIcon:autoDeselect(true)
	UpdateLogIcon:setOrder(99)
	UpdateLogIcon:align("Right")
	UpdateLogIcon:bindEvent('selected', function()
		UpdateLogIcon:deselect()
		if shared.updatelog then
			shared.updatelog()
		end
	end)

	-- Hide / show the whole top bar (Heroes Battlegrounds has one): hides every button but this one,
	-- the group button and the server label (ServerBrowserClient), closing whatever is open; the
	-- arrow then points the other way. Just the arrow, no bubble behind it. Buttons that were already hidden (e.g. Cosmetics in Duels) stay hidden.
	local CollapseIcon = Icon.new(true)
	CollapseIcon:setName("Collapse")
	local ARROW_HIDE, ARROW_SHOW = 120595228109974, 127485878449884 -- black arrow with a white outline, pointing left / right
	CollapseIcon:setImage(ARROW_HIDE)
	task.spawn(function() -- both arrows loaded up front, so the swap is instant
		local ContentProvider = game:GetService("ContentProvider")
		pcall(ContentProvider.PreloadAsync, ContentProvider, { "rbxassetid://" .. ARROW_HIDE, "rbxassetid://" .. ARROW_SHOW })
	end)
	CollapseIcon:autoDeselect(true)
	CollapseIcon:setOrder(1000)
	CollapseIcon:modifyTheme({
		{ "IconButton", "BackgroundTransparency", 1 },
		-- a bigger arrow in a narrower button, so it sits closer to the other buttons
		{ "IconImageScale", "Value", 0.8 },
		{ "Widget", "DesiredWidth", 30 },
		{ "Widget", "MinimumWidth", 30 },
		{ "Widget", "BorderSize", 0 },
		{ "PaddingLeft", "Size", UDim2.new(0, 0, 1, 0) },
		{ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) },
	})
	CollapseIcon:disableOverlay(true) -- no hover bubble either
	local KEEP_SHOWN = { ServerInfo = true, Gifting = true, UpdateLog = true } -- the right side stays
	local Collapsed = false
	local HiddenByCollapse = {}
	CollapseIcon:bindEvent('selected', function()
		CollapseIcon:deselect()
		Collapsed = not Collapsed
		if Collapsed then
			local ExpeditionUI = require(RS.Modules.ExpeditionUI)
			ExpeditionUI.CloseAllMenus()
			for _, Other in Icon.getIcons() do
				if Other ~= CollapseIcon and not KEEP_SHOWN[Other.name] and not Other.parentIconUID
					and not Other.isAnOverflow and Other.isEnabled then
					Other:setEnabled(false)
					table.insert(HiddenByCollapse, Other)
				end
			end
		else
			for _, Other in HiddenByCollapse do
				Other:setEnabled(true)
			end
			table.clear(HiddenByCollapse)
		end
		CollapseIcon:setImage(if Collapsed then ARROW_SHOW else ARROW_HIDE)
	end)




	--[[
	if not IsAdmin then
		Player:GetAttributeChangedSignal("isAdmin"):Connect(function()
			IsAdmin = Player:GetAttribute("isAdmin") or false
		end)
	end

	local shiftlockIcon = configDropdown[1]
	local moveBtnsIcon = configDropdown[2]
	local resetBtnsIcon = configDropdown[3]

	local function toggleNonKeyboardIcons()
		local currentValue = UIS.TouchEnabled == true or UIS.GamepadEnabled == true

		shiftlockIcon:setEnabled(currentValue)
		moveBtnsIcon:setEnabled(currentValue)
		resetBtnsIcon:setEnabled(currentValue)
	end

	toggleNonKeyboardIcons()
	UIS:GetPropertyChangedSignal('TouchEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.TouchEnabled == false then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)

	UIS:GetPropertyChangedSignal('GamepadEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.GamepadEnabled == true then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)

	UIS:GetPropertyChangedSignal('KeyboardEnabled'):Connect(function()
		toggleNonKeyboardIcons()

		if UIS.KeyboardEnabled == true then
			if TouchGui then
				TouchGui.Enabled = false
			end
		end	
	end)
	]]

	local loadedTopBar = Instance.new('BoolValue')
	loadedTopBar.Name = 'loadedTopBar'
	loadedTopBar.Value = true
	loadedTopBar.Parent = Player
end)


-- Top-bar feel (from Ultimate Battlegrounds' top bar): the button squeezes to 87.5% and springs
-- back when pressed, its icon flashes white and the circle flashes faintly. The top-level buttons
-- also get their hover sound and a soft hover highlight, the same click sound for every button
-- (instead of each icon playing its own), and buttons listed in IMAGES swap to an "On" image while
-- their window is open, like theirs. Hooks every TopbarPlus icon, including ones other scripts make
-- (RankedIcon).
do
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TweenService = game:GetService("TweenService")
	local Debris = game:GetService("Debris")

	local Icon = require(ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Icon"))

	local PRESSED_SCALE = 0.875
	local PRESS = TweenInfo.new(0.0875, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local RELEASE = TweenInfo.new(0.175, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	local FADE = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
	local CIRCLE_FLASH = 0.9 -- how faint the circle's flash starts (1 = invisible)

	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI")) -- its Hover / Click sounds
	local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local HOVER = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local HOVER_HIGHLIGHT = 0.88 -- how strong the hover highlight is (1 = invisible)

	-- whether each button's window is open; buttons not listed use TopbarPlus' own selected state
	-- (the Characters dropdown)
	local function GuiOpen(Name: string): () -> boolean
		return function()
			local Gui = PlayerGui:FindFirstChild(Name)
			return Gui ~= nil and Gui:IsA("ScreenGui") and Gui.Enabled
		end
	end
	local IS_OPEN: { [string]: () -> boolean } = {
		Shop = GuiOpen("StoreUI"),
		Quests = GuiOpen("QuestsUI"),
		Cosmetics = GuiOpen("CosmeticsUI"),
		SettingsMenu = GuiOpen("SettingsUI"),
		Ranked = GuiOpen("ServersUI"),
		UpdateLog = GuiOpen("UpdateLogUI"),
		Emotes = function()
			return (shared :: any).emoteWheelOpen == true -- set by StarterGui.Emotes.WheelHandler2D
		end,
	}
	-- buttons with an "On" image for while their window is open
	local IMAGES: { [string]: { Off: number, On: number } } = {
	}
	local OpenSetters: { [any]: (boolean) -> () } = {}
	-- windows that play the Open sound themselves (ExpeditionUI); the rest (emote wheel,
	-- Characters list) get it from here, so everything that opens sounds the same
	local PLAYS_OWN_OPEN = { Shop = true, Quests = true, Cosmetics = true, SettingsMenu = true, Ranked = true, UpdateLog = true }

	local Hooked: { [Instance]: boolean } = setmetatable({}, { __mode = "k" }) :: any

	-- a white copy of the icon image laid over it, fading out
	local function FlashImage(Button: GuiObject, Image: ImageLabel, Scale: UIScale)
		if not Image.Visible or Image.Image == "" then
			return
		end
		local Ghost = Instance.new("ImageLabel")
		Ghost.Name = "ClickFlash"
		Ghost.BackgroundTransparency = 1
		Ghost.Image = Image.Image
		Ghost.ImageRectOffset = Image.ImageRectOffset
		Ghost.ImageRectSize = Image.ImageRectSize
		Ghost.ScaleType = Image.ScaleType
		Ghost.ImageColor3 = Color3.new(1, 1, 1)
		Ghost.ImageTransparency = 0
		-- the real image sits in a layout list, so place the copy by where it is on screen
		local Factor = math.max(Scale.Scale, 0.01)
		local Offset = (Image.AbsolutePosition - Button.AbsolutePosition) / Factor
		local Size = Image.AbsoluteSize / Factor
		Ghost.Position = UDim2.fromOffset(Offset.X, Offset.Y)
		Ghost.Size = UDim2.fromOffset(Size.X, Size.Y)
		Ghost.ZIndex = Image.ZIndex + 5
		Ghost.Parent = Button
		TweenService:Create(Ghost, FADE, { ImageTransparency = 1 }):Play()
		Debris:AddItem(Ghost, 0.5)
	end

	-- a faint white flash over the whole circle (or pill)
	local function FlashCircle(Button: GuiObject)
		local Glow = Instance.new("Frame")
		Glow.Name = "ClickGlow"
		Glow.Size = UDim2.fromScale(1, 1)
		Glow.BackgroundColor3 = Color3.new(1, 1, 1)
		Glow.BackgroundTransparency = CIRCLE_FLASH
		Glow.BorderSizePixel = 0
		Glow.ZIndex = 20
		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(1, 0)
		Corner.Parent = Glow
		Glow.Parent = Button
		TweenService:Create(Glow, FADE, { BackgroundTransparency = 1 }):Play()
		Debris:AddItem(Glow, 0.5)
	end

	local function Hook(TheIcon: any)
		local Widget = TheIcon and TheIcon.widget
		if not Widget or Hooked[Widget] then
			return
		end
		local Button = Widget:FindFirstChild("IconButton", true)
		local Click = Widget:FindFirstChild("ClickRegion", true)
		local Image = Widget:FindFirstChild("IconImage", true)
		if not (Button and Click and Button:IsA("GuiObject") and Click:IsA("GuiObject")) then
			return
		end
		Hooked[Widget] = true

		local Scale = Button:FindFirstChild("ClickFXScale") :: UIScale?
		if not Scale then
			local NewScale = Instance.new("UIScale")
			NewScale.Name = "ClickFXScale"
			NewScale.Parent = Button
			Scale = NewScale
		end
		local TheScale = Scale :: UIScale

		-- dropdown rows (Characters, Settings) keep their own sounds and look
		local function TopLevel(): boolean
			return not TheIcon.parentIconUID and not TheIcon.locked -- locked: a label, not a button
		end
		local function Circle(Name: string): Frame
			local Frame = Instance.new("Frame")
			Frame.Name = Name
			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundColor3 = Color3.new(1, 1, 1)
			Frame.BackgroundTransparency = 1
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 1
			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(1, 0)
			Corner.Parent = Frame
			Frame.Parent = Button
			return Frame
		end

		-- buttons with no bubble (the hide arrow) get no highlight, squeeze or flashes, just the sounds
		-- (HBG's arrow simply swaps)
		local Bare = TheIcon.name == "Collapse"

		-- hover: a soft highlight, and the hover sound (mouse only)
		local Highlight = Circle("HoverFX")
		Click.MouseEnter:Connect(function()
			if not TopLevel() then
				return
			end
			if not Bare then
				TweenService:Create(Highlight, HOVER, { BackgroundTransparency = HOVER_HIGHLIGHT }):Play()
			end
			if UserInputService.MouseEnabled then
				UI.Play("Hover", 0.15)
			end
		end)
		Click.MouseLeave:Connect(function()
			TweenService:Create(Highlight, HOVER, { BackgroundTransparency = 1 }):Play()
		end)

		-- open: its "On" image while this button's window is open (if it has one)
		local ShownOpen = false
		OpenSetters[TheIcon] = function(Open: boolean)
			if Open == ShownOpen then
				return
			end
			ShownOpen = Open
			if Open and not PLAYS_OWN_OPEN[TheIcon.name] then
				UI.Play("Open", 0.5)
			end
			local Pair = IMAGES[TheIcon.name]
			if Pair then
				pcall(TheIcon.setImage, TheIcon, if Open then Pair.On else Pair.Off)
			end
		end

		local Held = false
		local function Release()
			if Held then
				Held = false
				TweenService:Create(TheScale, RELEASE, { Scale = 1 }):Play()
			end
		end
		Click.InputBegan:Connect(function(Input)
			local Kind = Input.UserInputType
			if Kind == Enum.UserInputType.MouseButton1 or Kind == Enum.UserInputType.Touch then
				Held = true
				if TopLevel() then
					UI.Play("Click", 0.4) -- every top-bar button sounds the same
				end
				if not Bare then
					TweenService:Create(TheScale, PRESS, { Scale = PRESSED_SCALE }):Play()
					if Image and Image:IsA("ImageLabel") then
						FlashImage(Button, Image, TheScale)
					end
					FlashCircle(Button)
				end
			end
		end)
		Click.InputEnded:Connect(function(Input)
			local Kind = Input.UserInputType
			if Kind == Enum.UserInputType.MouseButton1 or Kind == Enum.UserInputType.Touch then
				Release()
			end
		end)
		Click.MouseLeave:Connect(Release)
	end

	for _, Existing in Icon.getIcons() do
		task.spawn(Hook, Existing)
	end
	Icon.iconAdded:Connect(function(NewIcon)
		task.defer(Hook, NewIcon) -- after TopbarPlus has built its widget
	end)

	-- keep the "On" images (and the Open sound) in step with the windows
	task.spawn(function()
		while true do
			task.wait(0.15)
			for TheIcon, SetOpen in OpenSetters do
				if TheIcon.parentIconUID or TheIcon.isAnOverflow then
					continue
				end
				local Check = IS_OPEN[TheIcon.name]
				SetOpen(if Check then Check() else TheIcon.isSelected == true)
			end
		end
	end)
end

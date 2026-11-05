-- EmotesModule (ModuleScript)
-- All emote logic: cards, spin roulette, wheel/slot pages, bulk products, listeners.

-- SERVICES --
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local EmotesModule = {}

function EmotesModule.init(ctx)
	local MainFrame = ctx.MainFrame
	local Template  = ctx.Template
	assert(MainFrame, "EmotesModule.init: ctx.MainFrame is required")
	assert(Template,  "EmotesModule.init: ctx.Template is required")

	local Player = Players.LocalPlayer
	local InfoModule = require(RS:WaitForChild("Info"))
	local EmotesFolder = RS.Assets.Animations.Emotes
	local Remotes = RS.Remotes

	local EmotesSF = MainFrame.EmotesScrollingFrame

	local emotesGrid = EmotesSF:WaitForChild("UIGridLayout")
	if emotesGrid then
		local function resizeEmotesCanvas()
			EmotesSF.CanvasSize = UDim2.new(0, 0, 0, emotesGrid.AbsoluteContentSize.Y)
		end
		emotesGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeEmotesCanvas)
		resizeEmotesCanvas()
	end


	-- VARIABLES --
	local EmoteIds = {}   -- [EmoteName] = AnimationId

	local isSpinning = {}
	local slotCD = false
	local CosmeticCD = false      -- independent from the Cosmetics script's cooldown
	local CurrentPage = 1
	local EmotesTabActive = false

	local selectedEmote = nil

	local OwnedEmotes = {}
	local EquippedEmotes = {}


	-- Initial emote data fetch
	local okEmotes = pcall(function()
		OwnedEmotes = Remotes.Emotes.GetOwnedEmotes:InvokeServer() or {}

		local eqP1, eqP2 = Remotes.Emotes.GetEquippedEmotes:InvokeServer()
		eqP1 = eqP1 or {}
		eqP2 = eqP2 or {}
		for slot, name in eqP1 do EquippedEmotes["1_" .. slot] = name end
		for slot, name in eqP2 do EquippedEmotes["2_" .. slot] = name end
	end)
	if not okEmotes then warn("[Emotes] initial data fetch failed") end


	-- FUNCTIONS --

	local function GetEmoteAnim(emoteName)
		for _, descendant in EmotesFolder:GetDescendants() do
			if descendant:IsA("Animation") and descendant.Name == emoteName then
				return descendant
			end
		end
		return nil
	end

	-- Establish Rarity Weights for Sorting
	local function GetRarityWeight(rarityName)
		-- Adjust these string names to match your exact folder names in RS
		local weights = {
			["Secret"] = 7,
			["Mythic"] = 6,
			["Legendary"] = 5,
			["Epic"] = 4,
			["Rare"] = 3,
			["Uncommon"] = 2,
			["Common"] = 1
		}
		return weights[rarityName] or 0
	end

	-- Sorts the OwnedEmotes table by Rarity -> Alphabetical, then updates LayoutOrder
	local function SortOwnedEmotes()
		table.sort(OwnedEmotes, function(a, b)
			local animA = GetEmoteAnim(a)
			local animB = GetEmoteAnim(b)

			local rarityA = (animA and animA.Parent:IsA("Folder") and animA.Parent ~= EmotesFolder) and animA.Parent.Name or "Common"
			local rarityB = (animB and animB.Parent:IsA("Folder") and animB.Parent ~= EmotesFolder) and animB.Parent.Name or "Common"

			local weightA = GetRarityWeight(rarityA)
			local weightB = GetRarityWeight(rarityB)

			if weightA ~= weightB then
				return weightA > weightB -- Highest rarity first
			else
				return a < b -- Alphabetical fallback
			end
		end)

		for index, emoteName in ipairs(OwnedEmotes) do
			local frame = EmotesSF:FindFirstChild(emoteName)
			if frame then
				frame.LayoutOrder = index
			end
		end
	end

	local function countUnownedEmotes(ownedList)
		local n = 0
		for _, anim in EmotesFolder:GetDescendants() do
			if anim:IsA("Animation") and not table.find(ownedList, anim.Name) then n += 1 end
		end
		return n
	end

	local function RefreshEmoteBulkVisibility()
		local remaining = countUnownedEmotes(OwnedEmotes)

		if remaining == 0 then
			MainFrame.EmoteBulk.Visible = false
		elseif remaining < 5 then
			MainFrame.EmoteBulk.Visible = true
			MainFrame.EmoteBulk.Emotesx10.Visible = false
			MainFrame.EmoteBulk.Emotesx5.Visible = false
			MainFrame.EmoteBulk.Emotesx1.Visible = true
		elseif remaining < 10 then
			MainFrame.EmoteBulk.Visible = true
			MainFrame.EmoteBulk.Emotesx10.Visible = false
			MainFrame.EmoteBulk.Emotesx5.Visible = true
			MainFrame.EmoteBulk.Emotesx1.Visible = true
		else
			MainFrame.EmoteBulk.Visible = true
			MainFrame.EmoteBulk.Emotesx10.Visible = true
			MainFrame.EmoteBulk.Emotesx5.Visible = true
			MainFrame.EmoteBulk.Emotesx1.Visible = true
		end
	end

	local function getRandomFakeEmote()
		local anims = {}
		for _, desc in EmotesFolder:GetDescendants() do
			if desc:IsA("Animation") and desc.Name ~= "Resolute" then
				table.insert(anims, desc)
			end
		end

		if #anims > 0 then
			local chosen = anims[math.random(1, #anims)]
			local rarity = (chosen.Parent and chosen.Parent:IsA("Folder") and chosen.Parent ~= EmotesFolder) and chosen.Parent.Name or "Common"
			return chosen.Name, rarity
		end
		return "Unknown", "Common"
	end

	-- Creating emote slots (the scrolling-frame cards). Clones the injected Template.
	local function CreateEmoteFrame(EmoteName: string)
		if EmotesSF:FindFirstChild(EmoteName) then
			return EmotesSF[EmoteName]
		end

		local Frame = Template:Clone()
		Frame.Name = EmoteName
		Frame.Info.Text = EmoteName
		Frame.Parent = EmotesSF

		local EmoteAnim = GetEmoteAnim(EmoteName)
		local Rarity = (EmoteAnim and EmoteAnim.Parent:IsA("Folder") and EmoteAnim.Parent ~= EmotesFolder) and EmoteAnim.Parent.Name or "Common"
		local RarityData = InfoModule.EmoteRarities and InfoModule.EmoteRarities[Rarity] or {Color = Color3.new(1, 1, 1)}

		local isEquipped = false
		for _, name in EquippedEmotes do
			if name == EmoteName then
				isEquipped = true
				break
			end
		end

		-- Setup Rarity UIStroke
		local stroke = Frame:FindFirstChildOfClass("UIStroke")
		if stroke then
			stroke.Color = RarityData.Color
			stroke.Thickness = 2
		end

		local viewport = Frame:FindFirstChild("ViewportFrame")
		local loadedTrack = nil
		--local startFrame = 0.1

		if viewport and EmoteAnim then
			local worldModel = viewport:FindFirstChild("WorldModel")
			local dummy = worldModel and worldModel:FindFirstChild("Preview")

			if dummy then
				local humanoid = dummy:FindFirstChild("Humanoid")
				local animator = humanoid and humanoid:FindFirstChild("Animator")

				if humanoid and not animator then
					animator = Instance.new("Animator")
					animator.Parent = humanoid
				end

				if animator then
					local animObject = dummy:FindFirstChild("Animation")
					if animObject and animObject:IsA("Animation") then
						animObject.AnimationId = EmoteAnim.AnimationId
						loadedTrack = animator:LoadAnimation(animObject)
					end
					loadedTrack.Looped = true
					
					loadedTrack:Play(0)
					loadedTrack:AdjustSpeed(0)
					loadedTrack.TimePosition = .1
				end
			end
		end

		-- Play on Hover
		Frame.ImageButton.MouseEnter:Connect(function()
			if loadedTrack then
				loadedTrack:AdjustSpeed(1)
			end
		end)

		-- Stop on Leave
		Frame.ImageButton.MouseLeave:Connect(function()
			if loadedTrack then
				loadedTrack:AdjustSpeed(0)
			end
		end)

		-- Emote Selection Logic
		Frame.ImageButton.Activated:Connect(function()
			if CosmeticCD then return end
			CosmeticCD = true
			task.delay(0.5, function() CosmeticCD = false end)

			selectedEmote = EmoteName

			for _, child in EmotesSF:GetChildren() do
				if child:IsA("Frame") then
					local s = child:FindFirstChildOfClass("UIStroke")
					if s then
						if child.Name == EmoteName then
							s.Color = Color3.fromRGB(42, 255, 85) -- Gold for Selected
							s.Thickness = 2
						else
							-- Reset other frames back to their Rarity Color
							local childAnim = GetEmoteAnim(child.Name)
							local childRarity = (childAnim and childAnim.Parent:IsA("Folder") and childAnim.Parent ~= EmotesFolder) and childAnim.Parent.Name or "Common"
							local childRarityData = InfoModule.EmoteRarities and InfoModule.EmoteRarities[childRarity] or {Color = Color3.new(1, 1, 1)}

							s.Color = childRarityData.Color
							s.Thickness = 1
						end
					end
				end
			end

			shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()
		end)

		return Frame
	end


	-- SPIN ROULETTE --
	local function setupSpinner(spinFolder)
		local frame = spinFolder:FindFirstChild("Frame")
		local textLabel = frame and frame:FindFirstChild("TextLabel")
		local button = spinFolder:FindFirstChild("Button")

		if not (textLabel and button) then return end

		button.Activated:Connect(function()
			if isSpinning[spinFolder] then return end
			isSpinning[spinFolder] = true

			local success, realEmoteName, rarityName, goldAwarded, rolledEmoteName = Remotes.Emotes.SpinEmote:InvokeServer()
			if not success then
				isSpinning[spinFolder] = false
				shared.sfx({ SoundId = "rbxassetid://131661013076677", Parent = workspace, Volume = 0.6 }):Play()
				return
			end

			for i = 1, 30 do
				local fakeName, fakeRarity = getRandomFakeEmote()
				local rarityData = (InfoModule.EmoteRarities and InfoModule.EmoteRarities[fakeRarity])
					or { Color = Color3.new(1, 1, 1) }
				textLabel.Text = fakeName
				textLabel.TextColor3 = rarityData.Color

				shared.sfx({ SoundId = "rbxassetid://116394299154002", Parent = workspace, Volume = 0.5 }):Play()
				task.wait(i * 0.015)
			end

			-- Final reveal
			local revealRarityData = (InfoModule.EmoteRarities and InfoModule.EmoteRarities[rarityName])
				or { Color = Color3.new(1, 1, 1) }

			if realEmoteName then
				textLabel.Text = realEmoteName
				textLabel.TextColor3 = revealRarityData.Color

				shared.sfx({ SoundId = "rbxassetid://4612378086", Parent = workspace, Volume = 0.4 }):Play()

				local realEmoteAnim = GetEmoteAnim(realEmoteName)
				if realEmoteAnim then
					EmoteIds[realEmoteName] = realEmoteAnim.AnimationId
				end
				if not table.find(OwnedEmotes, realEmoteName) then
					table.insert(OwnedEmotes, realEmoteName)
				end

				local newFrame:Frame = CreateEmoteFrame(realEmoteName)
				local stroke = newFrame:FindFirstChild("UIStroke")
				if stroke then
					--warn("Made green")
					stroke.Color = Color3.fromRGB(0, 255, 0)
					stroke.Thickness = 3
					task.delay(3, function()
						if newFrame.Parent and selectedEmote ~= realEmoteName then
							local cAnim = GetEmoteAnim(realEmoteName)
							local cRarity = (cAnim and cAnim.Parent:IsA("Folder") and cAnim.Parent ~= EmotesFolder) and cAnim.Parent.Name or "Common"
							local cRarityData = InfoModule.EmoteRarities and InfoModule.EmoteRarities[cRarity] or {Color = Color3.new(1, 1, 1)}
							stroke.Color = cRarityData.Color
							stroke.Thickness = 2
						end
					end)
				end
				
				SortOwnedEmotes()
				RefreshEmoteBulkVisibility()
			else
				textLabel.Text = (rolledEmoteName or "?") .. " +" .. tostring(goldAwarded or 0) .. " Gold"
				textLabel.TextColor3 = revealRarityData.Color
				shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.6 }):Play()
			end

			isSpinning[spinFolder] = false
		end)
	end

	-- Initialize the 3 Spinners
	setupSpinner(MainFrame.SpinList:FindFirstChild("1"))
	setupSpinner(MainFrame.SpinList:FindFirstChild("2"))
	setupSpinner(MainFrame.SpinList:FindFirstChild("3"))


	-- Seed EmoteIds for anything already owned
	for _, EmoteName in OwnedEmotes do
		local anim = GetEmoteAnim(EmoteName)
		if anim then
			EmoteIds[EmoteName] = anim.AnimationId
		end
	end


	-- WHEEL / SLOT PAGES --
	local EmoteUI     = MainFrame:WaitForChild("EmoteUI"):WaitForChild("ImageLabel")
	local Page1Folder = EmoteUI:WaitForChild("Emotes")
	local Page2Folder = EmoteUI:WaitForChild("Emotes2")
	local EmoteSwitch = EmoteUI:FindFirstChild("Switch") or MainFrame:FindFirstChild("EmoteSwitch")

	local hasMoreEmotes = Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes")
	local hasSecondPage = Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage")

	local PagesSlots = { [1] = {}, [2] = {} }
	for slotNum = 1, 8 do
		PagesSlots[1][slotNum] = Page1Folder:FindFirstChild(tostring(slotNum))
		PagesSlots[2][slotNum] = Page2Folder:FindFirstChild(tostring(slotNum))
	end

	local function PlayAnim(animator: Animator, animation: Animation)
		for _, track in animator:GetPlayingAnimationTracks() do
			track:Stop()
		end
		local track = animator:LoadAnimation(animation)
		track.Looped = true
		track:Play()
	end

	local function SetSlotDisplay(slotFrame, emoteName: string?)
		if not slotFrame then return end

		local label = slotFrame:FindFirstChild("EmoteName")
		local animId = emoteName and EmoteIds[emoteName]

		if not animId then
			if label then
				label.Text = "Empty"
				label.TextColor3 = Color3.fromRGB(120, 120, 120)
			end
			return
		end

		if label then
			label.Text = emoteName
			label.TextColor3 = Color3.fromRGB(255, 255, 255)
		end

		local anim = GetEmoteAnim(emoteName)
		local prop = slotFrame:FindFirstChild("EmoteProperty")
		if prop then
			local desc = anim and anim:GetAttribute("Description")
			prop.Visible = desc ~= nil
			if desc then prop.Text = desc end
		end

		local viewport  = slotFrame:FindFirstChild("ViewportFrame")
		local world     = viewport and viewport:FindFirstChild("WorldModel")
		local preview   = world and world:FindFirstChild("Preview")
		local animation = preview and preview:FindFirstChild("Animation")
		local humanoid  = preview and preview:FindFirstChild("Humanoid")
		local animator  = humanoid and humanoid:FindFirstChild("Animator")

		if animation and animator then
			animation.AnimationId = animId
			PlayAnim(animator, animation)
		end
	end

	local function ClearEmoteHighlights()
		for _, child in EmotesSF:GetChildren() do
			if child:IsA("Frame") then
				local s = child:FindFirstChildOfClass("UIStroke")
				if s then
					local cAnim = GetEmoteAnim(child.Name)
					local cRarity = (cAnim and cAnim.Parent:IsA("Folder") and cAnim.Parent ~= EmotesFolder) and cAnim.Parent.Name or "Common"
					local cRarityData = InfoModule.EmoteRarities and InfoModule.EmoteRarities[cRarity] or {Color = Color3.new(1, 1, 1)}

					s.Color = cRarityData.Color
					s.Thickness = 1
				end
			end
		end
	end

	local function SetupSlot(page: number, slotNum: number, slotFrame)
		local btn = slotFrame:FindFirstChild("Button")
		if not btn then
			warn("Emote slot missing Button:", page, slotNum)
			return
		end

		btn.Activated:Connect(function()
			if slotCD then return end

			local label = slotFrame:FindFirstChild("EmoteName")

			if not selectedEmote then
				if label then
					local prev = label.TextColor3
					label.TextColor3 = Color3.fromRGB(200, 50, 50)
					task.delay(0.4, function() label.TextColor3 = prev end)
				end
				return
			end

			slotCD = true
			task.delay(0.1, function() slotCD = false end)

			local pageStr = page == 1 and "Emotes" or "Emotes2"
			local couldSet = Remotes.Emotes.ChangeEmotes:InvokeServer({
				Slot = tostring(slotNum),
				EmoteName = selectedEmote,
				Page = pageStr,
			})

			if couldSet then
				EquippedEmotes[page .. "_" .. slotNum] = selectedEmote
				SetSlotDisplay(slotFrame, selectedEmote)

				shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()

				selectedEmote = nil
				ClearEmoteHighlights()
			end
		end)
	end

	for page = 1, 2 do
		for slotNum, slotFrame in PagesSlots[page] do
			SetupSlot(page, slotNum, slotFrame)
			SetSlotDisplay(slotFrame, EquippedEmotes[page .. "_" .. slotNum])

			local lbl = slotFrame:FindFirstChild("Slot")
			if lbl then lbl.Text = tostring(slotNum) end
		end
	end

	RefreshEmoteBulkVisibility()

	local function RefreshSlotVisibility()
		local canPage2 = (hasMoreEmotes == true) and (hasSecondPage == true)
		if not canPage2 then CurrentPage = 1 end

		local maxSlots = hasMoreEmotes and 8 or 4

		EmoteUI.Visible = EmotesTabActive
		MainFrame.EmoteBulk.Visible = EmotesTabActive and countUnownedEmotes(OwnedEmotes) > 0
		MainFrame.SpinList.Visible = EmotesTabActive
		MainFrame.Spins.Visible = EmotesTabActive
		MainFrame.BuyEmoteSpins.Visible = EmotesTabActive

		for page = 1, 2 do
			local pageActive = EmotesTabActive and (CurrentPage == page)
			for slotNum = 1, 8 do
				local frame = PagesSlots[page][slotNum]
				if frame then
					frame.Visible = pageActive and (slotNum <= maxSlots)
				end
			end
		end

		if EmoteSwitch then
			EmoteSwitch.Visible = EmotesTabActive and canPage2
		end
	end

	if EmoteSwitch and EmoteSwitch:IsA("GuiButton") then
		EmoteSwitch.Activated:Connect(function()
			if not (hasMoreEmotes and hasSecondPage) then return end
			CurrentPage = CurrentPage == 1 and 2 or 1
			RefreshSlotVisibility()
			shared.sfx({ SoundId = "rbxassetid://5797580410", Parent = workspace, Volume = 0.75 }):Play()
		end)
	end

	RefreshSlotVisibility()

	-- Build the scrolling-frame cards for owned emotes
	for _, EmoteName in OwnedEmotes do
		CreateEmoteFrame(EmoteName)
	end
	
	SortOwnedEmotes()

	-- LISTENERS --

	Remotes.Emotes.Set.OnClientEvent:Connect(function(Action: string, Params: { any })
		-- Update Owned Emotes doesn't work anymore since we don't fire the remote no more. We wait for spinner to complete and then show it.
		if Action == 'UpdateOwnedEmotes' then
			for _, EmoteName in Params.OwnedEmotes do
				if not EmoteIds[EmoteName] then
					local anim = GetEmoteAnim(EmoteName)
					if anim then EmoteIds[EmoteName] = anim.AnimationId end
				end

				if EmotesSF:FindFirstChild(EmoteName) then continue end

				if not table.find(OwnedEmotes, EmoteName) then
					table.insert(OwnedEmotes, EmoteName)
				end
				
				--warn("creating new frame")

				local newFrame:Frame = CreateEmoteFrame(EmoteName)
				local stroke = newFrame:FindFirstChild("UIStroke")
				if stroke then
					--warn("Made green")
					stroke.Color = Color3.fromRGB(0, 255, 0)
					stroke.Thickness = 3
					task.delay(3, function()
						if newFrame.Parent and selectedEmote ~= EmoteName then
							local cAnim = GetEmoteAnim(EmoteName)
							local cRarity = (cAnim and cAnim.Parent:IsA("Folder") and cAnim.Parent ~= EmotesFolder) and cAnim.Parent.Name or "Common"
							local cRarityData = InfoModule.EmoteRarities and InfoModule.EmoteRarities[cRarity] or {Color = Color3.new(1, 1, 1)}
							stroke.Color = cRarityData.Color
							stroke.Thickness = 2
						end
					end)
				end

				--shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.6 }):Play()
				shared.sfx({ SoundId = "rbxassetid://4612378086", Parent = workspace, Volume = 0.4 }):Play()
			end

			SortOwnedEmotes()
			RefreshEmoteBulkVisibility()

		elseif Action == 'SlotUpdated' then
			local pageIndex = Params.Page == "Emotes" and 1 or 2
			local slotNum = tonumber(Params.Slot)
			local slotFrame = PagesSlots[pageIndex] and PagesSlots[pageIndex][slotNum]

			EquippedEmotes[pageIndex .. "_" .. slotNum] = Params.EmoteName
			SetSlotDisplay(slotFrame, Params.EmoteName)
		end
	end)

	Remotes.Gamepasses.GamepassPurchased.OnClientEvent:Connect(function(gamepassId)
		gamepassId = tostring(gamepassId)
		if gamepassId == "2063706242"   -- MoreEmotes pass
			or gamepassId == "2063782093"  -- SecondPage pass
			or gamepassId == "3726822535"  -- MoreEmotes gift product
			or gamepassId == "3726822706"  -- SecondPage gift product
		then
			hasMoreEmotes = Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes")
			hasSecondPage = Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage")
			RefreshSlotVisibility()
		end
	end)

	-- BULK PRODUCT BUTTONS --
	MainFrame.EmoteBulk.Emotesx1.Activated:Connect(function()
		Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote")
	end)

	MainFrame.EmoteBulk.Emotesx5.Activated:Connect(function()
		Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote x5")
	end)

	MainFrame.EmoteBulk.Emotesx10.Activated:Connect(function()
		Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote x10")
	end)
	
	MainFrame.BuyEmoteSpins.Activated:Connect(function()
		local result = Remotes.Emotes.BuyEmoteSpins:InvokeServer()
		if result == "Bought" then
			shared.sfx({
				SoundId = "rbxassetid://4612384643",
				Parent = workspace,
				Volume = 0.6
			}):Play()
		end
	end)
	
	local function updateSpins()
		local value = Player:GetAttribute("EmoteSpins") or 0
		script.Parent.Parent.Frame.Spins.Spins.Text = "Spins: " .. value
	end

	Player:GetAttributeChangedSignal("EmoteSpins"):Connect(updateSpins)
	updateSpins()
	
	print("EmotesModule initialized")

	-- Controller returned to the shell; the tab bar drives this.
	return {
		setTabActive = function(active: boolean)
			EmotesTabActive = active
			RefreshSlotVisibility()
		end,
	}
end

return EmotesModule
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
	-- Radial layout matching StarterGui.Emotes.WheelHandler, so the circle you
	-- equip into sits exactly where that emote appears in the in-game wheel.
	--
	--   ring 1  (top)     page indicator      <- the wheel's "Close" position
	--   ring 2-9          equip slots 1-8
	--   ring 10 (bottom)  page switch         <- the wheel's "More" position
	--
	-- Positions 1 and 10 are kept rather than skipped precisely so that equip
	-- slot N lands on the same circle in both UIs.

	local EmoteUI = MainFrame:WaitForChild("EmoteUI"):WaitForChild("ImageLabel")

	-- these are reassigned by the GamepassPurchased listener further down
	local hasMoreEmotes = Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes")
	local hasSecondPage = Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage")

	-- The pre-built panel slots are superseded by circles built in code here.
	local OldPage1  = EmoteUI:FindFirstChild("Emotes")
	local OldPage2  = EmoteUI:FindFirstChild("Emotes2")
	local OldSwitch = EmoteUI:FindFirstChild("Switch") or MainFrame:FindFirstChild("EmoteSwitch")
	-- Emotes/Emotes2 are Folders, which have no Visible property -- hide the slot
	-- frames inside them instead. Switch is a button, so it hides directly.
	local function hideOld(inst: Instance?)
		if not inst then return end
		if inst:IsA("GuiObject") then
			inst.Visible = false
			return
		end
		for _, child in ipairs(inst:GetChildren()) do
			if child:IsA("GuiObject") then
				child.Visible = false
			end
		end
	end

	hideOld(OldPage1)
	hideOld(OldPage2)
	hideOld(OldSwitch)

	-- Visual spec copied from the wheel so the two stay in step.
	local WHEEL_RADIUS = 0.42
	local BUTTON_SIZE  = UDim2.new(0.14, 0, 0.14, 0)
	local HOVER_SIZE   = UDim2.new(0.17, 0, 0.17, 0)
	-- Must match RING_ORDER in WheelHandler, otherwise the circle you equip into
	-- is no longer the circle that plays it.
	local POS_INDEX_BY_SLOT = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
	local SLOT_KEY_NAMES    = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
	local FILL_IDLE    = Color3.fromRGB(30, 30, 35)
	local FILL_HOVER   = Color3.fromRGB(45, 45, 55)
	local BADGE_COLOR  = Color3.fromRGB(255, 195, 75)
	local TW_HOVER     = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local PREVIEW_REFERENCE_HEIGHT = 5
	local PREVIEW_ZOOM = 1.0
	local PREVIEW_VERTICAL_BIAS = 0.0

	local function posFromRing(index: number): UDim2
		local a = ((POS_INDEX_BY_SLOT[index] or index) - 1) * (math.pi * 2 / 10) - math.pi / 2
		return UDim2.new(0.5 + math.cos(a) * WHEEL_RADIUS, 0, 0.5 + math.sin(a) * WHEEL_RADIUS, 0)
	end

	-- PREVIEW RIGS (your own avatar, body only, fixed framing -- same as the wheel) --

	local function buildPreviewRig(): Model?
		local char = Player.Character
		if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

		local wasArchivable = char.Archivable
		char.Archivable = true
		local ok, clone = pcall(function() return char:Clone() end)
		char.Archivable = wasArchivable
		if not ok or not clone then return nil end

		-- weapon Models and Tools sit directly under the character
		for _, child in ipairs(clone:GetChildren()) do
			if child:IsA("Tool") or child:IsA("Model") then
				child:Destroy()
			end
		end

		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("BaseScript") or d:IsA("ModuleScript")
				or d:IsA("Sound") or d:IsA("ParticleEmitter") or d:IsA("Trail") then
				d:Destroy()
			elseif d:IsA("BasePart") then
				d.CanCollide = false
				d.CanQuery = false
				d.CanTouch = false
			end
		end

		local hum = clone:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
			if not hum:FindFirstChildOfClass("Animator") then
				Instance.new("Animator").Parent = hum
			end
		end

		pcall(function() clone:PivotTo(CFrame.new(0, 0, 0)) end)

		local hrp = clone:FindFirstChild("HumanoidRootPart")
		if hrp and hrp:IsA("BasePart") then hrp.Anchored = true end

		return clone
	end

	local function frameCamera(cam: Camera, rig: Model)
		local hrp = rig:FindFirstChild("HumanoidRootPart")
		local look = (hrp and hrp:IsA("BasePart")) and hrp.CFrame.LookVector or Vector3.new(0, 0, -1)
		local origin = (hrp and hrp:IsA("BasePart")) and hrp.Position or Vector3.new(0, 0, 0)

		local zoom = math.max(PREVIEW_ZOOM, 0.05)
		local dist = (PREVIEW_REFERENCE_HEIGHT * 0.5)
			/ math.tan(math.rad(cam.FieldOfView * 0.5)) * 1.25 / zoom
		local focus = origin + Vector3.new(0, PREVIEW_REFERENCE_HEIGHT * PREVIEW_VERTICAL_BIAS, 0)

		cam.CFrame = CFrame.lookAt(focus + look * dist, focus)
	end

	-- RING CONSTRUCTION --

	local existingRing = EmoteUI:FindFirstChild("EmoteRing")
	if existingRing then existingRing:Destroy() end

	local Ring = Instance.new("Frame")
	Ring.Name = "EmoteRing"
	Ring.AnchorPoint = Vector2.new(0.5, 0.5)
	Ring.Position = UDim2.new(0.5, 0, 0.5, 0)
	Ring.Size = UDim2.new(1, 0, 1, 0)
	Ring.BackgroundTransparency = 1
	Ring.Parent = EmoteUI

	local ringRatio = Instance.new("UIAspectRatioConstraint")
	ringRatio.AspectRatio = 1
	ringRatio.DominantAxis = Enum.DominantAxis.Height
	ringRatio.Parent = Ring

	local function buildCircle(index: number)
		local btn = Instance.new("TextButton")
		btn.Name = "Ring" .. tostring(index)
		btn.Size = BUTTON_SIZE
		btn.Position = posFromRing(index)
		btn.AnchorPoint = Vector2.new(0.5, 0.5)
		btn.BackgroundColor3 = FILL_IDLE
		btn.BackgroundTransparency = 0.15
		btn.Text = ""
		btn.AutoButtonColor = false
		btn.Parent = Ring

		local grad = Instance.new("UIGradient")
		grad.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 70)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30)),
		})
		grad.Rotation = 90
		grad.Parent = btn

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(1, 0)
		corner.Parent = btn

		local vp = Instance.new("ViewportFrame")
		vp.Name = "EmotePreview"
		vp.Size = UDim2.new(1, 0, 1, 0)
		vp.Position = UDim2.new(0.5, 0, 0.5, 0)
		vp.AnchorPoint = Vector2.new(0.5, 0.5)
		vp.BackgroundTransparency = 1
		vp.LightColor = Color3.fromRGB(242, 244, 255)
		vp.LightDirection = Vector3.new(-1, -1, 0)
		vp.Ambient = Color3.fromRGB(110, 120, 128)
		vp.Visible = false
		vp.Active = false
		vp.ZIndex = 2
		vp.Parent = btn

		local vpCorner = Instance.new("UICorner")
		vpCorner.CornerRadius = UDim.new(1, 0)
		vpCorner.Parent = vp

		local world = Instance.new("WorldModel")
		world.Parent = vp

		local cam = Instance.new("Camera")
		cam.FieldOfView = 40
		cam.Parent = vp
		vp.CurrentCamera = cam

		local name = Instance.new("TextLabel")
		name.Name = "EmoteName"
		name.Size = UDim2.new(0.8, 0, 0.4, 0)
		name.Position = UDim2.new(0.1, 0, 0.15, 0)
		name.BackgroundTransparency = 1
		name.Text = ""
		name.TextColor3 = Color3.new(1, 1, 1)
		name.Font = Enum.Font.GothamBold
		name.TextScaled = true
		name.ZIndex = 1
		name.Parent = btn

		local ghost = name:Clone()
		ghost.Name = "NameGhost"
		ghost.ZIndex = 3
		ghost.TextTransparency = 0.8
		ghost.Parent = btn

		local badge = Instance.new("TextLabel")
		badge.Name = "Badge"
		badge.Size = UDim2.new(0.8, 0, 0.16, 0)
		badge.Position = UDim2.new(0.1, 0, 0.06, 0)
		badge.BackgroundTransparency = 1
		badge.Text = "LOCKED"
		badge.TextColor3 = BADGE_COLOR
		badge.Font = Enum.Font.GothamBold
		badge.TextScaled = true
		badge.Visible = false
		badge.ZIndex = 3
		badge.Parent = btn

		local key = Instance.new("TextLabel")
		key.Name = "Key"
		key.Size = UDim2.new(0.8, 0, 0.25, 0)
		key.Position = UDim2.new(0.1, 0, 0.55, 0)
		key.BackgroundTransparency = 1
		key.Text = SLOT_KEY_NAMES[index]
		key.TextColor3 = Color3.fromRGB(200, 200, 200)
		key.Font = Enum.Font.GothamMedium
		key.TextScaled = true
		key.ZIndex = 3
		key.Parent = btn
		Instance.new("UIStroke").Parent = key

		local circle = {
			Button = btn,
			NameLabel = name,
			NameGhost = ghost,
			Badge = badge,
			KeyLabel = key,
			Viewport = vp,
			World = world,
			Camera = cam,
			Animator = nil,
			Track = nil,
			Interactive = false,
		}

		btn.MouseEnter:Connect(function()
			if not circle.Interactive then return end
			TweenService:Create(btn, TW_HOVER, {
				Size = HOVER_SIZE,
				BackgroundColor3 = FILL_HOVER,
			}):Play()
		end)

		btn.MouseLeave:Connect(function()
			TweenService:Create(btn, TW_HOVER, {
				Size = BUTTON_SIZE,
				BackgroundColor3 = FILL_IDLE,
			}):Play()
		end)

		return circle
	end

	local RingSlots = {}
	for i = 1, 10 do
		RingSlots[i] = buildCircle(i)
	end

	local function ensureRigs()
		for i = 1, 10 do
			local c = RingSlots[i]
			if not (c.Rig and c.Rig.Parent) then
				for _, child in ipairs(c.World:GetChildren()) do child:Destroy() end
				local rig = buildPreviewRig()
				if rig then
					rig.Parent = c.World
					c.Rig = rig
					local hum = rig:FindFirstChildOfClass("Humanoid")
					c.Animator = hum and hum:FindFirstChildOfClass("Animator")
					frameCamera(c.Camera, rig)
				end
			end
		end
	end

	local function setCircleAnimation(circle, animId: string?)
		if circle.Track then
			pcall(function() circle.Track:Stop(0) end)
			circle.Track = nil
		end

		if not animId or animId == "" or not circle.Animator then
			circle.Viewport.Visible = false
			return
		end

		local anim = Instance.new("Animation")
		anim.AnimationId = animId

		local ok, track = pcall(function() return circle.Animator:LoadAnimation(anim) end)
		if not ok or not track then
			circle.Viewport.Visible = false
			return
		end

		track.Looped = true
		track:Play()
		circle.Track = track
		circle.Viewport.Visible = true
	end

	-- PagesSlots keeps the shape the listeners expect: PagesSlots[page][slotNum].
	-- The ring shows one page at a time, so these are lightweight tokens rather
	-- than distinct frames; SetSlotDisplay resolves a token to its live circle.
	local PagesSlots = { [1] = {}, [2] = {} }
	for page = 1, 2 do
		for slotNum = 1, 8 do
			PagesSlots[page][slotNum] = { page = page, slot = slotNum }
		end
	end

	local function paintEquipSlot(circle, emoteName: string?, locked: boolean)
		circle.Badge.Visible = locked
		circle.Interactive = not locked

		if locked then
			circle.NameLabel.Text = "Locked"
			circle.NameLabel.Position = UDim2.new(0.1, 0, 0.24, 0)
			circle.NameLabel.Size = UDim2.new(0.8, 0, 0.32, 0)
			circle.NameLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
			setCircleAnimation(circle, nil)
		else
			circle.NameLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
			circle.NameLabel.Size = UDim2.new(0.8, 0, 0.4, 0)

			local animId = emoteName and EmoteIds[emoteName]
			if animId then
				circle.NameLabel.Text = emoteName
				circle.NameLabel.TextColor3 = Color3.new(1, 1, 1)
				setCircleAnimation(circle, animId)
			else
				circle.NameLabel.Text = "Empty"
				circle.NameLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
				setCircleAnimation(circle, nil)
			end
		end

		circle.NameGhost.Text = circle.NameLabel.Text
		circle.NameGhost.Position = circle.NameLabel.Position
		circle.NameGhost.Size = circle.NameLabel.Size
		circle.NameGhost.TextTransparency = 0.8
	end

	-- Kept for the listeners at the bottom of this module.
	local function SetSlotDisplay(token, emoteName: string?)
		if not token then return end
		if token.page ~= CurrentPage then return end -- other page is not on screen

		local circle = RingSlots[token.slot + 1] -- equip slot N lives on ring N+1
		if not circle then return end

		local maxSlots = hasMoreEmotes and 8 or 4
		paintEquipSlot(circle, emoteName, token.slot > maxSlots)
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

	local function assignToSlot(slotNum: number)
		if slotCD then return end

		local circle = RingSlots[slotNum + 1]

		if not selectedEmote then
			if circle then
				local prev = circle.NameLabel.TextColor3
				circle.NameLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
				task.delay(0.4, function()
					circle.NameLabel.TextColor3 = prev
				end)
			end
			return
		end

		slotCD = true
		task.delay(0.1, function() slotCD = false end)

		local pageStr = CurrentPage == 1 and "Emotes" or "Emotes2"
		local couldSet = Remotes.Emotes.ChangeEmotes:InvokeServer({
			Slot = tostring(slotNum),
			EmoteName = selectedEmote,
			Page = pageStr,
		})

		if couldSet then
			EquippedEmotes[CurrentPage .. "_" .. slotNum] = selectedEmote
			paintEquipSlot(circle, selectedEmote, false)

			shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()

			selectedEmote = nil
			ClearEmoteHighlights()
		end
	end

	-- ring 2-9: the equip slots
	for slotNum = 1, 8 do
		local circle = RingSlots[slotNum + 1]
		circle.Button.Activated:Connect(function()
			if not circle.Interactive then
				shared.sfx({ SoundId = "rbxassetid://5797580410", Parent = workspace, Volume = 0.75 }):Play()
				Remotes.Gamepasses.RequestGamepass:FireServer("MoreEmotes")
				return
			end
			assignToSlot(slotNum)
		end)
	end

	local RefreshSlotVisibility

	-- ring 10: page switch (the wheel's "More")
	RingSlots[10].Button.Activated:Connect(function()
		if not (hasMoreEmotes and hasSecondPage) then
			shared.sfx({ SoundId = "rbxassetid://5797580410", Parent = workspace, Volume = 0.75 }):Play()
			Remotes.Gamepasses.RequestGamepass:FireServer(
				hasMoreEmotes and "SecondPage" or "MoreEmotes"
			)
			return
		end
		CurrentPage = CurrentPage == 1 and 2 or 1
		RefreshSlotVisibility()
		shared.sfx({ SoundId = "rbxassetid://5797580410", Parent = workspace, Volume = 0.75 }):Play()
	end)

	RefreshEmoteBulkVisibility()

	function RefreshSlotVisibility()
		local canPage2 = (hasMoreEmotes == true) and (hasSecondPage == true)
		if not canPage2 then CurrentPage = 1 end

		local maxSlots = hasMoreEmotes and 8 or 4

		EmoteUI.Visible = EmotesTabActive
		MainFrame.EmoteBulk.Visible = EmotesTabActive and countUnownedEmotes(OwnedEmotes) > 0
		MainFrame.SpinList.Visible = EmotesTabActive
		MainFrame.Spins.Visible = EmotesTabActive
		MainFrame.BuyEmoteSpins.Visible = EmotesTabActive

		if not EmotesTabActive then return end

		ensureRigs()

		-- ring 1: page indicator
		local pageCircle = RingSlots[1]
		pageCircle.Interactive = false
		pageCircle.Badge.Visible = false
		pageCircle.NameLabel.Text = "Page " .. tostring(CurrentPage)
		pageCircle.NameLabel.TextColor3 = Color3.new(1, 1, 1)
		pageCircle.NameGhost.Text = pageCircle.NameLabel.Text
		setCircleAnimation(pageCircle, nil)

		-- ring 2-9: equip slots for the page on screen
		for slotNum = 1, 8 do
			paintEquipSlot(
				RingSlots[slotNum + 1],
				EquippedEmotes[CurrentPage .. "_" .. slotNum],
				slotNum > maxSlots
			)
		end

		-- ring 10: page switch
		local switchCircle = RingSlots[10]
		switchCircle.Interactive = canPage2
		switchCircle.Badge.Visible = not canPage2
		switchCircle.NameLabel.Text = canPage2
			and (CurrentPage == 1 and "Page 2" or "Page 1")
			or "More"
		switchCircle.NameLabel.TextColor3 = canPage2 and Color3.new(1, 1, 1) or Color3.fromRGB(160, 160, 160)
		if not canPage2 then
			switchCircle.NameLabel.Position = UDim2.new(0.1, 0, 0.24, 0)
			switchCircle.NameLabel.Size = UDim2.new(0.8, 0, 0.32, 0)
		else
			switchCircle.NameLabel.Position = UDim2.new(0.1, 0, 0.15, 0)
			switchCircle.NameLabel.Size = UDim2.new(0.8, 0, 0.4, 0)
		end
		switchCircle.NameGhost.Text = switchCircle.NameLabel.Text
		switchCircle.NameGhost.Position = switchCircle.NameLabel.Position
		switchCircle.NameGhost.Size = switchCircle.NameLabel.Size
		setCircleAnimation(switchCircle, nil)
	end

	Player.CharacterAdded:Connect(function()
		for i = 1, 10 do
			local c = RingSlots[i]
			c.Rig = nil
			c.Animator = nil
			c.Track = nil
			for _, child in ipairs(c.World:GetChildren()) do child:Destroy() end
		end
		if EmotesTabActive then RefreshSlotVisibility() end
	end)

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

	--print("EmotesModule initialized")

	-- Controller returned to the shell; the tab bar drives this.
	return {
		setTabActive = function(active: boolean)
			EmotesTabActive = active
			RefreshSlotVisibility()
		end,
	}
end

return EmotesModule
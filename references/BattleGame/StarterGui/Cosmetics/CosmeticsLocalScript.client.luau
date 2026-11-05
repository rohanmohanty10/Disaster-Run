-- Cosmetics LocalScript

-- SERVICES --

local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")


-- PLAYER --

local Player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") == true --and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

local Character = Player.Character or Player.CharacterAdded:Wait()

local PlayerCosmeticsFolder: Folder = Player:WaitForChild('Cosmetics')
local PlayerEquippedAccessoriesFolder: Folder = PlayerCosmeticsFolder:WaitForChild('Accessories')
local PlayerEquippedAurasFolder: Folder = PlayerCosmeticsFolder:WaitForChild('Auras')

local InfoModule = require(RS:WaitForChild("Info"))

-- Assets --

local EmotesFolder = RS.Assets.Animations.Emotes

-- REMOTES --

local Remotes = RS.Remotes
local CosmeticsRems = Remotes.Cosmetics

local CosmSet = CosmeticsRems.Set
local CosmGet = CosmeticsRems.Get


local SpinConnections = {}

-- GUI --

local GUI = script.Parent
local MainFrame = GUI.Frame
local Wheel = GUI.Wheel
MainFrame.Visible = false


local AccessoriesSF = MainFrame.AccessoriesScrollingFrame
local AccessoryBtn = MainFrame.Accessories

local AurasSF = MainFrame.AurasScrollingFrame
local AurasBtn = MainFrame.Auras

local TitlesSF = MainFrame.TitleList
local TitlesBtn = MainFrame.Titles

local FinisherSF = MainFrame.FinisherScrollingFrame
local FinisherBtn = MainFrame.Finisher

local EmotesSF = MainFrame.EmotesScrollingFrame
local EmotesBtn = MainFrame.Emotes

local emotesGrid = EmotesSF:WaitForChild("UIGridLayout")

if emotesGrid then
	local function resizeEmotesCanvas()
		MainFrame.EmotesScrollingFrame.CanvasSize =
			UDim2.new(0, 0, 0, emotesGrid.AbsoluteContentSize.Y)
	end
	emotesGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeEmotesCanvas)
	resizeEmotesCanvas()
end


-- VARIABLES
local EmoteIds = {}   -- [EmoteName] = AnimationId

-- Per-card refresh functions, called whenever the player's kills change so the
-- progress bar fills and the item un-blacks the moment its requirement is met.
local CardRefreshers = {}

-- SPIN ROULETTE SYSTEM --
local isSpinning = {}

local slotCD = false
local CurrentPage = 1
local EmotesTabActive = false

local ImagesTweens = {}
local CosmeticCD = false

local selectedEmote = nil


local AllCosmeticsInformation = {}
local OwnedAccessories = {}
local OwnedAuras = {}
local OwnedEmotes = {}

local EquippedAccessories = {}
local EquippedAuras = ""
local EquippedEmotes = {}




local Success, Result = pcall(function()
	return CosmGet:InvokeServer({ Goal = "GetAllCosmetics" })
end)

if Success then
	AllCosmeticsInformation = Result

	OwnedAccessories = CosmGet:InvokeServer({ Goal = "GetOwnedAccessories" }) or {}
	OwnedAuras = CosmGet:InvokeServer({ Goal = "GetOwnedAuras" }) or {}
	OwnedEmotes = Remotes.Emotes.GetOwnedEmotes:InvokeServer() or {}
	
	EquippedAccessories = CosmGet:InvokeServer({ Goal = "GetEquippedAccessories" }) or ""
	EquippedAuras = CosmGet:InvokeServer({ Goal = "GetEquippedAuras" }) or ""
	local eqP1, eqP2 = Remotes.Emotes.GetEquippedEmotes:InvokeServer()
	eqP1 = eqP1 or {}
	eqP2 = eqP2 or {}
	for slot, name in eqP1 or {} do EquippedEmotes["1_" .. slot] = name end
	for slot, name in eqP2 or {} do EquippedEmotes["2_" .. slot] = name end
end

local leaderKills = Player:WaitForChild("leaderstats"):WaitForChild("Total Kills")


-- FUNCTIONS --
local function TriggerScrolls(NotHide: string)
	shared.sfx({
		SoundId = "rbxassetid://15675032796", 
		Parent = workspace, 
		Volume = 0.5
	}):Play()

	for _,Scroll: ScrollingFrame in MainFrame:GetChildren() do
		if Scroll:IsA('ScrollingFrame') then
			if Scroll.Name ~= NotHide then
				Scroll.Visible = false
			else
				Scroll.Visible = true
			end
		end
	end

	if NotHide ~= TitlesSF.Name then
		TitlesSF.Visible = false

		MainFrame.BackgroundTransparency = 0.35
	end
end

local function TriggerViewport(viewport: ViewportFrame, State: boolean)
	if viewport == nil or State == nil then return end

	viewport:SetAttribute('Active', State)

	-- Dim the viewport when not equipped by darkening with a overlay frame
	local overlay = viewport.Parent:FindFirstChild("DimOverlay")
	if not overlay then
		overlay = Instance.new("Frame")
		overlay.Name = "DimOverlay"
		overlay.Size = UDim2.new(1, 0, 1, 0)
		overlay.BackgroundColor3 = Color3.new(0, 0, 0)
		overlay.BorderSizePixel = 0
		overlay.ZIndex = 2
		overlay.Parent = viewport.Parent
	end

	local targetTransparency = State and 1 or .6 -- equipped = slight dim, unequipped = very dark
	TweenService:Create(overlay, TweenInfo.new(0.2), {BackgroundTransparency = targetTransparency}):Play()
end

-- An accessory/aura counts as "unlocked" (shown lit, not blacked-out) if the
-- player already owns it OR has enough Total Kills to equip it. VIP items use an
-- impossibly high Kills value, so they stay locked until actually owned.
local function isUnlocked(name: string, requiredKills: number?): boolean
	return table.find(OwnedAccessories, name) ~= nil
		or table.find(OwnedAuras, name) ~= nil
		or leaderKills.Value >= (requiredKills or 0)
end

local function UpdateFrameVisuals(Frame, isEquipped: boolean, isOwned: boolean, playerKills: number, requiredKills: number)
	-- Box outline
	local stroke = Frame:FindFirstChildOfClass("UIStroke")
	if stroke then
		if isEquipped then
			stroke.Color = Color3.fromRGB(38, 210, 35)   -- gold
			stroke.Thickness = 1
		elseif isOwned then
			stroke.Color = Color3.fromRGB(255, 255, 255)     -- dim gray-blue
			stroke.Thickness = 1
		else
			stroke.Color = Color3.fromRGB(0, 0, 0)     -- dim gray-blue
			stroke.Thickness = 1
		end
	end

	local viewport = Frame:FindFirstChildOfClass("ViewportFrame")
	if viewport then
		local overlay = Frame:FindFirstChild("DimOverlay")  
		if not overlay then
			overlay = Instance.new("Frame")
			overlay.Name = "DimOverlay"
			overlay.Size = UDim2.new(1, 0, 1, 0)
			overlay.BackgroundColor3 = Color3.new(0, 0, 0)
			overlay.BorderSizePixel = 0
			overlay.ZIndex = 2
			overlay.Parent = viewport.Parent
		end
		if isEquipped then
			overlay.BackgroundTransparency = 1
		elseif isOwned then
			overlay.BackgroundTransparency = 0.6
		else
			overlay.BackgroundTransparency = 0.4  --  dark for locked
		end
	end


	-- Kill progress bar
	local progressBG   = Frame:FindFirstChild("ProgressBar")
	local progressFill = progressBG and progressBG:FindFirstChild("ProgressBarFill")
	if progressFill then
		if requiredKills <= 0 or isOwned then
			progressFill.Size = UDim2.new(1, 0, 1, 0)
			progressFill.BackgroundColor3 = Color3.fromRGB(50, 160, 85)
		else
			local pct = math.clamp(playerKills / requiredKills, 0, 1)
			progressFill.Size = UDim2.new(pct, 0, 1, 0)

			-- hue goes from 0 (red) to 120 (green) as pct goes 0 → 1
			progressFill.BackgroundColor3 = Color3.fromHSV(pct * (120/360), 0.85, 0.75)
		end
	end
end

local function RefreshFullFrame(sf: ScrollingFrame, category: string, accessoryData: table, newEquipped: boolean)
	local frame = sf:FindFirstChild(accessoryData.Name)
	if not frame then return end

	local isOwned
	if category == "Auras" then
		isOwned = table.find(OwnedAuras, accessoryData.Name) ~= nil
	else
		isOwned = table.find(OwnedAccessories, accessoryData.Name) ~= nil
	end

	local isEquipped = newEquipped
	-- Treat "meets the kill requirement" the same as owned, so items you qualify
	-- for show lit instead of blacked-out.
	local unlocked = isUnlocked(accessoryData.Name, accessoryData.Kills)

	-- Image tint
	if isEquipped then
		frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
		frame.Info.Info.TextColor3   = Color3.new(1, 1, 1)
		frame.Info.TextColor3 = Color3.new(1, 1, 1)
	elseif unlocked then
		frame.ImageLabel.ImageColor3 = Color3.new(0.35, 0.35, 0.35)
		frame.Info.Info.TextColor3   = Color3.new(1, 1, 1)
		frame.Info.TextColor3 = Color3.new(1, 1, 1)
	else
		frame.ImageLabel.ImageColor3 = Color3.new(0, 0, 0.1)
		frame.Info.Info.TextColor3   = Color3.new(1, 0, 0)
		frame.Info.TextColor3 = Color3.new(1, 0, 0)
	end

	-- Stroke + progress bar (pass "unlocked" so the frame reads as available)
	UpdateFrameVisuals(frame, isEquipped, unlocked, leaderKills.Value, accessoryData.Kills)
end

-- Creating emote slots
local function CreateEmoteFrame(EmoteName: string, layoutOrder: number)
	if MainFrame.EmotesScrollingFrame:FindFirstChild(EmoteName) then
		return MainFrame.EmotesScrollingFrame[EmoteName]
	end

	local Frame = script.Frame:Clone()
	Frame.LayoutOrder = layoutOrder
	Frame.Name = EmoteName
	Frame.Info.Text = EmoteName
	Frame.Info.Info.Text = "Owned"
	Frame.Info.Info.TextColor3 = Color3.new(0, 1, 0)
	Frame.Parent = MainFrame.EmotesScrollingFrame

	--local EmoteAnim = GetEmoteAnim(EmoteName)
	--local Rarity = "Common" -- Default
	--if EmoteAnim and EmoteAnim.Parent:IsA("Folder") and EmoteAnim.Parent ~= EmotesFolder then
	--	Rarity = EmoteAnim.Parent.Name
	--end

	--local RarityData = InfoModule.Rarities[Rarity] or InfoModule.Rarities["Common"]

	---- Update Text and Colors
	--Frame.Info.Info.Text = Rarity
	--Frame.Info.Info.TextColor3 = RarityData.Color


	local isEquipped = false
	for _, name in EquippedEmotes do
		if name == EmoteName then
			isEquipped = true
			break
		end
	end

	UpdateFrameVisuals(Frame, isEquipped, true, 0, 0)
	Frame.ViewportFrame:SetAttribute("Active", isEquipped)

	Frame.ImageButton.Activated:Connect(function()
		if CosmeticCD then return end
		CosmeticCD = true
		task.delay(0.5, function() CosmeticCD = false end)

		selectedEmote = EmoteName

		for _, child in MainFrame.EmotesScrollingFrame:GetChildren() do
			local s = child:FindFirstChildOfClass("UIStroke")
			if s then
				if child.Name == EmoteName then
					s.Color = Color3.fromRGB(255, 215, 0)
					s.Thickness = 2
				else
					s.Color = Color3.fromRGB(255, 255, 255)
					s.Thickness = 1
				end
			end
		end

		shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()
	end)

	return Frame
end




-- Runtime

if AllCosmeticsInformation then
	for Category, Cosmetics in AllCosmeticsInformation do

		table.sort(Cosmetics, function(a, b)
			return a.Kills > b.Kills
		end)


		for Index, Accessory in Cosmetics do
			if Category == "Titles" then
				--nothing yet

			else
				local Frame = script.Frame:Clone()
				Frame.LayoutOrder = Index
				Frame.Name = Accessory.Name
				Frame.Info.Text = Accessory.Name

				local isOwned, isEquipped = false, false
				local applyModelColors = nil -- set for accessory 3D models; recolors black vs real

				if Accessory.Kills > 1000000 then
					Frame.Info.Info.Text = "VIP ONLY"

				elseif Accessory.Kills == 0 then
					Frame.Info.Info.Text = "FREE"
					Frame.Info.Info.TextColor3 = Color3.new(0, 1, 0)
				else
					Frame.Info.Info.Text = Accessory.Kills .. " Kills"
				end

				Frame.Parent = MainFrame[Category .. "ScrollingFrame"]

				Frame.ImageButton.Activated:Connect(function()
					-- 1. Check CoolDown first
					if CosmeticCD then return end

					-- 2. Determine if the player meets the Kill Requirement locally
					-- (This allows them to click even if they don't "own" it yet)
					local TotalKills = Player:WaitForChild("leaderstats"):WaitForChild("Total Kills").Value
					local Requirement = Accessory.Kills or 0
					local IsOwned = table.find(OwnedAccessories, Accessory.Name)

					if not IsOwned and TotalKills < Requirement then
						print("You need " .. Requirement .. " kills for this!")
						return 
					end

					CosmeticCD = true

					task.delay(0.5, function()
						CosmeticCD = false
					end)

					local EquipOrUnequip
					if Frame.ViewportFrame:GetAttribute("Active") then --Since the player currently has it on, so clicking it means they want to remove it.
						EquipOrUnequip = "Unequip"
					else
						EquipOrUnequip = "Equip"
					end

					Remotes.Cosmetics.Set:FireServer({ Type = Category, Name = Accessory.Name, State = EquipOrUnequip})

					--CosmSet:FireServer({ Type = Category, Name = Accessory.Name, State = not Frame.ImageLabel:GetAttribute("Active") })

					shared.sfx({
						SoundId = "rbxassetid://6895079853", 
						Parent = workspace, 
						Volume = 0.5
					}):Play()
				end)

				if Accessory.Name == "Custom Cape" then
					isOwned = true
					isEquipped = table.find(EquippedAccessories, Accessory.Name) ~= nil

					--Frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
					Frame.Info.Info.TextColor3 = Color3.new(1, 1, 0) --Gold
				elseif Category == "Auras" then
					Frame.ImageLabel.Image = "rbxassetid://" .. tostring(Accessory.Image)
					Frame.ImageLabel.Visible = true
					for _, ownedName in pairs(OwnedAuras) do
						if ownedName == Accessory.Name then
							isOwned = true
							--print(ownedName, " and ", Accessory.Name)
							break
						end
					end
					isEquipped = isOwned and (EquippedAuras == Accessory.Name)


					if isEquipped  then
						-- Player OWNS this or has enough kills
						Frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
					elseif isUnlocked(Accessory.Name, Accessory.Kills) then
						Frame.ImageLabel.ImageColor3 = Color3.new(.35, .35, .35)
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
					else
						-- Player does NOT own this and hasn't met the requirement
						Frame.ImageLabel.ImageColor3 = Color3.new(0, 0, .1) -- Very Dark
						Frame.Info.Info.TextColor3 = Color3.new(1, 0, 0) -- Red text
					end
				elseif Category == "Accessories" then
					local viewport = Frame.ViewportFrame
					local model = RS.Assets.AccessoriesSpinAnimations:FindFirstChild(Accessory.Name)

					if model and viewport then
						local clone = model:Clone()
						clone.Parent = viewport

						local originalColors = {}
						for _, part in clone:GetDescendants() do
							if part:IsA("BasePart") then
								originalColors[part] = {
									Color = part.Color,
									Material = part.Material
								}
							end
							if part:IsA("SpecialMesh") then
								originalColors[part] = {
									VertexColor = part.VertexColor,
									TextureId = part.TextureId
								}
							end
						end

						local function SetBlack()
							for _, part in clone:GetDescendants() do
								if part:IsA("BasePart") then
									part.Color = Color3.new(0, 0, 0)
									part.Material = Enum.Material.SmoothPlastic
								end
								if part:IsA("SpecialMesh") then
									part.VertexColor = Vector3.new(0, 0, 0)
									part.TextureId = ""
								end
							end
						end

						local function RestoreColors()
							for part, data in originalColors do
								if part:IsA("BasePart") then
									part.Color = data.Color
									part.Material = data.Material
								end
								if part:IsA("SpecialMesh") then
									part.VertexColor = data.VertexColor
									part.TextureId = data.TextureId
								end
							end
						end

						-- lets the live kill-refresh recolor this model without rebuilding the card
						applyModelColors = function(isUnlockedNow)
							if isUnlockedNow then RestoreColors() else SetBlack() end
						end

						local unlocked = isUnlocked(Accessory.Name, Accessory.Kills)
						if not unlocked then
							SetBlack()
						end

						-- Store these on the viewport so RefreshFullFrame can call them
						viewport:SetAttribute("HasModel", true)
						--viewport.SetBlack = SetBlack        -- won't work, use below instead
						clone:SetAttribute("IsBlack", not unlocked)

						-- Watch for equip state changes to swap colors
						viewport:GetAttributeChangedSignal("Active"):Connect(function()
							local active = viewport:GetAttribute("Active")
							if active then
								RestoreColors()
							elseif isUnlocked(Accessory.Name, Accessory.Kills) then
								RestoreColors()  -- owned OR requirement met = show real colors
							else
								SetBlack()
							end
						end)


						clone:PivotTo(CFrame.new(0, 0, 0))

						local camera = Instance.new("Camera")
						camera.Parent = viewport
						viewport.CurrentCamera = camera

						local cf, size = model:GetBoundingBox()
						local distance = size.Magnitude * 0.8  -- closer camera

						local camOffset = model:GetAttribute("CameraOffset")

						if camOffset then
							camera.CFrame = CFrame.new(camOffset, Vector3.new(0, 0, 0))
						else
							camera.CFrame = CFrame.new(
								Vector3.new(0, size.Y * 0.1, distance),
								Vector3.new(0, 0, 0)
							)
						end

						local startTime = tick()
						local connection
						connection = game:GetService("RunService").RenderStepped:Connect(function()
							local angle = (tick() - startTime) * 1.5
							clone:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, angle, 0))
						end)
						connection:Disconnect()  -- start disconnected since UI is hidden by default
						table.insert(SpinConnections, {connection = connection, startTime = startTime, clone = clone})
					end

					for _, ownedName in pairs(OwnedAccessories) do
						if ownedName == Accessory.Name then
							isOwned = true
							--print(ownedName, " and ", Accessory.Name)
							break
						end
					end
					isEquipped = isOwned and (table.find(EquippedAccessories, Accessory.Name) ~= nil)


					if isEquipped then
						-- Player OWNS this or has enough kills

						--Frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
						Frame.Info.TextColor3 = Color3.new(1, 1, 1)  -- Accessory name color
					elseif isUnlocked(Accessory.Name, Accessory.Kills) then
						--Frame.ImageLabel.ImageColor3 = Color3.new(.35, .35, .35)
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
						Frame.Info.TextColor3 = Color3.new(1, 1, 1)
					else
						-- Player does NOT own this and hasn't met the requirement
						--Frame.ImageLabel.ImageColor3 = Color3.new(0, 0, .1) -- Very Dark
						Frame.Info.Info.TextColor3 = Color3.new(1, 0, 0) -- Red text
						Frame.Info.TextColor3 = Color3.new(1, 0, 0)
					end
				end

				UpdateFrameVisuals(Frame, isEquipped, isUnlocked(Accessory.Name, Accessory.Kills), leaderKills.Value, Accessory.Kills)
				Frame.ViewportFrame:SetAttribute("Active", isEquipped)

				-- Re-applied whenever the player's kills change, so the progress bar
				-- fills and the item un-blacks the moment its requirement is met.
				local function refreshCard()
					if not Frame.Parent then return end
					local unlocked = isUnlocked(Accessory.Name, Accessory.Kills)
					local equippedNow = Frame.ViewportFrame:GetAttribute("Active") == true

					-- 3D model colour (accessories) — only touch it when not equipped
					if applyModelColors and not equippedNow then
						applyModelColors(unlocked)
					end

					-- aura image tint
					if Category == "Auras" then
						if equippedNow then
							Frame.ImageLabel.ImageColor3 = Color3.new(1, 1, 1)
						elseif unlocked then
							Frame.ImageLabel.ImageColor3 = Color3.new(.35, .35, .35)
						else
							Frame.ImageLabel.ImageColor3 = Color3.new(0, 0, .1)
						end
					end

					-- name / requirement text colour
					local tint = (equippedNow or unlocked) and Color3.new(1, 1, 1) or Color3.new(1, 0, 0)
					Frame.Info.Info.TextColor3 = tint
					Frame.Info.TextColor3 = tint

					-- stroke / dim overlay / progress bar
					UpdateFrameVisuals(Frame, equippedNow, unlocked, leaderKills.Value, Accessory.Kills)
				end

				-- Only kill-gated items need live refresh (FREE and VIP don't change with kills).
				if Accessory.Kills > 0 and Accessory.Kills <= 1000000 then
					table.insert(CardRefreshers, refreshCard)
				end
			end
		end
	end
end

-- Re-run every kill-gated card's refresh whenever Total Kills changes, so progress
-- bars fill live and items un-black the instant they unlock.
leaderKills:GetPropertyChangedSignal("Value"):Connect(function()
	for _, refresh in CardRefreshers do
		local ok, err = pcall(refresh)
		if not ok then warn("[Cosmetics] card refresh error:", err) end
	end
end)


local function GetEmoteAnim(emoteName)
	for _, descendant in EmotesFolder:GetDescendants() do
		if descendant:IsA("Animation") and descendant.Name == emoteName then
			return descendant
		end
	end
	return nil
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
	-- Gather all animations from the rarity subfolders
	for _, desc in EmotesFolder:GetDescendants() do
		if desc:IsA("Animation") then 
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

local function setupSpinner(spinFolder)
	local frame = spinFolder:FindFirstChild("Frame")
	local textLabel = frame and frame:FindFirstChild("TextLabel")
	local button = spinFolder:FindFirstChild("Button")

	if not (textLabel and button) then return end

	button.Activated:Connect(function()
		if isSpinning[spinFolder] then return end
		isSpinning[spinFolder] = true

		local success, realEmoteName, rarityName, goldAwarded, rolledEmoteName = RS.Remotes.Emotes.SpinEmote:InvokeServer()
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
			task.wait(i * 0.015)
		end

		
		-- Final reveal — branch on whether this was a grant or a dupe
		local revealRarityData = (InfoModule.EmoteRarities and InfoModule.EmoteRarities[rarityName])
			or { Color = Color3.new(1, 1, 1) }

		if realEmoteName then
			-- GRANTED
			textLabel.Text = realEmoteName
			textLabel.TextColor3 = revealRarityData.Color

			shared.sfx({ SoundId = "rbxassetid://4612384643", Parent = workspace, Volume = 0.8 }):Play()

			local realEmoteAnim = GetEmoteAnim(realEmoteName)
			if realEmoteAnim then
				EmoteIds[realEmoteName] = realEmoteAnim.AnimationId
			end
			if not table.find(OwnedEmotes, realEmoteName) then
				table.insert(OwnedEmotes, realEmoteName)
			end
			CreateEmoteFrame(realEmoteName, #OwnedEmotes)
			RefreshEmoteBulkVisibility()
		else
			-- DUPE — show what you would have gotten, and the gold you got instead
			textLabel.Text = (rolledEmoteName or "?") .. " +" .. tostring(goldAwarded or 0) .. " Gold"
			textLabel.TextColor3 = revealRarityData.Color

			shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.6 }):Play()
		end

		isSpinning[spinFolder] = false
	end)
end

-- Initialize the 3 Spinners
if MainFrame:FindFirstChild("SpinList") then
	setupSpinner(MainFrame.SpinList:FindFirstChild("1"))
	setupSpinner(MainFrame.SpinList:FindFirstChild("2"))
	setupSpinner(MainFrame.SpinList:FindFirstChild("3"))
end

for _, EmoteName in OwnedEmotes do
	local anim = GetEmoteAnim(EmoteName) 
	if anim then
		EmoteIds[EmoteName] = anim.AnimationId
	end
end

-- <<< rename this if your container is named differently >>>
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
	for _, child in MainFrame.EmotesScrollingFrame:GetChildren() do
		local s = child:FindFirstChildOfClass("UIStroke")
		if s then
			s.Color = Color3.fromRGB(255, 255, 255)
			s.Thickness = 1
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





















-- EMOTE LOOP (updated) --
for Index, EmoteName in OwnedEmotes do
	CreateEmoteFrame(EmoteName, Index)
end

AccessoryBtn.Activated:Connect(function()
	TriggerScrolls(AccessoriesSF.Name)
	EmotesTabActive = false
	RefreshSlotVisibility()
end)
AurasBtn.Activated:Connect(function()
	TriggerScrolls(AurasSF.Name)
	EmotesTabActive = false
	RefreshSlotVisibility()
end)
FinisherBtn.Activated:Connect(function()
	TriggerScrolls(FinisherSF.Name)
	EmotesTabActive = false
	RefreshSlotVisibility()
end)
EmotesBtn.Activated:Connect(function()
	TriggerScrolls(EmotesSF.Name)
	EmotesTabActive = true
	RefreshSlotVisibility()
end)
TitlesBtn.Activated:Connect(function()
	TriggerScrolls(TitlesSF.Name)
	EmotesTabActive = false
	RefreshSlotVisibility()

	TitlesSF.Visible = true
	MainFrame.BackgroundTransparency = 1
end)


--When the player opens the UI, it will do this.
for _,child in PlayerEquippedAccessoriesFolder:GetChildren() do
	TriggerViewport(AccessoriesSF[child.Name] and AccessoriesSF[child.Name].ViewportFrame, true)
end

for _,child in PlayerEquippedAurasFolder:GetChildren() do
	TriggerViewport(AurasSF[child.Name] and AurasSF[child.Name].ViewportFrame, true)
end


-- When the player gets a cosmetic added to their folder, or removed, it will do this.
PlayerEquippedAccessoriesFolder.ChildAdded:Connect(function(child)
	-- FIX 1 (ownership): re-fetch owned list so newly unlocked items show correctly
	OwnedAccessories    = CosmGet:InvokeServer({ Goal = "GetOwnedAccessories" })    or {}
	EquippedAccessories = CosmGet:InvokeServer({ Goal = "GetEquippedAccessories" }) or {}

	local accessoryData = nil
	if AllCosmeticsInformation then
		for _, cosmetics in AllCosmeticsInformation do
			for _, item in cosmetics do
				if item.Name == child.Name then accessoryData = item break end
			end
			if accessoryData then break end
		end
	end

	TriggerViewport(AccessoriesSF[child.Name] and AccessoriesSF[child.Name].ViewportFrame, true)
	if accessoryData then
		RefreshFullFrame(AccessoriesSF, "Accessories", accessoryData, true)
	end
end)

PlayerEquippedAccessoriesFolder.ChildRemoved:Connect(function(child)
	OwnedAccessories    = CosmGet:InvokeServer({ Goal = "GetOwnedAccessories" })    or {}
	EquippedAccessories = CosmGet:InvokeServer({ Goal = "GetEquippedAccessories" }) or {}

	local accessoryData = nil
	if AllCosmeticsInformation then
		for _, cosmetics in AllCosmeticsInformation do
			for _, item in cosmetics do
				if item.Name == child.Name then accessoryData = item break end
			end
			if accessoryData then break end
		end
	end

	TriggerViewport(AccessoriesSF[child.Name] and AccessoriesSF[child.Name].ViewportFrame, false)
	if accessoryData then
		RefreshFullFrame(AccessoriesSF, "Accessories", accessoryData, false)
	end
end)

PlayerEquippedAurasFolder.ChildAdded:Connect(function(child)
	OwnedAuras    = CosmGet:InvokeServer({ Goal = "GetOwnedAuras" })    or {}
	EquippedAuras = CosmGet:InvokeServer({ Goal = "GetEquippedAuras" }) or ""

	local accessoryData = nil
	if AllCosmeticsInformation and AllCosmeticsInformation.Auras then
		for _, item in AllCosmeticsInformation.Auras do
			if item.Name == child.Name then accessoryData = item break end
		end
	end

	TriggerViewport(AurasSF[child.Name] and AurasSF[child.Name].ViewportFrame, true)
	if accessoryData then
		RefreshFullFrame(AurasSF, "Auras", accessoryData, true)
	end
end)

PlayerEquippedAurasFolder.ChildRemoved:Connect(function(child)
	OwnedAuras    = CosmGet:InvokeServer({ Goal = "GetOwnedAuras" })    or {}
	EquippedAuras = CosmGet:InvokeServer({ Goal = "GetEquippedAuras" }) or ""

	local accessoryData = nil
	if AllCosmeticsInformation and AllCosmeticsInformation.Auras then
		for _, item in AllCosmeticsInformation.Auras do
			if item.Name == child.Name then accessoryData = item break end
		end
	end

	TriggerViewport(AurasSF[child.Name] and AurasSF[child.Name].ViewportFrame, false)
	if accessoryData then
		RefreshFullFrame(AurasSF, "Auras", accessoryData, false)
	end
end)

RS.Remotes.Emotes.Set.OnClientEvent:Connect(function(Action: string, Params: { any })
	if Action == 'UpdateOwnedEmotes' then
		local scrolling = MainFrame.EmotesScrollingFrame

		for _, EmoteName in Params.OwnedEmotes do
			if not EmoteIds[EmoteName] then
				local anim = GetEmoteAnim(EmoteName)
				if anim then EmoteIds[EmoteName] = anim.AnimationId end
			end

			if scrolling:FindFirstChild(EmoteName) then continue end

			if not table.find(OwnedEmotes, EmoteName) then
				table.insert(OwnedEmotes, EmoteName)
			end

			local newFrame = CreateEmoteFrame(EmoteName, #OwnedEmotes)

			local stroke = newFrame:FindFirstChildOfClass("UIStroke")
			if stroke then
				stroke.Color = Color3.fromRGB(0, 255, 0)
				stroke.Thickness = 2
				task.delay(3, function()
					if newFrame.Parent and selectedEmote ~= EmoteName then
						stroke.Color = Color3.fromRGB(255, 255, 255)
						stroke.Thickness = 1
					end
				end)
			end

			shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.6 }):Play()
		end
		
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


local function HideProducts()
	--local LeftCosmetics = Player:GetAttribute("LeftCosmetics")
	local RemainingCosmeticsNotOwned = CosmGet:InvokeServer({ Goal = "GetRemainingCosmetics"}) or "[]"

	local count = 0
	if RemainingCosmeticsNotOwned then
		for _, category in RemainingCosmeticsNotOwned do
			count += #category
		end
	end

	if count < 5 then
		MainFrame.AccessoriesBulk["5"].Visible = false
	end
	if count < 3 then
		MainFrame.AccessoriesBulk["3"].Visible = false
	end
	if count < 1 then
		MainFrame.AccessoriesBulk["1"].Visible = false
	end

end

Player:GetAttributeChangedSignal("LeftCosmetics"):Connect(HideProducts)
HideProducts()

local function updateSpins()
	local value = Player:GetAttribute("EmoteSpins") or 0
	script.Parent.Frame.Spins.Spins.Text = "Spins: " .. value
end

Player:GetAttributeChangedSignal("EmoteSpins"):Connect(updateSpins)
updateSpins()

--MainFrame.Bulk["1"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["1 Cosmetic"])
--end)

--MainFrame.Bulk["3"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["3 Cosmetics"])
--end)

--MainFrame.Bulk["5"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["5 Cosmetics"])
--end)

MainFrame.EmoteBulk.Emotesx1.Activated:Connect(function()
	Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote")
end)

MainFrame.EmoteBulk.Emotesx5.Activated:Connect(function()
	Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote x5")
end)

MainFrame.EmoteBulk.Emotesx10.Activated:Connect(function()
	Remotes.DevProducts.RequestDevProduct:FireServer("Random Emote x10")
end)

shared.cosgui = function()
	MainFrame.Visible = not MainFrame.Visible

	if MainFrame.Visible then
		-- Opening: reconnect all spin animations
		for _, data in SpinConnections do
			data.startTime = tick()
			data.connection = game:GetService("RunService").RenderStepped:Connect(function()
				local angle = (tick() - data.startTime) * 1.5
				data.clone:PivotTo(CFrame.new(0, 0, 0) * CFrame.Angles(0, angle, 0))
			end)
		end

		-- Cleanup other GUIs
		local GoalChildren = Player.PlayerGui:GetChildren()
		for _, ScreenGUI in pairs(GoalChildren) do
			if ScreenGUI.Name == "Cape Customization" or ScreenGUI.Name == "Awakening Outfit" or ScreenGUI.Name == "Kill Sound" then
				game:GetService("Debris"):AddItem(ScreenGUI, 0)
			end
			if ScreenGUI.Name == "Emotes" then
				local GoalImageLabel = ScreenGUI:FindFirstChild("ImageLabel")
				GoalImageLabel.Visible = true
				GoalImageLabel.Visible = false
			elseif ScreenGUI.Name == "Gifting" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				GoalFrame.Visible = true
				GoalFrame.Visible = false
			end
		end
	else
		-- Closing: disconnect all spin animations
		for _, data in SpinConnections do
			if data.connection then
				data.connection:Disconnect()
				data.connection = nil
			end
		end
	end
end

print("cosGui function created")
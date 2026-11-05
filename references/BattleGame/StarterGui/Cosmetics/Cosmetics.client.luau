-- Cosmetics LocalScript  (Accessories / Auras / Titles / Finisher + UI shell)
-- Emote logic lives in EmotesModule (a ModuleScript child of this script).
-- This script owns MainFrame, the tab bar, the single card template (script.Frame),
-- and shared.cosgui. It requires EmotesModule, hands it MainFrame + the template,
-- and drives the emote tab through the returned controller (setEmoteTab).

-- SERVICES --

local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")


-- PLAYER --

local Player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") == true

local Character = Player.Character or Player.CharacterAdded:Wait()

local PlayerCosmeticsFolder: Folder = Player:WaitForChild('Cosmetics')
local PlayerEquippedAccessoriesFolder: Folder = PlayerCosmeticsFolder:WaitForChild('Accessories')
local PlayerEquippedAurasFolder: Folder = PlayerCosmeticsFolder:WaitForChild('Auras')

local InfoModule = require(RS:WaitForChild("Info"))

-- REMOTES --

local Remotes = RS.Remotes
local CosmeticsRems = Remotes.Cosmetics

local CosmSet = CosmeticsRems.Set
local CosmGet = CosmeticsRems.Get


local SpinConnections = {}  -- accessory viewport rotators (reconnected on open)

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

-- Emotes tab still lives on this shell (the tab bar is one thing); the actual
-- emote behaviour is delegated to the Emotes script.
local EmotesSF = MainFrame.EmotesScrollingFrame
local EmotesBtn = MainFrame.Emotes


-- VARIABLES --

-- Per-card refresh functions, called whenever the player's kills change so the
-- progress bar fills and the item un-blacks the moment its requirement is met.
local CardRefreshers = {}

local CosmeticCD = false

local AllCosmeticsInformation = {}
local OwnedAccessories = {}
local OwnedAuras = {}

local EquippedAccessories = {}
local EquippedAuras = ""


local Success, Result = pcall(function()
	return CosmGet:InvokeServer({ Goal = "GetAllCosmetics" })
end)

if Success then
	AllCosmeticsInformation = Result

	OwnedAccessories = CosmGet:InvokeServer({ Goal = "GetOwnedAccessories" }) or {}
	OwnedAuras = CosmGet:InvokeServer({ Goal = "GetOwnedAuras" }) or {}

	EquippedAccessories = CosmGet:InvokeServer({ Goal = "GetEquippedAccessories" }) or ""
	EquippedAuras = CosmGet:InvokeServer({ Goal = "GetEquippedAuras" }) or ""
end

local leaderKills = Player:WaitForChild("leaderstats"):WaitForChild("Total Kills")


-- Emote logic lives in the EmotesModule ModuleScript (a child of this script).
-- We hand it MainFrame and the single card template, so there is exactly one
-- Frame template in the whole hierarchy. require() blocks until init() returns,
-- so EmoteController is ready before any tab button can fire -- no nil guard,
-- no shared globals.
local EmoteController = require(script.EmotesModule).init({
	MainFrame = MainFrame,
	Template  = script.EmoteFrame,
})

local function setEmoteTab(active: boolean)
	EmoteController.setTabActive(active)
end


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

			-- hue goes from 0 (red) to 120 (green) as pct goes 0 -> 1
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


-- Runtime -- builds Accessories / Auras / Titles / Finisher cards

if AllCosmeticsInformation then
	for Category, Cosmetics in AllCosmeticsInformation do

		table.sort(Cosmetics, function(a, b)
			return a.Kills > b.Kills
		end)


		for Index, Accessory in Cosmetics do
			if Category == "Titles" then
				--nothing yet
				continue
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

					shared.sfx({
						SoundId = "rbxassetid://6895079853",
						Parent = workspace,
						Volume = 0.5
					}):Play()
				end)

				if Accessory.Name == "Custom Cape" then
					isOwned = true
					isEquipped = table.find(EquippedAccessories, Accessory.Name) ~= nil

					Frame.Info.Info.TextColor3 = Color3.new(1, 1, 0) --Gold
				elseif Category == "Auras" then
					Frame.ImageLabel.Image = "rbxassetid://" .. tostring(Accessory.Image)
					Frame.ImageLabel.Visible = true
					for _, ownedName in pairs(OwnedAuras) do
						if ownedName == Accessory.Name then
							isOwned = true
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
					local model = RS.Assets.Accessories:FindFirstChild(Accessory.Name)

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

						viewport:SetAttribute("HasModel", true)
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
							break
						end
					end
					isEquipped = isOwned and (table.find(EquippedAccessories, Accessory.Name) ~= nil)


					if isEquipped then
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
						Frame.Info.TextColor3 = Color3.new(1, 1, 1)  -- Accessory name color
					elseif isUnlocked(Accessory.Name, Accessory.Kills) then
						Frame.Info.Info.TextColor3 = Color3.new(1, 1, 1) -- White text
						Frame.Info.TextColor3 = Color3.new(1, 1, 1)
					else
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

					-- 3D model colour (accessories) -- only touch it when not equipped
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


-- TAB BUTTONS --
AccessoryBtn.Activated:Connect(function()
	TriggerScrolls(AccessoriesSF.Name)
	setEmoteTab(false)
end)
-- Not created yet.
--AurasBtn.Activated:Connect(function()
--	TriggerScrolls(AurasSF.Name)
--	setEmoteTab(false)
--end)
--FinisherBtn.Activated:Connect(function()
--	TriggerScrolls(FinisherSF.Name)
--	setEmoteTab(false)
--end)
EmotesBtn.Activated:Connect(function()
	TriggerScrolls(EmotesSF.Name)
	setEmoteTab(true)
end)
TitlesBtn.Activated:Connect(function()
	TriggerScrolls(TitlesSF.Name)
	setEmoteTab(false)

	TitlesSF.Visible = true
	MainFrame.BackgroundTransparency = 1
end)


-- When the player opens the UI, it will do this.
for _,child in PlayerEquippedAccessoriesFolder:GetChildren() do
	TriggerViewport(AccessoriesSF[child.Name] and AccessoriesSF[child.Name].ViewportFrame, true)
end

for _,child in PlayerEquippedAurasFolder:GetChildren() do
	TriggerViewport(AurasSF[child.Name] and AurasSF[child.Name].ViewportFrame, true)
end


-- When the player gets a cosmetic added to their folder, or removed, it will do this.
PlayerEquippedAccessoriesFolder.ChildAdded:Connect(function(child)
	-- re-fetch owned list so newly unlocked items show correctly
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


local function HideProducts()
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
--MainFrame.Bulk["1"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["1 Cosmetic"])
--end)

--MainFrame.Bulk["3"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["3 Cosmetics"])
--end)

--MainFrame.Bulk["5"].Activated:Connect(function()
--	MarketplaceService:PromptProductPurchase(Player, InfoModule.Products["5 Cosmetics"])
--end)


shared.cosgui = function()
	MainFrame.Visible = not MainFrame.Visible

	if MainFrame.Visible then
		-- Opening: reconnect all accessory viewport spin animations
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
				if shared.closeEmoteWheel then
					shared.closeEmoteWheel()
				end				
			elseif ScreenGUI.Name == "Gifting" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				GoalFrame.Visible = true
				GoalFrame.Visible = false
			end
		end
	else
		-- Closing: disconnect all accessory viewport spin animations
		for _, data in SpinConnections do
			if data.connection then
				data.connection:Disconnect()
				data.connection = nil
			end
		end
	end
end

--print("cosGui function created")

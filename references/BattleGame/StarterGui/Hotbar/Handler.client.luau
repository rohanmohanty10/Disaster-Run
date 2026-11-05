--// Services \\--

local UIS = game:GetService('UserInputService')
local RS = game:GetService('ReplicatedStorage')
local TS = game:GetService('TweenService')
local Players = game:GetService('Players')
local StarterGUI = game:GetService('StarterGui')

StarterGUI:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)



--// Player \\--

local Player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") == true --and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
local Character = Player.Character or Player.CharacterAdded:Wait()
--local Backpack = Player:WaitForChild('Moveset')



--// Remotes \\--

local Remotes = RS:WaitForChild("Remotes")

--local MovesetHandler = Remotes.MovesetHandler


--local AbilitiesHandlerFolder = Remotes.AbilitiesHandler

--local AbilitieRemote_Set = AbilitiesHandlerFolder.Set
--local AbilitieRemote_Get = AbilitiesHandlerFolder.Get



--// Modules \\--

--local TekrinnDialogue = require(RS.Resources.KJ.UFW.TekrinnDialogue)
--local InfoModule = require(RS.Info)



--// GUI \\--

local GUI = script.Parent
local HotbarFrame = GUI.Hotbar
local CooldownFrame = script.Cooldown
local CurrentTween: Tween
local hotbarState = true



--// Keys \\--

local Keys = {
	['One']   = '1',
	['Two']   = '2',
	['Three'] = '3',
	['Four']  = '4',
	['Five']  = '5',
	['Six']   = '6',
	['Seven'] = '7',
	['Eight'] = '8',

	['C']  = '9',
	['Z']  = '0',

	['ButtonL1'] = '1',
	['ButtonL2'] = '2',
	['ButtonR2'] = '3',
	['ButtonR1'] = '4',

	["DLeft+ButtonL1"] = "0",
	["DLeft+ButtonR1"] = "9"
}

local AbilitySlots = {"AbilityOneCooldown", "AbilityTwoCooldown", "AbilityThreeCooldown", "AbilityFourCooldown"}
local ModeAbilitySlots = {"ModeAbilityOneCooldown", "ModeAbilityTwoCooldown", "ModeAbilityThreeCooldown", "ModeAbilityFourCooldown"}

--// Variables \\--

local MoveSelected = nil
local Speaked = false



--// Functions \\--

local function getDamageNeed()
	return Player:GetAttribute("DamageNeed") or 0
end

local function updateAwakeningBar(value)
	local clampedVal = math.clamp(value, 0, 1)
	GUI.Hotbar["4"].Base.Bar.Fill:TweenSize( UDim2.fromScale(clampedVal, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true )

	if clampedVal >= 1 then

	else

	end
end

local function whiteGradientTween(Parent)
	local moveUsed = script.Cooldown:Clone()
	moveUsed.BackgroundColor3 = Color3.new(1,1,1)
	moveUsed.Size = UDim2.fromScale(1,-1)
	moveUsed.Parent = Parent
	TS:Create(moveUsed, TweenInfo.new(.5, Enum.EasingStyle.Linear), { BackgroundTransparency = 1 }):Play()
	game.Debris:AddItem(moveUsed, .5)
end

local function Equip(HotbarSlot: TextButton, slot, isReleased: boolean)
	local slotNumber = tonumber(slot) or tonumber(Keys[slot])
	if typeof(slotNumber) == "number" and slotNumber >= 1 and slotNumber <= 4 then

		if not isReleased then
			-- Get the name of the cooldown attribute (e.g., "AbilityOneCooldown")
			local cooldownName = AbilitySlots[slotNumber]
			local isOnCooldown = Player:GetAttribute(cooldownName)
			local isMode = Character:GetAttribute("Awakened")
			if isMode then
				cooldownName = ModeAbilitySlots[slotNumber]
				isOnCooldown = Player:GetAttribute(cooldownName)
			end

			if not isOnCooldown then
				whiteGradientTween(HotbarSlot)
			end
		end

		if Character:GetAttribute("Awakened") then
			print("Mode Active: Firing ModeSkillRequest")
			Remotes.ModeSkillRequest:FireServer(slotNumber, HotbarSlot.ToolName.Text, isReleased)
		else
			Remotes.SkillRequest:FireServer(slotNumber, HotbarSlot.ToolName.Text, isReleased)
		end
	else
		warn("Invalid Slot Attempted: " .. tostring(slot))
	end

	--if Tool then
	--	Character:RemoveTag('Move Selected')

	--	if Tool:GetAttribute("CDS") ~= 0 then
	--		local function addCooldown()
	--			local PreviousCooldown = HotbarSlot:FindFirstChild("Cooldown")
	--			if PreviousCooldown then PreviousCooldown:Destroy() end

	--			local Cooldown: Frame = CooldownFrame:Clone()

	--			if Tool:GetAttribute("CDS") ~= 0 then
	--				Cooldown.Parent = HotbarSlot
	--			end

	--			if Tool:GetAttribute("CDS") > -1 and Tool:GetAttribute("CDS") ~= 0 then
	--				game.Debris:AddItem(Cooldown, Tool:GetAttribute('CDS'))

	--				local Tween = TS:Create(Cooldown,TweenInfo.new(Tool:GetAttribute('CDS'), Enum.EasingStyle.Linear), { Size = UDim2.fromScale(1, 0) })
	--				Tween.Completed:Once(function()
	--					if Tool.Name == HotbarSlot.ToolName.Text then
	--						whiteGradientTween(HotbarSlot)
	--					end
	--				end)

	--				Tween:Play()
	--			elseif Tool:GetAttribute("CDS") == 0 then
	--				whiteGradientTween(HotbarSlot)
	--			end
	--		end

	--		if Tool:GetAttribute('onCDS') ~= true then
	--			local changedSignal
	--			changedSignal = Tool:GetAttributeChangedSignal("onCDS"):Connect(function()
	--				if Tool:GetAttribute("onCDS") == true or Tool:GetAttribute("CDS") == 0 then
	--					changedSignal:Disconnect()

	--					if Tool:GetAttribute("CDS") ~= 0 then
	--						addCooldown()
	--					end
	--				end
	--			end)
	--		else
	--			addCooldown()
	--		end

	--	else
	--		whiteGradientTween(HotbarSlot)
	--	end
	--end
end

local function AddTool(Tool: Tool)
	if not Tool:IsA("Tool") or not Tool:GetAttribute("Index") then return end

	local HotbarSlot: Frame = HotbarFrame[tostring(Tool:GetAttribute("Index"))]
	if HotbarSlot then
		local Base: TextButton = HotbarSlot.Base

		local PreviousState = HotbarSlot:GetAttribute("Active")
		HotbarSlot:SetAttribute("Active", true)

		if PreviousState ~= true and Base.ToolName.Text ~= Tool.Name then
			Base:TweenPosition(UDim2.fromOffset(0, 125), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

			task.wait(0.5)
		end


		local Cooldown = Base:FindFirstChild('Cooldown')
		if Cooldown then
			Cooldown:Destroy()

			whiteGradientTween(Base)
		end


		local Description = Tool:GetAttribute('Description')

		Base.ToolName.Text = Tool.Name
		if Description ~= 'nil' then
			Base.Description.Text = Description
			Base.Description.Description.Text = Description

			Base.Description.Visible = true
			Base.Description.Description.Visible = true
		else
			Base.Description.Visible = false
			Base.Description.Description.Visible = false
		end


		HotbarSlot.Visible = true


		Base:TweenPosition(UDim2.fromOffset(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)


		for _, slotFrame in HotbarFrame:GetChildren() do
			if slotFrame:IsA("Frame") and slotFrame:FindFirstChild("Base") then
				local base = slotFrame.Base

				if base.ToolName.Text ~= "Unlimited Flex Works" then
					base.Bar.Visible = false
					if base:FindFirstChild("Flipbook") then
						base.Flipbook:Destroy()
					end
				else
					local DamageNeed = math.clamp(Player:GetAttribute("DamageNeed") or 0, 0, 1)
					base.Bar.Visible = true

					if DamageNeed >= 1 and Player:GetAttribute("Moveset") == "KJ" then
						base.Bar.Visible = false

						if not base:FindFirstChild("Flipbook") then
							local Flipbook = script.Flipbook:Clone()
							Flipbook.LocalScript.Enabled = true
							Flipbook.Parent = base
							Flipbook.Visible = true

							TS:Create(Flipbook, TweenInfo.new(0.25), {
								ImageTransparency = 0
							}):Play()
						end
					else
						if base:FindFirstChild("Flipbook") then
							base.Flipbook:Destroy()
						end
					end
				end
			end
		end
	end
end

--// Connections \\--

Player:GetAttributeChangedSignal("DamageNeed"):Connect(function()
	updateAwakeningBar(getDamageNeed())

	local DamageNeedAttribute = Player:GetAttribute("DamageNeed")
	if not DamageNeedAttribute then
		Speaked = false
		return
	else
		if DamageNeedAttribute >= 1 and Player:GetAttribute("Moveset") == "KJ" then
			if not Speaked then
				local function Speak(Text, TypeSpeed, Bold)
					--TekrinnDialogue(Character, {
					--	{
					--		Text = Text, 
					--		Color = ColorSequence.new({
					--			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), 
					--			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 17, 17)), 
					--			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
					--		}), 
					--		TextStrokeColor = Color3.new(0, 0, 0), 
					--		Bold = Bold, 
					--		Italic = false, 
					--		Shake = {
					--			Intensity = 1, 
					--			Lifetime = 2
					--		}, 
					--		TypeSpeed = TypeSpeed, 
					--		HigherUp = true
					--	}
					--})
				end

				shared.sfx({
					SoundId = "rbxassetid://129076824684716", 
					Parent = workspace, 
					Volume = 2.5
				}):Play()

				task.delay(0.1, function()
					Speak("I'm done playing around", 0.082)
					wait(2.564)

					if Character:FindFirstChild("usingufw") then
						return
					else
						Speak("This should end it all..", 0.0965, true)
						return
					end
				end)
				return
			end

		else
			Speaked = false
		end
		return
	end
end)
updateAwakeningBar(getDamageNeed())

local currentlyHolding = {}

UIS.InputBegan:Connect(function(input, gameProccessedEvent)
	if gameProccessedEvent then return end
	if shared.emoteWheelOpen then return end
	
	
	local keyName = input.KeyCode.Name

	if Keys[keyName] and not Character:HasTag('ThrowableGrabbed') then
		local slotIndex = Keys[keyName]
		local HotbarSlot = HotbarFrame[slotIndex]

		if HotbarSlot then
			currentlyHolding[keyName] = HotbarSlot.Base
			Equip(HotbarSlot.Base, keyName, false) -- Trigger Press/Charge
		end
	end
end)


UIS.InputEnded:Connect(function(input, gpe)
	local keyName = input.KeyCode.Name
	if currentlyHolding[keyName] then
		local slotBase = currentlyHolding[keyName]
		currentlyHolding[keyName] = nil -- Clear the hold state

		-- Only fire release if the move is intended to be holdable
		-- You could check an attribute on the Tool or just fire it and let the server decide
		Equip(slotBase, keyName, true) -- true = Release
	end
end)


--for i, HotbarSlot: Frame in HotbarFrame:GetChildren() do
--	if HotbarSlot:IsA('Frame') and HotbarSlot:FindFirstChild('Base') then
--		HotbarSlot = HotbarSlot.Base
--		HotbarSlot.Activated:Connect(function()
--			if Player.Configuration['Auto Use'].Value == true then
--				Equip(HotbarSlot, HotbarSlot.Parent.Name)
--			else
--				if HotbarSlot.SelectionObjectClipper.Visible == true then
--					MoveSelected.SelectionObjectClipper.Visible = false
--					MoveSelected = nil

--					Character:RemoveTag('Move Selected')
--				else
--					for _, Slot in HotbarFrame:GetChildren() do
--						if Slot:IsA('Frame') and Slot:FindFirstChild('Base') then
--							Slot = Slot.Base

--							if Slot ~= HotbarSlot and Slot.SelectionObjectClipper.Visible == true then
--								Slot.SelectionObjectClipper.Visible = false

--								Character:RemoveTag('Move Selected')
--							end
--						end
--					end

--					HotbarSlot.SelectionObjectClipper.Visible = true
--					MoveSelected = HotbarSlot

--					Character:AddTag('Move Selected')
--				end
--			end
--		end)
--	end
--end

--New Hold and Release 7/7/26

for i, HotbarSlot: Frame in HotbarFrame:GetChildren() do
	if HotbarSlot:IsA('Frame') and HotbarSlot:FindFirstChild('Base') then
		HotbarSlot = HotbarSlot.Base

		local releaseConnection: RBXScriptConnection
		HotbarSlot.InputBegan:Connect(function(Input)
			if Input.UserInputState ~= Enum.UserInputState.Begin then return end
			if Input.UserInputType ~= Enum.UserInputType.Touch and Input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end

			if Player.Configuration['Auto Use'].Value == true then
				Equip(HotbarSlot, HotbarSlot.Parent.Name, false)

				if releaseConnection then
					releaseConnection:Disconnect()
				end

				releaseConnection = Input:GetPropertyChangedSignal("UserInputState"):Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						releaseConnection:Disconnect()
						releaseConnection = nil

						Equip(HotbarSlot, HotbarSlot.Parent.Name, true)
					end
				end)
			end
		end)

		HotbarSlot.Activated:Connect(function()
			if Player.Configuration['Auto Use'].Value == true then return end

			if HotbarSlot.SelectionObjectClipper.Visible == true then
				MoveSelected.SelectionObjectClipper.Visible = false
				MoveSelected = nil

				Character:RemoveTag('Move Selected')
			else
				for _, Slot in HotbarFrame:GetChildren() do
					if Slot:IsA('Frame') and Slot:FindFirstChild('Base') then
						Slot = Slot.Base

						if Slot ~= HotbarSlot and Slot.SelectionObjectClipper.Visible == true then
							Slot.SelectionObjectClipper.Visible = false

							Character:RemoveTag('Move Selected')
						end
					end
				end

				HotbarSlot.SelectionObjectClipper.Visible = true
				MoveSelected = HotbarSlot

				Character:AddTag('Move Selected')
			end
		end)
	end
end


--MovesetHandler.OnClientEvent:Connect(function(Goal)
--	if Goal == "removeCooldowns" then
--		for _, Frame in HotbarFrame:GetChildren() do
--			if Frame:IsA("Frame") then
--				local Base = Frame:FindFirstChild('Base')

--				local Cooldown = Base:FindFirstChild('Cooldown')
--				if Cooldown then
--					Cooldown:Destroy()

--					whiteGradientTween(Base)
--				end
--			end
--		end
--	end
--end)

shared.triggerHotbar = function(State)
	hotbarState = State

	if State == true then
		HotbarFrame:TweenPosition(UDim2.new(0.5, -327, 1, -70), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
	else
		HotbarFrame:TweenPosition(UDim2.new(0.5, -327, 1, 55), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
	end
end

Player:WaitForChild("Moveset").ChildAdded:Connect(AddTool)

Player:WaitForChild("Moveset").ChildRemoved:Connect(function(Tool: Tool)
	if Tool:IsA("Tool") and Tool:GetAttribute("Index") then
		local wasReplaced = false

		for _,v in Player.Moveset:GetChildren() do
			if v:GetAttribute("Index") == Tool:GetAttribute("Index") and v.Name ~= Tool.Name then
				wasReplaced = true
			end
		end

		local HotbarSlot: Frame = HotbarFrame[tostring(Tool:GetAttribute("Index"))]
		if HotbarSlot then
			local Base: TextButton = HotbarSlot.Base

			Base:TweenPosition(UDim2.fromOffset(0, 125), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)

			if wasReplaced == true then
				task.delay(0.5, function()
					Base:TweenPosition(UDim2.fromOffset(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
				end)

				return
			end


			HotbarSlot:SetAttribute("Active", false)

			task.delay(0.5, function()
				if HotbarSlot:GetAttribute("Active") == false then
					HotbarSlot.Visible = false
					Base.ToolName.Text = "N/A"
				end
			end)
		end
	end
end)

for i, attributeName in ipairs(AbilitySlots) do
	Player:GetAttributeChangedSignal(attributeName):Connect(function()
		local endTime = Player:GetAttribute(attributeName)
		local SlotContainer = HotbarFrame:FindFirstChild(tostring(i))
		if not SlotContainer then return end
		local HotbarSlot = SlotContainer:FindFirstChild("Base") 
		if not HotbarSlot then return end

		local function addCooldown(duration)
			local PreviousCooldown = HotbarSlot:FindFirstChild("Cooldown")
			if PreviousCooldown then PreviousCooldown:Destroy() end

			local Cooldown = script.Cooldown:Clone()
			Cooldown.Name = "Cooldown"
			-- Ensure visibility
			Cooldown.ZIndex = HotbarSlot.ZIndex + 5
			Cooldown.Visible = true
			Cooldown.Parent = HotbarSlot

			-- Position at bottom to shrink downwards
			Cooldown.AnchorPoint = Vector2.new(0, 1)
			Cooldown.Position = UDim2.fromScale(0, 1)
			Cooldown.Size = UDim2.fromScale(1, 1)

			if duration > 0 then
				game.Debris:AddItem(Cooldown, duration + 0.1)

				local Tween = TS:Create(Cooldown, TweenInfo.new(duration, Enum.EasingStyle.Linear), { 
					Size = UDim2.fromScale(1, 0) 
				})

				Tween.Completed:Once(function(playbackState)
					if playbackState == Enum.PlaybackState.Completed then
						whiteGradientTween(HotbarSlot)
					end
				end)

				Tween:Play()
				--print("Inside duration")
			else
				whiteGradientTween(HotbarSlot)
			end
		end

		if typeof(endTime) == "number" then
			-- USE THE SAME SYNC AS SERVER (workspace:GetServerTimeNow() is recommended)
			--print("Is Number")
			local currentTime = workspace:GetServerTimeNow() 
			local duration = endTime -- currentTime

			if duration > 0 then
				--print("has duration")
				addCooldown(duration)
			end
		elseif endTime == false or endTime == 0 then
			whiteGradientTween(HotbarSlot)
			local Previous = HotbarSlot:FindFirstChild("Cooldown")
			if Previous then Previous:Destroy() end
		end
	end)
end

for i, attributeName in ipairs(ModeAbilitySlots) do
	Player:GetAttributeChangedSignal(attributeName):Connect(function()
		local endTime = Player:GetAttribute(attributeName)
		local SlotContainer = HotbarFrame:FindFirstChild(tostring(i))
		if not SlotContainer then return end
		local HotbarSlot = SlotContainer:FindFirstChild("Base") 
		if not HotbarSlot then return end

		local function addCooldown(duration)
			local PreviousCooldown = HotbarSlot:FindFirstChild("Cooldown")
			if PreviousCooldown then PreviousCooldown:Destroy() end

			local Cooldown = script.Cooldown:Clone()
			Cooldown.Name = "Cooldown"
			-- Ensure visibility
			Cooldown.ZIndex = HotbarSlot.ZIndex + 5
			Cooldown.Visible = true
			Cooldown.Parent = HotbarSlot

			-- Position at bottom to shrink downwards
			Cooldown.AnchorPoint = Vector2.new(0, 1)
			Cooldown.Position = UDim2.fromScale(0, 1)
			Cooldown.Size = UDim2.fromScale(1, 1)

			if duration > 0 then
				game.Debris:AddItem(Cooldown, duration + 0.1)

				local Tween = TS:Create(Cooldown, TweenInfo.new(duration, Enum.EasingStyle.Linear), { 
					Size = UDim2.fromScale(1, 0) 
				})

				Tween.Completed:Once(function(playbackState)
					if playbackState == Enum.PlaybackState.Completed then
						whiteGradientTween(HotbarSlot)
					end
				end)

				Tween:Play()
				--print("Inside duration")
			else
				whiteGradientTween(HotbarSlot)
			end
		end

		if typeof(endTime) == "number" then
			-- USE THE SAME SYNC AS SERVER (workspace:GetServerTimeNow() is recommended)
			--print("Is Number")
			local currentTime = workspace:GetServerTimeNow() 
			local duration = endTime -- currentTime

			if duration > 0 then
				--print("has duration")
				addCooldown(duration)
			end
		elseif endTime == false or endTime == 0 then
			whiteGradientTween(HotbarSlot)
			local Previous = HotbarSlot:FindFirstChild("Cooldown")
			if Previous then Previous:Destroy() end
		end
	end)
end

-- At run time. So only when player spawns in.
for _, Tool: Tool in Player.Moveset:GetChildren() do
	task.spawn(function()
		AddTool(Tool)
	end)
end
-- Emote Handler

-- SERVICES --

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local PlayerService = game:GetService('Players')

-- PLAYER --

local Player = PlayerService.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") == true --and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
local Character = Player.Character or Player.CharacterAdded:Wait()

-- REMOTES --

local Remotes = ReplicatedStorage.Remotes
local Comunicator: RemoteEvent = Remotes.Comunicator.Set
local Getter = Remotes.Comunicator.Get
local EmotesSet = Remotes.Emotes.Set


-- MODULES --

local ReplicatedModules = ReplicatedStorage:WaitForChild("Modules")
local InfoModule = require(ReplicatedStorage:WaitForChild("Info"))


print("Emotes Handler started")

-- EMOTES --

local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes
local EmoteIds = {}
-- PASSES --


--local MoreEmoteSlotsPass = InfoModule.Passes["VIP"]
--local SecondEmotePagePass = InfoModule.Passes["VIP"]



-- GUI --

local GUI = script.Parent
local EmoteWheel = GUI.ImageLabel
local ScrollFrame = script.ScrollingFrame
local CurrentPage = 1
local PagesSlots = {
	[1] = {
		[1] = EmoteWheel.Emotes['1'];
		[2] = EmoteWheel.Emotes['2'];
		[3] = EmoteWheel.Emotes['3'];
		[4] = EmoteWheel.Emotes['4'];
		[5] = EmoteWheel.Emotes['5'];
		[6] = EmoteWheel.Emotes['6'];
		[7] = EmoteWheel.Emotes['7'];
		[8] = EmoteWheel.Emotes['8'];
	}; 

	[2] = {
		[1] = EmoteWheel.Emotes2['1'];
		[2] = EmoteWheel.Emotes2['2'];
		[3] = EmoteWheel.Emotes2['3'];
		[4] = EmoteWheel.Emotes2['4'];
		[5] = EmoteWheel.Emotes2['5'];
		[6] = EmoteWheel.Emotes2['6'];
		[7] = EmoteWheel.Emotes2['7'];
		[8] = EmoteWheel.Emotes2['8'];
	}
}



-- FUNCTIONS --
local function PlayAnim(Animator: Animator, Animation)
	for _,track in Animator:GetPlayingAnimationTracks() do
		track:Stop()
	end

	local Track = Animator:LoadAnimation(Animation)

	Track.Looped = true
	Track:Play()
end

local function GetEmoteAnim(emoteName)
	-- First check if it's directly in the Emotes folder (like Billy Bounce)
	local directEmote = EmotesFolder:FindFirstChild(emoteName)
	if directEmote and directEmote:IsA("Animation") then return directEmote end

	-- Then check the rarity subfolders
	for _, folder in EmotesFolder:GetChildren() do
		if folder:IsA("Folder") then
			local emote = folder:FindFirstChild(emoteName)
			if emote and emote:IsA("Animation") then
				return emote
			end
		end
	end
	return nil
end

local function CloseScrolls()
	for _, Slot in PagesSlots[CurrentPage] do
		local SF = Slot:FindFirstChild('ScrollingFrame')

		if SF then
			SF:Destroy()
		end
	end
end

local function TriggerVisibleSlots(value: boolean, excludeSlot: string)
	if not PagesSlots[CurrentPage] then return end

	local maxSlots
	if Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") == true then
		maxSlots = 8
	else
		maxSlots = 4
	end

	for i = 1, maxSlots do
		local Slot = PagesSlots[CurrentPage][i]:FindFirstChild(tostring(i))
		if Slot and Slot.Name ~= excludeSlot then
			Slot.Visible = value
		end
	end
end

local function SetupPlayBtn(Button: TextButton)
	Button.Activated:Connect(function()
		CloseScrolls()
		EmoteWheel.Visible = false

		if Button.Parent.Parent.Name == 'Emotes2' then
			if Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") == false then
				return
			end
		end

		local AnimationName = Button.Parent.EmoteName.Text
		local Animation: Animation = GetEmoteAnim(AnimationName)
		if not Animation then return end -- empty/unresolved slot; original code would error here

		local Cooldown = Animation:GetAttribute("Cooldown")
		if (Cooldown and not Animation:HasTag("OnCDS")) or not Cooldown then
			Remotes.Emotes.Set:FireServer('PlayEmote', AnimationName)
			if Cooldown then
				Animation:AddTag("OnCDS")
				task.delay(Cooldown, function()
					Animation:RemoveTag("OnCDS")
				end)
			end
		else
			shared.sfx({ SoundId = "rbxassetid://5797580410", Parent = workspace, Volume = 0.75 }):Play()
		end
	end)
end

-- RUNTIME --

local owdEms = Remotes.Emotes.GetOwnedEmotes:InvokeServer() --Code which gets all of the player's owned emotes. Go to DataManager to find this remoteFunction and code relating to it. 
if owdEms then
	for _, EmoteName in owdEms do
		local EmoteAnim = GetEmoteAnim(EmoteName)
		if not EmoteAnim then continue end

		EmoteIds[EmoteAnim.Name] = EmoteAnim.AnimationId
	end
end

for EmoteName, _ in EmoteIds do
	local TemplateClone = script.Template:Clone()
	TemplateClone.Name = EmoteName
	TemplateClone.Text = EmoteName
	TemplateClone.Parent = ScrollFrame.ScrollingFrame

	local EmoteAnim = GetEmoteAnim(EmoteName)

	if EmoteAnim:GetAttribute("Description") == "KillEmote" then
		if not TemplateClone:FindFirstChild("EmoteGlow") then
			local EmoteGlow = script.EmoteGlow:Clone()
			EmoteGlow.ImageColor3 = Color3.fromRGB(171, 66, 66)
			EmoteGlow.Parent = TemplateClone
		end
	end

	TemplateClone.MouseButton1Click:Connect(function()
		local Character = Player.Character

		if Character then
			shared.sfx({
				SoundId = "rbxassetid://6493287948", 
				Parent = workspace, 
				Volume = 0.65
			}):Play()
		end
	end)
end

EmoteWheel:GetPropertyChangedSignal('Visible'):Connect(function()
	if EmoteWheel.Visible == true then
		CloseScrolls()
		TriggerVisibleSlots(true)

		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end)


if Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") then
	if Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage") then
		EmoteWheel.Switch.Visible = true
	else
		EmoteWheel.GamepassTwo.Visible = true
	end

	for i,v in EmoteWheel.Emotes:GetChildren() do
		v.Visible = true
	end
else
	EmoteWheel.Gamepass.Visible = true
end


local Emotes, Emotes2 = Remotes.Emotes.GetEquippedEmotes:InvokeServer()
local function InitSlotDisplay(Slot: Frame, EmoteName: string)
	--if not EmoteIds[EmoteName] then EmoteName = 'Resolute' end

	--local EmoteAnim = GetEmoteAnim(EmoteName)
	--if not EmoteIds[EmoteName] or not EmoteAnim then return end

	--local Desc = EmoteAnim:GetAttribute('Description')
	--if Desc then
	--	Slot.EmoteProperty.Text = Desc
	--	Slot.EmoteProperty.Visible = true
	--else
	--	Slot.EmoteProperty.Visible = false
	--end

	--Slot.EmoteName.Text = EmoteName
	--Slot.ViewportFrame.WorldModel.Preview.Animation.AnimationId = EmoteIds[EmoteName]
	--PlayAnim(Slot.ViewportFrame.WorldModel.Preview.Humanoid.Animator, Slot.ViewportFrame.WorldModel.Preview.Animation)
	
	local EmoteAnim = EmoteName and GetEmoteAnim(EmoteName)
	if not EmoteAnim then
		EmoteName = 'Resolute'
		EmoteAnim = GetEmoteAnim('Resolute')
	end
	if not EmoteAnim then return end -- Resolute itself missing; nothing to show

	EmoteIds[EmoteName] = EmoteAnim.AnimationId -- cache it now for the play button

	local Desc = EmoteAnim:GetAttribute('Description')
	if Desc then
		Slot.EmoteProperty.Text = Desc
		Slot.EmoteProperty.Visible = true
	else
		Slot.EmoteProperty.Visible = false
	end

	Slot.EmoteName.Text = EmoteName
	Slot.ViewportFrame.WorldModel.Preview.Animation.AnimationId = EmoteAnim.AnimationId
	PlayAnim(Slot.ViewportFrame.WorldModel.Preview.Humanoid.Animator, Slot.ViewportFrame.WorldModel.Preview.Animation)

end

-- Then replace startup calls:
for _, Slot in PagesSlots[1] do
	SetupPlayBtn(Slot.Button)
	InitSlotDisplay(Slot, Emotes[Slot.Name])  -- no server call
end
for _, Slot in PagesSlots[2] do
	SetupPlayBtn(Slot.Button)
	InitSlotDisplay(Slot, Emotes2[Slot.Name])  -- no server call
end


EmoteWheel.Switch.Activated:Connect(function() ----When you have both gamepasses, this will show instead.
	if Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") == false and Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage") == false then 
		print("Player doesn't own one of them")
		return 
	else
		print("Player Owns both more emotes and second page")
	end

	shared.sfx({
		SoundId = "rbxassetid://5797580410", 
		Parent = workspace, 
		Volume = 0.75
	}):Play()

	if CurrentPage == 1 then
		CurrentPage = 2

		for _,v in PagesSlots[1] do
			v.Visible = false
		end

		for _,v in PagesSlots[2] do
			v.Visible = true
		end
	else
		CurrentPage = 1

		for _,v in PagesSlots[1] do
			v.Visible = true
		end

		for _,v in PagesSlots[2] do
			v.Visible = false
		end
	end	
end)


EmoteWheel.Gamepass.Activated:Connect(function()
	Remotes.Gamepasses.RequestGamepass:FireServer("MoreEmotes")
end)

EmoteWheel.GamepassTwo.Activated:Connect(function()
	if Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") == false then
		return
	end
	Remotes.Gamepasses.RequestGamepass:FireServer("SecondPage")
end)

Remotes.Gamepasses.GamepassPurchased.OnClientEvent:Connect(function(gamepassId)
	--print("Changed")
	gamepassId = tostring(gamepassId)

	-- MoreEmotes pass
	if gamepassId == "2063706242" then
		EmoteWheel.Gamepass.Visible = false

		-- Show second page button or switch
		if Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage") then
			EmoteWheel.Switch.Visible = true
		else
			EmoteWheel.GamepassTwo.Visible = true
		end

		-- Reveal all 8 slots on page 1
		for _, v in EmoteWheel.Emotes:GetChildren() do
			v.Visible = true
		end
	end

	-- SecondPage pass
	if gamepassId == "2063782093" then
		EmoteWheel.GamepassTwo.Visible = false
		EmoteWheel.Switch.Visible = true
	end

	if gamepassId == "3726822535" then --More emotes gift product
		EmoteWheel.Gamepass.Visible = false

		-- Show second page button or switch
		if Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage") then
			EmoteWheel.Switch.Visible = true
		else
			EmoteWheel.GamepassTwo.Visible = true
		end

		-- Reveal all 8 slots on page 1
		for _, v in EmoteWheel.Emotes:GetChildren() do
			v.Visible = true
		end
	end

	if gamepassId == "3726822706" then --Second page gift product
		EmoteWheel.GamepassTwo.Visible = false
		EmoteWheel.Switch.Visible = true
	end
end)

--EmoteWheel.Spin.Activated:Connect(function()
--	if Getter:InvokeServer('SpinEmote') == true then
--		shared.sfx({
--			SoundId = "rbxassetid://4612384643", 
--			Parent = workspace, 
--			Volume = 0.6
--		}):Play()

--		EmoteWheel.Spin.Text = 'NEW EMOTE: <font color="rgb(255, 85, 85)">50 KILLS</font>\n<font size="16">HOLD EMOTE DOWN TO CHANGE</font>'
--	end
--end)

--if remainingEmotesToUnlock > 0 then
--	EmoteWheel.Spin.Text = 'RANDOM EMOTE\n<font size="16">1,000 BELI</font>'
--	EmoteWheel.Spin.Visible = true
--end

ReplicatedStorage.Remotes.Emotes.Set.OnClientEvent:Connect(function(Action: string, Params: { any })
	if Action == 'UpdateOwnedEmotes' then
		for _, EmoteName in Params.OwnedEmotes do
			if EmoteIds[EmoteName] then continue end
			local EmoteAnim = GetEmoteAnim(EmoteName)
			if EmoteAnim then EmoteIds[EmoteName] = EmoteAnim.AnimationId end
		end
	end

	if Action == "SlotUpdated" then
		local page = Params.Page
		local slotNum = tonumber(Params.Slot)
		local emoteName = Params.EmoteName
		local pageIndex = page == "Emotes" and 1 or 2
		local slot = PagesSlots[pageIndex] and PagesSlots[pageIndex][slotNum]
		
		print("SlotUpdated →", page, slotNum, emoteName,
			"slotFound:", slot ~= nil, "hasId:", EmoteIds[emoteName] ~= nil)
		
		if slot then
			InitSlotDisplay(slot, emoteName)
		end
	end

end)


shared.emotegui = function()
	if not EmoteWheel.Visible then
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
			end
		end
	end

	EmoteWheel.Visible = not EmoteWheel.Visible

	if EmoteWheel.Visible then
		if Player:GetAttribute("HasVIP") then
			EmoteWheel.Gamepass.Visible = false
			EmoteWheel.GamepassTwo.Visible = false
		end
	end
end
print("emotegui function created")
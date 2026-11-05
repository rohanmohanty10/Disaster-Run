-- services
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- remote (same one your topbar uses)
local PSE = RS.Remotes.Commands.Set

local LocalPlayer = Players.LocalPlayer

local playerIcons = {}
local SelectedUserFrame = nil
local SelectedUserId = nil
local SelectedPlayer = nil

local imageStartLink = "rbxthumb://type=AvatarHeadShot&id="
local imageEndLink = "&w=420&h=420"

local GUI = script.Parent
local MainFrame = GUI.Frame

local PlayersListFrame = MainFrame.ReceiverMagic.Receiver
local PlayersListScrollingFrame = PlayersListFrame.ScrollingFrame
local PlayersListSearchBox = PlayersListFrame.TextBox
local KillButton = MainFrame.Send -- repurposed "Send" button; rename its text to "Kill" in Studio


-- functions

local function createIconImageId(userId)
	return imageStartLink .. userId .. imageEndLink
end

local function deselectCurrent()
	if SelectedUserFrame then
		TweenService:Create(SelectedUserFrame.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageColor3 = Color3.new(0.2, 0.2, 0.2)
		}):Play()
		TweenService:Create(SelectedUserFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1
		}):Play()
	end
	SelectedUserFrame = nil
	SelectedUserId = nil
	SelectedPlayer = nil
	KillButton.Visible = false
end

local function createPlayerIcon(player)
	-- server players only; skip yourself (use "Kill Yourself" for that)
	if playerIcons[player.Name] ~= nil or player == LocalPlayer then return end

	local ImageButton = script.ImageButton:Clone()

	ImageButton.Avatar.Image = createIconImageId(player.UserId)
	ImageButton.Avatar.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
	ImageButton.TextLabel.Text = player.DisplayName
	ImageButton.TextLabel.TextLabel.Text = string.format("(@%s)", player.Name)

	ImageButton.MouseButton1Click:Connect(function()
		if SelectedUserFrame == ImageButton then return end

		deselectCurrent()

		if KillButton.Visible == false then
			if shared.sfx then
				shared.sfx({ SoundId = "rbxassetid://9114157527", Parent = workspace, PlaybackSpeed = 1.6, Volume = 0.3 }):Play()
			end
			KillButton.Size = UDim2.new(0, 0, 0.094, 0)
			KillButton.TextTransparency = 1
			TweenService:Create(KillButton, TweenInfo.new(0.62, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
				Size = UDim2.new(1.552, 0, 0.094, 0), TextTransparency = 0
			}):Play()
		end

		if shared.sfx then
			shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()
		end

		KillButton.Visible = true
		SelectedUserFrame = ImageButton
		SelectedUserId = player.UserId
		SelectedPlayer = player

		TweenService:Create(ImageButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 0.75
		}):Play()
		TweenService:Create(ImageButton.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageColor3 = Color3.new(1, 1, 1)
		}):Play()
	end)

	ImageButton.Parent = PlayersListScrollingFrame
	playerIcons[player.Name] = ImageButton
	return ImageButton
end


-- canvas sizing (kept from your gifting script)
local canvasYSize = 500
local function ChangePlayersListAbsoluteContentSize()
	local absoluteYSize = PlayersListScrollingFrame.UIListLayout.AbsoluteContentSize.Y
	if canvasYSize < absoluteYSize then
		canvasYSize = absoluteYSize
	end
	PlayersListScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(absoluteYSize, canvasYSize))
end


-- populate from the SERVER (not friends)
for _, player in Players:GetPlayers() do
	createPlayerIcon(player)
end

Players.PlayerAdded:Connect(createPlayerIcon)

Players.PlayerRemoving:Connect(function(player)
	local icon = playerIcons[player.Name]
	if icon then
		if SelectedUserFrame == icon then
			deselectCurrent()
		end
		icon:Destroy()
		playerIcons[player.Name] = nil
	end
end)

ChangePlayersListAbsoluteContentSize()
PlayersListScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangePlayersListAbsoluteContentSize)


-- search: filters the players already in the server (no Roblox lookup)
PlayersListSearchBox.Focused:Connect(function()
	if shared.sfx then
		shared.sfx({ SoundId = "rbxassetid://6052548458", Parent = workspace, Volume = 0.2 }):Play()
	end
end)

PlayersListSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = PlayersListSearchBox.Text:lower()

	for name, icon in playerIcons do
		if query == "" then
			icon.Visible = true
		else
			local display = icon.TextLabel.Text:lower()
			icon.Visible = (name:lower():find(query, 1, true) ~= nil)
				or (display:find(query, 1, true) ~= nil)
		end
	end
end)


-- confirm
KillButton.MouseButton1Click:Connect(function()
	if not SelectedUserId then return end

	if shared.sfx then
		shared.sfx({ SoundId = "rbxassetid://6895079853", Parent = workspace, Volume = 0.5 }):Play()
	end

	PSE:FireServer("Kill", { Type = "Player", Target = SelectedPlayer, TargetUserId = SelectedUserId })

	MainFrame.Visible = false
	deselectCurrent()
end)


-- toggle (called from the topbar Kill Player row)
shared.killgui = function(action)
	if action == "close" then
		if MainFrame.Visible then
			MainFrame.Visible = false
			deselectCurrent()
		end
		return
	end

	-- no arg = toggle (default behaviour)
	if not MainFrame.Visible then
		
		deselectCurrent()
		PlayersListSearchBox.Text = ""
		PlayersListFrame.Visible = true
	end
	MainFrame.Visible = not MainFrame.Visible
	warn("Pressed from kill gui")
end
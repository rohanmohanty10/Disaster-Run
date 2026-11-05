-- services

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local UserService = game:GetService("UserService")


-- references

local ComSet = game.ReplicatedStorage.Remotes.Comunicator.Set
local ComGet = game.ReplicatedStorage.Remotes.Comunicator.Get

local LocalPlayer = Players.LocalPlayer

local playerIcons = {}

local imageStartLink = "rbxthumb://type=AvatarHeadShot&id="
local imageEndLink = "&w=420&h=420"

local SelectedUserFrame = nil
local SelectedPassFrame = nil

local GiftingInfo = {}

local GUI = script.Parent
local MainFrame = GUI.Frame

local PlayersListFrame = MainFrame.ReceiverMagic.Receiver
local PlayersListScrollingFrame = PlayersListFrame.ScrollingFrame
local PlayersListSearchBox = PlayersListFrame.TextBox

local PassesScrollingFrame = MainFrame.ScrollingFrame
local SendButton = MainFrame.Send

local LastPlayersListSearchBoxCheck = tick()
local LastPlayerSearchedButton = nil

local InfoModule = require(RS.Info)

local GiftablePasses = {
	VipGift = "3726822224", --3726822535
	MoreEmoteGift = "3726822535", --3726822535
	SecondPageGift = "3726822706", --3726822706
}
--if not GiftablePasses then
--	repeat
--		GiftablePasses = InfoModule.Gifts
		
--		task.wait()
--	until GiftablePasses ~= nil
--end


-- functions

local function createIconImageId(userId)
	return imageStartLink .. userId .. imageEndLink
end

local function createPlayerIcon(UserId, Name, DisplayName)
	if playerIcons[Name] ~= nil or UserId == Players.LocalPlayer.UserId then return end
	
	local ImageButton = script.ImageButton:Clone()
	
	ImageButton.Avatar.Image = createIconImageId(UserId)
	ImageButton.Avatar.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
	
	ImageButton.TextLabel.Text = DisplayName
	ImageButton.TextLabel.TextLabel.Text = string.format("(@%s)", Name)
	
	ImageButton.MouseButton1Click:Connect(function()
		if SelectedUserFrame ~= ImageButton then
			if SelectedUserFrame then
				TweenService:Create(SelectedUserFrame.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageColor3 = Color3.new(0.2, 0.2, 0.2)
				}):Play()
				
				TweenService:Create(SelectedUserFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					BackgroundTransparency = 1
				}):Play()
			end
			
			if SendButton.Visible == false then
				shared.sfx({
					SoundId = "rbxassetid://9114157527", 
					Parent = workspace, 
					PlaybackSpeed = 1.6, 
					Volume = 0.3
				}):Play()
				
				SendButton.Size = UDim2.new(0, 0, 0.094, 0)
				SendButton.TextTransparency = 1.75
				TweenService:Create(SendButton, TweenInfo.new(0.62, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
					Size = UDim2.new(1.552, 0, 0.094, 0), 
					TextTransparency = 0
				}):Play()
			end
			
			shared.sfx({
				SoundId = "rbxassetid://6895079853", 
				Parent = workspace, 
				Volume = 0.5
			}):Play()

			SendButton.Visible = true
			
			
			GiftingInfo.goalUserId = UserId
			SelectedUserFrame = ImageButton
			
			
			TweenService:Create(ImageButton, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0.75
			}):Play()
			
			TweenService:Create(ImageButton.Avatar, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageColor3 = Color3.new(1, 1, 1)
			}):Play()
		end
	end)
	
	ImageButton.Parent = PlayersListScrollingFrame
	
	playerIcons[Name] = ImageButton
	
	return ImageButton
end

local function ResetPlayersListScrollingFrame()
	if LastPlayerSearchedButton then
		LastPlayerSearchedButton:Destroy()
		LastPlayerSearchedButton = nil
	end

	for _,v in playerIcons do
		v.Visible = true
	end	
end


-- runtime

PlayersListScrollingFrame.ChildAdded:Connect(function(ImageButton: ImageButton)
	if ImageButton:IsA("ImageButton") then
		PlayersListScrollingFrame.CanvasSize = UDim2.fromScale(0, 0.079 * (#PlayersListScrollingFrame:GetChildren() - 1))
	end
end)

PlayersListScrollingFrame.ChildRemoved:Connect(function(ImageButton: ImageButton)
	if ImageButton:IsA("ImageButton") then
		PlayersListScrollingFrame.CanvasSize = UDim2.fromScale(0, 0.079 * (#PlayersListScrollingFrame:GetChildren() - 1))
	end
end)

for ProductName, PassId: number in GiftablePasses do
	local productInfo = MarketplaceService:GetProductInfo(tonumber(PassId), Enum.InfoType.Product)
	
	
	local PassIcon = productInfo.IconImageAssetId
	if PassIcon == 0 then
		PassIcon = 14684890890
	end
	
	
	local PassFrame = script.Frame:Clone()
	
	PassFrame.TextLabel.Text = ProductName
	PassFrame.TextLabel.TextLabel.Text = productInfo.PriceInRobux .. " ROBUX"
	
	PassFrame.ImageLabel.Image = "rbxassetid://" .. PassIcon
	PassFrame.ImageLabel.ImageColor3 = Color3.new(0.2, 0.2, 0.2)
	
	PassFrame.Parent = PassesScrollingFrame
	
	PassFrame.Btn.MouseButton1Click:Connect(function()
		if SelectedPassFrame ~= PassFrame then
			if PlayersListFrame.Visible == false then
				--shared.sfx({
				--	SoundId = "rbxassetid://10066914500", 
				--	Parent = workspace, 
				--	Volume = 0.5
				--}):Play()
				
				PlayersListFrame.Visible = true
				
				PlayersListFrame.Position = UDim2.fromScale(1.5, 0.5)
				TweenService:Create(PlayersListFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Position = UDim2.fromScale(0.5, 0.5) }):Play()
			end
			
			--shared.sfx({
			--	SoundId = "rbxassetid://6895079853", 
			--	Parent = workspace, 
			--	Volume = 0.5
			--}):Play()
			
			if SelectedPassFrame ~= nil then
				TweenService:Create(SelectedPassFrame.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					ImageColor3 = Color3.new(0.2, 0.2, 0.2)
				}):Play()
			end
			
			SelectedPassFrame = PassFrame
			GiftingInfo.passName = ProductName
			
			TweenService:Create(PassFrame.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				ImageColor3 = Color3.new(1, 1, 1)
			}):Play()
		end
	end)
end

for _, Player in Players:GetPlayers() do
	createPlayerIcon(Player.UserId, Player.Name, Player.DisplayName)
end

pcall(function()
	local FriendsList = Players:GetFriendsAsync(LocalPlayer.UserId)

	repeat
		for _, Data in FriendsList:GetCurrentPage() do
			createPlayerIcon(Data.Id, Data.Username, Data.DisplayName)
		end

		if FriendsList.IsFinished == false then
			FriendsList:AdvanceToNextPageAsync()
		end
	until FriendsList.IsFinished == true
end)

Players.PlayerAdded:Connect(function(Player)
	createPlayerIcon(Player.UserId, Player.Name, Player.DisplayName)
end)

Players.PlayerRemoving:Connect(function(Player)
	local playerIcon: ImageButton = playerIcons[Player.Name]
	
	if playerIcon then
		playerIcon:Destroy()
		playerIcons[Player.Name] = nil
	end
end)


local canvasYSize = 500
local function ChangePlayersListAbsoluteContentSize()
	local absoluteYSize = PlayersListScrollingFrame.UIListLayout.AbsoluteContentSize.Y
	
	if canvasYSize < absoluteYSize then
		canvasYSize = absoluteYSize
	end
	
	PlayersListScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, math.max(absoluteYSize, canvasYSize))
end

ChangePlayersListAbsoluteContentSize()
PlayersListScrollingFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangePlayersListAbsoluteContentSize)


local function ChangePassesListAbsoluteContentSize()
	PassesScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, PassesScrollingFrame.UIGridLayout.AbsoluteContentSize.Y + 5)
end

ChangePassesListAbsoluteContentSize()
PassesScrollingFrame.UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(ChangePassesListAbsoluteContentSize)

PlayersListSearchBox.Focused:Connect(function()
	shared.sfx({
		SoundId = "rbxassetid://6052548458", 
		Parent = workspace, 
		Volume = 0.2
	}):Play()
end)

PlayersListSearchBox:GetPropertyChangedSignal("Text"):Connect(function() --This is how you search for a player you want to gift to.
	LastPlayersListSearchBoxCheck = tick()

	shared.sfx({
		SoundId = "rbxassetid://147982968", 
		Parent = workspace, 
		Volume = 0.2, 
		PlaybackSpeed = 2
	}):Play()
	
	task.delay(0.3, function()
		if tick() - LastPlayersListSearchBoxCheck > 0.3 then
			pcall(function()
				if PlayersListSearchBox.Text == "" then
					ResetPlayersListScrollingFrame()
				else
					local Username = PlayersListSearchBox.Text
					local userId = Players:GetUserIdFromNameAsync(Username)

					if userId then
						local userInfo = UserService:GetUserInfosByUserIdsAsync({ userId })[1]

						if userInfo then
							for _,v in playerIcons do
								v.Visible = false
							end
							
							if playerIcons[Username] == nil then
								if LastPlayerSearchedButton then
									LastPlayerSearchedButton:Destroy()
									LastPlayerSearchedButton = nil
								end

								LastPlayerSearchedButton = createPlayerIcon(userId, Username, userInfo.DisplayName)

							else
								playerIcons[Username].Visible = true
							end

						else
							for _,v in playerIcons do
								v.Visible = true
							end	
						end

					else
						ResetPlayersListScrollingFrame()
					end
				end
			end)
		end
	end)
end)

SendButton.MouseButton1Click:Connect(function()
	local passName = GiftingInfo.passName
	local goalUserId = GiftingInfo.goalUserId
	
	shared.sfx({
		SoundId = "rbxassetid://6895079853", 
		Parent = workspace, 
		Volume = 0.5
	}):Play()
	
	RS.Remotes.DevProducts.RequestGiftingProduct:FireServer(goalUserId, passName)
	--ComSet:FireServer("SendGift", { userId = goalUserId, Pass = passName })
	
	MainFrame.Visible = false
end)


shared.giftgui = function()
	if not MainFrame.Visible then
		local GoalChildren = LocalPlayer.PlayerGui:GetChildren()

		for _, ScreenGUI in pairs(GoalChildren) do
			if ScreenGUI.Name == "Cape Customization" or ScreenGUI.Name == "Awakening Outfit" or ScreenGUI.Name == "Kill Sound" then
				game:GetService("Debris"):AddItem(ScreenGUI, 0)
			end
			
			if ScreenGUI.Name == "Emotes" then
				local GoalImageLabel = ScreenGUI:FindFirstChild("ImageLabel")
				GoalImageLabel.Visible = true
				GoalImageLabel.Visible = false
				
			elseif ScreenGUI.Name == "Cosmetics" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				GoalFrame.Visible = true
				GoalFrame.Visible = false
			end
		end
	end
	
	MainFrame.Visible = not MainFrame.Visible
end
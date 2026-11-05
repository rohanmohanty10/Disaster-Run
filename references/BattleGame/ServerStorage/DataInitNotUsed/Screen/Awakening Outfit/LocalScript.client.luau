local Player = game.Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")


-- Services

local Players = game.Players
local IS = game.InsertService
local AvatarEditor = game:GetService('AvatarEditorService')
local RS = game.ReplicatedStorage
local TS = game.TweenService


-- Modules

local InfoModule = require(RS.Info)


-- Remotes

local Remotes = RS.Remotes


local PlrComs = Remotes.Comunicator

local PlrSet = PlrComs.Set
local PlrGet = PlrComs.Get


-- Gui

local GUI = script.Parent
local MainFrame = GUI.Frame
local OutfitsScroll = MainFrame.ScrollingFrame


-- Variables

local selectedColor = Color3.fromRGB(255, 255, 255)
local unselectedColor = Color3.fromRGB(70, 70, 70)
local selectedOutfit, selectedMovesets = nil, {}
local hasPerms = false


-- Functions

local function AddScrolls()
	local Outfits = AvatarEditor:GetOutfits(Enum.OutfitSource.Created, Enum.OutfitType.Avatar):GetCurrentPage()
	for _,v in Outfits do
		local Button = script.TextButton:Clone()
		Button.Text = v.Name
		Button.Activated:Connect(function()
			PlrSet:FireServer('ApplyOutfit', { Hum = MainFrame.ViewportFrame.WorldModel.Preview.Humanoid, Id = v.Id })
			selectedOutfit = v.Id

			shared.sfx({
				SoundId = "rbxassetid://5797580410",
				Parent = workspace,
				Volume = 0.75
			}):Play()
		end)
		Button.Parent = OutfitsScroll
	end
	
	OutfitsScroll.CanvasSize = UDim2.new(0, 0, 0, 13 * #OutfitsScroll:GetChildren())
end


-- Runtime

local hasOutfitPerms = pcall(function()
	AvatarEditor:GetOutfits()
end)

if hasOutfitPerms then
	AddScrolls()
else
	AvatarEditor.PromptAllowInventoryReadAccessCompleted:Connect(function(result)
		if result == Enum.AvatarPromptResult.Success then
			hasPerms = true
			print("already works")
			AddScrolls()
		else
			AvatarEditor:PromptAllowInventoryReadAccess()
			
			script.Parent:Destroy()
		end
	end)
end

local charsCount = 0
for Name, Info in InfoModule.Movesets do
	local Order = Info.Order
	local imageId = Info.Icon
	
	local Icon = script.MovesetTemplate:Clone()
	Icon.Image = "rbxassetid://" .. imageId
	Icon.LayoutOrder = Order
	Icon.Parent = MainFrame.Characters
	
	Icon.Activated:Connect(function()
		local isSelected = table.find(selectedMovesets, Name)

		if isSelected ~= nil then
			TS:Create(Icon, TweenInfo.new(.5), { ImageColor3 = unselectedColor }):Play()

			table.remove(selectedMovesets, isSelected)
		else
			TS:Create(Icon, TweenInfo.new(.5), { ImageColor3 = selectedColor }):Play()

			table.insert(selectedMovesets, Name)
		end
		
		shared.sfx({
			SoundId = "rbxassetid://6895079853",
			Volume = 0.5,
			Parent = Player.PlayerGui
		}):Play()
	end)
	
	
	charsCount += 1
end


MainFrame.Characters.CanvasSize = UDim2.new(0, MainFrame.Characters.AbsoluteSize.X + (MainFrame.Characters.AbsoluteSize.X/charsCount), 0, 0)

MainFrame.Apply.Activated:Connect(function()
	if #selectedMovesets == 0 or not selectedOutfit then return end

	PlrSet:FireServer('SetAwkOutfit', { Movesets = selectedMovesets, OutfitId = selectedOutfit })
	
	shared.sfx({
		SoundId = "rbxassetid://6895079853",
		Volume = 0.5,
		Parent = Player.PlayerGui
	}):Play()
	
	script.Parent:Destroy()
end)

GUI:GetPropertyChangedSignal('Enabled'):Connect(function()
	if GUI.Enabled == true and hasPerms == false then
		print("enabled works")
		
		AvatarEditor:PromptAllowInventoryReadAccess()
	end
end)
if GUI.Enabled == true and hasPerms == false then
	AvatarEditor:PromptAllowInventoryReadAccess()
end
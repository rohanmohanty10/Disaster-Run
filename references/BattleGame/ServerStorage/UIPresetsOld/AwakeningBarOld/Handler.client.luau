--// Services \\--

local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local Debris = game.Debris



--// Modules \\--

local InfoModule = require(RS:WaitForChild("Info", 5))



--// Remotes \\--

local Remotes = RS.Remotes


--local AwakeningRemotes = Remotes.ModeRequest

--local AwakeningSet = AwakeningRemotes.Set
--local AwakeningGet = AwakeningRemotes.Get



--// Player \\--

local Player: Player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
local Character = Player.Character or Player.CharacterAdded:Wait()
Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character or Player.CharacterAdded:Wait()

	SetUltName()
end)

local AwakeningProgress: NumberValue = Player:WaitForChild("AwakeningProgress", 5)



--// Events \\--

local AwkProgChanged = AwakeningProgress:GetPropertyChangedSignal('Value')
--local AwkSetEvent = AwakeningSet.OnClientEvent



--// GUI \\--

local GUI = script.Parent
local BarFrame = GUI.UltimateBar
local UltKey = BarFrame.UltKey
local CurrentTween: Tween

local DeviceUltKey = "[G]"
if UIS.TouchEnabled then
	DeviceUltKey = "[PRESS]"
elseif UIS.GamepadEnabled then
	DeviceUltKey = "[DPAD UP]"
end



--// Functions \\--

function SetUltName()
	local MovesetName = Player:GetAttribute("Character")
	local MovesetInfo = InfoModule.Movesets[MovesetName]
	if not MovesetInfo then return end
	
	local ultName: string = MovesetInfo.UltimateName
	local MovesetAwakeningBarColor = InfoModule.Movesets[MovesetName].AwakeningBarColor
	
	if ultName then
		ultName = ultName:upper()
		
		BarFrame.UltName.Text = ultName
		BarFrame.UltName.Shadow.Text = ultName
		
	else
		BarFrame.UltName.Text = "?"
		BarFrame.UltName.Shadow.Text = "?"
	end
	
	if MovesetAwakeningBarColor then
		BarFrame.Outline.Fill.BackgroundColor3 = MovesetAwakeningBarColor
	else
		BarFrame.Outline.Fill.BackgroundColor3 = Color3.fromRGB(227, 77, 77)
	end 
end

local function ActivateAwk()
	if AwakeningProgress.Value < 100 or Character:HasTag('Stunned') or Character:GetAttribute("Awakened") then return end
	if game.PlaceId == workspace:GetAttribute("DuelsHubPlaceId") then return end
	
	Remotes.ModeRequest:FireServer('Awakening')
end



--// Connections \\--

AwkProgChanged:Connect(function()
	local raw = math.clamp(AwakeningProgress.Value / 100, 0, 1)
	local MIN_FILL = 0.04

	-- linear map with a floor, but only floor when there's SOME progress
	local FinalXSize
	if raw <= 0 then
		FinalXSize = 0                                 -- true empty at 0
	else
		FinalXSize = MIN_FILL + (1 - MIN_FILL) * raw   -- linear from floor→full
	end
	if raw >= 1 then FinalXSize = 1 end

	BarFrame.Outline.Fill:TweenSize(UDim2.fromScale(FinalXSize, 1), nil, nil, 0.4, true)

	--local FinalXSize = AwakeningProgress.Value / 100
	
	--if FinalXSize > 1 then
	--	FinalXSize = 1
	--end
	
	----BarFrame.Progress.Bar:TweenSize(UDim2.fromScale(FinalXSize, 1), nil, nil, 0.4, true)
	--BarFrame.Outline.Fill:TweenSize(UDim2.fromScale(FinalXSize, 1), nil, nil, 0.4, true)

	if AwakeningProgress.Value >= 100 then
		if UltKey.Visible then return end
		UltKey.Text = DeviceUltKey
		UltKey.TextLabel.Text = DeviceUltKey
		UltKey.Visible = true
		
		local Indicator = InfoModule.Movesets[Player:GetAttribute("Character")].Indicator
		shared.sfx({
			SoundId = Indicator.Sound, 
			Parent = Character.Torso, 
			Volume = Indicator.Volume, 
			RollOffMaxDistance = 100,
		}):Play()
		
		local Light = script.Light:Clone()
		Light.Parent = Character.Torso
		
		local HLight = script.HLight:Clone()
		HLight.Parent = Character
		
		TS:Create(Light, TweenInfo.new(2, Enum.EasingStyle.Linear), { Brightness = 0 }):Play()
		TS:Create(HLight, TweenInfo.new(2, Enum.EasingStyle.Linear), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
		
		Debris:AddItem(Light, 2)
		Debris:AddItem(HLight, 2)
		
	else
		UltKey.Visible = false
		
	end
end)


UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	
	if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.DPadUp then
		ActivateAwk()
	end
end)

BarFrame.ActivateButton.Activated:Connect(ActivateAwk)

Player:GetAttributeChangedSignal("Moveset"):Connect(SetUltName)

SetUltName()

shared.triggerAwkbar = function(State)
	if State == true then
		BarFrame:TweenPosition(UDim2.new(0.5, 0, 1, -(UIS.TouchEnabled and 150 or 90)), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
	else
		BarFrame:TweenPosition(UDim2.new(0.5, 0, 1, 100), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 1, true)
	end
end
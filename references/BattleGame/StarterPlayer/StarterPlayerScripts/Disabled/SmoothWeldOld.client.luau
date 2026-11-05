local TouchGui: ScreenGui
local loadStart = tick()

local Player = game.Players.LocalPlayer

repeat task.wait() until game:GetService("UserInputService").TouchEnabled or game:GetService("UserInputService").KeyboardEnabled or game:GetService("UserInputService").GamepadEnabled
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

--Services
local MarketService = game:GetService("MarketplaceService")
local RNS = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local TS = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local SoundService = game:GetService("SoundService")
local GuiService = game:GetService("GuiService")
local VoiceChatService = game:GetService("VoiceChatService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--Remotes
local Remotes = RS.Remotes

local ComRemotes = Remotes.Comunicator

local Comunicator = ComRemotes.Set
local Getter = ComRemotes.Get

local Velocity = require(ReplicatedStorage.Modules.Velocity)

local PSE = Remotes.Commands.Set

Remotes.Weld.RemoteEvent.OnClientEvent:Connect(function(Params)
	warn("Smooth weld activated")
	local Bind = Params.Bind
	local Character: Model = Params.Character
	local EnemyCharacter: Model = Params.EnemyCharacter
	local TweenTime: number = Params.TweenTime
	local EasingStyle = Params.EasingStyle or Enum.EasingStyle.Sine
	local EasingDirection = Params.EasingDirection or Enum.EasingDirection.Out
	local Offset: CFrame = Params.Offset

	local StartCFrame = EnemyCharacter:GetPivot()
	local StartTime = os.clock()


	local TweenTask = task.spawn(function()
		while Character ~= nil and Character.Parent ~= nil and EnemyCharacter ~= nil and EnemyCharacter.Parent ~= nil and Bind ~= nil and Bind.Parent ~= nil do
			EnemyCharacter:PivotTo(StartCFrame:Lerp(Character:GetPivot() * Offset, TS:GetValue((os.clock() - StartTime) / TweenTime, EasingStyle, EasingDirection)))

			task.wait()
		end
	end)

	task.delay(TweenTime, function()
		pcall(function()
			task.cancel(TweenTask)
		end)
	end)
end)

Remotes.Combat.Velocity.OnClientEvent:Connect(function(Settings : {})
	local character = Players.LocalPlayer.Character
	if not character then return end
	
	--local NewObject = self:Velocity()
	local NewObject = Velocity.new(character)
	NewObject.Settings = Settings
	NewObject:Fire()
	print(NewObject.Settings)
	warn("VELOCITY APPLIED FROM REMOTE")
end)
-- services

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")



-- replicated storage

local Remotes = ReplicatedStorage.Remotes

local ComunicatorSet = Remotes.Comunicator.Set
local ComunicatorGet = Remotes.Comunicator.Get



-- player

local Player = Players.LocalPlayer



-- gui

local GUI = script.Parent
local MainFrame = GUI.Frame
local BackgroundFade = GUI.Background

local ApplyButton = MainFrame.Apply
local KillTextBox = MainFrame.Decal
local DeathTextBox = MainFrame.DecalTwo



-- runtime

ApplyButton.MouseButton1Click:Connect(function()
	ComunicatorSet:FireServer("SetKillSounds", { Kill = KillTextBox.Text, Death = DeathTextBox.Text })
	
	shared.sfx({
		SoundId = "rbxassetid://6895079853",
		Volume = 0.5,
		Parent = Player.PlayerGui
	}):Play()
	
	script.Parent:Destroy()
end)

KillTextBox.Text = Player:GetAttribute("killSound") or ""
Player:GetAttributeChangedSignal("killSound"):Connect(function()
	KillTextBox.Text = Player:GetAttribute("killSound") or ""
end)

DeathTextBox.Text = Player:GetAttribute("deathSound") or ""
Player:GetAttributeChangedSignal("deathSound"):Connect(function()
	DeathTextBox.Text = Player:GetAttribute("deathSound") or ""
end)
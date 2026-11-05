local KillMessagesModule = {}


--Services
local RS = game:GetService("ReplicatedStorage")



--Remotes
local Remotes = RS.Remotes

local Replication = Remotes.Replicate

local ReplicateSet = Replication.Set
local ReplicateGet = Replication.Get



--Variables

local RandomMessages = {
	"dunked by ",
	"obliterated by ",
	"erased by ",
	"clapped by ",
	"annihilated by ",
	"destroyed by ",
	"folded by ",
	"humbled by ",
	"deleted by ",
	"evaporated by ",
	"shredded by ",
	"smoked by ",
	"dismantled by ",
	"slapped by ",
	"crushed by ",
	"stomped by ",
	"bodied by ",
	"cooked by ",
	"ruined by ",
	"ended by ",
	"demolished by ",
	"embarrassed by ",
	"outplayed by ",
	"one-shotted by ",
	"flashbanged by ",
}

local RandomColors = {
	Color3.fromRGB(255, 0, 0),
	Color3.fromRGB(0, 255, 0),
	Color3.fromRGB(0, 170, 255),
	Color3.fromRGB(255, 255, 0),
	Color3.fromRGB(255, 0, 255),
	Color3.fromRGB(255, 128, 0),
	Color3.fromRGB(180, 0, 255),
	Color3.fromRGB(255, 255, 255),
}

local RandomFonts = {
	Enum.Font.SourceSansBold,
	Enum.Font.Arcade,
	Enum.Font.GothamBold,
	Enum.Font.Fantasy,
	Enum.Font.Bangers,
	Enum.Font.Cartoon,
	Enum.Font.FredokaOne,
}


--Functions

function KillMessagesModule.SendMessage(EnemyCharacter: Model, Character: Model, HasVIP: boolean)
	local KillMessage
	
	
	if HasVIP then
		KillMessage = " has been " .. RandomMessages[math.random(1, #RandomMessages)]
	else
		KillMessage = " has been killed by "
	end
	
	
	local MessageColor = (HasVIP and RandomColors[math.random(1, #RandomColors)]) or Color3.fromRGB(255,255,255)
	local MessageFont = (HasVIP and RandomFonts[math.random(1, #RandomFonts)]) or Enum.Font.SourceSansBold
	
	
	ReplicateSet:FireAllClients("systemMessage", { Info = { Text = EnemyCharacter.Name .. KillMessage .. Character.Name, Color = MessageColor, Font = MessageFont, FontSize = Enum.FontSize.Size24 } })
end


return KillMessagesModule
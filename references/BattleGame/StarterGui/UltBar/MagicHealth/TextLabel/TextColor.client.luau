local Text = script.Parent
local ShadowText = Text.TextLabel

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

if Player:GetAttribute("Character") == "Sou" then
	Text.Text = "LET'S TAKE THIS SERIOUSLY..."
	ShadowText.Text = Text.Text
elseif Player:GetAttribute("Character") == "Kai" then
	Text.Text = "Rebirth Of A Killer"
	ShadowText.Text = Text.Text
	Text.UIGradient.Color = ColorSequence.new(Color3.fromRGB(253, 243, 255))
	ShadowText.UIGradient.Color = ColorSequence.new(Color3.fromRGB(72, 0, 1))
elseif Player:GetAttribute("Character") == "Sunny" then
	Text.Text = "Mark"
	ShadowText.Text = Text.Text
	Text.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	ShadowText.UIGradient.Color = ColorSequence.new(Color3.fromRGB(254, 238, 159))
elseif Player:GetAttribute("Character") == "Alejo" then
	Text.Text = "BLOW DOWN THE HOUSE!"
	ShadowText.Text = Text.Text
	Text.UIGradient.Color = ColorSequence.new(Color3.fromRGB(236, 236, 236))
	ShadowText.UIGradient.Color = ColorSequence.new(Color3.fromRGB(143, 60, 0))
elseif Player:GetAttribute("Character") == "Ghostface" then
	Text.Text = "Don't hang up on me!"
	ShadowText.Text = Text.Text
	Text.UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
	ShadowText.UIGradient.Color = ColorSequence.new(Color3.fromRGB(16, 16, 16))
end
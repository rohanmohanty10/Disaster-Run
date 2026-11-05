local Parent = script.Parent
local Frame = Parent.Frame

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local InfoModule = require(game.ReplicatedStorage.Info)

if UserInputService.TouchEnabled then
	Frame.Size = UDim2.new(0.436, 0, 0.643, 0)
	Frame.Position = UDim2.new(0.758, 0, 0.497, 0)
end

Frame.Visible = true

local ScrollingFrame = Frame.Tab.ScrollingFrame
local UIListLayout = ScrollingFrame.UIListLayout

ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end)

for _, child in pairs(ScrollingFrame:GetChildren()) do
	if tonumber(child.Name) then
		child:Destroy()
	end
end

local function cleanText(text)
	return text
		:gsub(" ✶ ", " ")
		:gsub("## (.-)\n", "%1\n")
		:gsub("BIGGERRR (.-)\n", "%1\n")
		:gsub("%-# (.-)\n", "%1\n")
		:gsub("%*%*(.-)%*%*", "<b>%1</b>")
		:gsub('%*', "• ")
end

local lines = cleanText(InfoModule.UpdateLog):split('\n')

local currentY = 0
local padding = 6
local size = 7
local font = Enum.Font.Gotham

for i, line in ipairs(lines) do
	local clone = ScrollingFrame.Content:Clone()
	clone.Name = tostring(i)
	clone.Text = line
	clone.TextTransparency = 1
	clone.TextXAlignment = Enum.TextXAlignment.Left
	clone.Font = font
	clone.TextSize = size
	clone.TextScaled = false
	clone.AnchorPoint = Vector2.new(0.5, 0)
	clone.Position = UDim2.new(0.5, 0, 0, currentY)

	local height = clone.TextBounds.Y + padding
	clone.Size = UDim2.new(0.95, 0, 0, height)

	if line:find("🛠️") or line:find("✨") then
		clone.TextXAlignment = Enum.TextXAlignment.Center
	end

	local oldConstraint = clone:FindFirstChildWhichIsA("UITextSizeConstraint")
	if oldConstraint then
		oldConstraint:Destroy()
	end

	clone.Parent = ScrollingFrame

	TweenService:Create(clone, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		TextTransparency = 0,
	}):Play()

	currentY = currentY + height
end
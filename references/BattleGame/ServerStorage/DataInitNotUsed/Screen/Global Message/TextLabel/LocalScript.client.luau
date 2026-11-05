local Parent_upvr = script.Parent
local Frame = Parent_upvr.Frame

local TweenService_upvr = game:GetService("TweenService")

if game:GetService("UserInputService").GamepadEnabled or game:GetService("GuiService"):IsTenFootInterface() then
	return script.Parent.Parent:Destroy()
end


script.Parent.Visible = true
Parent_upvr.TextColor3 = ({Color3.fromRGB(105, 182, 255), Color3.fromRGB(255, 121, 80), Color3.fromRGB(94, 255, 132), Color3.fromRGB(255, 155, 232), Color3.fromRGB(194, 192, 255), Color3.fromRGB(255, 245, 103)})[math.random(1, 6)]
Frame.BackgroundTransparency = 0


TweenService_upvr:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	BackgroundTransparency = 1;
}):Play()

shared.sfx({
	SoundId = "rbxassetid://6647897822",
	Parent = workspace,
	Volume = 1
}):Play()


local Message_upvr = Parent_upvr.Parent:GetAttribute("Message")
local TextColor3 = Parent_upvr.TextColor3
Parent_upvr.translate.Text = Message_upvr
local TextLabel_upvr = Parent_upvr.TextLabel


task.delay(0.4, function() 
	TweenService_upvr:Create(Parent_upvr.Fade, TweenInfo.new(#Message_upvr * 0.06 * 2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		ImageTransparency = 0.6
	}):Play()
	
	local Text = Parent_upvr.translate.Text
	
	for i = 1, #Text do
		TextLabel_upvr.Text ..= string.sub(Text, i, i)
		task.wait(0.06)
	end
	
	task.delay(10, function()
		TweenService_upvr:Create(Parent_upvr, TweenInfo.new(3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Position = UDim2.new(0, 0, 0, -200);
		}):Play()
	end)
end)


while task.wait() do
	local var17 = math.sin(tick() * math.pi / 2) * 22
	
	Parent_upvr.TextColor3 = Color3.fromRGB(math.clamp(TextColor3.R * 255 - var17, 0, 255), math.clamp(TextColor3.G * 255 + var17, 0, 255), math.clamp(TextColor3.B * 255 - var17, 0, 255))
end
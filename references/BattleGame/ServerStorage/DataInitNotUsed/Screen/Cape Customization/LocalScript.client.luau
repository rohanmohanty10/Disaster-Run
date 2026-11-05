-- Services

local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")


-- Player


local Player = game.Players.LocalPlayer


-- GUI

local GUI = script.Parent
local ColorWheel = GUI.Frame.Wheel
local SliderFrame = GUI.Frame.Slider
local InsertDecal = GUI.Frame.Decal
local PreviewDecal = GUI.Frame.Preview
local CursorFrame = ColorWheel.Cursor


-- Variables

local SoundPlayed = false
local SoundPlayedTwo = false

local DefaultColor = Color3.new(1, 1, 1)
local DarkerValue = 1
local StartTime = 0

local Configuration = {
	Slider = 0,
	Cursor = {
		0, 0 
	},
	Decal = 0
}

local LastData


-- Functions

pcall(function() 
	LastData = game:GetService("HttpService"):JSONDecode(GUI:GetAttribute("Info"))
	
	if LastData then
		InsertDecal.Text = tonumber(LastData.Decal)
		
		
		local R, G, B = LastData.Color[1], LastData.Color[2], LastData.Color[3]
		local GeneratedColor = Color3.new(R, G, B)
		
		
		InsertDecal.Text = LastData.Decal
		PreviewDecal.Glow.ImageColor3 = GeneratedColor
		PreviewDecal.BackgroundColor3 = GeneratedColor
		SliderFrame.TextButton.Position = UDim2.new(0, 0, LastData.OldData.Slider, 0)
		ColorWheel.Cursor.Position = UDim2.new(0, LastData.OldData.Cursor[1], 0, LastData.OldData.Cursor[2])
		
		
		if not GeneratedColor then
			GeneratedColor = Color3.new(1, 1, 1)
		end
		
		
		DefaultColor = GeneratedColor
		DarkerValue = LastData.Slider or 1
		Configuration.Slider = LastData.Slider
		Configuration.Cursor = LastData.Cursor
		Configuration.Decal = tonumber(GUI:GetAttribute("Decal"))
		Configuration.Color = {
			R,
			G,
			B 
		}
	end
end)


GUI.Frame.Apply.MouseButton1Click:Connect(function() 
	shared.sfx({
		SoundId = "rbxassetid://6895079853",
		Volume = 0.5,
		Parent = Player.PlayerGui
	}):Play()
	
	
	Configuration.Decal = tonumber(InsertDecal.Text)
	
	
	RS.Remotes.Comunicator.Set:FireServer("UpdateCape", {
		Color = Color3.new(DefaultColor.R * DarkerValue, DefaultColor.G * DarkerValue, DefaultColor.B * DarkerValue),
		Value = DarkerValue,
		Decal = tonumber(InsertDecal.Text),
		OldData = game:GetService("HttpService"):JSONEncode(Configuration),
	})
	
	
	script.Parent:Destroy()
end)


local function GenerateColor(Target)
	local Center = Vector2.new(
		ColorWheel.AbsolutePosition.X + ColorWheel.AbsoluteSize.X / 2,
		ColorWheel.AbsolutePosition.Y + ColorWheel.AbsoluteSize.Y / 2
	)
	
	local Offset = Target - Center
	local Radius = ColorWheel.AbsoluteSize.X / 2
	
	if Radius == 0 then
		Radius = 1
	end
	
	local Distance = math.clamp(Offset.Magnitude, 0, Radius)
	local Hue = (1 - ((math.atan2(Offset.Y, Offset.X) + math.pi) / (2 * math.pi))) % 1
	local Saturation = Distance / Radius
	
	return Color3.fromHSV(Hue, Saturation, 1)
end


SliderFrame.MouseButton1Down:Connect(function()
	if not SoundPlayedTwo then
		SoundPlayedTwo = true
		
		shared.sfx({
			SoundId = "rbxassetid://6895079853",
			Volume = 0.5,
			Parent = Player.PlayerGui
		}):Play()
	end
end)


ColorWheel.MouseButton1Down:Connect(function() 
	if not SoundPlayed then
		SoundPlayed = true
		
		shared.sfx({
			SoundId = "rbxassetid://6895079853",
			Volume = 0.5,
			Parent = Player.PlayerGui
		}):Play()
	end
end)


UIS.InputEnded:Connect(function(Type, gameProcessed) 
	if Type.UserInputType ~= Enum.UserInputType.MouseButton1 and Type.UserInputType ~= Enum.UserInputType.Touch then
		
	elseif SoundPlayed or SoundPlayedTwo then
		SoundPlayed = false
		SoundPlayedTwo = false
		
		shared.sfx({
			SoundId = "rbxassetid://6895079853",
			Volume = 0.5,
			Parent = Player.PlayerGui
		}):Play()
	end
end)


UIS.InputChanged:Connect(function(Type)
	if Type.UserInputType ~= Enum.UserInputType.MouseMovement and Type.UserInputType ~= Enum.UserInputType.Touch and Type.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	
	
	if tick() - StartTime < 0.06 then return end
	StartTime = tick()
	
	
	if SoundPlayedTwo or Type.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pos = (Type.Position.Y - SliderFrame.AbsolutePosition.Y) / SliderFrame.AbsoluteSize.Y
		local Clamped = math.clamp(Pos, 0, 1)
		
		
		if Clamped == Pos then
			shared.sfx({
				SoundId = "rbxassetid://7198717057",
				Volume = 0.5,
				Parent = Player.PlayerGui
			}):Play()
		end
		
		
		SliderFrame.TextButton:TweenPosition(UDim2.new(0, 0, Clamped, 0), nil, nil, 0.1, true)
		DarkerValue = 1 - Clamped
		Configuration.Slider = Clamped
		
		
		local GeneratedColor = Color3.new(DefaultColor.R * DarkerValue, DefaultColor.G * DarkerValue, DefaultColor.B * DarkerValue)
		PreviewDecal.Glow.ImageColor3 = GeneratedColor
		PreviewDecal.BackgroundColor3 = GeneratedColor
		
		
		return
	end
	

	local MousePos = UIS:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y)
	local VectorTwo = Vector2.new(ColorWheel.AbsolutePosition.X + ColorWheel.AbsoluteSize.X / 2, ColorWheel.AbsolutePosition.Y + ColorWheel.AbsoluteSize.Y / 2)
	local CalculatedUnit = (MousePos - VectorTwo).unit
	
	
	if SoundPlayed or Type.UserInputType == Enum.UserInputType.MouseButton1 then
		local Pos = ColorWheel.AbsoluteSize.X / 2
		
		
		shared.sfx({
			SoundId = "rbxassetid://7198717057",
			Volume = 0.5,
			Parent = Player.PlayerGui
		}):Play()
		
		
		if (MousePos - VectorTwo).Magnitude <= ColorWheel.AbsoluteSize.X * 0.5 then
			CursorFrame:TweenPosition(UDim2.new(0, MousePos.X - ColorWheel.AbsolutePosition.X, 0, MousePos.Y - ColorWheel.AbsolutePosition.Y), nil, nil, 0.1, true)
		else
			CursorFrame:TweenPosition(UDim2.new(0, Pos + CalculatedUnit.X * Pos, 0, Pos + CalculatedUnit.Y * Pos), nil, nil, 0.1, true)
		end
		
		
		Configuration.Cursor = {
			CursorFrame.Position.X.Offset,
			CursorFrame.Position.Y.Offset
		}
		
		
		DefaultColor = GenerateColor(MousePos)
		
		local GeneratedColor = Color3.new(DefaultColor.R * DarkerValue, DefaultColor.G * DarkerValue, DefaultColor.B * DarkerValue)
		PreviewDecal.Glow.ImageColor3 = GeneratedColor
		PreviewDecal.BackgroundColor3 = GeneratedColor
	end
end)
--!strict
-- Tiny helper for building code UI: Make("Frame", { Size = ..., Parent = ... }, { children }).
-- Also holds the match-UI theme (GAME_PLAN.md Section 5: deep slate glass + neon borders).

local Make = {}

Make.Theme = {
	Slate = Color3.fromRGB(15, 23, 42), -- #0F172A
	SlateLight = Color3.fromRGB(30, 41, 59),
	Text = Color3.fromRGB(241, 245, 249),
	SubText = Color3.fromRGB(148, 163, 184),
	Cyan = Color3.fromRGB(56, 189, 248),
	Green = Color3.fromRGB(74, 222, 128),
	Red = Color3.fromRGB(248, 113, 113),
	Gold = Color3.fromRGB(250, 204, 21),
	Purple = Color3.fromRGB(167, 139, 250),
	Font = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
	FontHeavy = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy),
}

function Make.new(className: string, props: { [string]: any }?, children: { Instance }?): any
	local instance = Instance.new(className) :: any
	local parent = nil
	for key, value in props or {} do
		if key == "Parent" then
			parent = value
		else
			instance[key] = value
		end
	end
	for _, child in children or {} do
		child.Parent = instance
	end
	if parent then
		instance.Parent = parent
	end
	return instance
end

-- A dark glass panel with a neon outline.
function Make.Panel(props: { [string]: any }, accent: Color3?, children: { Instance }?): Frame
	local merged = {
		BackgroundColor3 = Make.Theme.Slate,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
	}
	for key, value in props do
		merged[key] = value
	end
	local list = children or {}
	table.insert(list, Make.new("UICorner", { CornerRadius = UDim.new(0, 10) }))
	table.insert(list, Make.new("UIStroke", { Color = accent or Make.Theme.Cyan, Thickness = 1.5, Transparency = 0.2 }))
	return Make.new("Frame", merged, list)
end

function Make.Label(props: { [string]: any }): TextLabel
	local merged = {
		BackgroundTransparency = 1,
		FontFace = Make.Theme.Font,
		TextColor3 = Make.Theme.Text,
		TextScaled = true,
	}
	for key, value in props do
		merged[key] = value
	end
	local label = Make.new("TextLabel", merged)
	Make.new("UIStroke", { Thickness = 1.5, Transparency = 0.3, Parent = label })
	return label
end

-- A horizontal fill bar. Returns the background frame and the fill frame.
function Make.Bar(props: { [string]: any }, color: Color3): (Frame, Frame)
	local merged = {
		BackgroundColor3 = Make.Theme.SlateLight,
		BorderSizePixel = 0,
	}
	for key, value in props do
		merged[key] = value
	end
	local background = Make.new("Frame", merged, { Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }) })
	local fill = Make.new("Frame", {
		BackgroundColor3 = color,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Parent = background,
	}, { Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }) })
	return background, fill
end

return Make

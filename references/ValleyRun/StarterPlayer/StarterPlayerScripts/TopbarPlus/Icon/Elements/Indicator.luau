 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
return function(icon, Icon)

	local widget = icon.widget
	local contents = icon:getInstance("Contents")
	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.LayoutOrder = 9999999
	indicator.ZIndex = 6
	indicator.Size = UDim2.new(0, 42, 0, 42)
	indicator.BorderColor3 = Color3.fromRGB(0, 0, 0)
	indicator.BackgroundTransparency = 1
	indicator.Position = UDim2.new(1, 0, 0.5, 0)
	indicator.BorderSizePixel = 0
	indicator.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	indicator.Parent = contents

	local indicatorButton = Instance.new("Frame")
	indicatorButton.Name = "IndicatorButton"
	indicatorButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	indicatorButton.AnchorPoint = Vector2.new(0.5, 0.5)
	indicatorButton.BorderSizePixel = 0
	indicatorButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	indicatorButton.Parent = indicator
	
	local GuiService = game:GetService("GuiService")
	local GamepadService = game:GetService("GamepadService")
	local ourClickRegion = icon:getInstance("ClickRegion")
	local function selectionChanged()
		local selectedClickRegion = GuiService.SelectedObject
		if selectedClickRegion == ourClickRegion then
			indicatorButton.BackgroundTransparency = 1
			indicatorButton.Position = UDim2.new(0.5, -2, 0.5, 0)
			indicatorButton.Size = UDim2.fromScale(1.2, 1.2)
		else
			indicatorButton.BackgroundTransparency = 0.75
			indicatorButton.Position = UDim2.new(0.5, 2, 0.5, 0)
			indicatorButton.Size = UDim2.fromScale(1, 1)
		end
	end
	icon.janitor:add(GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged))
	selectionChanged()

	local imageLabel = Instance.new("ImageLabel")
	imageLabel.LayoutOrder = 2
	imageLabel.ZIndex = 15
	imageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	imageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	imageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
	imageLabel.Parent = indicatorButton

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = indicatorButton

	local UserInputService = game:GetService("UserInputService")
	local function setIndicatorVisible(visibility)
		if visibility == nil then
			visibility = indicator.Visible
		end
		if GamepadService.GamepadCursorEnabled then
			visibility = false
		end
		if visibility then
			icon:modifyTheme({"PaddingRight", "Size", UDim2.new(0, 0, 1, 0)}, "IndicatorPadding")
		elseif indicator.Visible then
			icon:removeModification("IndicatorPadding")
		end
		icon:modifyTheme({"Indicator", "Visible", visibility})
		icon.updateSize:Fire()
	end
	icon.janitor:add(GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible))
	icon.indicatorSet:Connect(function(keyCode)
		local visibility = false
		if keyCode then
			imageLabel.Image = UserInputService:GetImageForKeyCode(keyCode)
			visibility = true
		end
		setIndicatorVisible(visibility)
	end)

	local function updateSize()
		local ySize = widget.AbsoluteSize.Y*0.96
		indicator.Size = UDim2.new(0, ySize, 0, ySize)
	end
	widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)
	updateSize()

	return indicator
end
]]

 

return function(u1, p2) -- Line: 1
    local widget = u1.widget;
    local Instance2 = u1:getInstance("Contents");
    local Frame = Instance.new("Frame");
    Frame.Name = "Indicator";
    Frame.LayoutOrder = 9999999;
    Frame.ZIndex = 6;
    Frame.Size = UDim2.new(0, 42, 0, 42);
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.new(1, 0, 0.5, 0);
    Frame.BorderSizePixel = 0;
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.Parent = Instance2;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "IndicatorButton";
    Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame2.BorderSizePixel = 0;
    Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame2.Parent = Frame;
    local GuiService = game:GetService("GuiService");
    local GamepadService = game:GetService("GamepadService");
    local Instance3 = u1:getInstance("ClickRegion");

    local function selectionChanged() -- Line: 28
        -- upvalues: GuiService (copy), Instance3 (copy), Frame2 (copy)
        if GuiService.SelectedObject == Instance3 then
            Frame2.BackgroundTransparency = 1;
            Frame2.Position = UDim2.new(0.5, -2, 0.5, 0);
            Frame2.Size = UDim2.fromScale(1.2, 1.2);

            return;
        end;

        Frame2.BackgroundTransparency = 0.75;
        Frame2.Position = UDim2.new(0.5, 2, 0.5, 0);
        Frame2.Size = UDim2.fromScale(1, 1);
    end;

    u1.janitor:add(GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged));
    selectionChanged();
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.LayoutOrder = 2;
    ImageLabel.ZIndex = 15;
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0);
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png";
    ImageLabel.Parent = Frame2;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame2;
    local UserInputService = game:GetService("UserInputService");

    local function setIndicatorVisible(p3) -- Line: 58
        -- upvalues: Frame (copy), GamepadService (copy), u1 (copy)
        if p3 == nil then
            p3 = Frame.Visible;
        end;

        if GamepadService.GamepadCursorEnabled then
            p3 = false;
        end;

        if p3 then
            u1:modifyTheme({ "PaddingRight", "Size", UDim2.new(0, 0, 1, 0) }, "IndicatorPadding");
        elseif Frame.Visible then
            u1:removeModification("IndicatorPadding");
        end;

        u1:modifyTheme({ "Indicator", "Visible", p3 });
        u1.updateSize:Fire();
    end;

    u1.janitor:add(GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible));
    u1.indicatorSet:Connect(function(p4) -- Line: 74
        -- upvalues: ImageLabel (copy), UserInputService (copy), setIndicatorVisible (copy)
        local v5;

        if p4 then
            ImageLabel.Image = UserInputService:GetImageForKeyCode(p4);
            v5 = true;
        else
            v5 = false;
        end;

        setIndicatorVisible(v5);
    end);
    widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 83, Name: updateSize
        -- upvalues: widget (copy), Frame (copy)
        local v6 = widget.AbsoluteSize.Y * 0.96;
        Frame.Size = UDim2.new(0, v6, 0, v6);
    end);
    local v7 = widget.AbsoluteSize.Y * 0.96;
    Frame.Size = UDim2.new(0, v7, 0, v7);

    return Frame;
end;
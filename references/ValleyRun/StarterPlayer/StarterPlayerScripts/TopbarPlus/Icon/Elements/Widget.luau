 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- I named this 'Widget' instead of 'Icon' to make a clear difference between the icon *object* and
-- the icon (aka Widget) instance.
-- This contains the core components of the icon such as the button, image, label and notice. It's
-- also responsible for handling the automatic resizing of the widget (based upon image visibility and text length)

return function(icon, Icon)

	local Utility = require(script.Parent.Parent.Utility)
	local hasSizedOnScreen = false

	local widget = Instance.new("Frame")
	widget:SetAttribute("WidgetUID", icon.UID)
	widget.Name = "Widget"
	widget.BackgroundTransparency = 1
	widget.Visible = true
	widget.ZIndex = 20
	widget.Active = false
	widget.ClipsDescendants = true

	local button = Instance.new("Frame")
	button.Name = "IconButton"
	button.Visible = true
	button.ZIndex = 2
	button.BorderSizePixel = 0
	button.Parent = widget
	button.ClipsDescendants = true
	button.Active = false -- This is essential for mobile scrollers to work when dragging
	icon.deselected:Connect(function()
		button.ClipsDescendants = true
		task.delay(0.2, function()
			if icon.isSelected then
				button.ClipsDescendants = false
			end
		end)
	end)

	-- Account for PreferredTransparency which can be set by every player
	local GuiService = game:GetService("GuiService")
	icon:setBehaviour("IconButton", "BackgroundTransparency", function(value)
		local preference = GuiService.PreferredTransparency
		local newValue = value * preference
		if value == 1 then
			return value
		end
		return newValue
	end)
	icon.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function()
		icon:refreshAppearance(button, "BackgroundTransparency")
	end))

	local iconCorner = Instance.new("UICorner")
	iconCorner:SetAttribute("Collective", "IconCorners")
	iconCorner.Name = "UICorner"
	iconCorner.Parent = button

	local menu = require(script.Parent.Menu)(icon)
	local menuUIListLayout = menu.MenuUIListLayout
	local menuGap = menu.MenuGap
	menu.Parent = button

	local iconSpot = Instance.new("Frame")
	iconSpot.Name = "IconSpot"
	iconSpot.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
	iconSpot.BackgroundTransparency = 0.9
	iconSpot.Visible = true
	iconSpot.AnchorPoint = Vector2.new(0, 0.5)
	iconSpot.ZIndex = 5
	iconSpot.Parent = menu

	local iconSpotCorner = iconCorner:Clone()
	iconSpotCorner.Parent = iconSpot

	local overlay = iconSpot:Clone()
	overlay.UICorner.Name = "OverlayUICorner"
	overlay.Name = "IconOverlay"
	overlay.BackgroundColor3 = Color3.fromRGB(208, 217, 251)
	overlay.ZIndex = iconSpot.ZIndex + 1
	overlay.Size = UDim2.new(1, 0, 1, 0)
	overlay.Position = UDim2.new(0, 0, 0, 0)
	overlay.AnchorPoint = Vector2.new(0, 0)
	overlay.Visible = false
	overlay.Parent = iconSpot

	local clickRegion = Instance.new("TextButton")
	clickRegion:SetAttribute("CorrespondingIconUID", icon.UID)
	clickRegion.Name = "ClickRegion"
	clickRegion.BackgroundTransparency = 1
	clickRegion.Visible = true
	clickRegion.Text = ""
	clickRegion.ZIndex = 20
	clickRegion.Selectable = true
	clickRegion.SelectionGroup = true
	clickRegion.Parent = iconSpot
	
	local Gamepad = require(script.Parent.Parent.Features.Gamepad)
	Gamepad.registerButton(clickRegion)

	local clickRegionCorner = iconCorner:Clone()
	clickRegionCorner.Parent = clickRegion

	local contents = Instance.new("Frame")
	contents.Name = "Contents"
	contents.BackgroundTransparency = 1
	contents.Size = UDim2.fromScale(1, 1)
	contents.Parent = iconSpot

	local contentsList = Instance.new("UIListLayout")
	contentsList.Name = "ContentsList"
	contentsList.FillDirection = Enum.FillDirection.Horizontal
	contentsList.VerticalAlignment = Enum.VerticalAlignment.Center
	contentsList.SortOrder = Enum.SortOrder.LayoutOrder
	contentsList.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
	contentsList.Padding = UDim.new(0, 3)
	contentsList.Parent = contents

	local paddingLeft = Instance.new("Frame")
	paddingLeft.Name = "PaddingLeft"
	paddingLeft.LayoutOrder = 0
	paddingLeft.ZIndex = 5
	paddingLeft.BorderColor3 = Color3.fromRGB(0, 0, 0)
	paddingLeft.BackgroundTransparency = 1
	paddingLeft.BorderSizePixel = 0
	paddingLeft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	paddingLeft.Parent = contents

	local paddingCenter = Instance.new("Frame")
	paddingCenter.Name = "PaddingCenter"
	paddingCenter.LayoutOrder = 3
	paddingCenter.ZIndex = 5
	paddingCenter.Size = UDim2.new(0, 0, 1, 0)
	paddingCenter.BorderColor3 = Color3.fromRGB(0, 0, 0)
	paddingCenter.BackgroundTransparency = 1
	paddingCenter.BorderSizePixel = 0
	paddingCenter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	paddingCenter.Parent = contents

	local paddingRight = Instance.new("Frame")
	paddingRight.Name = "PaddingRight"
	paddingRight.LayoutOrder = 7
	paddingRight.ZIndex = 5
	paddingRight.BorderColor3 = Color3.fromRGB(0, 0, 0)
	paddingRight.BackgroundTransparency = 1
	paddingRight.BorderSizePixel = 0
	paddingRight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	paddingRight.Parent = contents

	local iconLabelContainer = Instance.new("Frame")
	iconLabelContainer.Name = "IconLabelContainer"
	iconLabelContainer.LayoutOrder = 4
	iconLabelContainer.ZIndex = 3
	iconLabelContainer.AnchorPoint = Vector2.new(0, 0.5)
	iconLabelContainer.Size = UDim2.new(0, 0, 0.5, 0)
	iconLabelContainer.BackgroundTransparency = 1
	iconLabelContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
	iconLabelContainer.Parent = contents

	local iconLabel = Instance.new("TextLabel")
	local viewportX = workspace.CurrentCamera.ViewportSize.X+200
	iconLabel.Name = "IconLabel"
	iconLabel.LayoutOrder = 4
	iconLabel.ZIndex = 15
	iconLabel.AnchorPoint = Vector2.new(0, 0)
	iconLabel.Size = UDim2.new(0, viewportX, 1, 0)
	iconLabel.ClipsDescendants = false
	iconLabel.BackgroundTransparency = 1
	iconLabel.Position = UDim2.fromScale(0, 0)
	iconLabel.RichText = true
	iconLabel.TextColor3 = Color3.fromRGB(247, 247, 248)
	iconLabel.TextXAlignment = Enum.TextXAlignment.Left
	iconLabel.Text = ""
	iconLabel.TextWrapped = true
	iconLabel.TextScaled = false
	iconLabel.Active = false
	iconLabel.AutoLocalize = true
	iconLabel.Parent = iconLabelContainer

	local iconImage = Instance.new("ImageLabel")
	iconImage.Name = "IconImage"
	iconImage.LayoutOrder = 2
	iconImage.ZIndex = 15
	iconImage.AnchorPoint = Vector2.new(0, 0.5)
	iconImage.Size = UDim2.new(0, 0, 0.5, 0)
	iconImage.BackgroundTransparency = 1
	iconImage.Position = UDim2.new(0, 11, 0.5, 0)
	iconImage.ScaleType = Enum.ScaleType.Stretch
	iconImage.Active = false
	iconImage.Parent = contents

	local iconImageCorner = iconCorner:Clone()
	iconImageCorner:SetAttribute("Collective", nil)
	iconImageCorner.CornerRadius = UDim.new(0, 0)
	iconImageCorner.Name = "IconImageCorner"
	iconImageCorner.Parent = iconImage

	local TweenService = game:GetService("TweenService")
	local resizingCount = 0
	local function handleLabelAndImageChangesUnstaggered(forceUpdateString)

		-- We defer changes by a frame to eliminate all but 1 requests which
		-- could otherwise stack up to 20+ requests in a single frame
		-- We then repeat again once to account for any final changes
		-- Deferring is also essential because properties are set immediately
		-- afterwards (therefore calculations will use the correct values)
		task.defer(function()
			local indicator = icon.indicator
			local usingIndicator = indicator and indicator.Visible
			local usingText = usingIndicator or iconLabel.Text ~= ""
			local usingImage = iconImage.Image ~= "" or iconImage.ImageContent.SourceType ~= Enum.ContentSourceType.None
			local _alignment = Enum.HorizontalAlignment.Center
			local NORMAL_BUTTON_SIZE = UDim2.fromScale(1, 1)
			local buttonSize = NORMAL_BUTTON_SIZE
			if usingImage and not usingText then
				iconLabelContainer.Visible = false
				iconImage.Visible = true
				paddingLeft.Visible = false
				paddingCenter.Visible = false
				paddingRight.Visible = false
			elseif not usingImage and usingText then
				iconLabelContainer.Visible = true
				iconImage.Visible = false
				paddingLeft.Visible = true
				paddingCenter.Visible = false
				paddingRight.Visible = true
			elseif usingImage and usingText then
				iconLabelContainer.Visible = true
				iconImage.Visible = true
				paddingLeft.Visible = true
				paddingCenter.Visible = not usingIndicator
				paddingRight.Visible = not usingIndicator
				_alignment = Enum.HorizontalAlignment.Left
			end
			button.Size = buttonSize

			local function getItemWidth(item)
				-- AbsoluteSize stays 0 until the icon is laid out on screen, so fixed pixel widths are read
				-- straight from Size. Scaled or automatic widths still need the measured size
				local targetWidth = item:GetAttribute("TargetWidth")
				if targetWidth then
					return targetWidth
				end
				local automaticSize = item.AutomaticSize
				local isAutomaticX = automaticSize == Enum.AutomaticSize.X or automaticSize == Enum.AutomaticSize.XY
				if item.Size.X.Scale == 0 and not isAutomaticX then
					return item.Size.X.Offset
				end
				return item.AbsoluteSize.X
			end
			local contentsPadding = contentsList.Padding.Offset
			local initialWidgetWidth = contentsPadding --0
			local textWidth = iconLabel.TextBounds.X
			iconLabelContainer.Size = UDim2.new(0, textWidth, iconLabel.Size.Y.Scale, 0)
			for _, child in pairs(contents:GetChildren()) do
				if child:IsA("GuiObject") and child.Visible == true then
					local itemWidth = getItemWidth(child)
					initialWidgetWidth += itemWidth + contentsPadding
				end
			end
			local widgetMinimumWidth = widget:GetAttribute("MinimumWidth")
			local widgetMinimumHeight = widget:GetAttribute("MinimumHeight")
			local widgetBorderSize = widget:GetAttribute("BorderSize")
			local widgetWidth = math.clamp(initialWidgetWidth, widgetMinimumWidth, math.max(viewportX, widgetMinimumWidth))
			local menuIcons = icon.menuIcons
			local additionalWidth = 0
			local hasMenu = #menuIcons > 0
			local showMenu = hasMenu and icon.isSelected
			if showMenu then
				for _, frame in pairs(menu:GetChildren()) do
					if frame ~= iconSpot and frame:IsA("GuiObject") and frame.Visible then
						additionalWidth += getItemWidth(frame) + menuUIListLayout.Padding.Offset
					end
				end
				if not iconSpot.Visible then
					widgetWidth -= (getItemWidth(iconSpot) + menuUIListLayout.Padding.Offset*2 + widgetBorderSize)
				end
				additionalWidth -= (widgetBorderSize*0.5)
				widgetWidth += additionalWidth - (widgetBorderSize*0.75)
			end
			menuGap.Visible = showMenu and iconSpot.Visible
			local desiredWidth = widget:GetAttribute("DesiredWidth")
			if desiredWidth and widgetWidth < desiredWidth then
				widgetWidth = desiredWidth
			end

			icon.updateMenu:Fire()
			local preWidth = math.max(widgetWidth-additionalWidth, widgetMinimumWidth)
			local spotWidth = preWidth-(widgetBorderSize*2)
			local menuWidth = menu:GetAttribute("MenuWidth")
			local totalMenuWidth = menuWidth and menuWidth + spotWidth + menuUIListLayout.Padding.Offset + 10
			if totalMenuWidth then
				local maxWidth = menu:GetAttribute("MaxWidth")
				if maxWidth then
					totalMenuWidth = math.max(maxWidth, widgetMinimumWidth)
				end
				menu:SetAttribute("MenuCanvasWidth", widgetWidth)
				if totalMenuWidth < widgetWidth then
					widgetWidth = totalMenuWidth
				end
			end

			local style = Enum.EasingStyle.Quint
			local direction = Enum.EasingDirection.Out
			local spotWidthMax = math.max(spotWidth, getItemWidth(iconSpot), iconSpot.AbsoluteSize.X)
			local widgetWidthMax = math.max(widgetWidth, getItemWidth(widget), widget.AbsoluteSize.X)
			local SPEED = 750
			-- The first size once the icon is laid out on screen snaps into place instead of growing
			local isFirstSizeOnScreen = not hasSizedOnScreen and contents.AbsoluteSize.Y > 0
			if isFirstSizeOnScreen then
				hasSizedOnScreen = true
			end
			local spotTweenInfo = if isFirstSizeOnScreen then TweenInfo.new(0) else Utility.getTweenInfo(TweenInfo.new(spotWidthMax/SPEED, style, direction))
			local widgetTweenInfo = if isFirstSizeOnScreen then TweenInfo.new(0) else Utility.getTweenInfo(TweenInfo.new(widgetWidthMax/SPEED, style, direction))
			TweenService:Create(iconSpot, spotTweenInfo, {
				Position = UDim2.new(0, widgetBorderSize, 0.5, 0),
				Size = UDim2.new(0, spotWidth, 1, -widgetBorderSize*2),
			}):Play()
			TweenService:Create(clickRegion, spotTweenInfo, {
				Size = UDim2.new(0, spotWidth, 1, 0),
			}):Play()
			local newWidgetSize = UDim2.fromOffset(widgetWidth, widgetMinimumHeight)
			local updateInstantly = widget.Size.Y.Offset ~= widgetMinimumHeight
			if updateInstantly then
				widget.Size = newWidgetSize
			end
			widget:SetAttribute("TargetWidth", newWidgetSize.X.Offset)
			local movingTween = TweenService:Create(widget, widgetTweenInfo, {
				Size = newWidgetSize,
			})
			movingTween:Play()
			resizingCount += 1
			for step = 1, math.max(widgetTweenInfo.Time * 100, 1) do
				task.delay(step/100, function()
					Icon.iconChanged:Fire(icon)
				end)
			end
			task.delay(widgetTweenInfo.Time-0.2, function()
				resizingCount -= 1
				task.defer(function()
					if resizingCount == 0 then
						icon.resizingComplete:Fire()
					end
				end)
			end)
			icon:updateParent()
		end)
	end
	local handleLabelAndImageChanges = Utility.createStagger(0.01, handleLabelAndImageChangesUnstaggered)

	-- The first size is worked out before the icon is on screen, when the contents have no height
	-- (so the image counts as 0 wide) and the font may not have loaded. We size again once the real values arrive
	local lastContentsHeight = contents.AbsoluteSize.Y
	contents:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		local contentsHeight = contents.AbsoluteSize.Y
		if contentsHeight ~= lastContentsHeight then
			lastContentsHeight = contentsHeight
			handleLabelAndImageChanges()
		end
	end)
	iconLabel:GetPropertyChangedSignal("TextBounds"):Connect(handleLabelAndImageChanges)
	local firstTimeSettingFontFace = true
	icon:setBehaviour("IconLabel", "Text", handleLabelAndImageChanges)
	icon:setBehaviour("IconLabel", "FontFace", function(value)
		local previousFontFace = iconLabel.FontFace
		if previousFontFace == value then
			return
		end
		task.spawn(function()
			--[[
			local fontLink = value.Family
			if string.match(fontLink, "rbxassetid://") then
				local ContentProvider = game:GetService("ContentProvider")
				local assets = {fontLink}
				ContentProvider:PreloadAsync(assets)
			end--]]

			-- Afaik there's no way to determine when a Font Family has
			-- loaded (even with ContentProvider), so we just have to try
			-- a few times and hope it loads within the refresh period
			handleLabelAndImageChanges()
			if firstTimeSettingFontFace then
				firstTimeSettingFontFace = false
				for i = 1, 10 do
					task.wait(1)
					handleLabelAndImageChanges()
				end
			end
		end)
	end)
	local function updateBorderSize()
		task.defer(function()
			local borderOffset = widget:GetAttribute("BorderSize")
			local alignment = icon.alignment
			local alignmentOffset = (iconSpot.Visible == false and 0) or (alignment == "Right" and -borderOffset) or borderOffset
			menu.Position = UDim2.new(0, alignmentOffset, 0, 0)
			menuGap.Size = UDim2.fromOffset(borderOffset, 0)
			menuUIListLayout.Padding = UDim.new(0, 0)
			handleLabelAndImageChanges()
		end)
	end
	icon:setBehaviour("Widget", "BorderSize", updateBorderSize)
	icon:setBehaviour("IconSpot", "Visible", updateBorderSize)
	icon.startMenuUpdate:Connect(handleLabelAndImageChanges)
	icon.updateSize:Connect(handleLabelAndImageChanges)
	icon:setBehaviour("ContentsList", "HorizontalAlignment", handleLabelAndImageChanges)
	icon:setBehaviour("Widget", "Visible", handleLabelAndImageChanges)
	icon:setBehaviour("Widget", "DesiredWidth", handleLabelAndImageChanges)
	icon:setBehaviour("Widget", "MinimumWidth", handleLabelAndImageChanges)
	icon:setBehaviour("PaddingLeft", "Size", handleLabelAndImageChanges)
	icon:setBehaviour("PaddingCenter", "Size", handleLabelAndImageChanges)
	icon:setBehaviour("PaddingRight", "Size", handleLabelAndImageChanges)
	icon:setBehaviour("Widget", "MinimumHeight", handleLabelAndImageChanges)
	icon:setBehaviour("Indicator", "Visible", handleLabelAndImageChanges)
	icon:setBehaviour("IconImageRatio", "AspectRatio", handleLabelAndImageChanges)
	icon:setBehaviour("IconImage", "Image", function(value)
		local isContent = typeof(value) == "Content"
		local textureId = if isContent then value elseif tonumber(value) then `rbxassetid://{value}` else value or ""
		local currentValue = if isContent then iconImage.ImageContent else iconImage.Image
		if currentValue ~= textureId then
			handleLabelAndImageChanges()
		end
		return textureId
	end)
	icon.alignmentChanged:Connect(function(newAlignment)
		if newAlignment == "Center" then
			newAlignment = "Left"
		end
		menuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[newAlignment]
		updateBorderSize()
	end)

	-- Localization support (refresh icon size whenever player changes language changes in-game)
	local Players = game:GetService("Players")
	local localPlayer = Players.LocalPlayer
	local lastLocaleId = localPlayer.LocaleId
	icon.janitor:add(localPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function()
		task.delay(0.2, function()
			local newLocaleId = localPlayer.LocaleId
			if newLocaleId ~= lastLocaleId then
				lastLocaleId = newLocaleId
				icon:refresh()
				task.wait(0.5)
				icon:refresh()
			end
		end)
	end))
	
	local iconImageScale = Instance.new("NumberValue")
	iconImageScale.Name = "IconImageScale"
	iconImageScale.Parent = iconImage
	iconImageScale:GetPropertyChangedSignal("Value"):Connect(function()
		iconImage.Size = UDim2.new(iconImageScale.Value, 0, iconImageScale.Value, 0)
	end)

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
	UIAspectRatioConstraint.Name = "IconImageRatio"
	UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
	UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
	UIAspectRatioConstraint.Parent = iconImage

	local iconGradient = Instance.new("UIGradient")
	iconGradient.Name = "IconGradient"
	iconGradient.Enabled = true
	iconGradient.Parent = button

	local iconSpotGradient = Instance.new("UIGradient")
	iconSpotGradient.Name = "IconSpotGradient"
	iconSpotGradient.Enabled = true
	iconSpotGradient.Parent = iconSpot

	return widget
end

]=]

 

return function(u1, u2) -- Line: 6
    local Frame = Instance.new("Frame");
    Frame:SetAttribute("WidgetUID", u1.UID);
    Frame.Name = "Widget";
    Frame.BackgroundTransparency = 1;
    Frame.Visible = true;
    Frame.ZIndex = 20;
    Frame.Active = false;
    Frame.ClipsDescendants = true;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "IconButton";
    Frame2.Visible = true;
    Frame2.ZIndex = 2;
    Frame2.BorderSizePixel = 0;
    Frame2.Parent = Frame;
    Frame2.ClipsDescendants = true;
    Frame2.Active = false;
    u1.deselected:Connect(function() -- Line: 25
        -- upvalues: Frame2 (copy), u1 (copy)
        Frame2.ClipsDescendants = true;
        task.delay(0.2, function() -- Line: 27
            -- upvalues: u1 (ref), Frame2 (ref)
            if u1.isSelected then
                Frame2.ClipsDescendants = false;
            end;
        end);
    end);
    local GuiService = game:GetService("GuiService");
    u1:setBehaviour("IconButton", "BackgroundTransparency", function(p3) -- Line: 36
        -- upvalues: GuiService (copy)
        if p3 == 1 then
            return p3;
        end;

        return p3 * GuiService.PreferredTransparency;
    end);
    u1.janitor:add(GuiService:GetPropertyChangedSignal("PreferredTransparency"):Connect(function() -- Line: 44
        -- upvalues: u1 (copy), Frame2 (copy)
        u1:refreshAppearance(Frame2, "BackgroundTransparency");
    end));
    local UICorner = Instance.new("UICorner");
    UICorner:SetAttribute("Collective", "IconCorners");
    UICorner.Name = "UICorner";
    UICorner.Parent = Frame2;
    local u4 = require(script.Parent.Menu)(u1);
    local MenuUIListLayout = u4.MenuUIListLayout;
    local MenuGap = u4.MenuGap;
    u4.Parent = Frame2;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "IconSpot";
    Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225);
    Frame3.BackgroundTransparency = 0.9;
    Frame3.Visible = true;
    Frame3.AnchorPoint = Vector2.new(0, 0.5);
    Frame3.ZIndex = 5;
    Frame3.Parent = u4;
    UICorner:Clone().Parent = Frame3;
    local v5 = Frame3:Clone();
    v5.UICorner.Name = "OverlayUICorner";
    v5.Name = "IconOverlay";
    v5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    v5.ZIndex = Frame3.ZIndex + 1;
    v5.Size = UDim2.new(1, 0, 1, 0);
    v5.Position = UDim2.new(0, 0, 0, 0);
    v5.AnchorPoint = Vector2.new(0, 0);
    v5.Visible = false;
    v5.Parent = Frame3;
    local TextButton = Instance.new("TextButton");
    TextButton:SetAttribute("CorrespondingIconUID", u1.UID);
    TextButton.Name = "ClickRegion";
    TextButton.BackgroundTransparency = 1;
    TextButton.Visible = true;
    TextButton.Text = "";
    TextButton.ZIndex = 20;
    TextButton.Selectable = true;
    TextButton.SelectionGroup = true;
    TextButton.Parent = Frame3;
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton);
    UICorner:Clone().Parent = TextButton;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "Contents";
    Frame4.BackgroundTransparency = 1;
    Frame4.Size = UDim2.fromScale(1, 1);
    Frame4.Parent = Frame3;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "ContentsList";
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
    UIListLayout.Padding = UDim.new(0, 3);
    UIListLayout.Parent = Frame4;
    local Frame5 = Instance.new("Frame");
    Frame5.Name = "PaddingLeft";
    Frame5.LayoutOrder = 1;
    Frame5.ZIndex = 5;
    Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame5.BackgroundTransparency = 1;
    Frame5.BorderSizePixel = 0;
    Frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame5.Parent = Frame4;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "PaddingCenter";
    Frame6.LayoutOrder = 3;
    Frame6.ZIndex = 5;
    Frame6.Size = UDim2.new(0, 0, 1, 0);
    Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame6.BackgroundTransparency = 1;
    Frame6.BorderSizePixel = 0;
    Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame6.Parent = Frame4;
    local Frame7 = Instance.new("Frame");
    Frame7.Name = "PaddingRight";
    Frame7.LayoutOrder = 5;
    Frame7.ZIndex = 5;
    Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame7.BackgroundTransparency = 1;
    Frame7.BorderSizePixel = 0;
    Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame7.Parent = Frame4;
    local Frame8 = Instance.new("Frame");
    Frame8.Name = "IconLabelContainer";
    Frame8.LayoutOrder = 4;
    Frame8.ZIndex = 3;
    Frame8.AnchorPoint = Vector2.new(0, 0.5);
    Frame8.Size = UDim2.new(0, 0, 0.5, 0);
    Frame8.BackgroundTransparency = 1;
    Frame8.Position = UDim2.new(0.5, 0, 0.5, 0);
    Frame8.Parent = Frame4;
    local TextLabel = Instance.new("TextLabel");
    local u6 = workspace.CurrentCamera.ViewportSize.X + 200;
    TextLabel.Name = "IconLabel";
    TextLabel.LayoutOrder = 4;
    TextLabel.ZIndex = 15;
    TextLabel.AnchorPoint = Vector2.new(0, 0);
    TextLabel.Size = UDim2.new(0, u6, 1, 0);
    TextLabel.ClipsDescendants = false;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.fromScale(0, 0);
    TextLabel.RichText = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Text = "";
    TextLabel.TextWrapped = true;
    TextLabel.TextWrap = true;
    TextLabel.TextScaled = false;
    TextLabel.Active = false;
    TextLabel.AutoLocalize = true;
    TextLabel.Parent = Frame8;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "IconImage";
    ImageLabel.LayoutOrder = 2;
    ImageLabel.ZIndex = 15;
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0);
    ImageLabel.ScaleType = Enum.ScaleType.Stretch;
    ImageLabel.Active = false;
    ImageLabel.Parent = Frame4;
    local v7 = UICorner:Clone();
    v7:SetAttribute("Collective", nil);
    v7.CornerRadius = UDim.new(0, 0);
    v7.Name = "IconImageCorner";
    v7.Parent = ImageLabel;
    local TweenService = game:GetService("TweenService");
    local u8 = 0;

    local function handleLabelAndImageChangesUnstaggered(p9) -- Line: 195
        -- upvalues: u1 (copy), TextLabel (copy), ImageLabel (copy), Frame8 (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame2 (copy), UIListLayout (copy), Frame4 (copy), Frame (copy), u6 (copy), u4 (copy), Frame3 (copy), MenuUIListLayout (copy), MenuGap (copy), TweenService (copy), TextButton (copy), u8 (ref), u2 (copy)
        task.defer(function() -- Line: 202
            -- upvalues: u1 (ref), TextLabel (ref), ImageLabel (ref), Frame8 (ref), Frame5 (ref), Frame6 (ref), Frame7 (ref), Frame2 (ref), UIListLayout (ref), Frame4 (ref), Frame (ref), u6 (ref), u4 (ref), Frame3 (ref), MenuUIListLayout (ref), MenuGap (ref), TweenService (ref), TextButton (ref), u8 (ref), u2 (ref)
            local indicator = u1.indicator;

            if indicator then
                indicator = indicator.Visible;
            end;

            local v10 = indicator or TextLabel.Text ~= "";
            local v11;

            if ImageLabel.Image == "" then
                v11 = false;
            else
                v11 = ImageLabel.Image ~= nil;
            end;

            local _ = Enum.HorizontalAlignment.Center;
            local UDim2_fromScale_ret = UDim2.fromScale(1, 1);

            if v11 and not v10 then
                Frame8.Visible = false;
                ImageLabel.Visible = true;
                Frame5.Visible = false;
                Frame6.Visible = false;
                Frame7.Visible = false;
            elseif v11 or not v10 then
                if v11 and v10 then
                    Frame8.Visible = true;
                    ImageLabel.Visible = true;
                    Frame5.Visible = true;
                    Frame6.Visible = not indicator;
                    Frame7.Visible = not indicator;
                    local _ = Enum.HorizontalAlignment.Left;
                end;
            else
                Frame8.Visible = true;
                ImageLabel.Visible = false;
                Frame5.Visible = true;
                Frame6.Visible = false;
                Frame7.Visible = true;
            end;

            Frame2.Size = UDim2_fromScale_ret;

            local function getItemWidth(p12) -- Line: 232
                return p12:GetAttribute("TargetWidth") or p12.AbsoluteSize.X;
            end;

            local Offset = UIListLayout.Padding.Offset;
            Frame8.Size = UDim2.new(0, TextLabel.TextBounds.X, TextLabel.Size.Y.Scale, 0);
            local v13 = Offset;

            for _, child in pairs(Frame4:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v13 = v13 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + Offset);
                end;
            end;

            local Attribute = Frame:GetAttribute("MinimumWidth");
            local Attribute2 = Frame:GetAttribute("MinimumHeight");
            local Attribute3 = Frame:GetAttribute("BorderSize");
            local math_clamp_ret = math.clamp(v13, Attribute, u6);
            local v14 = 0;
            local v15 = #u1.menuIcons > 0 and u1.isSelected;

            if v15 then
                for _, child in pairs(u4:GetChildren()) do
                    if child ~= Frame3 and (child:IsA("GuiObject") and child.Visible) then
                        v14 = v14 + ((child:GetAttribute("TargetWidth") or child.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset);
                    end;
                end;

                if not Frame3.Visible then
                    local v16 = Frame3;
                    math_clamp_ret = math_clamp_ret - ((v16:GetAttribute("TargetWidth") or v16.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + Attribute3);
                end;

                v14 = v14 - Attribute3 * 0.5;
                math_clamp_ret = math_clamp_ret + (v14 - Attribute3 * 0.75);
            end;

            if v15 then
                v15 = Frame3.Visible;
            end;

            MenuGap.Visible = v15;
            local Attribute4 = Frame:GetAttribute("DesiredWidth");

            if Attribute4 then
                if math_clamp_ret >= Attribute4 then
                    Attribute4 = math_clamp_ret;
                end;
            else
                Attribute4 = math_clamp_ret;
            end;

            u1.updateMenu:Fire();
            local v17 = math.max(Attribute4 - v14, Attribute) - Attribute3 * 2;
            local Attribute5 = u4:GetAttribute("MenuWidth");

            if Attribute5 then
                Attribute5 = Attribute5 + v17 + MenuUIListLayout.Padding.Offset + 10;
            end;

            if Attribute5 then
                local Attribute6 = u4:GetAttribute("MaxWidth");

                if Attribute6 then
                    Attribute5 = math.max(Attribute6, Attribute);
                end;

                u4:SetAttribute("MenuCanvasWidth", Attribute4);

                if Attribute5 >= Attribute4 then
                    Attribute5 = Attribute4;
                end;
            else
                Attribute5 = Attribute4;
            end;

            local Quint = Enum.EasingStyle.Quint;
            local Out = Enum.EasingDirection.Out;
            local v18 = Frame3;
            local v19 = v18:GetAttribute("TargetWidth") or v18.AbsoluteSize.X;
            local math_max_ret = math.max(v17, v19, Frame3.AbsoluteSize.X);
            local v20 = Frame;
            local v21 = v20:GetAttribute("TargetWidth") or v20.AbsoluteSize.X;
            local math_max_ret2 = math.max(Attribute5, v21, Frame.AbsoluteSize.X);
            local TweenInfo_new_ret = TweenInfo.new(math_max_ret / 750, Quint, Out);
            local TweenInfo_new_ret2 = TweenInfo.new(math_max_ret2 / 750, Quint, Out);
            TweenService:Create(Frame3, TweenInfo_new_ret, {
                Position = UDim2.new(0, Attribute3, 0.5, 0),
                Size = UDim2.new(0, v17, 1, -Attribute3 * 2)
            }):Play();
            TweenService:Create(TextButton, TweenInfo_new_ret, {
                Size = UDim2.new(0, v17, 1, 0)
            }):Play();
            local UDim2_fromOffset_ret = UDim2.fromOffset(Attribute5, Attribute2);

            if Frame.Size.Y.Offset ~= Attribute2 then
                Frame.Size = UDim2_fromOffset_ret;
            end;

            Frame:SetAttribute("TargetWidth", UDim2_fromOffset_ret.X.Offset);
            TweenService:Create(Frame, TweenInfo_new_ret2, {
                Size = UDim2_fromOffset_ret
            }):Play();
            u8 = u8 + 1;

            for i = 1, TweenInfo_new_ret2.Time * 100 do
                task.delay(i / 100, function() -- Line: 314
                    -- upvalues: u2 (ref), u1 (ref)
                    u2.iconChanged:Fire(u1);
                end);
                local _ = i;
            end;

            task.delay(TweenInfo_new_ret2.Time - 0.2, function() -- Line: 318
                -- upvalues: u8 (ref), u1 (ref)
                u8 = u8 - 1;
                task.defer(function() -- Line: 320
                    -- upvalues: u8 (ref), u1 (ref)
                    if u8 == 0 then
                        u1.resizingComplete:Fire();
                    end;
                end);
            end);
            u1:updateParent();
        end);
    end;

    local u22 = require(script.Parent.Parent.Utility).createStagger(0.01, handleLabelAndImageChangesUnstaggered);
    local u23 = true;
    u1:setBehaviour("IconLabel", "Text", u22);
    u1:setBehaviour("IconLabel", "FontFace", function(p24) -- Line: 333
        -- upvalues: TextLabel (copy), u22 (copy), u23 (ref)
        if TextLabel.FontFace == p24 then
            return;
        end;

        task.spawn(function() -- Line: 338
            -- upvalues: u22 (ref), u23 (ref)
            u22();

            if u23 then
                u23 = false;

                for i = 1, 10 do
                    task.wait(1);
                    u22();
                    local _ = i;
                end;
            end;
        end);
    end);

    local function updateBorderSize() -- Line: 360
        -- upvalues: Frame (copy), u1 (copy), Frame3 (copy), u4 (copy), MenuGap (copy), MenuUIListLayout (copy), u22 (copy)
        task.defer(function() -- Line: 361
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u4 (ref), MenuGap (ref), MenuUIListLayout (ref), u22 (ref)
            local Attribute = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v25;

            if Frame3.Visible == false then
                v25 = 0;
            elseif alignment == "Right" then
                v25 = -Attribute or Attribute;
            else
                v25 = Attribute;
            end;

            u4.Position = UDim2.new(0, v25, 0, 0);
            MenuGap.Size = UDim2.fromOffset(Attribute, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u22();
        end);
    end;

    u1:setBehaviour("Widget", "BorderSize", updateBorderSize);
    u1:setBehaviour("IconSpot", "Visible", updateBorderSize);
    u1.startMenuUpdate:Connect(u22);
    u1.updateSize:Connect(u22);
    u1:setBehaviour("ContentsList", "HorizontalAlignment", u22);
    u1:setBehaviour("Widget", "Visible", u22);
    u1:setBehaviour("Widget", "DesiredWidth", u22);
    u1:setBehaviour("Widget", "MinimumWidth", u22);
    u1:setBehaviour("Widget", "MinimumHeight", u22);
    u1:setBehaviour("Indicator", "Visible", u22);
    u1:setBehaviour("IconImageRatio", "AspectRatio", u22);
    u1:setBehaviour("IconImage", "Image", function(p26) -- Line: 382
        -- upvalues: ImageLabel (copy), u22 (copy)
        local v27 = tonumber(p26) and "http://www.roblox.com/asset/?id=" .. p26 or (p26 or "");

        if ImageLabel.Image ~= v27 then
            u22();
        end;

        return v27;
    end);
    u1.alignmentChanged:Connect(function(p28) -- Line: 389
        -- upvalues: MenuUIListLayout (copy), Frame (copy), u1 (copy), Frame3 (copy), u4 (copy), MenuGap (copy), u22 (copy)
        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[p28 == "Center" and "Left" or p28];
        task.defer(function() -- Line: 361
            -- upvalues: Frame (ref), u1 (ref), Frame3 (ref), u4 (ref), MenuGap (ref), MenuUIListLayout (ref), u22 (ref)
            local Attribute = Frame:GetAttribute("BorderSize");
            local alignment = u1.alignment;
            local v29;

            if Frame3.Visible == false then
                v29 = 0;
            elseif alignment == "Right" then
                v29 = -Attribute or Attribute;
            else
                v29 = Attribute;
            end;

            u4.Position = UDim2.new(0, v29, 0, 0);
            MenuGap.Size = UDim2.fromOffset(Attribute, 0);
            MenuUIListLayout.Padding = UDim.new(0, 0);
            u22();
        end);
    end);
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local LocaleId = LocalPlayer.LocaleId;
    u1.janitor:add(LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(function() -- Line: 401
        -- upvalues: LocalPlayer (copy), LocaleId (ref), u1 (copy)
        task.delay(0.2, function() -- Line: 402
            -- upvalues: LocalPlayer (ref), LocaleId (ref), u1 (ref)
            local LocaleId2 = LocalPlayer.LocaleId;

            if LocaleId2 ~= LocaleId then
                LocaleId = LocaleId2;
                u1:refresh();
                task.wait(0.5);
                u1:refresh();
            end;
        end);
    end));
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Name = "IconImageScale";
    NumberValue.Parent = ImageLabel;
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 416
        -- upvalues: ImageLabel (copy), NumberValue (copy)
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0);
    end);
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
    UIAspectRatioConstraint.Name = "IconImageRatio";
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize;
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height;
    UIAspectRatioConstraint.Parent = ImageLabel;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Name = "IconGradient";
    UIGradient.Enabled = true;
    UIGradient.Parent = Frame2;
    local UIGradient2 = Instance.new("UIGradient");
    UIGradient2.Name = "IconSpotGradient";
    UIGradient2.Enabled = true;
    UIGradient2.Parent = Frame3;

    return Frame;
end;
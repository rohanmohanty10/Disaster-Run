 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
local Utility = require(script.Parent.Parent.Utility)
local CAPTION_COLOR = Color3.fromRGB(39, 41, 48)
local TEXT_SIZE = 15
return function(icon)

	-- Credit to lolmansReturn and Canary Software for
	-- retrieving these values
	local clickRegion = icon:getInstance("ClickRegion")
	local caption = Instance.new("CanvasGroup")
	caption.Name = "Caption"
	caption.AnchorPoint = Vector2.new(0.5, 0)
	caption.BackgroundTransparency = 1
	caption.BorderSizePixel = 0
	caption.GroupTransparency = 1
	caption.Position = UDim2.fromOffset(0, 0)
	caption.Visible = true
	caption.ZIndex = 30
	caption.Parent = clickRegion

	local box = Instance.new("Frame")
	box.Name = "Box"
	box.AutomaticSize = Enum.AutomaticSize.XY
	box.BackgroundColor3 = CAPTION_COLOR
	box.Position = UDim2.fromOffset(4, 7)
	box.ZIndex = 12
	box.Parent = caption

	local header = Instance.new("TextLabel")
	header.Name = "Header"
	header.FontFace = Font.new(
		"rbxasset://fonts/families/BuilderSans.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	header.Text = "Caption"
	header.TextColor3 = Color3.fromRGB(247, 247, 248)
	header.TextSize = TEXT_SIZE
	header.TextTruncate = Enum.TextTruncate.None
	header.TextWrapped = false
	header.AutomaticSize = Enum.AutomaticSize.X
	header.BackgroundTransparency = 1
	header.LayoutOrder = 1
	header.Size = UDim2.fromOffset(0, 16)
	header.ZIndex = 18
	header.Parent = box

	local layout = Instance.new("UIListLayout")
	layout.Name = "Layout"
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Parent = box

	local UICorner = Instance.new("UICorner")
	UICorner.Name = "CaptionCorner"
	UICorner.Parent = box

	local padding = Instance.new("UIPadding")
	padding.Name = "Padding"
	padding.PaddingBottom = UDim.new(0, 12)
	padding.PaddingLeft = UDim.new(0, 12)
	padding.PaddingRight = UDim.new(0, 12)
	padding.PaddingTop = UDim.new(0, 12)
	padding.Parent = box

	local hotkeys = Instance.new("Frame")
	hotkeys.Name = "Hotkeys"
	hotkeys.AutomaticSize = Enum.AutomaticSize.Y
	hotkeys.BackgroundTransparency = 1
	hotkeys.LayoutOrder = 3
	hotkeys.Size = UDim2.fromScale(1, 0)
	hotkeys.Visible = false
	hotkeys.Parent = box

	local layout1 = Instance.new("UIListLayout")
	layout1.Name = "Layout1"
	layout1.Padding = UDim.new(0, 6)
	layout1.FillDirection = Enum.FillDirection.Vertical
	layout1.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout1.HorizontalFlex = Enum.UIFlexAlignment.None
	layout1.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
	layout1.VerticalFlex = Enum.UIFlexAlignment.None
	layout1.SortOrder = Enum.SortOrder.LayoutOrder
	layout1.Parent = hotkeys

	local keyTag1 = Instance.new("ImageLabel")
	keyTag1.Name = "Key1"
	keyTag1.Image = "rbxasset://textures/ui/Controls/key_single.png"
	keyTag1.ImageTransparency = 0.7
	keyTag1.ScaleType = Enum.ScaleType.Slice
	keyTag1.SliceCenter = Rect.new(5, 5, 23, 24)
	keyTag1.AutomaticSize = Enum.AutomaticSize.X
	keyTag1.BackgroundTransparency = 1
	keyTag1.LayoutOrder = 1
	keyTag1.Size = UDim2.fromOffset(0, 30)
	keyTag1.ZIndex = 15
	keyTag1.Parent = hotkeys

	local inset = Instance.new("UIPadding")
	inset.Name = "Inset"
	inset.PaddingLeft = UDim.new(0, 8)
	inset.PaddingRight = UDim.new(0, 8)
	inset.Parent = keyTag1

	local labelContent = Instance.new("TextLabel")
	labelContent.AutoLocalize = false
	labelContent.Name = "LabelContent"
	labelContent.FontFace = Font.new(
		"rbxasset://fonts/families/GothamSSm.json",
		Enum.FontWeight.Medium,
		Enum.FontStyle.Normal
	)
	labelContent.Text = ""
	labelContent.TextColor3 = Color3.fromRGB(189, 190, 190)
	labelContent.TextSize = TEXT_SIZE
	labelContent.AutomaticSize = Enum.AutomaticSize.X
	labelContent.BackgroundTransparency = 1
	labelContent.Position = UDim2.fromOffset(0, -1)
	labelContent.Size = UDim2.fromScale(1, 1)
	labelContent.ZIndex = 16
	labelContent.Parent = keyTag1
	
	local caret = Instance.new("ImageLabel")
	caret.Name = "Caret"
	caret.Image = "rbxassetid://101906294438076"
	caret.ImageColor3 = CAPTION_COLOR
	caret.AnchorPoint = Vector2.new(0, 0.5)
	caret.BackgroundTransparency = 1
	caret.Position = UDim2.new(0, 0, 0, 4)
	caret.Size = UDim2.fromOffset(16, 8)
	caret.ZIndex = 12
	caret.Parent = caption

	local dropShadow = Instance.new("ImageLabel")
	dropShadow.Visible = true
	dropShadow.Name = "DropShadow"
	dropShadow.Image = "rbxassetid://124920646932671"
	dropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	dropShadow.ImageTransparency = 0.5
	dropShadow.ScaleType = Enum.ScaleType.Slice
	dropShadow.SliceCenter = Rect.new(12, 12, 13, 13)
	dropShadow.BackgroundTransparency = 1
	dropShadow.Position = UDim2.fromOffset(0, 5)
	dropShadow.Size = UDim2.fromOffset(0, 48)
	dropShadow.Parent = caption
	box:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		-- Offset sized so the shadow overhangs the box by 4 on both sides, which also
		-- widens the caption evenly so the box stays centred under the icon
		dropShadow.Size = UDim2.fromOffset(box.AbsoluteSize.X + 8, box.AbsoluteSize.Y + 8)
	end)
	
	-- It's important we match the sizes as this is not
	-- handles within clipOutside (as it assumes the sizes
	-- are already the same)
	local captionJanitor = icon.captionJanitor
	local _, captionClone = icon:clipOutside(caption)
	captionClone.AutomaticSize = Enum.AutomaticSize.None
	local function matchSize()
		local absolute = caption.AbsoluteSize
		captionClone.Size = UDim2.fromOffset(absolute.X, absolute.Y)
	end
	captionJanitor:add(caption:GetPropertyChangedSignal("AbsoluteSize"):Connect(matchSize))
	matchSize()
	
	
	
	-- This handles the appearing/disappearing/positioning of the caption
	local isCompletelyEnabled = false
	local captionHeader = caption.Box.Header
	local UserInputService = game:GetService("UserInputService")
	local function updateHotkey(keyCodeEnum)
		local hasKeyboard = UserInputService.KeyboardEnabled
		local text = caption:GetAttribute("CaptionText") or ""
		local hideHeader = text == "_hotkey_"
		if not hasKeyboard and hideHeader then
			icon:setCaption()
			return
		end
		captionHeader.Text = text
		captionHeader.Visible = not hideHeader
		if keyCodeEnum then
			labelContent.Text = keyCodeEnum.Name
			hotkeys.Visible = true
		end
		if not hasKeyboard then
			hotkeys.Visible = false
		end
	end
	caption:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey)

	local EASING_STYLE = Enum.EasingStyle.Quad
	local TWEEN_SPEED = 0.2
	local TWEEN_INFO_IN = TweenInfo.new(TWEEN_SPEED, EASING_STYLE, Enum.EasingDirection.In)
	local TWEEN_INFO_OUT = TweenInfo.new(TWEEN_SPEED, EASING_STYLE, Enum.EasingDirection.Out)
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local function getCaptionPosition(customEnabled)
		local enabled = if customEnabled ~= nil then customEnabled else isCompletelyEnabled
		local yOut = -3
		local yIn = yOut + 8
		local yOffset = if enabled then yIn else yOut
		return UDim2.new(0.5, 0, 1, yOffset)
	end
	local function updatePosition(forcedEnabled)
		
		-- Ignore changes if not enabled to reduce redundant calls
		if not isCompletelyEnabled then
			return
		end
		
		-- Currently the one thing which isn't accounted for are the bounds of the screen
		-- This would be an issue if someone sets a long caption text for the left or
		-- right most icon
		local enabled = if forcedEnabled ~= nil then forcedEnabled else isCompletelyEnabled
		local startPosition = getCaptionPosition(not enabled)
		local endPosition = getCaptionPosition(enabled)
		
		-- It's essential we reset the carets position to prevent the x sizing bounds
		-- of the caption from infinitely scaling up
		if enabled then
			local caretY = caret.Position.Y.Offset
			caret.Position = UDim2.fromOffset(0, caretY)
			caption.AutomaticSize = Enum.AutomaticSize.XY
			caption.Size = UDim2.fromOffset(32, 53)
		else
			local absolute = caption.AbsoluteSize
			caption.AutomaticSize = Enum.AutomaticSize.Y
			caption.Size = UDim2.fromOffset(absolute.X, absolute.Y)
		end
		
		-- We initially default to the opposite state
		local previousCaretX
		local function updateCaret()
			local caretX = clickRegion.AbsolutePosition.X - caption.AbsolutePosition.X + clickRegion.AbsoluteSize.X/2 - caret.AbsoluteSize.X/2
			local caretY = caret.Position.Y.Offset
			local newCaretPosition = UDim2.fromOffset(caretX, caretY)
			if previousCaretX ~= caretX then
				-- Again, it's essential we reset the caret if
				-- a difference in X position is detected otherwise
				-- a slight quirk with AutomaticCanvas can cause
				-- the caption to infinitely scale
				previousCaretX = caretX
				caret.Position = UDim2.fromOffset(0, caretY)
				task.wait()
			end
			caret.Position = newCaretPosition
		end
		captionClone.Position = startPosition
		updateCaret()
		
		-- Now we tween into the new state
		local tweenInfo = (enabled and TWEEN_INFO_IN) or TWEEN_INFO_OUT
		local tween = TweenService:Create(captionClone, Utility.getTweenInfo(tweenInfo), {Position = endPosition})
		local updateCaretConnection = RunService.Heartbeat:Connect(updateCaret)
		tween:Play()
		tween.Completed:Once(function()
			updateCaretConnection:Disconnect()
		end)
		
	end
	captionJanitor:add(clickRegion:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		updatePosition()
	end))
	updatePosition(false)
	
	captionJanitor:add(icon.toggleKeyAdded:Connect(updateHotkey))
	for keyCodeEnum, _ in pairs(icon.bindedToggleKeys) do
		updateHotkey(keyCodeEnum)
		break
	end
	captionJanitor:add(icon.fakeToggleKeyChanged:Connect(updateHotkey))
	local fakeToggleKey = icon.fakeToggleKey
	if fakeToggleKey then
		updateHotkey(fakeToggleKey)
	end

	local function setCaptionEnabled(enabled)
		if isCompletelyEnabled == enabled then
			return
		end
		local joinedFrame = icon.joinedFrame
		if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
			enabled = false
		end
		isCompletelyEnabled = enabled
		local newTransparency = (enabled and 0) or 1
		local tweenInfo = (enabled and TWEEN_INFO_IN) or TWEEN_INFO_OUT
		-- The fade stays even with Reduce Motion on, the same as Roblox's own captions. Only the slide is skipped
		local tweenTransparency = TweenService:Create(caption, tweenInfo, {
			GroupTransparency = newTransparency
		})
		-- A fully faded CanvasGroup can still draw as a white box on some phones,
		-- so we stop showing it at all once it's gone
		if enabled then
			Utility.setVisible(caption, true, "CaptionFade")
		else
			tweenTransparency.Completed:Once(function()
				if not isCompletelyEnabled then
					Utility.setVisible(caption, false, "CaptionFade")
				end
			end)
		end
		tweenTransparency:Play()
		if enabled then
			captionClone:SetAttribute("ForceUpdate", true)
		end
		updatePosition()
		updateHotkey()
	end
	
	Utility.setVisible(caption, false, "CaptionFade")

	local WAIT_DURATION = 0.5
	local RECOVER_PERIOD = 0.3
	local Icon = require(icon.iconModule)
	captionJanitor:add(icon.stateChanged:Connect(function(stateName)
		if stateName == "Viewing" then
			local lastClock = Icon.captionLastClosedClock
			local clockDifference = (lastClock and os.clock() - lastClock) or 999
			local waitDuration = (clockDifference < RECOVER_PERIOD and 0) or WAIT_DURATION
			task.delay(waitDuration, function()
				if icon.activeState == "Viewing" then
					setCaptionEnabled(true)
				end
			end)
		else
			Icon.captionLastClosedClock = os.clock()
			setCaptionEnabled(false)
		end
	end))
	
	return caption
end

]]

 

local Color3_fromRGB_ret = Color3.fromRGB(39, 41, 48);

return function(u1) -- Line: 3
    -- upvalues: Color3_fromRGB_ret (copy)
    local Instance2 = u1:getInstance("ClickRegion");
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Name = "Caption";
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.BorderSizePixel = 0;
    CanvasGroup.GroupTransparency = 1;
    CanvasGroup.Position = UDim2.fromOffset(0, 0);
    CanvasGroup.Visible = true;
    CanvasGroup.ZIndex = 30;
    CanvasGroup.Parent = Instance2;
    local Frame = Instance.new("Frame");
    Frame.Name = "Box";
    Frame.AutomaticSize = Enum.AutomaticSize.XY;
    Frame.BackgroundColor3 = Color3_fromRGB_ret;
    Frame.Position = UDim2.fromOffset(4, 7);
    Frame.ZIndex = 12;
    Frame.Parent = CanvasGroup;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Header";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel.Text = "Caption";
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
    TextLabel.TextSize = 15;
    TextLabel.TextTruncate = Enum.TextTruncate.None;
    TextLabel.TextWrapped = false;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.LayoutOrder = 1;
    TextLabel.Size = UDim2.fromOffset(0, 16);
    TextLabel.ZIndex = 18;
    TextLabel.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Name = "Layout";
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.Name = "CaptionCorner";
    UICorner.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.Name = "Padding";
    UIPadding.PaddingBottom = UDim.new(0, 12);
    UIPadding.PaddingLeft = UDim.new(0, 12);
    UIPadding.PaddingRight = UDim.new(0, 12);
    UIPadding.PaddingTop = UDim.new(0, 12);
    UIPadding.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "Hotkeys";
    Frame2.AutomaticSize = Enum.AutomaticSize.Y;
    Frame2.BackgroundTransparency = 1;
    Frame2.LayoutOrder = 3;
    Frame2.Size = UDim2.fromScale(1, 0);
    Frame2.Visible = false;
    Frame2.Parent = Frame;
    local UIListLayout2 = Instance.new("UIListLayout");
    UIListLayout2.Name = "Layout1";
    UIListLayout2.Padding = UDim.new(0, 6);
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical;
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic;
    UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None;
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout2.Parent = Frame2;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "Key1";
    ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png";
    ImageLabel.ImageTransparency = 0.7;
    ImageLabel.ScaleType = Enum.ScaleType.Slice;
    ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24);
    ImageLabel.AutomaticSize = Enum.AutomaticSize.X;
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.LayoutOrder = 1;
    ImageLabel.Size = UDim2.fromOffset(0, 30);
    ImageLabel.ZIndex = 15;
    ImageLabel.Parent = Frame2;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.Name = "Inset";
    UIPadding2.PaddingLeft = UDim.new(0, 8);
    UIPadding2.PaddingRight = UDim.new(0, 8);
    UIPadding2.Parent = ImageLabel;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AutoLocalize = false;
    TextLabel2.Name = "LabelContent";
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal);
    TextLabel2.Text = "";
    TextLabel2.TextColor3 = Color3.fromRGB(189, 190, 190);
    TextLabel2.TextSize = 15;
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Position = UDim2.fromOffset(0, -1);
    TextLabel2.Size = UDim2.fromScale(1, 1);
    TextLabel2.ZIndex = 16;
    TextLabel2.Parent = ImageLabel;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.Name = "Caret";
    ImageLabel2.Image = "rbxassetid://101906294438076";
    ImageLabel2.ImageColor3 = Color3_fromRGB_ret;
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Position = UDim2.new(0, 0, 0, 4);
    ImageLabel2.Size = UDim2.fromOffset(16, 8);
    ImageLabel2.ZIndex = 12;
    ImageLabel2.Parent = CanvasGroup;
    local ImageLabel3 = Instance.new("ImageLabel");
    ImageLabel3.Visible = true;
    ImageLabel3.Name = "DropShadow";
    ImageLabel3.Image = "rbxassetid://124920646932671";
    ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0);
    ImageLabel3.ImageTransparency = 0.45;
    ImageLabel3.ScaleType = Enum.ScaleType.Slice;
    ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13);
    ImageLabel3.BackgroundTransparency = 1;
    ImageLabel3.Position = UDim2.fromOffset(0, 5);
    ImageLabel3.Size = UDim2.new(1, 0, 0, 48);
    ImageLabel3.Parent = CanvasGroup;
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 145
        -- upvalues: ImageLabel3 (copy), Frame (copy)
        ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8);
    end);
    local captionJanitor = u1.captionJanitor;
    local _, u2 = u1:clipOutside(CanvasGroup);
    u2.AutomaticSize = Enum.AutomaticSize.None;
    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 155, Name: matchSize
        -- upvalues: CanvasGroup (copy), u2 (copy)
        local AbsoluteSize = CanvasGroup.AbsoluteSize;
        u2.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    end));
    local AbsoluteSize = CanvasGroup.AbsoluteSize;
    u2.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
    local u3 = false;
    local Header = CanvasGroup.Box.Header;
    local UserInputService = game:GetService("UserInputService");

    local function updateHotkey(p4) -- Line: 168
        -- upvalues: UserInputService (copy), CanvasGroup (copy), u1 (copy), Header (copy), TextLabel2 (copy), Frame2 (copy)
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v5 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v6 = v5 == "_hotkey_";

        if not KeyboardEnabled and v6 then
            u1:setCaption();

            return;
        end;

        Header.Text = v5;
        Header.Visible = not v6;

        if p4 then
            TextLabel2.Text = p4.Name;
            Frame2.Visible = true;
        end;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey);
    local Quad = Enum.EasingStyle.Quad;
    local TweenInfo_new_ret = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In);
    local TweenInfo_new_ret2 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out);
    local TweenService = game:GetService("TweenService");
    local RunService = game:GetService("RunService");

    local function getCaptionPosition(p7) -- Line: 194
        -- upvalues: u3 (ref)
        if p7 == nil then
            p7 = u3;
        end;

        return UDim2.new(0.5, 0, 1, p7 and 10 or 2);
    end;

    local function updatePosition(p8) -- Line: 201
        -- upvalues: u3 (ref), ImageLabel2 (copy), CanvasGroup (copy), Instance2 (copy), u2 (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy), RunService (copy)
        if not u3 then
            return;
        end;

        if p8 == nil then
            p8 = u3;
        end;

        local v9 = not p8;

        if v9 == nil then
            v9 = u3;
        end;

        local UDim2_new_ret = UDim2.new(0.5, 0, 1, v9 and 10 or 2);
        local v10;

        if p8 == nil then
            v10 = u3;
        else
            v10 = p8;
        end;

        local UDim2_new_ret2 = UDim2.new(0.5, 0, 1, v10 and 10 or 2);

        if p8 then
            ImageLabel2.Position = UDim2.fromOffset(0, ImageLabel2.Position.Y.Offset);
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY;
            CanvasGroup.Size = UDim2.fromOffset(32, 53);
        else
            local AbsoluteSize2 = CanvasGroup.AbsoluteSize;
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y;
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize2.X, AbsoluteSize2.Y);
        end;

        local u11 = nil;

        local function updateCaret() -- Line: 230
            -- upvalues: Instance2 (ref), CanvasGroup (ref), ImageLabel2 (ref), u11 (ref)
            local v12 = Instance2.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + Instance2.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2;
            local Offset = ImageLabel2.Position.Y.Offset;
            local UDim2_fromOffset_ret = UDim2.fromOffset(v12, Offset);

            if u11 ~= v12 then
                u11 = v12;
                ImageLabel2.Position = UDim2.fromOffset(0, Offset);
                task.wait();
            end;

            ImageLabel2.Position = UDim2_fromOffset_ret;
        end;

        u2.Position = UDim2_new_ret;
        updateCaret();
        local v13 = TweenService:Create(u2, p8 and TweenInfo_new_ret or TweenInfo_new_ret2, {
            Position = UDim2_new_ret2
        });
        local u14 = RunService.Heartbeat:Connect(updateCaret);
        v13:Play();
        v13.Completed:Once(function() -- Line: 253
            -- upvalues: u14 (copy)
            u14:Disconnect();
        end);
    end;

    captionJanitor:add(Instance2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 258
        -- upvalues: updatePosition (copy)
        updatePosition();
    end));
    updatePosition(false);
    captionJanitor:add(u1.toggleKeyAdded:Connect(updateHotkey));

    for i, _ in pairs(u1.bindedToggleKeys) do
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v15 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v16 = v15 == "_hotkey_";

        if KeyboardEnabled or not v16 then
            Header.Text = v15;
            Header.Visible = not v16;

            if i then
                TextLabel2.Text = i.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u1:setCaption();
        end;

        break;
    end;

    captionJanitor:add(u1.fakeToggleKeyChanged:Connect(updateHotkey));
    local fakeToggleKey = u1.fakeToggleKey;

    if fakeToggleKey then
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v17 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v18 = v17 == "_hotkey_";

        if KeyboardEnabled or not v18 then
            Header.Text = v17;
            Header.Visible = not v18;

            if fakeToggleKey then
                TextLabel2.Text = fakeToggleKey.Name;
                Frame2.Visible = true;
            end;

            if not KeyboardEnabled then
                Frame2.Visible = false;
            end;
        else
            u1:setCaption();
        end;
    end;

    local function setCaptionEnabled(p19) -- Line: 274
        -- upvalues: u3 (ref), u1 (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenService (copy), CanvasGroup (copy), u2 (copy), updatePosition (copy), UserInputService (copy), Header (copy), Frame2 (copy)
        if u3 == p19 then
            return;
        end;

        local joinedFrame = u1.joinedFrame;

        if joinedFrame and string.match(joinedFrame.Name, "Dropdown") then
            p19 = false;
        end;

        u3 = p19;
        TweenService:Create(CanvasGroup, p19 and TweenInfo_new_ret or TweenInfo_new_ret2, {
            GroupTransparency = p19 and 0 or 1
        }):Play();

        if p19 then
            u2:SetAttribute("ForceUpdate", true);
        end;

        updatePosition();
        local KeyboardEnabled = UserInputService.KeyboardEnabled;
        local v20 = CanvasGroup:GetAttribute("CaptionText") or "";
        local v21 = v20 == "_hotkey_";

        if not KeyboardEnabled and v21 then
            u1:setCaption();

            return;
        end;

        Header.Text = v20;
        Header.Visible = not v21;

        if not KeyboardEnabled then
            Frame2.Visible = false;
        end;
    end;

    local iconModule = require(u1.iconModule);
    captionJanitor:add(u1.stateChanged:Connect(function(p22) -- Line: 299
        -- upvalues: iconModule (copy), u1 (copy), setCaptionEnabled (copy)
        if p22 ~= "Viewing" then
            iconModule.captionLastClosedClock = os.clock();
            setCaptionEnabled(false);

            return;
        end;

        local captionLastClosedClock = iconModule.captionLastClosedClock;
        local v23 = (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3 and 0 or 0.5;
        task.delay(v23, function() -- Line: 304
            -- upvalues: u1 (ref), setCaptionEnabled (ref)
            if u1.activeState == "Viewing" then
                setCaptionEnabled(true);
            end;
        end);
    end));

    return CanvasGroup;
end;
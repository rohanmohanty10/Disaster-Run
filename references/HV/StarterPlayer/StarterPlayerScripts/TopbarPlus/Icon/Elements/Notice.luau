 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
return function(icon, Icon)

	local notice = Instance.new("Frame")
	notice.Name = "Notice"
	notice.ZIndex = 25
	notice.AutomaticSize = Enum.AutomaticSize.X
	notice.BorderColor3 = Color3.fromRGB(0, 0, 0)
	notice.BorderSizePixel = 0
	notice.BackgroundTransparency = 0.1
	notice.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	notice.Visible = false
	notice.Parent = icon.widget

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = notice

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Parent = notice

	local noticeLabel = Instance.new("TextLabel")
	noticeLabel.Name = "NoticeLabel"
	noticeLabel.ZIndex = 26
	noticeLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	noticeLabel.AutomaticSize = Enum.AutomaticSize.X
	noticeLabel.Size = UDim2.new(1, 0, 1, 0)
	noticeLabel.BackgroundTransparency = 1
	noticeLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
	noticeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	noticeLabel.TextSize = 14
	noticeLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	noticeLabel.Text = "1"
	noticeLabel.TextWrapped = true
	noticeLabel.Font = Enum.Font.Arial
	noticeLabel.Parent = notice
	
	local iconModule = script.Parent.Parent
	local packages = iconModule.Packages
	local Janitor = require(packages.Janitor)
	local Signal = require(packages.GoodSignal)
	local Utility = require(iconModule.Utility)
	icon.noticeChanged:Connect(function(totalNotices)

		-- Notice amount
		if not totalNotices then
			return
		end
		local exceeded99 = totalNotices > 99
		local customLabel = icon.noticeLabelText
		local noticeDisplay = customLabel or (exceeded99 and "99+") or totalNotices
		noticeLabel.Text = noticeDisplay
		if exceeded99 and not customLabel then
			noticeLabel.TextSize = 11
		end

		-- Should enable
		local enabled = true
		if totalNotices < 1 then
			enabled = false
		end
		local parentIcon = Icon.getIconByUID(icon.parentIconUID)
		local dropdownOrMenuActive = #icon.dropdownIcons > 0 or #icon.menuIcons > 0
		if icon.isSelected and dropdownOrMenuActive then
			enabled = false
		elseif parentIcon and not parentIcon.isSelected then
			enabled = false
		end
		Utility.setVisible(notice, enabled, "NoticeHandler")

	end)
	icon.noticeStarted:Connect(function(customClearSignal, noticeId)
	
		if not customClearSignal then
			customClearSignal = icon.deselected
		end
		local parentIcon = Icon.getIconByUID(icon.parentIconUID)
		if parentIcon then
			parentIcon:notify(customClearSignal)
		end
		
		local noticeJanitor = icon.janitor:add(Janitor.new())
		local noticeComplete = noticeJanitor:add(Signal.new())
		noticeJanitor:add(icon.endNotices:Connect(function()
			noticeComplete:Fire()
		end))
		noticeJanitor:add(customClearSignal:Connect(function()
			noticeComplete:Fire()
		end))
		noticeId = noticeId or Utility.generateUID()
		icon.notices[noticeId] = {
			completeSignal = noticeComplete,
			clearNoticeEvent = customClearSignal,
		}
		local function updateNotice()
			icon.noticeChanged:Fire(icon.totalNotices)
		end
		icon.notified:Fire(noticeId)
		icon.totalNotices += 1
		updateNotice()
		noticeComplete:Once(function()
			noticeJanitor:destroy()
			icon.totalNotices -= 1
			icon.notices[noticeId] = nil
			updateNotice()
		end)
	end)
	
	-- Establish the notice
	notice:SetAttribute("ClipToJoinedParent", true)
	icon:clipOutside(notice)
	
	return notice
end

]]

 

return function(u1, u2) -- Line: 1
    local Frame = Instance.new("Frame");
    Frame.Name = "Notice";
    Frame.ZIndex = 25;
    Frame.AutomaticSize = Enum.AutomaticSize.X;
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BorderSizePixel = 0;
    Frame.BackgroundTransparency = 0.1;
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame.Visible = false;
    Frame.Parent = u1.widget;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(1, 0);
    UICorner.Parent = Frame;
    Instance.new("UIStroke").Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "NoticeLabel";
    TextLabel.ZIndex = 26;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.AutomaticSize = Enum.AutomaticSize.X;
    TextLabel.Size = UDim2.new(1, 0, 1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0);
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    TextLabel.FontSize = Enum.FontSize.Size14;
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0);
    TextLabel.Text = "1";
    TextLabel.TextWrapped = true;
    TextLabel.TextWrap = true;
    TextLabel.Font = Enum.Font.Arial;
    TextLabel.Parent = Frame;
    local Parent = script.Parent.Parent;
    local Packages = Parent.Packages;
    local Janitor = require(Packages.Janitor);
    local GoodSignal = require(Packages.GoodSignal);
    local Utility = require(Parent.Utility);
    u1.noticeChanged:Connect(function(p3) -- Line: 43
        -- upvalues: TextLabel (copy), u2 (copy), u1 (copy), Utility (copy), Frame (copy)
        if not p3 then
            return;
        end;

        local v4 = p3 > 99;
        TextLabel.Text = v4 and "99+" or p3;

        if v4 then
            TextLabel.TextSize = 11;
        end;

        local v5 = p3 >= 1;
        local IconByUID = u2.getIconByUID(u1.parentIconUID);

        if u1.isSelected and (#u1.dropdownIcons > 0 and true or #u1.menuIcons > 0) then
            v5 = false;
        elseif IconByUID and not IconByUID.isSelected then
            v5 = false;
        end;

        Utility.setVisible(Frame, v5, "NoticeHandler");
    end);
    u1.noticeStarted:Connect(function(p6, p7) -- Line: 71
        -- upvalues: u1 (copy), u2 (copy), Janitor (copy), GoodSignal (copy), Utility (copy)
        local v8 = p6 or u1.deselected;
        local IconByUID = u2.getIconByUID(u1.parentIconUID);

        if IconByUID then
            IconByUID:notify(v8);
        end;

        local u9 = u1.janitor:add(Janitor.new());
        local u10 = u9:add(GoodSignal.new());
        u9:add(u1.endNotices:Connect(function() -- Line: 83
            -- upvalues: u10 (copy)
            u10:Fire();
        end));
        u9:add(v8:Connect(function() -- Line: 86
            -- upvalues: u10 (copy)
            u10:Fire();
        end));
        local u11 = p7 or Utility.generateUID();
        u1.notices[u11] = {
            completeSignal = u10,
            clearNoticeEvent = v8
        };

        local function updateNotice() -- Line: 94
            -- upvalues: u1 (ref)
            u1.noticeChanged:Fire(u1.totalNotices);
        end;

        u1.notified:Fire(u11);
        local v12 = u1;
        v12.totalNotices = v12.totalNotices + 1;
        u1.noticeChanged:Fire(u1.totalNotices);
        u10:Once(function() -- Line: 100
            -- upvalues: u9 (copy), u1 (ref), u11 (ref)
            u9:destroy();
            local v13 = u1;
            v13.totalNotices = v13.totalNotices - 1;
            u1.notices[u11] = nil;
            u1.noticeChanged:Fire(u1.totalNotices);
        end);
    end);
    Frame:SetAttribute("ClipToJoinedParent", true);
    u1:clipOutside(Frame);

    return Frame;
end;
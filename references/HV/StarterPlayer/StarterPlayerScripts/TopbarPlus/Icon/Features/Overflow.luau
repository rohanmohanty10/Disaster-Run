 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- When designing your game for many devices and screen sizes, icons may occasionally
-- particularly for smaller devices like phones, overlap with other icons or the bounds
-- of the screen. The overflow handler solves this challenge by moving the out-of-bounds
-- icon into an overflow menu (with a limited scrolling canvas) preventing overlaps occuring



-- LOCAL
local Overflow = {}
local holders = {}
local orderedAvailableIcons = {}
local iconsDict
local currentCamera = workspace.CurrentCamera
local overflowIcons = {}
local overflowIconUIDs = {}
local Utility = require(script.Parent.Parent.Utility)
local beginCheckingCenterIcons = false
local beganSecondaryCenterCheck = false
local Icon



-- FUNCTIONS
-- This is called upon the Icon initializing
function Overflow.start(incomingIcon)
	Icon = incomingIcon
	iconsDict = Icon.iconsDictionary
	local primaryScreenGui
	for _, screenGui in pairs(Icon.container) do
		if primaryScreenGui == nil and screenGui.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
			primaryScreenGui = screenGui
		end
		for _, holder in pairs(screenGui.Holders:GetChildren()) do
			if holder:GetAttribute("IsAHolder") then
				holders[holder.Name] = holder
			end
		end
	end

	-- We listen for changes in icons (such as them being added, removed,
	-- the setting of a different alignment, the widget size changing, etc)
	local beginOverflow = false
	local updateBoundaries = Utility.createStagger(0.1, function(ignoreAvailable)
		if not beginOverflow then
			return
		end
		if not ignoreAvailable then
			Overflow.updateAvailableIcons("Center")
		end
		Overflow.updateBoundary("Left")
		Overflow.updateBoundary("Right")
	end)
	task.delay(0.5, function()
		beginOverflow = true
		updateBoundaries()
	end)
	task.delay(2, function()
		-- This is essential to prevent central icons begin added
		-- left or right due to incomplete UIListLayout calculations
		-- within the first few frames
		beginCheckingCenterIcons = true
		updateBoundaries()
	end)
	Icon.iconAdded:Connect(updateBoundaries)
	Icon.iconRemoved:Connect(updateBoundaries)
	Icon.iconChanged:Connect(updateBoundaries)
	currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		updateBoundaries(true)
	end)
	primaryScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		updateBoundaries(true)
	end)

	-- Holders can move or shrink on their own, like when the inset settles late on mobile
	-- or the health bar pushes the right icons over, and none of the above fire for that
	for _, holder in pairs(holders) do
		holder:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			updateBoundaries(true)
		end)
		holder:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
			updateBoundaries(true)
		end)
	end
end

function Overflow.getWidth(icon, getMaxWidth)
	local widget = icon.widget
	return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end

function Overflow.getAvailableIcons(alignment)
	local ourOrderedIcons = orderedAvailableIcons[alignment]
	if not ourOrderedIcons then
		ourOrderedIcons = Overflow.updateAvailableIcons(alignment)
	end
	return ourOrderedIcons
end

function Overflow.updateAvailableIcons(alignment)

	-- We only track items that are directly on the topbar (i.e. not within a parent icon)
	local ourTotal = 0
	local ourOrderedIcons = {}
	for _, icon in pairs(iconsDict) do
		local parentUID = icon.parentIconUID
		local isDirectlyOnTopbar = not parentUID or overflowIconUIDs[parentUID]
		local isOverflow = overflowIconUIDs[icon.UID]
		if isDirectlyOnTopbar and icon.alignment == alignment and not isOverflow and icon.isEnabled then
			table.insert(ourOrderedIcons, icon)
			ourTotal += 1
		end
	end

	-- Ignore if no icons are available
	if ourTotal <= 0 then
		return {}
	end

	-- This sorts these icons by smallest order, or if equal, left-most position
	-- (even for the right alignment because all icons are sorted left-to-right)
	table.sort(ourOrderedIcons, function(iconA, iconB)
		local orderA = iconA.widget.LayoutOrder
		local orderB = iconB.widget.LayoutOrder
		local hasParentA = iconA.parentIconUID
		local hasParentB = iconB.parentIconUID
		if hasParentA == hasParentB then
			if orderA < orderB then
				return true
			end
			if orderA > orderB then
				return false
			end
			return iconA.widget.AbsolutePosition.X < iconB.widget.AbsolutePosition.X
		elseif hasParentB then
			return false
		elseif hasParentA then
			return true
		end
		return nil
	end)

	-- Finish up
	orderedAvailableIcons[alignment] = ourOrderedIcons
	return ourOrderedIcons

end

function Overflow.getRealXPositions(alignment, orderedIcons)
	-- We calculate the the absolute position of icons instead of reading
	-- directly to determine where they would be if not within an overflow
	local isLeft = alignment == "Left"
	local holder = holders[alignment]
	local holderXPos = holder.AbsolutePosition.X
	local holderXSize = holder.AbsoluteSize.X
	local holderUIList = holder.UIListLayout
	local topbarInset = holderUIList.Padding.Offset
	local absoluteX = (isLeft and holderXPos) or holderXPos + holderXSize
	local realXPositions = {}
	if isLeft then
		Utility.reverseTable(orderedIcons)
	end
	for i = #orderedIcons, 1, -1 do
		local icon = orderedIcons[i]
		local sizeX = Overflow.getWidth(icon)
		if not isLeft then
			absoluteX -= sizeX
		end
		realXPositions[icon.UID] = absoluteX
		if isLeft then
			absoluteX += sizeX
		end
		absoluteX += (isLeft and topbarInset) or -topbarInset
	end
	return realXPositions
end

function Overflow.updateBoundary(alignment)

	-- We only track items that are directly on the topbar (i.e. not within a parent icon) or within an overflow
	local holder = holders[alignment]
	local holderUIList = holder.UIListLayout
	local holderXPos = holder.AbsolutePosition.X
	local holderXSize = holder.AbsoluteSize.X
	local topbarInset = holderUIList.Padding.Offset
	local topbarPadding = holderUIList.Padding.Offset
	local BOUNDARY_GAP = topbarInset
	local ourOrderedIcons = Overflow.updateAvailableIcons(alignment)
	local boundWidth = 0
	local ourTotal = 0
	for _, icon in pairs(ourOrderedIcons) do
		boundWidth += Overflow.getWidth(icon) + topbarPadding
		ourTotal += 1
	end
	if ourTotal <= 0 then
		return
	end
	
	-- These are the icons with menus which icons will be moved into
	-- when overflowing
	local isCentral = alignment == "Center"
	local isLeft = alignment == "Left"
	local isRight = not isLeft
	local overflowIcon = overflowIcons[alignment]
	if not overflowIcon and not isCentral and #ourOrderedIcons > 0 then
		local order = (isLeft and -9999999) or 9999999
		overflowIcon = Icon.new()--:setLabel(`{alignment}`)
		overflowIcon:setImage(6069276526, "Deselected")
		overflowIcon:setName("Overflow"..alignment)
		overflowIcon:setOrder(order)
		overflowIcon:setAlignment(alignment)
		overflowIcon:autoDeselect(false)
		overflowIcon.isAnOverflow = true
		--overflowIcon:freezeMenu()
		overflowIcon:select("OverflowStart", overflowIcon)
		overflowIcon:setEnabled(false)
		overflowIcons[alignment] = overflowIcon
		overflowIconUIDs[overflowIcon.UID] = true
		if not Icon.closeableOverflowMenus then
			local iconSpot = overflowIcon:getInstance("IconSpot")
			iconSpot.Visible = false
		end
	end

	-- The default boundary is the point where both the left-most-right-icon
	-- and left-most-right-icon meet OR the opposite side of the screen
	local oppositeAlignment = (alignment == "Left" and "Right") or "Left"
	local oppositeOrderedIcons = Overflow.updateAvailableIcons(oppositeAlignment)
	local nearestOppositeIcon = (isLeft and oppositeOrderedIcons[1]) or (isRight and oppositeOrderedIcons[#oppositeOrderedIcons])
	local oppositeOverflowIcon = overflowIcons[oppositeAlignment]
	local boundary = (isLeft and holderXPos + holderXSize) or holderXPos
	if nearestOppositeIcon then
		local oppositeRealXPositions = Overflow.getRealXPositions(oppositeAlignment, oppositeOrderedIcons)
		local oppositeX = oppositeRealXPositions[nearestOppositeIcon.UID]
		local oppositeXSize = Overflow.getWidth(nearestOppositeIcon)
		boundary = (isLeft and oppositeX - BOUNDARY_GAP) or oppositeX + oppositeXSize + BOUNDARY_GAP
	end
	
	-- We get the left-most icon (if left alignment) or right-most-icon (if
	-- right alignment) of the central icons group to see if we need to change
	-- the boundary (if the central icon boundary is smaller than the alignment
	-- boundary then we use the central)
	local totalChecks = 0
	local usingNearestCenter = false
	local function checkToShiftCentralIcon()
		local centerOrderedIcons = Overflow.getAvailableIcons("Center")
		local centerPos = (isLeft and 1) or #centerOrderedIcons
		local nearestCenterIcon = centerOrderedIcons[centerPos]
		local function secondaryCheck()
			if not beganSecondaryCenterCheck then
				beganSecondaryCenterCheck = true
				task.delay(3, Overflow.updateBoundary, alignment)
			end
		end
		if nearestCenterIcon and not nearestCenterIcon.hasRelocatedInOverflow then
			local ourNearestIcon = (isLeft and ourOrderedIcons[#ourOrderedIcons]) or (isRight and ourOrderedIcons[1])
			local centralNearestXPos = nearestCenterIcon.widget.AbsolutePosition.X
			local ourNearestXPos = ourNearestIcon.widget.AbsolutePosition.X
			local ourNearestXSize = Overflow.getWidth(ourNearestIcon)
			local centerBoundary = (isLeft and centralNearestXPos-BOUNDARY_GAP) or centralNearestXPos + Overflow.getWidth(nearestCenterIcon) + BOUNDARY_GAP
			local removeBoundary = (isLeft and ourNearestXPos + ourNearestXSize) or ourNearestXPos
			local hasShifted = false
			if isLeft then
				if centerBoundary < removeBoundary then
					if not beginCheckingCenterIcons then
						secondaryCheck()
						return
					end
					nearestCenterIcon:align("Left")
					nearestCenterIcon.hasRelocatedInOverflow = true
					hasShifted = true
				end
			elseif isRight then
				if centerBoundary > removeBoundary then
					if not beginCheckingCenterIcons or removeBoundary < 0 then
						secondaryCheck()
						return
					end
					nearestCenterIcon:align("Right")
					nearestCenterIcon.hasRelocatedInOverflow = true
					hasShifted = true
				end
			end
			if hasShifted then
				totalChecks += 1
				if totalChecks <= 4 then
					Overflow.updateAvailableIcons("Center")
					checkToShiftCentralIcon()
				end
			end
		end
	end
	checkToShiftCentralIcon()
	
	--[[
	This updates the maximum size of the overflow menus
	The menu determines its bounds from the smallest of either:
	 	1. The closest center-aligned icon (i.e. the boundary)
	 	2. The edge of the opposite overflow menu UNLESS...
	 	3. ... the edge exceeds more than half the screenGui
	--]]
	if overflowIcon then
		local menuBoundary = boundary
		local menu = overflowIcon:getInstance("Menu")
		local holderXEndPos = holderXPos + holderXSize
		local menuWidth = holderXSize
		if menu and oppositeOverflowIcon then
			local oppositeWidget = oppositeOverflowIcon.widget
			local oppositeXPos = oppositeWidget.AbsolutePosition.X
			local oppositeXSize = Overflow.getWidth(oppositeOverflowIcon)
			local oppositeBoundary = (isLeft and oppositeXPos - BOUNDARY_GAP) or oppositeXPos + oppositeXSize + BOUNDARY_GAP
			local oppositeMenu = oppositeOverflowIcon:getInstance("Menu")
			local isDominant = menu.AbsoluteCanvasSize.X >= oppositeMenu.AbsoluteCanvasSize.X
			if not usingNearestCenter then
				local halfwayXPos = holderXPos + holderXSize/2
				local halfwayBoundary = (isLeft and halfwayXPos - BOUNDARY_GAP/2) or halfwayXPos + BOUNDARY_GAP/2
				menuBoundary = halfwayBoundary
				if isDominant then
					menuBoundary = oppositeBoundary
				end
			end
			menuWidth = (isLeft and menuBoundary - holderXPos) or (holderXEndPos - menuBoundary)
		end
		local currentMaxWidth = menu and menu:GetAttribute("MaxWidth")
		menuWidth = Utility.round(menuWidth)
		if menu and currentMaxWidth ~= menuWidth then
			menu:SetAttribute("MaxWidth", menuWidth)
		end
	end

	-- Parent ALL icons of that alignment into the overflow if at least on
	-- sibling exceeds the bounds.
	-- We calculate the the absolute position of icons instead of reading
	-- directly to determine where they would be if not within an overflow
	local joinOverflow = false
	local realXPositions = Overflow.getRealXPositions(alignment, ourOrderedIcons)
	for i = #ourOrderedIcons, 1, -1 do
		local icon = ourOrderedIcons[i]
		local widgetX = Overflow.getWidth(icon)
		local xPos = realXPositions[icon.UID]
		if (isLeft and xPos + widgetX >= boundary) or (isRight and xPos <= boundary) then
			joinOverflow = true
		end
	end
	for i = #ourOrderedIcons, 1, -1 do
		local icon = ourOrderedIcons[i]
		local isOverflow = overflowIconUIDs[icon.UID]
		if not isOverflow then
			if joinOverflow and not icon.parentIconUID then
				icon:joinMenu(overflowIcon)
			elseif not joinOverflow and icon.parentIconUID then
				icon:leave()
			end
		end
	end
	
	-- Hide the overflows when not in use
	if overflowIcon.isEnabled ~= joinOverflow then
		overflowIcon:setEnabled(joinOverflow)
	end
	
	-- Have the menus auto selected
	if overflowIcon.isEnabled and not overflowIcon.overflowAlreadyOpened then
		overflowIcon.overflowAlreadyOpened = true
		overflowIcon:select()
	end

end



return Overflow
]=]

 

local u1 = {};
local u2 = {};
local u3 = {};
local u4 = nil;
local workspace_CurrentCamera = workspace.CurrentCamera;
local u5 = {};
local u6 = {};
local Utility = require(script.Parent.Parent.Utility);
local u7 = false;
local u8 = false;
local u9 = nil;

function u1.start(p10) -- Line: 25
    -- upvalues: u9 (ref), u4 (ref), u2 (copy), Utility (copy), u1 (copy), u7 (ref), workspace_CurrentCamera (copy)
    u9 = p10;
    u4 = u9.iconsDictionary;
    local v11 = nil;

    for _, v in pairs(u9.container) do
        if v11 == nil then
            if v.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
                v11 = v;
            end;
        end;

        for _, child in pairs(v.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                u2[child.Name] = child;
            end;
        end;
    end;

    local u12 = false;
    local u14 = Utility.createStagger(0.1, function(p13) -- Line: 43
        -- upvalues: u12 (ref), u1 (ref)
        if not u12 then
            return;
        end;

        if not p13 then
            u1.updateAvailableIcons("Center");
        end;

        u1.updateBoundary("Left");
        u1.updateBoundary("Right");
    end);
    task.delay(0.5, function() -- Line: 53
        -- upvalues: u12 (ref), u14 (copy)
        u12 = true;
        u14();
    end);
    task.delay(2, function() -- Line: 57
        -- upvalues: u7 (ref), u14 (copy)
        u7 = true;
        u14();
    end);
    u9.iconAdded:Connect(u14);
    u9.iconRemoved:Connect(u14);
    u9.iconChanged:Connect(u14);
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 67
        -- upvalues: u14 (copy)
        u14(true);
    end);
    v11:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 70
        -- upvalues: u14 (copy)
        u14(true);
    end);
end;

function u1.getWidth(p15, p16) -- Line: 75
    local widget = p15.widget;

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X;
end;

function u1.getAvailableIcons(p17) -- Line: 80
    -- upvalues: u3 (copy), u1 (copy)
    return u3[p17] or u1.updateAvailableIcons(p17);
end;

function u1.updateAvailableIcons(p18) -- Line: 88
    -- upvalues: u4 (ref), u6 (copy), u3 (copy)
    local v19 = 0;
    local v20 = {};

    for _, v in pairs(u4) do
        local parentIconUID = v.parentIconUID;

        if (not parentIconUID or u6[parentIconUID]) and (v.alignment == p18 and (not u6[v.UID] and v.isEnabled)) then
            table.insert(v20, v);
            v19 = v19 + 1;
        end;
    end;

    if v19 <= 0 then
        return {};
    end;

    table.sort(v20, function(p21, p22) -- Line: 110
        local LayoutOrder = p21.widget.LayoutOrder;
        local LayoutOrder2 = p22.widget.LayoutOrder;
        local parentIconUID = p21.parentIconUID;
        local parentIconUID2 = p22.parentIconUID;

        if parentIconUID ~= parentIconUID2 then
            if parentIconUID2 then
                return false;
            end;

            return parentIconUID and true or nil;
        end;

        if LayoutOrder < LayoutOrder2 then
            return true;
        end;

        if LayoutOrder2 < LayoutOrder then
            return false;
        end;

        return p21.widget.AbsolutePosition.X < p22.widget.AbsolutePosition.X;
    end);
    u3[p18] = v20;

    return v20;
end;

function u1.getRealXPositions(p23, p24) -- Line: 137
    -- upvalues: u2 (copy), Utility (copy), u1 (copy)
    local v25 = p23 == "Left";
    local v26 = u2[p23];
    local X = v26.AbsolutePosition.X;
    local Offset = v26.UIListLayout.Padding.Offset;
    local v27 = v25 and X and X or X + v26.AbsoluteSize.X;
    local v28 = {};

    if v25 then
        Utility.reverseTable(p24);
    end;

    for i = #p24, 1, -1 do
        local v29 = p24[i];
        local Width = u1.getWidth(v29);

        if not v25 then
            v27 = v27 - Width;
        end;

        v28[v29.UID] = v27;

        if v25 then
            v27 = v27 + Width;
        end;

        v27 = v27 + (v25 and Offset and Offset or -Offset);
        local _ = i;
    end;

    return v28;
end;

function u1.updateBoundary(u30) -- Line: 166
    -- upvalues: u2 (copy), u1 (copy), u5 (copy), u9 (ref), u6 (copy), u8 (ref), u7 (ref), Utility (copy)
    local v31 = u2[u30];
    local UIListLayout = v31.UIListLayout;
    local X = v31.AbsolutePosition.X;
    local X2 = v31.AbsoluteSize.X;
    local Offset = UIListLayout.Padding.Offset;
    local Offset2 = UIListLayout.Padding.Offset;
    local u32 = u1.updateAvailableIcons(u30);
    local v33 = 0;
    local v34 = 0;

    for _, v in pairs(u32) do
        v33 = v33 + (u1.getWidth(v) + Offset2);
        v34 = v34 + 1;
    end;

    if v34 <= 0 then
        return;
    end;

    local u35 = u30 == "Left";
    local u36 = not u35;
    local v37 = u5[u30];

    if not (v37 or (u30 == "Center" or #u32 <= 0)) then
        v37 = u9.new();
        v37:setImage(6069276526, "Deselected");
        v37:setName("Overflow" .. u30);
        v37:setOrder(u35 and -9999999 or 9999999);
        v37:setAlignment(u30);
        v37:autoDeselect(false);
        v37.isAnOverflow = true;
        v37:select("OverflowStart", v37);
        v37:setEnabled(false);
        u5[u30] = v37;
        u6[v37.UID] = true;

        if not u9.closeableOverflowMenus then
            v37:getInstance("IconSpot").Visible = false;
        end;
    end;

    local v38 = u30 == "Left" and "Right" or "Left";
    local v39 = u1.updateAvailableIcons(v38);
    local v40 = u35 and v39[1];

    if not v40 then
        if u36 then
            v40 = v39[#v39];
        else
            v40 = u36;
        end;
    end;

    local v41 = u5[v38];
    local v42;

    if u35 then
        v42 = X + X2 or X;
    else
        v42 = X;
    end;

    if v40 then
        local v43 = u1.getRealXPositions(v38, v39)[v40.UID];
        local Width = u1.getWidth(v40);
        v42 = u35 and v43 - Offset or v43 + Width + Offset;
    end;

    local u44 = 0;

    local function checkToShiftCentralIcon() -- Line: 233
        -- upvalues: u1 (ref), u35 (copy), u8 (ref), u30 (copy), u32 (copy), u36 (copy), Offset (copy), u7 (ref), u44 (ref), checkToShiftCentralIcon (copy)
        local AvailableIcons = u1.getAvailableIcons("Center");
        local v45 = AvailableIcons[u35 and 1 or #AvailableIcons];

        local function secondaryCheck() -- Line: 237
            -- upvalues: u8 (ref), u1 (ref), u30 (ref)
            if not u8 then
                u8 = true;
                task.delay(3, u1.updateBoundary, u30);
            end;
        end;

        if v45 and not v45.hasRelocatedInOverflow then
            local v46 = u35 and u32[#u32] or u36 and u32[1];
            local X3 = v45.widget.AbsolutePosition.X;
            local X4 = v46.widget.AbsolutePosition.X;
            local Width = u1.getWidth(v46);
            local v47 = u35 and X3 - Offset or X3 + u1.getWidth(v45) + Offset;

            if u35 then
                X4 = X4 + Width or X4;
            end;

            local v48 = false;

            if u35 then
                if v47 < X4 then
                    if not u7 then
                        if not u8 then
                            u8 = true;
                            task.delay(3, u1.updateBoundary, u30);
                        end;

                        return;
                    end;

                    v45:align("Left");
                    v45.hasRelocatedInOverflow = true;
                    v48 = true;
                end;
            elseif u36 and X4 < v47 then
                if not u7 or X4 < 0 then
                    if not u8 then
                        u8 = true;
                        task.delay(3, u1.updateBoundary, u30);
                    end;

                    return;
                end;

                v45:align("Right");
                v45.hasRelocatedInOverflow = true;
                v48 = true;
            end;

            if v48 then
                u44 = u44 + 1;

                if u44 <= 4 then
                    u1.updateAvailableIcons("Center");
                    checkToShiftCentralIcon();
                end;
            end;
        end;
    end;

    checkToShiftCentralIcon();

    if v37 then
        local Instance = v37:getInstance("Menu");
        local v49 = X + X2;

        if Instance and v41 then
            local X3 = v41.widget.AbsolutePosition.X;
            local Width = u1.getWidth(v41);
            local v50 = u35 and X3 - Offset or X3 + Width + Offset;
            local Instance2 = v41:getInstance("Menu");
            local v51 = X + X2 / 2;
            local v52 = u35 and v51 - Offset / 2 or v51 + Offset / 2;

            if Instance.AbsoluteCanvasSize.X >= Instance2.AbsoluteCanvasSize.X then
                v52 = v50;
            end;

            X2 = u35 and v52 - X or v49 - v52;
        end;

        local v53;

        if Instance then
            v53 = Instance:GetAttribute("MaxWidth");
        else
            v53 = Instance;
        end;

        local v54 = Utility.round(X2);

        if Instance and v53 ~= v54 then
            Instance:SetAttribute("MaxWidth", v54);
        end;
    end;

    local RealXPositions = u1.getRealXPositions(u30, u32);
    local v55 = false;

    for i = #u32, 1, -1 do
        local v56 = u32[i];
        local Width = u1.getWidth(v56);
        local v57 = RealXPositions[v56.UID];
        local v58;

        if u35 and v42 <= v57 + Width or u36 and v57 <= v42 then
            v58 = i;
            v55 = true;
        else
            v58 = i;
        end;
    end;

    for i = #u32, 1, -1 do
        local v59 = u32[i];
        local v60;

        if u6[v59.UID] then
            v60 = i;
        elseif v55 and not v59.parentIconUID then
            v59:joinMenu(v37);
            v60 = i;
        elseif v55 or not v59.parentIconUID then
            v60 = i;
        else
            v59:leave();
            v60 = i;
        end;
    end;

    if v37.isEnabled ~= v55 then
        v37:setEnabled(v55);
    end;

    if v37.isEnabled and not v37.overflowAlreadyOpened then
        v37.overflowAlreadyOpened = true;
        v37:select();
    end;
end;

return u1;
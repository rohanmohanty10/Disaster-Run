 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
-- Just generic utility functions which I use and repeat across all my projects



-- LOCAL
local Utility = {}
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer



-- FUNCTIONS
function Utility.createStagger(delayTime, callback, delayInitially)
	-- This creates and returns a function which when called
	-- acts identically to callback, however will only be called
	-- for a maximum of once per delayTime. If the returned function
	-- is called more than once during the delayTime, then it will
	-- wait until the expiryTime then perform another recall.
	-- This is useful for visual interfaces and effects which may be
	-- triggered multiple times within a frame or short period, but which
	-- we don't necessary need to (for performance reasons).
	local staggerActive = false
	local multipleCalls = false
	if not delayTime or delayTime == 0 then
		-- We make 0.01 instead of 0 because devices can now run at
		-- different frame rates
		delayTime = 0.01
	end
	local function staggeredCallback(...)
		if staggerActive then
			multipleCalls = true
			return
		end
		local packedArgs = table.pack(...)
		staggerActive = true
		multipleCalls = false
		task.spawn(function()
			if delayInitially then
				task.wait(delayTime)
			end
			callback(table.unpack(packedArgs))
		end)
		task.delay(delayTime, function()
			staggerActive = false
			if multipleCalls then
				-- This means it has been called at least once during
				-- the stagger period, so call again
				staggeredCallback(table.unpack(packedArgs))
			end
		end)
	end
	return staggeredCallback
end

function Utility.round(n)
	-- Credit to Darkmist101 for this
	return math.floor(n + 0.5)
end

function Utility.reverseTable(t)
	for i = 1, math.floor(#t/2) do
		local j = #t - i + 1
		t[i], t[j] = t[j], t[i]
	end
end

function Utility.copyTable(t)
	-- Credit to Stephen Leitnick (September 13, 2017) for this function from TableUtil
	assert(type(t) == "table", "First argument must be a table")
	local tCopy = table.create(#t)
	for k,v in pairs(t) do
		if (type(v) == "table") then
			tCopy[k] = Utility.copyTable(v)
		else
			tCopy[k] = v
		end
	end
	return tCopy
end

local validCharacters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","1","2","3","4","5","6","7","8","9","0","<",">","?","@","{","}","[","]","!","(",")","=","+","~","#"}
function Utility.generateUID(length)
	length = length or 8
	local UID = ""
	local list = validCharacters
	local total = #list
	for i = 1, length do
		local randomCharacter = list[math.random(1, total)]
		UID = UID..randomCharacter
	end
	return UID
end

local instanceTrackers = {}
function Utility.setVisible(instance, bool, sourceUID)
	-- This effectively works like a buff object but
	-- incredibly simplified. It stacks false values
	-- so that if there is more than more than, the 
	-- instance remains hidden even if set visible true
	local tracker = instanceTrackers[instance]
	if not tracker then
		tracker = {}
		instanceTrackers[instance] = tracker
		instance.Destroying:Once(function()
			instanceTrackers[instance] = nil
		end)
	end
	if not bool then
		tracker[sourceUID] = true
	else
		tracker[sourceUID] = nil
	end
	local isVisible = bool
	if bool then
		for sourceUID, _ in pairs(tracker) do
			isVisible = false
			break
		end
	end
	instance.Visible = isVisible
end

function Utility.formatStateName(incomingStateName)
	return string.upper(string.sub(incomingStateName, 1, 1))..string.lower(string.sub(incomingStateName, 2))
end

function Utility.isReducedMotion()
	local success, isEnabled = pcall(function()
		return game:GetService("GuiService").ReducedMotionEnabled
	end)
	return success and isEnabled == true
end

function Utility.getTweenInfo(tweenInfo)
	-- A zero length tween still fires Completed, so anything waiting on it carries on as normal
	if Utility.isReducedMotion() then
		return TweenInfo.new(0)
	end
	return tweenInfo
end

function Utility.localPlayerRespawned(callback)
	-- The client localscript may be located under a ScreenGui with ResetOnSpawn set to true
	-- In these scenarios, traditional methods like CharacterAdded won't be called by the
	-- time the localscript has been destroyed, therefore we listen for removing instead
	-- If humanoid and health == 0, then reset/died normally, else was
	-- forcefully reset via a method such as LoadCharacter
	-- We wrap this behaviour in case any additional quirks need to be accounted for
	return localPlayer.CharacterRemoving:Connect(callback)
end

function Utility.getClippedContainer(screenGui)
	-- We always want clipped items to display in front hence
	-- why we have this
	local clippedContainer = screenGui:FindFirstChild("ClippedContainer")
	if not clippedContainer then
		clippedContainer = Instance.new("Folder")
		clippedContainer.Name = "ClippedContainer"
		clippedContainer.Parent = screenGui
	end
	return clippedContainer
end

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")
function Utility.clipOutside(icon, instance)
	local cloneJanitor = icon.janitor:add(Janitor.new())
	instance.Destroying:Once(function()
		cloneJanitor:Destroy()
	end)
	icon.janitor:add(instance)

	local originalParent = instance.Parent
	local clone = cloneJanitor:add(Instance.new("Frame"))
	clone:SetAttribute("IsAClippedClone", true)
	clone.Name = instance.Name
	clone.AnchorPoint = instance.AnchorPoint
	clone.Size = instance.Size
	clone.Position = instance.Position
	clone.BackgroundTransparency = 1
	clone.LayoutOrder = instance.LayoutOrder
	clone.Parent = originalParent

	local valueInstance = Instance.new("ObjectValue")
	valueInstance.Name = "OriginalInstance"
	valueInstance.Value = instance
	valueInstance.Parent = clone

	local valueInstanceCopy = valueInstance:Clone()
	instance:SetAttribute("HasAClippedClone", true)
	valueInstanceCopy.Name = "ClippedClone"
	valueInstanceCopy.Value = clone
	valueInstanceCopy.Parent = instance

	local screenGui
	local Icon = require(icon.iconModule)
	local container = Icon.container
	local function updateScreenGui()
		local originalScreenGui = originalParent:FindFirstAncestorWhichIsA("ScreenGui")
		screenGui = if string.match(originalScreenGui.Name, "Clipped") then originalScreenGui else container[originalScreenGui.Name.."Clipped"]
		instance.AnchorPoint = Vector2.new(0, 0)
		instance.Parent = Utility.getClippedContainer(screenGui)
	end
	cloneJanitor:add(icon.alignmentChanged:Connect(updateScreenGui))
	updateScreenGui()

	-- Lets copy over children that modify size
	for _, child in pairs(instance:GetChildren()) do
		if child:IsA("UIAspectRatioConstraint") then
			child:Clone().Parent = clone
		end
	end

	-- If the icon is hidden, its important we are too (as
	-- setting a parent to visible = false no longer makes
	-- this hidden)
	local widget = icon.widget
	local isOutsideParent = false
	local ignoreVisibilityUpdater = instance:GetAttribute("IgnoreVisibilityUpdater")
	local function updateVisibility()
		if ignoreVisibilityUpdater then
			return
		end
		local isVisible = widget.Visible
		if isOutsideParent then
			isVisible = false
		end
		Utility.setVisible(instance, isVisible, "ClipHandler")
	end
	cloneJanitor:add(widget:GetPropertyChangedSignal("Visible"):Connect(updateVisibility))

	local previousScroller
	local function checkIfOutsideParentXBounds()
		-- Defer so that roblox's properties reflect their true values
		task.defer(function()
			-- If the instance is within a parent item (such as a dropdown or menu)
			-- then we hide it if it exceeds the bounds of that parent
			local parentInstance
			local ourUID = icon.UID
			local nextIconUID = ourUID
			local shouldClipToParent = instance:GetAttribute("ClipToJoinedParent")
			if shouldClipToParent then
				for i = 1, 10 do -- This is safer than while true do and should never be > 4 parents
					local nextIcon = Icon.getIconByUID(nextIconUID)
					if not nextIcon then
						break
					end
					local nextParentInstance = nextIcon.joinedFrame
					nextIconUID = nextIcon.parentIconUID
					if not nextParentInstance then
						break
					end
					parentInstance = nextParentInstance
					if parentInstance and parentInstance.Name == "DropdownScroller" then
						break
					end
				end
			end
			if not parentInstance then
				isOutsideParent = false
				updateVisibility()
				return
			end
			local pos = instance.AbsolutePosition
			local halfSize = instance.AbsoluteSize/2
			local parentPos = parentInstance.AbsolutePosition
			local parentSize = parentInstance.AbsoluteSize
			local posHalf = (pos + halfSize)
			local exceededLeft = posHalf.X < parentPos.X
			local exceededRight = posHalf.X > (parentPos.X + parentSize.X)
			local exceededTop = posHalf.Y < parentPos.Y
			local exceededBottom = posHalf.Y > (parentPos.Y + parentSize.Y)
			local hasExceeded = exceededLeft or exceededRight or exceededTop or exceededBottom
			if hasExceeded ~= isOutsideParent then
				isOutsideParent = hasExceeded
				updateVisibility()
			end
			if parentInstance:IsA("ScrollingFrame") and previousScroller ~= parentInstance then
				previousScroller = parentInstance
				local connection = parentInstance:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function()
					checkIfOutsideParentXBounds()
				end)
				cloneJanitor:add(connection, "Disconnect", "TrackUtilityScroller-"..ourUID)
			end
		end)
	end

	local camera = workspace.CurrentCamera
	local additionalOffsetX = instance:GetAttribute("AdditionalOffsetX") or 0
	local function trackProperty(property)
		local absoluteProperty = "Absolute"..property
		local function updateProperty()
			local cloneValue = clone[absoluteProperty]
			local absoluteValue = UDim2.fromOffset(cloneValue.X, cloneValue.Y)
			if property == "Position" then

				-- This binds the instances within the bounds of the screen
				local SIDE_PADDING = 4
				local limitX = camera.ViewportSize.X - instance.AbsoluteSize.X - SIDE_PADDING
				local inputX = absoluteValue.X.Offset
				if inputX < SIDE_PADDING then
					inputX = SIDE_PADDING
				elseif inputX > limitX then
					inputX = limitX
				end
				absoluteValue = UDim2.fromOffset(inputX, absoluteValue.Y.Offset)

				-- AbsolutePosition does not perfectly match with TopbarInsets enabled
				-- This corrects this
				local topbarInset = GuiService.TopbarInset
				local viewportWidth = workspace.CurrentCamera.ViewportSize.X
				local guiWidth = screenGui.AbsoluteSize.X
				local guiOffset = screenGui.AbsolutePosition.X
				--local widthDifference = guiOffset - topbarInset.Min.X
				local oldTopbarCenterOffset = 0--widthDifference/30
				local offsetX = if Icon.isOldTopbar then guiOffset else viewportWidth - guiWidth - oldTopbarCenterOffset
				
				-- Also add additionalOffset
				offsetX -= additionalOffsetX
				absoluteValue += UDim2.fromOffset(-offsetX, topbarInset.Height)

				-- Finally check if within its direct parents bounds
				checkIfOutsideParentXBounds()

			end
			instance[property] = absoluteValue
		end
		
		-- This defer is essential as the listener may be in a different screenGui to the actor
		local updatePropertyStaggered = Utility.createStagger(0.01, updateProperty)
		cloneJanitor:add(clone:GetPropertyChangedSignal(absoluteProperty):Connect(updatePropertyStaggered))
		cloneJanitor:add(clone:GetAttributeChangedSignal("ForceUpdate"):Connect(function()
			updatePropertyStaggered()
		end))

		-- This is to patch a weirddddd bug with ScreenGuis with SreenInsets set to
		-- 'TopbarSafeInsets'. For some reason the absolute position of gui instances
		-- within this type of screenGui DO NOT accurately update to match their new
		-- real world position; instead they jump around almost randomly for a few frames.
		-- I have spent way too many hours trying to solve this bug, I think the only way
		-- for the time being is to not use ScreenGuis with TopbarSafeInsets, but I don't
		-- have time to redesign the entire system around that at the moment.
		-- Here's a GIF of this bug: https://i.imgur.com/VitHdC1.gif
		local updatePropertyPatch = Utility.createStagger(0.5, updateProperty, true)
		cloneJanitor:add(clone:GetPropertyChangedSignal(absoluteProperty):Connect(updatePropertyPatch))
		
		-- When the screenGui is resized (such as when chat is hidden/shown), we need
		-- to update the position of the clone. Ths especially fixes the following:
		-- https://devforum.roblox.com/t/bug/1017485/1732
		if property == "Position" then
			cloneJanitor:add(screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				updatePropertyStaggered()
			end))
		end

	end
	task.delay(0.1, checkIfOutsideParentXBounds)
	checkIfOutsideParentXBounds()
	updateVisibility()
	trackProperty("Position")
	
	-- Track visiblity changes
	cloneJanitor:add(instance:GetPropertyChangedSignal("Visible"):Connect(function()
		--print("Visiblity changed:", instance, clone, instance.Visible)
		--clone.Visible = instance.Visible
	end))

	-- To ensure accurate positioning, it's important the clone also remains the same size as the instance
	local shouldTrackCloneSize = instance:GetAttribute("TrackCloneSize")
	if shouldTrackCloneSize then
		trackProperty("Size")
	else
		cloneJanitor:add(instance:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			local absolute = instance.AbsoluteSize
			clone.Size = UDim2.fromOffset(absolute.X, absolute.Y)
		end))
	end

	return clone
end

function Utility.joinFeature(originalIcon, parentIcon, iconsArray, scrollingFrameOrFrame)

	-- This is resonsible for moving the icon under a feature like a dropdown
	local joinJanitor = originalIcon.joinJanitor
	joinJanitor:clean()
	if not scrollingFrameOrFrame then
		originalIcon:leave()
		return
	end
	originalIcon.parentIconUID = parentIcon.UID
	originalIcon.joinedFrame = scrollingFrameOrFrame
	local function updateAlignent()
		local parentAlignment = parentIcon.alignment
		if parentAlignment == "Center" then
			parentAlignment = "Left"
		end
		originalIcon:setAlignment(parentAlignment, true)
	end
	joinJanitor:add(parentIcon.alignmentChanged:Connect(updateAlignent))
	updateAlignent()
	originalIcon:modifyTheme({"IconButton", "BackgroundTransparency", 1}, "JoinModification")
	originalIcon:modifyTheme({"ClickRegion", "Active", false}, "JoinModification")
	if parentIcon.childModifications then
		-- We defer so that the default values (such as dropdown
		-- minimum width can be applied before any custom
		-- child modifications from the user)
		task.defer(function()
			originalIcon:modifyTheme(parentIcon.childModifications, parentIcon.childModificationsUID)
		end)
	end
	--
	local clickRegion = originalIcon:getInstance("ClickRegion")
	local function makeSelectable()
		clickRegion.Selectable = parentIcon.isSelected
	end
	joinJanitor:add(parentIcon.toggled:Connect(makeSelectable))
	task.defer(makeSelectable)
	joinJanitor:add(function()
		clickRegion.Selectable = true
	end)
	--

	-- We track icons in arrays and dictionaries using their UID instead of the icon
	-- itself to prevent heavy cyclical tables when printing the icons
	local originalIconUID = originalIcon.UID
	table.insert(iconsArray, originalIconUID)
	parentIcon:autoDeselect(false)
	parentIcon.childIconsDict[originalIconUID] = true
	if not parentIcon.isEnabled then
		parentIcon:setEnabled(true)
	end
	originalIcon.joinedParent:Fire(parentIcon)

	-- This is responsible for removing it from that feature and updating
	-- their parent icon so its informed of the icon leaving it
	joinJanitor:add(function()
		local joinedFrame = originalIcon.joinedFrame
		if not joinedFrame then
			return
		end
		for i, iconUID in pairs(iconsArray) do
			if iconUID == originalIconUID then
				table.remove(iconsArray, i)
				break
			end
		end
		local Icon = require(originalIcon.iconModule)
		local parentIcon = Icon.getIconByUID(originalIcon.parentIconUID)
		if not parentIcon then
			return
		end
		originalIcon:setAlignment(originalIcon.originalAlignment)
		originalIcon.parentIconUID = false
		originalIcon.joinedFrame = false
		--originalIcon:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
		originalIcon:removeModification("JoinModification")
		
		local parentHasNoChildren = true
		local parentChildIcons = parentIcon.childIconsDict
		parentChildIcons[originalIconUID] = nil
		for childIconUID, _ in pairs(parentChildIcons) do
			parentHasNoChildren = false
			break
		end
		if parentHasNoChildren and not parentIcon.isAnOverflow then
			parentIcon:setEnabled(false)
		end
		updateAlignent()

	end)

end



return Utility
]]

 

local u1 = {};
local LocalPlayer = game:GetService("Players").LocalPlayer;

function u1.createStagger(p2, u3, u4) -- Line: 13
    local u5 = false;
    local u6 = false;
    local u7 = (not p2 or p2 == 0) and 0.01 or p2;

    local function staggeredCallback(...) -- Line: 29
        -- upvalues: u5 (ref), u6 (ref), u4 (copy), u7 (ref), u3 (copy), staggeredCallback (copy)
        if u5 then
            u6 = true;

            return;
        end;

        local table_pack_ret = table.pack(...);
        u5 = true;
        u6 = false;
        task.spawn(function() -- Line: 37
            -- upvalues: u4 (ref), u7 (ref), u3 (ref), table_pack_ret (copy)
            if u4 then
                task.wait(u7);
            end;

            u3(table.unpack(table_pack_ret));
        end);
        task.delay(u7, function() -- Line: 43
            -- upvalues: u5 (ref), u6 (ref), staggeredCallback (ref), table_pack_ret (copy)
            u5 = false;

            if u6 then
                staggeredCallback(table.unpack(table_pack_ret));
            end;
        end);
    end;

    return staggeredCallback;
end;

function u1.round(p8) -- Line: 55
    return math.floor(p8 + 0.5);
end;

function u1.reverseTable(p9) -- Line: 60
    for i = 1, math.floor(#p9 / 2) do
        local v10 = #p9 - i + 1;
        local v11 = p9[i];
        p9[i] = p9[v10];
        p9[v10] = v11;
        local _ = i;
    end;
end;

function u1.copyTable(p12) -- Line: 67
    -- upvalues: u1 (copy)
    local v13 = type(p12) == "table";
    assert(v13, "First argument must be a table");
    local table_create_ret = table.create(#p12);

    for i, v in pairs(p12) do
        if type(v) == "table" then
            table_create_ret[i] = u1.copyTable(v);
        else
            table_create_ret[i] = v;
        end;
    end;

    return table_create_ret;
end;

local u14 = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "<", ">", "?", "@", "{", "}", "[", "]", "!", "(", ")", "=", "+", "~", "#" };

function u1.generateUID(p15) -- Line: 82
    -- upvalues: u14 (copy)
    local v16 = u14;
    local v17 = #v16;
    local v18 = "";

    for i = 1, p15 or 8 do
        v18 = v18 .. v16[math.random(1, v17)];
        local _ = i;
    end;

    return v18;
end;

local u19 = {};

function u1.setVisible(u20, p21, p22) -- Line: 95
    -- upvalues: u19 (copy)
    local v23 = u19[u20];

    if not v23 then
        v23 = {};
        u19[u20] = v23;
        u20.Destroying:Once(function() -- Line: 104
            -- upvalues: u19 (ref), u20 (copy)
            u19[u20] = nil;
        end);
    end;

    if p21 then
        v23[p22] = nil;
    else
        v23[p22] = true;
    end;

    if p21 then
        for _, _ in pairs(v23) do
            p21 = false;
            break;
        end;
    end;

    u20.Visible = p21;
end;

function u1.formatStateName(p24) -- Line: 123
    return string.upper((string.sub(p24, 1, 1))) .. string.lower((string.sub(p24, 2)));
end;

function u1.localPlayerRespawned(p25) -- Line: 127
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.CharacterRemoving:Connect(p25);
end;

function u1.getClippedContainer(p26) -- Line: 137
    local ClippedContainer = p26:FindFirstChild("ClippedContainer");

    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder");
        ClippedContainer.Name = "ClippedContainer";
        ClippedContainer.Parent = p26;
    end;

    return ClippedContainer;
end;

local Janitor = require(script.Parent.Packages.Janitor);
local GuiService = game:GetService("GuiService");

function u1.clipOutside(u27, u28) -- Line: 151
    -- upvalues: Janitor (copy), u1 (copy), GuiService (copy)
    local u29 = u27.janitor:add(Janitor.new());
    u28.Destroying:Once(function() -- Line: 153
        -- upvalues: u29 (copy)
        u29:Destroy();
    end);
    u27.janitor:add(u28);
    local Parent = u28.Parent;
    local u30 = u29:add(Instance.new("Frame"));
    u30:SetAttribute("IsAClippedClone", true);
    u30.Name = u28.Name;
    u30.AnchorPoint = u28.AnchorPoint;
    u30.Size = u28.Size;
    u30.Position = u28.Position;
    u30.BackgroundTransparency = 1;
    u30.LayoutOrder = u28.LayoutOrder;
    u30.Parent = Parent;
    local ObjectValue = Instance.new("ObjectValue");
    ObjectValue.Name = "OriginalInstance";
    ObjectValue.Value = u28;
    ObjectValue.Parent = u30;
    local v31 = ObjectValue:Clone();
    u28:SetAttribute("HasAClippedClone", true);
    v31.Name = "ClippedClone";
    v31.Value = u30;
    v31.Parent = u28;
    local u32 = nil;
    local iconModule = require(u27.iconModule);
    local container = iconModule.container;

    local function updateScreenGui() -- Line: 183
        -- upvalues: Parent (copy), u32 (ref), container (copy), u28 (copy), u1 (ref)
        local v33 = Parent:FindFirstAncestorWhichIsA("ScreenGui");

        if not string.match(v33.Name, "Clipped") then
            v33 = container[v33.Name .. "Clipped"];
        end;

        u32 = v33;
        u28.AnchorPoint = Vector2.new(0, 0);
        u28.Parent = u1.getClippedContainer(u32);
    end;

    u29:add(u27.alignmentChanged:Connect(updateScreenGui));
    updateScreenGui();

    for _, child in pairs(u28:GetChildren()) do
        if child:IsA("UIAspectRatioConstraint") then
            child:Clone().Parent = u30;
        end;
    end;

    local widget = u27.widget;
    local u34 = false;
    local Attribute = u28:GetAttribute("IgnoreVisibilityUpdater");

    local function updateVisibility() -- Line: 205
        -- upvalues: Attribute (copy), widget (copy), u34 (ref), u1 (ref), u28 (copy)
        if Attribute then
            return;
        end;

        local Visible = widget.Visible;

        if u34 then
            Visible = false;
        end;

        u1.setVisible(u28, Visible, "ClipHandler");
    end;

    u29:add(widget:GetPropertyChangedSignal("Visible"):Connect(updateVisibility));
    local u35 = nil;

    local function checkIfOutsideParentXBounds() -- Line: 218
        -- upvalues: u27 (copy), u28 (copy), iconModule (copy), u34 (ref), Attribute (copy), widget (copy), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (copy), u29 (copy)
        task.defer(function() -- Line: 220
            -- upvalues: u27 (ref), u28 (ref), iconModule (ref), u34 (ref), Attribute (ref), widget (ref), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (ref), u29 (ref)
            local v36 = nil;
            local UID = u27.UID;
            local v37;

            if u28:GetAttribute("ClipToJoinedParent") then
                v37 = UID;

                for i = 1, 10 do
                    local IconByUID = iconModule.getIconByUID(UID);

                    if not IconByUID then
                        break;
                    end;

                    local joinedFrame = IconByUID.joinedFrame;
                    UID = IconByUID.parentIconUID;

                    if not joinedFrame then
                        break;
                    end;

                    if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                        v36 = joinedFrame;
                        break;
                    end;

                    v36 = joinedFrame;
                    local _ = i;
                end;
            else
                v37 = UID;
            end;

            if not v36 then
                u34 = false;

                if Attribute then
                    return;
                end;

                local Visible = widget.Visible;

                if u34 then
                    Visible = false;
                end;

                u1.setVisible(u28, Visible, "ClipHandler");

                return;
            end;

            local AbsolutePosition = v36.AbsolutePosition;
            local AbsoluteSize = v36.AbsoluteSize;
            local v38 = u28.AbsolutePosition + u28.AbsoluteSize / 2;
            local v39 = v38.X < AbsolutePosition.X or (v38.X > AbsolutePosition.X + AbsoluteSize.X or (v38.Y < AbsolutePosition.Y or v38.Y > AbsolutePosition.Y + AbsoluteSize.Y));

            if v39 ~= u34 then
                u34 = v39;

                if not Attribute then
                    local Visible = widget.Visible;

                    if u34 then
                        Visible = false;
                    end;

                    u1.setVisible(u28, Visible, "ClipHandler");
                end;
            end;

            if v36:IsA("ScrollingFrame") and u35 ~= v36 then
                u35 = v36;
                u29:add(v36:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                    -- upvalues: checkIfOutsideParentXBounds (ref)
                    checkIfOutsideParentXBounds();
                end), "Disconnect", "TrackUtilityScroller-" .. v37);
            end;
        end);
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;
    local u40 = u28:GetAttribute("AdditionalOffsetX") or 0;

    local function trackProperty(u41) -- Line: 275
        -- upvalues: u30 (copy), workspace_CurrentCamera (copy), u28 (copy), GuiService (ref), u32 (ref), iconModule (copy), u40 (copy), u27 (copy), u34 (ref), Attribute (copy), widget (copy), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (copy), u29 (copy)
        local u42 = "Absolute" .. u41;

        local function updateProperty() -- Line: 277
            -- upvalues: u30 (ref), u42 (copy), u41 (copy), workspace_CurrentCamera (ref), u28 (ref), GuiService (ref), u32 (ref), iconModule (ref), u40 (ref), u27 (ref), u34 (ref), Attribute (ref), widget (ref), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (ref), u29 (ref)
            local v43 = u30[u42];
            local UDim2_fromOffset_ret = UDim2.fromOffset(v43.X, v43.Y);

            if u41 == "Position" then
                local v44 = workspace_CurrentCamera.ViewportSize.X - u28.AbsoluteSize.X - 4;
                local Offset = UDim2_fromOffset_ret.X.Offset;

                if Offset < 4 then
                    v44 = 4;
                elseif v44 >= Offset then
                    v44 = Offset;
                end;

                local UDim2_fromOffset_ret2 = UDim2.fromOffset(v44, UDim2_fromOffset_ret.Y.Offset);
                local X = workspace.CurrentCamera.ViewportSize.X;
                local X2 = u32.AbsoluteSize.X;
                local X3 = u32.AbsolutePosition.X;

                if not iconModule.isOldTopbar then
                    X3 = X - X2 - 0;
                end;

                UDim2_fromOffset_ret = UDim2_fromOffset_ret2 + UDim2.fromOffset(-(X3 - u40), GuiService.TopbarInset.Height);
                task.defer(function() -- Line: 220
                    -- upvalues: u27 (ref), u28 (ref), iconModule (ref), u34 (ref), Attribute (ref), widget (ref), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (ref), u29 (ref)
                    local v45 = nil;
                    local UID = u27.UID;
                    local v46;

                    if u28:GetAttribute("ClipToJoinedParent") then
                        v46 = UID;

                        for i = 1, 10 do
                            local IconByUID = iconModule.getIconByUID(UID);

                            if not IconByUID then
                                break;
                            end;

                            local joinedFrame = IconByUID.joinedFrame;
                            UID = IconByUID.parentIconUID;

                            if not joinedFrame then
                                break;
                            end;

                            if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                                v45 = joinedFrame;
                                break;
                            end;

                            v45 = joinedFrame;
                            local _ = i;
                        end;
                    else
                        v46 = UID;
                    end;

                    if not v45 then
                        u34 = false;

                        if Attribute then
                            return;
                        end;

                        local Visible = widget.Visible;

                        if u34 then
                            Visible = false;
                        end;

                        u1.setVisible(u28, Visible, "ClipHandler");

                        return;
                    end;

                    local AbsolutePosition = v45.AbsolutePosition;
                    local AbsoluteSize = v45.AbsoluteSize;
                    local v47 = u28.AbsolutePosition + u28.AbsoluteSize / 2;
                    local v48 = v47.X < AbsolutePosition.X or (v47.X > AbsolutePosition.X + AbsoluteSize.X or (v47.Y < AbsolutePosition.Y or v47.Y > AbsolutePosition.Y + AbsoluteSize.Y));

                    if v48 ~= u34 then
                        u34 = v48;

                        if not Attribute then
                            local Visible = widget.Visible;

                            if u34 then
                                Visible = false;
                            end;

                            u1.setVisible(u28, Visible, "ClipHandler");
                        end;
                    end;

                    if v45:IsA("ScrollingFrame") and u35 ~= v45 then
                        u35 = v45;
                        u29:add(v45:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                            -- upvalues: checkIfOutsideParentXBounds (ref)
                            checkIfOutsideParentXBounds();
                        end), "Disconnect", "TrackUtilityScroller-" .. v46);
                    end;
                end);
            end;

            u28[u41] = UDim2_fromOffset_ret;
        end;

        local u49 = u1.createStagger(0.01, updateProperty);
        u29:add(u30:GetPropertyChangedSignal(u42):Connect(u49));
        u29:add(u30:GetAttributeChangedSignal("ForceUpdate"):Connect(function() -- Line: 317
            -- upvalues: u49 (copy)
            u49();
        end));
        local v50 = u1.createStagger(0.5, updateProperty, true);
        u29:add(u30:GetPropertyChangedSignal(u42):Connect(v50));

        if u41 == "Position" then
            u29:add(u32:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 336
                -- upvalues: u49 (copy)
                u49();
            end));
        end;
    end;

    task.delay(0.1, checkIfOutsideParentXBounds);
    task.defer(function() -- Line: 220
        -- upvalues: u27 (copy), u28 (copy), iconModule (copy), u34 (ref), Attribute (copy), widget (copy), u1 (ref), u35 (ref), checkIfOutsideParentXBounds (copy), u29 (copy)
        local v51 = nil;
        local UID = u27.UID;
        local v52;

        if u28:GetAttribute("ClipToJoinedParent") then
            v52 = UID;

            for i = 1, 10 do
                local IconByUID = iconModule.getIconByUID(UID);

                if not IconByUID then
                    break;
                end;

                local joinedFrame = IconByUID.joinedFrame;
                UID = IconByUID.parentIconUID;

                if not joinedFrame then
                    break;
                end;

                if joinedFrame and joinedFrame.Name == "DropdownScroller" then
                    v51 = joinedFrame;
                    break;
                end;

                v51 = joinedFrame;
                local _ = i;
            end;
        else
            v52 = UID;
        end;

        if not v51 then
            u34 = false;

            if Attribute then
                return;
            end;

            local Visible = widget.Visible;

            if u34 then
                Visible = false;
            end;

            u1.setVisible(u28, Visible, "ClipHandler");

            return;
        end;

        local AbsolutePosition = v51.AbsolutePosition;
        local AbsoluteSize = v51.AbsoluteSize;
        local v53 = u28.AbsolutePosition + u28.AbsoluteSize / 2;
        local v54 = v53.X < AbsolutePosition.X or (v53.X > AbsolutePosition.X + AbsoluteSize.X or (v53.Y < AbsolutePosition.Y or v53.Y > AbsolutePosition.Y + AbsoluteSize.Y));

        if v54 ~= u34 then
            u34 = v54;

            if not Attribute then
                local Visible = widget.Visible;

                if u34 then
                    Visible = false;
                end;

                u1.setVisible(u28, Visible, "ClipHandler");
            end;
        end;

        if v51:IsA("ScrollingFrame") and u35 ~= v51 then
            u35 = v51;
            u29:add(v51:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- Line: 265
                -- upvalues: checkIfOutsideParentXBounds (ref)
                checkIfOutsideParentXBounds();
            end), "Disconnect", "TrackUtilityScroller-" .. v52);
        end;
    end);

    if not Attribute then
        local Visible = widget.Visible;

        if u34 then
            Visible = false;
        end;

        u1.setVisible(u28, Visible, "ClipHandler");
    end;

    trackProperty("Position");
    u29:add(u28:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 348
    end));

    if u28:GetAttribute("TrackCloneSize") then
        trackProperty("Size");
    else
        u29:add(u28:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 358
            -- upvalues: u28 (copy), u30 (copy)
            local AbsoluteSize = u28.AbsoluteSize;
            u30.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
        end));
    end;

    return u30;
end;

function u1.joinFeature(u55, u56, u57, p58) -- Line: 367
    local joinJanitor = u55.joinJanitor;
    joinJanitor:clean();

    if not p58 then
        u55:leave();

        return;
    end;

    u55.parentIconUID = u56.UID;
    u55.joinedFrame = p58;
    joinJanitor:add(u56.alignmentChanged:Connect(function() -- Line: 378, Name: updateAlignent
        -- upvalues: u56 (copy), u55 (copy)
        local alignment = u56.alignment;
        u55:setAlignment(alignment == "Center" and "Left" or alignment, true);
    end));
    local alignment = u56.alignment;
    u55:setAlignment(alignment == "Center" and "Left" or alignment, true);
    u55:modifyTheme({ "IconButton", "BackgroundTransparency", 1 }, "JoinModification");
    u55:modifyTheme({ "ClickRegion", "Active", false }, "JoinModification");

    if u56.childModifications then
        task.defer(function() -- Line: 393
            -- upvalues: u55 (copy), u56 (copy)
            u55:modifyTheme(u56.childModifications, u56.childModificationsUID);
        end);
    end;

    local Instance2 = u55:getInstance("ClickRegion");

    local function makeSelectable() -- Line: 399
        -- upvalues: Instance2 (copy), u56 (copy)
        Instance2.Selectable = u56.isSelected;
    end;

    joinJanitor:add(u56.toggled:Connect(makeSelectable));
    task.defer(makeSelectable);
    joinJanitor:add(function() -- Line: 404
        -- upvalues: Instance2 (copy)
        Instance2.Selectable = true;
    end);
    local UID = u55.UID;
    table.insert(u57, UID);
    u56:autoDeselect(false);
    u56.childIconsDict[UID] = true;

    if not u56.isEnabled then
        u56:setEnabled(true);
    end;

    u55.joinedParent:Fire(u56);
    joinJanitor:add(function() -- Line: 422
        -- upvalues: u55 (copy), u57 (copy), UID (copy), u56 (copy)
        if not u55.joinedFrame then
            return;
        end;

        for i, v in pairs(u57) do
            if v == UID then
                table.remove(u57, i);
                break;
            end;
        end;

        local IconByUID = require(u55.iconModule).getIconByUID(u55.parentIconUID);

        if not IconByUID then
            return;
        end;

        u55:setAlignment(u55.originalAlignment);
        u55.parentIconUID = false;
        u55.joinedFrame = false;
        u55:removeModification("JoinModification");
        local v59 = true;
        local childIconsDict = IconByUID.childIconsDict;
        childIconsDict[UID] = nil;

        for _, _ in pairs(childIconsDict) do
            v59 = false;
            break;
        end;

        if v59 and not IconByUID.isAnOverflow then
            IconByUID:setEnabled(false);
        end;

        local alignment2 = u56.alignment;
        u55:setAlignment(alignment2 == "Center" and "Left" or alignment2, true);
    end);
end;

return u1;
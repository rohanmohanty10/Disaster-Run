 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
local hasBecomeOldTheme = false
local previousInsetHeight = 0
return function(Icon)
	
	-- Has to be included for the time being due to this bug mentioned here:
	-- https://devforum.roblox.com/t/bug/2973508/7
	local GuiService = game:GetService("GuiService")
	local Players =  game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local container = {}
	local Signal = require(script.Parent.Parent.Packages.GoodSignal)
	local insetChanged = Signal.new()
	local guiInset = GuiService:GetGuiInset()
	local startInset = 0
	local yDownOffset = 0
	local ySizeOffset = 0
	local checkCount = 0
	local isConsoleScreen = false
	local isUsingVR = false
	local function checkInset()
		local currentHeight = GuiService.TopbarInset.Height
		local isOldTopbar = currentHeight <= 36
		

		-- These additional checks are needed to ensure *it is actually* the old topbar
		-- and not a client which takes a really long time to load
		-- There's unfortunately no APIs to do this a prettier way
		isConsoleScreen = GuiService:IsTenFootInterface()
		isUsingVR = UserInputService.VREnabled
		Icon.isOldTopbar = isOldTopbar
		checkCount += 1
		if checkCount == 1 then
			task.delay(5, function()
				local localPlayer = Players.LocalPlayer
				localPlayer:WaitForChild("PlayerGui")
				if checkCount == 1 then
					checkInset()
				end
			end)
		end

		-- Conver to old theme if verified
		-- A height of 0 means the topbar has not loaded yet
		if Icon.isOldTopbar and currentHeight ~= 0 and not isConsoleScreen and not isUsingVR and hasBecomeOldTheme == false then
			hasBecomeOldTheme = true
			task.defer(function()
				-- If oldtopbar, apply the Classic theme
				local themes = script.Parent.Parent.Features.Themes
				local Classic = require(themes.Classic)
				Icon.modifyBaseTheme(Classic)

				-- Also configure the oldtopbar correctly
				local function decideToHideTopbar()
					if GuiService.MenuIsOpen then
						Icon.setTopbarEnabled(false, true)
					else
						Icon.setTopbarEnabled()
					end
				end
				GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar)
				decideToHideTopbar()
			end)
		end

		-- Modify the offsets slightly depending on device type
		guiInset = GuiService:GetGuiInset()
		startInset = if isOldTopbar then 12 else guiInset.Y - 50
		yDownOffset = if isOldTopbar then 2 else 0 --if isOldTopbar then 2 else 0 
		ySizeOffset = -2
		if GuiService.TopbarInset.Height == 0 and not hasBecomeOldTheme then
			yDownOffset += 13
			ySizeOffset = 50
		end

		-- Now inform other areas of the change
		insetChanged:Fire(guiInset)
		local insetHeight = guiInset.Y
		if insetHeight ~= previousInsetHeight then
			previousInsetHeight = insetHeight
			task.defer(function()
				Icon.insetHeightChanged:Fire(insetHeight)
			end)
		end
		
	end
	GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset)
	checkInset()

	local screenGui = Instance.new("ScreenGui")
	insetChanged:Connect(function()
		screenGui:SetAttribute("StartInset", startInset)
	end)
	screenGui.Name = "TopbarStandard"
	screenGui.Enabled = true
	screenGui.DisplayOrder = Icon.baseDisplayOrder
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = false
	screenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
	container[screenGui.Name] = screenGui
	Icon.baseDisplayOrderChanged:Connect(function()
		screenGui.DisplayOrder = Icon.baseDisplayOrder
	end)

	local holders = Instance.new("Frame")
	holders.Name = "Holders"
	holders.BackgroundTransparency = 1
	insetChanged:Connect(function()
		-- Console used to get a fixed 56 tall holder, but its topbar now lays out like desktop
		-- so the full inset height lines icons up with Roblox's own
		local holderSize = if isConsoleScreen and isUsingVR then UDim2.new(1, 0, 0, 36) else UDim2.new(1, 0, 1, ySizeOffset)
		holders.Position = UDim2.new(0, 0, 0, yDownOffset)
		holders.Size = holderSize
	end)
	holders.Visible = true
	holders.ZIndex = 1
	holders.Parent = screenGui
	
	local screenGuiCenter = screenGui:Clone()
	local holdersCenter = screenGuiCenter.Holders
	local function updateCenteredHoldersHeight()
		holdersCenter.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height+ySizeOffset)
	end
	screenGuiCenter.Name = "TopbarCentered"
	screenGuiCenter.DisplayOrder = Icon.baseDisplayOrder
	screenGuiCenter.ScreenInsets = Enum.ScreenInsets.None
	Icon.baseDisplayOrderChanged:Connect(function()
		screenGuiCenter.DisplayOrder = Icon.baseDisplayOrder
	end)
	container[screenGuiCenter.Name] = screenGuiCenter
	
	insetChanged:Connect(updateCenteredHoldersHeight)
	updateCenteredHoldersHeight()
	
	local screenGuiClipped = screenGui:Clone()
	screenGuiClipped.Name = screenGuiClipped.Name.."Clipped"
	screenGuiClipped.DisplayOrder = (Icon.baseDisplayOrder + 1)
	Icon.baseDisplayOrderChanged:Connect(function()
		screenGuiClipped.DisplayOrder = (Icon.baseDisplayOrder + 1)
	end)
	container[screenGuiClipped.Name] = screenGuiClipped
	
	local screenGuiCenterClipped = screenGuiCenter:Clone()
	screenGuiCenterClipped.Name = screenGuiCenterClipped.Name.."Clipped"
	screenGuiCenterClipped.DisplayOrder = (Icon.baseDisplayOrder + 1)
	Icon.baseDisplayOrderChanged:Connect(function()
		screenGuiCenterClipped.DisplayOrder = (Icon.baseDisplayOrder + 1)
	end)
	container[screenGuiCenterClipped.Name] = screenGuiCenterClipped
	
	local holderReduction = -24
	local left = Instance.new("ScrollingFrame")
	left:SetAttribute("IsAHolder", true)
	left.Name = "Left"
	insetChanged:Connect(function()
		left.Position = UDim2.fromOffset(startInset, 0)
	end)
	left.Size = UDim2.new(1, holderReduction, 1, 0)
	left.BackgroundTransparency = 1
	left.Visible = true
	left.ZIndex = 1
	left.Active = false
	left.ClipsDescendants = true
	left.HorizontalScrollBarInset = Enum.ScrollBarInset.None
	left.CanvasSize = UDim2.new(0, 0, 1, -1) -- This -1 prevents a dropdown scrolling appearance bug
	left.AutomaticCanvasSize = Enum.AutomaticSize.X
	left.ScrollingDirection = Enum.ScrollingDirection.X
	left.ScrollBarThickness = 0
	left.BorderSizePixel = 0
	left.Selectable = false
	left.ScrollingEnabled = false--true
	left.ElasticBehavior = Enum.ElasticBehavior.Never
	left.Parent = holders
	
	local UIListLayout = Instance.new("UIListLayout")
	insetChanged:Connect(function()
		UIListLayout.Padding = UDim.new(0, startInset)
	end)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	UIListLayout.Parent = left
	
	local center = left:Clone()
	insetChanged:Connect(function()
		center.UIListLayout.Padding = UDim.new(0, startInset)
	end)
	center.ScrollingEnabled = false
	center.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	center.Name = "Center"
	center.Parent = holdersCenter
	
	local right = left:Clone()
	insetChanged:Connect(function()
		right.UIListLayout.Padding = UDim.new(0, startInset)
	end)
	right.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	right.Name = "Right"
	right.AnchorPoint = Vector2.new(1, 0)
	-- The same 16 Roblox leaves between the screen edge and its own logo
	local EDGE_MARGIN = 16
	right.Position = UDim2.new(1, -EDGE_MARGIN, 0, 0)
	right.Parent = holders

	-- Roblox's health bar sits in the top right but isn't counted in TopbarSafeInsets,
	-- so we shuffle the right icons over ourselves while it's showing
	local StarterGui = game:GetService("StarterGui")
	local HEALTH_BAR_WIDTH = 136
	local humanoidConnections = {}
	local function updateRightOffset()
		local isHealthBarShowing = false
		local character = Players.LocalPlayer and Players.LocalPlayer.Character
		local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
		if humanoid and not Icon.isOldTopbar and not isConsoleScreen and not isUsingVR then
			local success, isHealthEnabled = pcall(StarterGui.GetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.Health)
			local displayType = humanoid.HealthDisplayType
			if success and isHealthEnabled and displayType ~= Enum.HumanoidHealthDisplayType.AlwaysOff then
				isHealthBarShowing = displayType == Enum.HumanoidHealthDisplayType.AlwaysOn or humanoid.Health < humanoid.MaxHealth
			end
		end
		local healthOffset = if isHealthBarShowing then HEALTH_BAR_WIDTH else 0
		right.Position = UDim2.new(1, -EDGE_MARGIN - healthOffset, 0, 0)
		right.Size = UDim2.new(1, holderReduction - healthOffset, 1, 0)
	end
	local function trackCharacter(character)
		for _, connection in pairs(humanoidConnections) do
			connection:Disconnect()
		end
		table.clear(humanoidConnections)
		local humanoid = character:WaitForChild("Humanoid", 10)
		if humanoid then
			table.insert(humanoidConnections, humanoid.HealthChanged:Connect(updateRightOffset))
			table.insert(humanoidConnections, humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(updateRightOffset))
			table.insert(humanoidConnections, humanoid:GetPropertyChangedSignal("HealthDisplayType"):Connect(updateRightOffset))
		end
		updateRightOffset()
	end
	insetChanged:Connect(updateRightOffset)
	task.defer(function()
		local localPlayer = Players.LocalPlayer
		localPlayer.CharacterAdded:Connect(trackCharacter)
		if localPlayer.Character then
			trackCharacter(localPlayer.Character)
		end
	end)

	-- This is important so that all elements update instantly
	insetChanged:Fire(guiInset)

	return container
end
]]

 

local u1 = false;
local u2 = 0;

return function(u3) -- Line: 3
    -- upvalues: u1 (ref), u2 (ref)
    local GuiService = game:GetService("GuiService");
    local Players = game:GetService("Players");
    local UserInputService = game:GetService("UserInputService");
    local v4 = {};
    local u5 = require(script.Parent.Parent.Packages.GoodSignal).new();
    local GuiInset = GuiService:GetGuiInset();
    local u6 = 0;
    local u7 = 0;
    local u8 = 0;
    local u9 = 0;
    local u10 = false;
    local u11 = false;

    local function checkInset(p12) -- Line: 20
        -- upvalues: GuiService (copy), u10 (ref), u11 (ref), UserInputService (copy), u3 (copy), u9 (ref), checkInset (copy), Players (copy), u1 (ref), GuiInset (ref), u6 (ref), u7 (ref), u8 (ref), u5 (copy), u2 (ref)
        local Height = GuiService.TopbarInset.Height;
        local v13 = Height <= 36;
        u10 = GuiService:IsTenFootInterface();
        u11 = UserInputService.VREnabled;
        u3.isOldTopbar = v13;
        u9 = u9 + 1;

        if Height == 0 and p12 == nil then
            task.defer(function() -- Line: 33
                -- upvalues: checkInset (ref)
                task.wait(8);
                checkInset("ForceConvertToOld");
            end);
        elseif u9 == 1 then
            task.delay(5, function() -- Line: 38
                -- upvalues: Players (ref), u9 (ref), checkInset (ref)
                Players.LocalPlayer:WaitForChild("PlayerGui");

                if u9 == 1 then
                    checkInset();
                end;
            end);
        end;

        if u3.isOldTopbar and not (u10 or (u11 or (u1 ~= false or Height == 0 and p12 ~= "ForceConvertToOld"))) then
            u1 = true;
            task.defer(function() -- Line: 50
                -- upvalues: u3 (ref), GuiService (ref)
                local Classic = require(script.Parent.Parent.Features.Themes.Classic);
                u3.modifyBaseTheme(Classic);

                local function decideToHideTopbar() -- Line: 57
                    -- upvalues: GuiService (ref), u3 (ref)
                    if GuiService.MenuIsOpen then
                        u3.setTopbarEnabled(false, true);

                        return;
                    end;

                    u3.setTopbarEnabled();
                end;

                GuiService:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar);

                if GuiService.MenuIsOpen then
                    u3.setTopbarEnabled(false, true);

                    return;
                end;

                u3.setTopbarEnabled();
            end);
        end;

        GuiInset = GuiService:GetGuiInset();
        u6 = v13 and 12 or GuiInset.Y - 50;
        u7 = v13 and 2 or 0;
        u8 = -2;

        if u10 then
            u6 = 10;
            u7 = 0;
        end;

        if GuiService.TopbarInset.Height == 0 and not u1 then
            u7 = u7 + 13;
            u8 = 50;
        end;

        u5:Fire(GuiInset);
        local Y = GuiInset.Y;

        if Y ~= u2 then
            u2 = Y;
            task.defer(function() -- Line: 88
                -- upvalues: u3 (ref), Y (copy)
                u3.insetHeightChanged:Fire(Y);
            end);
        end;
    end;

    GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(checkInset);
    checkInset("FirstTime");
    local ScreenGui = Instance.new("ScreenGui");
    u5:Connect(function() -- Line: 98
        -- upvalues: ScreenGui (copy), u6 (ref)
        ScreenGui:SetAttribute("StartInset", u6);
    end);
    ScreenGui.Name = "TopbarStandard";
    ScreenGui.Enabled = true;
    ScreenGui.DisplayOrder = u3.baseDisplayOrder;
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets;
    v4[ScreenGui.Name] = ScreenGui;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 109
        -- upvalues: ScreenGui (copy), u3 (copy)
        ScreenGui.DisplayOrder = u3.baseDisplayOrder;
    end);
    local Frame = Instance.new("Frame");
    Frame.Name = "Holders";
    Frame.BackgroundTransparency = 1;
    u5:Connect(function() -- Line: 116
        -- upvalues: u11 (ref), u10 (ref), u8 (ref), Frame (copy), u7 (ref)
        local v14 = u11 and 36 or 56;
        local v15;

        if u10 then
            v15 = UDim2.new(1, 0, 0, v14);
        else
            v15 = UDim2.new(1, 0, 1, u8);
        end;

        Frame.Position = UDim2.new(0, 0, 0, u7);
        Frame.Size = v15;
    end);
    Frame.Visible = true;
    Frame.ZIndex = 1;
    Frame.Parent = ScreenGui;
    local u16 = ScreenGui:Clone();
    local Holders = u16.Holders;

    local function updateCenteredHoldersHeight() -- Line: 128
        -- upvalues: Holders (copy), GuiService (copy), u8 (ref)
        Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u8);
    end;

    u16.Name = "TopbarCentered";
    u16.DisplayOrder = u3.baseDisplayOrder;
    u16.ScreenInsets = Enum.ScreenInsets.None;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 134
        -- upvalues: u16 (copy), u3 (copy)
        u16.DisplayOrder = u3.baseDisplayOrder;
    end);
    v4[u16.Name] = u16;
    u5:Connect(updateCenteredHoldersHeight);
    Holders.Size = UDim2.new(1, 0, 0, GuiService.TopbarInset.Height + u8);
    local u17 = ScreenGui:Clone();
    u17.Name = u17.Name .. "Clipped";
    u17.DisplayOrder = u3.baseDisplayOrder + 1;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 145
        -- upvalues: u17 (copy), u3 (copy)
        u17.DisplayOrder = u3.baseDisplayOrder + 1;
    end);
    v4[u17.Name] = u17;
    local u18 = u16:Clone();
    u18.Name = u18.Name .. "Clipped";
    u18.DisplayOrder = u3.baseDisplayOrder + 1;
    u3.baseDisplayOrderChanged:Connect(function() -- Line: 153
        -- upvalues: u18 (copy), u3 (copy)
        u18.DisplayOrder = u3.baseDisplayOrder + 1;
    end);
    v4[u18.Name] = u18;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame:SetAttribute("IsAHolder", true);
    ScrollingFrame.Name = "Left";
    u5:Connect(function() -- Line: 162
        -- upvalues: ScrollingFrame (copy), u6 (ref)
        ScrollingFrame.Position = UDim2.fromOffset(u6, 0);
    end);
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.Visible = true;
    ScrollingFrame.ZIndex = 1;
    ScrollingFrame.Active = false;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X;
    ScrollingFrame.ScrollBarThickness = 0;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.Selectable = false;
    ScrollingFrame.ScrollingEnabled = false;
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    u5:Connect(function() -- Line: 183
        -- upvalues: UIListLayout (copy), u6 (ref)
        UIListLayout.Padding = UDim.new(0, u6);
    end);
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom;
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left;
    UIListLayout.Parent = ScrollingFrame;
    local u19 = ScrollingFrame:Clone();
    u5:Connect(function() -- Line: 193
        -- upvalues: u19 (copy), u6 (ref)
        u19.UIListLayout.Padding = UDim.new(0, u6);
    end);
    u19.ScrollingEnabled = false;
    u19.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    u19.Name = "Center";
    u19.Parent = Holders;
    local u20 = ScrollingFrame:Clone();
    u5:Connect(function() -- Line: 202
        -- upvalues: u20 (copy), u6 (ref)
        u20.UIListLayout.Padding = UDim.new(0, u6);
    end);
    u20.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right;
    u20.Name = "Right";
    u20.AnchorPoint = Vector2.new(1, 0);
    u20.Position = UDim2.new(1, -12, 0, 0);
    u20.Parent = Frame;
    u5:Fire(GuiInset);

    return v4;
end;
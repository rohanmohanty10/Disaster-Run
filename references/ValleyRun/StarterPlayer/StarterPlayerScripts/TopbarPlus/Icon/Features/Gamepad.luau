 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[[
-- As the name suggests, this handles everything related to gamepads
-- (i.e. Xbox or Playstation controllers) and their navigation
-- I created a separate module for gamepads (and not touchpads or
-- keyboards) because gamepads are greatly more unqiue and require
-- additional tailored programming



-- SERVICES
local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")



-- LOCAL
local DEFAULT_HIGHLIGHT_KEY = Enum.KeyCode.DPadUp -- The default key to highlight the topbar icon
local GAMEPAD_INPUT = Enum.PreferredInput.Gamepad
local Gamepad = {}
local Icon



-- FUNCTIONS
-- This is called upon the Icon initializing
function Gamepad.start(incomingIcon)
	
	-- Public variables
	Icon = incomingIcon
	Icon.highlightKey = if Icon.highlightKey ~= nil then Icon.highlightKey else DEFAULT_HIGHLIGHT_KEY -- What controller key to highlight the topbar (or set to false to disable)
	Icon.highlightIcon = false -- Change to a specific icon if you'd like to highlight a specific icon instead of the left-most
	
	-- We defer so the developer can make changes before the
	-- gamepad controls are initialized
	task.delay(1, function()
		-- Some local utility
		local iconsDict = Icon.iconsDictionary
		local function getIconFromSelectedObject()
			local clickRegion = GuiService.SelectedObject
			local iconUID = clickRegion and clickRegion:GetAttribute("CorrespondingIconUID")
			local icon = iconUID and iconsDict[iconUID]
			return icon
		end
		
		-- This enables users to instantly open up their last selected icon
		local previousHighlightedIcon
		local usedIndicatorOnce = DEFAULT_HIGHLIGHT_KEY ~= Icon.highlightKey
		local usedBOnce = DEFAULT_HIGHLIGHT_KEY ~= Icon.highlightKey
		local Selection = require(script.Parent.Parent.Elements.Selection)
		local function updateSelectedObject()
			local icon = getIconFromSelectedObject()
			local isUsingGamepad = UserInputService.PreferredInput == GAMEPAD_INPUT
			if icon then
				if isUsingGamepad then
					local clickRegion = icon:getInstance("ClickRegion")
					local selection = icon.selection
					if not selection then
						selection = icon.janitor:add(Selection(Icon))
						selection:SetAttribute("IgnoreVisibilityUpdater", true)
						selection.Parent = icon.widget
						icon.selection = selection
						icon:refreshAppearance(selection) --icon:clipOutside(selection)
					end
					clickRegion.SelectionImageObject = selection.Selection
				end
				if previousHighlightedIcon and previousHighlightedIcon ~= icon then
					previousHighlightedIcon:setIndicator()
				end
				local newIndicator = if isUsingGamepad and not usedBOnce and not icon.parentIconUID then Enum.KeyCode.ButtonB else nil
				previousHighlightedIcon = icon
				Icon.lastHighlightedIcon = icon
				icon:setIndicator(newIndicator)
			else
				local newIndicator = if isUsingGamepad and not usedIndicatorOnce then Icon.highlightKey else nil
				if not previousHighlightedIcon then
					previousHighlightedIcon = Gamepad.getIconToHighlight()
				end
				if newIndicator == Icon.highlightKey then
					-- We only display the highlightKey once to show
					-- the user how to highlight the topbar icon
					usedIndicatorOnce = true
				else
					--usedBOnce = true
				end
				if previousHighlightedIcon then
					previousHighlightedIcon:setIndicator(newIndicator)
				end
			end
		end
		GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject)

		-- This listens for a gamepad being present/added/removed
		local function preferredInputChanged()
			local preferredInput = UserInputService.PreferredInput
			local isUsingGamepad = preferredInput == GAMEPAD_INPUT

			if not isUsingGamepad then
				usedIndicatorOnce = false
				usedBOnce = false
			end
			updateSelectedObject()
		end
		UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged)
		preferredInputChanged()

		-- This allows for easy highlighting of the topbar when the
		-- when ``Icon.highlightKey`` (i.e. DPadUp) is pressed.
		-- If you'd like to disable, do ``Icon.highlightKey = false``
		UserInputService.InputBegan:Connect(function(input, touchingAnObject)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				-- Sometimes the Roblox gamepad glitches when combined with a cursor
				-- This fixes that by unhighlighting if the cursor is pressed down
				-- (i.e. a mouse click)
				local icon = getIconFromSelectedObject()
				if icon then
					GuiService.SelectedObject = nil
				end
				return
			end
			if input.KeyCode ~= Icon.highlightKey then
				return
			end
			local iconToHighlight = Gamepad.getIconToHighlight()
			if iconToHighlight then
				if GamepadService.GamepadCursorEnabled then
					task.wait(0.2)
					GamepadService:DisableGamepadCursor()
				end
				local clickRegion = iconToHighlight:getInstance("ClickRegion")
				GuiService.SelectedObject = clickRegion
			end
		end)
	end)
end

function Gamepad.getIconToHighlight()
	-- If an icon has already been selected, returns the last selected icon
	-- Else if more than 0 icons, it selects the left-most icon
	local iconsDict = Icon.iconsDictionary
	local iconToHighlight = Icon.highlightIcon or Icon.lastHighlightedIcon
	if not iconToHighlight then
		local currentX
		for _, icon in pairs(iconsDict) do
			if icon.parentIconUID then
				continue
			end
			local thisX = icon.widget.AbsolutePosition.X
			if not currentX or thisX < currentX then
				iconToHighlight = icon
				currentX = iconToHighlight.widget.AbsolutePosition.X
			end
		end
	end
	return iconToHighlight
end

-- This called when the icon's ClickRegion is created
function Gamepad.registerButton(buttonInstance)
	-- This provides a basic level of support for controllers by making
	-- the icons easy to highlight via the virtual cursor, then
	-- when selected, focuses in on the selected icon and hops
	-- between other nearby icons simply by toggling the joystick
	local inputBegan = false
	buttonInstance.InputBegan:Connect(function(input)
		-- Two wait frames required to ensure inputBegan is detected within
		-- UserInputService.InputBegan. We do this because object.InputBegan
		-- does not return the correct input objects (unlike the service)
		inputBegan = true
		task.wait()
		task.wait()
		inputBegan = false
	end)
	local connection = UserInputService.InputBegan:Connect(function(input)
		task.wait()
		if input.KeyCode == Enum.KeyCode.ButtonA and inputBegan then
			-- We focus on an icon when selected via the virtual cursor
			task.wait(0.2)
			GamepadService:DisableGamepadCursor()
			GuiService.SelectedObject = buttonInstance
			return
		end
		local isSelected = GuiService.SelectedObject == buttonInstance
		local unselectKeyCodes = {"ButtonB", "ButtonSelect"}
		local keyName = input.KeyCode.Name
		if table.find(unselectKeyCodes, keyName) and isSelected then
			-- We unfocus when back button is pressed, but ignore
			-- if the virtual cursor is disabled otherwise it will be
			-- impossible to select the topbar
			if not(keyName == "ButtonSelect" and not GamepadService.GamepadCursorEnabled) then
				GuiService.SelectedObject = nil
			end
		end
	end)
	buttonInstance.Destroying:Once(function()
		connection:Disconnect()
	end)
end



return Gamepad

]]

 

local GamepadService = game:GetService("GamepadService");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local DPadUp = Enum.KeyCode.DPadUp;
local Gamepad = Enum.PreferredInput.Gamepad;
local u1 = {};
local u2 = nil;

function u1.start(p3) -- Line: 26
    -- upvalues: u2 (ref), DPadUp (copy), GuiService (copy), UserInputService (copy), Gamepad (copy), u1 (copy), GamepadService (copy)
    u2 = p3;
    local v4;

    if u2.highlightKey == nil then
        v4 = DPadUp;
    else
        v4 = u2.highlightKey;
    end;

    u2.highlightKey = v4;
    u2.highlightIcon = false;
    task.delay(1, function() -- Line: 35
        -- upvalues: u2 (ref), GuiService (ref), DPadUp (ref), UserInputService (ref), Gamepad (ref), u1 (ref), GamepadService (ref)
        local iconsDictionary = u2.iconsDictionary;

        local function getIconFromSelectedObject() -- Line: 38
            -- upvalues: GuiService (ref), iconsDictionary (copy)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            return SelectedObject;
        end;

        local u5 = nil;
        local u6 = DPadUp ~= u2.highlightKey;
        local u7 = DPadUp ~= u2.highlightKey;
        local Selection = require(script.Parent.Parent.Elements.Selection);

        local function updateSelectedObject() -- Line: 50
            -- upvalues: GuiService (ref), iconsDictionary (copy), UserInputService (ref), Gamepad (ref), Selection (copy), u2 (ref), u5 (ref), u7 (ref), u6 (ref), u1 (ref)
            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            local v8 = UserInputService.PreferredInput == Gamepad;

            if not SelectedObject then
                local v9;

                if v8 and not u6 then
                    v9 = u2.highlightKey;
                else
                    v9 = nil;
                end;

                if not u5 then
                    u5 = u1.getIconToHighlight();
                end;

                if v9 == u2.highlightKey then
                    u6 = true;
                end;

                if u5 then
                    u5:setIndicator(v9);
                end;

                return;
            end;

            if v8 then
                local Instance = SelectedObject:getInstance("ClickRegion");
                local selection = SelectedObject.selection;

                if not selection then
                    selection = SelectedObject.janitor:add(Selection(u2));
                    selection:SetAttribute("IgnoreVisibilityUpdater", true);
                    selection.Parent = SelectedObject.widget;
                    SelectedObject.selection = selection;
                    SelectedObject:refreshAppearance(selection);
                end;

                Instance.SelectionImageObject = selection.Selection;
            end;

            if u5 and u5 ~= SelectedObject then
                u5:setIndicator();
            end;

            local v10;

            if v8 and not (u7 or SelectedObject.parentIconUID) then
                v10 = Enum.KeyCode.ButtonB;
            else
                v10 = nil;
            end;

            u5 = SelectedObject;
            u2.lastHighlightedIcon = SelectedObject;
            SelectedObject:setIndicator(v10);
        end;

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject);

        local function preferredInputChanged() -- Line: 93
            -- upvalues: UserInputService (ref), Gamepad (ref), u6 (ref), u7 (ref), updateSelectedObject (copy)
            if UserInputService.PreferredInput ~= Gamepad then
                u6 = false;
                u7 = false;
            end;

            updateSelectedObject();
        end;

        UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(preferredInputChanged);

        if UserInputService.PreferredInput ~= Gamepad then
            u6 = false;
            u7 = false;
        end;

        updateSelectedObject();
        UserInputService.InputBegan:Connect(function(p11, p12) -- Line: 109
            -- upvalues: GuiService (ref), iconsDictionary (copy), u2 (ref), u1 (ref), GamepadService (ref)
            if p11.UserInputType ~= Enum.UserInputType.MouseButton1 then
                if p11.KeyCode ~= u2.highlightKey then
                    return;
                end;

                local IconToHighlight = u1.getIconToHighlight();

                if IconToHighlight then
                    if GamepadService.GamepadCursorEnabled then
                        task.wait(0.2);
                        GamepadService:DisableGamepadCursor();
                    end;

                    GuiService.SelectedObject = IconToHighlight:getInstance("ClickRegion");
                end;

                return;
            end;

            local SelectedObject = GuiService.SelectedObject;

            if SelectedObject then
                SelectedObject = SelectedObject:GetAttribute("CorrespondingIconUID");
            end;

            if SelectedObject then
                SelectedObject = iconsDictionary[SelectedObject];
            end;

            if SelectedObject then
                GuiService.SelectedObject = nil;
            end;
        end);
    end);
end;

function u1.getIconToHighlight() -- Line: 136
    -- upvalues: u2 (ref)
    local iconsDictionary = u2.iconsDictionary;
    local v13 = u2.highlightIcon or u2.lastHighlightedIcon;

    if not v13 then
        local v14 = nil;

        for _, v in pairs(iconsDictionary) do
            if not (v.parentIconUID or v14 and v.widget.AbsolutePosition.X >= v14) then
                v14 = v.widget.AbsolutePosition.X;
                v13 = v;
            end;
        end;
    end;

    return v13;
end;

function u1.registerButton(u15) -- Line: 158
    -- upvalues: UserInputService (copy), GamepadService (copy), GuiService (copy)
    local u16 = false;
    u15.InputBegan:Connect(function(p17) -- Line: 164
        -- upvalues: u16 (ref)
        u16 = true;
        task.wait();
        task.wait();
        u16 = false;
    end);
    local u20 = UserInputService.InputBegan:Connect(function(p18) -- Line: 173
        -- upvalues: u16 (ref), GamepadService (ref), GuiService (ref), u15 (copy)
        task.wait();

        if p18.KeyCode == Enum.KeyCode.ButtonA and u16 then
            task.wait(0.2);
            GamepadService:DisableGamepadCursor();
            GuiService.SelectedObject = u15;

            return;
        end;

        local v19 = GuiService.SelectedObject == u15;
        local Name = p18.KeyCode.Name;

        if table.find({ "ButtonB", "ButtonSelect" }, Name) and (v19 and (Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled)) then
            GuiService.SelectedObject = nil;
        end;
    end);
    u15.Destroying:Once(function() -- Line: 194
        -- upvalues: u20 (copy)
        u20:Disconnect();
    end);
end;

return u1;
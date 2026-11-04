 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=92368439343389

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- The functions here are dedicated solely to managing theme state
-- and updating the appearance of instances to match that state.
-- You don't need to use any of these functions, the useful ones
-- have been abstracted as icon methods



-- LOCAL
local Themes = {}
local Utility = require(script.Parent.Parent.Utility)
local baseTheme = require(script.Default)
local isStudio = game:GetService("RunService"):IsStudio()
local alreadyWarned = {}

-- Some elements like Caption and Notice are only built once they're used, so a theme
-- can name them before they exist. Add any new element names here or they'll warn in Studio
local KNOWN_INSTANCE_NAMES = {
	"Box", "Caption", "CaptionCorner", "Caret", "ClickRegion", "Contents", "ContentsList", "DropShadow",
	"Dropdown", "DropdownCorner", "DropdownList", "DropdownPadding", "DropdownScroller", "DropdownSpeed",
	"Header", "Hotkeys", "IconButton", "IconCorners", "IconGradient", "IconImage", "IconImageCorner",
	"IconImageRatio", "IconImageScale", "IconLabel", "IconLabelContainer", "IconOverlay", "IconSpot",
	"IconSpotGradient", "Indicator", "IndicatorButton", "Inset", "Key1", "LabelContent", "Layout", "Layout1",
	"Menu", "MenuGap", "MenuUIListLayout", "Notice", "NoticeLabel", "OverlayUICorner", "Padding",
	"PaddingCenter", "PaddingLeft", "PaddingRight", "Selection", "SelectionContainer", "SelectionGradient",
	"UICorner", "UIStroke", "Widget",
}

-- Every attribute TopbarPlus relies on (like MinimumWidth) gets its default in the base theme,
-- so any property named there is a deliberate attribute rather than a typo
local baseThemeProperties = {}
for _, detail in pairs(baseTheme) do
	baseThemeProperties[detail[2]] = true
end



-- LOCAL FUNCTIONS
local function warnOnce(key, message)
	if alreadyWarned[key] then
		return
	end
	alreadyWarned[key] = true
	warn(`TopbarPlus: {message} (this warning only shows in Studio)`)
end



-- FUNCTIONS
function Themes.getThemeValue(stateGroup, instanceName, property, iconState)
	if stateGroup then
		for _, detail in pairs(stateGroup) do
			local checkingInstanceName, checkingPropertyName, checkingValue = unpack(detail)
			if instanceName == checkingInstanceName and property == checkingPropertyName then
				return checkingValue
			end
		end
	end
	return nil
end

function Themes.getInstanceValue(instance, property)
	local success, value = pcall(function()
		return instance[property]
	end)
	if not success then
		value = instance:GetAttribute(property)
	end
	return value
end

function Themes.getRealInstance(instance)
	if not instance:GetAttribute("IsAClippedClone") then
		return
	end
	local originalInstance = instance:FindFirstChild("OriginalInstance")
	if not originalInstance then
		return
	end
	return originalInstance.Value
end

function Themes.getClippedClone(instance)
	if not instance:GetAttribute("HasAClippedClone") then
		return
	end
	local clippedClone = instance:FindFirstChild("ClippedClone")
	if not clippedClone then
		return
	end
	return clippedClone.Value
end

function Themes.getActiveGroup(icon)
	-- Hovering happens on both selected and deselected icons, so its own values go on top
	-- of the look the icon already has instead of replacing it
	local stateGroup = icon:getStateGroup()
	if icon.activeState ~= "Viewing" then
		return stateGroup
	end
	local underlyingState = if icon.isSelected then "Selected" else "Deselected"
	local combined = {}
	local positions = {}
	for _, detail in pairs(icon:getStateGroup(underlyingState)) do
		table.insert(combined, detail)
		positions[detail[1].."-"..detail[2]] = #combined
	end
	for _, detail in pairs(stateGroup) do
		local detailState = detail[4]
		if typeof(detailState) == "string" and string.lower(detailState) == "viewing" then
			local position = positions[detail[1].."-"..detail[2]]
			if position then
				combined[position] = detail
			else
				table.insert(combined, detail)
			end
		end
	end
	return combined
end

function Themes.refresh(icon, instance, specificProperty)
	-- Some instances such as notices need immediate refreshing upon creation as
	-- they're added in after the initial refresh period
	if specificProperty then
		local stateGroup = Themes.getActiveGroup(icon)
		local value = Themes.getThemeValue(stateGroup, instance.Name, specificProperty) or Themes.getInstanceValue(instance, specificProperty)
		Themes.apply(icon, instance, specificProperty, value, true)
		return
	end
	-- If no property is specified we update all properties that exist within
	-- the applied theme appearance
	local stateGroup = Themes.getActiveGroup(icon)
	if not stateGroup then
		return
	end
	local validInstances = {[instance.Name] = instance}
	for _, child in pairs(instance:GetDescendants()) do
		local collective = child:GetAttribute("Collective")
		if collective then
			validInstances[collective] = child
		end
		validInstances[child.Name] = child
	end
	for _, detail in pairs(stateGroup) do
		local checkingInstanceName, checkingPropertyName, checkingValue = unpack(detail)
		local instanceToUpdate = validInstances[checkingInstanceName]
		if instanceToUpdate then
			Themes.apply(icon, instanceToUpdate.Name, checkingPropertyName, checkingValue, true)
		end
	end
	return
end

function Themes.apply(icon, collectiveOrInstanceNameOrInstance, property, value, forceApply)
	-- This is responsible for **applying** appearance changes to instances within the icon
	-- however it IS NOT responsible for updating themes. Use :modifyTheme for that.
	-- This also calls callbacks given by :setBehaviour before applying these property changes
	-- to the given instances
	if icon.isDestroyed then
		return
	end
	local instances
	local collectiveOrInstanceName = collectiveOrInstanceNameOrInstance
	if typeof(collectiveOrInstanceNameOrInstance) == "Instance" then
		instances = {collectiveOrInstanceNameOrInstance}
		collectiveOrInstanceName = collectiveOrInstanceNameOrInstance.Name
	else
		instances = icon:getInstanceOrCollective(collectiveOrInstanceNameOrInstance)
	end
	local key = collectiveOrInstanceName.."-"..property
	local customBehaviour = icon.customBehaviours[key]
	for _, instance in pairs(instances) do
		local clippedClone = Themes.getClippedClone(instance)
		if clippedClone then
			-- This means theme effects are applied to both the original
			-- instance and its clone (instead of just the instance).
			-- This is important for some properties such as position
			-- and size which might be dictated by the clone
			table.insert(instances, clippedClone)
		end
	end
	for _, instance in pairs(instances) do
		if property == "Position" and Themes.getClippedClone(instance) then
			-- The clone manages the position of the real instance so ignore
			continue
		elseif property == "Size" and Themes.getRealInstance(instance) then
			-- The real instance manages the size of the clone so ignore
			continue
		end
		local currentValue = Themes.getInstanceValue(instance, property)
		if not forceApply and value == currentValue then
			continue
		end
		if customBehaviour then
			local newValue = customBehaviour(value, instance, property)
			if newValue ~= nil then
				value = newValue
			end
		end
		-- Content can't go into Image so it goes into ImageContent instead
		local propertyToSet = if property == "Image" and typeof(value) == "Content" then "ImageContent" else property
		local success = pcall(function()
			instance[propertyToSet] = value
		end)
		if not success then
			-- If property is not a real property, we set
			-- the value as an attribute instead. This is useful
			-- for instance in :setWidth where we also want to
			-- specify a desired width for every state which can
			-- then be easily read by the widget element
			local isExistingAttribute = instance:GetAttribute(property) ~= nil
			instance:SetAttribute(property, value)
			local isClippedClone = instance:GetAttribute("IsAClippedClone")
			if isStudio and not isClippedClone and not isExistingAttribute and not baseThemeProperties[property] then
				warnOnce(`Property-{collectiveOrInstanceName}-{property}`, `couldn't set {property} on {collectiveOrInstanceName} to {tostring(value)}. It's either not a real property or the value is the wrong type`)
			end
		end
	end
end

function Themes.getModifications(modifications)
	if typeof(modifications[1]) ~= "table" then
		-- This enables users to do :modifyTheme({a,b,c,d})
		-- in addition of :modifyTheme({{a,b,c,d}})
		modifications = {modifications}
	end
	return modifications
end

function Themes.checkModifications(modifications, icon)
	-- Typos in a theme used to fail silently, so we point them out while developing
	if not isStudio or typeof(modifications) ~= "table" then
		return
	end
	for _, modification in pairs(Themes.getModifications(modifications)) do
		local instanceName = modification[1]
		if typeof(instanceName) == "string" and not table.find(KNOWN_INSTANCE_NAMES, instanceName) then
			-- Your own instances (like ones added to an icon) are fine as long as they exist by now
			task.defer(function()
				if icon and not icon.isDestroyed and #icon:getInstanceOrCollective(instanceName) > 0 then
					return
				end
				warnOnce("Instance-"..instanceName, `a theme names "{instanceName}" but no icon instance has that name, so it won't change anything`)
			end)
		end
	end
end

function Themes.merge(detail, modification, callback)
	local instanceName, property, value, stateName = table.unpack(modification)
	local checkingInstanceName, checkingPropertyName, _, checkingStateName = table.unpack(detail)
	if instanceName == checkingInstanceName and property == checkingPropertyName and Themes.statesMatch(stateName, checkingStateName) then
		detail[3] = value
		if callback then
			callback(detail)
		end
		return true
	end
	return false
end

function Themes.modify(icon, modifications, modificationsUID)
	Themes.checkModifications(modifications, icon)
	-- This is what the 'old set' used to do (although for clarity that behaviour has now been
	-- split into two methods, .modifyTheme and .apply).
	-- modifyTheme is responsible for UPDATING the internal values within a theme for a particular
	-- state, then checking to see if the appearance of the icon needs to be updated.
	-- If no iconState is specified, the change is applied to both Deselected and Selected
	-- A modification can also be 'undone' using :removeModification and passing in
	-- the UID returned from this method
	task.spawn(function()
		modificationsUID = modificationsUID or Utility.generateUID()
		modifications = Themes.getModifications(modifications)
		for _, modification in pairs(modifications) do
			local instanceName, property, value, iconState = table.unpack(modification)
			if iconState == nil then
				-- If no state specified, apply to all states
				Themes.modify(icon, {instanceName, property, value, "Selected"}, modificationsUID)
				Themes.modify(icon, {instanceName, property, value, "Viewing"}, modificationsUID)
			end
			local chosenState = Utility.formatStateName(iconState or "Deselected")
			local stateGroup = icon:getStateGroup(chosenState)
			local function nowSetIt()
				if chosenState == icon.activeState then
					Themes.apply(icon, instanceName, property, value)
				end
			end
			local function updateRecord()
				for stateName, detail in pairs(stateGroup) do
					local didMerge = Themes.merge(detail, modification, function(detail)
						detail[5] = modificationsUID
						nowSetIt()
					end)
					if didMerge then
						return
					end
				end
				local detail = {instanceName, property, value, chosenState, modificationsUID}
				table.insert(stateGroup, detail)
				nowSetIt()
			end
			updateRecord()
		end
	end)
	return modificationsUID
end

function Themes.remove(icon, modificationsUID)
	for iconState, stateGroup in pairs(icon.appearance) do
		for i = #stateGroup, 1, -1 do
			local detail = stateGroup[i]
			local checkingUID = detail[5]
			if checkingUID == modificationsUID then
				table.remove(stateGroup, i)
			end
		end
	end
	Themes.rebuild(icon)
end

function Themes.removeWith(icon, instanceName, property, state)
	for iconState, stateGroup in pairs(icon.appearance) do
		if state == iconState or not state then
			for i = #stateGroup, 1, -1 do
				local detail = stateGroup[i]
				local detailName = detail[1]
				local detailProperty = detail[2]
				if detailName == instanceName and detailProperty == property then
					table.remove(stateGroup, i)
				end
			end
		end
	end
	Themes.rebuild(icon)
end

function Themes.change(icon)
	-- This changes the theme to the appearance of whatever
	-- state is currently active
	local stateGroup = Themes.getActiveGroup(icon)
	for _, detail in pairs(stateGroup) do
		local instanceName, property, value = unpack(detail)
		Themes.apply(icon, instanceName, property, value)
	end
end

function Themes.set(icon, theme)
	-- This is responsible for processing the final appearance of a given theme (such as
	-- ensuring Deselected merge into missing Selected, saving that internal state,
	-- then checking to see if the appearance of the icon needs to be updated
	local themesJanitor = icon.themesJanitor
	themesJanitor:clean()
	themesJanitor:add(icon.stateChanged:Connect(function()
		Themes.change(icon)
	end))
	if typeof(theme) == "Instance" and theme:IsA("ModuleScript") then
		local themeModule = theme :: ModuleScript
		theme = require(themeModule)
	end
	if theme ~= baseTheme then
		Themes.checkModifications(theme, icon)
	end
	icon.appliedTheme = theme
	Themes.rebuild(icon)
end

function Themes.statesMatch(state1, state2)
	-- States match if they have the same name OR if nil (because unspecified represents all states)
	local state1lower = (state1 and string.lower(state1))
	local state2lower = (state2 and string.lower(state2))
	return state1lower == state2lower or not state1 or not state2
end

function Themes.rebuild(icon)
	-- A note for my future self: this code can be optimised further by
	-- converting appearance into a instanceName-property dictionary
	-- as apposed to an array of every potential change. When converting
	-- in the future, .modify and .apply would also have to be updated.
	local appliedTheme = icon.appliedTheme
	local statesArray = {"Deselected", "Selected", "Viewing"}
	local function generateTheme()
		for _, stateName in pairs(statesArray) do
			-- This applies themes in layers
			-- The last layers take higher priority as they overwrite
			-- any duplicate earlier applied effects
			local stateAppearance = {}
			local function updateDetails(theme, incomingStateName)
				-- This ensures there's always a base 'default' layer
				if not theme then
					return
				end
				for _, detail in pairs(theme) do
					local modificationsUID = detail[5]
					local detailStateName = detail[4]
					if Themes.statesMatch(incomingStateName, detailStateName) then
						local key = detail[1].."-"..detail[2]
						local newDetail = Utility.copyTable(detail)
						newDetail[5] = modificationsUID
						stateAppearance[key] = newDetail
					end
				end
			end
			-- First we apply the base theme (i.e. the Default module)
			if stateName == "Selected" then
				updateDetails(baseTheme, "Deselected")
			end
			updateDetails(baseTheme, "Empty")
			updateDetails(baseTheme, stateName)
			-- Next we apply any custom themes by the games developer
			if appliedTheme ~= baseTheme then
				if stateName == "Selected" then
					updateDetails(appliedTheme, "Deselected")
				end
				updateDetails(appliedTheme, stateName)
			end
			-- Finally we apply any modifications that have already been made
			-- Modifiers are all the changes made using icon:modifyTheme(...)
			local alreadyAppliedTheme = {}
			local alreadyAppliedGroup = icon.appearance[stateName]
			if alreadyAppliedGroup then
				for _, modifier in pairs(alreadyAppliedGroup) do
					local modificationsUID = modifier[5]
					if modificationsUID ~= nil then
						local modification = {modifier[1], modifier[2], modifier[3], stateName, modificationsUID}
						table.insert(alreadyAppliedTheme, modification)
					end
				end
			end
			updateDetails(alreadyAppliedTheme, stateName)
			-- This now converts it into our final appearance
			local finalStateAppearance = {}
			for _, detail in pairs(stateAppearance) do
				table.insert(finalStateAppearance, detail)
			end
			icon.appearance[stateName] = finalStateAppearance
		end
		Themes.change(icon)
	end
	generateTheme()
end



return Themes

]=]

 

local u1 = {};
local Utility = require(script.Parent.Parent.Utility);
local script_Default = require(script.Default);

function u1.getThemeValue(p2, p3, p4, p5) -- Line: 16
    if p2 then
        for _, v in pairs(p2) do
            local v6, v7, v8 = unpack(v);

            if p3 == v6 and p4 == v7 then
                return v8;
            end;
        end;
    end;

    return nil;
end;

function u1.getInstanceValue(u9, u10) -- Line: 28
    local success, result = pcall(function() -- Line: 29
        -- upvalues: u9 (copy), u10 (copy)
        return u9[u10];
    end);

    if not success then
        result = u9:GetAttribute(u10);
    end;

    return result;
end;

function u1.getRealInstance(p11) -- Line: 38
    if not p11:GetAttribute("IsAClippedClone") then
        return;
    end;

    local OriginalInstance = p11:FindFirstChild("OriginalInstance");

    if OriginalInstance then
        return OriginalInstance.Value;
    end;
end;

function u1.getClippedClone(p12) -- Line: 49
    if not p12:GetAttribute("HasAClippedClone") then
        return;
    end;

    local ClippedClone = p12:FindFirstChild("ClippedClone");

    if ClippedClone then
        return ClippedClone.Value;
    end;
end;

function u1.refresh(p13, p14, p15) -- Line: 60
    -- upvalues: u1 (copy)
    if p15 then
        local StateGroup = p13:getStateGroup();
        local v16 = u1.getThemeValue(StateGroup, p14.Name, p15) or u1.getInstanceValue(p14, p15);
        u1.apply(p13, p14, p15, v16, true);

        return;
    end;

    local StateGroup = p13:getStateGroup();

    if not StateGroup then
        return;
    end;

    local v17 = {
        [p14.Name] = p14
    };

    for _, descendant in pairs(p14:GetDescendants()) do
        local Attribute = descendant:GetAttribute("Collective");

        if Attribute then
            v17[Attribute] = descendant;
        end;

        v17[descendant.Name] = descendant;
    end;

    for _, v in pairs(StateGroup) do
        local v18, v19, v20 = unpack(v);
        local v21 = v17[v18];

        if v21 then
            u1.apply(p13, v21.Name, v19, v20, true);
        end;
    end;
end;

function u1.apply(p22, p23, u24, u25, p26) -- Line: 93
    -- upvalues: u1 (copy)
    if p22.isDestroyed then
        return;
    end;

    local v27;

    if typeof(p23) == "Instance" then
        p23 = p23.Name;
        v27 = { p23 };
    else
        v27 = p22:getInstanceOrCollective(p23);
    end;

    local v28 = p22.customBehaviours[p23 .. "-" .. u24];

    for _, v in pairs(v27) do
        local ClippedClone = u1.getClippedClone(v);

        if ClippedClone then
            table.insert(v27, ClippedClone);
        end;
    end;

    for _, v in pairs(v27) do
        if u24 ~= "Position" or not u1.getClippedClone(v) then
            if (u24 ~= "Size" or not u1.getRealInstance(v)) and (p26 or u25 ~= u1.getInstanceValue(v, u24)) then
                if v28 then
                    local v29 = v28(u25, v, u24);

                    if v29 ~= nil then
                        u25 = v29;
                    end;
                end;

                if not pcall(function() -- Line: 139
                    -- upvalues: v (copy), u24 (copy), u25 (ref)
                    v[u24] = u25;
                end) then
                    v:SetAttribute(u24, u25);
                end;
            end;
        end;
    end;
end;

function u1.getModifications(p30) -- Line: 153
    return typeof(p30[1]) ~= "table" and { p30 } or p30;
end;

function u1.merge(p31, p32, p33) -- Line: 162
    -- upvalues: u1 (copy)
    local table_unpack_ret, v34, v35, v36 = table.unpack(p32);
    local table_unpack_ret2, v37, _, v38 = table.unpack(p31);

    if table_unpack_ret ~= table_unpack_ret2 or (v34 ~= v37 or not u1.statesMatch(v36, v38)) then
        return false;
    end;

    p31[3] = v35;

    if p33 then
        p33(p31);
    end;

    return true;
end;

function u1.modify(u39, u40, u41) -- Line: 175
    -- upvalues: Utility (copy), u1 (copy)
    task.spawn(function() -- Line: 183
        -- upvalues: u41 (ref), Utility (ref), u40 (ref), u1 (ref), u39 (copy)
        u41 = u41 or Utility.generateUID();
        u40 = u1.getModifications(u40);

        for _, v in pairs(u40) do
            local table_unpack_ret, u42, u43, v44 = table.unpack(v);

            if v44 == nil then
                u1.modify(u39, {
                    table_unpack_ret,
                    u42,
                    u43,
                    "Selected"
                }, u41);
                u1.modify(u39, {
                    table_unpack_ret,
                    u42,
                    u43,
                    "Viewing"
                }, u41);
            end;

            local u45 = Utility.formatStateName(v44 or "Deselected");
            local StateGroup = u39:getStateGroup(u45);

            local function nowSetIt() -- Line: 195
                -- upvalues: u45 (copy), u39 (ref), u1 (ref), table_unpack_ret (copy), u42 (copy), u43 (copy)
                if u45 == u39.activeState then
                    u1.apply(u39, table_unpack_ret, u42, u43);
                end;
            end;

            (function() -- Line: 200, Name: updateRecord
                -- upvalues: StateGroup (copy), u1 (ref), v (copy), u41 (ref), u45 (copy), u39 (ref), table_unpack_ret (copy), u42 (copy), u43 (copy)
                for _, v2 in pairs(StateGroup) do
                    if u1.merge(v2, v, function(p46) -- Line: 202
                        -- upvalues: u41 (ref), u45 (ref), u39 (ref), u1 (ref), table_unpack_ret (ref), u42 (ref), u43 (ref)
                        p46[5] = u41;

                        if u45 == u39.activeState then
                            u1.apply(u39, table_unpack_ret, u42, u43);
                        end;
                    end) then
                        return;
                    end;
                end;

                table.insert(StateGroup, {
                    table_unpack_ret,
                    u42,
                    u43,
                    u45,
                    u41
                });

                if u45 == u39.activeState then
                    u1.apply(u39, table_unpack_ret, u42, u43);
                end;
            end)();
        end;
    end);

    return u41;
end;

function u1.remove(p47, p48) -- Line: 220
    -- upvalues: u1 (copy)
    for _, v in pairs(p47.appearance) do
        local v49 = v;

        for i = #v, 1, -1 do
            local v50;

            if v49[i][5] == p48 then
                table.remove(v49, i);
                v50 = i;
            else
                v50 = i;
            end;
        end;
    end;

    u1.rebuild(p47);
end;

function u1.removeWith(p51, p52, p53, p54) -- Line: 233
    -- upvalues: u1 (copy)
    for i, v in pairs(p51.appearance) do
        if p54 == i or not p54 then
            local v55 = v;

            for i2 = #v, 1, -1 do
                local v56 = v55[i2];
                local v57;

                if v56[1] == p52 and v56[2] == p53 then
                    table.remove(v55, i2);
                    v57 = i2;
                else
                    v57 = i2;
                end;
            end;
        end;
    end;

    u1.rebuild(p51);
end;

function u1.change(p58) -- Line: 249
    -- upvalues: u1 (copy)
    local StateGroup = p58:getStateGroup();

    for _, v in pairs(StateGroup) do
        local v59, v60, v61 = unpack(v);
        u1.apply(p58, v59, v60, v61);
    end;
end;

function u1.set(u62, p63) -- Line: 259
    -- upvalues: u1 (copy)
    local themesJanitor = u62.themesJanitor;
    themesJanitor:clean();
    themesJanitor:add(u62.stateChanged:Connect(function() -- Line: 265
        -- upvalues: u1 (ref), u62 (copy)
        u1.change(u62);
    end));

    if typeof(p63) == "Instance" and p63:IsA("ModuleScript") then
        p63 = require(p63);
    end;

    u62.appliedTheme = p63;
    u1.rebuild(u62);
end;

function u1.statesMatch(p64, p65) -- Line: 275
    local v66;

    if p64 then
        v66 = string.lower(p64);
    else
        v66 = p64;
    end;

    local v67;

    if p65 then
        v67 = string.lower(p65);
    else
        v67 = p65;
    end;

    return v66 == v67 and true or not (p64 and p65);
end;

function u1.rebuild(u68) -- Line: 282
    -- upvalues: u1 (copy), Utility (copy), script_Default (copy)
    local appliedTheme = u68.appliedTheme;
    local u69 = { "Deselected", "Selected", "Viewing" };
    (function() -- Line: 289, Name: generateTheme
        -- upvalues: u69 (copy), u1 (ref), Utility (ref), script_Default (ref), appliedTheme (copy), u68 (copy)
        for _, v in pairs(u69) do
            local u70 = {};

            local function updateDetails(p71, p72) -- Line: 295
                -- upvalues: u1 (ref), Utility (ref), u70 (copy)
                if not p71 then
                    return;
                end;

                for _, v2 in pairs(p71) do
                    local v73 = v2[5];

                    if u1.statesMatch(p72, v2[4]) then
                        local v74 = v2[1] .. "-" .. v2[2];
                        local v75 = Utility.copyTable(v2);
                        v75[5] = v73;
                        u70[v74] = v75;
                    end;
                end;
            end;

            if v == "Selected" then
                updateDetails(script_Default, "Deselected");
            end;

            updateDetails(script_Default, "Empty");
            updateDetails(script_Default, v);

            if appliedTheme ~= script_Default then
                if v == "Selected" then
                    updateDetails(appliedTheme, "Deselected");
                end;

                updateDetails(script_Default, "Empty");
                updateDetails(appliedTheme, v);
            end;

            local v76 = {};
            local v77 = u68.appearance[v];
            local v78;

            if v77 then
                v78 = v;

                for _, v2 in pairs(v77) do
                    local v79 = v2[5];

                    if v79 ~= nil then
                        table.insert(v76, {
                            v2[1],
                            v2[2],
                            v2[3],
                            v78,
                            v79
                        });
                    end;
                end;
            else
                v78 = v;
            end;

            updateDetails(v76, v78);
            local v80 = {};

            for _, v2 in pairs(u70) do
                table.insert(v80, v2);
            end;

            u68.appearance[v78] = v80;
        end;

        u1.change(u68);
    end)();
end;

return u1;
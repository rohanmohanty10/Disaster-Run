 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- CONFIG
local WHOLE_BODY_DETECTION_LIMIT = 729000 -- This is roughly the volume where Region3 checks begin to exceed 0.5% in Script Performance



-- LOCAL
local Janitor = require(script.Parent.Janitor)
local Enum_ = require(script.Parent.Enum)
local Signal = require(script.Parent.Signal)
local Tracker = require(script.Tracker)
local CollectiveWorldModel = require(script.CollectiveWorldModel)
local enum = Enum_.enums
local players = game:GetService("Players")
local activeZones = {}
local activeZonesTotalVolume = 0
local activeTriggers = {}
local registeredZones = {}
local activeParts = {}
local activePartToZone = {}
local allParts = {}
local allPartToZone = {}
local activeConnections = 0
local runService = game:GetService("RunService")
local heartbeat = runService.Heartbeat
local heartbeatConnections = {}
local localPlayer = runService:IsClient() and players.LocalPlayer



-- PUBLIC
local ZoneController = {}
local trackers = {}
trackers.player = Tracker.new("player")
trackers.item = Tracker.new("item")
ZoneController.trackers = trackers



-- LOCAL FUNCTIONS
local function dictLength(dictionary)
	local count = 0
	for _, _ in pairs(dictionary) do
		count += 1
	end
	return count
end

local function fillOccupants(zonesAndOccupantsTable, zone, occupant)
	local occupantsDict = zonesAndOccupantsTable[zone]
	if not occupantsDict then
		occupantsDict = {}
		zonesAndOccupantsTable[zone] = occupantsDict
	end
	local prevCharacter = occupant:IsA("Player") and occupant.Character
	occupantsDict[occupant] = (prevCharacter or true)
end

local heartbeatActions = {
	["player"] = function(recommendedDetection)
		return ZoneController._getZonesAndItems("player", activeZones, activeZonesTotalVolume, true, recommendedDetection)
	end,
	["localPlayer"] = function(recommendedDetection)
		local zonesAndOccupants = {}
		local character = localPlayer.Character
		if not character then
			return zonesAndOccupants
		end
		local touchingZones = ZoneController.getTouchingZones(character, true, recommendedDetection, trackers.player)
		for _, zone in pairs(touchingZones) do
			if zone.activeTriggers["localPlayer"] then
				fillOccupants(zonesAndOccupants, zone, localPlayer)
			end
		end
		return zonesAndOccupants
	end,
	["item"] = function(recommendedDetection)
		return ZoneController._getZonesAndItems("item", activeZones, activeZonesTotalVolume, true, recommendedDetection)
	end,
}



-- PRIVATE FUNCTIONS
function ZoneController._registerZone(zone)
   	registeredZones[zone] = true
	local registeredJanitor = zone.janitor:add(Janitor.new(), "destroy")
	zone._registeredJanitor = registeredJanitor
	registeredJanitor:add(zone.updated:Connect(function()
		ZoneController._updateZoneDetails()
	end), "Disconnect")
   ZoneController._updateZoneDetails()
end

function ZoneController._deregisterZone(zone)
	registeredZones[zone] = nil
	zone._registeredJanitor:destroy()
	zone._registeredJanitor = nil
	ZoneController._updateZoneDetails()
end

function ZoneController._registerConnection(registeredZone, registeredTriggerType)
	local originalItems = dictLength(registeredZone.activeTriggers)
	activeConnections += 1
	if originalItems == 0 then
		activeZones[registeredZone] = true
		ZoneController._updateZoneDetails()
	end
	local currentTriggerCount = activeTriggers[registeredTriggerType]
	activeTriggers[registeredTriggerType] = (currentTriggerCount and currentTriggerCount+1) or 1
	registeredZone.activeTriggers[registeredTriggerType] = true
	if registeredZone.touchedConnectionActions[registeredTriggerType] then
		registeredZone:_formTouchedConnection(registeredTriggerType)
	end
	if heartbeatActions[registeredTriggerType] then
		ZoneController._formHeartbeat(registeredTriggerType)
	end
end

-- This decides what to do if detection is 'Automatic'
-- This is placed in ZoneController instead of the Zone object due to the ZoneControllers all-knowing group-minded logic
function ZoneController.updateDetection(zone)
	local detectionTypes = {
		["enterDetection"] = "_currentEnterDetection",
		["exitDetection"] = "_currentExitDetection",
	}
	for detectionType, currentDetectionName in pairs(detectionTypes) do
		local detection = zone[detectionType]
		local combinedTotalVolume = Tracker.getCombinedTotalVolumes()
		if detection == enum.Detection.Automatic then
			if combinedTotalVolume > WHOLE_BODY_DETECTION_LIMIT then
				detection = enum.Detection.Centre
			else
				detection = enum.Detection.WholeBody
			end
		end
		zone[currentDetectionName] = detection
	end
end

function ZoneController._formHeartbeat(registeredTriggerType)
	local heartbeatConnection = heartbeatConnections[registeredTriggerType]
	if heartbeatConnection then return end
	-- This will only ever connect once per triggerType per server
	-- This means instead of initiating a loop per-zone we can handle everything within
	-- a singular connection. This is particularly beneficial for player/item-orinetated
	-- checking, where a check only needs to be cast once per interval, as apposed
	-- to every zone per interval
	-- I utilise heartbeat with os.clock() to provide precision (where needed) and flexibility
	local nextCheck = 0
	heartbeatConnection = heartbeat:Connect(function()
		local clockTime = os.clock()
		if clockTime >= nextCheck then
			local lowestAccuracy
			local lowestDetection
			for zone, _ in pairs(activeZones) do
				if zone.activeTriggers[registeredTriggerType] then
					local zAccuracy = zone.accuracy
					if lowestAccuracy == nil or zAccuracy < lowestAccuracy then
						lowestAccuracy = zAccuracy
					end
					ZoneController.updateDetection(zone)
					local zDetection = zone._currentEnterDetection
					if lowestDetection == nil or zDetection < lowestDetection then
						lowestDetection = zDetection
					end
				end
			end
			local highestAccuracy = lowestAccuracy
			local zonesAndOccupants = heartbeatActions[registeredTriggerType](lowestDetection)

			-- If a zone belongs to a settingsGroup with 'onlyEnterOnceExitedAll = true' , and the occupant already exists in a member group, then
			-- ignore all incoming occupants for the other zones (preventing the enteredSignal from being fired until the occupant has left
			-- all other zones within the same settingGroup)
			local occupantsToBlock = {}
			local zonesToPotentiallyIgnore = {}
			for zone, newOccupants in pairs(zonesAndOccupants) do
				local settingsGroup = (zone.settingsGroupName and ZoneController.getGroup(zone.settingsGroupName))
				if settingsGroup and settingsGroup.onlyEnterOnceExitedAll == true then
					--local currentOccupants = zone.occupants[registeredTriggerType]
					--if currentOccupants then
						for newOccupant, _ in pairs(newOccupants) do
							--if currentOccupants[newOccupant] then
								local groupDetail = occupantsToBlock[zone.settingsGroupName]
								if not groupDetail then
									groupDetail = {}
									occupantsToBlock[zone.settingsGroupName] = groupDetail
								end
								groupDetail[newOccupant] = zone
							--end
						end
						zonesToPotentiallyIgnore[zone] = newOccupants
					--end
				end
			end
			for zone, newOccupants in pairs(zonesToPotentiallyIgnore) do
				local groupDetail = occupantsToBlock[zone.settingsGroupName]
				if groupDetail then
					for newOccupant, _ in pairs(newOccupants) do
						local occupantToKeepZone = groupDetail[newOccupant]
						if occupantToKeepZone and occupantToKeepZone ~= zone then
							newOccupants[newOccupant] = nil
						end
					end
				end
			end

			-- This deduces what signals should be fired
			local collectiveSignalsToFire = {{}, {}}
			for zone, _ in pairs(activeZones) do
				if zone.activeTriggers[registeredTriggerType] then
					local zAccuracy = zone.accuracy
					local occupantsDict = zonesAndOccupants[zone] or {}
					local occupantsPresent = false
					for k,v in pairs(occupantsDict) do
						occupantsPresent = true
						break
					end
					if occupantsPresent and zAccuracy > highestAccuracy then
						highestAccuracy = zAccuracy
					end
					local signalsToFire = zone:_updateOccupants(registeredTriggerType, occupantsDict)
					collectiveSignalsToFire[1][zone] = signalsToFire.exited
					collectiveSignalsToFire[2][zone] = signalsToFire.entered
				end
			end

			-- This ensures all exited signals and called before entered signals
			local indexToSignalType = {"Exited", "Entered"}
			for index, zoneAndOccupants in pairs(collectiveSignalsToFire) do
				local signalType = indexToSignalType[index]
				local signalName = registeredTriggerType..signalType
				for zone, occupants in pairs(zoneAndOccupants) do
					local signal = zone[signalName]
					if signal then
						for _, occupant in pairs(occupants) do
							signal:Fire(occupant)
						end
					end
				end
			end

			local cooldown = enum.Accuracy.getProperty(highestAccuracy)
			nextCheck = clockTime + cooldown
		end
	end)
	heartbeatConnections[registeredTriggerType] = heartbeatConnection
end

function ZoneController._deregisterConnection(registeredZone, registeredTriggerType)
	activeConnections -= 1
	if activeTriggers[registeredTriggerType] == 1 then
		activeTriggers[registeredTriggerType] = nil
		local heartbeatConnection = heartbeatConnections[registeredTriggerType]
		if heartbeatConnection then
			heartbeatConnections[registeredTriggerType] = nil
			heartbeatConnection:Disconnect()
		end
	else
		activeTriggers[registeredTriggerType] -= 1
	end
	registeredZone.activeTriggers[registeredTriggerType] = nil
	if dictLength(registeredZone.activeTriggers) == 0 then
		activeZones[registeredZone] = nil
		ZoneController._updateZoneDetails()
	end
	if registeredZone.touchedConnectionActions[registeredTriggerType] then
		registeredZone:_disconnectTouchedConnection(registeredTriggerType)
	end
end

function ZoneController._updateZoneDetails()
	activeParts = {}
	activePartToZone = {}
	allParts = {}
	allPartToZone = {}
	activeZonesTotalVolume = 0
	for zone, _ in pairs(registeredZones) do
		local isActive = activeZones[zone]
		if isActive then
			activeZonesTotalVolume += zone.volume
		end
		for _, zonePart in pairs(zone.zoneParts) do
			if isActive then
				table.insert(activeParts, zonePart)
				activePartToZone[zonePart] = zone
			end
			table.insert(allParts, zonePart)
			allPartToZone[zonePart] = zone
		end
	end
end

function ZoneController._getZonesAndItems(trackerName, zonesDictToCheck, zoneCustomVolume, onlyActiveZones, recommendedDetection)
	local totalZoneVolume = zoneCustomVolume
	if not totalZoneVolume then
		for zone, _ in pairs(zonesDictToCheck) do
			totalZoneVolume += zone.volume
		end
	end
	local zonesAndOccupants = {}
	local tracker = trackers[trackerName]
	if tracker.totalVolume < totalZoneVolume then
		-- If the volume of all *characters/items* within the server is *less than* the total
		-- volume of all active zones (i.e. zones which listen for .playerEntered)
		-- then it's more efficient cast checks within each character and
		-- then determine the zones they belong to
		for _, item in pairs(tracker.items) do
			local touchingZones = ZoneController.getTouchingZones(item, onlyActiveZones, recommendedDetection, tracker)
			for _, zone in pairs(touchingZones) do
				if not onlyActiveZones or zone.activeTriggers[trackerName] then
					local finalItem = item
					if trackerName == "player" then
						finalItem = players:GetPlayerFromCharacter(item)
					end
					if finalItem then
						fillOccupants(zonesAndOccupants, zone, finalItem)
					end
				end
			end
		end
	else
		-- If the volume of all *active zones* within the server is *less than* the total
		-- volume of all characters/items, then it's more efficient to perform the
		-- checks directly within each zone to determine players inside
		for zone, _ in pairs(zonesDictToCheck) do
			if not onlyActiveZones or zone.activeTriggers[trackerName] then
				local result = CollectiveWorldModel:GetPartBoundsInBox(zone.region.CFrame, zone.region.Size, tracker.whitelistParams)
				local finalItemsDict = {}
				for _, itemOrChild in pairs(result) do
					local correspondingItem = tracker.partToItem[itemOrChild]
					if not finalItemsDict[correspondingItem] then
						finalItemsDict[correspondingItem] = true
					end
				end
				for item, _ in pairs(finalItemsDict) do
					if trackerName == "player" then
						local player = players:GetPlayerFromCharacter(item)
						if zone:findPlayer(player) then
							fillOccupants(zonesAndOccupants, zone, player)
						end
					elseif zone:findItem(item) then
						fillOccupants(zonesAndOccupants, zone, item)
					end
				end
			end
		end
	end
	return zonesAndOccupants
end



-- PUBLIC FUNCTIONS
function ZoneController.getZones()
	local registeredZonesArray = {}
	for zone, _ in pairs(registeredZones) do
		table.insert(registeredZonesArray, zone)
	end
	return registeredZonesArray
end

--[[
-- the player touched events which utilise active zones at the moment may change to the new CanTouch method for parts in the future
-- hence im disabling this as it may be depreciated quite soon
function ZoneController.getActiveZones()
	local zonesArray = {}
	for zone, _ in pairs(activeZones) do
		table.insert(zonesArray, zone)
	end
	return zonesArray
end
--]]

function ZoneController.getTouchingZones(item, onlyActiveZones, recommendedDetection, tracker)
	local exitDetection, finalDetection
	if tracker then
		exitDetection = tracker.exitDetections[item]
		tracker.exitDetections[item] = nil
	end
	finalDetection = exitDetection or recommendedDetection

	local itemSize, itemCFrame
	local itemIsBasePart = item:IsA("BasePart")
	local itemIsCharacter = not itemIsBasePart
	local bodyPartsToCheck = {}
	if itemIsBasePart then
		itemSize, itemCFrame = item.Size, item.CFrame
		table.insert(bodyPartsToCheck, item)
	elseif finalDetection == enum.Detection.WholeBody then
		itemSize, itemCFrame = Tracker.getCharacterSize(item)
		bodyPartsToCheck = item:GetChildren()
	else
		local hrp = item:FindFirstChild("HumanoidRootPart")
		if hrp then
			itemSize, itemCFrame = hrp.Size, hrp.CFrame
			table.insert(bodyPartsToCheck, hrp)
		end
	end
	if not itemSize or not itemCFrame then return {} end

	--[[
	local part = Instance.new("Part")
	part.Size = itemSize
	part.CFrame = itemCFrame
	part.Anchored = true
	part.CanCollide = false
	part.Color = Color3.fromRGB(255, 0, 0)
	part.Transparency = 0.4
	part.Parent = workspace
	game:GetService("Debris"):AddItem(part, 2)
	--]]
	local partsTable = (onlyActiveZones and activeParts) or allParts
	local partToZoneDict = (onlyActiveZones and activePartToZone) or allPartToZone

	local boundParams = OverlapParams.new()
	boundParams.FilterType = Enum.RaycastFilterType.Whitelist
	boundParams.MaxParts = #partsTable
	boundParams.FilterDescendantsInstances = partsTable

	-- This retrieves the bounds (the rough shape) of all parts touching the item/character
	-- If the corresponding zone is made up of *entirely* blocks then the bound will
	-- be the actual shape of the part.
	local touchingPartsDictionary = {}
	local zonesDict = {}
	local boundParts = CollectiveWorldModel:GetPartBoundsInBox(itemCFrame, itemSize, boundParams)
	local boundPartsThatRequirePreciseChecks = {}
	for _, boundPart in pairs(boundParts) do
		local correspondingZone = partToZoneDict[boundPart]
		if correspondingZone and correspondingZone.allZonePartsAreBlocks then
			zonesDict[correspondingZone] = true
			touchingPartsDictionary[boundPart] = correspondingZone
		else
			table.insert(boundPartsThatRequirePreciseChecks, boundPart)
		end
	end

	-- If the bound parts belong to a zone that isn't entirely made up of blocks, then
	-- we peform additional checks using GetPartsInPart which enables shape
	-- geometries to be precisely determined for non-block baseparts.
	local totalRemainingBoundParts = #boundPartsThatRequirePreciseChecks
	local precisePartsCount = 0
	if totalRemainingBoundParts > 0 then
		
		local preciseParams = OverlapParams.new()
		preciseParams.FilterType = Enum.RaycastFilterType.Whitelist
		preciseParams.MaxParts = totalRemainingBoundParts
		preciseParams.FilterDescendantsInstances = boundPartsThatRequirePreciseChecks

		local character = item
		for _, bodyPart in pairs(bodyPartsToCheck) do
			local endCheck = false
			if not bodyPart:IsA("BasePart") or (itemIsCharacter and Tracker.bodyPartsToIgnore[bodyPart.Name]) then
				continue
			end
			local preciseParts = CollectiveWorldModel:GetPartsInPart(bodyPart, preciseParams)
			for _, precisePart in pairs(preciseParts) do
				if not touchingPartsDictionary[precisePart] then
					local correspondingZone = partToZoneDict[precisePart]
					if correspondingZone then
						zonesDict[correspondingZone] = true
						touchingPartsDictionary[precisePart] = correspondingZone
						precisePartsCount += 1
					end
					if precisePartsCount == totalRemainingBoundParts then
						endCheck = true
						break
					end
				end
			end
			if endCheck then
				break
			end
		end
	end
	
	local touchingZonesArray = {}
	local newExitDetection
	for zone, _ in pairs(zonesDict) do
		if newExitDetection == nil or zone._currentExitDetection < newExitDetection then
			newExitDetection = zone._currentExitDetection
		end
		table.insert(touchingZonesArray, zone)
	end
	if newExitDetection and tracker then
		tracker.exitDetections[item] = newExitDetection
	end
	return touchingZonesArray, touchingPartsDictionary
end

local settingsGroups = {}
function ZoneController.setGroup(settingsGroupName, properties)
	local group = settingsGroups[settingsGroupName]
	if not group then
		group = {}
		settingsGroups[settingsGroupName] = group
	end
	

	-- PUBLIC PROPERTIES --
	group.onlyEnterOnceExitedAll = true
	
	-- PRIVATE PROPERTIES --
	group._name = settingsGroupName
	group._memberZones = {}


	if typeof(properties) == "table" then
		for k, v in pairs(properties) do
			group[k] = v
		end
	end
	return group
end

function ZoneController.getGroup(settingsGroupName)
	return settingsGroups[settingsGroupName]
end

local workspaceContainer
local workspaceContainerName = string.format("ZonePlus%sContainer", (runService:IsClient() and "Client") or "Server")
function ZoneController.getWorkspaceContainer()
	local container = workspaceContainer or workspace:FindFirstChild(workspaceContainerName)
	if not container then
		container = Instance.new("Folder")
		container.Name = workspaceContainerName
		container.Parent = workspace
		workspaceContainer = container
	end
	return container
end



return ZoneController
]=]

 

local Janitor = require(script.Parent.Janitor);
local Enum2 = require(script.Parent.Enum);
require(script.Parent.Signal);
local script_Tracker = require(script.Tracker);
local script_CollectiveWorldModel = require(script.CollectiveWorldModel);
local enums = Enum2.enums;
local Players = game:GetService("Players");
local u1 = {};
local u2 = 0;
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = 0;
local RunService = game:GetService("RunService");
local Heartbeat = RunService.Heartbeat;
local u10 = {};
local u11 = RunService:IsClient() and Players.LocalPlayer;
local u12 = {};
local u13 = {
    player = script_Tracker.new("player"),
    item = script_Tracker.new("item")
};
u12.trackers = u13;

local function dictLength(p14) -- Line: 40
    local v15 = 0;

    for _, _ in pairs(p14) do
        v15 = v15 + 1;
    end;

    return v15;
end;

local function fillOccupants(p16, p17, p18) -- Line: 48
    local v19 = p16[p17];

    if not v19 then
        v19 = {};
        p16[p17] = v19;
    end;

    local v20 = p18:IsA("Player") and p18.Character;
    v19[p18] = v20 or true;
end;

local u28 = {
    player = function(p21) -- Line: 59
        -- upvalues: u12 (copy), u1 (copy), u2 (ref)
        return u12._getZonesAndItems("player", u1, u2, true, p21);
    end,

    localPlayer = function(p22) -- Line: 62
        -- upvalues: u11 (copy), u12 (copy), u13 (copy)
        local v23 = {};
        local Character = u11.Character;

        if not Character then
            return v23;
        end;

        local TouchingZones = u12.getTouchingZones(Character, true, p22, u13.player);

        for _, v in pairs(TouchingZones) do
            if v.activeTriggers.localPlayer then
                local v24 = u11;
                local v25 = v23[v];

                if not v25 then
                    v25 = {};
                    v23[v] = v25;
                end;

                local v26 = v24:IsA("Player") and v24.Character;
                v25[v24] = v26 or true;
            end;
        end;

        return v23;
    end,

    item = function(p27) -- Line: 76
        -- upvalues: u12 (copy), u1 (copy), u2 (ref)
        return u12._getZonesAndItems("item", u1, u2, true, p27);
    end
};

function u12._registerZone(p29) -- Line: 84
    -- upvalues: u4 (copy), Janitor (copy), u12 (copy)
    u4[p29] = true;
    local v30 = p29.janitor:add(Janitor.new(), "destroy");
    p29._registeredJanitor = v30;
    v30:add(p29.updated:Connect(function() -- Line: 88
        -- upvalues: u12 (ref)
        u12._updateZoneDetails();
    end), "Disconnect");
    u12._updateZoneDetails();
end;

function u12._deregisterZone(p31) -- Line: 94
    -- upvalues: u4 (copy), u12 (copy)
    u4[p31] = nil;
    p31._registeredJanitor:destroy();
    p31._registeredJanitor = nil;
    u12._updateZoneDetails();
end;

function u12._registerConnection(p32, p33) -- Line: 101
    -- upvalues: u9 (ref), u1 (copy), u12 (copy), u3 (copy), u28 (copy)
    local v34 = 0;

    for _, _ in pairs(p32.activeTriggers) do
        v34 = v34 + 1;
    end;

    u9 = u9 + 1;

    if v34 == 0 then
        u1[p32] = true;
        u12._updateZoneDetails();
    end;

    local v35 = u3[p33];
    u3[p33] = v35 and v35 + 1 or 1;
    p32.activeTriggers[p33] = true;

    if p32.touchedConnectionActions[p33] then
        p32:_formTouchedConnection(p33);
    end;

    if u28[p33] then
        u12._formHeartbeat(p33);
    end;
end;

function u12.updateDetection(p36) -- Line: 121
    -- upvalues: script_Tracker (copy), enums (copy)
    for i, v in pairs({
        enterDetection = "_currentEnterDetection",
        exitDetection = "_currentExitDetection"
    }) do
        local v37 = p36[i];
        local CombinedTotalVolumes = script_Tracker.getCombinedTotalVolumes();

        if v37 == enums.Detection.Automatic then
            if CombinedTotalVolumes > 729000 then
                v37 = enums.Detection.Centre;
            else
                v37 = enums.Detection.WholeBody;
            end;
        end;

        p36[v] = v37;
    end;
end;

function u12._formHeartbeat(u38) -- Line: 140
    -- upvalues: u10 (copy), Heartbeat (copy), u1 (copy), u12 (copy), u28 (copy), enums (copy)
    if u10[u38] then
        return;
    end;

    local u39 = 0;
    u10[u38] = Heartbeat:Connect(function() -- Line: 150
        -- upvalues: u39 (ref), u1 (ref), u38 (copy), u12 (ref), u28 (ref), enums (ref)
        local os_clock_ret = os.clock();

        if u39 <= os_clock_ret then
            local v40 = nil;
            local v41 = nil;

            for i, _ in pairs(u1) do
                if i.activeTriggers[u38] then
                    local accuracy = i.accuracy;

                    if v40 ~= nil and accuracy >= v40 then
                        accuracy = v40;
                    end;

                    u12.updateDetection(i);
                    local _currentEnterDetection = i._currentEnterDetection;

                    if v41 == nil or _currentEnterDetection < v41 then
                        v41 = _currentEnterDetection;
                        v40 = accuracy;
                    else
                        v40 = accuracy;
                    end;
                end;
            end;

            local v42 = u28[u38](v41);
            local v43 = {};
            local v44 = {};

            for i, v in pairs(v42) do
                local v45 = i.settingsGroupName and u12.getGroup(i.settingsGroupName);

                if v45 and v45.onlyEnterOnceExitedAll == true then
                    local v46 = i;

                    for i2, _ in pairs(v) do
                        local v47 = v43[v46.settingsGroupName];

                        if not v47 then
                            v47 = {};
                            v43[v46.settingsGroupName] = v47;
                        end;

                        v47[i2] = v46;
                    end;

                    v44[v46] = v;
                end;
            end;

            for i, v in pairs(v44) do
                local v48 = v43[i.settingsGroupName];

                if v48 then
                    local v49 = v;
                    local v50 = i;

                    for i2, _ in pairs(v) do
                        local v51 = v48[i2];

                        if v51 and v51 ~= v50 then
                            v49[i2] = nil;
                        end;
                    end;
                end;
            end;

            local v52 = { {}, {} };

            for i, _ in pairs(u1) do
                if i.activeTriggers[u38] then
                    local accuracy = i.accuracy;
                    local v53 = v42[i] or {};
                    local v54 = false;

                    for _, _ in pairs(v53) do
                        v54 = true;
                        break;
                    end;

                    if v54 then
                        if v40 >= accuracy then
                            accuracy = v40;
                        end;
                    else
                        accuracy = v40;
                    end;

                    local v55 = i:_updateOccupants(u38, v53);
                    v52[1][i] = v55.exited;
                    v52[2][i] = v55.entered;
                    v40 = accuracy;
                end;
            end;

            local v56 = { "Exited", "Entered" };

            for i, v in pairs(v52) do
                local v57 = u38 .. v56[i];

                for i2, v2 in pairs(v) do
                    local v58 = i2[v57];

                    if v58 then
                        for _, v3 in pairs(v2) do
                            v58:Fire(v3);
                        end;
                    end;
                end;
            end;

            u39 = os_clock_ret + enums.Accuracy.getProperty(v40);
        end;
    end);
end;

function u12._deregisterConnection(p59, p60) -- Line: 249
    -- upvalues: u9 (ref), u3 (copy), u10 (copy), u1 (copy), u12 (copy)
    u9 = u9 - 1;

    if u3[p60] == 1 then
        u3[p60] = nil;
        local v61 = u10[p60];

        if v61 then
            u10[p60] = nil;
            v61:Disconnect();
        end;
    else
        local v62 = u3;
        v62[p60] = v62[p60] - 1;
    end;

    p59.activeTriggers[p60] = nil;
    local v63 = 0;

    for _, _ in pairs(p59.activeTriggers) do
        v63 = v63 + 1;
    end;

    if v63 == 0 then
        u1[p59] = nil;
        u12._updateZoneDetails();
    end;

    if p59.touchedConnectionActions[p60] then
        p59:_disconnectTouchedConnection(p60);
    end;
end;

function u12._updateZoneDetails() -- Line: 271
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u8 (ref), u2 (ref), u4 (copy), u1 (copy)
    u5 = {};
    u6 = {};
    u7 = {};
    u8 = {};
    u2 = 0;

    for i, _ in pairs(u4) do
        local v64 = u1[i];

        if v64 then
            u2 = u2 + i.volume;
        end;

        local v65 = i;

        for _, v in pairs(i.zoneParts) do
            if v64 then
                table.insert(u5, v);
                u6[v] = v65;
            end;

            table.insert(u7, v);
            u8[v] = v65;
        end;
    end;
end;

function u12._getZonesAndItems(p66, p67, p68, p69, p70) -- Line: 293
    -- upvalues: u13 (copy), u12 (copy), Players (copy), script_CollectiveWorldModel (copy)
    if not p68 then
        for i, _ in pairs(p67) do
            p68 = p68 + i.volume;
        end;
    end;

    local v71 = {};
    local v72 = u13[p66];

    if v72.totalVolume < p68 then
        for _, v in pairs(v72.items) do
            local TouchingZones = u12.getTouchingZones(v, p69, p70, v72);
            local v73 = v;

            for _, v2 in pairs(TouchingZones) do
                if not p69 or v2.activeTriggers[p66] then
                    local v74;

                    if p66 == "player" then
                        v74 = Players:GetPlayerFromCharacter(v73);
                    else
                        v74 = v73;
                    end;

                    if v74 then
                        local v75 = v71[v2];

                        if not v75 then
                            v75 = {};
                            v71[v2] = v75;
                        end;

                        local v76 = v74:IsA("Player") and v74.Character;
                        v75[v74] = v76 or true;
                    end;
                end;
            end;
        end;

        return v71;
    end;

    for i, _ in pairs(p67) do
        if not p69 or i.activeTriggers[p66] then
            local PartBoundsInBox = script_CollectiveWorldModel:GetPartBoundsInBox(i.region.CFrame, i.region.Size, v72.whitelistParams);
            local v77 = i;
            local v78 = {};

            for _, v in pairs(PartBoundsInBox) do
                local v79 = v72.partToItem[v];

                if not v78[v79] then
                    v78[v79] = true;
                end;
            end;

            for i2, _ in pairs(v78) do
                if p66 == "player" then
                    local PlayerFromCharacter = Players:GetPlayerFromCharacter(i2);

                    if v77:findPlayer(PlayerFromCharacter) then
                        local v80 = v71[v77];

                        if not v80 then
                            v80 = {};
                            v71[v77] = v80;
                        end;

                        local v81 = PlayerFromCharacter:IsA("Player") and PlayerFromCharacter.Character;
                        v80[PlayerFromCharacter] = v81 or true;
                    end;
                elseif v77:findItem(i2) then
                    local v82 = v71[v77];

                    if not v82 then
                        v82 = {};
                        v71[v77] = v82;
                    end;

                    local v83 = i2:IsA("Player") and i2.Character;
                    v82[i2] = v83 or true;
                end;
            end;
        end;
    end;

    return v71;
end;

function u12.getZones() -- Line: 354
    -- upvalues: u4 (copy)
    local v84 = {};

    for i, _ in pairs(u4) do
        table.insert(v84, i);
    end;

    return v84;
end;

function u12.getTouchingZones(p85, p86, p87, p88) -- Line: 374
    -- upvalues: enums (copy), script_Tracker (copy), u5 (ref), u7 (ref), u6 (ref), u8 (ref), script_CollectiveWorldModel (copy)
    local v89;

    if p88 then
        v89 = p88.exitDetections[p85];
        p88.exitDetections[p85] = nil;
    else
        v89 = nil;
    end;

    local v90 = v89 or p87;
    local v91 = nil;
    local v92 = nil;
    local v93 = p85:IsA("BasePart");
    local v94 = not v93;
    local v95 = {};

    if v93 then
        v91 = p85.Size;
        v92 = p85.CFrame;
        table.insert(v95, p85);
    elseif v90 == enums.Detection.WholeBody then
        v91, v92 = script_Tracker.getCharacterSize(p85);
        v95 = p85:GetChildren();
    else
        local HumanoidRootPart = p85:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            v91 = HumanoidRootPart.Size;
            v92 = HumanoidRootPart.CFrame;
            table.insert(v95, HumanoidRootPart);
        end;
    end;

    if not (v91 and v92) then
        return {};
    end;

    local v96 = p86 and u5 or u7;
    local v97 = p86 and u6 or u8;
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.MaxParts = #v96;
    OverlapParams_new_ret.FilterDescendantsInstances = v96;
    local PartBoundsInBox = script_CollectiveWorldModel:GetPartBoundsInBox(v92, v91, OverlapParams_new_ret);
    local v98 = {};
    local v99 = {};
    local v100 = {};

    for _, v in pairs(PartBoundsInBox) do
        local v101 = v97[v];

        if v101 and v101.allZonePartsAreBlocks then
            v98[v101] = true;
            v99[v] = v101;
        else
            table.insert(v100, v);
        end;
    end;

    local v102 = #v100;
    local v103 = 0;

    if v102 > 0 then
        local OverlapParams_new_ret2 = OverlapParams.new();
        OverlapParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
        OverlapParams_new_ret2.MaxParts = v102;
        OverlapParams_new_ret2.FilterDescendantsInstances = v100;

        for _, v in pairs(v95) do
            local v104 = false;

            if v:IsA("BasePart") and not (v94 and script_Tracker.bodyPartsToIgnore[v.Name]) then
                local PartsInPart = script_CollectiveWorldModel:GetPartsInPart(v, OverlapParams_new_ret2);

                for _, v2 in pairs(PartsInPart) do
                    if not v99[v2] then
                        local v105 = v97[v2];

                        if v105 then
                            v98[v105] = true;
                            v99[v2] = v105;
                            v103 = v103 + 1;
                        end;

                        if v103 == v102 then
                            v104 = true;
                            break;
                        end;
                    end;
                end;

                if v104 then
                    break;
                end;
            end;
        end;
    end;

    local v106 = nil;
    local v107 = {};

    for i, _ in pairs(v98) do
        if v106 == nil or i._currentExitDetection < v106 then
            v106 = i._currentExitDetection;
        end;

        table.insert(v107, i);
    end;

    if v106 and p88 then
        p88.exitDetections[p85] = v106;
    end;

    return v107, v99;
end;

local u108 = {};

function u12.setGroup(p109, p110) -- Line: 491
    -- upvalues: u108 (copy)
    local v111 = u108[p109];

    if not v111 then
        v111 = {};
        u108[p109] = v111;
    end;

    v111.onlyEnterOnceExitedAll = true;
    v111._name = p109;
    v111._memberZones = {};

    if typeof(p110) == "table" then
        for i, v in pairs(p110) do
            v111[i] = v;
        end;
    end;

    return v111;
end;

function u12.getGroup(p112) -- Line: 515
    -- upvalues: u108 (copy)
    return u108[p112];
end;

local u113 = nil;
local string_format_ret = string.format("ZonePlus%sContainer", RunService:IsClient() and "Client" or "Server");

function u12.getWorkspaceContainer() -- Line: 521
    -- upvalues: u113 (ref), string_format_ret (copy)
    local v114 = u113 or workspace:FindFirstChild(string_format_ret);

    if not v114 then
        v114 = Instance.new("Folder");
        v114.Name = string_format_ret;
        v114.Parent = workspace;
        u113 = v114;
    end;

    return v114;
end;

return u12;
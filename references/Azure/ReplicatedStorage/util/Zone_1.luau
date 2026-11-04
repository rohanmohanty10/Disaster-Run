 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- LOCAL
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local heartbeat = runService.Heartbeat
local localPlayer = runService:IsClient() and players.LocalPlayer
local replicatedStorage = game:GetService("ReplicatedStorage")
local httpService = game:GetService("HttpService")
local Enum_ = require(script.Enum)
local enum = Enum_.enums
local Janitor = require(script.Janitor)
local Signal = require(script.Signal)
local ZonePlusReference = require(script.ZonePlusReference)
local referenceObject = ZonePlusReference.getObject()
local zoneControllerModule = script.ZoneController
local trackerModule = zoneControllerModule.Tracker
local collectiveWorldModelModule = zoneControllerModule.CollectiveWorldModel
local ZoneController = require(zoneControllerModule)
local referenceLocation = (game:GetService("RunService"):IsClient() and "Client") or "Server"
local referencePresent = referenceObject and referenceObject:FindFirstChild(referenceLocation)
if referencePresent then
	return require(referenceObject.Value)
end

local Zone = {}
Zone.__index = Zone
if not referencePresent then
	ZonePlusReference.addToReplicatedStorage()
end
Zone.enum = enum



-- CONSTRUCTORS
function Zone.new(container)
	local self = {}
	setmetatable(self, Zone)
	
	-- Validate container
	local INVALID_TYPE_WARNING = "The zone container must be a model, folder, basepart or table!"
	local containerType = typeof(container)
	if not(containerType == "table" or containerType == "Instance") then
		error(INVALID_TYPE_WARNING)
	end

	-- Configurable
	self.accuracy = enum.Accuracy.High
	self.autoUpdate = true
	self.respectUpdateQueue = true
	--self.maxPartsAddition = 20
	--self.ignoreRecommendedMaxParts = false

	-- Variable
	local janitor = Janitor.new()
	self.janitor = janitor
	self._updateConnections = janitor:add(Janitor.new(), "destroy")
	self.container = container
	self.zoneParts = {}
	self.overlapParams = {}
	self.region = nil
	self.volume = nil
	self.boundMin = nil
	self.boundMax = nil
	self.recommendedMaxParts = nil
	self.zoneId = httpService:GenerateGUID()
	self.activeTriggers = {}
	self.occupants = {}
	self.trackingTouchedTriggers = {}
	self.enterDetection = enum.Detection.Centre
	self.exitDetection = enum.Detection.Centre
	self._currentEnterDetection = nil -- This will update automatically internally
	self._currentExitDetection = nil -- This will also update automatically internally
	self.totalPartVolume = 0
	self.allZonePartsAreBlocks = true
	self.trackedItems = {}
	self.settingsGroupName = nil
	self.worldModel = workspace
	self.onItemDetails = {}
	self.itemsToUntrack = {}

	-- This updates _currentEnterDetection and _currentExitDetection right away to prevent nil comparisons
	ZoneController.updateDetection(self)

	-- Signals
	self.updated = janitor:add(Signal.new(), "destroy")
	local triggerTypes = {
		"player",
		"part",
		"localPlayer",
		"item"
	}
	local triggerEvents = {
		"entered",
		"exited",
	}
	for _, triggerType in pairs(triggerTypes) do
		local activeConnections = 0
		local previousActiveConnections = 0
		for i, triggerEvent in pairs(triggerEvents) do
			-- this enables us to determine when a developer connects to an event
			-- so that we can act accoridngly (i.e. begin or end a checker loop)
			local signal = janitor:add(Signal.new(true), "destroy")
			local triggerEventUpper = triggerEvent:sub(1,1):upper()..triggerEvent:sub(2)
			local signalName = triggerType..triggerEventUpper
			self[signalName] = signal
			signal.connectionsChanged:Connect(function(increment)
				if triggerType == "localPlayer" and not localPlayer and increment == 1 then
					error(("Can only connect to 'localPlayer%s' on the client!"):format(triggerEventUpper))
				end
				previousActiveConnections = activeConnections
				activeConnections += increment
				if previousActiveConnections == 0 and activeConnections > 0 then
					-- At least 1 connection active, begin loop
					ZoneController._registerConnection(self, triggerType, triggerEventUpper)
				elseif previousActiveConnections > 0 and activeConnections == 0 then
					-- All connections have disconnected, end loop
					ZoneController._deregisterConnection(self, triggerType)
				end
			end)
		end
	end

	-- Setup touched receiver functions where applicable
	Zone.touchedConnectionActions = {}
	for _, triggerType in pairs(triggerTypes) do
		local methodName = ("_%sTouchedZone"):format(triggerType)
		local correspondingMethod = self[methodName]
		if correspondingMethod then
			self.trackingTouchedTriggers[triggerType] = {}
			Zone.touchedConnectionActions[triggerType] = function(touchedItem)
				correspondingMethod(self, touchedItem)
			end
		end
	end

	-- This constructs the zones boundaries, region, etc
	self:_update()

	-- Register/deregister zone
	ZoneController._registerZone(self)
	janitor:add(function()
		ZoneController._deregisterZone(self)
	end, true)
	
	return self
end

function Zone.fromRegion(cframe, size)
	local MAX_PART_SIZE = 2024
	local container = Instance.new("Model")
	local function createCube(cubeCFrame, cubeSize)
		if cubeSize.X > MAX_PART_SIZE or cubeSize.Y > MAX_PART_SIZE or cubeSize.Z > MAX_PART_SIZE then
			local quarterSize = cubeSize * 0.25
			local halfSize = cubeSize * 0.5
			createCube(cubeCFrame * CFrame.new(-quarterSize.X, -quarterSize.Y, -quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(-quarterSize.X, -quarterSize.Y, quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(-quarterSize.X, quarterSize.Y, -quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(-quarterSize.X, quarterSize.Y, quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(quarterSize.X, -quarterSize.Y, -quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(quarterSize.X, -quarterSize.Y, quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(quarterSize.X, quarterSize.Y, -quarterSize.Z), halfSize)
			createCube(cubeCFrame * CFrame.new(quarterSize.X, quarterSize.Y, quarterSize.Z), halfSize)
		else
			local part = Instance.new("Part")
			part.CFrame = cubeCFrame
			part.Size = cubeSize
			part.Anchored = true
			part.Parent = container
		end
	end
	createCube(cframe, size)
	local zone = Zone.new(container)
	zone:relocate()
	return zone
end



-- PRIVATE METHODS
function Zone:_calculateRegion(tableOfParts, dontRound)
	local bounds = {["Min"] = {}, ["Max"] = {}}
	for boundType, details in pairs(bounds) do
		details.Values = {}
		function details.parseCheck(v, currentValue)
			if boundType == "Min" then
				return (v <= currentValue)
			elseif boundType == "Max" then
				return (v >= currentValue)
			end
		end
		function details:parse(valuesToParse)
			for i,v in pairs(valuesToParse) do
				local currentValue = self.Values[i] or v
				if self.parseCheck(v, currentValue) then
					self.Values[i] = v
				end
			end
		end
	end
	for _, part in pairs(tableOfParts) do
		local sizeHalf = part.Size * 0.5
		local corners = {
			part.CFrame * CFrame.new(-sizeHalf.X, -sizeHalf.Y, -sizeHalf.Z),
			part.CFrame * CFrame.new(-sizeHalf.X, -sizeHalf.Y, sizeHalf.Z),
			part.CFrame * CFrame.new(-sizeHalf.X, sizeHalf.Y, -sizeHalf.Z),
			part.CFrame * CFrame.new(-sizeHalf.X, sizeHalf.Y, sizeHalf.Z),
			part.CFrame * CFrame.new(sizeHalf.X, -sizeHalf.Y, -sizeHalf.Z),
			part.CFrame * CFrame.new(sizeHalf.X, -sizeHalf.Y, sizeHalf.Z),
			part.CFrame * CFrame.new(sizeHalf.X, sizeHalf.Y, -sizeHalf.Z),
			part.CFrame * CFrame.new(sizeHalf.X, sizeHalf.Y, sizeHalf.Z),
		}
		for _, cornerCFrame in pairs(corners) do
			local x, y, z = cornerCFrame:GetComponents()
			local values = {x, y, z}
			bounds.Min:parse(values)
			bounds.Max:parse(values)
		end
	end
	local minBound = {}
	local maxBound = {}
	-- Rounding a regions coordinates to multiples of 4 ensures the region optimises the region
	-- by ensuring it aligns on the voxel grid
	local function roundToFour(to_round)
		local ROUND_TO = 4
		local divided = (to_round+ROUND_TO/2) / ROUND_TO
		local rounded = ROUND_TO * math.floor(divided)
		return rounded
	end
	for boundName, boundDetail in pairs(bounds) do
		for _, v in pairs(boundDetail.Values) do
			local newTable = (boundName == "Min" and minBound) or maxBound
			local newV = v
			if not dontRound then
				local roundOffset = (boundName == "Min" and -2) or 2
				newV = roundToFour(v+roundOffset) -- +-2 to ensures the zones region is not rounded down/up
			end
			table.insert(newTable, newV)
		end
	end
	local boundMin = Vector3.new(unpack(minBound))
	local boundMax = Vector3.new(unpack(maxBound))
	local region = Region3.new(boundMin, boundMax)
	return region, boundMin, boundMax
end

function Zone:_displayBounds()
	if not self.displayBoundParts then
		self.displayBoundParts = true
		local boundParts = {BoundMin = self.boundMin, BoundMax = self.boundMax}
		for boundName, boundCFrame in pairs(boundParts) do
			local part = Instance.new("Part")
			part.Anchored = true
			part.CanCollide = false
			part.Transparency = 0.5
			part.Size = Vector3.new(1,1,1)
			part.Color = Color3.fromRGB(255,0,0)
			part.CFrame = CFrame.new(boundCFrame)
			part.Name = boundName
			part.Parent = workspace
			self.janitor:add(part, "Destroy")
		end
	end
end

function Zone:_update()
	local container = self.container
	local zoneParts = {}
	local updateQueue = 0
	self._updateConnections:clean()

	local containerType = typeof(container)
	local holders = {}
	local INVALID_TYPE_WARNING = "The zone container must be a model, folder, basepart or table!"
	if containerType == "table" then
		for _, part in pairs(container) do
			if part:IsA("BasePart") then
				table.insert(zoneParts, part)
			end
		end
	elseif containerType == "Instance" then
		if container:IsA("BasePart") then
			table.insert(zoneParts, container)
		else
			table.insert(holders, container)
			for _, part in pairs(container:GetDescendants()) do
				if part:IsA("BasePart") then
					table.insert(zoneParts, part)
				else
					table.insert(holders, part)
				end
			end
		end
	end
	self.zoneParts = zoneParts
	self.overlapParams = {}
	
	local allZonePartsAreBlocksNew = true
	for _, zonePart in pairs(zoneParts) do
		local success, shapeName = pcall(function() return zonePart.Shape.Name end)
		if shapeName ~= "Block" then
			allZonePartsAreBlocksNew = false
		end
	end
	self.allZonePartsAreBlocks = allZonePartsAreBlocksNew
	
	local zonePartsWhitelist = OverlapParams.new()
	zonePartsWhitelist.FilterType = Enum.RaycastFilterType.Whitelist
	zonePartsWhitelist.MaxParts = #zoneParts
	zonePartsWhitelist.FilterDescendantsInstances = zoneParts
	self.overlapParams.zonePartsWhitelist = zonePartsWhitelist

	local zonePartsIgnorelist = OverlapParams.new()
	zonePartsIgnorelist.FilterType = Enum.RaycastFilterType.Blacklist
	zonePartsIgnorelist.FilterDescendantsInstances = zoneParts
	self.overlapParams.zonePartsIgnorelist = zonePartsIgnorelist
	
	-- this will call update on the zone when the container parts size or position changes, and when a
	-- child is removed or added from a holder (anything which isn't a basepart)
	local function update()
		if self.autoUpdate then
			local executeTime = os.clock()
			if self.respectUpdateQueue then
				updateQueue += 1
				executeTime += 0.1
			end
			local updateConnection
			updateConnection = runService.Heartbeat:Connect(function()
				if os.clock() >= executeTime then
					updateConnection:Disconnect()
					if self.respectUpdateQueue then
						updateQueue -= 1
					end
					if updateQueue == 0 and self.zoneId then
						self:_update()
					end
				end
			end)
		end
	end
	local partProperties = {"Size", "Position"}
	local function verifyDefaultCollision(instance)
		if instance.CollisionGroupId ~= 0 then
			error("Zone parts must belong to the 'Default' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.")
		end
	end
	for _, part in pairs(zoneParts) do
		for _, prop in pairs(partProperties) do
			self._updateConnections:add(part:GetPropertyChangedSignal(prop):Connect(update), "Disconnect")
		end
		verifyDefaultCollision(part)
		self._updateConnections:add(part:GetPropertyChangedSignal("CollisionGroupId"):Connect(function()
			verifyDefaultCollision(part)
		end), "Disconnect")
	end
	local containerEvents = {"ChildAdded", "ChildRemoved"}
	for _, holder in pairs(holders) do
		for _, event in pairs(containerEvents) do
			self._updateConnections:add(self.container[event]:Connect(function(child)
				if child:IsA("BasePart") then
					update()
				end
			end), "Disconnect")
		end
	end
	
	local region, boundMin, boundMax = self:_calculateRegion(zoneParts)
	local exactRegion, _, _ = self:_calculateRegion(zoneParts, true)
	self.region = region
	self.exactRegion = exactRegion
	self.boundMin = boundMin
	self.boundMax = boundMax
	local rSize = region.Size
	self.volume = rSize.X*rSize.Y*rSize.Z
	
	-- Update: I was going to use this for the old part detection until the CanTouch property was released
	-- everything below is now irrelevant however I'll keep just in case I use again for future
	-------------------------------------------------------------------------------------------------
	-- When a zones region is determined, we also check for parts already existing within the zone
	-- these parts are likely never to move or interact with the zone, so we set the number of these
	-- to the baseline MaxParts value. 'recommendMaxParts' is then determined through the sum of this
	-- and maxPartsAddition. This ultimately optimises region checks as they can be generated with
	-- minimal MaxParts (i.e. recommendedMaxParts can be used instead of math.huge every time)
	--[[
	local result = self.worldModel:FindPartsInRegion3(region, nil, math.huge)
	local maxPartsBaseline = #result
	self.recommendedMaxParts = maxPartsBaseline + self.maxPartsAddition
	--]]
	
	self:_updateTouchedConnections()
	
	self.updated:Fire()
end

function Zone:_updateOccupants(trackerName, newOccupants)
	local previousOccupants = self.occupants[trackerName]
	if not previousOccupants then
		previousOccupants = {}
		self.occupants[trackerName] = previousOccupants
	end
	local signalsToFire = {}
	for occupant, prevItem in pairs(previousOccupants) do
		local newItem = newOccupants[occupant]
		if newItem == nil or newItem ~= prevItem then
			previousOccupants[occupant] = nil
			if not signalsToFire.exited then
				signalsToFire.exited = {}
			end
			table.insert(signalsToFire.exited, occupant)
		end
	end
	for occupant, _ in pairs(newOccupants) do
		if previousOccupants[occupant] == nil then
			local isAPlayer = occupant:IsA("Player")
			previousOccupants[occupant] = (isAPlayer and occupant.Character) or true
			if not signalsToFire.entered then
				signalsToFire.entered = {}
			end
			table.insert(signalsToFire.entered, occupant)
		end
	end 
	return signalsToFire
end

function Zone:_formTouchedConnection(triggerType)
	local touchedJanitorName = "_touchedJanitor"..triggerType
	local touchedJanitor = self[touchedJanitorName]
	if touchedJanitor then
		touchedJanitor:clean()
	else
		touchedJanitor = self.janitor:add(Janitor.new(), "destroy")
		self[touchedJanitorName] = touchedJanitor
	end
	self:_updateTouchedConnection(triggerType)
end

function Zone:_updateTouchedConnection(triggerType)
	local touchedJanitorName = "_touchedJanitor"..triggerType
	local touchedJanitor = self[touchedJanitorName]
	if not touchedJanitor then return end
	for _, basePart in pairs(self.zoneParts) do
		touchedJanitor:add(basePart.Touched:Connect(self.touchedConnectionActions[triggerType], self), "Disconnect")
	end
end

function Zone:_updateTouchedConnections()
	for triggerType, _ in pairs(self.touchedConnectionActions) do
		local touchedJanitorName = "_touchedJanitor"..triggerType
		local touchedJanitor = self[touchedJanitorName]
		if touchedJanitor then
			touchedJanitor:cleanup()
			self:_updateTouchedConnection(triggerType)
		end
	end
end

function Zone:_disconnectTouchedConnection(triggerType)
	local touchedJanitorName = "_touchedJanitor"..triggerType
	local touchedJanitor = self[touchedJanitorName]
	if touchedJanitor then
		touchedJanitor:cleanup()
		self[touchedJanitorName] = nil
	end
end

local function round(number, decimalPlaces)
	return math.round(number * 10^decimalPlaces) * 10^-decimalPlaces
end
function Zone:_partTouchedZone(part)
	local trackingDict = self.trackingTouchedTriggers["part"]
	if trackingDict[part] then return end
	local nextCheck = 0
	local verifiedEntrance = false
	local enterPosition = part.Position
	local enterTime = os.clock()
	local partJanitor = self.janitor:add(Janitor.new(), "destroy")
	trackingDict[part] = partJanitor
	local instanceClassesToIgnore = {Seat = true, VehicleSeat = true}
	local instanceNamesToIgnore = {HumanoidRootPart = true}
	if not (instanceClassesToIgnore[part.ClassName] or not instanceNamesToIgnore[part.Name])  then
		part.CanTouch = false
	end
	--
	local partVolume = round((part.Size.X * part.Size.Y * part.Size.Z), 5)
	self.totalPartVolume += partVolume
	--
	partJanitor:add(heartbeat:Connect(function()
		local clockTime = os.clock()
		if clockTime >= nextCheck then
			----
			local cooldown = enum.Accuracy.getProperty(self.accuracy)
			nextCheck = clockTime + cooldown
			----

			-- We initially perform a singular point check as this is vastly more lightweight than a large part check
			-- If the former returns false, perform a whole part check in case the part is on the outer bounds.
			local withinZone = self:findPoint(part.CFrame)
			if not withinZone then
				withinZone = self:findPart(part)
			end
			if not verifiedEntrance then
				if withinZone then
					verifiedEntrance = true
					self.partEntered:Fire(part)
				elseif (part.Position - enterPosition).Magnitude > 1.5 and clockTime - enterTime >= cooldown then
					-- Even after the part has exited the zone, we track it for a brief period of time based upon the criteria
					-- in the line above to ensure the .touched behaviours are not abused
					partJanitor:cleanup()
				end
			elseif not withinZone then
				verifiedEntrance = false
				enterPosition = part.Position
				enterTime = os.clock()
				self.partExited:Fire(part)
			end
		end
	end), "Disconnect")
	partJanitor:add(function()
		trackingDict[part] = nil
		part.CanTouch = true
		self.totalPartVolume = round((self.totalPartVolume - partVolume), 5)
	end, true)
end

local partShapeActions = {
	["Ball"] = function(part)
		return "GetPartBoundsInRadius", {part.Position, part.Size.X}
	end,
	["Block"] = function(part)
		return "GetPartBoundsInBox", {part.CFrame, part.Size}
	end,
	["Other"] = function(part)
		return "GetPartsInPart", {part}
	end,
}
function Zone:_getRegionConstructor(part, overlapParams)
	local success, shapeName = pcall(function() return part.Shape.Name end)
	local methodName, args
	if success and self.allZonePartsAreBlocks then
		local action = partShapeActions[shapeName]
		if action then
			methodName, args = action(part)
		end
	end
	if not methodName then
		methodName, args = partShapeActions.Other(part)
	end
	if overlapParams then
		table.insert(args, overlapParams)
	end
	return methodName, args
end



-- PUBLIC METHODS
function Zone:findLocalPlayer()
	if not localPlayer then
		error("Can only call 'findLocalPlayer' on the client!")
	end
	return self:findPlayer(localPlayer)
end

function Zone:_find(trackerName, item)
	ZoneController.updateDetection(self)
	local tracker = ZoneController.trackers[trackerName]
	local touchingZones = ZoneController.getTouchingZones(item, false, self._currentEnterDetection, tracker)
	for _, zone in pairs(touchingZones) do
		if zone == self then
			return true
		end
	end
	return false
end

function Zone:findPlayer(player)
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return false
	end
	return self:_find("player", player.Character)
end

function Zone:findItem(item)
	return self:_find("item", item)
end

function Zone:findPart(part)
	local methodName, args = self:_getRegionConstructor(part, self.overlapParams.zonePartsWhitelist)
	local touchingZoneParts = self.worldModel[methodName](self.worldModel, unpack(args))
	--local touchingZoneParts = self.worldModel:GetPartsInPart(part, self.overlapParams.zonePartsWhitelist)
	if #touchingZoneParts > 0 then
		return true, touchingZoneParts
	end
	return false
end

function Zone:getCheckerPart()
	local checkerPart = self.checkerPart
	if not checkerPart then
		checkerPart = self.janitor:add(Instance.new("Part"), "Destroy")
		checkerPart.Size = Vector3.new(0.1, 0.1, 0.1)
		checkerPart.Name = "ZonePlusCheckerPart"
		checkerPart.Anchored = true
		checkerPart.Transparency = 1
		checkerPart.CanCollide = false
		self.checkerPart = checkerPart
	end
	local checkerParent = self.worldModel
	if checkerParent == workspace then
		checkerParent = ZoneController.getWorkspaceContainer()
	end
	if checkerPart.Parent ~= checkerParent then
		checkerPart.Parent = checkerParent
	end
	return checkerPart
end

function Zone:findPoint(positionOrCFrame)
	local cframe = positionOrCFrame
	if typeof(positionOrCFrame) == "Vector3" then
		cframe = CFrame.new(positionOrCFrame)
	end
	local checkerPart = self:getCheckerPart()
	checkerPart.CFrame = cframe
	--checkerPart.Parent = self.worldModel
	local methodName, args = self:_getRegionConstructor(checkerPart, self.overlapParams.zonePartsWhitelist)
	local touchingZoneParts = self.worldModel[methodName](self.worldModel, unpack(args))
	--local touchingZoneParts = self.worldModel:GetPartsInPart(self.checkerPart, self.overlapParams.zonePartsWhitelist)
	if #touchingZoneParts > 0 then
		return true, touchingZoneParts
	end
	return false
end

function Zone:_getAll(trackerName)
	ZoneController.updateDetection(self)
	local itemsArray = {}
	local zonesAndOccupants = ZoneController._getZonesAndItems(trackerName, {self = true}, self.volume, false, self._currentEnterDetection)
	local occupantsDict = zonesAndOccupants[self]
	if occupantsDict then
		for item, _ in pairs(occupantsDict) do
			table.insert(itemsArray, item)
		end
	end
	return itemsArray
end

function Zone:getPlayers()
	return self:_getAll("player")
end

function Zone:getItems()
	return self:_getAll("item")
end

function Zone:getParts()
	-- This is designed for infrequent 'one off' use
	-- If you plan on checking for parts within a zone frequently, it's recommended you
	-- use the .partEntered and .partExited events instead.
	local partsArray = {}
	if self.activeTriggers["part"] then
		local trackingDict = self.trackingTouchedTriggers["part"]
		for part, _ in pairs(trackingDict) do
			table.insert(partsArray, part)
		end
		return partsArray
	end
	local partsInRegion = self.worldModel:GetPartBoundsInBox(self.region.CFrame, self.region.Size, self.overlapParams.zonePartsIgnorelist)
	for _, part in pairs(partsInRegion) do
		if self:findPart(part) then
			table.insert(partsArray, part)
		end
	end
	return partsArray
end

function Zone:getRandomPoint()
	local region = self.exactRegion
	local size = region.Size
	local cframe = region.CFrame
	local random = Random.new()
	local randomCFrame
	local success, touchingZoneParts
	local pointIsWithinZone
	repeat
		randomCFrame = cframe * CFrame.new(random:NextNumber(-size.X/2,size.X/2), random:NextNumber(-size.Y/2,size.Y/2), random:NextNumber(-size.Z/2,size.Z/2))
		success, touchingZoneParts = self:findPoint(randomCFrame)
		if success then
			pointIsWithinZone = true
		end
	until pointIsWithinZone
	local randomVector = randomCFrame.Position
	return randomVector, touchingZoneParts
end

function Zone:setAccuracy(enumIdOrName)
	local enumId = tonumber(enumIdOrName)
	if not enumId then
		enumId = enum.Accuracy[enumIdOrName]
		if not enumId then
			error(("'%s' is an invalid enumName!"):format(enumIdOrName))
		end
	else
		local enumName = enum.Accuracy.getName(enumId)
		if not enumName then
			error(("%s is an invalid enumId!"):format(enumId))
		end
	end
	self.accuracy = enumId
end

function Zone:setDetection(enumIdOrName)
	local enumId = tonumber(enumIdOrName)
	if not enumId then
		enumId = enum.Detection[enumIdOrName]
		if not enumId then
			error(("'%s' is an invalid enumName!"):format(enumIdOrName))
		end
	else
		local enumName = enum.Detection.getName(enumId)
		if not enumName then
			error(("%s is an invalid enumId!"):format(enumId))
		end
	end
	self.enterDetection = enumId
	self.exitDetection = enumId
end

function Zone:trackItem(instance)
	local isBasePart = instance:IsA("BasePart")
	local isCharacter = false
	if not isBasePart then
		isCharacter = instance:FindFirstChildOfClass("Humanoid") and instance:FindFirstChild("HumanoidRootPart")
	end

	assert(isBasePart or isCharacter, "Only BaseParts or Characters/NPCs can be tracked!")

	if self.trackedItems[instance] then
		return
	end
	if self.itemsToUntrack[instance] then
		self.itemsToUntrack[instance] = nil
	end

	local itemJanitor = self.janitor:add(Janitor.new(), "destroy")
	local itemDetail = {
		janitor = itemJanitor,
		item = instance,
		isBasePart = isBasePart,
		isCharacter = isCharacter,
	}
	self.trackedItems[instance] = itemDetail

	itemJanitor:add(instance.AncestryChanged:Connect(function()
		if not instance:IsDescendantOf(game) then
			self:untrackItem(instance)
		end
	end), "Disconnect")

	local Tracker = require(trackerModule)
	Tracker.itemAdded:Fire(itemDetail)
end

function Zone:untrackItem(instance)
	local itemDetail = self.trackedItems[instance]
	if itemDetail then
		itemDetail.janitor:destroy()
	end
	self.trackedItems[instance] = nil

	local Tracker = require(trackerModule)
	Tracker.itemRemoved:Fire(itemDetail)
end

function Zone:bindToGroup(settingsGroupName)
	self:unbindFromGroup()
	local group = ZoneController.getGroup(settingsGroupName) or ZoneController.setGroup(settingsGroupName)
	group._memberZones[self.zoneId] = self
	self.settingsGroupName = settingsGroupName
end

function Zone:unbindFromGroup()
	if self.settingsGroupName then
		local group = ZoneController.getGroup(self.settingsGroupName)
		if group then
			group._memberZones[self.zoneId] = nil
		end
		self.settingsGroupName = nil
	end
end

function Zone:relocate()
	if self.hasRelocated then
		return
	end

	local CollectiveWorldModel = require(collectiveWorldModelModule)
	local worldModel = CollectiveWorldModel.setupWorldModel(self)
	self.worldModel = worldModel
	self.hasRelocated = true
	
	local relocationContainer = self.container
	if typeof(relocationContainer) == "table" then
		relocationContainer = Instance.new("Folder")
		for _, zonePart in pairs(self.zoneParts) do
			zonePart.Parent = relocationContainer
		end
	end
	self.relocationContainer = self.janitor:add(relocationContainer, "Destroy", "RelocationContainer")
	relocationContainer.Parent = worldModel
end

function Zone:_onItemCallback(eventName, desiredValue, instance, callbackFunction)
	local detail = self.onItemDetails[instance]
	if not detail then
		detail = {}
		self.onItemDetails[instance] = detail
	end
	if #detail == 0 then
		self.itemsToUntrack[instance] = true
	end
	table.insert(detail, instance)
	self:trackItem(instance)

	local function triggerCallback()
		callbackFunction()
		if self.itemsToUntrack[instance] then
			self.itemsToUntrack[instance] = nil
			self:untrackItem(instance)
		end
	end

	local inZoneAlready = self:findItem(instance)
	if inZoneAlready == desiredValue then
		triggerCallback()
	else
		local connection
		connection = self[eventName]:Connect(function(item)
			if connection and item == instance then
				connection:Disconnect()
				connection = nil
				triggerCallback()
			end
		end)
		--[[
		if typeof(expireAfterSeconds) == "number" then
			task.delay(expireAfterSeconds, function()
				if connection ~= nil then
					print("EXPIRE!")
					connection:Disconnect()
					connection = nil
					triggerCallback()
				end
			end)
		end
		--]]
	end
end

function Zone:onItemEnter(...)
	self:_onItemCallback("itemEntered", true, ...)
end

function Zone:onItemExit(...)
	self:_onItemCallback("itemExited", false, ...)
end

function Zone:destroy()
	self:unbindFromGroup()
	self.janitor:destroy()
end
Zone.Destroy = Zone.destroy



return Zone
]=]

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Heartbeat = RunService.Heartbeat;
local u1 = RunService:IsClient() and Players.LocalPlayer;
game:GetService("ReplicatedStorage");
local HttpService = game:GetService("HttpService");
local enums = require(script.Enum).enums;
local script_Janitor = require(script.Janitor);
local script_Signal = require(script.Signal);
local script_ZonePlusReference = require(script.ZonePlusReference);
local Object = script_ZonePlusReference.getObject();
local script_ZoneController = script.ZoneController;
local Tracker = script_ZoneController.Tracker;
local CollectiveWorldModel = script_ZoneController.CollectiveWorldModel;
local u2 = require(script_ZoneController);
local v3 = game:GetService("RunService"):IsClient() and "Client" or "Server";
local v4;

if Object then
    v4 = Object:FindFirstChild(v3);
else
    v4 = Object;
end;

if v4 then
    return require(Object.Value);
end;

local u5 = {};
u5.__index = u5;

if not v4 then
    script_ZonePlusReference.addToReplicatedStorage();
end;

u5.enum = enums;

function u5.new(p6) -- Line: 34
    -- upvalues: u5 (copy), enums (copy), script_Janitor (copy), HttpService (copy), u2 (copy), script_Signal (copy), u1 (copy)
    local u7 = {};
    setmetatable(u7, u5);
    local v8 = typeof(p6);

    if v8 ~= "table" and v8 ~= "Instance" then
        error("The zone container must be a model, folder, basepart or table!");
    end;

    u7.accuracy = enums.Accuracy.High;
    u7.autoUpdate = true;
    u7.respectUpdateQueue = true;
    local v9 = script_Janitor.new();
    u7.janitor = v9;
    u7._updateConnections = v9:add(script_Janitor.new(), "destroy");
    u7.container = p6;
    u7.zoneParts = {};
    u7.overlapParams = {};
    u7.region = nil;
    u7.volume = nil;
    u7.boundMin = nil;
    u7.boundMax = nil;
    u7.recommendedMaxParts = nil;
    u7.zoneId = HttpService:GenerateGUID();
    u7.activeTriggers = {};
    u7.occupants = {};
    u7.trackingTouchedTriggers = {};
    u7.enterDetection = enums.Detection.Centre;
    u7.exitDetection = enums.Detection.Centre;
    u7._currentEnterDetection = nil;
    u7._currentExitDetection = nil;
    u7.totalPartVolume = 0;
    u7.allZonePartsAreBlocks = true;
    u7.trackedItems = {};
    u7.settingsGroupName = nil;
    u7.worldModel = workspace;
    u7.onItemDetails = {};
    u7.itemsToUntrack = {};
    u2.updateDetection(u7);
    u7.updated = v9:add(script_Signal.new(), "destroy");
    local v10 = { "player", "part", "localPlayer", "item" };
    local v11 = { "entered", "exited" };

    for _, v in pairs(v10) do
        local u12 = v;
        local u13 = 0;
        local u14 = 0;

        for _, v2 in pairs(v11) do
            local v15 = v9:add(script_Signal.new(true), "destroy");
            local u16 = v2:sub(1, 1):upper() .. v2:sub(2);
            u7[u12 .. u16] = v15;
            v15.connectionsChanged:Connect(function(p17) -- Line: 105
                -- upvalues: u12 (copy), u1 (ref), u16 (copy), u13 (ref), u14 (ref), u2 (ref), u7 (copy)
                if u12 == "localPlayer" and (not u1 and p17 == 1) then
                    error(("Can only connect to \'localPlayer%s\' on the client!"):format(u16));
                end;

                u13 = u14;
                u14 = u14 + p17;

                if u13 == 0 and u14 > 0 then
                    u2._registerConnection(u7, u12, u16);

                    return;
                end;

                if u13 > 0 and u14 == 0 then
                    u2._deregisterConnection(u7, u12);
                end;
            end);
        end;
    end;

    u5.touchedConnectionActions = {};

    for _, v in pairs(v10) do
        local u18 = u7[("_%sTouchedZone"):format(v)];

        if u18 then
            u7.trackingTouchedTriggers[v] = {};

            u5.touchedConnectionActions[v] = function(p19) -- Line: 129
                -- upvalues: u18 (copy), u7 (copy)
                u18(u7, p19);
            end;
        end;
    end;

    u7:_update();
    u2._registerZone(u7);
    v9:add(function() -- Line: 140
        -- upvalues: u2 (ref), u7 (copy)
        u2._deregisterZone(u7);
    end, true);

    return u7;
end;

function u5.fromRegion(p20, p21) -- Line: 147
    -- upvalues: u5 (copy)
    local Model = Instance.new("Model");

    local function createCube(p22, p23) -- Line: 150
        -- upvalues: createCube (copy), Model (copy)
        if p23.X <= 2024 and (p23.Y <= 2024 and p23.Z <= 2024) then
            local Part = Instance.new("Part");
            Part.CFrame = p22;
            Part.Size = p23;
            Part.Anchored = true;
            Part.Parent = Model;

            return;
        end;

        local v24 = p23 * 0.25;
        local v25 = p23 * 0.5;
        createCube(p22 * CFrame.new(-v24.X, -v24.Y, -v24.Z), v25);
        createCube(p22 * CFrame.new(-v24.X, -v24.Y, v24.Z), v25);
        createCube(p22 * CFrame.new(-v24.X, v24.Y, -v24.Z), v25);
        createCube(p22 * CFrame.new(-v24.X, v24.Y, v24.Z), v25);
        createCube(p22 * CFrame.new(v24.X, -v24.Y, -v24.Z), v25);
        createCube(p22 * CFrame.new(v24.X, -v24.Y, v24.Z), v25);
        createCube(p22 * CFrame.new(v24.X, v24.Y, -v24.Z), v25);
        createCube(p22 * CFrame.new(v24.X, v24.Y, v24.Z), v25);
    end;

    createCube(p20, p21);
    local v26 = u5.new(Model);
    v26:relocate();

    return v26;
end;

function u5._calculateRegion(p27, p28, p29) -- Line: 179
    local v30 = {
        Min = {},
        Max = {}
    };

    for i, v in pairs(v30) do
        v.Values = {};

        function v.parseCheck(p31, p32) -- Line: 183
            -- upvalues: i (copy)
            if i == "Min" then
                return p31 <= p32;
            end;

            if i == "Max" then
                return p32 <= p31;
            end;
        end;

        function v.parse(p33, p34) -- Line: 190
            for i2, v2 in pairs(p34) do
                if p33.parseCheck(v2, p33.Values[i2] or v2) then
                    p33.Values[i2] = v2;
                end;
            end;
        end;
    end;

    for _, v in pairs(p28) do
        local v35 = v.Size * 0.5;
        local v36 = {
            v.CFrame * CFrame.new(-v35.X, -v35.Y, -v35.Z),
            v.CFrame * CFrame.new(-v35.X, -v35.Y, v35.Z),
            v.CFrame * CFrame.new(-v35.X, v35.Y, -v35.Z),
            v.CFrame * CFrame.new(-v35.X, v35.Y, v35.Z),
            v.CFrame * CFrame.new(v35.X, -v35.Y, -v35.Z),
            v.CFrame * CFrame.new(v35.X, -v35.Y, v35.Z),
            v.CFrame * CFrame.new(v35.X, v35.Y, -v35.Z),
            v.CFrame * CFrame.new(v35.X, v35.Y, v35.Z)
        };

        for _, v2 in pairs(v36) do
            local Components, v37, v38 = v2:GetComponents();
            local v39 = { Components, v37, v38 };
            v30.Min:parse(v39);
            v30.Max:parse(v39);
        end;
    end;

    local function roundToFour(p40) -- Line: 222
        return math.floor((p40 + 2) / 4) * 4;
    end;

    local v41 = {};
    local v42 = {};

    for i, v in pairs(v30) do
        local v43 = i;

        for _, v2 in pairs(v.Values) do
            local v44;

            if p29 then
                v44 = v2;
            else
                v44 = math.floor((v2 + (v43 == "Min" and -2 or 2) + 2) / 4) * 4;
            end;

            table.insert(v43 == "Min" and v42 and v42 or v41, v44);
        end;
    end;

    local Vector3_new_ret = Vector3.new(unpack(v42));
    local Vector3_new_ret2 = Vector3.new(unpack(v41));

    return Region3.new(Vector3_new_ret, Vector3_new_ret2), Vector3_new_ret, Vector3_new_ret2;
end;

function u5._displayBounds(p45) -- Line: 245
    if not p45.displayBoundParts then
        p45.displayBoundParts = true;

        for i, v in pairs({
            BoundMin = p45.boundMin,
            BoundMax = p45.boundMax
        }) do
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.Transparency = 0.5;
            Part.Size = Vector3.new(1, 1, 1);
            Part.Color = Color3.fromRGB(255, 0, 0);
            Part.CFrame = CFrame.new(v);
            Part.Name = i;
            Part.Parent = workspace;
            p45.janitor:add(Part, "Destroy");
        end;
    end;
end;

function u5._update(u46) -- Line: 264
    -- upvalues: RunService (copy)
    local container = u46.container;
    local v47 = {};
    local u48 = 0;
    u46._updateConnections:clean();
    local v49 = typeof(container);
    local v50 = {};

    if v49 == "table" then
        for _, v in pairs(container) do
            if v:IsA("BasePart") then
                table.insert(v47, v);
            end;
        end;
    elseif v49 == "Instance" then
        if container:IsA("BasePart") then
            table.insert(v47, container);
        else
            table.insert(v50, container);

            for _, descendant in pairs(container:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    table.insert(v47, descendant);
                else
                    table.insert(v50, descendant);
                end;
            end;
        end;
    end;

    u46.zoneParts = v47;
    u46.overlapParams = {};
    local v51 = true;

    for _, v in pairs(v47) do
        local _, result = pcall(function() -- Line: 298
            -- upvalues: v (copy)
            return v.Shape.Name;
        end);

        if result ~= "Block" then
            v51 = false;
        end;
    end;

    u46.allZonePartsAreBlocks = v51;
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    OverlapParams_new_ret.MaxParts = #v47;
    OverlapParams_new_ret.FilterDescendantsInstances = v47;
    u46.overlapParams.zonePartsWhitelist = OverlapParams_new_ret;
    local OverlapParams_new_ret2 = OverlapParams.new();
    OverlapParams_new_ret2.FilterType = Enum.RaycastFilterType.Exclude;
    OverlapParams_new_ret2.FilterDescendantsInstances = v47;
    u46.overlapParams.zonePartsIgnorelist = OverlapParams_new_ret2;

    local function update() -- Line: 318
        -- upvalues: u46 (copy), u48 (ref), RunService (ref)
        if u46.autoUpdate then
            local os_clock_ret = os.clock();

            if u46.respectUpdateQueue then
                u48 = u48 + 1;
                os_clock_ret = os_clock_ret + 0.1;
            end;

            local u52 = nil;
            u52 = RunService.Heartbeat:Connect(function() -- Line: 326
                -- upvalues: os_clock_ret (ref), u52 (ref), u46 (ref), u48 (ref)
                if os_clock_ret <= os.clock() then
                    u52:Disconnect();

                    if u46.respectUpdateQueue then
                        u48 = u48 - 1;
                    end;

                    if u48 == 0 and u46.zoneId then
                        u46:_update();
                    end;
                end;
            end);
        end;
    end;

    local function verifyDefaultCollision(p53) -- Line: 340
        if p53.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.");
        end;
    end;

    local v54 = { "Size", "Position" };

    for _, v in pairs(v47) do
        local u55 = v;

        for _, v2 in pairs(v54) do
            u46._updateConnections:add(u55:GetPropertyChangedSignal(v2):Connect(update), "Disconnect");
        end;

        if u55.CollisionGroupId ~= 0 then
            error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.");
        end;

        u46._updateConnections:add(u55:GetPropertyChangedSignal("CollisionGroupId"):Connect(function() -- Line: 350
            -- upvalues: u55 (copy)
            if u55.CollisionGroupId ~= 0 then
                error("Zone parts must belong to the \'Default\' (0) CollisionGroup! Consider using zone:relocate() if you wish to move zones outside of workspace to prevent them interacting with other parts.");
            end;
        end), "Disconnect");
    end;

    local v56 = { "ChildAdded", "ChildRemoved" };

    for _, _ in pairs(v50) do
        for _, v in pairs(v56) do
            u46._updateConnections:add(u46.container[v]:Connect(function(p57) -- Line: 357
                -- upvalues: u46 (copy), u48 (ref), RunService (ref)
                if p57:IsA("BasePart") and u46.autoUpdate then
                    local os_clock_ret = os.clock();

                    if u46.respectUpdateQueue then
                        u48 = u48 + 1;
                        os_clock_ret = os_clock_ret + 0.1;
                    end;

                    local u58 = nil;
                    u58 = RunService.Heartbeat:Connect(function() -- Line: 326
                        -- upvalues: os_clock_ret (ref), u58 (ref), u46 (ref), u48 (ref)
                        if os_clock_ret <= os.clock() then
                            u58:Disconnect();

                            if u46.respectUpdateQueue then
                                u48 = u48 - 1;
                            end;

                            if u48 == 0 and u46.zoneId then
                                u46:_update();
                            end;
                        end;
                    end);
                end;
            end), "Disconnect");
        end;
    end;

    local v59, v60, v61 = u46:_calculateRegion(v47);
    local v62, _, _ = u46:_calculateRegion(v47, true);
    u46.region = v59;
    u46.exactRegion = v62;
    u46.boundMin = v60;
    u46.boundMax = v61;
    local Size = v59.Size;
    u46.volume = Size.X * Size.Y * Size.Z;
    u46:_updateTouchedConnections();
    u46.updated:Fire();
end;

function u5._updateOccupants(p63, p64, p65) -- Line: 393
    local v66 = p63.occupants[p64];

    if not v66 then
        v66 = {};
        p63.occupants[p64] = v66;
    end;

    local v67 = {};

    for i, v in pairs(v66) do
        local v68 = p65[i];

        if v68 == nil or v68 ~= v then
            v66[i] = nil;

            if not v67.exited then
                v67.exited = {};
            end;

            table.insert(v67.exited, i);
        end;
    end;

    for i, _ in pairs(p65) do
        if v66[i] == nil then
            v66[i] = i:IsA("Player") and (i.Character or true) or true;

            if not v67.entered then
                v67.entered = {};
            end;

            table.insert(v67.entered, i);
        end;
    end;

    return v67;
end;

function u5._formTouchedConnection(p69, p70) -- Line: 423
    -- upvalues: script_Janitor (copy)
    local v71 = "_touchedJanitor" .. p70;
    local v72 = p69[v71];

    if v72 then
        v72:clean();
    else
        p69[v71] = p69.janitor:add(script_Janitor.new(), "destroy");
    end;

    p69:_updateTouchedConnection(p70);
end;

function u5._updateTouchedConnection(p73, p74) -- Line: 435
    local v75 = p73["_touchedJanitor" .. p74];

    if not v75 then
        return;
    end;

    for _, v in pairs(p73.zoneParts) do
        v75:add(v.Touched:Connect(p73.touchedConnectionActions[p74], p73), "Disconnect");
    end;
end;

function u5._updateTouchedConnections(p76) -- Line: 444
    for i, _ in pairs(p76.touchedConnectionActions) do
        local v77 = p76["_touchedJanitor" .. i];

        if v77 then
            v77:cleanup();
            p76:_updateTouchedConnection(i);
        end;
    end;
end;

function u5._disconnectTouchedConnection(p78, p79) -- Line: 455
    local v80 = "_touchedJanitor" .. p79;
    local v81 = p78[v80];

    if v81 then
        v81:cleanup();
        p78[v80] = nil;
    end;
end;

local function round(p82, p83) -- Line: 464
    return math.round(p82 * 10 ^ p83) * 10 ^ (-p83);
end;

function u5._partTouchedZone(u84, u85) -- Line: 467
    -- upvalues: script_Janitor (copy), Heartbeat (copy), enums (copy)
    local part = u84.trackingTouchedTriggers.part;

    if part[u85] then
        return;
    end;

    local u86 = 0;
    local u87 = false;
    local Position = u85.Position;
    local os_clock_ret = os.clock();
    local u88 = u84.janitor:add(script_Janitor.new(), "destroy");
    part[u85] = u88;

    if not ({
        Seat = true,
        VehicleSeat = true
    })[u85.ClassName] and ({
        HumanoidRootPart = true
    })[u85.Name] then
        u85.CanTouch = false;
    end;

    local u89 = math.round(u85.Size.X * u85.Size.Y * u85.Size.Z * 100000) * 0.00001;
    u84.totalPartVolume = u84.totalPartVolume + u89;
    u88:add(Heartbeat:Connect(function() -- Line: 485
        -- upvalues: u86 (ref), enums (ref), u84 (copy), u85 (copy), u87 (ref), Position (ref), os_clock_ret (ref), u88 (copy)
        local os_clock_ret2 = os.clock();

        if u86 <= os_clock_ret2 then
            local Property = enums.Accuracy.getProperty(u84.accuracy);
            u86 = os_clock_ret2 + Property;
            local v90 = u84:findPoint(u85.CFrame) or u84:findPart(u85);

            if u87 then
                if not v90 then
                    u87 = false;
                    Position = u85.Position;
                    os_clock_ret = os.clock();
                    u84.partExited:Fire(u85);
                end;
            else
                if v90 then
                    u87 = true;
                    u84.partEntered:Fire(u85);

                    return;
                end;

                if (u85.Position - Position).Magnitude > 1.5 and Property <= os_clock_ret2 - os_clock_ret then
                    u88:cleanup();
                end;
            end;
        end;
    end), "Disconnect");
    u88:add(function() -- Line: 516
        -- upvalues: part (copy), u85 (copy), u84 (copy), u89 (copy)
        part[u85] = nil;
        u85.CanTouch = true;
        u84.totalPartVolume = math.round((u84.totalPartVolume - u89) * 100000) * 0.00001;
    end, true);
end;

local u94 = {
    Ball = function(p91) -- Line: 524
        return "GetPartBoundsInRadius", { p91.Position, p91.Size.X };
    end,

    Block = function(p92) -- Line: 527
        return "GetPartBoundsInBox", { p92.CFrame, p92.Size };
    end,

    Other = function(p93) -- Line: 530
        return "GetPartsInPart", { p93 };
    end
};

function u5._getRegionConstructor(p95, u96, p97) -- Line: 534
    -- upvalues: u94 (copy)
    local success, result = pcall(function() -- Line: 535
        -- upvalues: u96 (copy)
        return u96.Shape.Name;
    end);
    local v98 = nil;
    local v99 = nil;

    if success and p95.allZonePartsAreBlocks then
        local v100 = u94[result];

        if v100 then
            v98, v99 = v100(u96);
        end;
    end;

    if not v98 then
        v99 = { u96 };
        v98 = "GetPartsInPart";
    end;

    if p97 then
        table.insert(v99, p97);
    end;

    return v98, v99;
end;

function u5.findLocalPlayer(p101) -- Line: 555
    -- upvalues: u1 (copy)
    if not u1 then
        error("Can only call \'findLocalPlayer\' on the client!");
    end;

    return p101:findPlayer(u1);
end;

function u5._find(p102, p103, p104) -- Line: 562
    -- upvalues: u2 (copy)
    u2.updateDetection(p102);
    local TouchingZones = u2.getTouchingZones(p104, false, p102._currentEnterDetection, u2.trackers[p103]);

    for _, v in pairs(TouchingZones) do
        if v == p102 then
            return true;
        end;
    end;

    return false;
end;

function u5.findPlayer(p105, p106) -- Line: 574
    local Character = p106.Character;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    if Character then
        return p105:_find("player", p106.Character);
    end;

    return false;
end;

function u5.findItem(p107, p108) -- Line: 583
    return p107:_find("item", p108);
end;

function u5.findPart(p109, p110) -- Line: 587
    local v111, v112 = p109:_getRegionConstructor(p110, p109.overlapParams.zonePartsWhitelist);
    local v113 = p109.worldModel[v111](p109.worldModel, unpack(v112));

    if #v113 > 0 then
        return true, v113;
    end;

    return false;
end;

function u5.getCheckerPart(p114) -- Line: 597
    -- upvalues: u2 (copy)
    local checkerPart = p114.checkerPart;

    if not checkerPart then
        checkerPart = p114.janitor:add(Instance.new("Part"), "Destroy");
        checkerPart.Size = Vector3.new(0.1, 0.1, 0.1);
        checkerPart.Name = "ZonePlusCheckerPart";
        checkerPart.Anchored = true;
        checkerPart.Transparency = 1;
        checkerPart.CanCollide = false;
        p114.checkerPart = checkerPart;
    end;

    local worldModel = p114.worldModel;

    if worldModel == workspace then
        worldModel = u2.getWorkspaceContainer();
    end;

    if checkerPart.Parent ~= worldModel then
        checkerPart.Parent = worldModel;
    end;

    return checkerPart;
end;

function u5.findPoint(p115, p116) -- Line: 618
    if typeof(p116) == "Vector3" then
        p116 = CFrame.new(p116);
    end;

    local CheckerPart = p115:getCheckerPart();
    CheckerPart.CFrame = p116;
    local v117, v118 = p115:_getRegionConstructor(CheckerPart, p115.overlapParams.zonePartsWhitelist);
    local v119 = p115.worldModel[v117](p115.worldModel, unpack(v118));

    if #v119 > 0 then
        return true, v119;
    end;

    return false;
end;

function u5._getAll(p120, p121) -- Line: 635
    -- upvalues: u2 (copy)
    u2.updateDetection(p120);
    local v122 = {};
    local v123 = u2._getZonesAndItems(p121, {
        self = true
    }, p120.volume, false, p120._currentEnterDetection)[p120];

    if v123 then
        for i, _ in pairs(v123) do
            table.insert(v122, i);
        end;
    end;

    return v122;
end;

function u5.getPlayers(p124) -- Line: 648
    return p124:_getAll("player");
end;

function u5.getItems(p125) -- Line: 652
    return p125:_getAll("item");
end;

function u5.getParts(p126) -- Line: 656
    local v127 = {};

    if p126.activeTriggers.part then
        for i, _ in pairs(p126.trackingTouchedTriggers.part) do
            table.insert(v127, i);
        end;

        return v127;
    end;

    local PartBoundsInBox = p126.worldModel:GetPartBoundsInBox(p126.region.CFrame, p126.region.Size, p126.overlapParams.zonePartsIgnorelist);

    for _, v in pairs(PartBoundsInBox) do
        if p126:findPart(v) then
            table.insert(v127, v);
        end;
    end;

    return v127;
end;

function u5.getRandomPoint(p128) -- Line: 677
    local exactRegion = p128.exactRegion;
    local Size = exactRegion.Size;
    local CFrame2 = exactRegion.CFrame;
    local Random_new_ret = Random.new();
    local v129 = nil;
    local v130, v131;

    repeat
        v130 = CFrame2 * CFrame.new(Random_new_ret:NextNumber(-Size.X / 2, Size.X / 2), Random_new_ret:NextNumber(-Size.Y / 2, Size.Y / 2), Random_new_ret:NextNumber(-Size.Z / 2, Size.Z / 2));
        local v132;
        v132, v131 = p128:findPoint(v130);
        v129 = v132 and true or v129;
    until v129;

    return v130.Position, v131;
end;

function u5.setAccuracy(p133, p134) -- Line: 696
    -- upvalues: enums (copy)
    local v135 = tonumber(p134);

    if v135 then
        if not enums.Accuracy.getName(v135) then
            error(("%s is an invalid enumId!"):format(v135));
        end;
    else
        v135 = enums.Accuracy[p134];

        if not v135 then
            error(("\'%s\' is an invalid enumName!"):format(p134));
        end;
    end;

    p133.accuracy = v135;
end;

function u5.setDetection(p136, p137) -- Line: 712
    -- upvalues: enums (copy)
    local v138 = tonumber(p137);

    if v138 then
        if not enums.Detection.getName(v138) then
            error(("%s is an invalid enumId!"):format(v138));
        end;
    else
        v138 = enums.Detection[p137];

        if not v138 then
            error(("\'%s\' is an invalid enumName!"):format(p137));
        end;
    end;

    p136.enterDetection = v138;
    p136.exitDetection = v138;
end;

function u5.trackItem(u139, u140) -- Line: 729
    -- upvalues: script_Janitor (copy), Tracker (copy)
    local v141 = u140:IsA("BasePart");
    local v142;

    if v141 then
        v142 = false;
    else
        v142 = u140:FindFirstChildOfClass("Humanoid") and u140:FindFirstChild("HumanoidRootPart");
    end;

    assert(v141 or v142, "Only BaseParts or Characters/NPCs can be tracked!");

    if u139.trackedItems[u140] then
        return;
    end;

    if u139.itemsToUntrack[u140] then
        u139.itemsToUntrack[u140] = nil;
    end;

    local v143 = u139.janitor:add(script_Janitor.new(), "destroy");
    local v144 = {
        janitor = v143,
        item = u140,
        isBasePart = v141,
        isCharacter = v142
    };
    u139.trackedItems[u140] = v144;
    v143:add(u140.AncestryChanged:Connect(function() -- Line: 754
        -- upvalues: u140 (copy), u139 (copy)
        if not u140:IsDescendantOf(game) then
            u139:untrackItem(u140);
        end;
    end), "Disconnect");
    require(Tracker).itemAdded:Fire(v144);
end;

function u5.untrackItem(p145, p146) -- Line: 764
    -- upvalues: Tracker (copy)
    local v147 = p145.trackedItems[p146];

    if v147 then
        v147.janitor:destroy();
    end;

    p145.trackedItems[p146] = nil;
    require(Tracker).itemRemoved:Fire(v147);
end;

function u5.bindToGroup(p148, p149) -- Line: 775
    -- upvalues: u2 (copy)
    p148:unbindFromGroup();
    (u2.getGroup(p149) or u2.setGroup(p149))._memberZones[p148.zoneId] = p148;
    p148.settingsGroupName = p149;
end;

function u5.unbindFromGroup(p150) -- Line: 782
    -- upvalues: u2 (copy)
    if p150.settingsGroupName then
        local Group = u2.getGroup(p150.settingsGroupName);

        if Group then
            Group._memberZones[p150.zoneId] = nil;
        end;

        p150.settingsGroupName = nil;
    end;
end;

function u5.relocate(p151) -- Line: 792
    -- upvalues: CollectiveWorldModel (copy)
    if p151.hasRelocated then
        return;
    end;

    local v152 = require(CollectiveWorldModel).setupWorldModel(p151);
    p151.worldModel = v152;
    p151.hasRelocated = true;
    local container = p151.container;

    if typeof(container) == "table" then
        container = Instance.new("Folder");

        for _, v in pairs(p151.zoneParts) do
            v.Parent = container;
        end;
    end;

    p151.relocationContainer = p151.janitor:add(container, "Destroy", "RelocationContainer");
    container.Parent = v152;
end;

function u5._onItemCallback(u153, p154, p155, u156, u157) -- Line: 813
    local v158 = u153.onItemDetails[u156];

    if not v158 then
        v158 = {};
        u153.onItemDetails[u156] = v158;
    end;

    if #v158 == 0 then
        u153.itemsToUntrack[u156] = true;
    end;

    table.insert(v158, u156);
    u153:trackItem(u156);

    local function triggerCallback() -- Line: 825
        -- upvalues: u157 (copy), u153 (copy), u156 (copy)
        u157();

        if u153.itemsToUntrack[u156] then
            u153.itemsToUntrack[u156] = nil;
            u153:untrackItem(u156);
        end;
    end;

    if u153:findItem(u156) == p155 then
        u157();

        if u153.itemsToUntrack[u156] then
            u153.itemsToUntrack[u156] = nil;
            u153:untrackItem(u156);
        end;
    else
        local u159 = nil;
        u159 = u153[p154]:Connect(function(p160) -- Line: 838
            -- upvalues: u159 (ref), u156 (copy), u157 (copy), u153 (copy)
            if u159 and p160 == u156 then
                u159:Disconnect();
                u159 = nil;
                u157();

                if u153.itemsToUntrack[u156] then
                    u153.itemsToUntrack[u156] = nil;
                    u153:untrackItem(u156);
                end;
            end;
        end);
    end;
end;

function u5.onItemEnter(p161, ...) -- Line: 860
    p161:_onItemCallback("itemEntered", true, ...);
end;

function u5.onItemExit(p162, ...) -- Line: 864
    p162:_onItemCallback("itemExited", false, ...);
end;

function u5.destroy(p163) -- Line: 868
    p163:unbindFromGroup();
    p163.janitor:destroy();
end;

u5.Destroy = u5.destroy;

return u5;